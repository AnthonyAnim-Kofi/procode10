-- ============================================================
-- REAL TYPESCRIPT CURRICULUM
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

  -- Prefer slug 'typescript' (used by the app); fall back to 'ts' if present.
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug IN ('typescript', 'ts')
  ORDER BY CASE WHEN slug = 'typescript' THEN 0 ELSE 1 END
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('TypeScript', 'typescript', '🟦', 'JavaScript with syntax for types. Build robust, scalable web applications.')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with TypeScript
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Understand static typing, compilation, and basic primitives', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to TypeScript', $note$
# Introduction to TypeScript

TypeScript is a strongly typed programming language that builds on JavaScript, giving you better tooling at any scale. It catches errors at compile time before your code runs in the browser or Node.js environment.

## Your First TypeScript Code

```typescript
let message: string = "Hello, TypeScript!";
console.log(message);

```

Breaking it down:

* `let message: string` — We explicitly tell TypeScript this variable can only hold text.
* `console.log(message)` — Standard JavaScript output.
* Every valid JS file is a valid TS file, but TS adds type safety.

## How TypeScript Runs

Browsers don't understand TypeScript. It must be compiled to JavaScript:

1. Write `app.ts`
2. Compile using the TS Compiler: `tsc app.ts`
3. This generates `app.js`, which you then run.

## Basic Primitives

TypeScript uses lowercase for its primitive types:

```typescript
let indexNumber: number = 10452;
let gpa: number = 3.8;
let isLoggedIn: boolean = true;
let studentName: string = "Anthony";

```

## Type Inference

You don't always have to write the type. TypeScript is smart:

```typescript
let group = "Group 1"; // TS infers this is a string
// group = 5; // Error: Type 'number' is not assignable to type 'string'.

```

## Arrays

```typescript
let scores: number[] = [90, 85, 100];
let modules: string[] = ["HCI", "DSA", "Architecture"];

```

## Key Takeaways

* TypeScript is a superset of JavaScript that adds static typing.
* It catches bugs during compilation, not at runtime.
* Types include `string`, `number`, `boolean`, and arrays like `type[]`.
* Type inference saves you from writing types everywhere.
$note$, 0);
-- Lesson 1.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Hello, TypeScript!', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What must happen to TypeScript code before a web browser can run it?',
'0',
'["It must be compiled into standard JavaScript", "It runs directly in the browser using a script tag", "It is converted to C++", "It is interpreted by CSS"]'::jsonb,
'Browsers only understand HTML, CSS, and JavaScript. TypeScript requires compilation using tsc.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the command used to compile a file named app.ts:',
'___ app.ts',
'tsc',
'["tsc", "ts-run", "node", "compile"]'::jsonb,
'tsc stands for TypeScript Compiler.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which statement about TypeScript is true?',
'0',
'["Every valid JavaScript file is also a valid TypeScript file", "TypeScript replaces JavaScript completely", "TypeScript does not support modern JS features", "Variables in TypeScript can never change types"]'::jsonb,
'TypeScript is a strict syntactical superset of JavaScript.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the steps to set up a basic text variable and log it:',
'[{"id":"1","code":"let appName: string;"},{"id":"2","code":"appName = \"EduManage\";"},{"id":"3","code":"console.log(appName);"}]'::jsonb,
'["1","2","3"]'::jsonb,
'["let appName: string;","appName = \"EduManage\";","console.log(appName);"]'::jsonb,
'Declare the variable with its type, assign it a string, then log it.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Declare a variable `greeting` of type string with the value "Hello TS!" and log it.',
'// Write your code here',
'Hello TS!',
'let greeting: string = "Hello TS!"; console.log(greeting);',
5, 20);

-- Lesson 1.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Primitive Types', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which primitive type would you use for a student''s index number (e.g., 102345)?',
'0',
'["number", "int", "float", "String"]'::jsonb,
'Unlike C++, TypeScript only has one numeric type: `number` (lowercase).',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the type annotation for a boolean flag:',
'let isEnrolled: ___ = true;',
'boolean',
'["boolean", "bool", "Boolean", "true"]'::jsonb,
'Always use lowercase primitive names like boolean, string, and number in TypeScript.',
2, 15);

INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens here: `let group = "Group 1"; group = 5;`?',
'0',
'["TypeScript throws a compile-time error", "It works perfectly", "It converts 5 to a string", "The program crashes at runtime"]'::jsonb,
'Due to type inference, TS knows `group` is a string. Assigning a number triggers an error.',
3, 10);

INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Declare a number, a string, and a boolean in that exact order:',
'[{"id":"1","code":"let limit: number = 50;"},{"id":"2","code":"let title: string = \"School Hub\";"},{"id":"3","code":"let isActive: boolean = true;"}]'::jsonb,
'["1","2","3"]'::jsonb,
'["let limit: number = 50;","let title: string = \"School Hub\";","let isActive: boolean = true;"]'::jsonb,
'number first, string second, boolean third.',
4, 15);

INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Declare `age` as 20 and log it. Expected: 20',
'// Declare age and log',
'20',
'let age: number = 20; console.log(age);',
5, 20);

-- Lesson 1.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Arrays and Tuples', 3) RETURNING id INTO v_lesson_id;

INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you declare an array of numbers in TypeScript?',
'0',
'["number[]", "Array[number]", "numbers", "int[]"]'::jsonb,
'Appending [] to a type creates an array of that type.',
1, 10);

INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the type for an array of strings:',
'let modules: ___ = ["HCI", "DSA"];',
'string[]',
'["string[]", "Array", "String", "strings"]'::jsonb,
'string[] guarantees every item pushed into the array must be text.',
2, 15);

INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a Tuple in TypeScript?',
'0',
'["A fixed-length array where each element has a known type", "A dynamic list of strings", "An object with two properties", "A read-only number"]'::jsonb,
'Tuples allow you to express an array with a fixed number of elements whose types are known, like [string, number].',
3, 10);

INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create a tuple representing a student name and their score:',
'[{"id":"1","code":"let record: [string, number];"},{"id":"2","code":"record = [\"Anthony\", 95];"},{"id":"3","code":"console.log(record[0]);"}]'::jsonb,
'["1","2","3"]'::jsonb,
'["let record: [string, number];","record = [\"Anthony\", 95];","console.log(record[0]);"]'::jsonb,
'Declare tuple type, initialize with exact match, then log.',
4, 15);

INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create a string array `stack` with "React" and "Next.js", then log the second item. Expected: Next.js',
'// Create array and log index 1',
'Next.js',
'let stack: string[] = ["React", "Next.js"]; console.log(stack[1]);',
5, 20);

-- Lesson 1.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Any and Unknown', 4) RETURNING id INTO v_lesson_id;

INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `any` type do?',
'0',
'["Bypasses TypeScript''s type checking entirely", "Makes a variable strictly a string or number", "Prevents reassignment", "Enforces strict null checks"]'::jsonb,
'Using `any` turns off type safety. Use it sparingly when migrating old JS code.',
1, 10);

INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the safer alternative to `any` that requires type checking before use:',
'let data: ___ = fetchAPI();',
'unknown',
'["unknown", "any", "void", "null"]'::jsonb,
'`unknown` means "I don''t know the type yet." You must narrow it before calling methods on it.',
2, 15);

INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why is `unknown` preferred over `any`?',
'0',
'["It forces you to perform type checks before using the variable", "It is faster to compile", "It uses less memory", "It automatically converts to strings"]'::jsonb,
'`any` lets you call non-existent methods (crashing at runtime). `unknown` throws a compile error until you check the type.',
3, 10);

INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Safely use an unknown variable by checking its type first:',
'[{"id":"1","code":"let val: unknown = \"Testing\";"},{"id":"2","code":"if (typeof val === \"string\") {"},{"id":"3","code":"  console.log(val.toUpperCase());"},{"id":"4","code":"}"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["let val: unknown = \"Testing\";","if (typeof val === \"string\") {","  console.log(val.toUpperCase());","}"]'::jsonb,
'Declare unknown, check typeof, safely use string method, close block.',
4, 15);

INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Declare an `any` variable `x = 5`, then set `x = "Hello"` and log it. Expected: Hello',
'// Declare any, reassign, log',
'Hello',
'let x: any = 5; x = "Hello"; console.log(x);',
5, 20);

-- ==============================================================
-- UNIT 2: Control Flow
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 2: Control Flow', 'Decisions, loops, and type narrowing in TypeScript', 'green', 2)
RETURNING id INTO v_unit_id;

INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Control Flow & Type Narrowing', $note$

# Control Flow in TypeScript

Control flow works exactly like JavaScript, but TypeScript uses it to **narrow types** intelligently.

## if / else if / else

```typescript
let score: number = 85;

if (score >= 90) {
    console.log("A");
} else if (score >= 80) {
    console.log("B");
} else {
    console.log("F");
}

```

## Loops

`for...of` loops over values (great for arrays):

```typescript
let modules = ["HCI", "DSA"];
for (let mod of modules) {
    console.log(mod);
}

```

Standard `for` loop:

```typescript
for (let i = 0; i < 3; i++) {
    console.log(i);
}

```

## Type Narrowing

TypeScript watches your `if` statements. If a variable could be a `string` or a `number`, checking `typeof` "narrows" the type inside the block.

```typescript
function printId(id: string | number) {
    if (typeof id === "string") {
        // In here, TS knows id is a string
        console.log(id.toUpperCase());
    } else {
        // In here, TS knows id is a number
        console.log(id * 2);
    }
}

```

## switch Statements

```typescript
let role = "admin";
switch (role) {
    case "admin":
        console.log("Full Access");
        break;
    case "student":
        console.log("Read Only");
        break;
    default:
        console.log("No Access");
}

```

## Key Takeaways

* Use `===` for strict equality (avoid `==`).
* `for...of` is the cleanest way to iterate over arrays.
* TypeScript analyzes your logic branches to understand what type a variable is at any given line (Type Narrowing).
$note$, 0);

-- Lesson 2.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Conditions and Strict Equality', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which operator should you use for equality checks in TypeScript to prevent type coercion?',
'0',
'["=== (Strict Equality)", "== (Loose Equality)", "=", "equals"]'::jsonb,
'Always use ===. `==` allows 5 == "5" to be true, which defeats the purpose of static typing.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the condition to check if an API request failed:',
'if (status ___ 200) { console.log("Error"); }',
'!==',
'["!==", "!=", "not", "==="]'::jsonb,
'!== is strict inequality. It checks both value and type.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the output of `console.log(10 > 5 ? "Yes" : "No");`?',
'0',
'["Yes", "No", "true", "undefined"]'::jsonb,
'The ternary operator evaluates 10 > 5 as true, returning the first string.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange an if/else block that checks permissions:',
'[{"id":"1","code":"let isAdmin = false;"},{"id":"2","code":"if (isAdmin) {"},{"id":"3","code":"  console.log(\"Dashboard\");"},{"id":"4","code":"} else {"},{"id":"5","code":"  console.log(\"Access Denied\"); }"}]'::jsonb,
'["1","2","3","4","5"]'::jsonb,
'["let isAdmin = false;","if (isAdmin) {","  console.log(\"Dashboard\");","} else {","  console.log(\"Access Denied\"); }"]'::jsonb,
'Declare, open if, log success, else, log failure.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write an if statement: if score (75) is >= 50, log "Pass", else "Fail". Expected: Pass',
'let score: number = 75;' || chr(10) || '// Write if/else',
'Pass',
'if (score >= 50) console.log("Pass"); else console.log("Fail");',
5, 20);

