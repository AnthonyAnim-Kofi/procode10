import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Code2, ArrowRight, GraduationCap, BookOpen, LineChart, Play } from "lucide-react";
import heroCoding from "@/assets/hero-coding.jpg";
import { useLanguages } from "@/hooks/useLanguages";
import { LanguageIcon } from "@/components/LanguageIcon";

const features = [
    {
        icon: GraduationCap,
        title: "Structured curriculum",
        description:
            "A coherent path from fundamentals to advanced topics, designed with the rigor of a university course.",
    },
    {
        icon: BookOpen,
        title: "Practice that mirrors real work",
        description:
            "Hands-on exercises and a fully featured playground — write, run, and reason about code in the browser.",
    },
    {
        icon: LineChart,
        title: "Measurable progress",
        description:
            "Skill tracking, performance analytics, and review tools that help you see what you actually understand.",
    },
];

const fallbackLanguages = [
    { name: "Python", slug: "python", icon: "🐍" },
    { name: "JavaScript", slug: "javascript", icon: "⚡" },
    { name: "TypeScript", slug: "typescript", icon: "📘" },
    { name: "Rust", slug: "rust", icon: "🦀" },
    { name: "Go", slug: "go", icon: "🐹" },
    { name: "Java", slug: "java", icon: "☕" },
    { name: "C++", slug: "cpp", icon: "➕" },
    { name: "Swift", slug: "swift", icon: "🦅" },
];

