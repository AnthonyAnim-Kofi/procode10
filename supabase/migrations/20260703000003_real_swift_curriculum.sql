-- ============================================================
-- REAL SWIFT CURRICULUM
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

  -- Prefer slug 'swift' (used by the app)
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug = 'swift'
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('Swift', 'swift', '📱', 'A powerful and intuitive programming language for iOS, macOS, tvOS, and watchOS.')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with Swift
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Learn Swift basics, variables, constants, and data types', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to Swift', $note$
# Introduction to Swift

Swift is a powerful and intuitive programming language developed by Apple for building apps on iOS, Mac, Apple TV, and Apple Watch. It’s designed to give developers more freedom and make software safer and faster.

## Your First Program

```swift
import Foundation

print("Hello, World!")

```
Breaking it down:
 * import Foundation — Imports Apple's core library (like importing System in C#).
 * print(...) — Outputs text to the console.
 * **No semicolons needed!** Swift doesn't require ; at the end of statements unless you write multiple statements on the same line.
 * Swift scripts run top-to-bottom. You don't explicitly need a main() function.
## Variables and Constants
In Swift, you must declare whether a value can change or if it is permanent.
```swift
var age = 25       // var creates a variable (can be changed)
age = 26           // Allowed

let name = "Alice" // let creates a constant (cannot be changed)
// name = "Bob"    // Error!

```
*Best Practice: Always use let unless you specifically know a value needs to change.*
## Data Types & Type Inference
Swift is strongly typed, but it's smart enough to figure out types automatically (Type Inference).
```swift
let score: Int = 100       // Explicitly declaring an Integer
let price = 19.99          // Inferred as Double
let isActive = true        // Inferred as Bool
let greeting = "Welcome"   // Inferred as String

```
## String Interpolation
To inject variables into a string, use \(variable):
```swift
let apples = 3
let msg = "I have \(apples) apples."
print(msg) // "I have 3 apples."

```
## Key Takeaways
 * Use var for variables and let for constants.
 * Semicolons are optional and rarely used.
 * Swift uses \(value) to inject variables directly into strings.
   $note$, 0);
   -- Lesson 1.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Hello, Swift!', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which function is used to output text to the console in Swift?',
   '0',
   '["print()","console.log()","System.out.println()","Console.WriteLine()"]'::jsonb,
   'Swift uses the simple print("...") command.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the statement to print a greeting:',
   '___("Hello, Swift!")',
   'print',
   '["print","log","write","display"]'::jsonb,
   'print writes to standard output.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Are semicolons (;) required at the end of statements in Swift?',
   '0',
   '["No, they are optional and generally omitted unless writing multiple statements on one line","Yes, every line must end with a semicolon","No, they are completely banned","Only after variable declarations"]'::jsonb,
   'Swift embraces clean, readable code, so semicolons are rarely used.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the minimal code to print a message:',
   '[{"id":"1","code":"import Foundation"},{"id":"2","code":"print(\"Starting app...\")"}]'::jsonb,
   '["1","2"]'::jsonb,
   '["import Foundation","print(\"Starting app...\")"]'::jsonb,
   'Import the core library first, then call print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write a Swift program that prints: Learning Swift',
   'import Foundation' || chr(10) || '// Write your code here',
   'Learning Swift',
   'print("Learning Swift")',
   5, 20);
   -- Lesson 1.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Variables and Constants', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which keyword is used to declare a constant (a value that cannot be changed) in Swift?',
   '0',
   '["let","var","const","final"]'::jsonb,
   'let makes a constant. var makes a variable.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to declare a value that CAN be changed later:',
   '___ score = 0',
   'var',
   '["var","let","mut","int"]'::jsonb,
   'Use var for variables that will change (mutate) over time.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you try to run let x = 5; x = 10?',
   '0',
   '["The compiler throws an error because let constants cannot be reassigned","It works fine and updates x to 10","It creates a new variable shadowing the old one","x becomes a double"]'::jsonb,
   'Swift enforces immutability strictly. If you declare with let, it is locked.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to declare a constant name and a variable age, then update the age:',
   '[{"id":"1","code":"let name = \"Alice\""},{"id":"2","code":"var age = 20"},{"id":"3","code":"age = 21"},{"id":"4","code":"print(name, age)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let name = \"Alice\"","var age = 20","age = 21","print(name, age)"]'::jsonb,
   'Declare constant, declare variable, reassign variable, print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Declare a variable count as 5. Update it to 6, and print it.',
   'import Foundation' || chr(10) || '// Declare, update, print',
   '6',
   'var count = 5; count = 6; print(count)',
   5, 20);
   -- Lesson 1.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Data Types and Inference', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you explicitly state that a variable is a Double in Swift?',
   '0',
   '["var price: Double = 9.99","var price = Double(9.99)","Double price = 9.99","var price as Double = 9.99"]'::jsonb,
   'Type annotations in Swift use a colon: var name: Type = value.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the type annotation for a whole number:',
   'let quantity: ___ = 100',
   'Int',
   '["Int","int","Integer","Number"]'::jsonb,
   'In Swift, core types are capitalized: Int, Double, String, Bool.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is Type Inference?',
   '0',
   '["The compiler''s ability to automatically deduce the type of a variable from its initial value","A way to manually convert types","A protocol in Swift","A debugging tool"]'::jsonb,
   'If you write let name = "Apple", Swift infers that name is a String.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the declarations with explicit types:',
   '[{"id":"1","code":"let id: Int = 1"},{"id":"2","code":"let balance: Double = 50.5"},{"id":"3","code":"let isValid: Bool = true"},{"id":"4","code":"print(id)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let id: Int = 1","let balance: Double = 50.5","let isValid: Bool = true","print(id)"]'::jsonb,
   'Int, Double, Bool, then output.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Declare a constant speed explicitly as a Double equal to 55.0. Print it.',
   'import Foundation' || chr(10) || '// Declare and print',
   '55.0',
   'let speed: Double = 55.0; print(speed)',
   5, 20);
   -- Lesson 1.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'String Interpolation', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which syntax is used for string interpolation in Swift?',
   '0',
   '["\\(variable)","${variable}","$variable","{variable}"]'::jsonb,
   'Example: "My age is \\(age)."',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the interpolation to print the score:',
   'let score = 10;' || chr(10) || 'print("Score: ___(score)")',
   '\',
   '["\\\", \"$\", \"#\", \"@\"]"]'::jsonb,
   'A backslash followed by parentheses allows you to evaluate Swift code inside a string.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you perform math operations inside String Interpolation?',
   '0',
   '["Yes, e.g., \\(a + b)","No, only variables can be used","Yes, but only with Integers","No, it throws a compiler error"]'::jsonb,
   'Any valid Swift expression returning a value can go inside \\( ... ).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to greet a user with their name and age:',
   '[{"id":"1","code":"let name = \"Bob\""},{"id":"2","code":"let age = 30"},{"id":"3","code":"let msg = \"Hello \\(name), you are \\(age)\""},{"id":"4","code":"print(msg)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let name = \"Bob\"","let age = 30","let msg = \"Hello \\(name), you are \\(age)\"","print(msg)"]'::jsonb,
   'Declare vars, create interpolated string, print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given let n = 5. Print exactly "5 times 2 is 10" using math inside string interpolation.',
   'import Foundation' || chr(10) || 'let n = 5' || chr(10) || '// Interpolate and print',
   '5 times 2 is 10',
   'print("\(n) times 2 is \(n * 2)")',
   5, 20);
   -- ==============================================================
   -- UNIT 2: Control Flow
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 2: Control Flow', 'Make decisions and repeat code with if, loops, and switches', 'green', 2)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Control Flow in Swift', $note$
# Control Flow in Swift
## If / Else Statements
In Swift, you **do not** need parentheses around the condition, but curly braces {} are **mandatory**.
```swift
let score = 85

if score >= 90 {
    print("A")
} else if score >= 80 {
    print("B")
} else {
    print("F")
}

```
## For-In Loops and Ranges
Swift makes looping over ranges incredibly easy.
 * Closed Range (...): Includes the final number.
 * Half-Open Range (..<): Excludes the final number.
