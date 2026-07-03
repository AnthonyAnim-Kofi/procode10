/**
 * useProjects – Hooks for language projects (admin CRUD + learner reads/completions)
 * and helper for uploading media to the private `project-media` bucket.
 */
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

/** Fetch projects for a given language (or all if no id). */
export function useLanguageProjects(languageId, { includeInactive = false } = {}) {
  return useQuery({
    queryKey: ["language-projects", languageId, includeInactive],
    queryFn: async () => {
      let q = supabase.from("language_projects").select("*").order("order_index", { ascending: true });
      if (languageId) q = q.eq("language_id", languageId);
      if (!includeInactive) q = q.eq("is_active", true);
      const { data, error } = await q;
      if (error) throw error;
      return data;
    },
    enabled: languageId !== undefined,
  });
}

/** Admin: create project */
export function useCreateProject() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: async (payload) => {
      const { data, error } = await supabase.from("language_projects").insert(payload).select().single();
      if (error) throw error;
      return data;
    },
    onSuccess: () => qc.invalidateQueries({ queryKey: ["language-projects"] }),
  });
}

/** Admin: update project */
export function useUpdateProject() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, ...updates }) => {
      const { data, error } = await supabase
        .from("language_projects")
        .update(updates)
        .eq("id", id)
        .select()
        .single();
      if (error) throw error;
      return data;
    },
    onSuccess: () => qc.invalidateQueries({ queryKey: ["language-projects"] }),
  });
}

/** Admin: delete project */
export function useDeleteProject() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: async (id) => {
      const { error } = await supabase.from("language_projects").delete().eq("id", id);
      if (error) throw error;
      return id;
    },
    onSuccess: () => qc.invalidateQueries({ queryKey: ["language-projects"] }),
  });
}

/**
 * Upload a file to the private `project-media` bucket and return a long-lived signed URL.
 * Signed URL lasts ~10 years so it can be stored in a project row.
 */
export async function uploadProjectMedia(file, folder = "misc") {
  if (!file) throw new Error("No file provided");
  const ext = file.name.split(".").pop();
  const path = `${folder}/${crypto.randomUUID()}.${ext}`;
  const { error: upErr } = await supabase.storage
    .from("project-media")
    .upload(path, file, { cacheControl: "3600", upsert: false, contentType: file.type });
  if (upErr) throw upErr;
  const { data, error } = await supabase.storage
    .from("project-media")
    .createSignedUrl(path, 60 * 60 * 24 * 365 * 10); // 10 years
  if (error) throw error;
  return { url: data.signedUrl, path };
}

/** Learner: fetch current user's completions (optionally scoped to a language). */
export function useMyProjectCompletions(languageId) {
  const { user } = useAuth();
  return useQuery({
    queryKey: ["my-project-completions", user?.id, languageId],
    queryFn: async () => {
      if (!user) return [];
      let q = supabase
        .from("user_project_completions")
        .select("*, language_projects!inner(language_id)")
        .eq("user_id", user.id);
      if (languageId) q = q.eq("language_projects.language_id", languageId);
      const { data, error } = await q;
      if (error) throw error;
      return data;
    },
    enabled: !!user,
  });
}

/** Learner: mark project as in-progress or completed. */
export function useUpsertProjectCompletion() {
  const qc = useQueryClient();
  const { user } = useAuth();
  return useMutation({
    mutationFn: async ({ projectId, status, submissionUrl, notes }) => {
      if (!user) throw new Error("Not authenticated");
      const payload = {
        user_id: user.id,
        project_id: projectId,
        status,
        submission_url: submissionUrl ?? null,
        notes: notes ?? null,
        completed_at: status === "completed" ? new Date().toISOString() : null,
      };
      const { data, error } = await supabase
        .from("user_project_completions")
        .upsert(payload, { onConflict: "user_id,project_id" })
        .select()
        .single();
      if (error) throw error;
      return data;
    },
    onSuccess: () => qc.invalidateQueries({ queryKey: ["my-project-completions"] }),
  });
}
