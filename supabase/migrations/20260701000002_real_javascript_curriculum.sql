-- ============================================================
-- REAL JAVASCRIPT CURRICULUM
-- Replaces all existing JavaScript content with accurate,
-- educational notes, lessons and questions.
--
-- Structure: 6 units · 4 lessons each · 5 questions each
-- Question mix per lesson: 2 multiple-choice, 1 fill-blank,
--   1 drag-order, 1 code-runner
-- ============================================================

DO $$
DECLARE
  v_lang_id   uuid;
  v_unit_id   uuid;
  v_lesson_id uuid;
BEGIN

  -- Ensure JavaScript language exists
  SELECT id INTO v_lang_id FROM public.languages WHERE slug = 'javascript';
  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('JavaScript', 'javascript', '🟨', 'The language of the web — runs in every browser')
    RETURNING id INTO v_lang_id;
  END IF;

  -- Wipe all existing JavaScript units (cascades to lessons, questions, unit_notes)
  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with JavaScript
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 1: Getting Started',
          'Write your first JavaScript code and understand how it runs',
          'yellow', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to JavaScript', $note$
# Introduction to JavaScript

JavaScript (JS) is the programming language of the web. It runs inside every browser and can also run on servers (Node.js). It was created in 1995 and is now one of the most widely used languages in the world.

## Where JavaScript Runs

- **Browser** — controls HTML, responds to clicks, fetches data
- **Node.js** — server-side JavaScript, file system, APIs
- **React Native / Electron** — mobile and desktop apps

## Your First Script

```js
console.log("Hello, World!");
```

`console.log()` is the primary way to output values during development.

## The `<script>` Tag

Embed JS directly in HTML:

```html
<script>
  console.log("Runs in the browser!");
</script>
```

Or link an external file:

```html
<script src="app.js"></script>
```

## Comments

```js
// Single-line comment

/*
  Multi-line
  comment
*/
```

## Semicolons

JavaScript uses semicolons `;` to end statements. They are technically optional (ASI — Automatic Semicolon Insertion), but using them is best practice:

```js
console.log("Line 1");
console.log("Line 2");
```

## Arithmetic Operators

| Operator | Example    | Result |
|----------|-----------|--------|
| `+`      | `5 + 3`   | `8`    |
| `-`      | `10 - 4`  | `6`    |
| `*`      | `3 * 4`   | `12`   |
| `/`      | `10 / 4`  | `2.5`  |
| `%`      | `10 % 3`  | `1`    |
| `**`     | `2 ** 8`  | `256`  |

## Key Takeaways
- JavaScript runs in the browser and on servers via Node.js
- `console.log()` outputs to the developer console
- Semicolons end statements; comments use `//` or `/* */`
- JavaScript is case-sensitive: `myVar` and `myvar` are different
$note$, 0);

  -- ── Lesson 1.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Hello, JavaScript!', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which function prints output to the browser console in JavaScript?',
   '0',
   '["console.log()", "print()", "echo()", "output()"]'::jsonb,
   'console.log() is JavaScript''s primary output function for developers.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the statement to output "Hello" to the console:',
   'console.___("Hello");',
   'log',
   '["log", "print", "write", "output"]'::jsonb,
   'console.log() is the method — "log" is the part after the dot.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How do you write a single-line comment in JavaScript?',
   '0',
   '["// This is a comment", "# This is a comment", "<!-- comment -->", "** comment **"]'::jsonb,
   'JavaScript uses // for single-line comments, same as C, Java, and many other languages.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these steps to link a JavaScript file to an HTML page:',
   '[{"id":"1","code":"1. Create a file called app.js"},{"id":"2","code":"2. Write your JavaScript code inside app.js"},{"id":"3","code":"3. Add <script src=\"app.js\"></script> to your HTML"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["1. Create a file called app.js","2. Write your JavaScript code inside app.js","3. Add <script src=\"app.js\"></script> to your HTML"]'::jsonb,
   'Create the file first, write code second, then link it to HTML.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a statement that prints: Hello, JavaScript!',
   '// Write your console.log() here' || chr(10),
   'Hello, JavaScript!',
   'console.log("Hello, JavaScript!");',
   5, 20);

  -- ── Lesson 1.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Variables: let, const, var', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which keyword declares a variable that CANNOT be reassigned?',
   '0',
   '["const", "let", "var", "final"]'::jsonb,
   'const (constant) declares a variable whose binding cannot be changed after assignment.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the declaration of a variable that CAN be reassigned later:',
   '___ score = 0;',
   'let',
   '["let", "const", "var", "define"]'::jsonb,
   'let is the modern keyword for a reassignable variable with block scope.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'let x = 5;' || chr(10) || 'x = 10;' || chr(10) || 'console.log(x);',
   '0',
   '["10", "5", "undefined", "Error: x already declared"]'::jsonb,
   'let allows reassignment. The second assignment (x = 10) replaces 5.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to declare a name, build a greeting, and log it:',
   '[{"id":"1","code":"const name = \"Alice\";"},{"id":"2","code":"let greeting = \"Hello, \" + name;"},{"id":"3","code":"console.log(greeting);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const name = \"Alice\";","let greeting = \"Hello, \" + name;","console.log(greeting);"]'::jsonb,
   'Declare the constant first, build the string second, output it third.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Declare a const called language with value "JavaScript" and log it.',
   '// Declare and log your variable' || chr(10),
   'JavaScript',
   'const language = "JavaScript"; console.log(language);',
   5, 20);

  -- ── Lesson 1.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Data Types in JavaScript', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does typeof "hello" return?',
   '0',
   '["\"string\"", "\"text\"", "\"char\"", "String"]'::jsonb,
   'typeof returns a lowercase string describing the type. Strings return "string".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the typeof call to check what type a variable is:',
   'console.log(___ 42);',
   'typeof',
   '["typeof", "type", "getType", "instanceof"]'::jsonb,
   'typeof is a JavaScript operator that returns the type of its operand as a string.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which of these is NOT a primitive JavaScript data type?',
   '0',
   '["Array", "number", "string", "boolean"]'::jsonb,
   'Arrays are objects, not primitives. The 7 primitives are: string, number, bigint, boolean, undefined, symbol, null.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to declare one variable of each type and log them:',
   '[{"id":"1","code":"const age = 25;"},{"id":"2","code":"const name = \"Bob\";"},{"id":"3","code":"const isActive = true;"},{"id":"4","code":"console.log(age, name, isActive);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["const age = 25;","const name = \"Bob\";","const isActive = true;","console.log(age, name, isActive);"]'::jsonb,
   'Declare number, string, and boolean in that order, then log all three.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Log the typeof the value true. Expected output: boolean',
   '// Check the type of true' || chr(10),
   'boolean',
   'console.log(typeof true);',
   5, 20);

  -- ── Lesson 1.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Template Literals and Strings', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What character wraps a template literal in JavaScript?',
   '0',
   '["Backtick (`)", "Single quote ('')", "Double quote (\")", "Hash (#)"]'::jsonb,
   'Template literals use backticks ` ` (not regular quotes) to enable embedded expressions.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the placeholder syntax inside a template literal:',
   'const name = "Alice";' || chr(10) || 'console.log(`Hello, ${___}!`);',
   'name',
   '["name", "${name}", "\"name\"", "#name"]'::jsonb,
   'Inside backtick strings, use ${variableName} to embed a variable.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const a = 3, b = 4;' || chr(10) || 'console.log(`Sum: ${a + b}`);',
   '0',
   '["Sum: 7", "Sum: ${a + b}", "Sum: 34", "Error"]'::jsonb,
   '${a + b} is evaluated as an expression inside the template literal. 3 + 4 = 7.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to build a greeting with a template literal:',
   '[{"id":"1","code":"const firstName = \"Maria\";"},{"id":"2","code":"const age = 22;"},{"id":"3","code":"console.log(`${firstName} is ${age} years old.`);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const firstName = \"Maria\";","const age = 22;","console.log(`${firstName} is ${age} years old.`);"]'::jsonb,
   'Declare both variables before using them in the template literal.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a template literal to log: The answer is 42' || chr(10) || 'Store 42 in a variable called answer first.',
   'const answer = 42;' || chr(10) || '// Use a template literal' || chr(10),
   'The answer is 42',
   'console.log(`The answer is ${answer}`);',
   5, 20);


  -- ==============================================================
  -- UNIT 2: Control Flow
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 2: Control Flow',
          'Make decisions and compare values with if statements and operators',
          'orange', 2)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Control Flow in JavaScript', $note$
