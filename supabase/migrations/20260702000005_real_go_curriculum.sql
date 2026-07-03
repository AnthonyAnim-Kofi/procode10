-- ============================================================
-- REAL GO CURRICULUM
-- Postgres escaping rules applied throughout:
--   Single quotes inside $$ dollar-quoted blocks are safe as-is.
--   Inside jsonb literals (options): " -> \" and ' -> ''
--   We use $$ dollar-quoting for all note blocks.
-- Structure: 6 units · 4 lessons · 5 questions each
-- ============================================================

DO $$
DECLARE
  v_lang_id   uuid;
  v_unit_id   uuid;
  v_lesson_id uuid;
BEGIN

  -- Prefer slug 'go' (used by the app); fall back to 'golang' if present.
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug IN ('go', 'golang')
  ORDER BY CASE WHEN slug = 'go' THEN 0 ELSE 1 END
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('Go', 'go', '🐹', 'An open-source, compiled language designed by Google for simplicity, performance, and concurrency.')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with Go
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Learn Go project structure, variables, and formatting', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to Go', $note$
# Introduction to Go

Go (often called Golang) is a statically typed, compiled programming language designed at Google. It focuses on simplicity, reliability, and high performance.

## Your First Program

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}

```
Breaking it down:
 * package main — Tells the Go compiler this file should compile as an executable, not a shared library.
 * import "fmt" — Imports the "format" package for printing text.
 * func main() — The entry point of the application.
 * fmt.Println(...) — Prints to the console with a new line.
## Variables and Types
Go provides multiple ways to declare variables.
```go
// Standard declaration (requires var keyword)
var age int = 25
var name string = "Alice"

// Type inference (omits the type)
var score = 100

// Short Variable Declaration (used INSIDE functions)
// := declares and assigns the variable automatically.
isActive := true
price := 19.99 // Inferred as float64

```
## Formatted Output (Printf)
fmt.Printf gives you control over how text and variables are combined using "verbs" (format specifiers):
```go
name := "Bob"
age := 30
// %s is for strings, %d is for integers, %v is for ANY value (default format)
fmt.Printf("My name is %s and I am %d years old\n", name, age)
fmt.Printf("Use %%v when you are not sure: %v\n", isActive)

```
## Constants
Constants are declared like variables but with the const keyword. They cannot be changed once declared.
```go
const pi = 3.14159

```
## Key Takeaways
 * Every executable Go program needs package main and a func main().
 * Use := for quick, clean variable declarations inside functions.
 * fmt.Printf uses %v as a "magic" placeholder for any variable type.
 * The standard tool gofmt automatically formats your code to standard Go style.
   $note$, 0);
   -- Lesson 1.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Hello, Go!', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What must an executable Go program start with to define its entry point file?',
   '0',
   '["package main","package go","include main","import main"]'::jsonb,
   'The Go compiler specifically looks for package main to know it should create an executable program.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the import statement for the package used to print text:',
   'import "___"',
   'fmt',
   '["fmt","print","console","io"]'::jsonb,
   'The "fmt" (format) package implements formatted I/O.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the name of the function where a Go program begins execution?',
   '0',
   '["func main()","func start()","public static void main()","func run()"]'::jsonb,
   'Just like C or C++, Go programs start executing from main().',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the lines to create a minimal Hello World program:',
   '[{"id":"1","code":"package main"},{"id":"2","code":"import \"fmt\""},{"id":"3","code":"func main() {"},{"id":"4","code":"  fmt.Println(\"Hello\")"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["package main","import \"fmt\"","func main() {","  fmt.Println(\"Hello\")","}"]'::jsonb,
   'Package first, then import, then func main, then print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write a Go program that prints: Hello Go',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Write your code here' || chr(10) || '}',
   'Hello Go',
   'fmt.Println("Hello Go")',
   5, 20);
   -- Lesson 1.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Variables and Short Declarations', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which operator is used for the "short variable declaration" in Go?',
   '0',
   '[":=","=","->","=="]'::jsonb,
   ':= declares and initializes a variable in one step, inferring its type automatically.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the standard variable declaration with an explicit type:',
   '___ count int = 10',
   'var',
   '["var","let","int","val"]'::jsonb,
   'The var keyword is used when you want to explicitly state the type, or declare a variable outside a function.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you declare a variable in Go but never use it?',
   '0',
   '["The Go compiler throws a compile-time error and refuses to compile","It is ignored","It prints a warning but compiles","It becomes nil"]'::jsonb,
   'Go is very strict about unused variables and imports to keep code clean and fast. Unused variables cause a compilation failure.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to declare a name and age, then print them:',
   '[{"id":"1","code":"func main() {"},{"id":"2","code":"  name := \"Alice\""},{"id":"3","code":"  age := 20"},{"id":"4","code":"  fmt.Println(name, age)"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["func main() {","  name := \"Alice\"","  age := 20","  fmt.Println(name, age)","}"]'::jsonb,
   'Open main, declare string, declare int, print, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use := to create a variable score set to 99, and print it.',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Declare and print' || chr(10) || '}',
   '99',
   'score := 99' || chr(10) || 'fmt.Println(score)',
   5, 20);
   -- Lesson 1.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Formatted Output', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which function allows you to format strings using "verbs" like %s and %d?',
   '0',
   '["fmt.Printf","fmt.Println","fmt.Format","fmt.Print"]'::jsonb,
   'Printf stands for "Print Formatted". Note that it does NOT add a newline automatically.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the generic placeholder (verb) that prints any value in its default format:',
   'fmt.Printf("Value is: ___\n", myVar)',
   '%v',
   '["%v","%d","%s","%any"]'::jsonb,
   '%v (value) is incredibly useful when you don''t want to worry about exactly what type the variable is.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you print a literal percent sign % when using Printf?',
   '0',
   '["By using %%","By using \\%","By typing %","By using percent"]'::jsonb,
   'In Go''s format strings, %% escapes the percent symbol so it prints a single %.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to print formatted data:',
   '[{"id":"1","code":"func main() {"},{"id":"2","code":"  item := \"Coffee\""},{"id":"3","code":"  price := 2.50"},{"id":"4","code":"  fmt.Printf(\"%s costs $%.2f\\n\", item, price)"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["func main() {","  item := \"Coffee\"","  price := 2.50","  fmt.Printf(\"%s costs $%.2f\\n\", item, price)","}"]'::jsonb,
   'Open main, declare string, declare float, print formatted, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use fmt.Printf to print "ID: 7" using the variable id = 7. Do not forget \n.',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    id := 7' || chr(10) || '    // Use Printf' || chr(10) || '}',
   'ID: 7',
   'fmt.Printf("ID: %d\n", id)',
   5, 20);
   -- Lesson 1.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Constants', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you use the := shorthand operator to declare a constant?',
   '0',
   '["No, constants must be declared with the const keyword","Yes, := works for constants too","Yes, but only for strings","Yes, but only outside functions"]'::jsonb,
   'const pi = 3.14 is required. pi := 3.14 creates a variable.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the declaration of an untyped constant:',
   '___ MaxSpeed = 120',
   'const',
   '["const","var","let","final"]'::jsonb,
   'The const keyword declares a constant value.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you try to modify a constant after declaring it?',
   '0',
   '["The compiler will throw an error","It modifies the constant successfully","It creates a new variable with the same name","The program crashes at runtime"]'::jsonb,
   'Constants are checked at compile-time. Attempting to assign a new value to a constant fails compilation.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to define and print a constant:',
   '[{"id":"1","code":"func main() {"},{"id":"2","code":"  const status = \"OK\""},{"id":"3","code":"  fmt.Println(status)"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["func main() {","  const status = \"OK\"","  fmt.Println(status)","}"]'::jsonb,
   'main func open, const declaration, print, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Declare a constant Gravity set to 9.8 and print it.',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Declare const and print' || chr(10) || '}',
   '9.8',
   'const Gravity = 9.8' || chr(10) || 'fmt.Println(Gravity)',
   5, 20);
   -- ==============================================================
   -- UNIT 2: Control Flow
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 2: Control Flow', 'Make decisions and repeat code with if, for, switch, and defer', 'green', 2)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Control Flow in Go', $note$
# Control Flow in Go
Go simplifies control flow. There are no parentheses () required around conditions, and for is the *only* looping construct.
## if / else
Parentheses are omitted, but curly braces {} are **mandatory**.
```go
score := 85