-- Lesson 2.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Loops and Iteration', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which loop is best for directly accessing the values of an array `let grades = [90, 85];`?',
'0',
'["for...of", "for...in", "while", "do...while"]'::jsonb,
'`for (let grade of grades)` loops through the values. `for...in` loops through the index numbers.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the loop to iterate over items in a cart:',
'for (let item ___ cart) { console.log(item); }',
'of',
'["of", "in", "to", "from"]'::jsonb,
'Use `of` for arrays and iterables. `in` is for object keys.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `continue` keyword do?',
'0',
'["Skips the current iteration and moves to the next one", "Exits the loop entirely", "Restarts the loop", "Throws an error"]'::jsonb,
'`continue` jumps to the next cycle of the loop. `break` stops the loop completely.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Iterate over an array and print each module:',
'[{"id":"1","code":"let modules = [\"HCI\", \"DSA\"];"},{"id":"2","code":"for (let mod of modules) {"},{"id":"3","code":"  console.log(mod);"},{"id":"4","code":"}"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["let modules = [\"HCI\", \"DSA\"];","for (let mod of modules) {","  console.log(mod);","}"]'::jsonb,
'Declare array, open for...of, log, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Use a basic `for` loop (let i=0; i<3; i++) to log 0, 1, 2 on separate lines.',
'// Loop and log',
'0' || chr(10) || '1' || chr(10) || '2',
'for(let i=0; i<3; i++) console.log(i);',
5, 20);

-- Lesson 2.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Type Narrowing', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If `id` is typed as `string | number`, what does TypeScript do after `if (typeof id === "string")`?',
'0',
'["It allows you to use string methods (like .toUpperCase()) safely inside that block", "It throws an error", "It permanently converts id to a string", "It converts id to a number"]'::jsonb,
'This is called Type Narrowing. TS is smart enough to limit the type within the conditional block.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the type guard keyword:',
'if (___ input === "number") { ... }',
'typeof',
'["typeof", "instanceof", "type", "class"]'::jsonb,
'`typeof` returns a string representing the primitive type (e.g., "number", "string", "boolean").',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which of these is NOT a valid string returned by `typeof`?',
'0',
'["array", "string", "number", "boolean"]'::jsonb,
'In JavaScript/TypeScript, arrays are technically objects. `typeof []` returns "object", not "array".',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to correctly narrow a value and double it if it''s a number:',
'[{"id":"1","code":"let val: number | string = 5;"},{"id":"2","code":"if (typeof val === \"number\") {"},{"id":"3","code":"  console.log(val * 2);"},{"id":"4","code":"}"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["let val: number | string = 5;","if (typeof val === \"number\") {","  console.log(val * 2);","}"]'::jsonb,
'Declare union, type guard, safe math operation, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Check if `val: any = "hello"` is a string. If so, log its length property. Expected: 5',
'let val: any = "hello";' || chr(10) || '// Write typeof check',
'5',
'if (typeof val === "string") console.log(val.length);',
5, 20);

-- Lesson 2.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Switch Statements', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What must usually be placed at the end of a `case` block in a switch statement?',
'0',
'["break;", "stop;", "return;", "continue;"]'::jsonb,
'Without `break`, the code will "fall through" and execute the next cases even if they don''t match.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the keyword for the fallback scenario in a switch:',
'___ : console.log("Not found");',
'default',
'["default", "else", "catch", "fallback"]'::jsonb,
'The `default` case runs if no other `case` matches the expression.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How does TypeScript evaluate `case` matches?',
'0',
'["Using strict equality (===)", "Using loose equality (==)", "Using greater/less than", "It only checks types"]'::jsonb,
'Switch statements in TS/JS use strict equality under the hood.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a switch statement that handles API roles:',
'[{"id":"1","code":"let role = \"admin\";"},{"id":"2","code":"switch (role) {"},{"id":"3","code":"  case \"admin\": console.log(\"Root\"); break;"},{"id":"4","code":"  default: console.log(\"User\");"},{"id":"5","code":"}"}]'::jsonb,
'["1","2","3","4","5"]'::jsonb,
'["let role = \"admin\";","switch (role) {","  case \"admin\": console.log(\"Root\"); break;","  default: console.log(\"User\");","}"]'::jsonb,
'Declare, open switch, case, default, close switch.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Use a switch on `code = 404` to log "Not Found". Provide a default break. Expected: Not Found',
'let code: number = 404;' || chr(10) || '// Write switch',
'Not Found',
'switch(code) { case 404: console.log("Not Found"); break; }',
5, 20);


-- ==============================================================
-- UNIT 3: Functions
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 3: Functions', 'Build strongly-typed functions and arrow syntax', 'orange', 3)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Functions in TypeScript', $note$

# Functions in TypeScript

TypeScript allows you to specify the types of parameters a function accepts and the type of value it returns.

## Typing Parameters and Returns

```typescript
function add(x: number, y: number): number {
    return x + y;
}

let sum = add(5, 10); // sum is inferred as number
// add("5", 10);      // Error!

```

If a function returns nothing, its return type is `void`:

```typescript
function logMessage(msg: string): void {
    console.log(msg);
}

```

## Arrow Functions

Very common in modern web development (React, Next.js):

```typescript
const multiply = (a: number, b: number): number => {
    return a * b;
};

// Implicit return (shorter):
const square = (n: number) => n * n;

```

## Optional Parameters

Add a `?` after the parameter name to make it optional.

```typescript
function greet(name: string, title?: string) {
    if (title) {
        console.log(`Hello ${title} ${name}`);
    } else {
        console.log(`Hello ${name}`);
    }
}
greet("Anthony"); // Valid!

```

## Default Parameters

Provide a default value right in the signature:

```typescript
function calculateDiscount(price: number, discount: number = 0.1) {
    return price - (price * discount);
}

```

## Key Takeaways

* Always type your parameters. Return types can often be inferred, but it's good practice to declare them.
* `void` means no return value.
* Optional params (`?`) must come AFTER required params.
$note$, 0);

