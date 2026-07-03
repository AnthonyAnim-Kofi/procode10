-- ============================================================
-- REAL C++ CURRICULUM
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

  -- Prefer slug 'cpp' (used by the app); fall back to legacy 'c++' row if present.
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug IN ('cpp', 'c++')
  ORDER BY CASE WHEN slug = 'cpp' THEN 0 ELSE 1 END
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('C++', 'cpp', '⚙️', 'A powerful, fast, systems-level programming language')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with C++
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Write your first C++ programs and understand compilation', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to C++', $note$
# Introduction to C++

C++ is a compiled, statically typed, general-purpose language created by Bjarne Stroustrup in 1985 as an extension of C. It is used in operating systems, game engines, embedded systems, and high-performance applications.

## Your First Program

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```

Breaking it down:
- `#include <iostream>` — imports the input/output stream library
- `using namespace std;` — lets you write `cout` instead of `std::cout`
- `int main()` — every C++ program starts here; returns an int (0 = success)
- `cout << "..."` — outputs text to the console
- `endl` — flushes the buffer and moves to the next line
- Every statement ends with `;`

## How C++ Runs

1. Write `main.cpp`
2. Compile: `g++ main.cpp -o main`
3. Run: `./main`

## Variables and Types

C++ is statically typed — you must declare the type:

```cpp
int    age    = 25;
double price  = 9.99;
char   grade  = 'A';
bool   active = true;
string name   = "Alice";   // requires #include <string>
```

## Output

```cpp
cout << "Name: " << name << endl;
cout << "Age: "  << age  << "\n";
```

## Input

```cpp
int x;
cin >> x;           // read one value
string line;
getline(cin, line); // read whole line
```

## Comments

```cpp
// Single-line comment
/* Multi-line
   comment */
```

## Arithmetic

`+`, `-`, `*`, `/`, `%` — same as most languages.
Integer division truncates: `7 / 2 = 3`. Use `7.0 / 2` for `3.5`.

## Key Takeaways
- Every C++ program needs `main()` returning `int`
- `#include` pulls in library headers
- Types are declared explicitly: `int`, `double`, `string`, `bool`, `char`
- Compile with `g++`, run the resulting executable
$note$, 0);

  -- Lesson 1.1
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Hello, C++!', 1) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the entry point of every C++ program?',
   '0',
   '["int main()", "void start()", "public static void main()", "run()"]'::jsonb,
   'The C++ runtime always calls main(). It must return int (0 signals success).',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the header needed to use cout:',
   '#include <___>',
   'iostream',
   '["iostream", "stdio", "cout", "output"]'::jsonb,
   'iostream provides cout (output) and cin (input). Always include it for console I/O.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the statement "return 0;" at the end of main() signify?',
   '0',
   '["The program finished successfully", "The program returned the number zero", "The program crashed", "Nothing — it is optional in all cases"]'::jsonb,
   'By convention, returning 0 from main signals successful completion to the operating system.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange the lines of a minimal C++ Hello World program:',
   '[{"id":"1","code":"#include <iostream>"},{"id":"2","code":"using namespace std;"},{"id":"3","code":"int main() {"},{"id":"4","code":"    cout << \"Hello!\" << endl;"},{"id":"5","code":"    return 0; }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["#include <iostream>","using namespace std;","int main() {","    cout << \"Hello!\" << endl;","    return 0; }"]'::jsonb,
   'Include first, namespace second, main third, output inside, return last.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a C++ program that prints: Hello, C++!',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    // Write your cout here' || chr(10) || '    return 0;' || chr(10) || '}',
   'Hello, C++!',
   'cout << "Hello, C++!" << endl;',
   5, 20);

  -- Lesson 1.2
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Variables and Data Types', 2) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which C++ type stores a decimal number with double precision?',
   '0',
   '["double", "float", "decimal", "real"]'::jsonb,
   'double uses 64 bits for higher precision. float uses 32 bits. double is preferred.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the type for a true/false variable:',
   '___ isOnline = true;',
   'bool',
   '["bool", "boolean", "bit", "flag"]'::jsonb,
   'C++ uses bool for true/false values (lowercase).',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the result of 9 / 2 when both operands are int in C++?',
   '0',
   '["4", "4.5", "5", "Error"]'::jsonb,
   'Integer division in C++ truncates toward zero. 9 / 2 = 4 (not 4.5).',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to declare an int, a double, and a string, then print them:',
   '[{"id":"1","code":"int age = 20;"},{"id":"2","code":"double gpa = 3.8;"},{"id":"3","code":"string name = \"Alice\";"},{"id":"4","code":"cout << name << \" \" << age << \" \" << gpa << endl;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int age = 20;","double gpa = 3.8;","string name = \"Alice\";","cout << name << \" \" << age << \" \" << gpa << endl;"]'::jsonb,
   'Declare int, double, string in that order, then output all three.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Declare an int called score = 95 and print it.',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    // Declare score and print' || chr(10) || '    return 0;' || chr(10) || '}',
   '95',
   'int score = 95; cout << score << endl;',
   5, 20);

  -- Lesson 1.3
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Input and Output', 3) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which C++ object is used to read input from the keyboard?',
   '0',
   '["cin", "cout", "scanf", "read"]'::jsonb,
   'cin (character input) reads from standard input. cout writes to standard output.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the extraction operator used with cin:',
   'int x;' || chr(10) || 'cin ___ x;',
   '>>',
   '[">>", "<<", "->", "=>"]'::jsonb,
   'cin uses >> (extraction operator) to read into a variable. cout uses << (insertion).',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the difference between endl and "\n" in C++?',
   '0',
   '["endl flushes the output buffer; \\n does not flush", "They are identical in all situations", "\\n is not valid in C++", "endl adds two newlines"]'::jsonb,
   'endl flushes the stream buffer (slower). "\n" just adds a newline (faster for large output).',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange lines to read a number and print it doubled:',
   '[{"id":"1","code":"int n;"},{"id":"2","code":"cin >> n;"},{"id":"3","code":"cout << n * 2 << endl;"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["int n;","cin >> n;","cout << n * 2 << endl;"]'::jsonb,
   'Declare first, read second, compute and output third.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print the result of 3 * 7 using cout. Expected: 21',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    // Print 3 * 7' || chr(10) || '    return 0;' || chr(10) || '}',
   '21',
   'cout << 3 * 7 << endl;',
   5, 20);

  -- Lesson 1.4
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Constants and Type Casting', 4) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which keyword declares a constant in C++?',
   '0',
   '["const", "final", "static", "readonly"]'::jsonb,
   'const prevents reassignment. const double PI = 3.14159; cannot be changed later.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the C-style cast to convert a double to int:',
   'double d = 4.9;' || chr(10) || 'int n = ___ d;',
   '(int)',
   '["(int)", "int()", "cast<int>", "to_int"]'::jsonb,
   'C-style cast syntax: (TargetType) value. The decimal is truncated, not rounded.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: cout << (int) 7.9;',
   '0',
   '["7", "8", "7.9", "Error"]'::jsonb,
   '(int) truncates the decimal part. 7.9 becomes 7.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to cast int to double for accurate division:',
   '[{"id":"1","code":"int a = 7, b = 2;"},{"id":"2","code":"double result = (double)a / b;"},{"id":"3","code":"cout << result << endl;"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["int a = 7, b = 2;","double result = (double)a / b;","cout << result << endl;"]'::jsonb,
   'Declare ints, cast one to double so division returns decimal, then print.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Cast 9.7 to int and print it. Expected: 9',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    double d = 9.7;' || chr(10) || '    // Cast and print' || chr(10) || '    return 0;' || chr(10) || '}',
   '9',
   'cout << (int)d << endl;',
   5, 20);

  -- ==============================================================
  -- UNIT 2: Control Flow
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 2: Control Flow', 'Make decisions and repeat code with conditions and loops', 'green', 2)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Control Flow in C++', $note$
# Control Flow in C++