if score >= 90 {
    fmt.Println("A")
} else if score >= 80 {
    fmt.Println("B")
} else {
    fmt.Println("F")
}

```
**Initialization statement:**
Go allows you to execute a short statement before the condition. The variable is scoped *only* to the if/else block!
```go
if n := 10; n % 2 == 0 {
    fmt.Println(n, "is even")
}
// 'n' does not exist here!

```
## The "for" Loop
Go has no while loop. The for loop does everything.
```go
// Standard C-style for loop
for i := 0; i < 3; i++ {
    fmt.Println(i)
}

// "While" style loop (only a condition)
count := 0
for count < 3 {
    count++
}

// Infinite loop
for {
    break // you need this to stop!
}

```
## switch Statements
Go's switch is safer than other languages: it does **not** fall through to the next case by default. You do not need break statements!
```go
day := "Mon"
switch day {
case "Mon", "Tue":
    fmt.Println("Weekday")
case "Sat", "Sun":
    fmt.Println("Weekend")
default:
    fmt.Println("Unknown")
}

```
## defer
A defer statement defers the execution of a function until the surrounding function returns. It's often used to close files or connections.
```go
func main() {
    defer fmt.Println("World")
    fmt.Println("Hello")
}
// Prints:
// Hello
// World

```
## Key Takeaways
 * No parentheses around conditions in if, for, or switch.
 * for is the only loop in Go.
 * switch does not fall through automatically.
 * defer delays execution until the end of the function.
   $note$, 0);
   -- Lesson 2.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'If/Else Statements', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is grammatically different about if conditions in Go compared to C, C++, or Java?',
   '0',
   '["Parentheses around the condition are not required (and generally discouraged)","Braces {} are optional","The condition must be an integer","You must use the then keyword"]'::jsonb,
   'if x > 5 { ... } is the correct syntax in Go. Braces {} are always required.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the if-statement that initializes a variable and tests it in one line:',
   'if val ___ 50; val > 10 { fmt.Println("Big") }',
   ':=',
   '[":=","=","==","var"]'::jsonb,
   'Go allows an initialization statement val := 50 before the boolean condition val > 10.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If you declare a variable in the initialization statement of an if block, where is it accessible?',
   '0',
   '["Only inside the if block and its corresponding else if / else blocks","Anywhere in the function","Anywhere in the package","Only inside the true block"]'::jsonb,
   'This is called block scope. It keeps your functions clean and prevents variable leakage.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange to check if temperature is below freezing:',
   '[{"id":"1","code":"temp := -2"},{"id":"2","code":"if temp <= 0 {"},{"id":"3","code":"  fmt.Println(\"Freezing\")"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["temp := -2","if temp <= 0 {","  fmt.Println(\"Freezing\")","}"]'::jsonb,
   'Declare, open if without parens, print, close if.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print "Even" if num = 8 is divisible by 2, else print "Odd". Expected: Even',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    num := 8' || chr(10) || '    // Write if/else' || chr(10) || '}',
   'Even',
   'if num % 2 == 0 { fmt.Println("Even") } else { fmt.Println("Odd") }',
   5, 20);
   -- Lesson 2.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'For Loops', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which keyword is used for a while loop in Go?',
   '0',
   '["There is no while keyword; Go uses for for all loops","while","loop","do"]'::jsonb,
   'To make a while loop in Go, you just use for condition { ... }.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Create an infinite loop:',
   '___ { fmt.Println("Forever") }',
   'for',
   '["for","while","loop","do"]'::jsonb,
   'for { ... } with no condition loops forever (until a break).',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the continue keyword do?',
   '0',
   '["It stops the current iteration and jumps to the next loop iteration","It exits the loop completely","It pauses the execution","It restarts the function"]'::jsonb,
   'continue skips the rest of the loop body for that iteration.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a loop that acts like a while loop:',
   '[{"id":"1","code":"i := 1"},{"id":"2","code":"for i <= 3 {"},{"id":"3","code":"  fmt.Println(i)"},{"id":"4","code":"  i++"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["i := 1","for i <= 3 {","  fmt.Println(i)","  i++","}"]'::jsonb,
   'Initialize outside, for condition, print, increment inside, close brace.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a standard for loop (with init, condition, post) to print numbers 1, 2, 3 on separate lines.',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Loop and print' || chr(10) || '}',
   '1' || chr(10) || '2' || chr(10) || '3',
   'for i := 1; i <= 3; i++ { fmt.Println(i) }',
   5, 20);
   -- Lesson 2.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Switch Statements', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How does Go''s switch statement handle fall-through behavior?',
   '0',
   '["Go automatically breaks out of the switch at the end of a matched case; fall-through is NOT the default","It falls through to the next case by default","You must manually write break at the end of every case","Fall-through is impossible in Go"]'::jsonb,
   'This prevents common bugs found in C/C++/Java. If you *want* it to fall through, you must explicitly use the fallthrough keyword.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the fallback case in a switch block:',
   '___: fmt.Println("Unknown")',
   'default',
   '["default","else","case else","otherwise"]'::jsonb,
   'The default: block executes if no other cases match the switched value.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you test multiple values in a single case in Go?',
   '0',
   '["Yes, by separating them with a comma (e.g., case 1, 2, 3:)","No, each case must have exactly one value","Yes, using the || operator (e.g., case 1 || 2:)","Only for strings"]'::jsonb,
   'Comma separation makes Go''s switch extremely concise.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a switch to handle traffic light colors (without needing breaks):',
   '[{"id":"1","code":"color := \"Red\""},{"id":"2","code":"switch color {"},{"id":"3","code":"case \"Red\":"},{"id":"4","code":"  fmt.Println(\"Stop\")"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["color := \"Red\"","switch color {","case \"Red\":","  fmt.Println(\"Stop\")","}"]'::jsonb,
   'Declare, open switch, case, print, close switch.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a switch on code := 404 to print "Not Found". Expected: Not Found',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    code := 404' || chr(10) || '    // switch here' || chr(10) || '}',
   'Not Found',
   'switch code { case 404: fmt.Println("Not Found") }',
   5, 20);
   -- Lesson 2.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Defer', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the defer keyword do?',
   '0',
   '["It schedules a function call to be executed right before the surrounding function returns","It runs a function asynchronously","It prevents a function from being executed","It pauses the program for a set duration"]'::jsonb,
   'Defer is heavily used to ensure resources like files and network connections are closed, regardless of how the function exits.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Schedule the print statement to run at the end of the function:',
   '___ fmt.Println("Cleanup")',
   'defer',
   '["defer","wait","finally","last"]'::jsonb,
   'defer pushes the function call onto a list. The list of saved calls is executed after the surrounding function returns.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If you have multiple defer statements in a function, in what order do they execute?',
   '0',
   '["LIFO (Last In, First Out) - reverse order of declaration","FIFO (First In, First Out) - order of declaration","Random order","Simultaneously"]'::jsonb,
   'Deferred calls are stacked. The last thing you defer is the first thing that runs during cleanup.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code so "First" prints, then "Second" prints:',
   '[{"id":"1","code":"func main() {"},{"id":"2","code":"  defer fmt.Println(\"Second\")"},{"id":"3","code":"  fmt.Println(\"First\")"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["func main() {","  defer fmt.Println(\"Second\")","  fmt.Println(\"First\")","}"]'::jsonb,
   'Open main, defer "Second", print "First", close. When main exits, "Second" will print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use defer to print "World". On the next line, print "Hello ". Expected: Hello World',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // defer World, print Hello (use Print, not Println for Hello)' || chr(10) || '}',
   'Hello World',
   'defer fmt.Println("World"); fmt.Print("Hello ")',
   5, 20);
   -- ==============================================================
   -- UNIT 3: Functions and Pointers
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 3: Functions & Pointers', 'Master Go functions, multiple returns, and pointers', 'orange', 3)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Functions and Pointers', $note$
# Functions in Go
Functions in Go are defined using the func keyword. The return type comes *after* the parameters.
```go
func add(x int, y int) int {
    return x + y
}

