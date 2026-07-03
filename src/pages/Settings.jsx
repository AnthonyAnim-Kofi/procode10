import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ArrowLeft, Check, User, Bell, Palette, Loader2, Volume2, CheckCircle2, XCircle, Trophy, MousePointerClick } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { cn } from "@/lib/utils";
import { useUserProfile, useUpdateProfile } from "@/hooks/useUserProgress";
import { useTheme, THEMES } from "@/components/ThemeContext";
import { ThemePreview } from "@/components/ThemePreview";
import { AVATARS, AVATAR_CATEGORIES } from "@/data/avatars";
import { useToast } from "@/hooks/use-toast";
import { useSoundPreferences } from "@/hooks/useSoundPreferences";
import { useNotificationPreferences } from "@/hooks/useNotificationPreferences";

const SOUND_TOGGLES = [
    { key: "correct", label: "Correct Answer", description: "Cheerful chime when you answer correctly", Icon: CheckCircle2 },
    { key: "incorrect", label: "Wrong Answer", description: "Soft notice when you miss a question", Icon: XCircle },
    { key: "complete", label: "Lesson Complete", description: "Celebration sound at the end of a lesson", Icon: Trophy },
    { key: "click", label: "UI Click", description: "Subtle feedback for buttons and taps", Icon: MousePointerClick },
];

