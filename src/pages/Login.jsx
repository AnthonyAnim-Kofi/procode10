import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import authSide from "@/assets/auth-side.jpg";
import { Code2, Mail, Lock, ArrowRight, Loader2 } from "lucide-react";

export default function Login() {
    const { signIn } = useAuth();
    const navigate = useNavigate();
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(false);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError("");
        setLoading(true);
        const { error } = await signIn(email, password);
        if (error) {
            setError(error.message);
            setLoading(false);
        } else {
            navigate("/learn");
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
                        <span className="text-lg font-bold tracking-tight">CodeBear</span>
                    </Link>
                    <blockquote className="max-w-md">
                        <p className="text-xl font-medium leading-snug mb-3 tracking-tight">
                            "Clarity over cleverness. A quiet desk and the right problem — that's where
                            real learning happens."
                        </p>
                        <footer className="text-sm text-primary-foreground/80">— CodeBear</footer>
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
                        <span className="text-lg font-bold text-foreground tracking-tight">CodeBear</span>
                    </Link>
                </header>

                <div className="flex-1 flex items-center justify-center p-6">
                    <div className="w-full max-w-sm">
                        <div className="lg:hidden flex justify-center mb-6">
                            <img
                                src="/apple-touch-icon.png"
                                alt="CodeBear logo"
                                className="w-20 h-20 rounded-2xl shadow-md"
                            />
                        </div>
                        <h1 className="text-3xl font-bold text-foreground tracking-tight mb-2 lg:text-left text-center">
                            Sign in to your account
                        </h1>
                        <p className="text-muted-foreground mb-8 text-sm lg:text-left text-center">
                            Continue your learning where you left off.
                        </p>


                        <form onSubmit={handleSubmit} className="space-y-5">
                            <div className="space-y-2">
                                <Label htmlFor="email">Email</Label>
                                <div className="relative">
                                    <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                    <Input
                                        id="email"
                                        type="email"
                                        placeholder="you@example.com"
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                        className="pl-9 h-11"
                                        required
                                    />
                                </div>
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="password">Password</Label>
                                <div className="relative">
                                    <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                    <Input
                                        id="password"
                                        type="password"
                                        placeholder="••••••••"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                        className="pl-9 h-11"
                                        required
                                    />
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
                                        Sign in
                                        <ArrowRight className="w-4 h-4" />
                                    </>
                                )}
                            </Button>
                        </form>

                        <div className="mt-8 space-y-1.5 text-center text-sm">
                            <p className="text-muted-foreground">
                                New here?{" "}
                                <Link to="/signup" className="text-primary font-semibold hover:underline">
                                    Create an account
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