```
If consecutive parameters share the same type, you can omit the type from all but the last: func add(x, y int) int.
## Multiple Return Values
Go has native support for returning multiple values from a function. This is frequently used for returning results alongside errors.
```go
func swap(first string, second string) (string, string) {
    return second, first
}

func main() {
    a, b := swap("Hello", "World")
    fmt.Println(a, b) // "World Hello"
}

```
## Named Return Values
You can name your return variables in the signature. A return statement without arguments (a "naked" return) automatically returns the current values of those named variables.
```go
func split(sum int) (x, y int) {
    x = sum * 4 / 9
    y = sum - x
    return // Returns x and y
}

```
## Pointers
Go has pointers. A pointer holds the memory address of a value.
 * & generates a pointer to its operand (address of).
 * * denotes the pointer's underlying value (dereference).
```go
i := 42
p := &i         // p is a pointer to i
fmt.Println(*p) // read i through the pointer p (prints 42)
*p = 21         // set i through the pointer p
fmt.Println(i)  // i is now 21

```
Unlike C or C++, Go has **no pointer arithmetic** (you can't do p++). Pointers are mostly used to safely pass variables to functions so they can modify the original data.
$note$, 0);
-- Lesson 3.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Defining Functions', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Where does the return type go in a Go function signature?',
'0',
'["After the parameter list","Before the function name","Inside the parentheses","It is not specified"]'::jsonb,
'E.g., func multiply(x int, y int) int',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the shorthand syntax for parameters sharing the same type:',
'func add(x, y ___) int { return x + y }',
'int',
'["int","var","type","float"]'::jsonb,
'If multiple consecutive parameters have the same type, you only need to write the type on the last one.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the return type of a Go function that does not return anything?',
'0',
'["You simply omit the return type entirely","void","nil","empty"]'::jsonb,
'Go does not use a void keyword. You just write func doSomething() { }.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a complete function that doubles a number:',
'[{"id":"1","code":"func double(n int) int {"},{"id":"2","code":"  return n * 2"},{"id":"3","code":"}"},{"id":"4","code":"func main() { fmt.Println(double(5)) }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["func double(n int) int {","  return n * 2","}","func main() { fmt.Println(double(5)) }"]'::jsonb,
'Function signature, body, close, then main calling it.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write func add(a, b int) int that returns their sum. Call it in main with 3 and 7, and print it. Expected: 10',
'package main' || chr(10) || 'import "fmt"' || chr(10) || '// Write add func' || chr(10) || 'func main() {' || chr(10) || '    // Call add and print' || chr(10) || '}',
'10',
'func add(a, b int) int { return a + b } ... fmt.Println(add(3, 7))',
5, 20);
-- Lesson 3.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Multiple and Named Returns', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you declare a function that returns both a string and an int?',
'0',
'["func myFunc() (string, int)","func myFunc() string, int","func (string, int) myFunc()","func myFunc() []any"]'::jsonb,
'Multiple return types must be enclosed in parentheses.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'To discard a return value you don''t need, use the blank identifier:',
'name, ___ := getUser()',
'*',
'["*","-","blank","nil"]'::jsonb,
'The underscore _ acts as a black hole. It accepts a value but discards it, keeping the compiler happy.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a "naked" return in Go?',
'0',
'["A return statement without arguments, used when return variables are named in the function signature","Returning nil","A function that returns nothing","Returning variables outside of their scope"]'::jsonb,
'If you write func calc() (total int), writing return will automatically return the total variable.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a function returning multiple values:',
'[{"id":"1","code":"func getCoords() (int, int) {"},{"id":"2","code":"  return 10, 20"},{"id":"3","code":"}"},{"id":"4","code":"x, y := getCoords()"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["func getCoords() (int, int) {","  return 10, 20","}","x, y := getCoords()"]'::jsonb,
'Signature with (int, int), return two values, close, call parsing two variables.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write func vals() (int, int) { return 5, 7 }. Call it, assign to a, b, and print a and b. Expected: 5 7',
'package main' || chr(10) || 'import "fmt"' || chr(10) || '// Write vals func' || chr(10) || 'func main() {' || chr(10) || '    // Call and print' || chr(10) || '}',
'5 7',
'func vals() (int, int) { return 5, 7 } ... a, b := vals(); fmt.Println(a, b)',
5, 20);
-- Lesson 3.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Pointers', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the & operator do in Go?',
'0',
'["It generates a pointer to its operand (gets the memory address)","It dereferences a pointer (gets the underlying value)","It represents logical AND","It creates a new variable"]'::jsonb,
'& means "address of". &x gives you the memory address of x.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to dereference the pointer p (read the value it points to):',
'fmt.Println(___p)',
'*',
'["*","&","->","val"]'::jsonb,
'* is the dereference operator. It means "the value at the address of".',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which statement about Go pointers is true?',
'0',
'["Go has pointers, but no pointer arithmetic (you cannot do p++)","Go pointers are exactly like C++ pointers","Go uses -> to access pointer fields","Go does not have pointers"]'::jsonb,
'Go chose to include pointers for performance and mutability, but excluded pointer arithmetic for safety and simplicity.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to create a pointer and modify the original value:',
'[{"id":"1","code":"x := 10"},{"id":"2","code":"p := &x"},{"id":"3","code":"*p = 20"},{"id":"4","code":"fmt.Println(x) // Prints 20"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["x := 10","p := &x","*p = 20","fmt.Println(x) // Prints 20"]'::jsonb,
'Declare val, get address, change val via pointer, print original var.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write func zero(ptr *int) that sets *ptr = 0. In main, x := 5, call zero(&x), print x. Expected: 0',
'package main' || chr(10) || 'import "fmt"' || chr(10) || '// Write zero func' || chr(10) || 'func main() {' || chr(10) || '    x := 5' || chr(10) || '    // Call zero and print x' || chr(10) || '}',
'0',
'func zero(ptr *int) { *ptr = 0 } ... zero(&x); fmt.Println(x)',
5, 20);
-- Lesson 3.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Anonymous Functions (Closures)', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is an anonymous function in Go?',
'0',
'["A function declared without a name, often used inline as a variable","A function that returns void","A function that has no parameters","A built-in system function"]'::jsonb,
'Go supports first-class functions. You can assign functions to variables and pass them around.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Call the anonymous function immediately after defining it by adding parentheses:',
'func() { fmt.Println("Hi") }___',
'()',
'["()","{}",";","run"]'::jsonb,
'Adding () executes the inline function instantly.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What makes an anonymous function a "closure"?',
'0',
'["It can access and modify variables from outside its own body (its surrounding scope)","It closes the program when done","It cannot accept arguments","It is stored in memory permanently"]'::jsonb,
'Closures "capture" the variables around them. If a closure updates an outside counter, that counter stays updated.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to create and call a function variable:',
'[{"id":"1","code":"func main() {"},{"id":"2","code":"  greet := func(name string) {"},{"id":"3","code":"    fmt.Println(\"Hi\", name)"},{"id":"4","code":"  }"},{"id":"5","code":"  greet(\"Bob\")\\n}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["func main() {","  greet := func(name string) {","    fmt.Println(\"Hi\", name)","  }","  greet(\"Bob\")\\n}"]'::jsonb,
'Main, assign func to var, body, close func, call var.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Assign square := func(n int) int { return n * n }. Print square(4). Expected: 16',
'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Define inline function and print result' || chr(10) || '}',
'16',
'square := func(n int) int { return n * n }; fmt.Println(square(4))',
5, 20);
-- ==============================================================
-- UNIT 4: Data Structures
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 4: Data Structures', 'Work with Arrays, Slices, Maps, and the Range keyword', 'purple', 4)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Data Structures in Go', $note$
# Data Structures: Arrays, Slices, and Maps
## Arrays
An array has a **fixed size**. The size is part of its type.
```go
var a [3]int
a[0] = 5

