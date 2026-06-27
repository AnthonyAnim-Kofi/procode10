import { createPortal } from "react-dom";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { useEffect, useLayoutEffect, useMemo, useRef, useState } from "react";
import { Home, Trophy, Target, ShoppingBag, Gem, MoreHorizontal } from "lucide-react";
import { cn } from "@/lib/utils";
import { useUserProfile } from "@/hooks/useUserProgress";
import { HeartTimerPopover } from "@/components/HeartTimerPopover";
import { StreakPopover } from "@/components/StreakPopover";
import { MobileMoreMenu } from "./MobileMoreMenu";

const navItems = [
    { icon: Home, label: "Learn", path: "/learn" },
    { icon: Trophy, label: "Ranks", path: "/leaderboard" },
    { icon: Target, label: "Quests", path: "/quests" },
    { icon: ShoppingBag, label: "Shop", path: "/shop" },
];

/** Detect iOS (iPhone / iPad / iPod, including iPadOS reporting as Mac with touch) */
function useIsIOS() {
    const [ios, setIos] = useState(false);
    useEffect(() => {
        if (typeof navigator === "undefined") return;
        const ua = navigator.userAgent || "";
        const isiOS =
            /iPad|iPhone|iPod/.test(ua) ||
            (navigator.platform === "MacIntel" && (navigator.maxTouchPoints || 0) > 1);
        setIos(isiOS);
    }, []);
    return ios;
}