-- Lesson 3.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Typing Parameters and Returns', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the return type of a function that only uses `console.log()` and doesn''t return a value?',
'0',
'["void", "null", "undefined", "empty"]'::jsonb,
'Just like in C++, `void` indicates a function performs an action but returns no data.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the return type annotation for a function that returns text:',
'function getName(): ___ { return "Coddytech"; }',
'string',
'["string", "text", "void", "String"]'::jsonb,
'The return type is placed after the parameter parentheses.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you omit the return type like this: `function add(a: number, b: number) { return a + b; }`?',
'0',
'["TypeScript automatically infers the return type as number", "It throws a syntax error", "The return type becomes any", "The function returns void"]'::jsonb,
'TS is smart. Because it adds two numbers, it infers the output is also a number.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Build a function that accepts an id and returns it as a string:',
'[{"id":"1","code":"function makeId(id: number): string {"},{"id":"2","code":"  return id.toString();"},{"id":"3","code":"}"}]'::jsonb,
'["1","2","3"]'::jsonb,
'["function makeId(id: number): string {","  return id.toString();","}"]'::jsonb,
'Signature with params and return type, body, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write a function `double(n: number): number` that returns n * 2. Log double(4). Expected: 8',
'// Write function and log result',
'8',
'function double(n: number): number { return n * 2; } console.log(double(4));',
5, 20);
-- Lesson 3.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Arrow Functions', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which syntax correctly defines an arrow function in TypeScript?',
'0',
'["const add = (a: number, b: number): number => a + b;", "function add => (a, b)", "const add = a, b => a + b;", "let add(a, b) => number"]'::jsonb,
'Arrow functions use the `=>` syntax. Types go in the same places as normal functions.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the arrow function syntax:',
'const logError = (msg: string) ___ console.log(msg);',
'=>',
'["=>", "->", "=", ">>"]'::jsonb,
'The "fat arrow" `=>` separates the parameters from the function body.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'When using an arrow function without curly braces `{}`...',
'0',
'["The expression after the arrow is implicitly returned", "You must write the `return` keyword", "It returns void", "It throws an error"]'::jsonb,
'Implicit returns make arrow functions great for short operations like `(x) => x * 2`.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange an arrow function that checks if a user is active:',
'[{"id":"1","code":"const isActive = (status: string): boolean => {"},{"id":"2","code":"  return status === \"online\";"},{"id":"3","code":"};"}]'::jsonb,
'["1","2","3"]'::jsonb,
'["const isActive = (status: string): boolean => {","  return status === \"online\";","};"]'::jsonb,
'Const declaration with arrow, return condition, close brace.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write an arrow function `getHalf = (n: number) => n / 2`. Log getHalf(10). Expected: 5',
'// Write arrow function and log',
'5',
'const getHalf = (n: number) => n / 2; console.log(getHalf(10));',
5, 20);
-- Lesson 3.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Optional and Default Parameters', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you mark a parameter as optional in TypeScript?',
'0',
'["By placing a ? after the parameter name", "By placing a ? before the type", "By assigning it to null", "By using the optional keyword"]'::jsonb,
'`name?: string` means `name` can be a string OR undefined.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax for a default parameter of 1:',
'function increment(val: number, step: number ___ 1) { ... }',
'=',
'["=", ":", "?", "=>"]'::jsonb,
'Use `=` to provide a default value. If `step` is not provided, it defaults to 1.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Where must optional parameters be placed in a function signature?',
'0',
'["At the very end of the parameter list", "At the beginning", "Anywhere", "Only in arrow functions"]'::jsonb,
'Required parameters must come first. `(a?: string, b: string)` is invalid.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a greeting function with an optional title:',
'[{"id":"1","code":"function greet(name: string, title?: string) {"},{"id":"2","code":"  if (title) console.log(title + \" \" + name);"},{"id":"3","code":"  else console.log(name);"},{"id":"4","code":"}"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["function greet(name: string, title?: string) {","  if (title) console.log(title + \" \" + name);","  else console.log(name);","}"]'::jsonb,
'Signature with ?, check if provided, else fallback, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write `function pow(base: number, exp: number = 2)`. Return `base  exp`. Log pow(3). Expected: 9',
'// Write function and log',
'9',
'function pow(base: number, exp: number = 2) { return base  exp; } console.log(pow(3));',
5, 20);
-- Lesson 3.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Rest Parameters', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What do Rest Parameters (...) do in TypeScript?',
'0',
'["They collect multiple arguments into a single array variable", "They copy an object", "They pause function execution", "They spread an array into individual values"]'::jsonb,
'In a parameter list, `...nums: number[]` allows calling `fn(1, 2, 3)` and treats `nums` as `[1, 2, 3]`.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the rest parameter syntax:',
'function sum(___numbers: number[]) { ... }',
'...',
'["...", "..", "*", "rest"]'::jsonb,
'Three dots `...` denote the rest parameter. It must be an array type.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Where must a rest parameter be placed?',
'0',
'["It must be the last parameter in the list", "It must be the first parameter", "It can be anywhere", "It must be inside an interface"]'::jsonb,
'Like optional parameters, rest parameters must come at the end.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create a function that collects all tags passed to it:',
'[{"id":"1","code":"function buildTags(id: string, ...tags: string[]) {"},{"id":"2","code":"  console.log(id, tags.length);"},{"id":"3","code":"}"},{"id":"4","code":"buildTags(\"Post1\", \"TS\", \"NextJS\");"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["function buildTags(id: string, ...tags: string[]) {","  console.log(id, tags.length);","}","buildTags(\"Post1\", \"TS\", \"NextJS\");"]'::jsonb,
'Signature with rest param, body, close, call with multiple args.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write `function logAll(...items: string[])` that logs the first item. Call it with "Apple", "Banana". Expected: Apple',
'// Write function and call it',
'Apple',
'function logAll(...items: string[]) { console.log(items[0]); } logAll("Apple", "Banana");',
5, 20);