// Array literal
primes := [4]int{2, 3, 5, 7}

```
## Slices
Slices are much more common in Go than arrays. A slice is a dynamically-sized, flexible view into the elements of an array.
```go
// No size in the brackets creates a slice
names := []string{"Alice", "Bob"}

// Add elements using the built-in append function
names = append(names, "Charlie")

```
Under the hood, a slice describes a piece of an underlying array. It has a len (length) and a cap (capacity).
## Maps
A map maps keys to values (like a Dictionary or Hash). The zero value of a map is nil. You must initialize it with make.
```go
// make(map[KeyType]ValueType)
ages := make(map[string]int)
ages["Anthony"] = 25

// Map literal
scores := map[string]int{
    "Alice": 100,
    "Bob": 85,
}

// Checking if a key exists
val, ok := scores["Charlie"] // ok is false if not found

```
## The "range" Keyword
The range form of the for loop iterates over a slice or map.
```go
nums := []int{2, 4, 6}
for index, value := range nums {
    fmt.Printf("Index %d is %d\n", index, value)
}

// For a map, range returns (key, value)
for key, val := range scores {
    fmt.Println(key, val)
}

```
If you only need the value, use the blank identifier _ for the index: for _, value := range nums.
$note$, 0);
-- Lesson 4.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Arrays and Slices', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the fundamental difference between an Array and a Slice in Go?',
'0',
'["Arrays have a fixed size built into their type, Slices are dynamically sized","Arrays can hold mixed types, Slices cannot","Slices are immutable","Arrays are dynamically sized"]'::jsonb,
'[3]int is an array of exactly 3 ints. []int is a slice that can grow.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to dynamically add "Go" to a slice of strings:',
'langs = ___ (langs, "Go")',
'append',
'["append","push","add","insert"]'::jsonb,
'The built-in append function adds elements to the end of a slice and returns the new slice.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which built-in function gives you the number of elements in a slice?',
'0',
'["len(slice)","slice.length","count(slice)","slice.size()"]'::jsonb,
'len() works on slices, arrays, maps, and strings.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to create a slice, append an item, and print it:',
'[{"id":"1","code":"nums := []int{1, 2}"},{"id":"2","code":"nums = append(nums, 3)"},{"id":"3","code":"fmt.Println(nums)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["nums := []int{1, 2}","nums = append(nums, 3)","fmt.Println(nums)"]'::jsonb,
'Declare slice, append to it, print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create a slice s := []int{5}. Append 10 to it, then print s. Expected: [5 10]',
'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Create slice, append, print' || chr(10) || '}',
'[5 10]',
's := []int{5}; s = append(s, 10); fmt.Println(s)',
5, 20);
-- Lesson 4.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Maps', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What built-in function must be used to initialize an empty map so you can add keys to it?',
'0',
'["make()","new()","init()","create()"]'::jsonb,
'A declared map is nil and will cause a panic if you write to it. You must use make(map[string]int).',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the map type definition where keys are strings and values are ints:',
'scores := make(___[string]int)',
'map',
'["map","dict","hash","slice"]'::jsonb,
'The syntax is map[KeyType]ValueType.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you check if a key exists in a map without crashing or getting a fake zero value?',
'0',
'["Using the two-value assignment: val, ok := myMap[\"key\"]","Using myMap.contains(\"key\")","Using myMap.exists(\"key\")","By checking if val == nil"]'::jsonb,
'If the key exists, ok will be true. If it does not, ok will be false and val will be the zero value of the type.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to create a map, assign a value, and read it safely:',
'[{"id":"1","code":"m := make(map[string]int)"},{"id":"2","code":"m[\"Apples\"] = 5"},{"id":"3","code":"val, ok := m[\"Apples\"]"},{"id":"4","code":"if ok { fmt.Println(val) }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["m := make(map[string]int)","m[\"Apples\"] = 5","val, ok := m[\"Apples\"]","if ok { fmt.Println(val) }"]'::jsonb,
'Make map, assign key, check existence with two-value assign, if ok print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create a map of string to int using a literal: m := map[string]int{"A": 1}. Print the value of "A". Expected: 1',
'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Map literal and print' || chr(10) || '}',
'1',
'm := map[string]int{"A": 1}; fmt.Println(m["A"])',
5, 20);
-- Lesson 4.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'The Range Keyword', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What two values does the range keyword return on each iteration over a slice?',
'0',
'["The index and the value","The value and the type","The length and the capacity","Just the value"]'::jsonb,
'for index, value := range slice { ... }',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to iterate over a slice, ignoring the index using the blank identifier:',
'for _**, val := range nums { fmt.Println(val) }',
'*',
'["*","i","index","nil"]'::jsonb,
'Since Go requires you to use all declared variables, the _ allows you to throw away the index if you only need the value.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'When you use range on a map, what are the two values returned?',
'0',
'["The key and the value","The index and the value","The key and a boolean","Just the key"]'::jsonb,
'for key, value := range myMap { ... }',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a loop that sums all values in a slice:',
'[{"id":"1","code":"nums := []int{2, 3, 4}"},{"id":"2","code":"sum := 0"},{"id":"3","code":"for _, v := range nums {"},{"id":"4","code":"  sum += v }"},{"id":"5","code":"fmt.Println(sum)"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["nums := []int{2, 3, 4}","sum := 0","for _, v := range nums {","  sum += v }","fmt.Println(sum)"]'::jsonb,
'Declare slice, declare sum, range loop ignoring index, add to sum, print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given arr := []int{7, 8}. Use range to print each value on a new line. (Ignore the index).',
'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    arr := []int{7, 8}' || chr(10) || '    // Write range loop' || chr(10) || '}',
'7' || chr(10) || '8',
'for _, v := range arr { fmt.Println(v) }',
5, 20);
-- Lesson 4.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Slicing Slices', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the expression a[1:4] do on an array or slice a?',
'0',
'["Creates a slice including elements 1 through 3 (excludes index 4)","Creates a slice of elements 1 through 4","Removes elements 1 through 4","Throws an error"]'::jsonb,
'Slicing is [low:high]. It includes the low index, but excludes the high index.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'To slice from the beginning of the array up to (but excluding) index 3, omit the low bound:',
'topThree := scores[___:3]',
'',
'["","0","start","nil"]'::jsonb,
'scores[:3] is equivalent to scores[0:3].',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you change a value in a slice (e.g., s[0] = 99) that was created from an array?',
'0',
'["The underlying array is modified because a slice is just a reference (view) to the array","Only the slice changes; the array is a copy","The compiler throws an error","A new array is automatically created"]'::jsonb,
'Slices do not store data themselves. Modifying the elements of a slice modifies the underlying array.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Slice an array to get the middle elements:',
'[{"id":"1","code":"primes := [5]int{2, 3, 5, 7, 11}"},{"id":"2","code":"mid := primes[1:4]"},{"id":"3","code":"fmt.Println(mid) // [3 5 7]"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["primes := [5]int{2, 3, 5, 7, 11}","mid := primes[1:4]","fmt.Println(mid) // [3 5 7]"]'::jsonb,
'Declare array, slice from 1 to 4, print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given words := []string{"A", "B", "C", "D"}. Print a slice containing only "B" and "C". Expected: [B C]',
'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    words := []string{"A", "B", "C", "D"}' || chr(10) || '    // Slice and print' || chr(10) || '}',
'[B C]',
'fmt.Println(words[1:3])',
5, 20);
-- ==============================================================
-- UNIT 5: Structs, Methods, and Interfaces
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 5: Structs & Methods', 'Go does not have classes. Build types using Structs and Interfaces', 'teal', 5)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Object-Oriented Go', $note$
# Structs, Methods, and Interfaces
Go does not have class, extends, or implements keywords. Instead, it uses structs and methods to provide object-oriented capabilities.
## Structs
A struct is a collection of fields.
```go
type Vertex struct {
    X int
    Y int
}