# Control Flow in JavaScript

## if / else if / else

```js
const score = 85;

if (score >= 90) {
  console.log("Grade: A");
} else if (score >= 80) {
  console.log("Grade: B");
} else if (score >= 70) {
  console.log("Grade: C");
} else {
  console.log("Grade: F");
}
```

Note: JavaScript uses **curly braces `{}`** for blocks, not indentation.

## Comparison Operators

| Operator | Meaning                    |
|----------|----------------------------|
| `===`    | Strict equal (type + value)|
| `!==`    | Strict not equal           |
| `<`      | Less than                  |
| `>`      | Greater than               |
| `<=`     | Less than or equal         |
| `>=`     | Greater than or equal      |

⚠️ Prefer `===` over `==`. The loose equality `==` does type coercion and can give surprising results: `"5" == 5` is `true`, but `"5" === 5` is `false`.

## Logical Operators

```js
const age = 20;
const hasID = true;

if (age >= 18 && hasID) {
  console.log("Welcome!");   // both must be true
}

if (age < 13 || age > 65) {
  console.log("Discount");   // at least one true
}

if (!hasID) {
  console.log("No entry");   // NOT
}
```

## switch Statement

Cleaner than many else-if chains when comparing one value:

```js
const day = "Monday";
switch (day) {
  case "Saturday":
  case "Sunday":
    console.log("Weekend!");
    break;
  case "Monday":
    console.log("Start of the week");
    break;
  default:
    console.log("Weekday");
}
```

Always include `break` — without it, execution "falls through" to the next case.

## Ternary Operator

One-line shorthand for simple if/else:

```js
const age = 20;
const label = age >= 18 ? "Adult" : "Minor";
console.log(label);   // Adult
```

Syntax: `condition ? valueIfTrue : valueIfFalse`

