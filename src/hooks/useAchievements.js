import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useEffect, useMemo, useRef } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useNotifications } from "@/hooks/useNotifications";
import { getNotificationPreference } from "@/hooks/useNotificationPreferences";
import { toast } from "sonner";
import { useUserProfile, useLessonProgress } from "@/hooks/useUserProgress";
import { useFollowing, useChallenges } from "@/hooks/useSocial";
/** Fetches all available achievements sorted by requirement value */
export function useAchievements() {
    return useQuery({
        queryKey: ["achievements"],
        queryFn: async () => {
            const { data, error } = await supabase
                .from("achievements")
                .select("*")
                .order("requirement_value", { ascending: true });
            if (error)
                throw error;
            return data;
        },
    });
}
/** Fetches the current user's earned achievements */
export function useUserAchievements() {
    const { user } = useAuth();
    return useQuery({
        queryKey: ["user-achievements", user?.id],
        queryFn: async () => {
            if (!user)
                return [];
            const { data, error } = await supabase
                .from("user_achievements")
                .select("*, achievement:achievements(*)")
                .eq("user_id", user.id);
            if (error)
                throw error;
            return data || [];
        },
        enabled: !!user,
    });
}
/**
 * Checks user stats against all achievements and awards any newly earned ones.
 * Sends both browser push notifications and in-app toast notifications.
 */
export function useCheckAndAwardAchievements() {
    const { user } = useAuth();
    const queryClient = useQueryClient();
    const { notifyAchievementUnlock } = useNotifications();
    return useMutation({
        mutationFn: async (stats) => {
            if (!user)
                throw new Error("Not authenticated");
            const { data: achievements } = await supabase
                .from("achievements")
                .select("*");
            const { data: userAchievements } = await supabase
                .from("user_achievements")
                .select("achievement_id")
                .eq("user_id", user.id);
            const earnedIds = new Set(userAchievements?.map(ua => ua.achievement_id) || []);
            const newAchievements = [];
            // Check each achievement against user's current stats
            for (const achievement of achievements || []) {
                if (earnedIds.has(achievement.id))
                    continue;
                let earned = false;
                switch (achievement.requirement_type) {
                    case "lessons_completed":
                        earned = stats.lessonsCompleted >= achievement.requirement_value;
                        break;
                    case "streak":
                        earned = stats.streak >= achievement.requirement_value;
                        break;
                    case "xp":
                        earned = stats.xp >= achievement.requirement_value;
                        break;
                    case "following":
                        earned = stats.following >= achievement.requirement_value;
                        break;
                    case "challenges":
                        earned = stats.challenges >= achievement.requirement_value;
                        break;
                    case "perfect_lesson":
                        earned = stats.perfectLessons >= achievement.requirement_value;
                        break;
                    case "league":
                        const leagueLevel = { bronze: 0, silver: 1, gold: 2, diamond: 3 }[stats.league] || 0;
                        earned = leagueLevel >= achievement.requirement_value;
                        break;
                }
                if (earned) {
                    newAchievements.push({ id: achievement.id, name: achievement.name, icon: achievement.icon });
                }
            }
            // Insert newly earned achievements and send notifications
            if (newAchievements.length > 0) {
                await supabase
                    .from("user_achievements")
                    .insert(newAchievements.map(a => ({
                    user_id: user.id,
                    achievement_id: a.id,
                })));
                // Notify once per achievement (toast when visible, push when tab hidden)
                if (getNotificationPreference("achievementAlerts")) {
                    for (const achievement of newAchievements) {
                        const toastId = `achievement-${achievement.id}`;
                        if (document.visibilityState === "hidden") {
                            notifyAchievementUnlock(achievement.name, achievement.id);
                        } else {
                            toast.success("🏆 Achievement Unlocked!", {
                                id: toastId,
                                description: `${achievement.name} — see your rewards on the Achievements page.`,
                                duration: 6000,
                            });
                        }
                    }
                }
            }
            return newAchievements.length;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ["user-achievements"] });
        },
    });
}
/**
 * Memoized user stats used for achievement progress display.
 */
export function useAchievementStats() {
    const { data: profile } = useUserProfile();
    const { data: lessonProgress } = useLessonProgress();
    const { data: following } = useFollowing();
    const { data: challenges } = useChallenges();
    return useMemo(() => ({
        lessonsCompleted: lessonProgress?.filter(p => p.completed).length || 0,
        streak: profile?.streak_count || 0,
        xp: profile?.xp || 0,
        following: following?.length || 0,
        challenges: challenges?.filter(c => c.status === "completed").length || 0,
        perfectLessons: lessonProgress?.filter(p => p.accuracy === 100).length || 0,
        league: profile?.league || "bronze",
    }), [lessonProgress, profile, following, challenges]);
}

/**
 * A global monitor that constantly checks if stats have crossed new milestones.
 * Should be placed in a top level authenticated component like MainLayout.
 */
export function useGlobalAchievementMonitor() {
    const { data: profile } = useUserProfile();
    const { data: lessonProgress } = useLessonProgress();
    const stats = useAchievementStats();
    const checkAndAward = useCheckAndAwardAchievements();
    const lastStatsKeyRef = useRef("");

    useEffect(() => {
        if (!profile || lessonProgress === undefined || checkAndAward.isPending)
            return;
        const statsKey = JSON.stringify(stats);
        if (statsKey === lastStatsKeyRef.current)
            return;
        lastStatsKeyRef.current = statsKey;
        checkAndAward.mutate(stats);
    }, [profile, lessonProgress, stats, checkAndAward.isPending, checkAndAward.mutate]);

    return stats;
}
