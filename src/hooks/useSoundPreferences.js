/**
 * useSoundPreferences – Per-user local sound preferences.
 * Each sound key (correct, incorrect, complete, click) can be muted independently.
 * Stored in localStorage so the choice survives across sessions on the same device.
 */
import { useCallback, useEffect, useState } from "react";

const STORAGE_KEY = "codebear:soundPrefs";
const DEFAULTS = { correct: true, incorrect: true, complete: true, click: true };

function read() {
    try {
        const raw = localStorage.getItem(STORAGE_KEY);
        if (!raw) return { ...DEFAULTS };
        return { ...DEFAULTS, ...JSON.parse(raw) };
    } catch {
        return { ...DEFAULTS };
    }
}

export function getSoundPreference(key) {
    return read()[key] !== false;
}

export function useSoundPreferences() {
    const [prefs, setPrefs] = useState(read);

    useEffect(() => {
        const onStorage = (e) => {
            if (e.key === STORAGE_KEY) setPrefs(read());
        };
        const onCustom = () => setPrefs(read());
        window.addEventListener("storage", onStorage);
        window.addEventListener("sound-prefs-changed", onCustom);
        return () => {
            window.removeEventListener("storage", onStorage);
            window.removeEventListener("sound-prefs-changed", onCustom);
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
        window.dispatchEvent(new CustomEvent("sound-prefs-changed"));
    }, []);

    return { prefs, setPref };
}