export default function Landing() {
    const { data: dbLanguages = [] } = useLanguages();
    const languages =
        dbLanguages.length > 0
            ? dbLanguages.map((l) => ({ name: l.name, slug: l.slug, icon: l.icon }))
            : fallbackLanguages;

    return (
        <div className="min-h-screen bg-background">
            {/* Header */}
            <header className="fixed top-0 left-0 right-0 z-50 bg-background/85 backdrop-blur-md border-b border-border">
                <div className="container mx-auto px-4">
                    <div className="flex items-center justify-between h-16">
                        <Link to="/" className="flex items-center gap-2.5">
                            <div className="flex items-center justify-center w-9 h-9 rounded-md bg-primary">
                                <Code2 className="w-5 h-5 text-primary-foreground" />
                            </div>
                            <span className="text-lg font-bold text-foreground tracking-tight">ProCode</span>
                        </Link>

                        <div className="flex items-center gap-2 sm:gap-3">
                            <Button variant="ghost" size="sm" asChild>
                                <Link to="/login">Sign in</Link>
                            </Button>
                            <Button size="sm" asChild>
                                <Link to="/signup">Get started</Link>
                            </Button>
                        </div>
                    </div>
                </div>
            </header>

            {/* Hero — split layout, no mascot */}
            <section className="pt-28 pb-16 lg:pt-36 lg:pb-24 bg-gradient-hero">
                <div className="container mx-auto px-4">
                    <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
                        <div className="max-w-xl">
                            <span className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-semibold tracking-wide uppercase mb-6">
                                For serious learners
                            </span>
                            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-bold text-foreground leading-[1.05] tracking-tight mb-6">
                                A modern way to learn programming, built for{" "}
                                <span className="text-gradient-primary">depth</span>.
                            </h1>
                            <p className="text-lg text-muted-foreground mb-8 leading-relaxed">
                                ProCode is a focused learning environment for university students,
                                career-changers, and working developers. Structured lessons, rigorous
                                practice, and an integrated playground — without the noise.
                            </p>
                            <div className="flex flex-col sm:flex-row gap-3">
                                <Button size="lg" asChild>
                                    <Link to="/signup">
                                        Start learning
                                        <ArrowRight className="w-4 h-4" />
                                    </Link>
                                </Button>
                                <Button size="lg" variant="outline" asChild>
                                    <Link to="/login">Sign in</Link>
                                </Button>
                            </div>
                        </div>

                        <div className="relative">
                            <div className="absolute -inset-4 bg-primary/10 rounded-2xl -rotate-1" />
                            <img
                                src={heroCoding}
                                alt="A student writing code on a laptop"
                                width={1536}
                                height={1024}
                                className="relative w-full h-auto rounded-2xl object-cover shadow-xl"
                            />
                        </div>
                    </div>
                </div>
            </section>

            {/* Video section — placeholder for user-provided coding video */}
            <section className="py-20 bg-card">
                <div className="container mx-auto px-4">
                    <div className="max-w-3xl mx-auto text-center mb-10">
                        <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-4 tracking-tight">
                            See ProCode in motion
                        </h2>
                        <p className="text-muted-foreground text-lg">
                            A short walkthrough of what learning on the platform actually looks like.
                        </p>
                    </div>

                    {/* 16:9 video placeholder — drop your <video> or <iframe> source in here */}
                    <div className="max-w-5xl mx-auto">
                        <div
                            data-landing-video-slot
                            className="relative aspect-video rounded-2xl border border-border bg-muted overflow-hidden group"
                        >
                            <div className="absolute inset-0 bg-gradient-to-br from-primary/10 via-transparent to-secondary/10" />
                            <div className="absolute inset-0 flex flex-col items-center justify-center gap-3 text-center px-6">
                                <div className="w-20 h-20 rounded-full bg-primary text-primary-foreground flex items-center justify-center shadow-lg transition-transform group-hover:scale-105">
                                    <Play className="w-8 h-8 ml-1" fill="currentColor" />
                                </div>
                                <p className="text-sm font-semibold text-foreground">Video coming soon</p>
                                <p className="text-xs text-muted-foreground max-w-sm">
                                    Replace this block with your <code className="font-mono">&lt;video&gt;</code> or
                                    embed (YouTube / Vimeo).
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Languages */}
            <section className="py-20">
                <div className="container mx-auto px-4">
                    <div className="max-w-2xl mx-auto text-center mb-12">
                        <h2 className="text-3xl font-bold text-foreground mb-3 tracking-tight">
                            Languages you'll actually use
                        </h2>
                        <p className="text-muted-foreground">
                            Curriculum across the languages that drive modern software, infrastructure, and
                            research.
                        </p>
                    </div>
                    <div className="flex flex-wrap justify-center gap-3 max-w-4xl mx-auto">
                        {languages.map((lang) => (
                            <div
                                key={lang.slug || lang.name}
                                className="flex items-center gap-2.5 px-4 py-2.5 bg-card rounded-md border border-border hover:border-primary/40 hover:shadow-sm transition-all"
                            >
                                <LanguageIcon slug={lang.slug} icon={lang.icon} size={22} />
                                <span className="font-medium text-foreground text-sm">{lang.name}</span>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Features */}
            <section className="py-20 bg-muted/40 border-y border-border">
                <div className="container mx-auto px-4">
                    <div className="max-w-2xl mx-auto text-center mb-14">
                        <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-4 tracking-tight">
                            Designed for people who want to actually learn
                        </h2>
                        <p className="text-muted-foreground text-lg">
                            No gimmicks. A clean environment, well-paced material, and tools that respect
                            your time.
                        </p>
                    </div>

                    <div className="grid md:grid-cols-3 gap-6 max-w-5xl mx-auto">
                        {features.map((feature, i) => (
                            <div
                                key={i}
                                className="p-7 bg-card rounded-xl border border-border hover:border-primary/30 transition-colors"
                            >
                                <div className="w-11 h-11 mb-5 rounded-md bg-primary/10 flex items-center justify-center">
                                    <feature.icon className="w-5 h-5 text-primary" />
                                </div>
                                <h3 className="text-lg font-semibold text-foreground mb-2 tracking-tight">
                                    {feature.title}
                                </h3>
                                <p className="text-muted-foreground text-sm leading-relaxed">
                                    {feature.description}
                                </p>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* CTA */}
            <section className="py-24 bg-primary">
                <div className="container mx-auto px-4 text-center max-w-2xl">
                    <h2 className="text-3xl lg:text-4xl font-bold text-primary-foreground mb-4 tracking-tight">
                        Begin your study program today
                    </h2>
                    <p className="text-primary-foreground/80 mb-8 text-lg">
                        Free to start. Build a portfolio of work as you go.
                    </p>
                    <Button size="lg" variant="golden" asChild>
                        <Link to="/signup">
                            Create your account
                            <ArrowRight className="w-4 h-4" />
                        </Link>
                    </Button>
                </div>
            </section>

            {/* Footer */}
            <footer className="py-10 bg-sidebar">
                <div className="container mx-auto px-4">
                    <div className="flex flex-col md:flex-row items-center justify-between gap-4">
                        <div className="flex items-center gap-2">
                            <div className="flex items-center justify-center w-8 h-8 rounded-md bg-sidebar-primary">
                                <Code2 className="w-4 h-4 text-sidebar-primary-foreground" />
                            </div>
                            <span className="font-semibold text-sidebar-foreground">ProCode</span>
                        </div>
                        <p className="text-sm text-sidebar-foreground/70">
                            © 2026 ProCode. A focused environment for learning to code.
                        </p>
                    </div>
                </div>
            </footer>
        </div>
    );
}