## Key Takeaways
- Use `===` (strict) instead of `==` (loose) for comparisons
- `&&` requires both sides true; `||` requires at least one true
- `switch` with `break` is cleaner than long if/else if chains
- Ternary operator is great for simple two-way choices
$note$, 0);

  -- ── Lesson 2.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'if / else Statements', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const x = 10;' || chr(10) || 'if (x > 5) {' || chr(10) || '  console.log("big");' || chr(10) || '}',
   '0',
   '["big", "Nothing", "Error: missing else", "10"]'::jsonb,
   '10 > 5 is true, so the if body runs and prints "big".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the else keyword:',
   'if (score >= 50) {' || chr(10) || '  console.log("Pass");' || chr(10) || '} ___ {' || chr(10) || '  console.log("Fail");' || chr(10) || '}',
   'else',
   '["else", "elif", "otherwise", "default"]'::jsonb,
   'In JavaScript, the fallback branch uses the else keyword.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why should you prefer === over == in JavaScript?',
   '0',
   '["=== checks both value and type, preventing unexpected coercion", "=== is faster to type", "== does not work in modern JS", "There is no practical difference"]'::jsonb,
   '== performs type coercion: "5" == 5 is true. === requires the same type: "5" === 5 is false.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to check if a temperature is freezing (≤ 0) and log the result:',
   '[{"id":"1","code":"const temp = -5;"},{"id":"2","code":"if (temp <= 0) {"},{"id":"3","code":"  console.log(\"Freezing!\");"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["const temp = -5;","if (temp <= 0) {","  console.log(\"Freezing!\");","}"]'::jsonb,
   'Declare the variable, open the if block, write the body, then close with }.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'If age is 20, log "Adult", otherwise log "Minor". Expected: Adult',
   'const age = 20;' || chr(10) || '// Write your if/else' || chr(10),
   'Adult',
   'if (age >= 18) { console.log("Adult"); } else { console.log("Minor"); }',
   5, 20);

  -- ── Lesson 2.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'else if and switch', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What happens in a switch statement when break is missing from a matched case?',
   '0',
   '["Execution falls through to the next case", "The program stops immediately", "An error is thrown", "The default case runs instead"]'::jsonb,
   'Without break, JavaScript falls through and runs the code in subsequent cases.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword that prevents fall-through in a switch statement:',
   'case "red":' || chr(10) || '  console.log("Stop");' || chr(10) || '  ___;',
   'break',
   '["break", "stop", "exit", "return"]'::jsonb,
   'break terminates the switch block after a matching case executes.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const n = 2;' || chr(10) || 'if (n === 1) {' || chr(10) || '  console.log("one");' || chr(10) || '} else if (n === 2) {' || chr(10) || '  console.log("two");' || chr(10) || '} else {' || chr(10) || '  console.log("other");' || chr(10) || '}',
   '0',
   '["two", "one", "other", "two and other"]'::jsonb,
   'n === 2 is the matching branch. Only "two" is printed; else is skipped.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a switch statement that logs "Weekend" for "Saturday":',
   '[{"id":"1","code":"const day = \"Saturday\";"},{"id":"2","code":"switch (day) {"},{"id":"3","code":"  case \"Saturday\":"},{"id":"4","code":"    console.log(\"Weekend\");"},{"id":"5","code":"    break; }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["const day = \"Saturday\";","switch (day) {","  case \"Saturday\":","    console.log(\"Weekend\");","    break; }"]'::jsonb,
   'Declare the variable, open switch, write the case, log, then break and close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a switch to log the season for month = 7 (July = "Summer"). Expected: Summer',
   'const month = 7;' || chr(10) || '// Use a switch statement' || chr(10),
   'Summer',
   'switch(month) { case 7: console.log("Summer"); break; }',
   5, 20);

  -- ── Lesson 2.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Logical Operators', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: console.log(true && false)',
   '0',
   '["false", "true", "null", "Error"]'::jsonb,
   '&& (AND) returns true only when BOTH sides are true. true && false = false.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the operator to check if either condition is true:',
   'if (isAdmin ___ isModerator) {',
   '||',
   '["||", "&&", "!", "or"]'::jsonb,
   '|| is the OR operator — true if at least one operand is true.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: console.log(!false)',
   '0',
   '["true", "false", "!false", "Error"]'::jsonb,
   'The ! (NOT) operator inverts a boolean. !false becomes true.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a check: log "Valid" only if x is between 1 and 100 (inclusive):',
   '[{"id":"1","code":"const x = 50;"},{"id":"2","code":"if (x >= 1 && x <= 100) {"},{"id":"3","code":"  console.log(\"Valid\");"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["const x = 50;","if (x >= 1 && x <= 100) {","  console.log(\"Valid\");","}"]'::jsonb,
   'Both conditions must be true, so use &&.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Log "Yes" if either a is 5 OR b is 10 (a=3, b=10). Expected: Yes',
   'const a = 3;' || chr(10) || 'const b = 10;' || chr(10) || '// Write your if with ||' || chr(10),
   'Yes',
   'if (a === 5 || b === 10) { console.log("Yes"); }',
   5, 20);

  -- ── Lesson 2.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Ternary Operator', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const age = 17;' || chr(10) || 'console.log(age >= 18 ? "Adult" : "Minor");',
   '0',
   '["Minor", "Adult", "undefined", "Error"]'::jsonb,
   '17 >= 18 is false, so the ternary returns the value after the colon: "Minor".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the ternary operator separator between true and false values:',
   'const label = x > 0 ? "positive" ___ "non-positive";',
   ':',
   '[":", "?", ",", "|"]'::jsonb,
   'Ternary syntax: condition ? trueValue : falseValue — the colon separates the two outcomes.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'The ternary operator is best described as:',
   '0',
   '["A concise one-line if/else expression", "A loop for three iterations", "A way to declare three variables at once", "An operator for three-way comparisons"]'::jsonb,
   'The ternary (tri = three) uses three parts: condition, true-value, false-value — forming a one-line if/else.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to use a ternary to label a number as even or odd:',
   '[{"id":"1","code":"const num = 7;"},{"id":"2","code":"const label = num % 2 === 0 ? \"even\" : \"odd\";"},{"id":"3","code":"console.log(label);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const num = 7;","const label = num % 2 === 0 ? \"even\" : \"odd\";","console.log(label);"]'::jsonb,
   'Declare the number, evaluate the ternary, then log the result.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a ternary to log "Pass" if score >= 50, else "Fail". score = 72. Expected: Pass',
   'const score = 72;' || chr(10) || '// Use ternary and console.log' || chr(10),
   'Pass',
   'console.log(score >= 50 ? "Pass" : "Fail");',
   5, 20);


  -- ==============================================================
  -- UNIT 3: Functions
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 3: Functions',
          'Define reusable code with function declarations, expressions, and arrows',
          'green', 3)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Functions in JavaScript', $note$
# Functions in JavaScript

Functions are the building blocks of JS programs. There are three main ways to define them.

## 1. Function Declaration

```js
function greet(name) {
  return `Hello, ${name}!`;
}
console.log(greet("Alice"));   // Hello, Alice!
```

Function declarations are **hoisted** — they can be called before they appear in the code.

## 2. Function Expression

```js
const greet = function(name) {
  return `Hello, ${name}!`;
};
console.log(greet("Bob"));
```

Not hoisted — the variable must be declared before you call it.

## 3. Arrow Function (ES6+)

The modern, concise syntax:

```js
const greet = (name) => `Hello, ${name}!`;

// With a body block:
const add = (a, b) => {
  const sum = a + b;
  return sum;
};
```

- Single parameter: parentheses optional — `x => x * 2`
- Single expression: `return` and `{}` can be omitted

## Default Parameters

```js
function power(base, exp = 2) {
  return base ** exp;
}
power(3);     // 9  (exp defaults to 2)
power(3, 3);  // 27
```

## Higher-Order Functions

Functions that accept or return other functions:

```js
const nums = [1, 2, 3, 4, 5];

const doubled = nums.map(n => n * 2);
// [2, 4, 6, 8, 10]

const evens = nums.filter(n => n % 2 === 0);
// [2, 4]

const total = nums.reduce((sum, n) => sum + n, 0);
// 15
```

