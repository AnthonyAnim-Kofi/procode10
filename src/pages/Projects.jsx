/**
 * Projects – Learner-facing page listing hands-on projects for the active language.
 * Users can view instructions, watch embedded video, open resources, and mark done for XP.
 */
import { useMemo, useState } from "react";
import { useSearchParams } from "react-router-dom";
import { Loader2, Clock, Zap, CheckCircle2, ExternalLink, PlayCircle, ArrowLeft } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { LanguageSelectItem } from "@/components/LanguageSelectItem";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useLanguages } from "@/hooks/useLanguages";
import { useLanguageProjects, useMyProjectCompletions, useUpsertProjectCompletion } from "@/hooks/useProjects";
import { useToast } from "@/hooks/use-toast";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

const diffColor = {
  beginner: "bg-emerald-100 text-emerald-700 dark:bg-emerald-950 dark:text-emerald-300",
  intermediate: "bg-amber-100 text-amber-700 dark:bg-amber-950 dark:text-amber-300",
  advanced: "bg-rose-100 text-rose-700 dark:bg-rose-950 dark:text-rose-300",
};

function isYouTube(url) {
  return /(?:youtube\.com|youtu\.be)/.test(url || "");
}
function youTubeEmbed(url) {
  try {
    const u = new URL(url);
    if (u.hostname.includes("youtu.be")) return `https://www.youtube.com/embed${u.pathname}`;
    const v = u.searchParams.get("v");
    if (v) return `https://www.youtube.com/embed/${v}`;
  } catch {}
  return url;
}