## if / else if / else

```cpp
int score = 85;

if (score >= 90) {
    cout << "A" << endl;
} else if (score >= 80) {
    cout << "B" << endl;
} else {
    cout << "F" << endl;
}
```

## Comparison and Logical Operators

| Operator | Meaning       |
|----------|--------------|
| `==`     | Equal        |
| `!=`     | Not equal    |
| `<` `>`  | Less/Greater |
| `&&`     | AND          |
| `\|\|`   | OR           |
| `!`      | NOT          |

## switch

```cpp
int day = 3;
switch (day) {
    case 1: cout << "Mon"; break;
    case 2: cout << "Tue"; break;
    case 3: cout << "Wed"; break;
    default: cout << "Other";
}
```

## for Loop

```cpp
for (int i = 0; i < 5; i++) {
    cout << i << " ";
}
```

## while Loop

```cpp
int i = 0;
while (i < 3) {
    cout << i++ << " ";
}
```

## do-while Loop

Guaranteed to execute at least once:

```cpp
int n;
do {
    cin >> n;
} while (n <= 0);
```

## Range-based for (C++11)

```cpp
int nums[] = {10, 20, 30};
for (int x : nums) {
    cout << x << " ";
}
```

## break and continue

`break` exits the loop; `continue` skips to the next iteration.

## Key Takeaways
- C++ uses `{` `}` for all code blocks
- `switch` needs `break` to prevent fall-through
- Range-based `for (auto x : container)` is the modern iteration style
- `do-while` guarantees at least one execution
$note$, 0);

  -- Lesson 2.1
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'if / else Statements', 1) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is printed?' || chr(10) || 'int x = 7;' || chr(10) || 'if (x > 10) cout << "big";' || chr(10) || 'else cout << "small";',
   '0',
   '["small", "big", "Nothing", "Error"]'::jsonb,
   '7 > 10 is false, so the else branch runs: "small".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the operator to check equality in C++:',
   'if (x ___ 10) cout << "equal";',
   '==',
   '["==", "=", "===", "equals"]'::jsonb,
   'Use == for comparison. Single = is assignment and will cause a bug.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: int n = 5; cout << (n % 2 == 0 ? "even" : "odd");',
   '0',
   '["odd", "even", "5", "Error"]'::jsonb,
   '5 % 2 = 1, which is not 0, so the ternary returns "odd".',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange: check if temp <= 0, print "Freezing" else print "Warm":',
   '[{"id":"1","code":"int temp = -3;"},{"id":"2","code":"if (temp <= 0) {"},{"id":"3","code":"    cout << \"Freezing\" << endl;"},{"id":"4","code":"} else {"},{"id":"5","code":"    cout << \"Warm\" << endl; }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["int temp = -3;","if (temp <= 0) {","    cout << \"Freezing\" << endl;","} else {","    cout << \"Warm\" << endl; }"]'::jsonb,
   'Declare, if with brace, body, else with brace, body.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print "Even" if 8 is divisible by 2, else print "Odd". Expected: Even',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    int n = 8;' || chr(10) || '    // Write your if/else' || chr(10) || '    return 0;' || chr(10) || '}',
   'Even',
   'if (n % 2 == 0) cout << "Even" << endl; else cout << "Odd" << endl;',
   5, 20);

  -- Lesson 2.2
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Loops', 2) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How many times does this loop body execute?' || chr(10) || 'for (int i = 0; i < 5; i++) { ... }',
   '0',
   '["5 times (i = 0,1,2,3,4)", "4 times", "6 times", "Infinite"]'::jsonb,
   'i starts at 0 and runs while i < 5: iterations for i = 0, 1, 2, 3, 4.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the range-based for loop syntax:',
   'for (int x ___ nums) { cout << x; }',
   ':',
   '[":", "in", "of", "->"]'::jsonb,
   'Range-based for uses a colon: for (type var : container).',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the continue keyword do inside a C++ loop?',
   '0',
   '["Skips the rest of the current iteration and goes to the next", "Exits the loop entirely", "Restarts the loop counter", "Pauses execution"]'::jsonb,
   'continue jumps to the next iteration. break exits the loop entirely.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a while loop that prints 1, 2, 3:',
   '[{"id":"1","code":"int i = 1;"},{"id":"2","code":"while (i <= 3) {"},{"id":"3","code":"    cout << i << endl;"},{"id":"4","code":"    i++;"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["int i = 1;","while (i <= 3) {","    cout << i << endl;","    i++;","}"]'::jsonb,
   'Initialize, open while, print, increment, close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a for loop to print the sum of 1 through 5. Expected: 15',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    int sum = 0;' || chr(10) || '    // Loop and sum' || chr(10) || '    cout << sum << endl;' || chr(10) || '    return 0;' || chr(10) || '}',
   '15',
   'for (int i = 1; i <= 5; i++) sum += i;',
   5, 20);

  -- Lesson 2.3
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'switch Statements', 3) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What happens without a break in a switch case?',
   '0',
   '["Execution falls through to the next case", "The switch exits automatically", "An error is thrown", "The default runs instead"]'::jsonb,
   'Without break, C++ continues executing into the next case body — called fall-through.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword that exits a switch case:',
   'case 1: cout << "one"; ___;',
   'break',
   '["break", "exit", "stop", "return"]'::jsonb,
   'break prevents fall-through by jumping past the end of the switch block.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which switch clause runs when no case matches?',
   '0',
   '["default", "else", "otherwise", "catch"]'::jsonb,
   'The default clause is the fallback — it runs when no case value matches the switch expression.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a switch that prints the season for month = 7:',
   '[{"id":"1","code":"int month = 7;"},{"id":"2","code":"switch (month) {"},{"id":"3","code":"    case 7: cout << \"Summer\"; break;"},{"id":"4","code":"    default: cout << \"Other\";"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["int month = 7;","switch (month) {","    case 7: cout << \"Summer\"; break;","    default: cout << \"Other\";","}"]'::jsonb,
   'Variable, switch open, case with break, default, close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a switch on grade = ''A'' to print "Excellent". Expected: Excellent',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    char grade = ''A'';' || chr(10) || '    // Write your switch' || chr(10) || '    return 0;' || chr(10) || '}',
   'Excellent',
   'switch (grade) { case ''A'': cout << "Excellent"; break; }',
   5, 20);

  -- Lesson 2.4
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Logical Operators and Conditions', 4) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: cout << (true && false);',
   '0',
   '["0", "1", "false", "Error"]'::jsonb,
   'In C++, true prints as 1 and false as 0. true && false = false = 0.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the operator to check if either condition is true:',
   'if (x < 0 ___ x > 100) cout << "Out of range";',
   '||',
   '["||", "&&", "!", "or"]'::jsonb,
   '|| is the OR operator in C++. At least one side must be true for the result to be true.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the value of: !(5 > 3)',
   '0',
   '["false (0)", "true (1)", "5", "Error"]'::jsonb,
   '5 > 3 is true. NOT true = false. In C++ output: 0.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange: print "Valid" if x is between 1 and 100 inclusive:',
   '[{"id":"1","code":"int x = 50;"},{"id":"2","code":"if (x >= 1 && x <= 100) {"},{"id":"3","code":"    cout << \"Valid\" << endl;"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int x = 50;","if (x >= 1 && x <= 100) {","    cout << \"Valid\" << endl;","}"]'::jsonb,
   'Declare x, combine two conditions with &&, print inside the block.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print "Pass" if score = 72 >= 50, else print "Fail". Expected: Pass',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    int score = 72;' || chr(10) || '    // Write if/else' || chr(10) || '    return 0;' || chr(10) || '}',
   'Pass',
   'if (score >= 50) cout << "Pass" << endl; else cout << "Fail" << endl;',
   5, 20);

  -- ==============================================================
  -- UNIT 3: Functions
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 3: Functions', 'Write reusable code with parameters, return types, and overloading', 'orange', 3)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Functions in C++', $note$
# Functions in C++