## Key Takeaways
- Declarations are hoisted; expressions and arrows are not
- Arrow functions are the modern standard for short, clean functions
- Default parameters provide fallback values
- `map`, `filter`, and `reduce` are essential higher-order array methods
$note$, 0);

  -- ── Lesson 3.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Function Declarations', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'function add(a, b) { return a + b; }' || chr(10) || 'console.log(add(3, 4));',
   '0',
   '["7", "34", "undefined", "Error"]'::jsonb,
   'add(3, 4) returns 3 + 4 = 7. console.log then prints 7.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword to define a function:',
   '___ square(n) {' || chr(10) || '  return n * n;' || chr(10) || '}',
   'function',
   '["function", "def", "func", "fn"]'::jsonb,
   'JavaScript function declarations use the function keyword.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is "hoisting" in JavaScript?',
   '0',
   '["Function declarations are moved to the top of their scope before code runs", "Variables are automatically given default values", "Functions run faster when hoisted", "Hoisting only applies to arrow functions"]'::jsonb,
   'Hoisting means JS moves function declarations to the top, so you can call them before they appear in the file.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a function that multiplies two numbers and logs the result:',
   '[{"id":"1","code":"function multiply(a, b) {"},{"id":"2","code":"  return a * b;"},{"id":"3","code":"}"},{"id":"4","code":"console.log(multiply(6, 7));"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["function multiply(a, b) {","  return a * b;","}","console.log(multiply(6, 7));"]'::jsonb,
   'Open the function, return inside, close the brace, then call and log.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Define a function called cube(n) that returns n ** 3. Log cube(3). Expected: 27',
   '// Define and call cube()' || chr(10),
   '27',
   'function cube(n) { return n ** 3; } console.log(cube(3));',
   5, 20);

  -- ── Lesson 3.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Arrow Functions', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which is the correct arrow function syntax?',
   '0',
   '["const double = n => n * 2;", "function double => n * 2;", "double(n) => { n * 2 }", "arrow double(n) { return n * 2; }"]'::jsonb,
   'Arrow functions use: const name = params => expression (or block).',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the arrow function symbol:',
   'const square = n ___ n * n;',
   '=>',
   '["=>", "->", "=", ">>"]'::jsonb,
   'Arrow functions use => (equals + greater-than) between parameters and the body.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const greet = name => `Hi, ${name}!`;' || chr(10) || 'console.log(greet("Sara"));',
   '0',
   '["Hi, Sara!", "name", "undefined", "Error"]'::jsonb,
   'greet("Sara") calls the arrow function with name="Sara". Returns "Hi, Sara!".',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to write and use an arrow function that adds 10:',
   '[{"id":"1","code":"const addTen = n => n + 10;"},{"id":"2","code":"const result = addTen(5);"},{"id":"3","code":"console.log(result);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const addTen = n => n + 10;","const result = addTen(5);","console.log(result);"]'::jsonb,
   'Define the arrow function, call it and store the result, then log it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an arrow function called isEven that returns true if n is even. Log isEven(4). Expected: true',
   '// Write and call your arrow function' || chr(10),
   'true',
   'const isEven = n => n % 2 === 0; console.log(isEven(4));',
   5, 20);

  -- ── Lesson 3.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Default Parameters', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'function greet(name = "World") {' || chr(10) || '  return `Hello, ${name}!`;' || chr(10) || '}' || chr(10) || 'console.log(greet());',
   '0',
   '["Hello, World!", "Hello, undefined!", "Error: name is required", "Hello, name!"]'::jsonb,
   'When greet() is called with no argument, name falls back to its default "World".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the default value so power(2) returns 4 (exp defaults to 2):',
   'function power(base, exp ___ 2) {' || chr(10) || '  return base ** exp;' || chr(10) || '}',
   '=',
   '["=", "==", ":", "=>"]'::jsonb,
   'Default parameters use = inside the parameter list: paramName = defaultValue.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const repeat = (str, times = 3) => str.repeat(times);' || chr(10) || 'console.log(repeat("ab", 2));',
   '0',
   '["abab", "ababab", "ab", "Error"]'::jsonb,
   'times = 2 overrides the default. "ab".repeat(2) = "abab".',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a function with a default and call it both ways:',
   '[{"id":"1","code":"function discount(price, pct = 10) {"},{"id":"2","code":"  return price - (price * pct / 100);"},{"id":"3","code":"}"},{"id":"4","code":"console.log(discount(100));"},{"id":"5","code":"console.log(discount(100, 20));"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["function discount(price, pct = 10) {","  return price - (price * pct / 100);","}","console.log(discount(100));","console.log(discount(100, 20));"]'::jsonb,
   'Define the function with default first, then show both calling styles.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a function greet(name = "Stranger") that returns "Hello, " + name + "!". Log greet(). Expected: Hello, Stranger!',
   '// Define and call greet()' || chr(10),
   'Hello, Stranger!',
   'function greet(name = "Stranger") { return "Hello, " + name + "!"; } console.log(greet());',
   5, 20);

  -- ── Lesson 3.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'map, filter, reduce', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does Array.map() return?',
   '0',
   '["A new array with each element transformed", "The original array modified in place", "A single accumulated value", "A boolean"]'::jsonb,
   'map() creates a NEW array by applying a function to each element of the original.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the array method that keeps only elements passing a test:',
   'const evens = [1,2,3,4].___( n => n % 2 === 0);',
   'filter',
   '["filter", "map", "reduce", "find"]'::jsonb,
   'filter() returns a new array containing only elements for which the callback returns true.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const total = [1, 2, 3, 4].reduce((sum, n) => sum + n, 0);' || chr(10) || 'console.log(total);',
   '0',
   '["10", "24", "[1,2,3,4]", "Error"]'::jsonb,
   'reduce accumulates: 0+1+2+3+4 = 10. The second argument (0) is the initial value.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to double every number in an array and log the result:',
   '[{"id":"1","code":"const nums = [1, 2, 3, 4, 5];"},{"id":"2","code":"const doubled = nums.map(n => n * 2);"},{"id":"3","code":"console.log(doubled);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const nums = [1, 2, 3, 4, 5];","const doubled = nums.map(n => n * 2);","console.log(doubled);"]'::jsonb,
   'Create the original array, transform it with map, then log the new array.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use filter to get only numbers greater than 3 from [1,2,3,4,5]. Log the result. Expected: [ 4, 5 ]',
   'const nums = [1, 2, 3, 4, 5];' || chr(10) || '// Use filter' || chr(10),
   '[ 4, 5 ]',
   'console.log(nums.filter(n => n > 3));',
   5, 20);


  -- ==============================================================
  -- UNIT 4: Arrays and Objects
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 4: Arrays & Objects',
          'Store and manipulate collections of data in arrays and objects',
          'blue', 4)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Arrays and Objects in JavaScript', $note$
# Arrays and Objects in JavaScript

## Arrays

An array is an ordered list of values:

```js
const fruits = ["apple", "banana", "cherry"];
console.log(fruits[0]);    // apple (index starts at 0)
console.log(fruits.length); // 3
```

**Key Array Methods**:

