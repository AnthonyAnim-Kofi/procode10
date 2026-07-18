import { useState } from "react";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import authSide from "@/assets/auth-side.jpg";
import { Code2, Mail, Lock, ArrowRight, Loader2, Gift, Check } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { THEMES } from "@/components/ThemeContext";
import { ThemePreview } from "@/components/ThemePreview";

export default function Signup() {
    const { signUp } = useAuth();
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const [referralCode, setReferralCode] = useState(searchParams.get("ref") ?? "");
    const [codingExperience, setCodingExperience] = useState("beginner");
    const [themePreference, setThemePreference] = useState("emerald");
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(false);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError("");
        if (password !== confirmPassword) {
            setError("Passwords don't match");
            return;
        }
        if (password.length < 6) {
            setError("Password must be at least 6 characters");
            return;
        }
        const codeToUse = referralCode.trim().toUpperCase();
        if (codeToUse) {
            const { data: valid, error: rpcError } = await supabase.rpc("validate_referral_code", {
                code: codeToUse,
            });
            if (rpcError || !valid) {
                setError("Invalid referral code. Please check and try again or leave it blank.");
                return;
            }
        }
        setLoading(true);
        const { error } = await signUp(email, password, { coding_experience: codingExperience, theme_preference: themePreference });
        if (error) {
            setError(error.message);
            setLoading(false);
        } else {
            const target = codeToUse ? `/onboarding?ref=${encodeURIComponent(codeToUse)}` : "/onboarding";
            navigate(target);
        }
    };

    return (
        <div className="min-h-screen grid lg:grid-cols-2 bg-background">
            {/* Left: image (desktop only) */}
            <aside className="hidden lg:block relative">
                <img
                    src={authSide}
                    alt="A laptop, notebook, and lamp on a writer's desk"
                    className="absolute inset-0 w-full h-full object-cover"
                />
                <div className="absolute inset-0 bg-gradient-to-tr from-primary/40 via-primary/10 to-transparent" />
                <div className="relative h-full flex flex-col justify-between p-10 text-primary-foreground">
                    <Link to="/" className="flex items-center gap-2.5 w-fit">
                        <div className="flex items-center justify-center w-9 h-9 rounded-md bg-primary-foreground/15 backdrop-blur">
                            <Code2 className="w-5 h-5" />
                        </div>
                        <span className="text-lg font-bold tracking-tight">ProCode</span>
                    </Link>
                    <blockquote className="max-w-md">
                        <p className="text-xl font-medium leading-snug mb-3 tracking-tight">
                            "Begin with the fundamentals. Compound them daily. In a year you will have built
                            something you're proud of."
                        </p>
                        <footer className="text-sm text-primary-foreground/80">— ProCode</footer>
                    </blockquote>
                </div>
            </aside>

            {/* Right: form */}
            <main className="flex flex-col">
                <header className="p-5 lg:hidden">
                    <Link to="/" className="flex items-center gap-2.5 w-fit">
                        <div className="flex items-center justify-center w-9 h-9 rounded-md bg-primary">
                            <Code2 className="w-5 h-5 text-primary-foreground" />
                        </div>
                        <span className="text-lg font-bold text-foreground tracking-tight">ProCode</span>
                    </Link>
                </header>

                <div className="flex-1 flex items-center justify-center p-6 py-10">
                    <div className="w-full max-w-sm">
                        <h1 className="text-3xl font-bold text-foreground tracking-tight mb-2">
                            Create your account
                        </h1>
                        <p className="text-muted-foreground mb-8 text-sm">
                            Start a structured path toward real programming skill.
                        </p>

                        <form onSubmit={handleSubmit} className="space-y-4">
                            <div className="space-y-2">
                                <Label htmlFor="email">Email</Label>
                                <div className="relative">
                                    <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                    <Input id="email" type="email" placeholder="you@example.com" value={email} onChange={(e) => setEmail(e.target.value)} className="pl-9 h-11" required />
                                </div>
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="password">Password</Label>
                                <div className="relative">
                                    <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                    <Input id="password" type="password" placeholder="••••••••" value={password} onChange={(e) => setPassword(e.target.value)} className="pl-9 h-11" required />
                                </div>
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="confirmPassword">Confirm password</Label>
                                <div className="relative">
                                    <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                    <Input id="confirmPassword" type="password" placeholder="••••••••" value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)} className="pl-9 h-11" required />
                                </div>
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="codingExperience">Experience level</Label>
                                <Select value={codingExperience} onValueChange={setCodingExperience}>
                                    <SelectTrigger className="w-full h-11 bg-background">
                                        <SelectValue placeholder="Select your experience" />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="beginner">Beginner — guided pace</SelectItem>
                                        <SelectItem value="intermediate">Intermediate — flexible order</SelectItem>
                                        <SelectItem value="advanced">Advanced — full access</SelectItem>
                                    </SelectContent>
                                </Select>
                            </div>

                            <div className="space-y-2">
                                <Label>Appearance theme</Label>
                                <div className="grid grid-cols-2 gap-2">
                                    {THEMES.map((t) => {
                                        const active = themePreference === t.id;
                                        return (
                                            <button
                                                key={t.id}
                                                type="button"
                                                onClick={() => setThemePreference(t.id)}
                                                className={`relative rounded-lg border-2 p-2 text-left transition-all ${active ? "border-primary ring-2 ring-primary/30" : "border-border hover:border-primary/40"}`}
                                            >
                                                <div className="flex gap-1 mb-1.5">
                                                    {t.swatches.map((c) => (
                                                        <span key={c} className="h-4 flex-1 rounded-sm border border-black/5" style={{ background: c }} />
                                                    ))}
                                                </div>
                                                <span className="text-xs font-semibold text-foreground">{t.name}</span>
                                                {active && (
                                                    <span className="absolute top-1.5 right-1.5 inline-flex items-center justify-center w-4 h-4 rounded-full bg-primary text-primary-foreground">
                                                        <Check className="w-2.5 h-2.5" />
                                                    </span>
                                                )}
                                            </button>
                                        );
                                    })}
                                </div>
                                <ThemePreview themeId={themePreference} />
                            </div>


                            <div className="space-y-2">
                                <Label htmlFor="referralCode" className="text-muted-foreground font-normal">
                                    Referral code <span className="text-xs">(optional)</span>
                                </Label>
                                <div className="relative">
                                    <Gift className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                    <Input id="referralCode" type="text" placeholder="e.g. ABC12DEF" value={referralCode} onChange={(e) => setReferralCode(e.target.value)} className="pl-9 h-11 font-mono uppercase" maxLength={12} />
                                </div>
                            </div>

                            {error && (
                                <p className="text-sm text-destructive bg-destructive/10 px-3 py-2 rounded-md">
                                    {error}
                                </p>
                            )}

                            <Button type="submit" size="lg" className="w-full" disabled={loading}>
                                {loading ? (
                                    <Loader2 className="w-4 h-4 animate-spin" />
                                ) : (
                                    <>
                                        Create account
                                        <ArrowRight className="w-4 h-4" />
                                    </>
                                )}
                            </Button>
                        </form>

                        <div className="mt-8 space-y-1.5 text-center text-sm">
                            <p className="text-muted-foreground">
                                Already have an account?{" "}
                                <Link to="/login" className="text-primary font-semibold hover:underline">
                                    Sign in
                                </Link>
                            </p>
                            <p className="text-muted-foreground">
                                Admin?{" "}
                                <Link to="/admin/login" className="text-primary font-semibold hover:underline">
                                    Admin sign in
                                </Link>
                            </p>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    );
}