-- ==============================================================
-- UNIT 4: Interfaces and Types
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 4: Interfaces & Types', 'Model custom data structures for your apps', 'purple', 4)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Interfaces and Custom Types', $note$

# Custom Types in TypeScript

When building apps with complex data (like a Next.js full-stack app or a School Hub), you need custom types to describe objects.

## Interfaces

Interfaces declare the shape of an object.

```typescript
interface Student {
    indexNumber: string;
    group: string;
    gpa?: number; // Optional property
}

let user: Student = {
    indexNumber: "102030",
    group: "Group 1"
    // gpa is optional, so it's fine if we omit it
};

```

## Type Aliases

`type` is similar to `interface`, but more versatile. It can define primitives, unions, and tuples.

```typescript
type Role = "admin" | "teacher" | "student"; // Union Type

let currentRole: Role = "admin";
// currentRole = "guest"; // Error!

```

## Union Types `|`

Allows a value to be one of several types.

```typescript
let id: string | number;
id = 101;
id = "202A";

```

## Intersection Types `&`

Combines multiple types into one. The object must have ALL properties.

```typescript
interface HasEmail { email: string; }
interface HasPhone { phone: string; }

type Contact = HasEmail & HasPhone;

let c: Contact = {
    email: "test@test.com",
    phone: "555-1234"
};

```

## Key Takeaways

* Use `interface` primarily for defining object shapes (often better for error messages and extending).
* Use `type` for Unions (`|`), Intersections (`&`), and simple aliases.
* `?` marks a property as optional inside an interface or type.
$note$, 0);
-- Lesson 4.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Defining Interfaces', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the primary purpose of an `interface` in TypeScript?',
'0',
'["To define the shape and properties of an object", "To write runtime logic", "To compile CSS files", "To loop over arrays"]'::jsonb,
'Interfaces are blueprints for objects. They ensure objects have specific properties.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax to make the `email` property optional:',
'interface User { email___ string; }',
'?:',
'["?:", ":?", "!", "=>"]'::jsonb,
'Adding a `?` right before the colon makes the property optional.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Are interfaces compiled into the final JavaScript code?',
'0',
'["No, they disappear completely during compilation", "Yes, they become JavaScript classes", "Yes, they become objects", "Yes, they become functions"]'::jsonb,
'Interfaces are exclusively for TypeScript''s compile-time checking. They emit zero JavaScript code.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Define a Student interface and assign an object to it:',
'[{"id":"1","code":"interface Student {"},{"id":"2","code":"  group: string; }"},{"id":"3","code":"let s: Student = {"},{"id":"4","code":"  group: \"Group 1\" };"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["interface Student {","  group: string; }","let s: Student = {","  group: \"Group 1\" };"]'::jsonb,
'Open interface, close interface, declare variable with type, assign matching object.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create an interface `Car` with a string `make`. Create an object `c: Car` with make "Toyota". Log `c.make`. Expected: Toyota',
'// Define interface, object, and log',
'Toyota',
'interface Car { make: string; } let c: Car = { make: "Toyota" }; console.log(c.make);',
5, 20);
-- Lesson 4.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Type Aliases', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How does a `type` alias differ from an `interface` syntax?',
'0',
'["Type aliases use an equals sign (=) after the name", "Type aliases cannot describe objects", "Type aliases are compiled to JavaScript", "Type aliases require the `new` keyword"]'::jsonb,
'`type User = { name: string };` vs `interface User { name: string; }`.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Create a type alias for a standard primitive:',
'___ ID = string;',
'type',
'["type", "interface", "let", "const"]'::jsonb,
'You can alias primitives with `type`, which you cannot do with `interface`.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you use a Type Alias to define a specific tuple shape (e.g., [string, number])?',
'0',
'["Yes, this is one of the strengths of Type Aliases", "No, only interfaces can do that", "No, tuples are not supported in custom types", "Yes, but only in strict mode"]'::jsonb,
'`type Point = [number, number];` is a perfect use case for a type alias.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create a type alias for a literal value constraint:',
'[{"id":"1","code":"type Role = \"admin\" | \"student\";"},{"id":"2","code":"let myRole: Role;"},{"id":"3","code":"myRole = \"admin\";"},{"id":"4","code":"console.log(myRole);"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["type Role = \"admin\" | \"student\";","let myRole: Role;","myRole = \"admin\";","console.log(myRole);"]'::jsonb,
'Define type, declare var, assign valid literal, log.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Define `type Score = number;`. Create `let s: Score = 100;` and log it. Expected: 100',
'// Define type and log',
'100',
'type Score = number; let s: Score = 100; console.log(s);',
5, 20);
-- Lesson 4.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Union Types', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does a Union type (`|`) represent?',
'0',
'["A value that can be one of several different types", "An object that combines two shapes", "A strictly numeric value", "An array of multiple types"]'::jsonb,
'Unions say "this OR that". `string | number`.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the union type to allow text or a number:',
'let password: string ___ number;',
'|',
'["|", "&", "||", "or"]'::jsonb,
'The single pipe `|` is the union operator in TypeScript.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If `let data: string | string[]`, how should you safely call `.push()`?',
'0',
'["Check if Array.isArray(data) first (Type Narrowing)", "Call data.push() directly", "Cast it to any", "Check typeof data === array"]'::jsonb,
'Since `.push()` doesn''t exist on strings, you must narrow the union to an array before using it.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a function that handles a union type:',
'[{"id":"1","code":"function print(val: string | number) {"},{"id":"2","code":"  if (typeof val === \"string\") console.log(val.trim());"},{"id":"3","code":"  else console.log(val * 2);"},{"id":"4","code":"}"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["function print(val: string | number) {","  if (typeof val === \"string\") console.log(val.trim());","  else console.log(val * 2);","}"]'::jsonb,
'Signature with union, type guard for string, else for number, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Declare `let res: "success" | "error"`. Set it to "success" and log it. Expected: success',
'// Declare union literal and log',
'success',
'let res: "success" | "error"; res = "success"; console.log(res);',
5, 20);
-- Lesson 4.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Intersection Types', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does an Intersection type (`&`) do?',
'0',
'["Combines multiple types into a single type that requires ALL properties", "Allows a value to be one of many types", "Excludes a type", "Makes properties optional"]'::jsonb,
'Intersection means "this AND that". If A has `id` and B has `name`, A & B requires both `id` and `name`.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the intersection type:',
'type AdminUser = User ___ AdminPermissions;',
'&',
'["&", "|", "&&", "+"]'::jsonb,
'The single ampersand `&` intersects types.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you intersect conflicting primitives, like `type X = string & number`?',
'0',
'["The resulting type is `never` because nothing can be both simultaneously", "It becomes `any`", "It becomes a tuple", "It defaults to string"]'::jsonb,
'Because a value cannot simultaneously be a string AND a number, TS resolves it to the `never` type.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Combine two interfaces into a new type:',
'[{"id":"1","code":"interface HasName { name: string; }"},{"id":"2","code":"interface HasAge { age: number; }"},{"id":"3","code":"type Person = HasName & HasAge;"},{"id":"4","code":"let p: Person = { name: \"A\", age: 20 };"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["interface HasName { name: string; }","interface HasAge { age: number; }","type Person = HasName & HasAge;","let p: Person = { name: \"A\", age: 20 };"]'::jsonb,
'Define interface 1, interface 2, intersect them, assign an object satisfying both.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given `type A={x:number}` and `type B={y:number}`. Create `type C = A & B`. Make `let obj: C = {x:1, y:2}` and log obj.x. Expected: 1',
'type A = { x: number }; type B = { y: number };' || chr(10) || '// Write intersection and log x',
'1',
'type C = A & B; let obj: C = { x: 1, y: 2 }; console.log(obj.x);',
5, 20);