export default function Settings() {
    const navigate = useNavigate();
    const { toast } = useToast();
    const { data: profile, isLoading } = useUserProfile();
    const updateProfile = useUpdateProfile();
    const { themeId, setThemeId } = useTheme();
    const { prefs: soundPrefs, setPref: setSoundPref } = useSoundPreferences();
    const { prefs: notifications, setPref: setNotificationPref } = useNotificationPreferences();
    const [displayName, setDisplayName] = useState("");
    const [selectedAvatar, setSelectedAvatar] = useState(null);

    const [avatarCategory, setAvatarCategory] = useState("all");
    const [initialized, setInitialized] = useState(false);
    const [autoFreezeSaving, setAutoFreezeSaving] = useState(false);
    // Initialize form with profile data when it loads
    if (profile && !initialized) {
        setDisplayName(profile.display_name || "");
        setSelectedAvatar(profile.avatar_url);
        setInitialized(true);
    }
    const filteredAvatars = avatarCategory === "all"
        ? AVATARS
        : AVATARS.filter(a => a.category === avatarCategory);
    const handleSaveProfile = async () => {
        try {
            await updateProfile.mutateAsync({
                display_name: displayName || profile?.display_name,
                avatar_url: selectedAvatar || profile?.avatar_url,
            });
            toast({
                title: "Profile updated!",
                description: "Your changes have been saved.",
            });
        }
        catch (error) {
            toast({
                title: "Error",
                description: "Failed to update profile. Please try again.",
                variant: "destructive",
            });
        }
    };
    const handleAutoStreakFreezeToggle = async (checked) => {
        setAutoFreezeSaving(true);
        try {
            await updateProfile.mutateAsync({ auto_use_streak_freeze: checked });
            toast({
                title: checked ? "Auto Streak Freeze enabled" : "Auto Streak Freeze disabled",
                description: checked
                    ? "Your streak freeze will be used automatically if you miss a day."
                    : "Your streak freeze will not be used automatically.",
            });
        }
        catch (error) {
            toast({
                title: "Error",
                description: "Failed to update streak freeze setting.",
                variant: "destructive",
            });
        }
        finally {
            setAutoFreezeSaving(false);
        }
    };
    if (isLoading) {
        return (<div className="flex items-center justify-center py-12">
        <Loader2 className="w-8 h-8 animate-spin text-primary"/>
      </div>);
    }
    return (<div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" onClick={() => navigate(-1)} className="rounded-xl">
          <ArrowLeft className="w-5 h-5"/>
        </Button>
        <div>
          <h1 className="text-2xl font-extrabold text-foreground">Settings</h1>
          <p className="text-muted-foreground">Customize your experience</p>
        </div>
      </div>

      <Tabs defaultValue="profile" className="space-y-6">
        <TabsList className="grid w-full grid-cols-4 h-auto p-1 bg-muted rounded-xl">
          <TabsTrigger value="profile" className="rounded-lg py-2 data-[state=active]:bg-background">
            <User className="w-4 h-4 mr-2"/>
            Profile
          </TabsTrigger>
          <TabsTrigger value="avatar" className="rounded-lg py-2 data-[state=active]:bg-background">
            <Palette className="w-4 h-4 mr-2"/>
            Avatar
          </TabsTrigger>
          <TabsTrigger value="sounds" className="rounded-lg py-2 data-[state=active]:bg-background">
            <Volume2 className="w-4 h-4 mr-2"/>
            Sounds
          </TabsTrigger>
          <TabsTrigger value="notifications" className="rounded-lg py-2 data-[state=active]:bg-background">
            <Bell className="w-4 h-4 mr-2"/>
            Alerts
          </TabsTrigger>
        </TabsList>


        {/* Profile Tab */}
        <TabsContent value="profile" className="space-y-6">
          <div className="p-6 bg-card rounded-2xl border border-border space-y-4">
            <div className="space-y-2">
              <Label htmlFor="displayName">Display Name</Label>
              <Input id="displayName" value={displayName} onChange={(e) => setDisplayName(e.target.value)} placeholder="Enter your display name" className="rounded-xl"/>
            </div>
            <div className="space-y-2">
              <Label htmlFor="email">Email</Label>
              <Input id="email" value={profile?.username || ""} disabled className="rounded-xl bg-muted"/>
              <p className="text-xs text-muted-foreground">Email cannot be changed</p>
            </div>

            <div className="pt-4 border-t border-border mt-4">
              <Label className="text-primary font-bold">Appearance Theme</Label>
              <p className="text-xs text-muted-foreground mb-3">Choose the colour palette used across the site.</p>
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
                {THEMES.map((t) => {
                  const active = themeId === t.id;
                  return (
                    <button
                      key={t.id}
                      type="button"
                      onClick={() => setThemeId(t.id)}
                      className={cn(
                        "group relative rounded-xl border-2 p-3 text-left transition-all",
                        active ? "border-primary ring-2 ring-primary/30" : "border-border hover:border-primary/40"
                      )}
                    >
                      <div className="flex gap-1 mb-2">
                        {t.swatches.map((c) => (
                          <span key={c} className="h-6 flex-1 rounded-md border border-black/5" style={{ background: c }} />
                        ))}
                      </div>
                      <span className="text-xs font-semibold text-foreground">{t.name}</span>
                      {active && (
                        <span className="absolute top-2 right-2 inline-flex items-center justify-center w-5 h-5 rounded-full bg-primary text-primary-foreground">
                          <Check className="w-3 h-3" />
                        </span>
                      )}
                    </button>
                  );
                })}
              </div>
              <div className="mt-4">
                <p className="text-xs text-muted-foreground mb-2">Live preview</p>
                <ThemePreview themeId={themeId} />
              </div>
            </div>
          </div>
        </TabsContent>

        {/* Avatar Tab */}
        <TabsContent value="avatar" className="space-y-6">
          <div className="p-6 bg-card rounded-2xl border border-border space-y-4">
            <div className="flex items-center gap-4 pb-4 border-b border-border">
              <div className="w-20 h-20 rounded-full bg-muted overflow-hidden">
                <img src={selectedAvatar || profile?.avatar_url || AVATARS[0].url} alt="Selected avatar" className="w-full h-full object-cover"/>
              </div>
              <div>
                <p className="font-bold text-foreground">Current Avatar</p>
                <p className="text-sm text-muted-foreground">
                  {AVATARS.find(a => a.url === (selectedAvatar || profile?.avatar_url))?.name || "Default"}
                </p>
              </div>
            </div>

            {/* Category Filter */}
            <div className="flex flex-wrap gap-2">
              {AVATAR_CATEGORIES.map((category) => (<Button key={category.id} variant={avatarCategory === category.id ? "default" : "outline"} size="sm" onClick={() => setAvatarCategory(category.id)} className="rounded-full">
                  {category.name}
                </Button>))}
            </div>

            {/* Avatar Grid */}
            <div className="grid grid-cols-4 sm:grid-cols-6 gap-3">
              {filteredAvatars.map((avatar) => (<button key={avatar.id} onClick={() => setSelectedAvatar(avatar.url)} className={cn("relative p-2 rounded-xl border-2 transition-all hover:scale-105", (selectedAvatar || profile?.avatar_url) === avatar.url
                ? "border-primary bg-primary/10"
                : "border-transparent bg-muted hover:border-muted-foreground/20")}>
                  <img src={avatar.url} alt={avatar.name} className="w-full aspect-square rounded-lg"/>
                  {(selectedAvatar || profile?.avatar_url) === avatar.url && (<div className="absolute -top-1 -right-1 w-5 h-5 bg-primary rounded-full flex items-center justify-center">
                      <Check className="w-3 h-3 text-primary-foreground"/>
                    </div>)}
                </button>))}
            </div>
          </div>
        </TabsContent>

        {/* Sounds Tab */}
        <TabsContent value="sounds" className="space-y-6">
          <div className="p-6 bg-card rounded-2xl border border-border space-y-2">
            <div className="pb-2 border-b border-border">
              <p className="font-bold text-foreground">Sound Effects</p>
              <p className="text-sm text-muted-foreground">Mute or enable individual sounds. Stored on this device.</p>
            </div>
            {SOUND_TOGGLES.map(({ key, label, description, Icon }, idx) => (
              <div
                key={key}
                className={cn(
                  "flex items-center justify-between py-3",
                  idx > 0 && "border-t border-border"
                )}
              >
                <div className="flex items-start gap-3">
                  <span className="mt-0.5 inline-flex items-center justify-center w-9 h-9 rounded-lg bg-primary/10 text-primary">
                    <Icon className="w-4 h-4" />
                  </span>
                  <div>
                    <p className="font-semibold text-foreground">{label}</p>
                    <p className="text-sm text-muted-foreground">{description}</p>
                  </div>
                </div>
                <Switch
                  checked={soundPrefs[key] !== false}
                  onCheckedChange={(checked) => setSoundPref(key, checked)}
                />
              </div>
            ))}
          </div>
        </TabsContent>



        {/* Notifications Tab */}
        <TabsContent value="notifications" className="space-y-6">
          <div className="p-6 bg-card rounded-2xl border border-border space-y-4">
            <div className="flex items-center justify-between py-3">
              <div>
                <p className="font-semibold text-foreground">Streak Reminders</p>
                <p className="text-sm text-muted-foreground">Get reminded to practice daily</p>
              </div>
              <Switch checked={notifications.streakReminders} onCheckedChange={(checked) => setNotificationPref("streakReminders", checked)}/>
            </div>
            <div className="flex items-center justify-between py-3 border-t border-border">
              <div>
                <p className="font-semibold text-foreground">Challenge Alerts</p>
                <p className="text-sm text-muted-foreground">Notify when friends challenge you</p>
              </div>
              <Switch checked={notifications.challengeAlerts} onCheckedChange={(checked) => setNotificationPref("challengeAlerts", checked)}/>
            </div>
            <div className="flex items-center justify-between py-3 border-t border-border">
              <div>
                <p className="font-semibold text-foreground">Achievement Alerts</p>
                <p className="text-sm text-muted-foreground">Celebrate when you earn badges</p>
              </div>
              <Switch checked={notifications.achievementAlerts} onCheckedChange={(checked) => setNotificationPref("achievementAlerts", checked)}/>
            </div>
            <div className="flex items-center justify-between py-3 border-t border-border">
              <div>
                <p className="font-semibold text-foreground">Weekly Report</p>
                <p className="text-sm text-muted-foreground">Receive weekly progress summary</p>
              </div>
              <Switch checked={notifications.weeklyReport} onCheckedChange={(checked) => setNotificationPref("weeklyReport", checked)}/>
            </div>
            <div className="flex items-center justify-between py-3 border-t border-border">
              <div>
                <p className="font-semibold text-foreground">Auto Use Streak Freeze</p>
                <p className="text-sm text-muted-foreground">Automatically save your streak if you miss a day</p>
              </div>
              <Switch
                checked={profile?.auto_use_streak_freeze ?? true}
                disabled={autoFreezeSaving}
                onCheckedChange={handleAutoStreakFreezeToggle}
              />
            </div>
          </div>
        </TabsContent>
      </Tabs>

      {/* Save Button */}
      <div className="flex gap-3">
        <Button onClick={handleSaveProfile} disabled={updateProfile.isPending} className="flex-1 rounded-xl h-12 font-bold">
          {updateProfile.isPending ? (<Loader2 className="w-5 h-5 animate-spin mr-2"/>) : (<Check className="w-5 h-5 mr-2"/>)}
          Save Changes
        </Button>
      </div>
    </div>);
}
