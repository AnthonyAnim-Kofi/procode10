import { useEffect, useState } from "react";
import { Code2 } from "lucide-react";

const STORAGE_KEY = "codebear:splash-seen";

/**
 * Full-screen splash animation shown once per browser session.
 * Uses sessionStorage so it does NOT replay on simple page refreshes
 * within the same tab/session, only on a fresh open.
 */
export function SplashScreen() {
  const [visible, setVisible] = useState(() => {
    if (typeof window === "undefined") return false;
    try {
      return !sessionStorage.getItem(STORAGE_KEY);
    } catch {
      return false;
    }
  });
  const [leaving, setLeaving] = useState(false);

  useEffect(() => {
    if (!visible) return;
    try {
      sessionStorage.setItem(STORAGE_KEY, "1");
    } catch {
      /* ignore */
    }
    const leaveTimer = setTimeout(() => setLeaving(true), 1800);
    const removeTimer = setTimeout(() => setVisible(false), 2400);
    return () => {
      clearTimeout(leaveTimer);
      clearTimeout(removeTimer);
    };
  }, [visible]);

  if (!visible) return null;

  return (
    <div
      role="status"
      aria-label="Loading ProCode"
      className={`fixed inset-0 z-[9999] flex items-center justify-center bg-background transition-opacity duration-500 ${
        leaving ? "opacity-0 pointer-events-none" : "opacity-100"
      }`}
    >
      {/* Soft radial backdrop */}
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,hsl(var(--primary)/0.15),transparent_60%)]" />

      <div className="relative flex flex-col items-center gap-6">
        {/* Animated logo mark */}
        <div className="relative">
          <span className="absolute inset-0 rounded-2xl bg-primary/30 blur-xl animate-pulse" />
          <div className="relative flex items-center justify-center w-20 h-20 rounded-2xl bg-primary shadow-lg splash-pop">
            <Code2 className="w-10 h-10 text-primary-foreground" />
          </div>
        </div>

        {/* Wordmark */}
        <div className="overflow-hidden">
          <h1 className="text-3xl font-bold tracking-tight text-foreground splash-rise">
            ProCode
          </h1>
        </div>

        {/* Loading bar */}
        <div className="h-1 w-40 rounded-full bg-muted overflow-hidden">
          <div className="h-full w-1/3 bg-primary splash-bar" />
        </div>
      </div>

      <style>{`
        @keyframes splash-pop {
          0% { transform: scale(0.6); opacity: 0; }
          60% { transform: scale(1.08); opacity: 1; }
          100% { transform: scale(1); opacity: 1; }
        }
        @keyframes splash-rise {
          0% { transform: translateY(110%); opacity: 0; }
          100% { transform: translateY(0); opacity: 1; }
        }
        @keyframes splash-bar {
          0% { transform: translateX(-120%); }
          100% { transform: translateX(380%); }
        }
        .splash-pop { animation: splash-pop 0.7s cubic-bezier(0.34, 1.56, 0.64, 1) both; }
        .splash-rise { animation: splash-rise 0.6s 0.25s cubic-bezier(0.22, 1, 0.36, 1) both; }
        .splash-bar { animation: splash-bar 1.4s 0.4s cubic-bezier(0.45, 0, 0.55, 1) infinite; }
      `}</style>
    </div>
  );
}