export function MobileHeader() {
    const location = useLocation();
    const navigate = useNavigate();
    const { data: profile } = useUserProfile();
    const hearts = profile?.hearts ?? 5;
    const streak = profile?.streak_count ?? 0;
    const gems = profile?.gems ?? 0;
    const isIOS = useIsIOS();

    // Tab indexing (incl. More)
    const tabs = useMemo(() => [...navItems, { label: "More", path: "__more__" }], []);
    const activeIndex = Math.max(
        0,
        navItems.findIndex((i) => i.path === location.pathname),
    );

    const navRef = useRef(null);
    const itemRefs = useRef([]);
    const [pill, setPill] = useState({ left: 0, width: 0, ready: false });
    const [dragX, setDragX] = useState(null); // px offset while dragging
    const dragState = useRef({ active: false, startX: 0, startLeft: 0 });

    const measure = (index) => {
        const el = itemRefs.current[index];
        const parent = navRef.current;
        if (!el || !parent) return null;
        const r = el.getBoundingClientRect();
        const p = parent.getBoundingClientRect();
        return { left: r.left - p.left, width: r.width };
    };

    useLayoutEffect(() => {
        const m = measure(activeIndex);
        if (m) setPill({ ...m, ready: true });
    }, [activeIndex]);

    useEffect(() => {
        const onResize = () => {
            const m = measure(activeIndex);
            if (m) setPill({ ...m, ready: true });
        };
        window.addEventListener("resize", onResize);
        return () => window.removeEventListener("resize", onResize);
    }, [activeIndex]);

    // Drag handlers (iOS only)
    const onPointerDown = (e) => {
        if (!isIOS) return;
        dragState.current = {
            active: true,
            startX: e.clientX,
            startLeft: pill.left,
        };
        setDragX(pill.left);
        e.currentTarget.setPointerCapture?.(e.pointerId);
    };
    const onPointerMove = (e) => {
        if (!dragState.current.active) return;
        const dx = e.clientX - dragState.current.startX;
        const parent = navRef.current;
        if (!parent) return;
        const max = parent.clientWidth - pill.width;
        const next = Math.max(0, Math.min(max, dragState.current.startLeft + dx));
        setDragX(next);
    };
    const onPointerUp = () => {
        if (!dragState.current.active) return;
        dragState.current.active = false;
        // Snap to nearest tab center
        const center = (dragX ?? pill.left) + pill.width / 2;
        let bestIdx = 0;
        let bestDist = Infinity;
        for (let i = 0; i < tabs.length; i++) {
            const m = measure(i);
            if (!m) continue;
            const c = m.left + m.width / 2;
            const d = Math.abs(c - center);
            if (d < bestDist) { bestDist = d; bestIdx = i; }
        }
        setDragX(null);
        const target = tabs[bestIdx];
        if (target.path === "__more__") {
            // Trigger More menu via custom event
            window.dispatchEvent(new CustomEvent("open-mobile-more"));
        } else if (target.path !== location.pathname) {
            navigate(target.path);
        }
    };

    const pillLeft = dragX ?? pill.left;

    return (<>
      {/* Top Header - Stats */}
      <header className="fixed top-0 left-0 right-0 z-50 lg:hidden bg-card border-b border-border">
        <div className="flex items-center justify-between px-4 h-14">
          <Link to="/profile" className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-full bg-primary/10 border-2 border-primary flex items-center justify-center overflow-hidden">
              {profile?.avatar_url ?
            <img src={profile.avatar_url} alt="Avatar" className="w-full h-full object-cover"/> :
            <span className="text-xs font-bold text-primary">
                  {profile?.display_name?.[0] || "U"}
                </span>}
            </div>
          </Link>

          <div className="flex items-center gap-4" data-tour="mobile-stats">
            <StreakPopover streak={streak}/>
            <div className="flex items-center gap-1 text-golden font-bold text-sm">
              <Gem className="w-5 h-5 border-inherit text-sky-500"/>
              <span className="text-secondary">{gems.toLocaleString()}</span>
            </div>
            <HeartTimerPopover hearts={hearts} compact/>
          </div>
        </div>
      </header>

      {/* Bottom Navigation - floating glass bar */}
      {typeof document !== "undefined" &&
            createPortal(
              <div
                className="fixed inset-x-0 bottom-0 z-50 lg:hidden pointer-events-none"
                style={{ paddingBottom: "calc(env(safe-area-inset-bottom, 0px) + 12px)" }}
                aria-hidden={false}
              >
                {/* Soft blur veil for the gap under the bar so attention isn't drawn there */}
                <div
                  className="absolute inset-x-0 bottom-0 h-24 pointer-events-none"
                  style={{
                    backdropFilter: "blur(14px) saturate(140%)",
                    WebkitBackdropFilter: "blur(14px) saturate(140%)",
                    maskImage: "linear-gradient(to top, black 35%, transparent 100%)",
                    WebkitMaskImage: "linear-gradient(to top, black 35%, transparent 100%)",
                  }}
                />

                <nav
                  ref={navRef}
                  aria-label="Bottom navigation"
                  className={cn(
                    "pointer-events-auto relative mx-auto flex items-center justify-around",
                    "h-[72px] px-2 rounded-[28px]",
                    "w-[calc(100%-24px)] max-w-[440px]",
                    isIOS ? "ios-liquid-glass" : "bg-card/95 border border-border shadow-lg",
                  )}
                >
                  {/* Sliding glass pill indicator */}
                  {pill.ready && (
                    <div
                      onPointerDown={onPointerDown}
                      onPointerMove={onPointerMove}
                      onPointerUp={onPointerUp}
                      onPointerCancel={onPointerUp}
                      className={cn(
                        "absolute top-1/2 -translate-y-1/2 rounded-[22px] touch-none",
                        isIOS ? "ios-glass-pill" : "bg-primary/15 border border-primary/30",
                      )}
                      style={{
                        left: pillLeft,
                        width: pill.width,
                        height: 56,
                        transition: dragX === null ? "left 280ms cubic-bezier(0.22,1,0.36,1)" : "none",
                      }}
                    />
                  )}

                  {navItems.map((item, idx) => {
                      const isActive = location.pathname === item.path;
                      return (
                        <Link
                          key={item.path}
                          to={item.path}
                          ref={(el) => (itemRefs.current[idx] = el)}
                          data-tour={`mobile-${item.label.toLowerCase()}`}
                          className={cn(
                            "relative z-10 flex flex-col items-center justify-center gap-0.5 px-3 h-full rounded-[22px] transition-colors flex-1",
                            isActive ? "text-primary" : "text-muted-foreground hover:text-foreground",
                          )}
                        >
                          <item.icon className={cn("w-[22px] h-[22px]", isActive && "fill-primary/15")}/>
                          <span className="text-[11px] font-semibold leading-tight">{item.label}</span>
                        </Link>
                      );
                  })}
                  <div
                    ref={(el) => (itemRefs.current[navItems.length] = el)}
                    data-tour="mobile-more"
                    className="relative z-10 flex-1 h-full flex items-center justify-center"
                  >
                    <MobileMoreMenu />
                  </div>
                </nav>
              </div>,
              document.body)}
    </>);
}