-- ==============================================================
-- UNIT 5: Object-Oriented TS
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 5: Classes & OOP', 'Encapsulation, inheritance, and implements', 'teal', 5)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Classes and Modifiers', $note$

# Object-Oriented TypeScript

TypeScript brings familiar OOP concepts (like from C++ or Java) to JavaScript classes.

## Classes and Access Modifiers

* `public` (default) - Accessible anywhere.
* `private` - Accessible only inside the class.
* `protected` - Accessible in the class and subclasses.

```typescript
class Student {
    private indexNumber: string;
    public name: string;

    constructor(index: string, name: string) {
        this.indexNumber = index;
        this.name = name;
    }

    public getIndex() { return this.indexNumber; }
}

```

## Parameter Properties (Shorthand)

Instead of declaring fields and setting them in the constructor, TS has a shorthand:

```typescript
class Admin {
    // This automatically creates and assigns the private/public fields!
    constructor(private id: number, public role: string) {}
}
let a = new Admin(1, "Root");

```

## Implementing Interfaces

Classes can be forced to adhere to an interface using `implements`:

```typescript
interface DatabaseModel {
    save(): void;
}

class User implements DatabaseModel {
    save() { console.log("Saving to DB..."); }
}

```

## Inheritance (`extends`)

Subclasses inherit from parent classes.

```typescript
class Person {
    constructor(public name: string) {}
}
class Teacher extends Person {
    constructor(name: string, public subject: string) {
        super(name); // Call parent constructor
    }
}

```

## Key Takeaways