export default function Projects() {
  const [searchParams, setSearchParams] = useSearchParams();
  const languageId = searchParams.get("language") || "";
  const { data: languages = [] } = useLanguages();
  const { data: projects = [], isLoading } = useLanguageProjects(languageId || undefined);
  const { data: completions = [] } = useMyProjectCompletions(languageId || undefined);
  const upsert = useUpsertProjectCompletion();
  const { toast } = useToast();
  const { user } = useAuth();
  const [openProject, setOpenProject] = useState(null);

  const completionMap = useMemo(() => {
    const m = new Map();
    completions.forEach((c) => m.set(c.project_id, c));
    return m;
  }, [completions]);

  const currentLanguage = languages.find((l) => l.id === languageId);

  const setLanguage = (id) => {
    setSearchParams(id ? { language: id } : {});
  };

  const markComplete = async (project) => {
    const already = completionMap.get(project.id)?.status === "completed";
    if (already) {
      toast({ title: "Already completed" });
      return;
    }
    try {
      await upsert.mutateAsync({ projectId: project.id, status: "completed" });
      // Award XP to profile
      if (user) {
        const { data: profile } = await supabase.from("profiles").select("xp, weekly_xp, daily_xp").eq("user_id", user.id).maybeSingle();
        if (profile) {
          await supabase.from("profiles").update({
            xp: (profile.xp || 0) + project.xp_reward,
            weekly_xp: (profile.weekly_xp || 0) + project.xp_reward,
            daily_xp: (profile.daily_xp || 0) + project.xp_reward,
          }).eq("user_id", user.id);
        }
      }
      toast({ title: `🎉 Project completed! +${project.xp_reward} XP` });
      setOpenProject(null);
    } catch (e) {
      toast({ title: `Could not save: ${e.message}`, variant: "destructive" });
    }
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-extrabold">Projects</h1>
        <p className="text-muted-foreground mt-1">Apply what you've learned with hands-on builds.</p>
      </div>

      <div className="flex flex-wrap items-center gap-3">
        <Select value={languageId} onValueChange={setLanguage}>
          <SelectTrigger className="w-[220px]">
            <SelectValue placeholder="Pick a language">
              {currentLanguage ? (
                <LanguageSelectItem slug={currentLanguage.slug} icon={currentLanguage.icon} name={currentLanguage.name} />
              ) : null}
            </SelectValue>
          </SelectTrigger>
          <SelectContent>
            {languages.map((l) => (
              <SelectItem key={l.id} value={l.id}>
                <LanguageSelectItem slug={l.slug} icon={l.icon} name={l.name} />
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      {!languageId ? (
        <div className="border border-dashed rounded-xl p-12 text-center text-muted-foreground">
          Select a language to see its projects.
        </div>
      ) : isLoading ? (
        <div className="flex justify-center py-12"><Loader2 className="w-8 h-8 animate-spin text-primary" /></div>
      ) : projects.length === 0 ? (
        <div className="border border-dashed rounded-xl p-12 text-center text-muted-foreground">
          No projects have been added for this language yet. Check back soon!
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {projects.map((p) => {
            const done = completionMap.get(p.id)?.status === "completed";
            return (
              <button
                key={p.id}
                onClick={() => setOpenProject(p)}
                className="text-left group bg-card border-2 border-border rounded-2xl overflow-hidden hover:border-primary/60 hover:shadow-lg transition-all"
              >
                <div className="relative aspect-video bg-muted">
                  {p.image_url ? (
                    <img src={p.image_url} alt={p.title} className="w-full h-full object-cover" />
                  ) : (
                    <div className="w-full h-full flex items-center justify-center text-muted-foreground">
                      <PlayCircle className="w-12 h-12" />
                    </div>
                  )}
                  {done && (
                    <div className="absolute top-2 right-2 bg-emerald-500 text-white rounded-full p-1.5 shadow">
                      <CheckCircle2 className="w-4 h-4" />
                    </div>
                  )}
                </div>
                <div className="p-4 space-y-2">
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className={`text-xs px-2 py-0.5 rounded-full capitalize ${diffColor[p.difficulty] || diffColor.beginner}`}>{p.difficulty}</span>
                    <span className="text-xs text-muted-foreground flex items-center gap-1"><Clock className="w-3 h-3" />{p.estimated_minutes}m</span>
                    <span className="text-xs text-amber-500 flex items-center gap-1 font-semibold"><Zap className="w-3 h-3" />+{p.xp_reward}</span>
                  </div>
                  <h3 className="font-bold text-lg leading-snug group-hover:text-primary">{p.title}</h3>
                  <p className="text-sm text-muted-foreground line-clamp-2">{p.description}</p>
                </div>
              </button>
            );
          })}
        </div>
      )}

      <Dialog open={!!openProject} onOpenChange={(o) => !o && setOpenProject(null)}>
        <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
          {openProject && (
            <>
              <DialogHeader>
                <DialogTitle className="text-2xl">{openProject.title}</DialogTitle>
              </DialogHeader>
              <div className="space-y-4">
                {openProject.video_url && (
                  <div className="aspect-video rounded-lg overflow-hidden bg-black">
                    {isYouTube(openProject.video_url) ? (
                      <iframe
                        src={youTubeEmbed(openProject.video_url)}
                        className="w-full h-full"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowFullScreen
                      />
                    ) : (
                      <video src={openProject.video_url} controls className="w-full h-full" />
                    )}
                  </div>
                )}
                {!openProject.video_url && openProject.image_url && (
                  <img src={openProject.image_url} alt={openProject.title} className="w-full rounded-lg" />
                )}

                <div className="flex flex-wrap items-center gap-2">
                  <span className={`text-xs px-2 py-1 rounded-full capitalize ${diffColor[openProject.difficulty] || diffColor.beginner}`}>{openProject.difficulty}</span>
                  <span className="text-xs text-muted-foreground flex items-center gap-1"><Clock className="w-3 h-3" />{openProject.estimated_minutes} min</span>
                  <span className="text-xs text-amber-500 font-bold flex items-center gap-1"><Zap className="w-3 h-3" />+{openProject.xp_reward} XP</span>
                </div>

                {openProject.description && <p className="text-muted-foreground">{openProject.description}</p>}

                {openProject.instructions && (
                  <div>
                    <h4 className="font-bold mb-2">Instructions</h4>
                    <div className="prose prose-sm dark:prose-invert max-w-none whitespace-pre-wrap bg-muted/50 rounded-lg p-4 text-sm">
                      {openProject.instructions}
                    </div>
                  </div>
                )}

                {openProject.starter_code && (
                  <div>
                    <h4 className="font-bold mb-2">Starter Code</h4>
                    <pre className="bg-slate-950 text-slate-100 rounded-lg p-4 text-xs overflow-x-auto"><code>{openProject.starter_code}</code></pre>
                  </div>
                )}

                <div className="flex flex-wrap gap-2 pt-2">
                  {openProject.resource_url && (
                    <Button asChild variant="outline">
                      <a href={openProject.resource_url} target="_blank" rel="noreferrer">
                        <ExternalLink className="w-4 h-4 mr-2" /> Open Resource
                      </a>
                    </Button>
                  )}
                  <Button
                    onClick={() => markComplete(openProject)}
                    disabled={upsert.isPending || completionMap.get(openProject.id)?.status === "completed"}
                    className="ml-auto"
                  >
                    {upsert.isPending ? <Loader2 className="w-4 h-4 animate-spin mr-2" /> : <CheckCircle2 className="w-4 h-4 mr-2" />}
                    {completionMap.get(openProject.id)?.status === "completed" ? "Completed" : "Mark Complete"}
                  </Button>
                </div>
              </div>
            </>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
