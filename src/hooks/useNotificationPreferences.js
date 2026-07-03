/**
 * Notification alert preferences (streak, challenges, achievements, weekly report).
 * Persisted in localStorage and read by NotificationManager / useAchievements.
 */
import { useCallback, useEffect, useState } from "react";

const STORAGE_KEY = "codebear:notificationPrefs";
const DEFAULTS = {
    streakReminders: true,
    challengeAlerts: true,
    achievementAlerts: true,
    weeklyReport: false,
};

function read() {
    try {
        const raw = localStorage.getItem(STORAGE_KEY);
        if (!raw) return { ...DEFAULTS };
        return { ...DEFAULTS, ...JSON.parse(raw) };
    } catch {
        return { ...DEFAULTS };
    }
}

export function getNotificationPreference(key) {
    return read()[key] !== false;
}

export function useNotificationPreferences() {
    const [prefs, setPrefs] = useState(read);

    useEffect(() => {
        const onStorage = (e) => {
            if (e.key === STORAGE_KEY) setPrefs(read());
        };
        const onCustom = () => setPrefs(read());
        window.addEventListener("storage", onStorage);
        window.addEventListener("notification-prefs-changed", onCustom);
        return () => {
            window.removeEventListener("storage", onStorage);
            window.removeEventListener("notification-prefs-changed", onCustom);
        };
    }, []);

    const setPref = useCallback((key, enabled) => {
        const next = { ...read(), [key]: !!enabled };
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(next));
        } catch {
            // ignore
        }
        setPrefs(next);
        window.dispatchEvent(new CustomEvent("notification-prefs-changed"));
    }, []);

    return { prefs, setPref };
}