## Function Anatomy

```cpp
int add(int a, int b) {
    return a + b;
}
```

- Return type comes first (`int`)
- Then function name (`add`)
- Then parameters with types in parentheses
- `return` sends a value back to the caller
- `void` means no return value

## Calling a Function

```cpp
int result = add(3, 4);   // result = 7
cout << add(10, 5);       // prints 15
```

## Function Declarations (Prototypes)

If a function is used before it is defined, declare it first:

```cpp
int add(int, int);   // prototype — parameter names optional

int main() {
    cout << add(2, 3);
}

int add(int a, int b) { return a + b; }
```

## Default Arguments

```cpp
void greet(string name, string msg = "Hello") {
    cout << msg << ", " << name << "!" << endl;
}
greet("Alice");         // Hello, Alice!
greet("Bob", "Hi");    // Hi, Bob!
```

## Function Overloading

Same name, different parameter types or counts:

```cpp
int add(int a, int b)          { return a + b; }
double add(double a, double b) { return a + b; }
```

## Pass by Value vs Pass by Reference

```cpp
void squareVal(int x) { x = x * x; }   // x is a copy — original unchanged
void squareRef(int& x) { x = x * x; }  // x is a reference — original changed

int n = 5;
squareVal(n);   // n still 5
squareRef(n);   // n is now 25
```