```swift
// Prints 1, 2, 3, 4, 5
for i in 1...5 {
    print(i)
}

// Prints 1, 2, 3, 4
for i in 1..<5 {
    print(i)
}

```
If you don't need the loop variable, use an underscore _ to ignore it:
```swift
for _ in 1...3 {
    print("Hello") // Prints Hello 3 times
}

```
## While Loops
```swift
var count = 3
while count > 0 {
    print(count)
    count -= 1
}

```
## Switch Statements
Swift switch statements are very powerful. They are **exhaustive** (you must cover every possible case) and they **do not fall through** by default, meaning no break is required!
```swift
let day = "Mon"

switch day {
case "Mon", "Tue", "Wed", "Thu", "Fri":
    print("Weekday")
case "Sat", "Sun":
    print("Weekend")
default:
    print("Unknown") // Default is required if not all cases are covered
}

```
## Key Takeaways
 * No parentheses around if or for conditions.
 * Use ... and ..< for clean range loops.
 * switch does not need break and prevents fallthrough bugs naturally.
   $note$, 0);
   -- Lesson 2.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'If and Else', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is grammatically different about if conditions in Swift compared to Java or C#?',
   '0',
   '["Parentheses () around the condition are not required, but braces {} are mandatory","Braces {} are optional","The condition must be an integer","You must use the then keyword"]'::jsonb,
   'if x > 5 { ... } is the correct syntax in Swift.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the condition to check if a user is online AND admin:',
   'if isOnline ___ isAdmin { print("Access") }',
   '&&',
   '["&&","||","AND","&"]'::jsonb,
   'The logical AND operator in Swift is &&.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the ! operator do?',
   '0',
   '["It reverses a boolean value (Logical NOT)","It means strictly equal","It safely unwraps an optional","It forces the program to crash"]'::jsonb,
   '!true becomes false.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange to check if temperature is below freezing:',
   '[{"id":"1","code":"let temp = -2"},{"id":"2","code":"if temp <= 0 {"},{"id":"3","code":"  print(\"Freezing\")"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let temp = -2","if temp <= 0 {","  print(\"Freezing\")","}"]'::jsonb,
   'Declare var, open if without parens, print, close if.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print "Even" if num = 8 is divisible by 2, else print "Odd". Expected: Even',
   'import Foundation' || chr(10) || 'let num = 8' || chr(10) || '// Write if/else',
   'Even',
   'if num % 2 == 0 { print("Even") } else { print("Odd") }',
   5, 20);
   -- Lesson 2.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'For-In Loops', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which range operator creates a range that includes the final number (e.g., 1 to 5 inclusive)?',
   '0',
   '["... (Closed Range Operator)","..< (Half-Open Range Operator)","->",":"]'::jsonb,
   '1...5 loops 5 times (1, 2, 3, 4, 5).',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the syntax to loop over a half-open range (1, 2, 3):',
   'for i in 1___4 { }',
   '..<',
   '["..<","...","<.","<="]'::jsonb,
   '..< stops BEFORE the final number. It is extremely useful for looping through arrays (0 to array.count).',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What should you use if you want to loop 3 times but don''t need to use the loop variable (i)?',
   '0',
   '["An underscore _ (e.g., for _ in 1...3)","The word ignore","Leave it blank","A while loop instead"]'::jsonb,
   'The underscore _ tells Swift to ignore the value, which saves memory and prevents "unused variable" warnings.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a loop that prints numbers 1 through 3 inclusive:',
   '[{"id":"1","code":"for i in 1...3 {"},{"id":"2","code":"  print(i)"},{"id":"3","code":"}"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["for i in 1...3 {","  print(i)","}"]'::jsonb,
   'for loop with ..., print i, close loop.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a for-in loop with ..< to print numbers 1, 2, 3 on separate lines.',
   'import Foundation' || chr(10) || '// Loop and print',
   '1' || chr(10) || '2' || chr(10) || '3',
   'for i in 1..<4 { print(i) }',
   5, 20);
   -- Lesson 2.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'While Loops', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the Swift equivalent of a do-while loop (executes the block once before checking the condition)?',
   '0',
   '["repeat-while","do-while","loop-while","run-while"]'::jsonb,
   'Swift uses repeat { ... } while condition.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to jump to the next iteration of a loop without executing the rest of the block:',
   'if i == 5 { ___ }',
   'continue',
   '["continue","break","next","skip"]'::jsonb,
   'continue skips the rest of the current loop iteration. break exits entirely.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the break keyword do inside a while loop?',
   '0',
   '["It stops the loop and exits it immediately","It skips the current iteration","It pauses the loop","It restarts the loop"]'::jsonb,
   'break breaks you out of the loop block entirely.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a while loop that counts down from 3 to 1:',
   '[{"id":"1","code":"var i = 3"},{"id":"2","code":"while i > 0 {"},{"id":"3","code":"  print(i)"},{"id":"4","code":"  i -= 1"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["var i = 3","while i > 0 {","  print(i)","  i -= 1","}"]'::jsonb,
   'Initialize i, while condition, print, decrement, close brace.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create a repeat loop that prints "Run" and then has a while false condition. Expected: Run',
   'import Foundation' || chr(10) || '// Write repeat-while loop',
   'Run',
   'repeat { print("Run") } while false',
   5, 20);
   -- Lesson 2.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Switch Statements', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is incredibly safe about Swift''s switch statements compared to other languages?',
   '0',
   '["They do NOT fall through by default, meaning you do not need to write break at the end of every case","They only accept integers","They automatically loop","They ignore unhandled cases"]'::jsonb,
   'Once a case matches, it executes its code and then automatically exits the switch.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Because switch statements must be exhaustive, you usually need to provide a fallback case:',
   '___: print("Unknown")',
   'default',
   '["default","else","case else","otherwise"]'::jsonb,
   'If the compiler can''t guarantee you covered every possible value, you must provide a default: case.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you test multiple values in a single case in Swift?',
   '0',
   '["Yes, by separating them with a comma (e.g., case 1, 2, 3:)","No, each case must have exactly one value","Yes, using the || operator","Only for strings"]'::jsonb,
   'Comma separation makes Swift''s switch extremely concise.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a switch to handle traffic light colors:',
   '[{"id":"1","code":"let color = \"Red\""},{"id":"2","code":"switch color {"},{"id":"3","code":"case \"Red\":"},{"id":"4","code":"  print(\"Stop\")"},{"id":"5","code":"default: print(\"Go\") }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["let color = \"Red\"","switch color {","case \"Red\":","  print(\"Stop\")","default: print(\"Go\") }"]'::jsonb,
   'Declare, open switch, case, print, default and close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a switch on let code = 404 to print "Not Found". Provide a default that prints "OK". Expected: Not Found',
   'import Foundation' || chr(10) || 'let code = 404' || chr(10) || '// switch here',
   'Not Found',
   'switch code { case 404: print("Not Found") default: print("OK") }',
   5, 20);
   -- ==============================================================
   -- UNIT 3: Functions and Closures
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 3: Functions & Closures', 'Build reusable code with functions, argument labels, and closures', 'orange', 3)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Functions and Closures', $note$
# Functions and Closures
## Defining a Function
Functions are defined using the func keyword. Return types are denoted with an arrow ->.
```swift
func add(a: Int, b: Int) -> Int {
    return a + b
}

```
## Calling a Function
By default, you must provide the parameter names when calling the function in Swift. This makes the code highly readable.
```swift
let sum = add(a: 5, b: 10)

```
## Argument Labels
Swift allows you to define an **Argument Label** (used when calling) and a **Parameter Name** (used inside the function body).
```swift
// 'to' is the argument label, 'name' is the parameter name
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Anthony") // Reads like English!

```
If you want to omit the label entirely when calling, use an underscore _.
```swift
func multiply(_ x: Int, _ y: Int) -> Int {
    return x * y
}
multiply(5, 5) // No labels required

```
## Multiple Return Values (Tuples)
Swift can return multiple values easily using Tuples.
```swift
func getMinMax() -> (min: Int, max: Int) {
    return (1, 100)
}
let bounds = getMinMax()
print(bounds.max) // 100

```
## Closures
Closures are self-contained blocks of functionality that can be passed around (like anonymous functions or lambdas).
```swift
let sayHi = { (name: String) -> Void in
    print("Hi \(name)")
}
sayHi("Bob")

```
$note$, 0);
-- Lesson 3.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Defining Functions', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Where does the return type go in a Swift function signature?',
'0',
'["After the parameter list, following an arrow ->","Before the function name","Inside the parentheses","It is not specified"]'::jsonb,
'E.g., func multiply(x: Int, y: Int) -> Int',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the keyword to define a function:',
'___ getUsername() -> String { return "Admin" }',
'func',
'["func","def","function","fn"]'::jsonb,
'Swift uses the func keyword.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If a function does not return any data, what is its return type?',
'0',
'["You simply omit the -> Type entirely (or it implicitly returns Void)","nil","null","empty"]'::jsonb,
'You just write func doSomething() { }.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a complete function that doubles a number and calls it:',
'[{"id":"1","code":"func double(n: Int) -> Int {"},{"id":"2","code":"  return n * 2"},{"id":"3","code":"}"},{"id":"4","code":"print(double(n: 5))"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["func double(n: Int) -> Int {","  return n * 2","}","print(double(n: 5))"]'::jsonb,
'Function signature, return statement, close, then call it with parameter label.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write func add(a: Int, b: Int) -> Int that returns their sum. Call it with 3 and 7, and print it. Expected: 10',
'import Foundation' || chr(10) || '// Write add func' || chr(10) || '// Call add and print',
'10',
'func add(a: Int, b: Int) -> Int { return a + b } print(add(a: 3, b: 7))',
5, 20);
-- Lesson 3.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Argument Labels', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why does Swift support distinct "Argument Labels" and "Parameter Names"?',
'0',
'["To allow functions to read like natural English when called, while maintaining clean variable names inside the function","To encrypt the variables","To prevent functions from returning values","Because objective-C required it"]'::jsonb,
'Example: func move(from start: Int, to end: Int). Calling it reads perfectly: move(from: 1, to: 5).',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'To allow calling a function WITHOUT writing the parameter name, use the underscore:',
'func printMsg(___ msg: String) { print(msg) }',
'*',
'["*","-","blank","nil"]'::jsonb,
'Using _ as the argument label means you can just call printMsg("Hello").',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If func greet(person name: String) is declared, how do you call it?',
'0',
'["greet(person: \"Alice\")","greet(name: \"Alice\")","greet(\"Alice\")","greet(person name: \"Alice\")"]'::jsonb,
'person is the argument label (used externally). name is the parameter name (used internally).',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a function with an argument label and call it:',
'[{"id":"1","code":"func sayHello(to name: String) {"},{"id":"2","code":"  print(\"Hi \\(name)\")"},{"id":"3","code":"}"},{"id":"4","code":"sayHello(to: \"Bob\")"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["func sayHello(to name: String) {","  print(\"Hi \\(name)\")","}","sayHello(to: \"Bob\")"]'::jsonb,
'Signature with label, body, close, call using label.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write func echo(_ val: Int) { print(val) }. Call it with 99 without using a label. Expected: 99',
'import Foundation' || chr(10) || '// Write func and call',
'99',
'func echo(_ val: Int) { print(val) }; echo(99)',
5, 20);
-- Lesson 3.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Tuples and Multiple Returns', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a Tuple in Swift?',
'0',
'["A comma-separated list of types/values enclosed in parentheses, useful for returning multiple values from a function","A dynamic array that can grow in size","A type of loop","A class inherited from Object"]'::jsonb,
'(String, Int) is a tuple type.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the return type to return a named tuple with an Int and a String:',
'func getUser() -> (id: ___, name: String) { return (1, "Admin") }',
'Int',
'["Int","int","Number","Double"]'::jsonb,
'Naming the tuple parameters makes them accessible via dot notation (e.g., user.id).',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you access the first element of an unnamed tuple let t = ("A", "B")?',
'0',
'["t.0","t[0]","t.first","t.A"]'::jsonb,
'Tuples use zero-indexed dot notation if they aren''t given specific names.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a function returning multiple values:',
'[{"id":"1","code":"func getCoords() -> (x: Int, y: Int) {"},{"id":"2","code":"  return (10, 20)"},{"id":"3","code":"}"},{"id":"4","code":"let pos = getCoords()"},{"id":"5","code":"print(pos.x)"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["func getCoords() -> (x: Int, y: Int) {","  return (10, 20)","}","let pos = getCoords()","print(pos.x)"]'::jsonb,
'Signature with tuple return, return statement, close, call function, access named property.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write func vals() -> (Int, Int) { return (5, 7) }. Call it, assign to let result = vals(). Print result.0. Expected: 5',
'import Foundation' || chr(10) || '// Write vals func' || chr(10) || '// Call and print',
'5',
'func vals() -> (Int, Int) { return (5, 7) } let result = vals(); print(result.0)',
5, 20);
-- Lesson 3.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Closures', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a Closure in Swift?',
'0',
'["A self-contained block of functionality that can be passed around and used in your code (like an anonymous function)","A function that terminates the app","A private class","A way to close files"]'::jsonb,
'Closures are often passed as arguments to other functions, especially for completion handlers in iOS.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the keyword that separates the closure''s parameters/return type from its body:',
'let greet = { (name: String) ___ print("Hi \(name)") }',
'in',
'["in","->","=>","do"]'::jsonb,
'The in keyword tells Swift that the closure header is finished, and the body is starting.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What are $0 and $1 in a Swift closure?',
'0',
'["Shorthand argument names provided by Swift, representing the first and second arguments passed to the closure","Memory addresses","Errors","Money values"]'::jsonb,
'This allows you to write incredibly short closures: let sum = { $0 + $1 }.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to create and call a closure:',
'[{"id":"1","code":"let square = { (n: Int) -> Int in"},{"id":"2","code":"  return n * n"},{"id":"3","code":"}"},{"id":"4","code":"print(square(4))"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let square = { (n: Int) -> Int in","  return n * n","}","print(square(4))"]'::jsonb,
'Closure definition with in, body, close, call the closure variable.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Assign let double = { (n: Int) in return n * 2 }. Print double(5). Expected: 10',
'import Foundation' || chr(10) || '// Define closure and print result',
'10',
'let double = { (n: Int) in return n * 2 }; print(double(5))',
5, 20);
-- ==============================================================
-- UNIT 4: Collections and Optionals
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 4: Collections & Optionals', 'Work with Arrays, Dictionaries, and master Optionals to prevent crashes', 'purple', 4)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Collections and Optionals', $note$
# Collections and Optionals
## Arrays
An ordered collection of values of the same type.
```swift
var nums = [1, 2, 3]
nums.append(4) // Adds to the end

print(nums[0]) // 1
print(nums.count) // 4

```
## Dictionaries
An unordered collection of key-value pairs.
```swift
var scores: [String: Int] = ["Alice": 100, "Bob": 85]
scores["Charlie"] = 90

print(scores["Alice"]) // Optional(100)

```
Notice it prints Optional(100). Why? Because the key might not exist!
## Optionals ?
Swift does not have null. It has nil. But a normal variable CANNOT be nil.
If a value might be missing, it must be declared as an Optional using ?.
```swift
var name: String? = "Anthony"
name = nil // Valid!

```
## Unwrapping Optionals
Before using an Optional, you must "unwrap" it to prove a value exists.
**1. Forced Unwrapping ! (Dangerous)**
Crashes the app if the value is nil.
```swift
print(name!) 

```
**2. Optional Binding if let (Safe)**
Runs the block only if the optional has a value.
```swift
if let safeName = name {
    print(safeName)
} else {
    print("Name is nil")
}

```
**3. Nil-Coalescing ?? (Default Value)**
Provides a default value if nil.
```swift
let finalName = name ?? "Anonymous"

```
$note$, 0);
-- Lesson 4.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Arrays', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you declare an array type of Strings in Swift?',
'0',
'["[String]","Array<String>","String[]","List<String>"]'::jsonb,
'Both [String] and Array<String> work, but [String] is the standard, preferred Swift syntax.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to dynamically add "Go" to an array of strings:',
'langs.___("Go")',
'append',
'["append","push","add","insert"]'::jsonb,
'The .append() method adds elements to the end of an array.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which property gives you the number of elements in an array?',
'0',
'["array.count","array.length","array.size()","array.capacity"]'::jsonb,
'Swift uses .count for all collections (Arrays, Dictionaries, Sets) and Strings.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to create an array, append an item, and print it:',
'[{"id":"1","code":"var nums = [1, 2]"},{"id":"2","code":"nums.append(3)"},{"id":"3","code":"print(nums[2])"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["var nums = [1, 2]","nums.append(3)","print(nums[2])"]'::jsonb,
'Declare array, append to it, print index 2.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create an array var a = [7]. Append 10 to it. Print a[1]. Expected: 10',
'import Foundation' || chr(10) || '// Create array, append, print',
'10',
'var a = [7]; a.append(10); print(a[1])',
5, 20);
-- Lesson 4.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Dictionaries', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the type syntax for a Dictionary with String keys and Int values?',
'0',
'["[String: Int]","Dict<String, Int>","{String: Int}","Map[String]Int"]'::jsonb,
'Dictionaries use brackets with a colon separating key and value types.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the initialization of an empty dictionary:',
'var scores = [String: Int]___',
'()',
'["()","{}","[]","new"]'::jsonb,
'Because [String: Int] is a type, adding () calls its initializer to create an empty instance.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why does accessing a dictionary by key (e.g., scores["Alice"]) return an Optional type?',
'0',
'["Because the key might not exist in the dictionary, which would return nil","Because dictionaries encrypt data","To make it faster","Because values can be any type"]'::jsonb,
'Swift is safe. Since "Alice" might not be in the dictionary, it returns an Int? (Optional Int) instead of crashing.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to create a dict, assign a value, and read it safely with a default:',
'[{"id":"1","code":"var m = [String: Int]()"},{"id":"2","code":"m[\"Apples\"] = 5"},{"id":"3","code":"let val = m[\"Apples\"] ?? 0"},{"id":"4","code":"print(val)"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["var m = [String: Int]()","m[\"Apples\"] = 5","let val = m[\"Apples\"] ?? 0","print(val)"]'::jsonb,
'Make map, assign key, read with ?? default, print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create a dict using a literal: var m = ["A": 1]. Print the value of "A" using default ?? 0. Expected: 1',
'import Foundation' || chr(10) || '// Map literal and print',
'1',
'var m = ["A": 1]; print(m["A"] ?? 0)',
5, 20);
-- Lesson 4.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Optionals', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does appending a ? to a type (e.g., String?) do?',
'0',
'["It makes it an Optional, meaning the variable can either hold a String or be nil","It makes it a boolean condition","It makes the variable a random value","It makes it required"]'::jsonb,
'In Swift, normal types CANNOT be nil. Optionals solve the "billion-dollar mistake" of null pointer exceptions.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to force unwrap an optional (crashing if it is nil):',
'print(name___)',
'!',
'["!","?","unwrap","force"]'::jsonb,
'The exclamation mark ! forcefully extracts the value. Only use it if you are 100% sure it is not nil.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the Nil-Coalescing Operator ?? do?',
'0',
'["It unwraps an optional, but provides a default value if the optional is nil","It compares two optionals to see if they are both nil","It forces a crash","It combines two strings"]'::jsonb,
'let name = optionalName ?? "Anonymous" is a safe, clean way to handle missing data.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to safely provide a default value for an Optional:',
'[{"id":"1","code":"var age: Int? = nil"},{"id":"2","code":"let safeAge = age ?? 18"},{"id":"3","code":"print(safeAge)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["var age: Int? = nil","let safeAge = age ?? 18","print(safeAge)"]'::jsonb,
'Declare nil optional, coalesce with ??, print result.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given var x: Int? = 5. Print it using ! to force unwrap. Expected: 5',
'import Foundation' || chr(10) || 'var x: Int? = 5' || chr(10) || '// Force unwrap and print',
'5',
'print(x!)',
5, 20);
-- Lesson 4.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Optional Binding (if let)', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is "Optional Binding" (if let) used for?',
'0',
'["To safely unwrap an optional: if it has a value, assign it to a temporary constant and execute the block","To bind a variable to the internet","To force an app to crash","To check if two variables are identical"]'::jsonb,
'if let safeVar = optionalVar { ... } is the most common way to handle Optionals in Swift.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the optional binding syntax:',
'if ___ safeName = optName { print(safeName) }',
'let',
'["let","var","bind","unwrap"]'::jsonb,
'if let creates a new, unwrapped constant that is only available inside the {} block.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if the optional is nil during an if let evaluation?',
'0',
'["The if block is skipped entirely (or execution jumps to an else block if provided)","The app crashes","The compiler throws an error","The variable becomes 0"]'::jsonb,
'It safely avoids the crash that ! would cause.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the safe unwrapping of an optional:',
'[{"id":"1","code":"let opt: Int? = 10"},{"id":"2","code":"if let val = opt {"},{"id":"3","code":"  print(val)"},{"id":"4","code":"} else {"},{"id":"5","code":"  print(\"Missing\") }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["let opt: Int? = 10","if let val = opt {","  print(val)","} else {","  print(\"Missing\") }"]'::jsonb,
'Declare Optional, if let, print unwrapped val, else, print missing.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given var v: String? = "Safe". Use if let to unwrap it into s, then print s. Expected: Safe',
'import Foundation' || chr(10) || 'var v: String? = "Safe"' || chr(10) || '// Write if let',
'Safe',
'if let s = v { print(s) }',
5, 20);
-- ==============================================================
-- UNIT 5: Structs, Classes, and OOP
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 5: Structs & Classes', 'Understand Value Types vs Reference Types and Object-Oriented patterns', 'teal', 5)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Structs and Classes', $note$
# Structs and Classes
In Swift, you can model custom data using struct or class. They look similar but behave very differently.
## Structs (Value Types)
Apple heavily prefers Structs. When you assign a struct to a new variable, it creates a **copy**.
```swift
struct Point {
    var x: Int
    var y: Int
}
var p1 = Point(x: 0, y: 0) // Auto-generated initializer!
var p2 = p1
p2.x = 5 
// p1.x is still 0. They are independent copies.

```
## Classes (Reference Types)
Classes share the same memory instance. If you change a copy, you change the original. Classes also support inheritance.
```swift
class Animal {
    var name: String
    
    // Classes REQUIRE you to write an initializer if there are no default values
    init(name: String) {
        self.name = name
    }
}

```
## Methods and Mutating
Methods are functions inside structs/classes. Because Structs are Value Types, their methods cannot modify their own properties unless explicitly marked as mutating.
```swift
struct Counter {
    var count = 0
    mutating func increment() {
        count += 1
    }
}

```
Classes don't need the mutating keyword because they are Reference Types.
## Key Takeaways
 * Use **Structs** by default (they are safer, faster, and represent "Values").
 * Use **Classes** when you need shared, mutable state (Reference Types) or Objective-C interoperability.
 * Structs get a free memberwise initializer; Classes do not.
 * Struct methods must be mutating to change properties.
   $note$, 0);
   -- Lesson 5.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Structs (Value Types)', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does it mean that Structs are "Value Types" in Swift?',
   '0',
   '["When assigned to a new variable or passed to a function, they are copied. Modifying the copy does not affect the original","They share the same memory location","They can only hold integers","They require the new keyword"]'::jsonb,
   'This behavior prevents accidental bugs where changing one object ruins data elsewhere in the app.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to define a struct:',
   '___ User { var name: String }',
   'struct',
   '["struct","class","type","func"]'::jsonb,
   'Structs are the foundational building block of data in Swift and SwiftUI.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What convenient feature does Swift provide automatically for Structs but NOT for Classes?',
   '0',
   '["A memberwise initializer (e.g., User(name: \"Bob\"))","Automatic memory management","Inheritance","Deinitializers"]'::jsonb,
   'You don''t have to write an init() method for a struct unless you want custom logic.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Define a Point struct and instantiate it:',
   '[{"id":"1","code":"struct Point {"},{"id":"2","code":"  var x: Int"},{"id":"3","code":"}"},{"id":"4","code":"let p = Point(x: 10)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["struct Point {","  var x: Int","}","let p = Point(x: 10)"]'::jsonb,
   'Type definition open, field, close, instantiate with auto-initializer.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Define struct Box { var size: Int }. Create b = Box(size: 8). Print b.size. Expected: 8',
   'import Foundation' || chr(10) || '// Define struct' || chr(10) || '// Instantiate and print',
   '8',
   'struct Box { var size: Int }; let b = Box(size: 8); print(b.size)',
   5, 20);
   -- Lesson 5.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Classes (Reference Types)', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does it mean that Classes are "Reference Types" in Swift?',
   '0',
   '["When assigned to a new variable, it points to the exact same memory instance. Changing one changes the other","They are copied automatically","They can only reference memory addresses","They cannot be mutated"]'::jsonb,
   'If A and B point to the same Class instance, modifying A.name also changes B.name.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'To set up initial values in a Class, you MUST write this special method:',
   '___(name: String) { self.name = name }',
   'init',
   '["init","setup","constructor","start"]'::jsonb,
   'Classes require an explicit initializer init() if properties don''t have default values.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which feature is exclusive to Classes and not available on Structs?',
   '0',
   '["Inheritance (e.g., class Dog: Animal)","Methods","Properties","Protocols"]'::jsonb,
   'Only classes can inherit traits and behaviors from another class in Swift.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange an inheritance hierarchy:',
   '[{"id":"1","code":"class Vehicle { }"},{"id":"2","code":"class Car: Vehicle {"},{"id":"3","code":"  var speed = 0"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Vehicle { }","class Car: Vehicle {","  var speed = 0","}"]'::jsonb,
   'Base class, derived class with colon, property, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given class Base { var a=1 }. Make class Sub: Base { var b=2 }. Make an instance of Sub, print instance.a + instance.b. Expected: 3',
   'import Foundation' || chr(10) || 'class Base { var a = 1 }' || chr(10) || '// Extend and log',
   '3',
   'class Sub: Base { var b = 2 }; let s = Sub(); print(s.a + s.b)',
   5, 20);
   -- Lesson 5.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Methods and Mutating', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'By default, can a method inside a struct modify the struct''s own properties?',
   '0',
   '["No, you must mark the method with the mutating keyword","Yes, anytime","Yes, but only if the properties are let","No, structs cannot have methods"]'::jsonb,
   'Because structs are value types, mutating them effectively creates a new struct under the hood. Swift makes you explicitly declare this intent.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to allow a struct method to modify its properties:',
   '___ func increment() { count += 1 }',
   'mutating',
   '["mutating","mut","var","override"]'::jsonb,
   'mutating func is required for Value Types (Structs and Enums) to modify self.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Do class methods require the mutating keyword to modify their properties?',
   '0',
   '["No, classes are reference types, so their properties can always be mutated (if declared with var)","Yes, exactly like structs","Yes, but only in initializers","No, classes cannot be mutated"]'::jsonb,
   'Because a class instance exists in exactly one place in memory, modifying it doesn''t require replacing the whole value.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a struct with a mutating method:',
   '[{"id":"1","code":"struct Counter {"},{"id":"2","code":"  var val = 0"},{"id":"3","code":"  mutating func bump() {"},{"id":"4","code":"    val += 1 } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["struct Counter {","  var val = 0","  mutating func bump() {","    val += 1 } }"]'::jsonb,
   'Struct def, property, mutating func signature, body and closes.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given struct Item { var price = 10 }. Add mutating func discount() { price -= 2 }. Create a var item, call discount(), print price. Expected: 8',
   'import Foundation' || chr(10) || 'struct Item {' || chr(10) || '    var price = 10' || chr(10) || '    // write mutating func' || chr(10) || '}' || chr(10) || '// create, call, print',
   '8',
   'struct Item { var price = 10; mutating func discount() { price -= 2 } }; var i = Item(); i.discount(); print(i.price)',
   5, 20);
   -- Lesson 5.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Initialization', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the primary purpose of init() in Swift?',
   '0',
   '["To ensure all properties of an instance are assigned an initial value before the instance is used","To delete the object","To reset the app","To define the class name"]'::jsonb,
   'Swift has strict safety rules: an object cannot exist in memory if its properties are undefined or nil (unless they are Optionals).',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword used inside an initializer to refer to the instance''s own property (to disambiguate from parameters):',
   '___ .name = name',
   'self',
   '["self","this","super","my"]'::jsonb,
   'self in Swift is equivalent to this in Java/C++/C#.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If a class has properties that are Optionals (e.g., var age: Int?), do they need to be initialized in init()?',
   '0',
   '["No, Optionals are automatically initialized to nil","Yes, to 0","Yes, to nil explicitly","Yes, they cause an error otherwise"]'::jsonb,
   'Optionals provide a free pass on initialization because "no value" (nil) is a valid state for them.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a class with an initializer:',
   '[{"id":"1","code":"class User {"},{"id":"2","code":"  var id: Int"},{"id":"3","code":"  init(id: Int) {"},{"id":"4","code":"    self.id = id } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class User {","  var id: Int","  init(id: Int) {","    self.id = id } }"]'::jsonb,
   'Class open, uninitialized field, init method, assign self.field and close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print exactly: self',
   'import Foundation' || chr(10) || '// just print it',
   'self',
   'print("self")',
   5, 20);
   -- ==============================================================
   -- UNIT 6: Advanced Swift
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 6: Advanced Swift', 'Enums, Protocols, Extensions, and Error Handling', 'red', 6)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Advanced Swift', $note$
# Advanced Swift Concepts
## Enumerations (Enums)
Enums define a common type for a group of related values. In Swift, enums are incredibly powerful and can even store **Associated Values**.
```swift
enum Result {
    case success(String)
    case failure(Int) // Storing an error code
}

let status = Result.success("Data loaded")

```
## Protocols
A protocol defines a blueprint of methods or properties (like an Interface in Java/C#). Structs, classes, and enums can adopt protocols.
```swift
protocol Identifiable {
    var id: String { get }
}

struct User: Identifiable {
    var id: String
}

```
## Extensions
Extensions add new functionality to an existing class, structure, enumeration, or protocol type—even if you don't have access to the original source code!
```swift
extension Int {
    func squared() -> Int {
        return self * self
    }
}
print(5.squared()) // 25

```
## Error Handling
Swift uses do, try, and catch to handle expected errors gracefully.
```swift
enum FileError: Error {
    case notFound
}

func readFile() throws {
    throw FileError.notFound
}

do {
    try readFile()
} catch {
    print("An error occurred")
}

```
## Key Takeaways
 * **Enums** can store specific data (Associated Values) alongside their cases.
 * **Protocols** act as contracts/blueprints.
 * **Extensions** let you add functions to existing types (even built-in ones like Int or String).
 * Use do-try-catch to handle functions marked with throws.
   $note$, 0);
   -- Lesson 6.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Enumerations (Enums)', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a major advantage of Swift Enums over traditional C-style enums?',
   '0',
   '["Swift enums can store arbitrary data types directly alongside the case (Associated Values)","Swift enums are always strings","Swift enums are faster","Swift enums can inherit from each other"]'::jsonb,
   'e.g., case barcode(String) or case qrCode(Int, Int, Int).',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the declaration of an enum case:',
   'enum Direction { ___ north }',
   'case',
   '["case","let","var","const"]'::jsonb,
   'Each value inside an enum is introduced with the case keyword.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'When you use a switch statement on an Enum, what does the Swift compiler enforce?',
   '0',
   '["Exhaustiveness: you must write a case for every single enum value (or provide a default)","That you use strings","That you mutate the enum","Nothing"]'::jsonb,
   'This is a massive safety feature. If you add a new enum case later, the compiler will break and remind you to handle it everywhere!',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange to create an enum and instantiate a variant:',
   '[{"id":"1","code":"enum Status {"},{"id":"2","code":"  case ok, error"},{"id":"3","code":"}"},{"id":"4","code":"let s = Status.ok"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["enum Status {","  case ok, error","}","let s = Status.ok"]'::jsonb,
   'Enum open, cases, enum close, instantiation.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given enum Role { case admin }. Create let r = Role.admin and print it. Expected: admin',
   'import Foundation' || chr(10) || '// Write enum and print',
   'admin',
   'enum Role { case admin }; let r = Role.admin; print(r)',
   5, 20);
   -- Lesson 6.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Protocols', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What feature in other languages are Swift Protocols most comparable to?',
   '0',
   '["Interfaces (like in Java or C#)","Classes","Structs","Macros"]'::jsonb,
   'Protocols define a blueprint of methods, properties, and other requirements that suit a particular task.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the syntax to declare a protocol:',
   '___ Describable { func description() }',
   'protocol',
   '["protocol","interface","contract","struct"]'::jsonb,
   'protocol Name { ... } is the standard syntax.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How does a struct "adopt" (implement) a protocol?',
   '0',
   '["By appending a colon : and the protocol name to the struct declaration (e.g., struct User: Describable)","Using the implements keyword","By embedding it","Protocols can only be adopted by classes"]'::jsonb,
   'The colon : syntax is used for both class inheritance and protocol adoption.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the definition and implementation of a protocol:',
   '[{"id":"1","code":"protocol Speak { func speak() }"},{"id":"2","code":"struct Dog: Speak {"},{"id":"3","code":"  func speak() { print(\"Bark\") }"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["protocol Speak { func speak() }","struct Dog: Speak {","  func speak() { print(\"Bark\") }","}"]'::jsonb,
   'Protocol definition, Struct adopting protocol, body of required method, close struct.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print exactly: protocol',
   'import Foundation' || chr(10) || '// print it',
   'protocol',
   'print("protocol")',
   5, 20);
   -- Lesson 6.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Extensions', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does an Extension allow you to do in Swift?',
   '0',
   '["Add new functionality (methods, computed properties) to an existing class, struct, or protocol\u2014even if you don''t have the source code","Delete code from a class","Override existing methods","Change stored properties"]'::jsonb,
   'Extensions are extremely powerful. You can add methods to Apple''s own types, like Int or String!',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to add functionality to the built-in Double type:',
   '___ Double { func squared() -> Double { return self * self } }',
   'extension',
   '["extension","extend","impl","add"]'::jsonb,
   'extension Type { ... } allows you to inject new capabilities into Type.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can extensions add NEW stored properties (variables that hold raw data in memory)?',
   '0',
   '["No, extensions can only add computed properties (which calculate their value) and methods","Yes, they can add stored properties","Yes, but only to classes","No, they cannot add properties of any kind"]'::jsonb,
   'Extensions cannot change the memory layout of a type, which means no new stored variables.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange an extension that adds a method to Int:',
   '[{"id":"1","code":"extension Int {"},{"id":"2","code":"  func isEven() -> Bool {"},{"id":"3","code":"    return self % 2 == 0 } }"},{"id":"4","code":"print(4.isEven())"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["extension Int {","  func isEven() -> Bool {","    return self % 2 == 0 } }","print(4.isEven())"]'::jsonb,
   'Signature with extension, method definition, return logic and closes, usage.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Extend Int with func doubled() -> Int { return self * 2 }. Print 5.doubled(). Expected: 10',
   'import Foundation' || chr(10) || '// Write extension and print',
   '10',
   'extension Int { func doubled() -> Int { return self * 2 } }; print(5.doubled())',
   5, 20);
   -- Lesson 6.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Error Handling', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you mark a function to indicate that it might produce an error?',
   '0',
   '["By placing the throws keyword before the return type ->","By returning a boolean","By placing error at the start","By using throws inside the body"]'::jsonb,
   'Example: func readFile() throws -> String',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'To call a function that is marked with throws, you MUST prefix the call with:',
   'let data = ___ readFile()',
   'try',
   '["try","do","catch","await"]'::jsonb,
   'try acknowledges that you know the function might fail, forcing you to handle it.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What block structure is used to catch and handle errors gracefully?',
   '0',
   '["do { try ... } catch { ... }","try { ... } catch { ... }","attempt { ... } error { ... }","if let error = try ..."]'::jsonb,
   'Swift uses a do block to encapsulate the throwing code, followed immediately by catch.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the safe error handling block:',
   '[{"id":"1","code":"do {"},{"id":"2","code":"  try riskyFunction()"},{"id":"3","code":"} catch {"},{"id":"4","code":"  print(\"Failed\") } "}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["do {","  try riskyFunction()","} catch {","  print(\"Failed\") } "]'::jsonb,
   'do block open, try call, catch block open, handle error.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print exactly: try catch',
   'import Foundation' || chr(10) || '// print it',
   'try catch',
   'print("try catch")',
   5, 20);
END $$;

