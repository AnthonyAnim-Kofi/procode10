import { LanguageIcon } from "@/components/LanguageIcon";

/** Consistent language row for Select dropdowns (learner + admin). */
export function LanguageSelectItem({ slug, icon, name, size = 20 }) {
    return (
        <span className="flex items-center gap-2">
            <LanguageIcon slug={slug} icon={icon} size={size} className="shrink-0" />
            <span>{name}</span>
        </span>
    );
}