```js
fruits.push("mango");       // add to end → length 4
fruits.pop();               // remove and return last item
fruits.unshift("grape");    // add to start
fruits.shift();             // remove and return first item
fruits.includes("banana");  // true — check membership
fruits.indexOf("cherry");   // 2 — find index
fruits.join(", ");          // "apple, banana, cherry" — join to string
fruits.slice(1, 3);         // ["banana", "cherry"] — copy a portion
```

**Spread Operator**:

```js
const more = [...fruits, "kiwi", "lime"];  // copy + add
```

## Objects

An object stores key-value pairs:

```js
const person = {
  name: "Alice",
  age: 30,
  city: "Accra"
};

console.log(person.name);      // Alice — dot notation
console.log(person["age"]);    // 30  — bracket notation
person.job = "Engineer";       // add a new property
delete person.city;            // remove a property
```

**Destructuring**:

```js
const { name, age } = person;
console.log(name, age);   // Alice 30
```

**Spread in Objects**:

```js
const updated = { ...person, age: 31 };  // copy + override age
```

**Object Methods**:

```js
Object.keys(person);     // ["name", "age", "job"]
Object.values(person);   // ["Alice", 30, "Engineer"]
Object.entries(person);  // [["name","Alice"], ["age",30], ...]
```

## Looping Over Arrays and Objects

```js
// Array — for...of
for (const fruit of fruits) {
  console.log(fruit);
}

// Object — for...in
for (const key in person) {
  console.log(`${key}: ${person[key]}`);
}
```

## Key Takeaways
- Arrays use `[]`, objects use `{}` with key: value pairs
- `push/pop` modify the end; `unshift/shift` modify the start
- Destructuring extracts properties into variables cleanly
- `Object.keys()`, `.values()`, `.entries()` are essential for iterating objects
$note$, 0);

  -- ── Lesson 4.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Array Methods', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const arr = [1, 2, 3];' || chr(10) || 'arr.push(4);' || chr(10) || 'console.log(arr.length);',
   '0',
   '["4", "3", "1", "Error"]'::jsonb,
   'push() adds one element to the end. The array was length 3 and is now length 4.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the method that checks if "banana" exists in the array:',
   'const fruits = ["apple", "banana"];' || chr(10) || 'console.log(fruits.___("banana"));',
   'includes',
   '["includes", "contains", "has", "find"]'::jsonb,
   'includes() returns true if the array contains the specified element.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does arr.pop() do?',
   '0',
   '["Removes and returns the last element", "Removes and returns the first element", "Adds an element to the end", "Returns the array length"]'::jsonb,
   'pop() removes and returns the last element. Use shift() for the first.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to create an array, add an item, and log it:',
   '[{"id":"1","code":"const colors = [\"red\", \"green\"];"},{"id":"2","code":"colors.push(\"blue\");"},{"id":"3","code":"console.log(colors);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const colors = [\"red\", \"green\"];","colors.push(\"blue\");","console.log(colors);"]'::jsonb,
   'Create the array, mutate it with push, then log the result.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Join the array ["Hello", "World"] into a single string with a space separator. Log the result. Expected: Hello World',
   'const words = ["Hello", "World"];' || chr(10) || '// Use .join()' || chr(10),
   'Hello World',
   'console.log(words.join(" "));',
   5, 20);

  -- ── Lesson 4.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'JavaScript Objects', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const car = { brand: "Toyota", year: 2022 };' || chr(10) || 'console.log(car.brand);',
   '0',
   '["Toyota", "brand", "2022", "undefined"]'::jsonb,
   'Dot notation (object.property) accesses the value. car.brand = "Toyota".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete bracket notation to access the "name" property:',
   'const person = { name: "Alice" };' || chr(10) || 'console.log(person[___]);',
   '"name"',
   '[""name"", "name", "0", "person"]'::jsonb,
   'Bracket notation requires the key as a string in quotes: object["key"].',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does Object.keys({ a: 1, b: 2, c: 3 }) return?',
   '0',
   '["[\"a\", \"b\", \"c\"]", "[1, 2, 3]", "[[\"a\",1],[\"b\",2],[\"c\",3]]", "3"]'::jsonb,
   'Object.keys() returns an array of the object''s own property names.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to create an object, add a property, and log it:',
   '[{"id":"1","code":"const phone = { brand: \"Samsung\", model: \"S24\" };"},{"id":"2","code":"phone.color = \"black\";"},{"id":"3","code":"console.log(phone.color);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const phone = { brand: \"Samsung\", model: \"S24\" };","phone.color = \"black\";","console.log(phone.color);"]'::jsonb,
   'Create the object, add a new property, then log that new property.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create an object with name "Ghana" and population 33000000. Log the name. Expected: Ghana',
   '// Create your object and log the name property' || chr(10),
   'Ghana',
   'const country = { name: "Ghana", population: 33000000 }; console.log(country.name);',
   5, 20);

  -- ── Lesson 4.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Destructuring', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const { x, y } = { x: 10, y: 20 };' || chr(10) || 'console.log(x + y);',
   '0',
   '["30", "xy", "undefined", "Error"]'::jsonb,
   'Destructuring pulls x=10 and y=20 from the object. 10 + 20 = 30.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the destructuring syntax to extract "name" and "age" from the object:',
   'const ___ = { name: "Bob", age: 25 };',
   '{ name, age }',
   '["{ name, age }", "[name, age]", "(name, age)", "name, age"]'::jsonb,
   'Object destructuring uses curly braces: const { prop1, prop2 } = object.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const [a, , c] = [1, 2, 3];' || chr(10) || 'console.log(a, c);',
   '0',
   '["1 3", "1 2", "2 3", "Error"]'::jsonb,
   'Array destructuring assigns by position. The middle comma skips index 1 (value 2).',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to destructure a user object and log their name:',
   '[{"id":"1","code":"const user = { name: \"Alice\", role: \"admin\" };"},{"id":"2","code":"const { name, role } = user;"},{"id":"3","code":"console.log(name);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const user = { name: \"Alice\", role: \"admin\" };","const { name, role } = user;","console.log(name);"]'::jsonb,
   'Create the object, destructure it, then log the extracted variable.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Destructure the first two elements of [10, 20, 30] into a and b. Log a + b. Expected: 30',
   'const nums = [10, 20, 30];' || chr(10) || '// Destructure and log the sum' || chr(10),
   '30',
   'const [a, b] = nums; console.log(a + b);',
   5, 20);

  -- ── Lesson 4.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Spread and Rest Operators', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const a = [1, 2];' || chr(10) || 'const b = [...a, 3, 4];' || chr(10) || 'console.log(b);',
   '0',
   '["[1, 2, 3, 4]", "[3, 4, 1, 2]", "[[1,2], 3, 4]", "Error"]'::jsonb,
   'The spread operator ... expands an array. [...a, 3, 4] = [1, 2, 3, 4].',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the rest parameter to collect extra arguments:',
   'function logAll(first, ___args) {' || chr(10) || '  console.log(first, args);' || chr(10) || '}',
   '...',
   '["...", "**", "->", "&"]'::jsonb,
   '...rest collects all remaining arguments into an array. Called "rest parameters".',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'const obj1 = { a: 1 };' || chr(10) || 'const obj2 = { ...obj1, b: 2 };' || chr(10) || 'console.log(obj2);',
   '0',
   '["{ a: 1, b: 2 }", "{ b: 2 }", "{ a: 1 }", "Error"]'::jsonb,
   'Spread on an object copies all its properties. ...obj1 copies a:1, then b:2 is added.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to merge two arrays using spread:',
   '[{"id":"1","code":"const evens = [2, 4, 6];"},{"id":"2","code":"const odds = [1, 3, 5];"},{"id":"3","code":"const all = [...evens, ...odds];"},{"id":"4","code":"console.log(all);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["const evens = [2, 4, 6];","const odds = [1, 3, 5];","const all = [...evens, ...odds];","console.log(all);"]'::jsonb,
   'Declare both arrays, then spread them into a new combined array, then log.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Copy the array [1,2,3] into a new array and add 4 at the end using spread. Log it. Expected: [ 1, 2, 3, 4 ]',
   'const original = [1, 2, 3];' || chr(10) || '// Use spread to copy and extend' || chr(10),
   '[ 1, 2, 3, 4 ]',
   'console.log([...original, 4]);',
   5, 20);


  -- ==============================================================
  -- UNIT 5: Loops in JavaScript
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 5: Loops',
          'Repeat code with for, while, for...of, and for...in loops',
          'purple', 5)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Loops in JavaScript', $note$