## Key Takeaways
- Return type is always specified before the function name
- Use prototypes when calling a function before its definition
- `&` in a parameter makes it a reference — changes affect the original
- Overloading allows the same name with different signatures
$note$, 0);

  -- Lesson 3.1
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Defining and Calling Functions', 1) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the return type of a C++ function that returns nothing?',
   '0',
   '["void", "null", "empty", "None"]'::jsonb,
   'void means the function performs an action but returns no value to the caller.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the return type for a function that returns a whole number:',
   '___ square(int n) { return n * n; }',
   'int',
   '["int", "void", "double", "return"]'::jsonb,
   'The return type must match what the function returns. n * n is an int.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a function prototype in C++?',
   '0',
   '["A declaration telling the compiler a function''s return type and parameter types before its full definition", "The first version of a function", "A template for creating multiple functions", "A virtual function declaration"]'::jsonb,
   'Prototypes let you use a function before it is defined: int add(int, int);',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a function that multiplies two ints and prints the result:',
   '[{"id":"1","code":"int multiply(int a, int b) {"},{"id":"2","code":"    return a * b;"},{"id":"3","code":"}"},{"id":"4","code":"cout << multiply(4, 5) << endl;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int multiply(int a, int b) {","    return a * b;","}","cout << multiply(4, 5) << endl;"]'::jsonb,
   'Function definition first, then the call.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a function cube(int n) that returns n*n*n. Print cube(3). Expected: 27',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || '// Write cube() here' || chr(10) || 'int main() {' || chr(10) || '    cout << cube(3) << endl;' || chr(10) || '    return 0;' || chr(10) || '}',
   '27',
   'int cube(int n) { return n * n * n; }',
   5, 20);

  -- Lesson 3.2
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Pass by Value and Reference', 2) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output?' || chr(10) || 'void addTen(int x) { x += 10; }' || chr(10) || 'int n = 5; addTen(n); cout << n;',
   '0',
   '["5", "15", "10", "Error"]'::jsonb,
   'Pass by value copies the argument. The original n is unchanged. Output: 5.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the symbol to make this parameter a reference:',
   'void doubleIt(int___ x) { x *= 2; }',
   '&',
   '["&", "*", "->", "@"]'::jsonb,
   '& makes the parameter a reference. Changes to x inside the function affect the original.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'When should you prefer pass by reference over pass by value?',
   '0',
   '["When you want the function to modify the original variable or avoid copying a large object", "Always — references are always faster", "When the function returns void", "When the parameter is a primitive type like int"]'::jsonb,
   'References avoid copying (good for large types) and allow modification of the original.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a reference function that squares its argument in place:',
   '[{"id":"1","code":"void squareRef(int& x) {"},{"id":"2","code":"    x = x * x;"},{"id":"3","code":"}"},{"id":"4","code":"int n = 4; squareRef(n); cout << n;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["void squareRef(int& x) {","    x = x * x;","}","int n = 4; squareRef(n); cout << n;"]'::jsonb,
   'Define with & parameter, modify inside, close, then call and print.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Define swap(int& a, int& b) that swaps two values. Print a and b after swap(a,b) where a=1, b=2. Expected: 2 1',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || '// Define swap here' || chr(10) || 'int main() {' || chr(10) || '    int a = 1, b = 2;' || chr(10) || '    swap(a, b);' || chr(10) || '    cout << a << " " << b << endl;' || chr(10) || '    return 0;' || chr(10) || '}',
   '2 1',
   'void swap(int& a, int& b) { int tmp = a; a = b; b = tmp; }',
   5, 20);

  -- Lesson 3.3
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Default Arguments and Overloading', 3) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'void greet(string name, string msg = "Hello") { cout << msg << ", " << name; }' || chr(10) || 'greet("Alice");',
   '0',
   '["Hello, Alice", "Alice", "Error: msg missing", "Hello"]'::jsonb,
   'msg has a default value of "Hello". When not supplied, the default is used.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the default value so power(3) returns 9 (exp defaults to 2):',
   'int power(int base, int exp ___ 2) { ... }',
   '=',
   '["=", "==", ":", "=>"]'::jsonb,
   'Default arguments use = in the parameter list. They must come after non-default params.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What distinguishes two overloaded functions in C++?',
   '0',
   '["Their parameter lists (type, number, or order)", "Their return types", "Their variable names", "The number of lines in the body"]'::jsonb,
   'Return type alone does not distinguish overloads. The parameter signature must differ.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange two overloaded area() functions for a square and a rectangle:',
   '[{"id":"1","code":"int area(int side) { return side * side; }"},{"id":"2","code":"int area(int w, int h) { return w * h; }"},{"id":"3","code":"cout << area(4) << endl;"},{"id":"4","code":"cout << area(3, 5) << endl;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int area(int side) { return side * side; }","int area(int w, int h) { return w * h; }","cout << area(4) << endl;","cout << area(3, 5) << endl;"]'::jsonb,
   'Both definitions first, then each call.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Call repeat("Go!", 3) — a function that prints a string n times. Expected: Go!Go!Go!',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'void repeat(string s, int n) {' || chr(10) || '    for (int i = 0; i < n; i++) cout << s;' || chr(10) || '    cout << endl;' || chr(10) || '}' || chr(10) || 'int main() {' || chr(10) || '    // Call repeat' || chr(10) || '    return 0;' || chr(10) || '}',
   'Go!Go!Go!',
   'repeat("Go!", 3);',
   5, 20);

  -- Lesson 3.4
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Recursion', 4) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What must every recursive function have to avoid infinite recursion?',
   '0',
   '["A base case that stops the recursion", "A for loop inside", "A pointer parameter", "A static variable"]'::jsonb,
   'Without a base case the function calls itself forever until a stack overflow occurs.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the base case for a factorial function:',
   'if (n <= ___) return 1;',
   '1',
   '["1", "0", "n", "-1"]'::jsonb,
   'factorial(0) = 1 and factorial(1) = 1. Returning 1 when n <= 1 stops the recursion.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: cout << factorial(4); where factorial uses the standard recursive definition?',
   '0',
   '["24", "12", "16", "4"]'::jsonb,
   'factorial(4) = 4 * 3 * 2 * 1 = 24.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a recursive countdown function that prints n down to 1:',
   '[{"id":"1","code":"void countdown(int n) {"},{"id":"2","code":"    if (n <= 0) return;"},{"id":"3","code":"    cout << n << endl;"},{"id":"4","code":"    countdown(n - 1);"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["void countdown(int n) {","    if (n <= 0) return;","    cout << n << endl;","    countdown(n - 1);","}"]'::jsonb,
   'Signature, base case, print, recursive call, close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Call factorial(5) and print the result. Expected: 120',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int factorial(int n) {' || chr(10) || '    if (n <= 1) return 1;' || chr(10) || '    return n * factorial(n - 1);' || chr(10) || '}' || chr(10) || 'int main() {' || chr(10) || '    cout << factorial(5) << endl;' || chr(10) || '    return 0;' || chr(10) || '}',
   '120',
   'The function is already defined — just run it as-is.',
   5, 20);

  -- ==============================================================
  -- UNIT 4: Arrays, Vectors, and Strings
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 4: Arrays, Vectors & Strings', 'Store collections of data and manipulate text', 'purple', 4)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Arrays, Vectors, and Strings', $note$
# Arrays, Vectors, and Strings in C++

## Arrays (Fixed Size)

```cpp
int scores[5] = {90, 85, 78, 92, 88};
cout << scores[0];    // 90 — index starts at 0
cout << scores[4];    // 88 — last element

// Loop with range-based for
for (int s : scores) cout << s << " ";
```

## std::vector (Dynamic Size)

```cpp
#include <vector>

vector<int> nums = {1, 2, 3};
nums.push_back(4);           // add to end
nums.pop_back();             // remove last
cout << nums.size();         // 3
cout << nums[0];             // 1
nums.at(0);                  // bounds-checked access
```

## Strings (std::string)

