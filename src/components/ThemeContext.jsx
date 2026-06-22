import React, { createContext, useContext, useEffect, useState } from 'react';

/**
 * Calendar-driven seasonal themes have been retired for a consistent,
 * higher-education aesthetic. The provider now always applies `theme-default`
 * unless an explicit override is set (kept for backwards compatibility).
 *
 * The HOLIDAYS / HOLIDAYS_FOR_SETTINGS exports remain so any legacy UI that
 * imports them keeps rendering without runtime errors — they're just empty.
 */
export const HOLIDAYS = [];
export const HOLIDAYS_FOR_SETTINGS = [];

export function getWesternEasterSunday(year) {
  // Retained for any legacy imports; pure function with no side effects.
  const a = year % 19;
  const b = Math.floor(year / 100);
  const c = year % 100;
  const d = Math.floor(b / 4);
  const e = b % 4;
  const f = Math.floor((b + 8) / 25);
  const g = Math.floor((b - f + 1) / 3);
  const h = (19 * a + b - d - g + 15) % 30;
  const i = Math.floor(c / 4);
  const k = c % 4;
  const l = (32 + 2 * e + 2 * i - h - k) % 7;
  const m = Math.floor((a + 11 * h + 22 * l) / 451);
  const month = Math.floor((h + l - 7 * m + 114) / 31);
  const day = ((h + l - 7 * m + 114) % 31) + 1;
  return new Date(year, month - 1, day);
}

const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const [overrideTheme, setOverrideTheme] = useState(null);
  const [currentTheme, setCurrentTheme] = useState('theme-default');

  useEffect(() => {
    const active = overrideTheme || 'theme-default';
    setCurrentTheme(active);
    const root = document.documentElement;
    // Strip any prior seasonal classes that may have been added in older sessions.
    Array.from(root.classList)
      .filter((c) => c.startsWith('theme-'))
      .forEach((c) => root.classList.remove(c));
    root.classList.add(active);
  }, [overrideTheme]);

  return (
    <ThemeContext.Provider value={{ currentTheme, overrideTheme, setOverrideTheme, HOLIDAYS, HOLIDAYS_FOR_SETTINGS }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within a ThemeProvider');
  return context;
}