# Loops in JavaScript

## for Loop

The classic loop with initializer, condition, and updater:

```js
for (let i = 0; i < 5; i++) {
  console.log(i);   // 0 1 2 3 4
}
```

## while Loop

Runs while the condition is true:

```js
let count = 0;
while (count < 3) {
  console.log(count);   // 0 1 2
  count++;
}
```

## do...while Loop

Always runs at least once, then checks the condition:

```js
let n = 0;
do {
  console.log(n);   // 0 (runs once even if condition false)
  n++;
} while (n < 0);
```

## for...of Loop

The modern way to iterate array values:

```js
const fruits = ["apple", "banana", "cherry"];
for (const fruit of fruits) {
  console.log(fruit);   // apple, banana, cherry
}
```

## for...in Loop

Iterates over an object's keys:

```js
const person = { name: "Alice", age: 30 };
for (const key in person) {
  console.log(`${key}: ${person[key]}`);
}
// name: Alice
// age: 30
```

## break and continue

```js
for (let i = 0; i < 10; i++) {
  if (i === 5) break;      // stop at 5
  if (i === 3) continue;   // skip 3
  console.log(i);          // 0, 1, 2, 4
}
```

## Key Takeaways
- `for` is best when you know how many iterations you need
- `for...of` is the cleanest way to iterate array items
- `for...in` iterates object keys (not recommended for arrays)
- `break` exits immediately; `continue` skips to the next iteration
$note$, 0);

  -- ── Lesson 5.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'for Loops', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How many times does this loop run?' || chr(10) || 'for (let i = 0; i < 4; i++) { console.log(i); }',
   '0',
   '["4 times (0,1,2,3)", "5 times (0,1,2,3,4)", "3 times (1,2,3)", "Infinite times"]'::jsonb,
   'The loop runs while i < 4. Starting at 0, it runs for i = 0, 1, 2, 3 — that''s 4 iterations.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the increment part of the for loop:',
   'for (let i = 0; i < 5; ___) {',
   'i++',
   '["i++", "i+1", "i+=1", "i = i"]'::jsonb,
   'i++ is the standard shorthand for i = i + 1 — incrementing by 1 each iteration.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'let sum = 0;' || chr(10) || 'for (let i = 1; i <= 4; i++) { sum += i; }' || chr(10) || 'console.log(sum);',
   '0',
   '["10", "4", "1234", "Error"]'::jsonb,
   'The loop adds 1+2+3+4 = 10 to sum.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these parts of a for loop to print numbers 1 to 3:',
   '[{"id":"1","code":"for (let i = 1; i <= 3; i++) {"},{"id":"2","code":"  console.log(i);"},{"id":"3","code":"}"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["for (let i = 1; i <= 3; i++) {","  console.log(i);","}"]'::jsonb,
   'for header first, body inside braces second, closing brace third.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a for loop to log the numbers 1, 2, 3, 4, 5 each on a separate line.',
   '// Write your for loop' || chr(10),
   '1' || chr(10) || '2' || chr(10) || '3' || chr(10) || '4' || chr(10) || '5',
   'for (let i = 1; i <= 5; i++) { console.log(i); }',
   5, 20);

  -- ── Lesson 5.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'for...of and for...in', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does for...of iterate over in an array?',
   '0',
   '["The VALUES of the array", "The KEYS (indices) of the array", "The array''s methods", "Nothing — for...of doesn''t work on arrays"]'::jsonb,
   'for...of gives you the values. for...in gives you the indices (keys).',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword in the for...of loop:',
   'for (const item ___ myArray) {',
   'of',
   '["of", "in", "from", "at"]'::jsonb,
   'for...of uses the of keyword: for (const item of array).',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which loop is best for iterating over an OBJECT''s properties?',
   '0',
   '["for...in", "for...of", "for with index", "while"]'::jsonb,
   'for...in iterates over an object''s enumerable keys. for...of works on iterables like arrays.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a for...of loop to log each name in an array:',
   '[{"id":"1","code":"const names = [\"Alice\", \"Bob\", \"Carol\"];"},{"id":"2","code":"for (const name of names) {"},{"id":"3","code":"  console.log(name);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["const names = [\"Alice\", \"Bob\", \"Carol\"];","for (const name of names) {","  console.log(name);","}"]'::jsonb,
   'Declare the array, open the for...of, log inside, then close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use for...in to log all keys of { x: 1, y: 2, z: 3 }. Expected: x y z (each on own line)',
   'const point = { x: 1, y: 2, z: 3 };' || chr(10) || '// Use for...in' || chr(10),
   'x' || chr(10) || 'y' || chr(10) || 'z',
   'for (const key in point) { console.log(key); }',
   5, 20);

  -- ── Lesson 5.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'while and do...while', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the key difference between while and do...while?',
   '0',
   '["do...while always runs the body at least once; while may skip it entirely", "while is faster than do...while", "do...while cannot use break", "There is no practical difference"]'::jsonb,
   'do...while checks its condition AFTER running the body, guaranteeing at least one execution.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the while keyword:',
   'let i = 0;' || chr(10) || '___ (i < 3) {' || chr(10) || '  console.log(i);' || chr(10) || '  i++;' || chr(10) || '}',
   'while',
   '["while", "for", "loop", "repeat"]'::jsonb,
   'while is JavaScript''s keyword for a condition-based loop.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How many times does this do...while body run?' || chr(10) || 'let n = 10;' || chr(10) || 'do { console.log(n); n++; } while (n < 5);',
   '0',
   '["Once (n starts at 10, condition is immediately false after first run)", "Zero times", "Five times", "Forever"]'::jsonb,
   'do...while runs the body once first, then checks n < 5 → 10 < 5 is false → stops. Total: 1 run.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a while loop that counts from 1 to 3:',
   '[{"id":"1","code":"let i = 1;"},{"id":"2","code":"while (i <= 3) {"},{"id":"3","code":"  console.log(i);"},{"id":"4","code":"  i++;"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["let i = 1;","while (i <= 3) {","  console.log(i);","  i++;","}"]'::jsonb,
   'Initialize, open while, log, increment, then close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a while loop to log the sum of 1+2+3+4+5 after the loop ends. Expected: 15',
   '// Use a while loop to sum 1 through 5' || chr(10) || 'let sum = 0;' || chr(10) || 'let i = 1;' || chr(10),
   '15',
   'while (i <= 5) { sum += i; i++; } console.log(sum);',
   5, 20);

  -- ── Lesson 5.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'break and continue', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What numbers does this log?' || chr(10) || 'for (let i = 0; i < 5; i++) {' || chr(10) || '  if (i === 3) break;' || chr(10) || '  console.log(i);' || chr(10) || '}',
   '0',
   '["0, 1, 2", "0, 1, 2, 3", "0, 1, 2, 3, 4", "1, 2"]'::jsonb,
   'When i reaches 3, break exits the loop. Only 0, 1, 2 are logged before that.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete with the keyword that skips to the next iteration without exiting the loop:',
   'for (let i = 0; i < 5; i++) {' || chr(10) || '  if (i === 2) ___;' || chr(10) || '  console.log(i);' || chr(10) || '}',
   'continue',
   '["continue", "break", "skip", "next"]'::jsonb,
   'continue jumps to the next loop iteration, skipping any code below it in the loop body.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is logged?' || chr(10) || 'for (let i = 0; i < 4; i++) {' || chr(10) || '  if (i % 2 === 0) continue;' || chr(10) || '  console.log(i);' || chr(10) || '}',
   '0',
   '["1, 3", "0, 2", "0, 1, 2, 3", "1, 2, 3"]'::jsonb,
   'continue skips even numbers (i % 2 === 0). Only odd values 1 and 3 are logged.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a loop that prints only odd numbers from 1 to 9:',
   '[{"id":"1","code":"for (let i = 1; i <= 9; i++) {"},{"id":"2","code":"  if (i % 2 === 0) continue;"},{"id":"3","code":"  console.log(i);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["for (let i = 1; i <= 9; i++) {","  if (i % 2 === 0) continue;","  console.log(i);","}"]'::jsonb,
   'Open the loop, skip evens with continue, log the rest, then close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Loop 0-9. Skip multiples of 3 (use continue). Log the rest. Expected: 1 2 4 5 7 8 (each on own line)',
   '// Use continue to skip multiples of 3' || chr(10),
   '1' || chr(10) || '2' || chr(10) || '4' || chr(10) || '5' || chr(10) || '7' || chr(10) || '8',
   'for (let i = 0; i < 9; i++) { if (i % 3 === 0) continue; console.log(i); }',
   5, 20);


  -- ==============================================================
  -- UNIT 6: DOM and Events
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 6: DOM & Events',
          'Manipulate web pages and respond to user interactions',
          'red', 6)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'The DOM and Events', $note$
