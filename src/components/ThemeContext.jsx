import React, { createContext, useContext, useEffect, useState } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/contexts/AuthContext';

/**
 * Theme system — four professional palettes the user can pick from at
 * signup or in Settings. The active class is applied to <html>.
 *
 * Legacy `HOLIDAYS` exports are kept (empty) so older imports don't crash.
 */
export const HOLIDAYS = [];
export const HOLIDAYS_FOR_SETTINGS = [];

export const THEMES = [
  { id: 'emerald', name: 'Emerald Prestige', className: 'theme-emerald', swatches: ['#064e3b', '#0d7a5f', '#c9a84c', '#f5f0e0'] },
  { id: 'navy', name: 'Navy Trust', className: 'theme-navy', swatches: ['#0f1b3d', '#1e3a5f', '#3b6fa0', '#e8edf3'] },
  { id: 'paper', name: 'Paper & Ink', className: 'theme-paper', swatches: ['#f5f3ee', '#e8e4dd', '#2d2d2d', '#0d0d0d'] },
  { id: 'slate', name: 'Slate & Steel', className: 'theme-slate', swatches: ['#2d3748', '#4a5568', '#718096', '#a0aec0'] },
];

const THEME_CLASSES = THEMES.map(t => t.className);
const LOCAL_KEY = 'cp.theme';

export function getWesternEasterSunday(year) {
  // Retained for any legacy imports; pure function with no side effects.
  return new Date(year, 0, 1);
}

const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const { user } = useAuth?.() || { user: null };
  const [themeId, setThemeIdState] = useState(() => {
    if (typeof window === 'undefined') return 'emerald';
    return window.localStorage.getItem(LOCAL_KEY) || 'emerald';
  });

  // Apply class to <html>
  useEffect(() => {
    const root = document.documentElement;
    THEME_CLASSES.forEach(c => root.classList.remove(c));
    Array.from(root.classList).filter(c => c.startsWith('theme-')).forEach(c => root.classList.remove(c));
    const chosen = THEMES.find(t => t.id === themeId) || THEMES[0];
    root.classList.add(chosen.className);
    try { window.localStorage.setItem(LOCAL_KEY, chosen.id); } catch {}
  }, [themeId]);

  // Sync from profile on login
  useEffect(() => {
    let cancelled = false;
    async function load() {
      if (!user) return;
      const { data } = await supabase
        .from('profiles')
        .select('theme_preference')
        .eq('user_id', user.id)
        .maybeSingle();
      if (!cancelled && data?.theme_preference) {
        setThemeIdState(data.theme_preference);
      }
    }
    load();
    return () => { cancelled = true; };
  }, [user?.id]);

  const setThemeId = async (id) => {
    setThemeIdState(id);
    if (user) {
      await supabase.from('profiles').update({ theme_preference: id }).eq('user_id', user.id);
    }
  };

  return (
    <ThemeContext.Provider value={{
      themeId,
      setThemeId,
      themes: THEMES,
      // Back-compat exports for legacy components:
      currentTheme: THEMES.find(t => t.id === themeId)?.className || 'theme-emerald',
      overrideTheme: null,
      setOverrideTheme: () => {},
      HOLIDAYS,
      HOLIDAYS_FOR_SETTINGS,
    }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within a ThemeProvider');
  return context;
}