```cpp
#include <string>

string s = "Hello";
cout << s.length();          // 5
cout << s[0];                // H
cout << s.substr(1, 3);      // ell (start, length)
s += " World";               // concatenation
cout << s.find("World");     // 6 — position
s = to_string(42);           // int → string
int n = stoi("42");          // string → int
```

## 2D Arrays

```cpp
int grid[3][3] = {{1,2,3},{4,5,6},{7,8,9}};
cout << grid[1][2];   // 6 (row 1, col 2)
```

## Key Takeaways
- C arrays are fixed size; prefer `vector` for dynamic lists
- `vector` methods: `push_back`, `pop_back`, `size`, `at`, `clear`
- `string` is a class with many useful methods: `length`, `substr`, `find`, `+`
- `to_string()` converts numbers to strings; `stoi()` / `stod()` convert back
$note$, 0);

  -- Lesson 4.1
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'C++ Arrays', 1) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'int arr[] = {10, 20, 30};' || chr(10) || 'cout << arr[1];',
   '0',
   '["20", "10", "30", "Error"]'::jsonb,
   'Array indexing starts at 0. Index 1 is the second element: 20.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the declaration of an int array with 3 elements:',
   'int nums___ = {5, 10, 15};',
   '[3]',
   '["[3]", "(3)", "{3}", "<3>"]'::jsonb,
   'C array size goes in square brackets: int nums[3] = {...}.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What happens when you access an array index outside its bounds in C++?',
   '0',
   '["Undefined behaviour — the program may crash or produce garbage values", "An out-of-bounds exception is thrown", "The value wraps around to index 0", "The compiler rejects it"]'::jsonb,
   'C arrays have no bounds checking. Accessing arr[100] on a 3-element array is undefined behaviour.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a loop to print each element of int arr[] = {1,2,3}:',
   '[{"id":"1","code":"int arr[] = {1, 2, 3};"},{"id":"2","code":"for (int x : arr) {"},{"id":"3","code":"    cout << x << endl;"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int arr[] = {1, 2, 3};","for (int x : arr) {","    cout << x << endl;","}"]'::jsonb,
   'Declare array, range-based for, print, close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print the sum of int arr[] = {3, 7, 10}. Expected: 20',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    int arr[] = {3, 7, 10};' || chr(10) || '    int sum = 0;' || chr(10) || '    // Sum and print' || chr(10) || '    return 0;' || chr(10) || '}',
   '20',
   'for (int x : arr) sum += x; cout << sum << endl;',
   5, 20);

  -- Lesson 4.2
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'std::vector', 2) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the main advantage of vector over a plain array?',
   '0',
   '["A vector can grow or shrink at runtime", "A vector uses less memory", "A vector allows mixed types", "A vector is faster for all operations"]'::jsonb,
   'std::vector is dynamically sized. You can push_back() to add elements without pre-declaring size.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the method to add an element to the end of a vector:',
   'nums.___(42);',
   'push_back',
   '["push_back", "append", "add", "insert"]'::jsonb,
   'vector::push_back() appends an element to the end of the vector.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does vector::at(i) do differently from vector::operator[](i)?',
   '0',
   '["at() performs bounds checking and throws std::out_of_range if i is invalid", "at() is faster", "at() returns a reference; [] returns a copy", "They are identical"]'::jsonb,
   'at() throws an exception on out-of-bounds access; [] is unchecked (undefined behaviour).',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to create a vector, add two elements, and print its size:',
   '[{"id":"1","code":"vector<string> names;"},{"id":"2","code":"names.push_back(\"Alice\");"},{"id":"3","code":"names.push_back(\"Bob\");"},{"id":"4","code":"cout << names.size() << endl;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["vector<string> names;","names.push_back(\"Alice\");","names.push_back(\"Bob\");","cout << names.size() << endl;"]'::jsonb,
   'Declare vector, add two elements, then print size.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Add 10, 20, 30 to a vector<int>, then print each element on its own line.',
   '#include <iostream>' || chr(10) || '#include <vector>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    vector<int> v;' || chr(10) || '    // Add and print' || chr(10) || '    return 0;' || chr(10) || '}',
   '10' || chr(10) || '20' || chr(10) || '30',
   'v.push_back(10); v.push_back(20); v.push_back(30); for (int x : v) cout << x << endl;',
   5, 20);

  -- Lesson 4.3
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'std::string', 3) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does s.substr(2, 3) return when s = "Hello"?',
   '0',
   '["llo", "He", "ell", "Hello"]'::jsonb,
   'substr(start, length): starts at index 2 (''l''), takes 3 characters → "llo".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the function that converts an int to a std::string:',
   'string s = ___(42);',
   'to_string',
   '["to_string", "str()", "string()", "itoa"]'::jsonb,
   'to_string() converts numeric types to std::string. The reverse is stoi() for integers.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'string s = "World";' || chr(10) || 'cout << s.length();',
   '0',
   '["5", "4", "6", "Error"]'::jsonb,
   '"World" has 5 characters: W-o-r-l-d.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to concatenate first and last name and print:',
   '[{"id":"1","code":"string first = \"John\";"},{"id":"2","code":"string last = \"Doe\";"},{"id":"3","code":"string full = first + \" \" + last;"},{"id":"4","code":"cout << full << endl;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["string first = \"John\";","string last = \"Doe\";","string full = first + \" \" + last;","cout << full << endl;"]'::jsonb,
   'Declare both, concatenate with +, then print.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print the first 3 characters of "Programming" using substr. Expected: Pro',
   '#include <iostream>' || chr(10) || '#include <string>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    string s = "Programming";' || chr(10) || '    // Use substr' || chr(10) || '    return 0;' || chr(10) || '}',
   'Pro',
   'cout << s.substr(0, 3) << endl;',
   5, 20);

  -- Lesson 4.4
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Sorting and Searching', 4) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which header provides std::sort in C++?',
   '0',
   '["<algorithm>", "<sort>", "<vector>", "<functional>"]'::jsonb,
   'std::sort lives in <algorithm>. It sorts a range defined by two iterators.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the sort call for a vector v:',
   'sort(v.___, v.end());',
   'begin()',
   '["begin()", "start()", "first()", "front()"]'::jsonb,
   'sort() takes two iterators: v.begin() to v.end() covers the entire vector.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does std::find(v.begin(), v.end(), 42) return if 42 is NOT in the vector?',
   '0',
   '["v.end()", "v.begin()", "-1", "nullptr"]'::jsonb,
   'find returns an iterator. If not found, it returns the end iterator (v.end()).',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to sort a vector and print the smallest element:',
   '[{"id":"1","code":"vector<int> v = {5, 2, 8, 1};"},{"id":"2","code":"sort(v.begin(), v.end());"},{"id":"3","code":"cout << v[0] << endl;"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["vector<int> v = {5, 2, 8, 1};","sort(v.begin(), v.end());","cout << v[0] << endl;"]'::jsonb,
   'Declare vector, sort it, then index 0 is the smallest.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Sort vector {4,1,3,2} and print the largest element. Expected: 4',
   '#include <iostream>' || chr(10) || '#include <vector>' || chr(10) || '#include <algorithm>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    vector<int> v = {4,1,3,2};' || chr(10) || '    // Sort and print largest' || chr(10) || '    return 0;' || chr(10) || '}',
   '4',
   'sort(v.begin(), v.end()); cout << v[v.size()-1] << endl;',
   5, 20);

  -- ==============================================================
  -- UNIT 5: OOP — Classes and Objects
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 5: OOP – Classes & Objects', 'Build C++ classes with constructors, methods, and access control', 'teal', 5)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'OOP in C++', $note$
# OOP in C++