# The DOM and Events

The DOM (Document Object Model) is the browser's tree-shaped representation of your HTML. JavaScript can read and change it to make pages interactive.

## Selecting Elements

```js
// By ID — returns one element or null
const btn = document.getElementById("myButton");

// By CSS selector — returns first match
const title = document.querySelector(".title");

// By CSS selector — returns ALL matches as NodeList
const items = document.querySelectorAll("li");
```

## Changing Content and Style

```js
const el = document.querySelector("#message");

el.textContent = "Hello!";           // change text
el.innerHTML = "<strong>Bold</strong>"; // set HTML inside
el.style.color = "red";              // inline CSS
el.classList.add("active");          // add a CSS class
el.classList.remove("hidden");       // remove a class
el.classList.toggle("visible");      // toggle a class
```

## Creating and Inserting Elements

```js
const li = document.createElement("li");
li.textContent = "New item";
document.querySelector("ul").appendChild(li);
```

## Handling Events

```js
const btn = document.getElementById("myBtn");

btn.addEventListener("click", function() {
  console.log("Button clicked!");
});

// Arrow function version
btn.addEventListener("click", () => {
  console.log("Clicked!");
});
```

Common events: `click`, `input`, `submit`, `keydown`, `mouseover`, `load`

## The Event Object

```js
document.addEventListener("keydown", (event) => {
  console.log(event.key);   // which key was pressed
});

btn.addEventListener("click", (event) => {
  event.preventDefault();   // stop default action (e.g. form submit)
});
```

