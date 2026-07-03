-- ============================================================
-- REAL C# CURRICULUM
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

  -- Prefer slug 'csharp' (used by the app); fall back to 'c#' if present.
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug IN ('csharp', 'c#')
  ORDER BY CASE WHEN slug = 'csharp' THEN 0 ELSE 1 END
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('C#', 'csharp', '💠', 'A modern, object-oriented, and type-safe programming language by Microsoft')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with C#
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Understand the structure of a C# program and basic types', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to C#', $note$
# Introduction to C#

C# (pronounced "C-Sharp") is a modern, object-oriented, and strongly-typed programming language created by Microsoft. It runs on the .NET framework and is widely used for building Windows desktop apps, web apps (ASP.NET), and games (Unity).

## Your First Program

```csharp
using System;

class Program {
    static void Main() {
        Console.WriteLine("Hello, World!");
    }
}

```
Breaking it down:
 * using System; — Imports basic classes like Console from the .NET library.
 * class Program — Every C# program is organized into classes.
 * static void Main() — The entry point. The application starts executing here.
 * Console.WriteLine(...) — Prints text to the screen and moves to the next line.
 * Every statement ends with a semicolon ;.
## Variables and Primitive Types
C# is statically typed; you must declare the variable type.
```csharp
int age = 25;
double price = 19.99;
bool isActive = true;
char grade = 'A';
string name = "Anthony";

```
## Input and Output
```csharp
// Output
Console.WriteLine("Welcome!");
Console.Write("Enter your name: "); // Does not move to the next line

// Input
string inputName = Console.ReadLine();

```
## String Interpolation
A powerful way to inject variables directly into strings using the $ symbol:
```csharp
string greeting = $"Hello, {name}! You are {age} years old.";
Console.WriteLine(greeting);

```
## Type Conversion (Casting)
Reading input always gives you a string. To do math, you must parse it:
```csharp
string input = "50";
int number = int.Parse(input);
number += 10; // 60

```
## Key Takeaways
 * Every C# application requires a Main() method.
 * Variables are statically typed (int, string, double, bool).
 * Use Console.WriteLine() and Console.ReadLine() for console I/O.
 * String interpolation ($"...") is the cleanest way to format strings.
   $note$, 0);
   -- Lesson 1.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Hello, C#!', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the standard entry point method for a C# console application?',
   '0',
   '["static void Main()","public void start()","function main()","Init()"]'::jsonb,
   'The .NET runtime automatically looks for a static method named Main() to start the program.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the statement to print to the screen:',
   '___.WriteLine("Hello!");',
   'Console',
   '["Console","System","Print","Output"]'::jsonb,
   'Console is a class in the System namespace used for standard input and output.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which directive imports the System namespace so you can use Console directly?',
   '0',
   '["using System;","#include <system>","import system;","require(System);"]'::jsonb,
   'In C#, the using keyword is used at the top of the file to include namespaces.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the lines to create a minimal Hello World program:',
   '[{"id":"1","code":"using System;"},{"id":"2","code":"class Program {"},{"id":"3","code":"  static void Main() {"},{"id":"4","code":"    Console.WriteLine(\"Hello\");"},{"id":"5","code":"  } }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["using System;","class Program {","  static void Main() {","    Console.WriteLine(\"Hello\");","  } }"]'::jsonb,
   'using directive, class definition, Main method, print statement, closing braces.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write a C# program that prints: Learning C#',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Write your code here' || chr(10) || '  }' || chr(10) || '}',
   'Learning C#',
   'Console.WriteLine("Learning C#");',
   5, 20);
   -- Lesson 1.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Variables and Types', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which data type is used to store text in C#?',
   '0',
   '["string","char","text","StringText"]'::jsonb,
   'The string keyword is used for sequences of characters (e.g., "Hello"). char is for a single character (e.g., ''A'').',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Declare a boolean variable set to false:',
   '___ isReady = false;',
   'bool',
   '["bool","boolean","bit","flag"]'::jsonb,
   'C# uses bool as the keyword for true/false values.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you try to assign int score = "100";?',
   '0',
   '["Compile-time error: Cannot implicitly convert type ''string'' to ''int''","It works fine","It crashes at runtime","It assigns 0"]'::jsonb,
   'C# is strongly typed. You cannot assign a string to an integer variable directly.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Declare variables for an item''s ID, price, and active status:',
   '[{"id":"1","code":"int id = 5;"},{"id":"2","code":"double price = 9.99;"},{"id":"3","code":"bool isActive = true;"},{"id":"4","code":"Console.WriteLine(id);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int id = 5;","double price = 9.99;","bool isActive = true;","Console.WriteLine(id);"]'::jsonb,
   'int, double, bool, then output.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Declare an int named count equal to 50, and print it.',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Declare count and print' || chr(10) || '  }' || chr(10) || '}',
   '50',
   'int count = 50; Console.WriteLine(count);',
   5, 20);
   -- Lesson 1.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Console Input and Output', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the main difference between Console.Write and Console.WriteLine?',
   '0',
   '["WriteLine adds a newline character at the end; Write does not","Write is for numbers, WriteLine is for strings","WriteLine is faster","There is no difference"]'::jsonb,
   'Write() leaves the cursor on the same line, which is useful for prompting input.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the method to read a line of text from the user:',
   'string input = Console.___();',
   'ReadLine',
   '["ReadLine","Read","Input","GetLine"]'::jsonb,
   'Console.ReadLine() reads user input until they press Enter.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which syntax correctly uses String Interpolation in C#?',
   '0',
   '["$\"Hello {name}\"","\"Hello {name}\"","\"Hello\" + name","f\"Hello {name}\""]'::jsonb,
   'Placing a $ before the string allows you to write variables directly inside curly braces {}.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange lines to combine a string using interpolation:',
   '[{"id":"1","code":"string role = \"Admin\";"},{"id":"2","code":"int level = 5;"},{"id":"3","code":"string msg = $\"{role} level {level}\";"},{"id":"4","code":"Console.WriteLine(msg);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["string role = \"Admin\";","int level = 5;","string msg = $\"{role} level {level}\";","Console.WriteLine(msg);"]'::jsonb,
   'Declare variables, use interpolation starting with $, print the result.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use string interpolation to print "Score: 99" using the variable s = 99.',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    int s = 99;' || chr(10) || '    // Interpolate and print' || chr(10) || '  }' || chr(10) || '}',
   'Score: 99',
   'Console.WriteLine($"Score: {s}");',
   5, 20);
   -- Lesson 1.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Type Conversion', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Why must you convert Console.ReadLine() if you want the user''s age?',
   '0',
   '["Because ReadLine() always returns a string, not an int","Because age might be negative","Because C# strings are actually numbers","Because Console only accepts bytes"]'::jsonb,
   'Even if the user types "25", ReadLine returns it as text. You must convert it to do math.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the method to convert a string to an integer:',
   'int n = int.___("42");',
   'Parse',
   '["Parse","Convert","Cast","ToInt"]'::jsonb,
   'int.Parse() takes a string and turns it into an integer. It throws an error if the string is invalid.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you run int.Parse("Hello")?',
   '0',
   '["A runtime exception is thrown (FormatException)","It returns 0","It returns -1","It ignores the line"]'::jsonb,
   'Since "Hello" is not a valid number, parsing fails and crashes the app unless handled.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to read a number from a string, add 5, and print it:',
   '[{"id":"1","code":"string input = \"10\";"},{"id":"2","code":"int num = int.Parse(input);"},{"id":"3","code":"num += 5;"},{"id":"4","code":"Console.WriteLine(num);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["string input = \"10\";","int num = int.Parse(input);","num += 5;","Console.WriteLine(num);"]'::jsonb,
   'Have a string, parse it to an int, modify it, print it.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Parse the string txt = "7" into an integer, multiply by 3, and print the result. Expected: 21',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    string txt = "7";' || chr(10) || '    // Parse, multiply, print' || chr(10) || '  }' || chr(10) || '}',
   '21',
   'int val = int.Parse(txt); Console.WriteLine(val * 3);',
   5, 20);
   -- ==============================================================
   -- UNIT 2: Control Flow
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 2: Control Flow', 'Make decisions and repeat code with loops and conditionals', 'green', 2)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Control Flow in C#', $note$
# Control Flow in C#
## if / else if / else
Decision-making in C# relies on boolean expressions.
```csharp
int score = 85;

if (score >= 90) {
    Console.WriteLine("Grade: A");
} else if (score >= 80) {
    Console.WriteLine("Grade: B");
} else {
    Console.WriteLine("Grade: F");
}

```
## Logical Operators
| Operator | Meaning | Example |
|---|---|---|
| == | Equal | x == 5 |
| != | Not equal | x != 0 |
| && | Logical AND | x > 0 && x < 10 |
| ` |  | ` |
| ! | Logical NOT | !isActive |
## switch Statement
The switch statement is a cleaner alternative to long if-else chains. In C#, every case must end with break.
```csharp
int day = 3;
switch (day) {
    case 1: 
        Console.WriteLine("Monday"); 
        break;
    case 2: 
        Console.WriteLine("Tuesday"); 
        break;
    default: 
        Console.WriteLine("Other day"); 
        break;
}

```
## for Loop
Executes code a specific number of times.
```csharp
for (int i = 0; i < 5; i++) {
    Console.WriteLine(i); // Prints 0 to 4
}

```
## while Loop
Executes code as long as a condition is true.
```csharp
int attempts = 0;
while (attempts < 3) {
    Console.WriteLine("Trying...");
    attempts++;
}

```
## foreach Loop
The easiest way to loop through a collection (like arrays or lists).
```csharp
string[] students = { "Alice", "Bob" };
foreach (string s in students) {
    Console.WriteLine(s);
}

```
## Key Takeaways
 * Use && for AND, || for OR.
 * switch statements must have break (fall-through is not allowed in C#).
 * foreach is the preferred loop for reading collections.
   $note$, 0);
   -- Lesson 2.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'If/Else and Logic', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What will be the output?' || chr(10) || 'int x = 10;' || chr(10) || 'if (x == 5) Console.WriteLine("A");' || chr(10) || 'else Console.WriteLine("B");',
   '0',
   '["B","A","Nothing","Error"]'::jsonb,
   'Since 10 is not equal to 5, the else block executes.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the condition to check if a user is online AND admin:',
   'if (isOnline ___ isAdmin) { ... }',
   '&&',
   '["&&","||","AND","&"]'::jsonb,
   'The logical AND operator is &&. Both conditions must be true.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the ! operator do?',
   '0',
   '["It reverses a boolean value (NOT)","It means strictly equal","It deletes a variable","It returns true"]'::jsonb,
   '!true becomes false. !false becomes true.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange to check if temperature is below freezing:',
   '[{"id":"1","code":"int temp = -2;"},{"id":"2","code":"if (temp <= 0) {"},{"id":"3","code":"  Console.WriteLine(\"Freezing\");"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int temp = -2;","if (temp <= 0) {","  Console.WriteLine(\"Freezing\");","}"]'::jsonb,
   'Declare, open if, print, close if.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print "Even" if num = 8 is divisible by 2, else print "Odd". Expected: Even',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    int num = 8;' || chr(10) || '    // Write if/else' || chr(10) || '  }' || chr(10) || '}',
   'Even',
   'if (num % 2 == 0) Console.WriteLine("Even"); else Console.WriteLine("Odd");',
   5, 20);
   -- Lesson 2.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Loops (for & while)', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How many times does this loop run?' || chr(10) || 'for (int i = 0; i < 3; i++) { ... }',
   '0',
   '["3 times (i = 0, 1, 2)","4 times","2 times","Infinite"]'::jsonb,
   'It runs while i is less than 3. So it runs for 0, 1, and 2.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to jump to the next iteration of a loop without executing the rest of the block:',
   'if (i == 5) ___ ;',
   'continue',
   '["continue","break","next","skip"]'::jsonb,
   'continue skips the rest of the current loop iteration and moves to the next one. break exits entirely.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the difference between a while and a do-while loop?',
   '0',
   '["do-while always executes its body at least once, even if the condition is false","while loops are faster","do-while loops cannot use break","There is no difference"]'::jsonb,
   'In a do-while loop, the condition is evaluated at the end of the loop, guaranteeing one run.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a while loop that prints 1, 2, 3:',
   '[{"id":"1","code":"int i = 1;"},{"id":"2","code":"while (i <= 3) {"},{"id":"3","code":"  Console.WriteLine(i);"},{"id":"4","code":"  i++;"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["int i = 1;","while (i <= 3) {","  Console.WriteLine(i);","  i++;","}"]'::jsonb,
   'Initialize, while condition, print, increment, close brace.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a for loop to print numbers 1, 2, 3 on separate lines.',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Loop and print' || chr(10) || '  }' || chr(10) || '}',
   '1' || chr(10) || '2' || chr(10) || '3',
   'for(int i=1; i<=3; i++) Console.WriteLine(i);',
   5, 20);
   -- Lesson 2.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Switch Statements', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What rule does C# strictly enforce regarding switch cases?',
   '0',
   '["Every non-empty case must explicitly exit (usually with break;)","Cases do not need a break","You cannot use strings in a switch","The default case is mandatory"]'::jsonb,
   'Unlike C++ or JavaScript, C# prevents "fall-through" bugs by requiring a break statement at the end of every case containing code.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the fallback case in a switch block:',
   '___: Console.WriteLine("Unknown"); break;',
   'default',
   '["default","else","case else","otherwise"]'::jsonb,
   'The default: block executes if no other cases match the switched value.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you use a switch statement on a string variable in C#?',
   '0',
   '["Yes, C# supports string matching in switch statements natively","No, only integers and chars","Only in C# 9.0 and above","Yes, but you must cast it to int"]'::jsonb,
   'C# has always allowed switching on strings, making it excellent for command processing.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a switch to handle traffic light colors:',
   '[{"id":"1","code":"string color = \"Red\";"},{"id":"2","code":"switch (color) {"},{"id":"3","code":"  case \"Red\": Console.WriteLine(\"Stop\"); break;"},{"id":"4","code":"  default: Console.WriteLine(\"Go\"); break;"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["string color = \"Red\";","switch (color) {","  case \"Red\": Console.WriteLine(\"Stop\"); break;","  default: Console.WriteLine(\"Go\"); break;","}"]'::jsonb,
   'Declare, open switch, case, default, close switch.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a switch on code = 404 to print "Not Found". Expected: Not Found',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    int code = 404;' || chr(10) || '    // switch here' || chr(10) || '  }' || chr(10) || '}',
   'Not Found',
   'switch(code){ case 404: Console.WriteLine("Not Found"); break; }',
   5, 20);
   -- Lesson 2.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'foreach Loop', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the primary advantage of the foreach loop in C#?',
   '0',
   '["It provides a clean, readable way to iterate through collections without managing index numbers","It is twice as fast as a for loop","It allows you to modify the size of the array","It can run backwards"]'::jsonb,
   'foreach is designed for safety and readability when reading arrays or lists.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the syntax to loop through an array of names:',
   '___ (string name in names) { Console.WriteLine(name); }',
   'foreach',
   '["foreach","for","in","loop"]'::jsonb,
   'The foreach keyword simplifies collection iteration.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you modify the iteration variable inside a foreach loop (e.g., foreach(int x in nums) { x = 5; })?',
   '0',
   '["No, the iteration variable is read-only","Yes, it modifies the original array","Yes, but only for strings","Yes, it modifies a copy"]'::jsonb,
   'The compiler will throw an error. The variable in a foreach loop cannot be assigned a new value.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Iterate over an array of scores and print each one:',
   '[{"id":"1","code":"int[] scores = { 90, 85, 100 };"},{"id":"2","code":"foreach (int s in scores) {"},{"id":"3","code":"  Console.WriteLine(s);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int[] scores = { 90, 85, 100 };","foreach (int s in scores) {","  Console.WriteLine(s);","}"]'::jsonb,
   'Declare array, foreach loop, print inside, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use foreach to print each character of the string word = "C#"; on a new line.',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    string word = "C#";' || chr(10) || '    // Loop and print' || chr(10) || '  }' || chr(10) || '}',
   'C' || chr(10) || '#',
   'foreach(char c in word) Console.WriteLine(c);',
   5, 20);
   -- ==============================================================
   -- UNIT 3: Methods
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 3: Methods', 'Organize code into reusable blocks called methods', 'orange', 3)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Methods in C#', $note$
# Methods in C#
Methods (functions) allow you to organize code into reusable blocks. In C#, methods are always defined inside a class.
## Defining a Method
```csharp
class Calculator {
    // static means we can call it without creating an object
    // int is the return type
    public static int Add(int a, int b) {
        return a + b;
    }
}

```
Calling it:
```csharp
int sum = Calculator.Add(5, 10);
Console.WriteLine(sum); // 15

```
## void Return Type
If a method performs an action but doesn't return data, use void.
```csharp
static void PrintWelcome(string name) {
    Console.WriteLine($"Welcome, {name}!");
}

```
## Method Overloading
You can have multiple methods with the *same name* as long as they take *different parameters*.
```csharp
static int Multiply(int a, int b) {
    return a * b;
}

static double Multiply(double a, double b) {
    return a * b;
}

```
The compiler chooses the correct method based on the arguments provided.
## Optional/Named Parameters
You can provide default values for parameters.
```csharp
static void Greet(string name, string title = "Mr.") {
    Console.WriteLine($"Hello {title} {name}");
}

// Greet("Smith");         -> Hello Mr. Smith
// Greet("Smith", "Dr.");  -> Hello Dr. Smith

```
## Key Takeaways
 * Methods contain a return type, name, and parameters.
 * void means no return value.
 * return exits the method and passes a value back.
 * Overloading allows same-named methods with different signatures.
   $note$, 0);
   -- Lesson 3.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Defining and Calling Methods', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the return type of a method that does not return any data?',
   '0',
   '["void","null","empty","static"]'::jsonb,
   'void explicitly tells the compiler that the method finishes its task without returning a value.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the signature for a method that returns a text string:',
   'static ___ GetUsername() { return "Admin"; }',
   'string',
   '["string","void","text","return"]'::jsonb,
   'The return type goes immediately before the method name.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Why do we often use static for methods in simple console apps?',
   '0',
   '["It allows the method to be called directly from Main without creating an object instance first","It makes the method run faster","It protects the data from hackers","It means the method cannot return data"]'::jsonb,
   'Static methods belong to the class itself, not to a specific object. Main() is static, so it can only easily call other static methods.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a complete class with a method that doubles a number:',
   '[{"id":"1","code":"class Program {"},{"id":"2","code":"  static int DoubleIt(int n) { return n * 2; }"},{"id":"3","code":"  static void Main() {"},{"id":"4","code":"    Console.WriteLine(DoubleIt(5)); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Program {","  static int DoubleIt(int n) { return n * 2; }","  static void Main() {","    Console.WriteLine(DoubleIt(5)); } }"]'::jsonb,
   'Class open, define method, Main method calling it, close braces.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write a method static int Add(int a, int b) that returns their sum. Call it with 3 and 7, and print the result. Expected: 10',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  // Write Add method here' || chr(10) || '  static void Main() {' || chr(10) || '    // Call and print' || chr(10) || '  }' || chr(10) || '}',
   '10',
   'static int Add(int a, int b) { return a + b; } ... Console.WriteLine(Add(3,7));',
   5, 20);
   -- Lesson 3.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Method Overloading', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is method overloading in C#?',
   '0',
   '["Creating multiple methods with the same name but different parameters (types or count)","Overriding a method in a subclass","Calling a method too many times","Methods with different names but the same parameters"]'::jsonb,
   'Overloading is a feature of Polymorphism. Example: Print(int) vs Print(string).',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the parameter to legally overload an existing void Log(string msg) method:',
   'void Log(string msg, ___ level) { }',
   'int',
   '["int","string","void","return"]'::jsonb,
   'To overload, the signature (parameter count/types) must change. Adding an int changes the signature.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you overload a method by ONLY changing its return type (e.g., int Calc() vs double Calc())?',
   '0',
   '["No, the parameter list must be different","Yes, return type is enough","Yes, but only if they are static","No, overloading is only for constructors"]'::jsonb,
   'The compiler cannot distinguish which method to call if only the return type differs.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange overloaded methods to calculate area for a square and a rectangle:',
   '[{"id":"1","code":"static int Area(int side) {"},{"id":"2","code":"  return side * side; }"},{"id":"3","code":"static int Area(int length, int width) {"},{"id":"4","code":"  return length * width; }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["static int Area(int side) {","  return side * side; }","static int Area(int length, int width) {","  return length * width; }"]'::jsonb,
   'First method signature and body, then the overloaded signature and body.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Call an overloaded Print method twice: first passing (5), then ("Five"). The methods are already written.',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Print(int n) { Console.WriteLine("Num: {n}"); }' || chr(10) || '  static void Print(string s) { Console.WriteLine("Str: {s}"); }' || chr(10) || '  static void Main() {' || chr(10) || '    // Call Print here' || chr(10) || '  }' || chr(10) || '}',
   'Num: 5' || chr(10) || 'Str: Five',
   'Print(5); Print("Five");',
   5, 20);
   -- Lesson 3.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Optional Parameters', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you declare an optional parameter in a C# method?',
   '0',
   '["By assigning a default value to the parameter in the method signature (e.g., int step = 1)","By using the optional keyword","By putting a ? after the type","By placing it first in the list"]'::jsonb,
   'Assigning a value like = 1 makes it optional when calling the method.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the syntax to make the tax parameter optional with a 0.05 default:',
   'double CalcTotal(double price, double tax ___ 0.05) { ... }',
   '=',
   '["=",":","-","=>"]'::jsonb,
   'Use the equals sign to assign the default value.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Where must optional parameters be placed in a method signature?',
   '0',
   '["At the very end of the parameter list","At the beginning","Anywhere","Only in constructors"]'::jsonb,
   'Required parameters must come first so the compiler can easily match arguments.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a method with an optional parameter and call it:',
   '[{"id":"1","code":"static void Greet(string name, string title = \"Mr.\") {"},{"id":"2","code":"  Console.WriteLine(title + \" \" + name); }"},{"id":"3","code":"static void Main() {"},{"id":"4","code":"  Greet(\"Bond\"); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["static void Greet(string name, string title = \"Mr.\") {","  Console.WriteLine(title + \" \" + name); }","static void Main() {","  Greet(\"Bond\"); }"]'::jsonb,
   'Signature with default, print body, Main method, call relying on default.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write static void Log(string msg, string type = "INFO"). Print "{type}: {msg}". Call Log("Started"). Expected: INFO: Started',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  // Write method here' || chr(10) || '  static void Main() {' || chr(10) || '    Log("Started");' || chr(10) || '  }' || chr(10) || '}',
   'INFO: Started',
   'static void Log(string msg, string type = "INFO") { Console.WriteLine($"{type}: {msg}"); }',
   5, 20);
   -- Lesson 3.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Pass by Value and ref/out', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'By default, how does C# pass value types (like int) to a method?',
   '0',
   '["By Value (a copy is passed, the original is unchanged)","By Reference (modifying it changes the original)","As a Pointer","As a constant"]'::jsonb,
   'Changing a standard int parameter inside a method does not affect the variable in Main().',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to pass a variable by reference so the method can change it:',
   'void AddTen(___ int x) { x += 10; }',
   'ref',
   '["ref","out","in","val"]'::jsonb,
   'The ref keyword must be used in both the method signature and when calling it.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the difference between ref and out parameters?',
   '0',
   '["out forces the method to assign a value before returning; ref requires the variable to be initialized before passing","They are exactly the same","out is for strings only","ref is faster"]'::jsonb,
   'out is often used when a method needs to return multiple values (e.g., int.TryParse).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a method that safely tries to parse an integer using an out parameter:',
   '[{"id":"1","code":"string input = \"42\";"},{"id":"2","code":"if (int.TryParse(input, out int result)) {"},{"id":"3","code":"  Console.WriteLine(result);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["string input = \"42\";","if (int.TryParse(input, out int result)) {","  Console.WriteLine(result);","}"]'::jsonb,
   'String input, TryParse condition using out, print result, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write static void Swap(ref int a, ref int b) to swap values. Call it on x=1, y=2, then print x and y. Expected: 2 1',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  // Write Swap' || chr(10) || '  static void Main() {' || chr(10) || '    int x = 1, y = 2;' || chr(10) || '    // Call Swap and print x y' || chr(10) || '  }' || chr(10) || '}',
   '2 1',
   'static void Swap(ref int a, ref int b) { int temp = a; a = b; b = temp; } ... Swap(ref x, ref y); Console.WriteLine($"{x} {y}");',
   5, 20);
   -- ==============================================================
   -- UNIT 4: Arrays and Collections
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 4: Arrays & Collections', 'Store multiple values using Arrays, Lists, and Dictionaries', 'purple', 4)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Collections in C#', $note$
# Arrays and Collections
## Arrays (Fixed Size)
Arrays hold a fixed number of items of the same type.
```csharp
int[] scores = new int[3];
scores[0] = 90;
scores[1] = 85;
scores[2] = 100;

// Shortcut declaration:
string[] names = { "Alice", "Bob" };
Console.WriteLine(names.Length); // 2

```
## Lists (Dynamic Size)
Lists are heavily used in C# because they can grow and shrink automatically. They require using System.Collections.Generic;.
```csharp
List<string> inventory = new List<string>();
inventory.Add("Sword");
inventory.Add("Shield");
inventory.Remove("Sword");

Console.WriteLine(inventory.Count); // 1

```
## Dictionaries (Key-Value Pairs)
Dictionaries map a specific key to a value, perfect for looking up data quickly.
```csharp
Dictionary<string, int> ages = new Dictionary<string, int>();
ages.Add("Anthony", 22);
ages["Sarah"] = 21; // Alternate syntax

Console.WriteLine(ages["Anthony"]); // 22

```
## Strings as Collections
A string is essentially a collection of characters.
```csharp
string word = "Hello";
Console.WriteLine(word[0]); // 'H'
Console.WriteLine(word.ToUpper()); // "HELLO"
Console.WriteLine(word.Substring(0, 4)); // "Hell"

```
## Key Takeaways
 * Use Arrays ([]) when the size is known and fixed.
 * Use List<T> for dynamic lists (Add, Remove).
 * Use Dictionary<TKey, TValue> for fast lookups by a key.
 * Arrays use .Length, but Lists and Dictionaries use .Count.
   $note$, 0);
   -- Lesson 4.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Arrays', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a primary limitation of arrays in C#?',
   '0',
   '["Their size is fixed upon creation and cannot be changed","They can only hold integers","They are slower than Lists","They cannot be used with foreach loops"]'::jsonb,
   'Once you declare new int[5], that array will always hold exactly 5 elements. Use a List if you need resizing.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the declaration of an array of 5 integers:',
   'int[] nums = ___ int[5];',
   'new',
   '["new","create","make","array"]'::jsonb,
   'Arrays are objects in C#, so you must instantiate them with the new keyword.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which property gives you the number of elements in an array?',
   '0',
   '["Length","Count","Size","Capacity"]'::jsonb,
   'myArray.Length returns the total capacity of the array.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Create an array, assign a value to the first element, and print it:',
   '[{"id":"1","code":"string[] colors = new string[3];"},{"id":"2","code":"colors[0] = \"Red\";"},{"id":"3","code":"Console.WriteLine(colors[0]);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["string[] colors = new string[3];","colors[0] = \"Red\";","Console.WriteLine(colors[0]);"]'::jsonb,
   'Instantiate array, access index 0, print it.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create an integer array with values { 5, 10, 15 }. Print the third value. Expected: 15',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Array and print' || chr(10) || '  }' || chr(10) || '}',
   '15',
   'int[] arr = { 5, 10, 15 }; Console.WriteLine(arr[2]);',
   5, 20);
   -- Lesson 4.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Lists', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which namespace is required to use the List<T> class?',
   '0',
   '["System.Collections.Generic","System.Linq","System.Lists","System.Data"]'::jsonb,
   'Lists are generic collections, so they live in System.Collections.Generic.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the method to add an item to the end of a list:',
   'myList.___("New Item");',
   'Add',
   '["Add","Push","Append","Insert"]'::jsonb,
   'Use .Add() to append to a List. Use .Remove() to take items out.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Instead of .Length, what property tells you how many items are currently in a List?',
   '0',
   '["Count","Length","Size","Capacity"]'::jsonb,
   'Lists and Dictionaries use the .Count property.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Create a List, add an item, and print the total count:',
   '[{"id":"1","code":"List<string> tasks = new List<string>();"},{"id":"2","code":"tasks.Add(\"Study\");"},{"id":"3","code":"Console.WriteLine(tasks.Count);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["List<string> tasks = new List<string>();","tasks.Add(\"Study\");","Console.WriteLine(tasks.Count);"]'::jsonb,
   'Instantiate List, Add item, print Count.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create a List<int>, add 50 and 60, then print the element at index 1. Expected: 60',
   'using System;' || chr(10) || 'using System.Collections.Generic;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // List, Add, Print' || chr(10) || '  }' || chr(10) || '}',
   '60',
   'List<int> list = new List<int>(); list.Add(50); list.Add(60); Console.WriteLine(list[1]);',
   5, 20);
   -- Lesson 4.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Dictionaries', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the structure of data inside a Dictionary<TKey, TValue>?',
   '0',
   '["Key-Value pairs where each key is unique","An ordered list of items","A multidimensional array","A set of random numbers"]'::jsonb,
   'Dictionaries allow fast lookups by Key. For example, looking up a student''s name using their Index Number.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Define a dictionary where the keys are strings and values are integers:',
   'Dictionary<***, int> map = new Dictionary<***, int>();',
   'string',
   '["string","string[]","text","Key"]'::jsonb,
   'The types are passed inside the angle brackets, e.g., <string, int>.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you try to add a duplicate key to a Dictionary using .Add("key", value)?',
   '0',
   '["An ArgumentException is thrown at runtime","It silently overwrites the old value","It creates a list of values for that key","It skips the addition"]'::jsonb,
   '.Add() throws an error on duplicate keys. However, using the indexer dict["key"] = value will safely overwrite.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange code to map a username to a role and retrieve it:',
   '[{"id":"1","code":"Dictionary<string, string> roles = new Dictionary<string, string>();"},{"id":"2","code":"roles.Add(\"Anthony\", \"Admin\");"},{"id":"3","code":"Console.WriteLine(roles[\"Anthony\"]);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["Dictionary<string, string> roles = new Dictionary<string, string>();","roles.Add(\"Anthony\", \"Admin\");","Console.WriteLine(roles[\"Anthony\"]);"]'::jsonb,
   'Instantiate dict, Add pair, lookup by key.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create a Dictionary<string, int>. Set key "HP" to 100. Print the value of "HP". Expected: 100',
   'using System;' || chr(10) || 'using System.Collections.Generic;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Dict, set, print' || chr(10) || '  }' || chr(10) || '}',
   '100',
   'Dictionary<string, int> stats = new Dictionary<string, int>(); stats["HP"] = 100; Console.WriteLine(stats["HP"]);',
   5, 20);
   -- Lesson 4.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'String Manipulation', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which string method extracts a portion of a string?',
   '0',
   '["Substring(startIndex, length)","Split()","Trim()","Slice()"]'::jsonb,
   '.Substring(0, 4) takes 4 characters starting from index 0.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the method to remove whitespace from the start and end of a string:',
   'string clean = dirtyInput.___();',
   'Trim',
   '["Trim","Clean","Strip","RemoveSpaces"]'::jsonb,
   '.Trim() is essential for cleaning up user input.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does string.Split('','') do?',
   '0',
   '["Splits a single string into an array of strings based on the comma separator","Removes all commas from the string","Joins an array of strings with commas","Throws an error"]'::jsonb,
   'Split() is incredibly useful for parsing CSV data (e.g., "apple,banana" -> ["apple", "banana"]).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange code to convert a string to uppercase and print it:',
   '[{"id":"1","code":"string msg = \"hello\";"},{"id":"2","code":"string upper = msg.ToUpper();"},{"id":"3","code":"Console.WriteLine(upper);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["string msg = \"hello\";","string upper = msg.ToUpper();","Console.WriteLine(upper);"]'::jsonb,
   'Declare, convert using ToUpper(), print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print the first 3 characters of word = "Computer" using Substring. Expected: Com',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    string word = "Computer";' || chr(10) || '    // Substring and print' || chr(10) || '  }' || chr(10) || '}',
   'Com',
   'Console.WriteLine(word.Substring(0, 3));',
   5, 20);
   -- ==============================================================
   -- UNIT 5: Object-Oriented Programming (OOP)
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 5: Classes & OOP', 'Build robust applications using Classes, Properties, and Inheritance', 'teal', 5)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'OOP in C#', $note$
# Object-Oriented Programming in C#
## Classes and Objects
A class is a blueprint. An object is a specific instance created from that blueprint.
```csharp
class Car {
    public string brand;
    
    // Constructor
    public Car(string b) {
        brand = b;
    }
    
    public void Honk() {
        Console.WriteLine("Beep!");
    }
}

// Creating an object
Car myCar = new Car("Toyota");
myCar.Honk();

```
## Properties and Encapsulation
Instead of using public fields (which is bad practice) or writing get/set methods (like Java), C# uses **Properties** with { get; set; }.
```csharp
class Student {
    // Auto-implemented property
    public string Name { get; set; }

    // Property with validation
    private int score;
    public int Score {
        get { return score; }
        set {
            if (value >= 0) score = value;
        }
    }
}

```
## Inheritance
A class can inherit from another class using the : symbol.
```csharp
class Animal {
    public virtual void Speak() { Console.WriteLine("..."); }
}

class Dog : Animal {
    // override changes the parent's behavior
    public override void Speak() { Console.WriteLine("Woof"); }
}

```
## Interfaces
Interfaces define a contract. A class that implements an interface must provide the code for its methods.
```csharp
interface ILogger {
    void Log(string msg);
}

class ConsoleLogger : ILogger {
    public void Log(string msg) {
        Console.WriteLine(msg);
    }
}

```
## Key Takeaways
 * Use { get; set; } Properties to protect data (Encapsulation).
 * virtual allows a method to be changed; override executes that change.
 * interface names usually start with a capital I in C# (e.g., ILogger).
   $note$, 0);
   -- Lesson 5.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Classes and Constructors', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the purpose of a Constructor in a class?',
   '0',
   '["To initialize the object''s data when it is created with the new keyword","To destroy the object to free memory","To define the return type","To make the class static"]'::jsonb,
   'The constructor is a special method with the same name as the class. It runs once when new ClassName() is called.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to create a new instance of the User class:',
   'User u = ___ User();',
   'new',
   '["new","create","make","init"]'::jsonb,
   'Classes are reference types. You must allocate them in memory using new.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If you don''t write a constructor for a class, what happens?',
   '0',
   '["The C# compiler automatically provides a parameterless default constructor","You cannot instantiate the class","The class is marked as static","A compile-time error occurs"]'::jsonb,
   'If you write NO constructors, C# gives you an empty one automatically. If you write one with parameters, the automatic one is removed.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a simple Player class with a constructor:',
   '[{"id":"1","code":"class Player {"},{"id":"2","code":"  public string name;"},{"id":"3","code":"  public Player(string n) { name = n; }"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Player {","  public string name;","  public Player(string n) { name = n; }","}"]'::jsonb,
   'Class, public field, constructor matching class name setting the field, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create an instance of Box passing 10 to the constructor. Print its Size. Expected: 10',
   'using System;' || chr(10) || 'class Box { public int Size; public Box(int s) { Size = s; } }' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Instantiate Box and print Size' || chr(10) || '  }' || chr(10) || '}',
   '10',
   'Box b = new Box(10); Console.WriteLine(b.Size);',
   5, 20);
   -- Lesson 5.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Properties and Encapsulation', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Why are C# Properties { get; set; } preferred over public fields?',
   '0',
   '["They provide encapsulation, allowing you to add validation logic later without changing the public API","They run faster than fields","They are required by the .NET compiler","They take up less memory"]'::jsonb,
   'Properties look like fields when you use them (obj.Name = "x"), but act like methods under the hood.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the syntax for an auto-implemented property:',
   'public int Score { ___; set; }',
   'get',
   '["get","read","fetch","value"]'::jsonb,
   'get allows reading, set allows writing. You can omit set or make it private set to make it read-only externally.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Inside a manual set block, what special keyword represents the incoming data being assigned?',
   '0',
   '["value","input","data","this"]'::jsonb,
   'When you write obj.Score = 50;, inside the set { } block, the keyword value holds the number 50.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a property that prevents a negative age:',
   '[{"id":"1","code":"private int _age;"},{"id":"2","code":"public int Age {"},{"id":"3","code":"  get { return _age; }"},{"id":"4","code":"  set { if (value >= 0) _age = value; }"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["private int _age;","public int Age {","  get { return _age; }","  set { if (value >= 0) _age = value; }","}"]'::jsonb,
   'Private backing field, public Property open, get block, set block with logic, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Set c.Name = "EduManage"; using the auto-property, then print c.Name. Expected: EduManage',
   'using System;' || chr(10) || 'class App { public string Name { get; set; } }' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    App c = new App();' || chr(10) || '    // Set Name and print' || chr(10) || '  }' || chr(10) || '}',
   'EduManage',
   'c.Name = "EduManage"; Console.WriteLine(c.Name);',
   5, 20);
   -- Lesson 5.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Inheritance and Polymorphism', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which character is used to denote inheritance in C# (e.g., class Dog inherits from Animal)?',
   '0',
   '["Colon (:)","Keyword extends","Arrow (->)","Keyword inherits"]'::jsonb,
   'class Dog : Animal is the correct C# syntax.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'To allow a child class to change a parent''s method, the parent''s method must be marked as:',
   'public ___ void Speak() { }',
   'virtual',
   '["virtual","override","abstract","static"]'::jsonb,
   'virtual gives permission to child classes to override the method.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If the parent method is marked virtual, what keyword must the child use to replace it?',
   '0',
   '["override","new","virtual","replace"]'::jsonb,
   'public override void Speak() tells the compiler you are intentionally replacing the parent''s behavior.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a Base and Derived class overriding a method:',
   '[{"id":"1","code":"class Shape { public virtual void Draw() { Console.WriteLine(\"Shape\"); } }"},{"id":"2","code":"class Circle : Shape {"},{"id":"3","code":"  public override void Draw() {"},{"id":"4","code":"    Console.WriteLine(\"Circle\"); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Shape { public virtual void Draw() { Console.WriteLine(\"Shape\"); } }","class Circle : Shape {","  public override void Draw() {","    Console.WriteLine(\"Circle\"); } }"]'::jsonb,
   'Base with virtual, derived with colon, override signature, body and close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Instantiate a Cat, which inherits from Pet, and call Speak(). Expected: Meow',
   'using System;' || chr(10) || 'class Pet { public virtual void Speak() {} }' || chr(10) || 'class Cat : Pet { public override void Speak() { Console.WriteLine("Meow"); } }' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Instatiate and call Speak' || chr(10) || '  }' || chr(10) || '}',
   'Meow',
   'Cat c = new Cat(); c.Speak();',
   5, 20);
   -- Lesson 5.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Interfaces', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the standard naming convention for Interfaces in C#?',
   '0',
   '["They begin with a capital ''I'' (e.g., ILogger, IComparable)","They end with ''Interface''","They must be fully uppercase","There is no convention"]'::jsonb,
   'Prefixing with I makes it immediately obvious that the type is an interface, not a concrete class.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the declaration to implement an interface:',
   'class UserRepository ___ IRepository { }',
   ':',
   '[":","implements","extends","->"]'::jsonb,
   'In C#, the colon : is used for both inheriting classes and implementing interfaces.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which statement about interfaces is true?',
   '0',
   '["A class can implement multiple interfaces, but can only inherit from one class","An interface can contain fields and constructors","A class can only implement one interface","Interfaces are instantiated using new"]'::jsonb,
   'class MyClass : BaseClass, IFirst, ISecond is perfectly valid. Multiple inheritance of classes is not allowed.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Define an interface and a class that implements it:',
   '[{"id":"1","code":"interface IRunnable { void Run(); }"},{"id":"2","code":"class Engine : IRunnable {"},{"id":"3","code":"  public void Run() {"},{"id":"4","code":"    Console.WriteLine(\"Vroom\"); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["interface IRunnable { void Run(); }","class Engine : IRunnable {","  public void Run() {","    Console.WriteLine(\"Vroom\"); } }"]'::jsonb,
   'Interface without body, class implementing it with colon, public method matching signature, body.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Implement IPayable.Pay() inside Employee. Print "Paid". Create an Employee and call Pay(). Expected: Paid',
   'using System;' || chr(10) || 'interface IPayable { void Pay(); }' || chr(10) || 'class Employee : IPayable {' || chr(10) || '  // Implement Pay here' || chr(10) || '}' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Instantiate and call' || chr(10) || '  }' || chr(10) || '}',
   'Paid',
   'public void Pay() { Console.WriteLine("Paid"); } ... Employee e = new Employee(); e.Pay();',
   5, 20);
   -- ==============================================================
   -- UNIT 6: Advanced C# Concepts
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 6: Advanced C#', 'Exceptions, Generics, and Language Integrated Query (LINQ)', 'red', 6)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Advanced C# Features', $note$
# Advanced C# Features
## Exception Handling
Wrap dangerous code (like file access or parsing user input) in try...catch to prevent your app from crashing.
```csharp
try {
    int num = int.Parse("NotANumber");
} catch (FormatException ex) {
    Console.WriteLine("Invalid input!");
} finally {
    // This block always runs, crash or no crash
    Console.WriteLine("Cleanup code here.");
}

```
## Generics <T>
Generics let you write methods or classes that work with ANY data type safely. List<T> is a generic class.
```csharp
// T is a placeholder for a type
static void Swap<T>(ref T a, ref T b) {
    T temp = a;
    a = b;
    b = temp;
}

```
## LINQ (Language Integrated Query)
LINQ allows you to query arrays and lists using SQL-like syntax. Requires using System.Linq;.
```csharp
int[] scores = { 90, 45, 82, 100, 30 };

// Find all passing scores
var passing = scores.Where(s => s >= 50);

// Sort them
var sorted = passing.OrderBy(s => s);

```
## Async / Await
For tasks that take a long time (like fetching data from the web or database), use asynchronous programming to keep your app responsive.
```csharp
using System.Threading.Tasks;

// The method returns a Task
static async Task FetchDataAsync() {
    Console.WriteLine("Fetching...");
    await Task.Delay(2000); // Wait 2 seconds without freezing the app
    Console.WriteLine("Done!");
}

```
## Key Takeaways
 * Use try...catch for predictable errors.
 * Generics <T> avoid code duplication and boxed types.
 * LINQ (.Where, .Select, .OrderBy) is the most powerful tool for data manipulation in C#.
 * async / await prevents the UI thread from freezing during heavy operations.
   $note$, 0);
   -- Lesson 6.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Exceptions', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What block of code is guaranteed to run whether an exception occurs or not?',
   '0',
   '["finally","catch","try","default"]'::jsonb,
   'The finally block is generally used to close files or database connections so they aren''t left hanging if a crash occurs.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the block that handles the error:',
   '___ (Exception ex) { Console.WriteLine(ex.Message); }',
   'catch',
   '["catch","try","except","error"]'::jsonb,
   'try { ... } catch (Exception ex) { ... }',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you manually trigger an exception in C#?',
   '0',
   '["throw new Exception(\\\"Message\\\");\\\", \\\"raise Exception(\\\"Message\\\");\\\", \\\"catch new Exception();\\\", \\\"return Exception;\\\"]"]'::jsonb,
   'The throw keyword creates an error state and halts execution unless caught.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a safe parse operation using try-catch:',
   '[{"id":"1","code":"try {"},{"id":"2","code":"  int x = int.Parse(\"A\"); }"},{"id":"3","code":"catch (FormatException) {"},{"id":"4","code":"  Console.WriteLine(\"Fail\"); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["try {","  int x = int.Parse(\"A\"); }","catch (FormatException) {","  Console.WriteLine(\"Fail\"); }"]'::jsonb,
   'try block open, dangerous code, catch block open, handle error.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Wrap int x = int.Parse("Oops"); in a try/catch. In the catch block, print "Error". Expected: Error',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    // Write try catch' || chr(10) || '  }' || chr(10) || '}',
   'Error',
   'try { int x = int.Parse("Oops"); } catch { Console.WriteLine("Error"); }',
   5, 20);
   -- Lesson 6.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Generics', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Why use a Generic Type <T> instead of object?',
   '0',
   '["Generics provide compile-time type safety and better performance (no boxing/unboxing)","Generics take less memory","Using object is actually preferred","Generics automatically encrypt data"]'::jsonb,
   'With object, you have to cast values back and forth, which is slow and prone to runtime errors. Generics enforce the type at compile-time.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the syntax for a generic method declaration:',
   'static void PrintItem___(T item) { Console.WriteLine(item); }',
   '<T>',
   '["<T>","(T)","{T}","[T]"]'::jsonb,
   'Angle brackets <T> define the type parameter directly after the method name.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can you constrain a Generic so it only accepts Classes (reference types)?',
   '0',
   '["Yes, using where T : class","No, Generics must accept everything","Yes, using where T : object","Only in interfaces"]'::jsonb,
   'Constraints (where clauses) make generics very powerful. You can ensure T has a parameterless constructor, inherits an interface, or is a struct.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a generic class that holds a value:',
   '[{"id":"1","code":"class Box<T> {"},{"id":"2","code":"  public T Content { get; set; }"},{"id":"3","code":"}"},{"id":"4","code":"Box<string> b = new Box<string>();"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Box<T> {","  public T Content { get; set; }","}","Box<string> b = new Box<string>();"]'::jsonb,
   'Class generic signature, generic property, close, instantiation.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write static T ReturnIt<T>(T val) { return val; }. Call it with (99) and print the result. Expected: 99',
   'using System;' || chr(10) || 'class Program {' || chr(10) || '  // Write method here' || chr(10) || '  static void Main() {' || chr(10) || '    // Call and print' || chr(10) || '  }' || chr(10) || '}',
   '99',
   'static T ReturnIt<T>(T val) { return val; } ... Console.WriteLine(ReturnIt(99));',
   5, 20);
   -- Lesson 6.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'LINQ Basics', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which LINQ extension method is used to filter a collection based on a condition?',
   '0',
   '["Where()","Select()","Filter()","Find()"]'::jsonb,
   '.Where(x => x > 5) filters items. .Select() is used for transforming data (mapping).',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the LINQ query to get only names starting with ''A'':',
   'var aNames = names.___ (n => n.StartsWith("A"));',
   'Where',
   '["Where","Select","Filter","Contains"]'::jsonb,
   'Where takes a lambda expression (an arrow function returning a boolean) to filter.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the var keyword do in C#?',
   '0',
   '["It asks the compiler to infer the type of the variable based on the value assigned to it","It declares a variable that can change types at runtime like JavaScript","It declares a global variable","It is required for LINQ"]'::jsonb,
   'var x = 5; is compiled exactly as int x = 5;. It is strongly typed, just shorter to write. Highly used with complex LINQ return types.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a LINQ query to filter and array and print the result:',
   '[{"id":"1","code":"int[] nums = { 1, 4, 7 };"},{"id":"2","code":"var large = nums.Where(n => n > 3);"},{"id":"3","code":"foreach (int n in large) {"},{"id":"4","code":"  Console.WriteLine(n); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int[] nums = { 1, 4, 7 };","var large = nums.Where(n => n > 3);","foreach (int n in large) {","  Console.WriteLine(n); }"]'::jsonb,
   'Array, LINQ Where query using var, foreach loop, print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given int[] arr = { 2, 9, 4 };. Use LINQ .Where(n => n % 2 == 0) to get even numbers. Foreach and print them.',
   'using System;' || chr(10) || 'using System.Linq;' || chr(10) || 'class Program {' || chr(10) || '  static void Main() {' || chr(10) || '    int[] arr = { 2, 9, 4 };' || chr(10) || '    // Filter and print' || chr(10) || '  }' || chr(10) || '}',
   '2' || chr(10) || '4',
   'var evens = arr.Where(n => n % 2 == 0); foreach(var n in evens) Console.WriteLine(n);',
   5, 20);
   -- Lesson 6.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Async / Await', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Why do we use async/await in modern C# applications?',
   '0',
   '["To prevent long-running tasks (like network calls) from blocking the main executing thread","To make calculations mathematically faster","To reduce memory usage","To bypass compiler errors"]'::jsonb,
   'If a web request takes 5 seconds, awaiting it allows the UI to stay responsive rather than freezing.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the modifier required for a method to use the await keyword inside of it:',
   'static ___ Task Fetch() { await Task.Delay(100); }',
   'async',
   '["async","await","virtual","thread"]'::jsonb,
   'You cannot use await unless the method is marked as async.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the standard return type of an async method that does not return data (the async equivalent of void)?',
   '0',
   '["Task","void","Task<void>","AsyncVoid"]'::jsonb,
   'Returning Task allows the calling method to await it. (async void is only used for UI event handlers and should generally be avoided).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange an async method that waits 1 second:',
   '[{"id":"1","code":"static async Task WaitSec() {"},{"id":"2","code":"  Console.WriteLine(\"Start\");"},{"id":"3","code":"  await Task.Delay(1000);"},{"id":"4","code":"  Console.WriteLine(\"End\"); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["static async Task WaitSec() {","  Console.WriteLine(\"Start\");","  await Task.Delay(1000);","  Console.WriteLine(\"End\"); }"]'::jsonb,
   'async signature, start print, await Task, end print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Make Main async Task. Write await Task.Delay(10); then print "Done". Expected: Done',
   'using System;' || chr(10) || 'using System.Threading.Tasks;' || chr(10) || 'class Program {' || chr(10) || '  // Adjust Main signature' || chr(10) || '  static void Main() {' || chr(10) || '    // await and print' || chr(10) || '  }' || chr(10) || '}',
   'Done',
   'static async Task Main() { await Task.Delay(10); Console.WriteLine("Done"); }',
   5, 20);
END $$;