func main() {
    v := Vertex{1, 2}
    v.X = 4
    fmt.Println(v.X)
}

```
## Methods
Go does not have classes, but you can define methods on types. A method is just a function with a special **receiver** argument.
```go
type User struct {
    Name string
}

// (u User) is the receiver
func (u User) sayHi() {
    fmt.Println("Hi, I am", u.Name)
}

func main() {
    bob := User{"Bob"}
    bob.sayHi()
}

```
## Pointer Receivers
If a method needs to **modify** the struct, or if the struct is very large, the receiver must be a pointer *.
```go
func (u *User) setName(newName string) {
    u.Name = newName // Changes the original struct
}

```
## Interfaces
Interfaces are implemented **implicitly**. If a struct has all the methods an interface requires, it implements that interface automatically. No implements keyword is needed!
```go
type Speaker interface {
    Speak()
}

type Dog struct{}

func (d Dog) Speak() {
    fmt.Println("Woof")
}

// Dog automatically implements Speaker!
func makeItSpeak(s Speaker) {
    s.Speak()
}

```
$note$, 0);
-- Lesson 5.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Structs', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you group related data fields together in Go?',
'0',
'["Using a struct","Using a class","Using a dictionary","Using an object"]'::jsonb,
'Go uses structs (like C) instead of classes to group state.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration for a custom struct type:',
'___ Person struct { Name string }',
'type',
'["type","class","var","func"]'::jsonb,
'type [Name] struct creates a new custom type.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How are fields in a struct accessed?',
'0',
'["Using dot notation (e.g., p.Name)","Using brackets (e.g., p[\"Name\"])","Using a getter (e.g., p.getName())","Using an arrow (e.g., p->Name)"]'::jsonb,
'Dot notation is used to access and mutate struct fields.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Define a Point struct and instantiate it:',
'[{"id":"1","code":"type Point struct {"},{"id":"2","code":"  X, Y int }"},{"id":"3","code":"func main() {"},{"id":"4","code":"  p := Point{X: 10, Y: 20} }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["type Point struct {","  X, Y int }","func main() {","  p := Point{X: 10, Y: 20} }"]'::jsonb,
'Type definition open, fields, main function, instantiate with field names.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Define type Car struct { Make string }. In main, create c := Car{"Ford"}, print c.Make. Expected: Ford',
'package main' || chr(10) || 'import "fmt"' || chr(10) || '// Define struct' || chr(10) || 'func main() {' || chr(10) || '    // Instantiate and print' || chr(10) || '}',
'Ford',
'type Car struct { Make string }; ... c := Car{"Ford"}; fmt.Println(c.Make)',
5, 20);
-- Lesson 5.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Methods and Receivers', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a method in Go?',
'0',
'["A function with a special receiver argument placed between func and the method name","A function inside a struct","A static class function","Any function"]'::jsonb,
'Example: func (r Rectangle) area() int. The (r Rectangle) binds the function to that type.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the receiver syntax so User instances can call GetName():',
'func (u ___) GetName() string { return u.Name }',
'User',
'["User","struct","this","self"]'::jsonb,
'The receiver binds the method to the User type. You define your own variable name (like u), Go does not use this or self.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If a method needs to modify the fields of a struct, what kind of receiver MUST it use?',
'0',
'["A pointer receiver (e.g., *User)","A value receiver (e.g., User)","A global receiver","A reference receiver (e.g., &User)"]'::jsonb,
'A value receiver passes a copy. To change the original, you must pass a pointer.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a method that increments a counter using a pointer receiver:',
'[{"id":"1","code":"type Counter struct { val int }"},{"id":"2","code":"func (c *Counter) Inc() {"},{"id":"3","code":"  c.val++ }"},{"id":"4","code":"// Usage: c.Inc()"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["type Counter struct { val int }","func (c *Counter) Inc() {","  c.val++ }","// Usage: c.Inc()"]'::jsonb,
'Struct def, pointer receiver method signature, body, usage comment.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given type Box struct { Size int }. Write a method func (b *Box) Grow() { b.Size += 10 }. In main, call Grow() on a Box of Size 5, print Size. Expected: 15',
'package main' || chr(10) || 'import "fmt"' || chr(10) || 'type Box struct { Size int }' || chr(10) || '// Write Grow method' || chr(10) || 'func main() {' || chr(10) || '    b := Box{Size: 5}' || chr(10) || '    // Call Grow and print Size' || chr(10) || '}',
'15',
'func (b *Box) Grow() { b.Size += 10 } ... b.Grow(); fmt.Println(b.Size)',
5, 20);
-- Lesson 5.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Interfaces', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How does a struct implement an interface in Go?',
'0',
'["Implicitly: the struct just needs to have all the methods defined in the interface","Explicitly: by using the implements keyword","By embedding the interface in the struct","By using a generic constraint"]'::jsonb,
'Implicit interfaces decouple definitions from implementations. If it walks like a duck and quacks like a duck, it implements the Duck interface.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration of an interface:',
'type Animal ___ { Speak() string }',
'interface',
'["interface","struct","class","contract"]'::jsonb,
'An interface defines a set of method signatures.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the empty interface interface{} (or any in Go 1.18+) used for?',
'0',
'["It can hold values of any type, because every type implements zero methods","It is used to define empty functions","It clears variables from memory","It prevents a type from having methods"]'::jsonb,
'Functions like fmt.Println take empty interfaces so they can accept strings, ints, structs, etc.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange code where a struct implements an interface:',
'[{"id":"1","code":"type Runner interface { Run() }"},{"id":"2","code":"type Athlete struct{}"},{"id":"3","code":"func (a Athlete) Run() { fmt.Println(\"Running\") }"},{"id":"4","code":"func doRun(r Runner) { r.Run() }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["type Runner interface { Run() }","type Athlete struct{}","func (a Athlete) Run() { fmt.Println(\"Running\") }","func doRun(r Runner) { r.Run() }"]'::jsonb,
'Interface def, struct def, method that implicitly implements interface, func that accepts interface.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Define interface Greeter { Greet() }. Make type Bot struct{}. Add method Greet() to Bot that prints "Beep". In main, var g Greeter = Bot{}; g.Greet(). Expected: Beep',
'package main' || chr(10) || 'import "fmt"' || chr(10) || '// Interface, Struct, Method' || chr(10) || 'func main() {' || chr(10) || '    // Instantiate and call' || chr(10) || '}',
'Beep',
'type Greeter interface { Greet() }; type Bot struct{}; func (b Bot) Greet() { fmt.Println("Beep") } ... var g Greeter = Bot{}; g.Greet()',
5, 20);
-- ==============================================================
-- UNIT 6: Concurrency and Errors
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 6: Concurrency & Errors', 'Master Goroutines, Channels, and Error Handling', 'red', 6)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Concurrency and Errors', $note$
# Concurrency and Error Handling
Go is famous for its simple, high-performance concurrency model.
## Goroutines
A goroutine is a lightweight thread managed by the Go runtime. Simply put the go keyword in front of a function call.
```go
func say(s string) {
    fmt.Println(s)
}

