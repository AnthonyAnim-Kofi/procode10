/**
 * ProjectsManager – Admin UI for creating, editing, deleting per-language projects.
 * Supports uploading image + video files or pasting external URLs.
 */
import { useState } from "react";
import { Plus, Trash2, Pencil, Loader2, Upload, Image as ImageIcon, Film, ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { LanguageSelectItem } from "@/components/LanguageSelectItem";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { useLanguages } from "@/hooks/useAdmin";
import {
  useLanguageProjects,
  useCreateProject,
  useUpdateProject,
  useDeleteProject,
  uploadProjectMedia,
} from "@/hooks/useProjects";

const emptyForm = {
  title: "",
  description: "",
  instructions: "",
  difficulty: "beginner",
  estimated_minutes: 60,
  image_url: "",
  video_url: "",
  resource_url: "",
  starter_code: "",
  xp_reward: 100,
  is_active: true,
};

export function ProjectsManager() {
  const { toast } = useToast();
  const { data: languages = [] } = useLanguages();
  const [selectedLanguage, setSelectedLanguage] = useState("");
  const { data: projects = [], isLoading } = useLanguageProjects(selectedLanguage, { includeInactive: true });
  const createProject = useCreateProject();
  const updateProject = useUpdateProject();
  const deleteProject = useDeleteProject();

  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [form, setForm] = useState(emptyForm);
  const [uploading, setUploading] = useState({ image: false, video: false });

  const openCreate = () => {
    setEditingId(null);
    setForm(emptyForm);
    setDialogOpen(true);
  };

  const openEdit = (p) => {
    setEditingId(p.id);
    setForm({
      title: p.title || "",
      description: p.description || "",
      instructions: p.instructions || "",
      difficulty: p.difficulty || "beginner",
      estimated_minutes: p.estimated_minutes ?? 60,
      image_url: p.image_url || "",
      video_url: p.video_url || "",
      resource_url: p.resource_url || "",
      starter_code: p.starter_code || "",
      xp_reward: p.xp_reward ?? 100,
      is_active: p.is_active ?? true,
    });
    setDialogOpen(true);
  };

  const handleUpload = async (file, kind) => {
    if (!file) return;
    setUploading((u) => ({ ...u, [kind]: true }));
    try {
      const { url } = await uploadProjectMedia(file, kind === "image" ? "images" : "videos");
      setForm((f) => ({ ...f, [kind === "image" ? "image_url" : "video_url"]: url }));
      toast({ title: `${kind === "image" ? "Image" : "Video"} uploaded` });
    } catch (e) {
      toast({ title: `Upload failed: ${e.message}`, variant: "destructive" });
    } finally {
      setUploading((u) => ({ ...u, [kind]: false }));
    }
  };

  const handleSave = async () => {
    if (!selectedLanguage) {
      toast({ title: "Pick a language first", variant: "destructive" });
      return;
    }
    if (!form.title.trim()) {
      toast({ title: "Title is required", variant: "destructive" });
      return;
    }
    try {
      const payload = {
        ...form,
        estimated_minutes: Number(form.estimated_minutes) || 60,
        xp_reward: Number(form.xp_reward) || 100,
      };
      if (editingId) {
        await updateProject.mutateAsync({ id: editingId, ...payload });
        toast({ title: "Project updated" });
      } else {
        await createProject.mutateAsync({
          language_id: selectedLanguage,
          order_index: projects.length,
          ...payload,
        });
        toast({ title: "Project created" });
      }
      setDialogOpen(false);
    } catch (e) {
      toast({ title: `Save failed: ${e.message}`, variant: "destructive" });
    }
  };

  const handleDelete = async (id) => {
    if (!confirm("Delete this project?")) return;
    try {
      await deleteProject.mutateAsync(id);
      toast({ title: "Project deleted" });
    } catch (e) {
      toast({ title: `Delete failed: ${e.message}`, variant: "destructive" });
    }
  };

  return (
    <div className="space-y-6">
      <div className="bg-slate-800 rounded-xl border border-slate-700 p-4 flex flex-wrap items-end gap-4">
        <div className="flex-1 min-w-[200px]">
          <Label className="text-slate-300">Language</Label>
          <Select value={selectedLanguage} onValueChange={setSelectedLanguage}>
            <SelectTrigger className="bg-slate-700 border-slate-600 text-white">
              <SelectValue placeholder="Select a language" />
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
        <Button onClick={openCreate} disabled={!selectedLanguage} className="bg-amber-600 hover:bg-amber-700">
          <Plus className="w-4 h-4 mr-2" /> New Project
        </Button>
      </div>

      <div className="bg-slate-800 rounded-xl border border-slate-700 overflow-hidden">
        <div className="p-4 border-b border-slate-700">
          <h3 className="font-bold">Projects ({projects.length})</h3>
        </div>
        {isLoading ? (
          <div className="p-8 text-center"><Loader2 className="w-6 h-6 animate-spin mx-auto text-amber-500" /></div>
        ) : projects.length === 0 ? (
          <div className="p-8 text-center text-slate-400">
            {selectedLanguage ? "No projects yet. Create the first one!" : "Select a language above."}
          </div>
        ) : (
          <div className="divide-y divide-slate-700">
            {projects.map((p) => (
              <div key={p.id} className="p-4 flex items-start gap-4 hover:bg-slate-700/40">
                {p.image_url ? (
                  <img src={p.image_url} alt="" className="w-20 h-20 rounded-lg object-cover shrink-0" />
                ) : (
                  <div className="w-20 h-20 rounded-lg bg-slate-700 flex items-center justify-center shrink-0">
                    <ImageIcon className="w-6 h-6 text-slate-500" />
                  </div>
                )}
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 flex-wrap">
                    <h4 className="font-bold">{p.title}</h4>
                    <span className="text-xs px-2 py-0.5 rounded-full bg-slate-700 capitalize">{p.difficulty}</span>
                    <span className="text-xs text-amber-400">+{p.xp_reward} XP</span>
                    {!p.is_active && <span className="text-xs px-2 py-0.5 rounded-full bg-red-900/60 text-red-300">Hidden</span>}
                  </div>
                  <p className="text-sm text-slate-400 line-clamp-2 mt-1">{p.description}</p>
                  <div className="flex items-center gap-3 mt-2 text-xs text-slate-500">
                    {p.video_url && <span className="flex items-center gap-1"><Film className="w-3 h-3" /> Video</span>}
                    {p.resource_url && <span className="flex items-center gap-1"><ExternalLink className="w-3 h-3" /> Resource</span>}
                    <span>{p.estimated_minutes} min</span>
                  </div>
                </div>
                <div className="flex gap-2 shrink-0">
                  <Button size="sm" variant="outline" onClick={() => openEdit(p)}><Pencil className="w-3 h-3" /></Button>
                  <Button size="sm" variant="destructive" onClick={() => handleDelete(p.id)}><Trash2 className="w-3 h-3" /></Button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Edit / Create Dialog */}
      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="max-w-2xl max-h-[85vh] overflow-y-auto bg-slate-900 text-white border-slate-700">
          <DialogHeader>
            <DialogTitle>{editingId ? "Edit Project" : "New Project"}</DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <div>
              <Label>Title</Label>
              <Input value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} className="bg-slate-800 border-slate-700" />
            </div>
            <div>
              <Label>Short Description</Label>
              <Textarea rows={2} value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} className="bg-slate-800 border-slate-700" />
            </div>
            <div>
              <Label>Instructions (Markdown supported)</Label>
              <Textarea rows={6} value={form.instructions} onChange={(e) => setForm({ ...form, instructions: e.target.value })} className="bg-slate-800 border-slate-700 font-mono text-sm" />
            </div>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <Label>Difficulty</Label>
                <Select value={form.difficulty} onValueChange={(v) => setForm({ ...form, difficulty: v })}>
                  <SelectTrigger className="bg-slate-800 border-slate-700"><SelectValue /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="beginner">Beginner</SelectItem>
                    <SelectItem value="intermediate">Intermediate</SelectItem>
                    <SelectItem value="advanced">Advanced</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label>Est. Minutes</Label>
                <Input type="number" value={form.estimated_minutes} onChange={(e) => setForm({ ...form, estimated_minutes: e.target.value })} className="bg-slate-800 border-slate-700" />
              </div>
              <div>
                <Label>XP Reward</Label>
                <Input type="number" value={form.xp_reward} onChange={(e) => setForm({ ...form, xp_reward: e.target.value })} className="bg-slate-800 border-slate-700" />
              </div>
            </div>

            <div className="space-y-2">
              <Label>Cover Image</Label>
              <div className="flex gap-2">
                <Input placeholder="Paste image URL or upload" value={form.image_url} onChange={(e) => setForm({ ...form, image_url: e.target.value })} className="bg-slate-800 border-slate-700" />
                <label className="cursor-pointer">
                  <input type="file" accept="image/*" hidden onChange={(e) => handleUpload(e.target.files?.[0], "image")} />
                  <Button asChild variant="outline"><span>{uploading.image ? <Loader2 className="w-4 h-4 animate-spin" /> : <Upload className="w-4 h-4" />}</span></Button>
                </label>
              </div>
            </div>

            <div className="space-y-2">
              <Label>Video</Label>
              <div className="flex gap-2">
                <Input placeholder="Paste video URL (mp4/YouTube) or upload" value={form.video_url} onChange={(e) => setForm({ ...form, video_url: e.target.value })} className="bg-slate-800 border-slate-700" />
                <label className="cursor-pointer">
                  <input type="file" accept="video/*" hidden onChange={(e) => handleUpload(e.target.files?.[0], "video")} />
                  <Button asChild variant="outline"><span>{uploading.video ? <Loader2 className="w-4 h-4 animate-spin" /> : <Upload className="w-4 h-4" />}</span></Button>
                </label>
              </div>
            </div>

            <div>
              <Label>External Resource URL (GitHub repo, Figma, docs...)</Label>
              <Input value={form.resource_url} onChange={(e) => setForm({ ...form, resource_url: e.target.value })} className="bg-slate-800 border-slate-700" />
            </div>

            <div>
              <Label>Starter Code (optional)</Label>
              <Textarea rows={4} value={form.starter_code} onChange={(e) => setForm({ ...form, starter_code: e.target.value })} className="bg-slate-800 border-slate-700 font-mono text-sm" />
            </div>

            <div className="flex items-center gap-2">
              <input id="active" type="checkbox" checked={form.is_active} onChange={(e) => setForm({ ...form, is_active: e.target.checked })} />
              <Label htmlFor="active">Visible to learners</Label>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setDialogOpen(false)}>Cancel</Button>
            <Button onClick={handleSave} disabled={createProject.isPending || updateProject.isPending} className="bg-amber-600 hover:bg-amber-700">
              {(createProject.isPending || updateProject.isPending) && <Loader2 className="w-4 h-4 animate-spin mr-2" />}
              {editingId ? "Save Changes" : "Create Project"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
