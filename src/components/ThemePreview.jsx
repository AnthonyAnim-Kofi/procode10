import { THEMES } from "@/components/ThemeContext";
import { Heart, Flame, Gem } from "lucide-react";

/**
 * ThemePreview – live preview of a theme palette before the user commits.
 * Renders a self-contained card with the target theme class applied so the
 * shadcn CSS variables resolve to that theme's tokens without affecting the
 * rest of the page.
 */
export function ThemePreview({ themeId }) {
  const theme = THEMES.find((t) => t.id === themeId) || THEMES[0];
  return (
    <div className={`${theme.className} rounded-xl border border-border overflow-hidden`}>
      <div className="bg-background p-4 space-y-3">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-[11px] uppercase tracking-wider text-muted-foreground">Preview</p>
            <p className="text-sm font-bold text-foreground">{theme.name}</p>
          </div>
          <div className="flex items-center gap-2 text-foreground">
            <span className="inline-flex items-center gap-1 text-xs font-semibold"><Flame className="w-3.5 h-3.5 text-primary" />7</span>
            <span className="inline-flex items-center gap-1 text-xs font-semibold"><Heart className="w-3.5 h-3.5 text-destructive" />5</span>
            <span className="inline-flex items-center gap-1 text-xs font-semibold"><Gem className="w-3.5 h-3.5 text-secondary" />420</span>
          </div>
        </div>

        <div className="bg-card border border-border rounded-lg p-3">
          <p className="text-xs font-semibold text-card-foreground mb-2">Sample lesson card</p>
          <div className="flex gap-2">
            <span className="inline-flex items-center justify-center text-xs font-bold px-2.5 py-1 rounded-md bg-primary text-primary-foreground">Continue</span>
            <span className="inline-flex items-center justify-center text-xs font-bold px-2.5 py-1 rounded-md bg-secondary text-secondary-foreground">Notes</span>
            <span className="inline-flex items-center justify-center text-xs font-bold px-2.5 py-1 rounded-md border border-border text-foreground">Skip</span>
          </div>
        </div>

        <div className="flex gap-1">
          {theme.swatches.map((c) => (
            <span key={c} className="h-3 flex-1 rounded-full border border-black/10" style={{ background: c }} />
          ))}
        </div>
      </div>
    </div>
  );
}
