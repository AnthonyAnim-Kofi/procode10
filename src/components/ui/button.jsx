import * as React from "react";
import { Slot } from "@radix-ui/react-slot";
import { cva } from "class-variance-authority";
import { cn } from "@/lib/utils";
const buttonVariants = cva("inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-semibold ring-offset-background transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0 tracking-normal", {
    variants: {
        variant: {
            default: "bg-primary text-primary-foreground hover:bg-primary/90 btn-primary-shadow",
            destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90 btn-destructive-shadow",
            outline: "border border-border bg-background hover:bg-muted text-foreground btn-outline-shadow",
            secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/90 btn-secondary-shadow",
            ghost: "hover:bg-muted hover:text-foreground",
            link: "text-primary underline-offset-4 hover:underline",
            premium: "bg-premium text-premium-foreground hover:bg-premium/90",
            golden: "bg-golden text-golden-foreground hover:bg-golden/90",
            super: "bg-gradient-to-r from-primary to-[hsl(160,60%,32%)] text-primary-foreground hover:opacity-95",
            locked: "bg-muted text-muted-foreground cursor-not-allowed",
        },
        size: {
            default: "h-11 px-5 py-2",
            sm: "h-9 rounded-md px-4",
            lg: "h-12 rounded-md px-7 text-base",
            xl: "h-14 rounded-md px-8 text-base",
            icon: "h-11 w-11 rounded-md",
            rounded: "h-14 w-14 rounded-full",
        },
    },
    defaultVariants: {
        variant: "default",
        size: "default",
    },
});
const Button = React.forwardRef(({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button";
    return (<Comp className={cn(buttonVariants({ variant, size, className }))} ref={ref} {...props}/>);
});
Button.displayName = "Button";
export { Button, buttonVariants };
