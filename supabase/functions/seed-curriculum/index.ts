// Seeds quiz questions into empty lessons using the Lovable AI gateway,
// grounded in each lesson's title + language. Run in batches from the admin panel.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.0";
import { corsHeaders } from "npm:@supabase/supabase-js@2/cors";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SERVICE_ROLE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const LOVABLE_API_KEY = Deno.env.get("LOVABLE_API_KEY")!;
const ADMIN_KEY = Deno.env.get("ADMIN_KEY")!;

const MODEL = "google/gemini-2.5-flash";

type LessonRow = {
  id: string;
  title: string;
  description: string | null;
  unit_id: string;
  unit_title: string;
  language_name: string;
  language_slug: string;
};

async function generateQuestions(lesson: LessonRow) {
  const prompt = `You are creating 3 multiple-choice quiz questions for a coding lesson.

Language: ${lesson.language_name}
Unit: ${lesson.unit_title}
Lesson: ${lesson.title}
${lesson.description ? `Lesson goal: ${lesson.description}` : ""}

Rules:
- Each question must test a real concept relevant to the lesson title above, in ${lesson.language_name}.
- Exactly 4 options, exactly 1 correct.
- Include a short hint (≤120 chars).
- Questions should rise in difficulty: q1 recall, q2 applied, q3 trickier.
- Return STRICT JSON with shape: { "questions": [ { "instruction": string, "code": string|null, "options": [string,string,string,string], "answer": string, "hint": string } ] }
- "answer" MUST be exactly one of the option strings.
- "code" is an optional short snippet shown above the question, or null.`;

  const res = await fetch("https://ai.gateway.lovable.dev/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${LOVABLE_API_KEY}`,
    },
    body: JSON.stringify({
      model: MODEL,
      messages: [
        { role: "system", content: "You output only valid JSON. No prose." },
        { role: "user", content: prompt },
      ],
      response_format: { type: "json_object" },
    }),
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`AI ${res.status}: ${text.slice(0, 200)}`);
  }

  const data = await res.json();
  const content = data.choices?.[0]?.message?.content ?? "{}";
  const parsed = JSON.parse(content);
  const qs = Array.isArray(parsed.questions) ? parsed.questions : [];
  if (qs.length === 0) throw new Error("No questions returned");
  return qs.slice(0, 3);
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const body = await req.json().catch(() => ({}));
    const adminKey = req.headers.get("x-admin-key") ?? body.adminKey;
    if (adminKey !== ADMIN_KEY) {
      return new Response(JSON.stringify({ error: "unauthorized" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const batchSize = Math.min(Math.max(Number(body.batchSize) || 15, 1), 40);
    const languageSlug: string | undefined = body.languageSlug;

    const supabase = createClient(SUPABASE_URL, SERVICE_ROLE);

    // Find lessons with zero questions
    let q = supabase
      .from("lessons")
      .select(
        "id, title, description, unit_id, units!inner(id, title, language_id, languages!inner(id, name, slug))"
      )
      .order("created_at", { ascending: true })
      .limit(batchSize * 4); // overfetch, filter empties below

    if (languageSlug) {
      q = q.eq("units.languages.slug", languageSlug);
    }
    const { data: lessons, error } = await q;
    if (error) throw error;

    const { data: existing } = await supabase
      .from("questions")
      .select("lesson_id")
      .in("lesson_id", (lessons ?? []).map((l: any) => l.id));

    const filled = new Set((existing ?? []).map((r: any) => r.lesson_id));
    const empty = (lessons ?? []).filter((l: any) => !filled.has(l.id)).slice(0, batchSize);

    const results: { lessonId: string; ok: boolean; error?: string; inserted?: number }[] = [];

    for (const l of empty as any[]) {
      const lesson: LessonRow = {
        id: l.id,
        title: l.title,
        description: l.description,
        unit_id: l.unit_id,
        unit_title: l.units.title,
        language_name: l.units.languages.name,
        language_slug: l.units.languages.slug,
      };

      try {
        const qs = await generateQuestions(lesson);
        const rows = qs
          .filter(
            (qq: any) =>
              qq.instruction &&
              Array.isArray(qq.options) &&
              qq.options.length === 4 &&
              qq.answer &&
              qq.options.includes(qq.answer)
          )
          .map((qq: any, idx: number) => ({
            lesson_id: lesson.id,
            type: "multiple_choice",
            instruction: String(qq.instruction).slice(0, 1000),
            code: qq.code ? String(qq.code).slice(0, 2000) : null,
            options: qq.options,
            answer: qq.answer,
            hint: qq.hint ? String(qq.hint).slice(0, 240) : null,
            order_index: idx,
            xp_reward: 10,
          }));

        if (rows.length === 0) {
          results.push({ lessonId: lesson.id, ok: false, error: "invalid AI output" });
          continue;
        }

        const { error: insErr } = await supabase.from("questions").insert(rows);
        if (insErr) throw insErr;
        results.push({ lessonId: lesson.id, ok: true, inserted: rows.length });
      } catch (e) {
        results.push({
          lessonId: lesson.id,
          ok: false,
          error: e instanceof Error ? e.message : String(e),
        });
      }
    }

    // Remaining count
    const { count: remaining } = await supabase
      .from("lessons")
      .select("id", { count: "exact", head: true });

    return new Response(
      JSON.stringify({
        processed: results.length,
        succeeded: results.filter((r) => r.ok).length,
        failed: results.filter((r) => !r.ok).length,
        totalLessons: remaining,
        results,
      }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  } catch (e) {
    return new Response(
      JSON.stringify({ error: e instanceof Error ? e.message : String(e) }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