## Class Basics

```cpp
class Car {
private:
    string brand;
    int year;

public:
    // Constructor
    Car(string b, int y) : brand(b), year(y) {}

    // Method
    void describe() {
        cout << brand << " (" << year << ")" << endl;
    }

    // Getter
    string getBrand() { return brand; }
};

Car myCar("Toyota", 2022);
myCar.describe();   // Toyota (2022)
```

## Access Modifiers

| Modifier    | Accessible from        |
|-------------|------------------------|
| `private`   | Inside the class only  |
| `public`    | Anywhere               |
| `protected` | Class and subclasses   |

Default in `class` is **private**. Default in `struct` is **public**.

## Constructor Initializer List

Efficient way to set fields:

```cpp
Car(string b, int y) : brand(b), year(y) {}
```

## Destructors

Run automatically when an object goes out of scope:

```cpp
~Car() { cout << "Car destroyed" << endl; }
```

## Inheritance

```cpp
class Vehicle {
public:
    void move() { cout << "Moving..." << endl; }
};

class Car : public Vehicle {
public:
    void honk() { cout << "Beep!" << endl; }
};

Car c;
c.move();   // inherited
c.honk();   // own method
```

## Key Takeaways
- Use `private` for fields; expose via `public` getters/setters (encapsulation)
- Constructors can use initializer lists for efficiency
- Destructors clean up resources when an object is destroyed
- `class` defaults to private; `struct` defaults to public
$note$, 0);

  -- Lesson 5.1
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Defining Classes', 1) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the default access level for members in a C++ class?',
   '0',
   '["private", "public", "protected", "internal"]'::jsonb,
   'Unlike struct (public default), class members are private by default.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword to create a new object of class Car:',
   'Car myCar = ___ Car("Toyota", 2022);',
   'new',
   '["new", "create", "make", "Car"]'::jsonb,
   'In C++, new allocates on the heap. Without new: Car myCar("Toyota", 2022); allocates on the stack.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the purpose of a C++ destructor?',
   '0',
   '["To release resources when an object goes out of scope or is deleted", "To create a copy of an object", "To initialize fields to zero", "To prevent object creation"]'::jsonb,
   'Destructors (named ~ClassName()) run automatically when the object''s lifetime ends.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a simple Dog class with a name field and bark() method:',
   '[{"id":"1","code":"class Dog {"},{"id":"2","code":"public:"},{"id":"3","code":"    string name;"},{"id":"4","code":"    void bark() { cout << \"Woof!\" << endl; }"},{"id":"5","code":"};"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["class Dog {","public:","    string name;","    void bark() { cout << \"Woof!\" << endl; }","};"]'::jsonb,
   'class keyword, public section, field, method, closing semicolon.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a Dog object with name "Rex" and call bark(). Expected: Woof!',
   '#include <iostream>' || chr(10) || '#include <string>' || chr(10) || 'using namespace std;' || chr(10) || 'class Dog {' || chr(10) || 'public:' || chr(10) || '    string name;' || chr(10) || '    void bark() { cout << "Woof!" << endl; }' || chr(10) || '};' || chr(10) || 'int main() {' || chr(10) || '    // Create Dog and call bark()' || chr(10) || '    return 0;' || chr(10) || '}',
   'Woof!',
   'Dog d; d.name = "Rex"; d.bark();',
   5, 20);

  -- Lesson 5.2
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Constructors and Encapsulation', 2) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a constructor initializer list in C++?',
   '0',
   '["A syntax after the : that initializes member fields before the constructor body runs", "A list of constructors the class has", "A way to call another class constructor", "A type of array initializer"]'::jsonb,
   'Car(string b) : brand(b) {} initializes brand before the body. More efficient than assignment inside the body.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the access modifier that hides a field from outside the class:',
   '___ :' || chr(10) || '    int balance;',
   'private',
   '["private", "public", "protected", "hidden"]'::jsonb,
   'private members can only be accessed from within the class.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a getter method?',
   '0',
   '["A public method returning a private field''s value", "A method that sets a field value", "A static class method", "A constructor that takes no arguments"]'::jsonb,
   'int getAge() { return age; } gives read access to the private age field.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a BankAccount class with private balance and a deposit method:',
   '[{"id":"1","code":"class BankAccount {"},{"id":"2","code":"private:"},{"id":"3","code":"    double balance = 0;"},{"id":"4","code":"public:"},{"id":"5","code":"    void deposit(double amt) { balance += amt; }"},{"id":"6","code":"    double getBalance() { return balance; }"},{"id":"7","code":"};"}]'::jsonb,
   '["1","2","3","4","5","6","7"]'::jsonb,
   '["class BankAccount {","private:","    double balance = 0;","public:","    void deposit(double amt) { balance += amt; }","    double getBalance() { return balance; }","};"]'::jsonb,
   'class, private section, field, public section, methods, close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Deposit 500 into account and print the balance. Expected: 500',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'class BankAccount {' || chr(10) || 'private:' || chr(10) || '    double balance = 0;' || chr(10) || 'public:' || chr(10) || '    void deposit(double a) { balance += a; }' || chr(10) || '    double getBalance() { return balance; }' || chr(10) || '};' || chr(10) || 'int main() {' || chr(10) || '    BankAccount acc;' || chr(10) || '    // Deposit 500 and print balance' || chr(10) || '    return 0;' || chr(10) || '}',
   '500',
   'acc.deposit(500); cout << acc.getBalance() << endl;',
   5, 20);

  -- Lesson 5.3
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Inheritance', 3) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the syntax for public inheritance in C++?',
   '0',
   '["class Dog : public Animal", "class Dog extends Animal", "class Dog implements Animal", "class Dog inherits Animal"]'::jsonb,
   'C++ uses a colon: class Derived : public Base { ... };',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword to call the parent class constructor from a derived class:',
   'Dog(string n) : ___(n) {}',
   'Animal',
   '["Animal", "super", "base", "parent"]'::jsonb,
   'In C++, call the base constructor by name in the initializer list: : BaseClass(args).',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the virtual keyword on a base class method enable?',
   '0',
   '["Polymorphism — the correct derived class method is called through a base pointer", "The method can be private", "The method cannot be overridden", "The method is static"]'::jsonb,
   'virtual enables runtime polymorphism. Without it, the base version is called even through a derived pointer.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a Dog class inheriting Animal and overriding speak():',
   '[{"id":"1","code":"class Animal { public: virtual void speak() { cout << \"...\"; } };"},{"id":"2","code":"class Dog : public Animal {"},{"id":"3","code":"public:"},{"id":"4","code":"    void speak() override { cout << \"Woof!\"; }"},{"id":"5","code":"};"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["class Animal { public: virtual void speak() { cout << \"...\"; } };","class Dog : public Animal {","public:","    void speak() override { cout << \"Woof!\"; }","};"]'::jsonb,
   'Base class with virtual, then derived with override.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a Cat and call speak(). Expected: Meow!',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'class Animal { public: virtual void speak() { cout << "..."; } };' || chr(10) || 'class Cat : public Animal {' || chr(10) || 'public:' || chr(10) || '    void speak() override { cout << "Meow!" << endl; }' || chr(10) || '};' || chr(10) || 'int main() {' || chr(10) || '    // Create Cat and call speak()' || chr(10) || '    return 0;' || chr(10) || '}',
   'Meow!',
   'Cat c; c.speak();',
   5, 20);

  -- Lesson 5.4
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Templates', 4) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a C++ template?',
   '0',
   '["A blueprint that generates type-safe code for multiple types without duplication", "A design pattern", "A way to create abstract classes", "A macro that runs at runtime"]'::jsonb,
   'Templates let you write functions and classes that work with any type: template<typename T>.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the template declaration keyword:',
   '___ <typename T>' || chr(10) || 'T maxVal(T a, T b) { return a > b ? a : b; }',
   'template',
   '["template", "generic", "type", "class"]'::jsonb,
   'template<typename T> introduces a type parameter T that the compiler substitutes at compile time.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'When is a template function instantiated in C++?',
   '0',
   '["At compile time when the compiler sees a call with specific types", "At runtime when the function is first called", "When the program starts", "When the header is included"]'::jsonb,
   'The compiler generates specific code for each type combination it sees: maxVal<int> and maxVal<double> are separate.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a template function that returns the smaller of two values:',
   '[{"id":"1","code":"template <typename T>"},{"id":"2","code":"T minVal(T a, T b) {"},{"id":"3","code":"    return a < b ? a : b;"},{"id":"4","code":"}"},{"id":"5","code":"cout << minVal(3, 7) << endl;"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["template <typename T>","T minVal(T a, T b) {","    return a < b ? a : b;","}","cout << minVal(3, 7) << endl;"]'::jsonb,
   'Template declaration, function signature, body, close, then call.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Call the provided template maxVal with 10 and 25. Expected: 25',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'template <typename T>' || chr(10) || 'T maxVal(T a, T b) { return a > b ? a : b; }' || chr(10) || 'int main() {' || chr(10) || '    // Call maxVal and print' || chr(10) || '    return 0;' || chr(10) || '}',
   '25',
   'cout << maxVal(10, 25) << endl;',
   5, 20);

  -- ==============================================================
  -- UNIT 6: Pointers and Memory
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 6: Pointers & Memory', 'Understand pointers, dynamic memory, and smart pointers', 'red', 6)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Pointers and Memory in C++', $note$
# Pointers and Memory in C++