* Access modifiers (`private`, `public`, `protected`) disappear in compiled JS, but protect your code during dev.
* Parameter properties in constructors save a lot of typing.
* `implements` connects an interface contract to a class implementation.
$note$, 0);
-- Lesson 5.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Classes and Access Modifiers', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the default access modifier for class members if none is provided?',
'0',
'["public", "private", "protected", "static"]'::jsonb,
'Unlike C++ classes (default private), TypeScript/JavaScript classes default to public.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Make this database connection string strictly hidden from outside access:',
'___ dbUrl: string;',
'private',
'["private", "hidden", "protected", "secret"]'::jsonb,
'The `private` modifier prevents external access to the property.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Are TypeScript access modifiers enforced at runtime in the browser?',
'0',
'["No, they are stripped out during compilation to JS", "Yes, the browser enforces them strictly", "Only if strict mode is on", "Yes, they cause runtime crashes if violated"]'::jsonb,
'JS has its own private fields (using `#`), but standard TS `private` is just a compile-time check.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a class with a private field and a public getter:',
'[{"id":"1","code":"class User {"},{"id":"2","code":"  private email: string = \"a@b.com\";"},{"id":"3","code":"  public getEmail() {"},{"id":"4","code":"    return this.email; } } "}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["class User {","  private email: string = \"a@b.com\";","  public getEmail() {","    return this.email; } } "]'::jsonb,
'Class open, private property, public getter method returning this.prop.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create a class `App` with a public method `run()` that logs "Running". Instantiate it and call run(). Expected: Running',
'// Define class and call method',
'Running',
'class App { run() { console.log("Running"); } } let a = new App(); a.run();',
5, 20);
-- Lesson 5.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Constructors and Parameter Properties', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a constructor in a TypeScript class?',
'0',
'["A special method called automatically when creating a new instance (`new Class()`)", "A method to delete an object", "The type definition of the class", "A function that returns HTML"]'::jsonb,
'Constructors initialize the object state.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Use the parameter property shorthand to automatically create a private `id` field:',
'constructor(___ id: number) {}',
'private',
'["private", "public", "this", "let"]'::jsonb,
'Adding an access modifier directly inside the constructor arguments auto-creates the field and assigns it.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `readonly` modifier do?',
'0',
'["Prevents the property from being changed after it is initialized in the constructor", "Makes the property hidden", "Makes the class unable to be instantiated", "Creates a static property"]'::jsonb,
'`readonly` guarantees immutability for that property after creation.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a class using the constructor shorthand:',
'[{"id":"1","code":"class Item {"},{"id":"2","code":"  constructor(public name: string) {}"},{"id":"3","code":"}"},{"id":"4","code":"let item = new Item(\"Laptop\");"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["class Item {","  constructor(public name: string) {}","}","let item = new Item(\"Laptop\");"]'::jsonb,
'Class open, shorthand constructor, class close, instantiation.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create `class Box { constructor(public size: number) {} }`. Instantiate with size 10 and log `.size`. Expected: 10',
'// Define class and log size',
'10',
'class Box { constructor(public size: number) {} } let b = new Box(10); console.log(b.size);',
5, 20);
-- Lesson 5.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Inheritance', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which keyword establishes an inheritance relationship between classes?',
'0',
'["extends", "implements", "inherits", "super"]'::jsonb,
'`class Child extends Parent {}`',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'What function must you call inside a child class constructor?',
'___(args);',
'super',
'["super", "parent", "base", "this"]'::jsonb,
'You must call `super()` to execute the parent class''s constructor before using `this`.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `protected` modifier do?',
'0',
'["Acts like private, but allows subclasses to access the property", "Acts like public", "Prevents subclasses from overriding methods", "Makes the property readonly"]'::jsonb,
'`protected` is perfect for inheritance when children need internal data the outside world shouldn''t see.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a Teacher subclass extending Staff:',
'[{"id":"1","code":"class Staff { constructor(public name: string) {} }"},{"id":"2","code":"class Teacher extends Staff {"},{"id":"3","code":"  constructor(name: string, public subject: string) {"},{"id":"4","code":"    super(name); } } "}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["class Staff { constructor(public name: string) {} }","class Teacher extends Staff {","  constructor(name: string, public subject: string) {","    super(name); } } "]'::jsonb,
'Base class, derived class extending base, constructor matching signature, super call.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given `class Base { a=1; }`, make `class Sub extends Base { b=2; }`. Make an instance and log `instance.a + instance.b`. Expected: 3',
'class Base { a = 1; }' || chr(10) || '// Extend and log',
'3',
'class Sub extends Base { b = 2; } let s = new Sub(); console.log(s.a + s.b);',
5, 20);
-- Lesson 5.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Implementing Interfaces', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the purpose of `class MyClass implements MyInterface`?',
'0',
'["It forces the class to adhere to the structure defined by the interface", "It copies code from the interface", "It turns the class into an interface", "It extends another class"]'::jsonb,
'`implements` is a contract. If the class misses a method from the interface, TS throws an error.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax to bind a class to an interface:',
'class Logger ___ ILogger { log() {} }',
'implements',
'["implements", "extends", "uses", "binds"]'::jsonb,
'`implements` checks that the class shape matches the interface shape.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can a class implement multiple interfaces?',
'0',
'["Yes, separated by commas (e.g., implements A, B)", "No, only one interface is allowed", "Yes, but they must be from the same file", "No, interfaces can only be extended"]'::jsonb,
'Classes can implement multiple interfaces, but can only `extend` ONE parent class.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create an interface and a class that implements it:',
'[{"id":"1","code":"interface Pingable { ping(): void; }"},{"id":"2","code":"class Server implements Pingable {"},{"id":"3","code":"  ping() { console.log(\"Pong\"); }"},{"id":"4","code":"}"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["interface Pingable { ping(): void; }","class Server implements Pingable {","  ping() { console.log(\"Pong\"); }","}"]'::jsonb,
'Define interface, class implements interface, write the required method, close class.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Interface `I { val: number }`. Write `class C implements I { val = 5; }`. Log a new instance''s val. Expected: 5',
'interface I { val: number; }' || chr(10) || '// Write class and log',
'5',
'class C implements I { val = 5; } let c = new C(); console.log(c.val);',
5, 20);

-- ==============================================================
-- UNIT 6: Generics and Advanced Types
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 6: Generics & Utility Types', 'Write reusable, dynamic, and flexible type-safe code', 'red', 6)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Generics in TypeScript', $note$

# Generics and Utility Types

Generics allow you to create reusable components that work over a variety of types rather than a single one. (Similar to C++ Templates).

## Generics `<T>`

```typescript
// T is a placeholder for the type we pass in later
function identity<T>(arg: T): T {
    return arg;
}

let num = identity<number>(42); // Returns a number
let str = identity<string>("TS"); // Returns a string

```

## Generic Interfaces / Classes

Useful for wrappers, API responses, or data structures (like Linked Lists or Stacks).

```typescript
interface ApiResponse<T> {
    data: T;
    status: number;
}

let res: ApiResponse<string[]> = {
    data: ["User1", "User2"],
    status: 200
};

```

## Generic Constraints (`extends`)

You can force a generic to have certain properties.

```typescript
function logLength<T extends { length: number }>(item: T) {
    console.log(item.length);
}
logLength("Hello"); // Works (strings have .length)
logLength([1, 2, 3]); // Works (arrays have .length)
// logLength(100); // Error! Numbers don't have .length

```

## Utility Types

TypeScript provides built-in type transformations:

* `Partial<T>`: Makes all properties in T optional.
* `Required<T>`: Makes all properties in T required.
* `Omit<T, 'key'>`: Removes a key from a type.

```typescript
interface User { id: number; name: string; }
type UpdateUser = Partial<User>; // { id?: number; name?: string; }

```

## Key Takeaways

* `<T>` acts as a variable for a TYPE.
* Generics power most robust libraries (like React or Supabase clients).
* Utility types let you quickly derive new types from existing interfaces without rewriting code.
$note$, 0);

