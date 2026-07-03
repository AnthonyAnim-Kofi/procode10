import { useEffect, useRef } from "react";
import { useUserProfile, useUpdateProfile } from "@/hooks/useUserProgress";
import { useStreakReminder, useNotifications } from "@/hooks/useNotifications";
import { useNotificationPreferences } from "@/hooks/useNotificationPreferences";
import { useChallenges } from "@/hooks/useSocial";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";

const WEEKLY_REPORT_KEY = "codebear:lastWeeklyReport";

export function NotificationManager() {
    const { data: profile } = useUserProfile();
    const updateProfile = useUpdateProfile();
    const { data: challenges } = useChallenges();
    const {
        notifyChallengeAlert,
        notifyChallengeWin,
        notifyChallengeLoss,
        notifyChallengeTie,
        sendNotification,
    } = useNotifications();
    const { prefs: notificationPrefs } = useNotificationPreferences();
    const notifiedChallengesRef = useRef(new Set());
    const notifiedCompletedRef = useRef(new Set());
    const streakFreezeNoticeShownRef = useRef(false);

    useStreakReminder(
        profile?.last_practice_date || null,
        !!profile && notificationPrefs.streakReminders,
    );

    // One-time login notice when auto streak freeze was used while away.
    useEffect(() => {
        if (!profile || streakFreezeNoticeShownRef.current)
            return;
        if (!profile.auto_use_streak_freeze || !profile.last_streak_freeze_used)
            return;
        const noticeSeenAt = profile.streak_freeze_notice_seen_at
            ? new Date(profile.streak_freeze_notice_seen_at).getTime()
            : 0;
        const freezeUsedAt = new Date(profile.last_streak_freeze_used).getTime();
        if (Number.isNaN(freezeUsedAt) || freezeUsedAt <= noticeSeenAt)
            return;
        streakFreezeNoticeShownRef.current = true;
        toast.success("Your streak was saved while you were away using a Streak Freeze.");
        updateProfile.mutate({
            streak_freeze_notice_seen_at: new Date().toISOString(),
        });
    }, [profile, updateProfile]);

    // Weekly progress summary (at most once every 7 days)
    useEffect(() => {
        if (!profile || !notificationPrefs.weeklyReport)
            return;
        const lastSent = Number(localStorage.getItem(WEEKLY_REPORT_KEY) || 0);
        const weekMs = 7 * 24 * 60 * 60 * 1000;
        if (lastSent && Date.now() - lastSent < weekMs)
            return;

        const body = `XP: ${profile.xp || 0} · Streak: ${profile.streak_count || 0} days · Weekly XP: ${profile.weekly_xp || 0}`;
        if (document.visibilityState === "hidden") {
            sendNotification("Your Weekly Report 📊", { body, tag: "weekly-report" });
        } else {
            toast.info("Your Weekly Report 📊", { id: "weekly-report", description: body, duration: 8000 });
        }
        localStorage.setItem(WEEKLY_REPORT_KEY, String(Date.now()));
    }, [profile, sendNotification, notificationPrefs.weeklyReport]);

    // Check for new (pending) challenges
    useEffect(() => {
        if (!challenges || challenges.length === 0 || !profile || !notificationPrefs.challengeAlerts)
            return;
        const pendingChallenges = challenges.filter(
            (c) => c.status === "pending" && c.challenged_id === profile.user_id
        );
        for (const challenge of pendingChallenges) {
            if (notifiedChallengesRef.current.has(challenge.id))
                continue;
            const challengeDate = new Date(challenge.created_at);
            const now = new Date();
            const diffMinutes = (now.getTime() - challengeDate.getTime()) / (1000 * 60);
            if (diffMinutes < 10) {
                supabase
                    .from("profiles")
                    .select("display_name, username")
                    .eq("user_id", challenge.challenger_id)
                    .single()
                    .then(({ data }) => {
                        const challengerName = data?.display_name || data?.username || "Someone";
                        const toastId = `challenge-alert-${challenge.id}`;
                        if (document.visibilityState === "hidden") {
                            notifyChallengeAlert(challengerName, challenge.id);
                        } else {
                            toast.info("New Challenge! ⚔️", {
                                id: toastId,
                                description: `${challengerName} has challenged you to a lesson battle!`,
                                duration: 6000,
                            });
                        }
                        notifiedChallengesRef.current.add(challenge.id);
                    });
            }
        }
    }, [challenges, profile, notifyChallengeAlert, notificationPrefs.challengeAlerts]);

    // Check for newly completed challenges and notify outcome
    useEffect(() => {
        if (!challenges || challenges.length === 0 || !profile || !notificationPrefs.challengeAlerts)
            return;

        const completedChallenges = challenges.filter(
            (c) =>
                c.status === "completed" &&
                c.challenger_score !== null &&
                c.challenger_score !== undefined &&
                c.challenged_score !== null &&
                c.challenged_score !== undefined
        );

        for (const challenge of completedChallenges) {
            if (notifiedCompletedRef.current.has(challenge.id))
                continue;

            const isChallenger = challenge.challenger_id === profile.user_id;
            const myScore = isChallenger ? challenge.challenger_score : challenge.challenged_score;
            const opponentScore = isChallenger ? challenge.challenged_score : challenge.challenger_score;
            const opponentUserId = isChallenger ? challenge.challenged_id : challenge.challenger_id;

            const completedAt = challenge.completed_at ? new Date(challenge.completed_at) : null;
            if (completedAt) {
                const diffMinutes = (Date.now() - completedAt.getTime()) / (1000 * 60);
                if (diffMinutes > 30) {
                    notifiedCompletedRef.current.add(challenge.id);
                    continue;
                }
            }

            supabase
                .from("profiles")
                .select("display_name, username")
                .eq("user_id", opponentUserId)
                .single()
                .then(({ data }) => {
                    const opponentName = data?.display_name || data?.username || "Your opponent";
                    const toastId = `challenge-result-${challenge.id}`;
                    if (document.visibilityState === "hidden") {
                        if (myScore > opponentScore) {
                            notifyChallengeWin(opponentName, challenge.id);
                        } else if (myScore < opponentScore) {
                            notifyChallengeLoss(opponentName, challenge.id);
                        } else {
                            notifyChallengeTie(opponentName, challenge.id);
                        }
                    } else {
                        if (myScore > opponentScore) {
                            toast.success("You Won! 🏆", {
                                id: toastId,
                                description: `You beat ${opponentName} in the challenge!`,
                            });
                        } else if (myScore < opponentScore) {
                            toast.info("Challenge Complete 💪", {
                                id: toastId,
                                description: `${opponentName} beat you this time. Better luck next time!`,
                            });
                        } else {
                            toast.info("It's a Tie! 🤝", {
                                id: toastId,
                                description: `You and ${opponentName} finished with the same score!`,
                            });
                        }
                    }
                    notifiedCompletedRef.current.add(challenge.id);
                });
        }
    }, [challenges, profile, notifyChallengeWin, notifyChallengeLoss, notifyChallengeTie, notificationPrefs.challengeAlerts]);

    return null;
}