## What is a Pointer?

A pointer stores the **memory address** of a variable.

```cpp
int x = 42;
int* p = &x;      // p holds the address of x

cout << x;        // 42 — the value
cout << &x;       // 0x7ffd... — the address
cout << p;        // same address as &x
cout << *p;       // 42 — dereference: value AT the address
```

- `&` — address-of operator
- `*` — dereference operator (get value at address)
- `int*` — pointer-to-int type

## Modifying Through a Pointer

```cpp
*p = 100;   // changes x to 100 through the pointer
cout << x;  // 100
```

## Dynamic Memory (Heap)

```cpp
int* arr = new int[5];   // allocate 5 ints on the heap
arr[0] = 10;
delete[] arr;            // MUST free array memory

int* n = new int(42);    // single value
delete n;                // MUST free single value
```

Forgetting `delete` causes a **memory leak**.

## nullptr

The safe null pointer in C++11:

```cpp
int* p = nullptr;
if (p != nullptr) { ... }
```

## Smart Pointers (C++11)

```cpp
#include <memory>

unique_ptr<int> p = make_unique<int>(42);  // auto-deleted when out of scope
shared_ptr<int> s = make_shared<int>(10);  // reference-counted
```

Smart pointers automatically free memory — prefer them over raw new/delete.

## Key Takeaways
- `&x` gives the address; `*p` dereferences to get the value
- Always `delete` what you `new`; use `delete[]` for arrays
- Use `nullptr` (not NULL or 0) for null pointers in modern C++
- Prefer `unique_ptr` / `shared_ptr` over raw pointers in new code
$note$, 0);

  -- Lesson 6.1
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Pointer Basics', 1) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the & operator do when applied to a variable?',
   '0',
   '["Returns the memory address of the variable", "Dereferences a pointer", "Performs bitwise AND", "Creates a reference copy"]'::jsonb,
   '&x is the address-of operator — it returns where x lives in memory.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the dereference to read the value at address p:',
   'int x = 10; int* p = &x; cout << ___p;',
   '*',
   '["*", "&", "->", "@"]'::jsonb,
   '* before a pointer dereferences it — gives you the value stored at the pointed-to address.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'int x = 5; int* p = &x; *p = 20; cout << x;',
   '0',
   '["20", "5", "The address of x", "Error"]'::jsonb,
   '*p = 20 writes 20 through the pointer to x. cout << x then shows 20.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to declare an int, point to it, and print the value via the pointer:',
   '[{"id":"1","code":"int num = 42;"},{"id":"2","code":"int* ptr = &num;"},{"id":"3","code":"cout << *ptr << endl;"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["int num = 42;","int* ptr = &num;","cout << *ptr << endl;"]'::jsonb,
   'Declare the int, then point to it with &, then dereference with *.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Point p at n = 7, then change n to 99 via *p, and print n. Expected: 99',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    int n = 7;' || chr(10) || '    // Create pointer, modify via it, print n' || chr(10) || '    return 0;' || chr(10) || '}',
   '99',
   'int* p = &n; *p = 99; cout << n << endl;',
   5, 20);

  -- Lesson 6.2
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Dynamic Memory', 2) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the new operator do in C++?',
   '0',
   '["Allocates memory on the heap and returns a pointer to it", "Creates an object on the stack", "Imports a library", "Declares a new variable type"]'::jsonb,
   'new allocates on the heap at runtime. The heap persists until you explicitly call delete.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the statement to free a dynamically allocated array:',
   'int* arr = new int[10];' || chr(10) || '___ arr;',
   'delete[]',
   '["delete[]", "delete", "free(arr)", "release(arr)"]'::jsonb,
   'Use delete[] for arrays and delete (no brackets) for single objects.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a memory leak in C++?',
   '0',
   '["Memory allocated with new that is never freed with delete, wasting RAM", "A pointer pointing to freed memory", "Accessing an array out of bounds", "A variable that overflows its type"]'::jsonb,
   'Every new must have a matching delete/delete[]. Omitting it causes the memory to stay allocated until the process ends.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to allocate a single int on the heap, set it to 42, print it, then free it:',
   '[{"id":"1","code":"int* p = new int(42);"},{"id":"2","code":"cout << *p << endl;"},{"id":"3","code":"delete p;"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["int* p = new int(42);","cout << *p << endl;","delete p;"]'::jsonb,
   'Allocate, use, then always delete.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Allocate an int* pointing to 100 on the heap, print it, then delete it. Expected: 100',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    // new, print, delete' || chr(10) || '    return 0;' || chr(10) || '}',
   '100',
   'int* p = new int(100); cout << *p << endl; delete p;',
   5, 20);

  -- Lesson 6.3
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Smart Pointers', 3) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the main benefit of using unique_ptr over raw pointers?',
   '0',
   '["It automatically deletes the managed object when it goes out of scope", "It is faster than a raw pointer", "It can point to multiple objects simultaneously", "It works without including any headers"]'::jsonb,
   'unique_ptr uses RAII — the destructor automatically calls delete, preventing leaks.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the function used to safely create a unique_ptr:',
   'auto p = ___<int>(42);',
   'make_unique',
   '["make_unique", "new_unique", "create_unique", "unique_ptr"]'::jsonb,
   'make_unique<T>(args) is the safe, idiomatic way to create a unique_ptr in C++14+.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the difference between unique_ptr and shared_ptr?',
   '0',
   '["unique_ptr has one owner; shared_ptr uses reference counting and can have multiple owners", "shared_ptr is faster", "unique_ptr uses reference counting", "They are identical in modern C++"]'::jsonb,
   'unique_ptr cannot be copied (one owner). shared_ptr counts references and deletes when count hits 0.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange to create a unique_ptr to an int and print its value:',
   '[{"id":"1","code":"#include <memory>"},{"id":"2","code":"auto p = make_unique<int>(99);"},{"id":"3","code":"cout << *p << endl;"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["#include <memory>","auto p = make_unique<int>(99);","cout << *p << endl;"]'::jsonb,
   'Include memory header, create unique_ptr, dereference to print.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a unique_ptr<int> pointing to 55 and print the value. Expected: 55',
   '#include <iostream>' || chr(10) || '#include <memory>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    // Create unique_ptr and print' || chr(10) || '    return 0;' || chr(10) || '}',
   '55',
   'auto p = make_unique<int>(55); cout << *p << endl;',
   5, 20);

  -- Lesson 6.4
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'nullptr and Pointer Safety', 4) RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why should you use nullptr instead of NULL in modern C++?',
   '0',
   '["nullptr is type-safe and cannot be implicitly converted to an integer", "nullptr is faster at runtime", "NULL was removed from C++11", "nullptr is shorter to type"]'::jsonb,
   'NULL is just 0 (an int). nullptr is a distinct pointer type — avoids ambiguous overload resolution.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the null pointer value in modern C++:',
   'int* p = ___;',
   'nullptr',
   '["nullptr", "NULL", "0", "void"]'::jsonb,
   'nullptr is the C++11 null pointer literal. Always prefer it over NULL or 0.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a dangling pointer?',
   '0',
   '["A pointer that still holds the address of memory that has been freed", "A pointer that was never initialized", "A pointer to a stack variable", "A smart pointer"]'::jsonb,
   'After delete p, the pointer still holds the old address. Accessing it is undefined behaviour. Set it to nullptr after deleting.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange safe pointer usage: allocate, use, delete, then set to nullptr:',
   '[{"id":"1","code":"int* p = new int(7);"},{"id":"2","code":"cout << *p << endl;"},{"id":"3","code":"delete p;"},{"id":"4","code":"p = nullptr;"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int* p = new int(7);","cout << *p << endl;","delete p;","p = nullptr;"]'::jsonb,
   'Allocate, use, delete, then null the pointer to prevent dangling.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Check if pointer p is nullptr and print "null" if so. p = nullptr. Expected: null',
   '#include <iostream>' || chr(10) || 'using namespace std;' || chr(10) || 'int main() {' || chr(10) || '    int* p = nullptr;' || chr(10) || '    // Check and print' || chr(10) || '    return 0;' || chr(10) || '}',
   'null',
   'if (p == nullptr) cout << "null" << endl;',
   5, 20);

END $$;