## Key Takeaways
- `querySelector` uses CSS selectors; `getElementById` uses just the id value
- `addEventListener` attaches a callback that fires when the event occurs
- `textContent` is safer than innerHTML (no HTML injection risk)
- `event.preventDefault()` stops the browser's default behaviour
$note$, 0);

  -- ── Lesson 6.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Selecting DOM Elements', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which method selects an element by its id attribute?',
   '0',
   '["document.getElementById()", "document.querySelector()", "document.getElement()", "document.select()"]'::jsonb,
   'getElementById takes an ID string (without the # prefix) and returns one element.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the method that selects the FIRST element matching a CSS selector:',
   'const btn = document.___(\"#submit\");',
   'querySelector',
   '["querySelector", "getElementById", "getElement", "findElement"]'::jsonb,
   'querySelector accepts any CSS selector — "#id", ".class", "tag" — and returns the first match.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does document.querySelectorAll("li") return?',
   '0',
   '["A NodeList of all matching <li> elements", "Only the first <li> element", "An array of all <li> elements", "null if no matches"]'::jsonb,
   'querySelectorAll returns a NodeList (not a plain array) of ALL matching elements.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange steps to select an element and change its text:',
   '[{"id":"1","code":"// 1. Select the element"},{"id":"2","code":"const heading = document.querySelector(\"h1\");"},{"id":"3","code":"// 2. Change its content"},{"id":"4","code":"heading.textContent = \"Welcome!\";"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["// 1. Select the element","const heading = document.querySelector(\"h1\");","// 2. Change its content","heading.textContent = \"Welcome!\";"]'::jsonb,
   'Select the element first, then modify its text content.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'What method do you call on document to select ALL elements with class "card"? Log the method name as a string. Expected: querySelectorAll',
   '// Log the name of the correct method' || chr(10),
   'querySelectorAll',
   'console.log("querySelectorAll");',
   5, 20);

  -- ── Lesson 6.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Changing the DOM', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the difference between textContent and innerHTML?',
   '0',
   '["textContent sets plain text safely; innerHTML parses and renders HTML", "textContent allows HTML tags; innerHTML does not", "They are identical", "innerHTML is deprecated"]'::jsonb,
   'textContent treats everything as text (safe). innerHTML renders HTML markup (risk of XSS if using user data).',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the property to add the CSS class "active" to an element:',
   'el.classList.___(\"active\");',
   'add',
   '["add", "append", "push", "insert"]'::jsonb,
   'classList.add() adds a CSS class to the element without removing others.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does document.createElement("div") do?',
   '0',
   '["Creates a new <div> element in memory but does not add it to the page yet", "Creates a div and immediately inserts it into the DOM", "Selects all existing divs", "Creates a div and removes all other divs"]'::jsonb,
   'createElement builds a new element in memory. You still need appendChild or similar to insert it.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange steps to create a new list item and append it to a ul:',
   '[{"id":"1","code":"const li = document.createElement(\"li\");"},{"id":"2","code":"li.textContent = \"New item\";"},{"id":"3","code":"document.querySelector(\"ul\").appendChild(li);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["const li = document.createElement(\"li\");","li.textContent = \"New item\";","document.querySelector(\"ul\").appendChild(li);"]'::jsonb,
   'Create element, set its text, then append it to the parent.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Log the string that represents the CSS method used to toggle a class. Expected: toggle',
   '// Log the classList method for toggling' || chr(10),
   'toggle',
   'console.log("toggle"); // classList.toggle() adds the class if absent, removes if present',
   5, 20);

  -- ── Lesson 6.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Event Listeners', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which method attaches a function to run when an event fires?',
   '0',
   '["addEventListener()", "onEvent()", "attachEvent()", "bindEvent()"]'::jsonb,
   'addEventListener(eventType, callback) is the standard way to listen for events.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the event type string for a mouse click:',
   'btn.addEventListener("___", () => console.log("clicked"));',
   'click',
   '["click", "pressed", "tap", "mouseclick"]'::jsonb,
   'The event type for a mouse click is the string "click".',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the purpose of event.preventDefault()?',
   '0',
   '["Stops the browser''s default action for an event (e.g. stops a form submitting)", "Removes the event listener permanently", "Prevents the event from firing at all", "Logs the event to the console"]'::jsonb,
   'preventDefault() stops the built-in browser behaviour — e.g. preventing a form from reloading the page.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange steps to add a click listener that logs "Hello!":',
   '[{"id":"1","code":"const btn = document.getElementById(\"myBtn\");"},{"id":"2","code":"btn.addEventListener(\"click\", () => {"},{"id":"3","code":"  console.log(\"Hello!\");"},{"id":"4","code":"});"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["const btn = document.getElementById(\"myBtn\");","btn.addEventListener(\"click\", () => {","  console.log(\"Hello!\");","});"]'::jsonb,
   'Get the element, call addEventListener, write the callback body, then close it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Log the names of three common DOM events separated by commas. Expected: click, input, submit',
   '// Log the three event names' || chr(10),
   'click, input, submit',
   'console.log("click, input, submit");',
   5, 20);

  -- ── Lesson 6.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Event Delegation', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is event delegation?',
   '0',
   '["Attaching one listener to a parent element to handle events from child elements", "Passing events between multiple files", "Using multiple listeners on the same element", "Preventing events from bubbling up the DOM"]'::jsonb,
   'Event delegation exploits bubbling — events from children bubble up, so a parent can catch them all.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the property that tells you which element originally triggered the event:',
   'ul.addEventListener("click", (e) => {' || chr(10) || '  console.log(e.___.tagName);' || chr(10) || '});',
   'target',
   '["target", "source", "origin", "element"]'::jsonb,
   'event.target is the element that triggered the event, even if caught by a parent listener.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is "event bubbling"?',
   '0',
   '["An event on a child element propagates up to its parent elements", "An event fires multiple times rapidly", "Events are queued and run in order", "Events travel from parent to child"]'::jsonb,
   'Bubbling: a click on a <li> also triggers click handlers on its <ul>, then <body>, then <html>.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a delegated click listener on a list that logs which item was clicked:',
   '[{"id":"1","code":"const list = document.querySelector(\"ul\");"},{"id":"2","code":"list.addEventListener(\"click\", (e) => {"},{"id":"3","code":"  if (e.target.tagName === \"LI\") {"},{"id":"4","code":"    console.log(e.target.textContent);"},{"id":"5","code":"  }});"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["const list = document.querySelector(\"ul\");","list.addEventListener(\"click\", (e) => {","  if (e.target.tagName === \"LI\") {","    console.log(e.target.textContent);","  });"]'::jsonb,
   'Select the parent, add the listener, check e.target is an LI, then log its text.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Log the two main benefits of event delegation separated by " and ". Expected: fewer listeners and handles dynamic elements',
   '// Log the two benefits' || chr(10),
   'fewer listeners and handles dynamic elements',
   'console.log("fewer listeners and handles dynamic elements");',
   5, 20);

END $$;