func main() {
    go say("world") // Runs concurrently in the background
    say("hello")    // Runs in the foreground
}

```
## Channels
Channels are pipes that connect concurrent goroutines. You can send values into channels from one goroutine and receive them in another.
```go
func main() {
    // Make a channel of ints
    ch := make(chan int)

    // Run a goroutine
    go func() {
        ch <- 42 // Send 42 to the channel
    }()

    val := <-ch // Receive from the channel
    fmt.Println(val)
}

```
## Error Handling
Go does not have try-catch exceptions. Instead, errors are returned as normal values using the built-in error interface.
```go
import (
    "fmt"
    "os"
)

func main() {
    file, err := os.Open("data.txt")
    if err != nil {
        fmt.Println("Error opening file:", err)
        return // Stop execution
    }
    fmt.Println("File opened successfully")
}

```
## Key Takeaways
 * go fn() starts a background task (goroutine).
 * ch <- val sends to a channel, <-ch receives.
 * Always check if err != nil after calling a function that returns an error!
   $note$, 0);
   -- Lesson 6.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Goroutines', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a Goroutine?',
   '0',
   '["A lightweight thread managed by the Go runtime","An operating system thread","A type of loop","A way to handle errors"]'::jsonb,
   'Goroutines are incredibly cheap to create compared to OS threads. You can run thousands of them easily.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to execute a function asynchronously:',
   '___ computeTask()',
   'go',
   '["go","run","thread","async"]'::jsonb,
   'Prefixing a function call with go starts it in a new goroutine.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if the main function (the main goroutine) finishes before other goroutines are done?',
   '0',
   '["The program exits immediately and the other goroutines are terminated","The program waits for all goroutines to finish","The compiler throws an error","A panic occurs"]'::jsonb,
   'If main finishes, the program dies. You must use WaitGroups or Channels to make main wait.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to start a background task:',
   '[{"id":"1","code":"func main() {"},{"id":"2","code":"  go func() {"},{"id":"3","code":"    fmt.Println(\"Background\")"},{"id":"4","code":"  }()"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["func main() {","  go func() {","    fmt.Println(\"Background\")","  }()","}"]'::jsonb,
   'main func, go keyword before anonymous func, body, close and call (), close main.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write go fmt.Println("Async"). (Note: in this runner environment, main might exit before it prints, but just write the code).',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Write go print' || chr(10) || '}',
   '',
   'go fmt.Println("Async")',
   5, 20);
   -- Lesson 6.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Channels', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a Channel used for in Go?',
   '0',
   '["Safely sending data between different goroutines","Reading files from the disk","Creating structs","Handling HTTP requests"]'::jsonb,
   'Channels are pipes that connect concurrent goroutines, preventing race conditions.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to SEND the value 42 into the channel ch:',
   'ch ___ 42',
   '<-',
   '["<-","->","=","put"]'::jsonb,
   'The arrow indicates the direction of data flow. Value goes INTO the channel.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'By default, sends and receives on a channel block until the other side is ready. What does this provide?',
   '0',
   '["Synchronization between goroutines without needing explicit locks","Faster execution","Memory compression","Error throwing"]'::jsonb,
   'Because <-ch waits for data, you can use it to force main to wait until a goroutine is done.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to create a channel, send to it, and read from it:',
   '[{"id":"1","code":"ch := make(chan int)"},{"id":"2","code":"go func() {"},{"id":"3","code":"  ch <- 99 }()"},{"id":"4","code":"val := <-ch"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["ch := make(chan int)","go func() {","  ch <- 99 }()","val := <-ch"]'::jsonb,
   'Make chan, open goroutine, send to chan, receive from chan outside goroutine.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create ch := make(chan string). Send "Done" via a goroutine. Receive and print it. Expected: Done',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'func main() {' || chr(10) || '    // Channel, go send, receive & print' || chr(10) || '}',
   'Done',
   'ch := make(chan string); go func() { ch <- "Done" }(); fmt.Println(<-ch)',
   5, 20);
   -- Lesson 6.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Error Handling', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How does Go typically handle functions that might fail (like parsing a string to an integer)?',
   '0',
   '["The function returns an error as a second return value, which the caller must check","It throws an exception that must be caught in a try/catch block","It returns nil","It crashes the program"]'::jsonb,
   'result, err := doSomething(). Go relies on explicit error checking.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the standard Go idiom for checking if an error occurred:',
   'if err != ___ { fmt.Println("Error!") }',
   'nil',
   '["nil","null","0","false"]'::jsonb,
   'nil is Go''s version of null. If the error is not nil, something went wrong.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the panic() function do in Go?',
   '0',
   '["It stops ordinary control flow, begins panicking, and crashes the program if not recovered","It creates a new error object","It restarts the program","It runs a goroutine"]'::jsonb,
   'Use panic only for unrecoverable programmer errors. Use error for expected failures (like bad user input).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to call a function and check its error:',
   '[{"id":"1","code":"data, err := readFile(\"config.txt\")"},{"id":"2","code":"if err != nil {"},{"id":"3","code":"  fmt.Println(\"Failed:\", err)"},{"id":"4","code":"  return }"},{"id":"5","code":"fmt.Println(\"Success\", data)"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["data, err := readFile(\"config.txt\")","if err != nil {","  fmt.Println(\"Failed:\", err)","  return }","fmt.Println(\"Success\", data)"]'::jsonb,
   'Call func getting data and err, check if err != nil, print err and return, else success.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given err := getErr(). Write if err != nil { fmt.Println("Caught") }. Expected: Caught',
   'package main' || chr(10) || 'import "fmt"' || chr(10) || 'import "errors"' || chr(10) || 'func getErr() error { return errors.New("bad") }' || chr(10) || 'func main() {' || chr(10) || '    err := getErr()' || chr(10) || '    // Write check' || chr(10) || '}',
   'Caught',
   'if err != nil { fmt.Println("Caught") }',
   5, 20);
END $$;