-- Lesson 6.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Generics Basics', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the purpose of Generics `<T>` in TypeScript?',
'0',
'["To write reusable code that maintains type safety across different types", "To generate HTML tags dynamically", "To bypass the compiler", "To create global variables"]'::jsonb,
'Generics are like variables for types. You pass a type in, and it shapes the function or class.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the generic type parameter syntax:',
'function wrap___(val: T): T[] { return [val]; }',
'',
'["", "(T)", "{T}", "[T]"]'::jsonb,
'Type parameters are enclosed in angle brackets before the parentheses.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you use multiple generic type parameters, like `<T, U>`?',
'0',
'["Yes, you can have as many as you need", "No, only T is allowed", "Only in classes, not functions", "Yes, but they must both be strings"]'::jsonb,
'`function map<T, U>(input: T): U` is a very common pattern.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a generic function that returns whatever is passed into it:',
'[{"id":"1","code":"function echo<T>(arg: T): T {"},{"id":"2","code":"  return arg;"},{"id":"3","code":"}"},{"id":"4","code":"let n = echo<number>(10);"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["function echo<T>(arg: T): T {","  return arg;","}","let n = echo<number>(10);"]'::jsonb,
'Signature with , return arg, close, call with explicit .',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write `function getFirst<T>(arr: T[]): T { return arr[0]; }`. Log `getFirst<string>(["A", "B"])`. Expected: A',
'// Write generic function and log',
'A',
'function getFirst(arr: T[]): T { return arr[0]; } console.log(getFirst(["A", "B"]));',
5, 20);

-- Lesson 6.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Generic Constraints', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why would you use a generic constraint (e.g., `<T extends HasId>`)?',
'0',
'["To guarantee that the type passed in has specific properties, while remaining flexible", "To convert T into a string", "To prevent the function from returning data", "To throw an error at runtime"]'::jsonb,
'Constraints let you say "T can be anything, AS LONG AS it has an ID."',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the constraint keyword:',
'function logId<T ___ { id: string }>(item: T) { ... }',
'extends',
'["extends", "implements", "has", "typeof"]'::jsonb,
'`extends` acts as a constraint when used inside angle brackets `< >`.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If `function check<T extends { name: string }>(obj: T)`, what happens if you call `check({ age: 20 })`?',
'0',
'["Compile-time error: property ''name'' is missing", "It works fine", "It adds ''name'' automatically", "It returns undefined"]'::jsonb,
'The constraint requires the object to possess a `name` property.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Build a function that requires a length property:',
'[{"id":"1","code":"function getLen<T extends { length: number }>"},{"id":"2","code":"(item: T): number {"},{"id":"3","code":"  return item.length; }"},{"id":"4","code":"console.log(getLen(\"Hi\"));"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["function getLen<T extends { length: number }>","(item: T): number {","  return item.length; }","console.log(getLen(\"Hi\"));"]'::jsonb,
'Generic constraint, params and return, return statement, valid function call.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given `interface HasX { x: number; }`. Write `function printX<T extends HasX>(obj: T) { console.log(obj.x); }`. Call with `{x: 99}`. Expected: 99',
'interface HasX { x: number; }' || chr(10) || '// Write constrained function and call',
'99',
'function printX(obj: T) { console.log(obj.x); } printX({x: 99});',
5, 20);

-- Lesson 6.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Utility Types (Partial & Omit)', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the built-in `Partial<T>` utility type do?',
'0',
'["It creates a new type where all properties of T become optional", "It makes all properties required", "It removes half the properties", "It converts properties to strings"]'::jsonb,
'Partial is excellent for HTTP PATCH requests or updating database records where you only provide a few fields.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the utility type to remove the `password` field from a User type:',
'type PublicUser = ___<User, "password">;',
'Omit',
'["Omit", "Remove", "Delete", "Partial"]'::jsonb,
'`Omit<Type, Keys>` constructs a type by picking all properties from Type and then removing Keys.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which utility type is the exact opposite of `Partial<T>`?',
'0',
'["Required", "Omit", "Pick", "Full"]'::jsonb,
'`Required<T>` constructs a type consisting of all properties of T set to required (removes `?`).',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Use Partial to allow an incomplete update object:',
'[{"id":"1","code":"interface Task { id: number; title: string; }"},{"id":"2","code":"function updateTask(id: number, updates: Partial<Task>) {"},{"id":"3","code":"  console.log(\"Updating...\"); }"},{"id":"4","code":"updateTask(1, { title: \"New\" });"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["interface Task { id: number; title: string; }","function updateTask(id: number, updates: Partial<Task>) {","  console.log(\"Updating...\"); }","updateTask(1, { title: \"New\" });"]'::jsonb,
'Interface, signature with Partial, body, valid call with only 1 property.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Interface `T { a:number; b:number; }`. Let `p: Partial<T> = { a: 1 };`. Log p.a. Expected: 1',
'interface T { a: number; b: number; }' || chr(10) || '// Use Partial and log',
'1',
'let p: Partial = { a: 1 }; console.log(p.a);',
5, 20);

-- Lesson 6.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Enums', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is an `enum` in TypeScript?',
'0',
'["A way to define a set of named constants", "A generic type parameter", "A loop structure", "A type of database connection"]'::jsonb,
'Enums allow a developer to define a set of named constants (numeric or string based).',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration for a string enum:',
'___ Direction { Up = "UP", Down = "DOWN" }',
'enum',
'["enum", "type", "interface", "const"]'::jsonb,
'`enum` creates both a type AND an object at runtime in JavaScript.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'By default, what value is assigned to the first member of a numeric enum?',
'0',
'["0", "1", "undefined", "null"]'::jsonb,
'Unless initialized differently, numeric enums auto-increment starting from 0.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create an enum and use it in a switch statement:',
'[{"id":"1","code":"enum Status { Pending, Done }"},{"id":"2","code":"let s: Status = Status.Done;"},{"id":"3","code":"if (s === Status.Done) {"},{"id":"4","code":"  console.log(\"Finished\"); }"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["enum Status { Pending, Done }","let s: Status = Status.Done;","if (s === Status.Done) {","  console.log(\"Finished\"); }"]'::jsonb,
'Define enum, assign to variable, check equality, log.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create `enum Role { Admin = 1, User = 2 }`. Log `Role.Admin`. Expected: 1',
'// Define enum and log',
'1',
'enum Role { Admin = 1, User = 2 } console.log(Role.Admin);',
5, 20);

END $$;
