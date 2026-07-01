-- ============================================================
-- REAL PYTHON CURRICULUM
-- Replaces all existing Python content with accurate, educational
-- notes, lessons and questions written by subject matter level.
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

  -- Ensure Python language exists
  SELECT id INTO v_lang_id FROM public.languages WHERE slug = 'python';
  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('Python', 'python', '🐍', 'Learn the most popular programming language')
    RETURNING id INTO v_lang_id;
  END IF;

  -- Wipe all existing Python units (cascades to lessons, questions, unit_notes)
  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with Python
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 1: Getting Started',
          'Write your first Python programs and understand how the language works',
          'green', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to Python', $note$
# Introduction to Python

Python is a high-level, interpreted programming language created by Guido van Rossum in 1991. It is famous for its clean, readable syntax and is used in web development, data science, AI, and automation.

## Hello, World!

```python
print("Hello, World!")
```

This single line is a complete, working Python program — no imports, no boilerplate.

## Running Python

Two ways to run Python:
- **Script mode** — save code as `hello.py`, then run `python hello.py` in your terminal
- **Interactive (REPL)** — type `python` in your terminal to enter a live session

## The print() Function

`print()` displays output to the screen:

```python
print("Welcome to Python!")
print(42)
print(2 + 3)        # prints 5
```

Each `print()` starts on a new line by default.

## Comments

Python ignores lines starting with `#`:

```python
# This is a comment — Python skips it
print("Hello")  # inline comment
```

## Arithmetic Operators

| Operator | Meaning          | Example   | Result |
|----------|------------------|-----------|--------|
| `+`      | Addition         | `5 + 3`   | `8`    |
| `-`      | Subtraction      | `10 - 4`  | `6`    |
| `*`      | Multiplication   | `3 * 4`   | `12`   |
| `/`      | Division         | `7 / 2`   | `3.5`  |
| `//`     | Floor division   | `7 // 2`  | `3`    |
| `%`      | Modulo (remainder)| `10 % 3` | `1`    |
| `**`     | Exponentiation   | `2 ** 8`  | `256`  |

## Indentation is Mandatory

Python uses indentation to define code blocks — not curly braces:

```python
if True:
    print("inside the if block")   # indented
print("outside the if block")      # not indented
```

Inconsistent indentation raises an `IndentationError`.

## Key Takeaways
- Python runs code line by line from top to bottom
- `print()` is the primary output function
- `#` starts a comment; Python ignores everything after it
- Indentation defines structure — 4 spaces is the standard
$note$, 0);

  -- ── Lesson 1.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Your First Python Program', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does this code display?' || chr(10) || 'print("Hello, World!")',
   '0',
   '["Hello, World!", "print", "Nothing — it needs a semicolon", "An error because of the quotes"]'::jsonb,
   'print() outputs the text inside the parentheses, without the surrounding quotes.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the statement to display "Python" to the screen:',
   '___("Python")',
   'print',
   '["print", "output", "display", "write"]'::jsonb,
   'The built-in function for showing output in Python is print().',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Python is described as an "interpreted" language. What does this mean?',
   '0',
   '["Python executes code line by line without a separate compile step", "Python can only run inside a web browser", "Python converts code to machine code before running", "Python requires a paid licence"]'::jsonb,
   'Interpreted means Python reads and runs your source code directly.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these steps to write and run your first Python script:',
   '[{"id":"1","code":"1. Create a new file called hello.py"},{"id":"2","code":"2. Write: print(\"Hello!\") inside the file"},{"id":"3","code":"3. In your terminal run: python hello.py"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["1. Create a new file called hello.py","2. Write: print(\"Hello!\") inside the file","3. In your terminal run: python hello.py"]'::jsonb,
   'Create the file first, write the code second, then run it third.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a Python program that prints exactly: Hello, Python!',
   '# Write your print statement below' || chr(10),
   'Hello, Python!',
   'Use print("Hello, Python!") — punctuation must match exactly.',
   5, 20);

  -- ── Lesson 1.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Comments and Indentation', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the single-line comment:',
   '___ This explains the code below',
   '#',
   '["#", "//", "--", "/*"]'::jsonb,
   'Python uses the hash symbol # to begin a comment.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does Python do when it encounters a comment?',
   '0',
   '["Ignores it — comments have no effect on the running program", "Displays the comment text to the screen", "Stores the comment in a log file", "Raises a SyntaxError"]'::jsonb,
   'Comments are for humans only. Python skips over them entirely.',
   2, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What error does Python raise when indentation is incorrect?',
   '0',
   '["IndentationError", "SyntaxError", "TypeError", "ValueError"]'::jsonb,
   'Python enforces indentation strictly. Misaligned blocks cause an IndentationError.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these three lines so the if-block runs correctly:',
   '[{"id":"1","code":"# Greet the user"},{"id":"2","code":"if True:"},{"id":"3","code":"    print(\"Hello!\")"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["# Greet the user","if True:","    print(\"Hello!\")"]'::jsonb,
   'The comment comes first, then the if statement, then the indented body inside it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write two print() calls: first print "Line 1", then print "Line 2".',
   '# Write two print statements' || chr(10),
   'Line 1' || chr(10) || 'Line 2',
   'Each print() starts on a new line. Call print() twice in order.',
   5, 20);

  -- ── Lesson 1.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Numbers and Math Operators', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(2 ** 3)',
   '0',
   '["8", "6", "23", "Error: ** is not valid Python"]'::jsonb,
   'The ** operator is exponentiation. 2 ** 3 = 2 × 2 × 2 = 8.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the expression to get the remainder when 10 is divided by 3:',
   'result = 10 ___ 3',
   '%',
   '["%", "//", "mod", "rem"]'::jsonb,
   'The % operator (modulo) returns the remainder. 10 % 3 = 1.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the result of 7 // 2 in Python?',
   '0',
   '["3", "3.5", "4", "3.0"]'::jsonb,
   '// is floor (integer) division — it divides and rounds DOWN. 7 // 2 = 3.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to calculate and print the area of a rectangle (width=5, height=3):',
   '[{"id":"1","code":"width = 5"},{"id":"2","code":"height = 3"},{"id":"3","code":"print(width * height)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["width = 5","height = 3","print(width * height)"]'::jsonb,
   'Define both variables before using them in the expression.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print the result of 100 divided by 4 using regular division. Expected output: 25.0',
   '# Use the / operator' || chr(10),
   '25.0',
   'Regular division / always returns a float. print(100 / 4) gives 25.0.',
   5, 20);

  -- ── Lesson 1.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Variables and Assignment', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Assign the value 42 to a variable called age:',
   '___ = 42',
   'age',
   '["age", "var age", "int age", "Age"]'::jsonb,
   'In Python, create a variable with: name = value. No keyword like var or int is needed.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of this code?' || chr(10) || 'x = 5' || chr(10) || 'x = 10' || chr(10) || 'print(x)',
   '0',
   '["10", "5", "5 and 10", "Error: x is already defined"]'::jsonb,
   'Reassigning a variable replaces its old value. The last assignment wins.',
   2, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which of these is a valid Python variable name?',
   '0',
   '["my_score", "2score", "my-score", "my score"]'::jsonb,
   'Variable names must start with a letter or underscore, and cannot contain spaces or hyphens.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to store two numbers and print their sum:',
   '[{"id":"1","code":"a = 15"},{"id":"2","code":"b = 7"},{"id":"3","code":"print(a + b)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["a = 15","b = 7","print(a + b)"]'::jsonb,
   'You must define variables before using them in expressions.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a variable called language with the value "Python" and print it.',
   '# Create your variable and print it' || chr(10),
   'Python',
   'language = "Python" then print(language).',
   5, 20);


  -- ==============================================================
  -- UNIT 2: Variables and Data Types
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 2: Variables & Data Types',
          'Master how Python stores text, numbers, and booleans',
          'blue', 2)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Python Data Types', $note$
# Python Data Types

Python has several built-in data types. The four most common are:

| Type    | Keyword | Example              |
|---------|---------|----------------------|
| Integer | `int`   | `42`, `-5`, `1000`   |
| Float   | `float` | `3.14`, `-0.5`, `2.0`|
| String  | `str`   | `"Hello"`, `'World'` |
| Boolean | `bool`  | `True`, `False`      |

Plus `None` — represents "no value".

## Checking the Type

```python
print(type(42))        # <class 'int'>
print(type(3.14))      # <class 'float'>
print(type("Hello"))   # <class 'str'>
print(type(True))      # <class 'bool'>
```

## Strings

Strings hold text. Use single or double quotes:

```python
name = "Alice"
city = 'Accra'
bio  = """This can
span multiple lines."""
```

Key string operations:
```python
s = "Python"
print(len(s))          # 6 — character count
print(s.upper())       # PYTHON
print(s.lower())       # python
print(s[0])            # P — index 0 is the first character
print(s[-1])           # n — index -1 is the last character
print(s + " rocks!")   # Python rocks! — concatenation
```

## f-Strings (Formatted Strings)

The cleanest way to embed variables in text:

```python
name = "Alice"
age  = 30
print(f"My name is {name} and I am {age} years old.")
# → My name is Alice and I am 30 years old.
```

## Numbers

```python
x = 10       # int  — whole number
y = 3.14     # float — decimal
z = x + y    # 13.14 (result is float when mixing int and float)
```

## Booleans

`True` and `False` are Python keywords (capital first letter):

```python
is_logged_in = True
is_empty     = False
print(5 > 3)    # True
print(5 == 3)   # False
```

## Type Conversion

```python
int("42")      # → 42    (string → integer)
float("3.14")  # → 3.14  (string → float)
str(100)       # → "100" (integer → string)
bool(0)        # → False (0 and "" are falsy)
bool(1)        # → True
```

## Key Takeaways
- Use `type()` to inspect any variable's type at runtime
- f-strings (f"...{variable}...") are the modern way to format text
- `bool(0)`, `bool("")`, `bool(None)` are all `False`
- Division `/` always returns a float; use `//` for integer division
$note$, 0);

  -- ── Lesson 2.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Strings in Python', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(len("Python"))',
   '0',
   '["6", "5", "7", "Error: len() cannot be used on strings"]'::jsonb,
   'len() counts characters. "Python" has 6 characters: P-y-t-h-o-n.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the call to convert the string to UPPERCASE:',
   'text = "hello"' || chr(10) || 'print(text.___()',
   'upper',
   '["upper", "toUpper", "uppercase", "UPPER"]'::jsonb,
   'Python strings have an upper() method that returns the uppercase version.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does "Hello"[0] evaluate to?',
   '0',
   '["H", "e", "Hello", "Error: indexing not allowed"]'::jsonb,
   'String indexing starts at 0. "Hello"[0] is the first character: H.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to build and print a greeting using an f-string:',
   '[{"id":"1","code":"first = \"Alice\""},{"id":"2","code":"last = \"Smith\""},{"id":"3","code":"print(f\"Hello, {first} {last}!\")"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["first = \"Alice\"","last = \"Smith\"","print(f\"Hello, {first} {last}!\")"]'::jsonb,
   'Define the variables before using them inside the f-string.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use an f-string to print: My score is 100' || chr(10) || 'Store 100 in a variable called score first.',
   'score = 100' || chr(10) || '# Print using an f-string' || chr(10),
   'My score is 100',
   'print(f"My score is {score}")',
   5, 20);

  -- ── Lesson 2.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Numbers: int and float', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What type does Python assign to the value 3.14?',
   '0',
   '["float", "int", "double", "decimal"]'::jsonb,
   'Any number with a decimal point is a float in Python.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Convert the string "25" to an integer:',
   'age = ___("25")',
   'int',
   '["int", "integer", "str", "float"]'::jsonb,
   'The int() function converts a string (or float) to an integer.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(type(5 / 2))',
   '0',
   '["<class ''float''>", "<class ''int''>", "<class ''str''>", "Error"]'::jsonb,
   'Regular division / always produces a float, even when dividing two integers.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to convert a string to float and print it:',
   '[{"id":"1","code":"price_str = \"19.99\""},{"id":"2","code":"price = float(price_str)"},{"id":"3","code":"print(price + 1)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["price_str = \"19.99\"","price = float(price_str)","print(price + 1)"]'::jsonb,
   'Convert the string to a float before doing arithmetic with it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Convert the string "7" to an integer, multiply it by 6, and print the result.',
   'number = "7"' || chr(10) || '# Convert to int and multiply by 6' || chr(10),
   '42',
   'int("7") converts to 7, then 7 * 6 = 42.',
   5, 20);

  -- ── Lesson 2.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Booleans and None', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which of these is a valid boolean value in Python?',
   '0',
   '["True", "true", "TRUE", "yes"]'::jsonb,
   'Python''s boolean values are True and False — capital first letter only.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the expression to check if x equals 10:',
   'x = 10' || chr(10) || 'print(x ___ 10)',
   '==',
   '["==", "=", "!=", "is"]'::jsonb,
   'Use == (double equals) to compare for equality. Single = is assignment.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(bool(0))',
   '0',
   '["False", "True", "0", "Error"]'::jsonb,
   'In Python, 0, empty strings, and None are all "falsy" — bool(0) is False.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to check if a user is old enough to vote (age >= 18):',
   '[{"id":"1","code":"age = 20"},{"id":"2","code":"can_vote = age >= 18"},{"id":"3","code":"print(can_vote)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["age = 20","can_vote = age >= 18","print(can_vote)"]'::jsonb,
   'Set the variable first, evaluate the condition second, print the result third.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print the result of: is 15 greater than 10? Your output should be: True',
   '# Use a comparison expression inside print()' || chr(10),
   'True',
   'print(15 > 10) evaluates to True.',
   5, 20);

  -- ── Lesson 2.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Type Conversion', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print("5" + "3")',
   '0',
   '["53", "8", "Error: cannot add strings", "5 3"]'::jsonb,
   '+ on two strings concatenates them. "5" + "3" joins the characters → "53".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Convert the integer 42 to a string so it can be joined with text:',
   'result = "The answer is " + ___(42)',
   'str',
   '["str", "string", "int", "text"]'::jsonb,
   'str() converts any value to its string representation.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(int(3.9))',
   '0',
   '["3", "4", "3.9", "Error"]'::jsonb,
   'int() truncates the decimal part — it does not round. int(3.9) = 3.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to add the number 5 to the string "10" and print the result 15:',
   '[{"id":"1","code":"text_num = \"10\""},{"id":"2","code":"real_num = int(text_num)"},{"id":"3","code":"print(real_num + 5)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["text_num = \"10\"","real_num = int(text_num)","print(real_num + 5)"]'::jsonb,
   'Convert the string to an integer before doing arithmetic.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Convert 3.7 to an integer and print it. Expected: 3',
   '# Convert float to int' || chr(10),
   '3',
   'int(3.7) truncates — it does not round up.',
   5, 20);


  -- ==============================================================
  -- UNIT 3: Control Flow
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 3: Control Flow',
          'Make decisions with if statements and comparison operators',
          'orange', 3)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Control Flow in Python', $note$
# Control Flow in Python

Control flow lets your program make decisions and take different paths based on conditions.

## if / elif / else

```python
score = 85

if score >= 90:
    print("Grade: A")
elif score >= 80:
    print("Grade: B")
elif score >= 70:
    print("Grade: C")
else:
    print("Grade: F")
```

- `if` checks the first condition
- `elif` (else if) checks additional conditions if the previous ones are False
- `else` runs when all conditions above are False

## Comparison Operators

| Operator | Meaning           |
|----------|-------------------|
| `==`     | Equal to          |
| `!=`     | Not equal to      |
| `<`      | Less than         |
| `>`      | Greater than      |
| `<=`     | Less than or equal|
| `>=`     | Greater than/equal|

## Logical Operators

Combine multiple conditions:

```python
age = 25
has_id = True

if age >= 18 and has_id:
    print("Welcome!")

if age < 13 or age > 65:
    print("Special discount applies")

if not has_id:
    print("ID required")
```

## Truthy and Falsy Values

Any value can be used as a condition:

```python
name = ""
if name:              # empty string is falsy
    print("Got a name")
else:
    print("No name!")  # this runs
```

Falsy values: `0`, `0.0`, `""`, `[]`, `{}`, `None`, `False`
Everything else is truthy.

## Nested Conditions

```python
x = 15
if x > 0:
    if x % 2 == 0:
        print("positive even")
    else:
        print("positive odd")    # this prints
```

## Key Takeaways
- `if`, `elif`, `else` control which code blocks run
- Comparison operators return `True` or `False`
- `and` requires both sides to be true; `or` requires only one side
- Empty values (0, "", [], None) are falsy in Python
$note$, 0);

  -- ── Lesson 3.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'if Statements', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'x = 10' || chr(10) || 'if x > 5:' || chr(10) || '    print("big")',
   '0',
   '["big", "Nothing — the condition is False", "Error: missing else", "x > 5"]'::jsonb,
   '10 > 5 is True, so the indented print("big") executes.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the if statement keyword:',
   '___ age >= 18:' || chr(10) || '    print("Adult")',
   'if',
   '["if", "when", "check", "while"]'::jsonb,
   'Python uses the keyword if to begin a conditional statement.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which operator checks if two values are equal in Python?',
   '0',
   '["==", "=", "!=", "==="]'::jsonb,
   'Single = assigns a value. Double == compares two values for equality.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to check if a temperature is above freezing:',
   '[{"id":"1","code":"temp = 5"},{"id":"2","code":"if temp > 0:"},{"id":"3","code":"    print(\"Above freezing\")"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["temp = 5","if temp > 0:","    print(\"Above freezing\")"]'::jsonb,
   'Assign the variable first, then write the if statement, then the indented body.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an if statement: if 20 > 10, print "Yes". Expected output: Yes',
   '# Write your if statement' || chr(10),
   'Yes',
   'if 20 > 10: then indented print("Yes")',
   5, 20);

  -- ── Lesson 3.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'elif and else', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'In an if/elif/else chain, when does the else block run?',
   '0',
   '["When none of the previous conditions are True", "Always", "When the first condition is True", "When an error occurs"]'::jsonb,
   'else is the catch-all — it runs only if every if and elif above it was False.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword for an additional condition check:',
   'if score >= 90:' || chr(10) || '    print("A")' || chr(10) || '___ score >= 80:' || chr(10) || '    print("B")',
   'elif',
   '["elif", "else if", "elseif", "elsif"]'::jsonb,
   'Python uses elif (not "else if") for additional conditional branches.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is printed?' || chr(10) || 'x = 15' || chr(10) || 'if x > 20:' || chr(10) || '    print("A")' || chr(10) || 'elif x > 10:' || chr(10) || '    print("B")' || chr(10) || 'else:' || chr(10) || '    print("C")',
   '0',
   '["B", "A", "C", "B and C"]'::jsonb,
   '15 > 20 is False (skip A). 15 > 10 is True → print "B". else is skipped.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to print a grade based on score = 75:',
   '[{"id":"1","code":"score = 75"},{"id":"2","code":"if score >= 90:"},{"id":"3","code":"    print(\"A\")"},{"id":"4","code":"elif score >= 70:"},{"id":"5","code":"    print(\"C\")"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["score = 75","if score >= 90:","    print(\"A\")","elif score >= 70:","    print(\"C\")"]'::jsonb,
   'The if block comes first, then elif beneath it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Given age = 16, print "Minor" if under 18, else print "Adult". Expected: Minor',
   'age = 16' || chr(10) || '# Write your if/else block' || chr(10),
   'Minor',
   'if age < 18: print("Minor") else: print("Adult")',
   5, 20);

  -- ── Lesson 3.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Logical Operators', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(True and False)',
   '0',
   '["False", "True", "None", "Error"]'::jsonb,
   'and returns True only when BOTH sides are True. True and False → False.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the logical operator so the condition means "x is greater than 0 OR x is less than -10":',
   'if x > 0 ___ x < -10:',
   'or',
   '["or", "and", "not", "||"]'::jsonb,
   'or returns True if at least one side is True.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of: print(not True)',
   '0',
   '["False", "True", "not True", "Error"]'::jsonb,
   'not inverts a boolean. not True → False.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to check if a user can log in (must have both a username AND a password):',
   '[{"id":"1","code":"username = \"alice\""},{"id":"2","code":"password = \"secret\""},{"id":"3","code":"if username and password:"},{"id":"4","code":"    print(\"Access granted\")"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["username = \"alice\"","password = \"secret\"","if username and password:","    print(\"Access granted\")"]'::jsonb,
   'Define both variables, then combine them with and in the condition.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Print "Valid" if x = 5 is both greater than 0 AND less than 10, else print "Invalid". Expected: Valid',
   'x = 5' || chr(10) || '# Use an and condition' || chr(10),
   'Valid',
   'if x > 0 and x < 10: print("Valid") else: print("Invalid")',
   5, 20);

  -- ── Lesson 3.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Nested Conditions', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is printed?' || chr(10) || 'x = 8' || chr(10) || 'if x > 0:' || chr(10) || '    if x % 2 == 0:' || chr(10) || '        print("positive even")',
   '0',
   '["positive even", "Nothing — the inner condition is False", "Error: cannot nest if", "positive odd"]'::jsonb,
   '8 > 0 is True (enter outer if). 8 % 2 == 0 is True (enter inner if). Prints "positive even".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the nested if so it checks if x is positive AND even:',
   'if x > 0:' || chr(10) || '    ___ x % 2 == 0:' || chr(10) || '        print("positive even")',
   'if',
   '["if", "elif", "else", "while"]'::jsonb,
   'A nested if inside another if is still introduced with the if keyword.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'A nested if is an if statement placed:',
   '0',
   '["Inside the body of another if statement", "Before the outer if statement", "After the else statement only", "In a separate function always"]'::jsonb,
   'Nesting means one if is inside the indented block of another if.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to print "teen" only if age is between 13 and 17 (inclusive):',
   '[{"id":"1","code":"age = 15"},{"id":"2","code":"if age >= 13:"},{"id":"3","code":"    if age <= 17:"},{"id":"4","code":"        print(\"teen\")"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["age = 15","if age >= 13:","    if age <= 17:","        print(\"teen\")"]'::jsonb,
   'The inner if is indented inside the outer if body.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Using nested if statements, check if n = 12 is positive and even. Print "positive even". Expected: positive even',
   'n = 12' || chr(10) || '# Use nested if statements' || chr(10),
   'positive even',
   'if n > 0: then inside if n % 2 == 0: print("positive even")',
   5, 20);


  -- ==============================================================
  -- UNIT 4: Loops
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 4: Loops',
          'Repeat actions with while loops, for loops, and control keywords',
          'purple', 4)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Loops in Python', $note$
# Loops in Python

Loops let you repeat a block of code without copy-pasting it.

## while Loop

Repeats while a condition is True:

```python
count = 1
while count <= 5:
    print(count)
    count += 1
# Prints 1 2 3 4 5 (each on its own line)
```

⚠️ If the condition never becomes False, you get an **infinite loop**. Always make sure the loop will eventually stop.

## for Loop

Iterates over a sequence (list, string, range, etc.):

```python
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)
```

Iterating over a string character by character:

```python
for char in "Python":
    print(char)    # P then y then t then h then o then n
```

## range()

`range(start, stop, step)` generates a sequence of numbers:

```python
for i in range(5):           # 0 1 2 3 4
    print(i)

for i in range(1, 6):        # 1 2 3 4 5
    print(i)

for i in range(0, 10, 2):    # 0 2 4 6 8
    print(i)
```

`range(n)` always stops BEFORE n.

## break and continue

```python
for i in range(10):
    if i == 5:
        break           # exit the loop entirely
    print(i)            # prints 0 1 2 3 4

for i in range(6):
    if i == 3:
        continue        # skip this iteration, keep looping
    print(i)            # prints 0 1 2 4 5
```

## Key Takeaways
- `while` loops need a condition that eventually becomes False
- `for` loops are best when you know how many times to iterate
- `range(n)` generates numbers from 0 up to (but not including) n
- `break` exits the loop; `continue` skips to the next iteration
$note$, 0);

  -- ── Lesson 4.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'while Loops', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How many times does this loop run?' || chr(10) || 'i = 0' || chr(10) || 'while i < 3:' || chr(10) || '    print(i)' || chr(10) || '    i += 1',
   '0',
   '["3 times (i = 0, 1, 2)", "4 times (i = 0, 1, 2, 3)", "Infinite times", "0 times"]'::jsonb,
   'The loop runs while i < 3. i starts at 0, increments each time: 0, 1, 2 → then i=3 stops.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword to start a while loop:',
   '___ count < 10:' || chr(10) || '    print(count)',
   'while',
   '["while", "for", "loop", "repeat"]'::jsonb,
   'while is Python''s keyword for condition-based loops.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What causes an infinite loop?',
   '0',
   '["The loop condition never becomes False", "Using while instead of for", "Forgetting the colon :", "The variable name is wrong"]'::jsonb,
   'A loop runs forever if its condition is always True. Always update the loop variable!',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to count down from 3 to 1 using a while loop:',
   '[{"id":"1","code":"n = 3"},{"id":"2","code":"while n > 0:"},{"id":"3","code":"    print(n)"},{"id":"4","code":"    n -= 1"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["n = 3","while n > 0:","    print(n)","    n -= 1"]'::jsonb,
   'Set the variable, then the loop, then print inside, then decrement inside.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a while loop to print the numbers 1, 2, 3 (one per line).',
   '# Use a while loop' || chr(10) || 'i = 1' || chr(10),
   '1' || chr(10) || '2' || chr(10) || '3',
   'while i <= 3: print(i) then i += 1',
   5, 20);

  -- ── Lesson 4.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'for Loops', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does this code print?' || chr(10) || 'for letter in "Hi":' || chr(10) || '    print(letter)',
   '0',
   '["H then i (on separate lines)", "Hi (on one line)", "Error: cannot loop over a string", "H and i simultaneously"]'::jsonb,
   'A for loop over a string iterates character by character. "Hi" → "H" then "i".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the for loop keyword:',
   '___ item in my_list:' || chr(10) || '    print(item)',
   'for',
   '["for", "while", "each", "loop"]'::jsonb,
   'for is the keyword for iteration in Python.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'total = 0' || chr(10) || 'for n in [1, 2, 3]:' || chr(10) || '    total += n' || chr(10) || 'print(total)',
   '0',
   '["6", "3", "1 2 3", "Error"]'::jsonb,
   'The loop adds 1+2+3 to total. total = 0+1+2+3 = 6.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to print each item in a shopping list:',
   '[{"id":"1","code":"items = [\"bread\", \"milk\", \"eggs\"]"},{"id":"2","code":"for item in items:"},{"id":"3","code":"    print(item)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["items = [\"bread\", \"milk\", \"eggs\"]","for item in items:","    print(item)"]'::jsonb,
   'Define the list first, then iterate over it with for.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a for loop to print each color in the list: ["red", "green", "blue"]',
   'colors = ["red", "green", "blue"]' || chr(10) || '# Loop through colors' || chr(10),
   'red' || chr(10) || 'green' || chr(10) || 'blue',
   'for color in colors: print(color)',
   5, 20);

  -- ── Lesson 4.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'range() and Loop Tricks', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What numbers does range(1, 5) produce?',
   '0',
   '["1, 2, 3, 4", "1, 2, 3, 4, 5", "0, 1, 2, 3, 4", "1 to 5 inclusive"]'::jsonb,
   'range(start, stop) goes FROM start UP TO BUT NOT INCLUDING stop.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete range() to generate every even number from 0 to 8 (0, 2, 4, 6, 8):',
   'for i in range(0, 10, ___):',
   '2',
   '["2", "1", "0", "even"]'::jsonb,
   'The third argument to range() is the step. A step of 2 skips every other number.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'for i in range(3):' || chr(10) || '    print(i)',
   '0',
   '["0, 1, 2 (each on a new line)", "1, 2, 3", "0, 1, 2, 3", "3, 2, 1"]'::jsonb,
   'range(3) generates 0, 1, 2 — it starts at 0 and stops before 3.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to print the sum of numbers 1 through 5 (should print 15):',
   '[{"id":"1","code":"total = 0"},{"id":"2","code":"for i in range(1, 6):"},{"id":"3","code":"    total += i"},{"id":"4","code":"print(total)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["total = 0","for i in range(1, 6):","    total += i","print(total)"]'::jsonb,
   'Initialize total to 0, loop from 1 to 5, add each i, then print after the loop.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use range() to print numbers 5, 4, 3, 2, 1 (countdown). Print each on its own line.',
   '# Use range() with a negative step' || chr(10),
   '5' || chr(10) || '4' || chr(10) || '3' || chr(10) || '2' || chr(10) || '1',
   'range(5, 0, -1) counts down: 5, 4, 3, 2, 1.',
   5, 20);

  -- ── Lesson 4.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'break and continue', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the break statement do inside a loop?',
   '0',
   '["Exits the loop immediately", "Skips the current iteration and continues", "Pauses the loop for 1 second", "Restarts the loop from the beginning"]'::jsonb,
   'break terminates the loop entirely — no more iterations run after break.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete with the keyword that skips the rest of the current iteration:',
   'for i in range(5):' || chr(10) || '    if i == 2:' || chr(10) || '        ___' || chr(10) || '    print(i)',
   'continue',
   '["continue", "break", "skip", "pass"]'::jsonb,
   'continue jumps to the next iteration, skipping anything below it in the loop body.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What numbers does this code print?' || chr(10) || 'for i in range(5):' || chr(10) || '    if i == 3:' || chr(10) || '        break' || chr(10) || '    print(i)',
   '0',
   '["0, 1, 2", "0, 1, 2, 3", "0, 1, 2, 3, 4", "3, 4"]'::jsonb,
   'When i equals 3, break exits immediately. Only 0, 1, 2 are printed before that.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange this loop to print 0, 1, 2 then stop when it hits 3:',
   '[{"id":"1","code":"for i in range(10):"},{"id":"2","code":"    if i == 3:"},{"id":"3","code":"        break"},{"id":"4","code":"    print(i)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["for i in range(10):","    if i == 3:","        break","    print(i)"]'::jsonb,
   'The if check and break come before the print so 3 is never printed.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Loop through 0-9 but skip 4 (use continue). Print all numbers except 4.',
   '# Use continue to skip 4' || chr(10),
   '0' || chr(10) || '1' || chr(10) || '2' || chr(10) || '3' || chr(10) || '5' || chr(10) || '6' || chr(10) || '7' || chr(10) || '8' || chr(10) || '9',
   'for i in range(10): if i == 4: continue then print(i)',
   5, 20);


  -- ==============================================================
  -- UNIT 5: Functions
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 5: Functions',
          'Write reusable code blocks with parameters, return values, and scope',
          'teal', 5)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Functions in Python', $note$
# Functions in Python

A function is a reusable block of code that performs a specific task. Define once, call many times.

## Defining a Function

```python
def greet(name):
    print(f"Hello, {name}!")

greet("Alice")   # → Hello, Alice!
greet("Bob")     # → Hello, Bob!
```

- `def` is the keyword to define a function
- `greet` is the function name
- `name` is a parameter (a local placeholder variable)
- Call the function by writing its name followed by `()`

## Return Values

Functions can send back a result:

```python
def add(a, b):
    return a + b

result = add(3, 4)   # result = 7
print(result)        # 7
```

A function without `return` implicitly returns `None`.

## Default Arguments

Provide fallback values for parameters:

```python
def greet(name, greeting="Hello"):
    print(f"{greeting}, {name}!")

greet("Alice")             # Hello, Alice!
greet("Bob", "Hi")         # Hi, Bob!
```

Default parameters must come after non-default ones.

## Scope: Local vs Global

Variables defined inside a function are **local** — they exist only within that function:

```python
def show():
    x = 10          # local to show()
    print(x)

show()              # 10
print(x)            # NameError: x is not defined outside
```

Global variables are accessible anywhere, but it is best practice to pass values as arguments.

## Lambda Functions (Anonymous Functions)

Short, one-line functions:

```python
square = lambda x: x ** 2
print(square(5))    # 25

double = lambda n: n * 2
print(double(7))    # 14
```

## Key Takeaways
- `def name(params):` defines a function
- `return value` sends a result back to the caller
- Default arguments make parameters optional
- Variables inside a function are local and cannot be accessed outside
- `lambda x: expression` creates a tiny anonymous function
$note$, 0);

  -- ── Lesson 5.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Defining Functions', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What keyword is used to define a function in Python?',
   '0',
   '["def", "function", "func", "define"]'::jsonb,
   'Python uses def (short for "define") to declare a function.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword to define a function called greet:',
   '___ greet():' || chr(10) || '    print("Hello!")',
   'def',
   '["def", "func", "function", "create"]'::jsonb,
   'def begins every function definition in Python.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'def say_hi():' || chr(10) || '    print("Hi!")' || chr(10) || 'say_hi()',
   '0',
   '["Hi!", "Nothing — def only defines, not calls", "Error: function not called correctly", "say_hi()"]'::jsonb,
   'say_hi() at the end CALLS the function, which runs its body and prints "Hi!".',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to define and call a function that prints "Python is fun!":',
   '[{"id":"1","code":"def message():"},{"id":"2","code":"    print(\"Python is fun!\")"},{"id":"3","code":"message()"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["def message():","    print(\"Python is fun!\")","message()"]'::jsonb,
   'Define the function first (def), write the body indented, then call it by name.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Define a function called welcome that prints "Welcome to Python!" then call it.',
   '# Define your function here' || chr(10) || '# Then call it below' || chr(10),
   'Welcome to Python!',
   'def welcome(): then indented print("Welcome to Python!") then welcome() to call it.',
   5, 20);

  -- ── Lesson 5.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Parameters and Return Values', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'def square(n):' || chr(10) || '    return n * n' || chr(10) || 'print(square(4))',
   '0',
   '["16", "4", "8", "Error"]'::jsonb,
   'square(4) calls the function with n=4. It returns 4*4=16. print() then shows 16.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the keyword to send a value back from the function:',
   'def double(x):' || chr(10) || '    ___ x * 2',
   'return',
   '["return", "yield", "print", "output"]'::jsonb,
   'return sends a value back to wherever the function was called.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does a function return if it has no return statement?',
   '0',
   '["None", "0", "False", "An error"]'::jsonb,
   'In Python, functions without an explicit return statement implicitly return None.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to define a function that adds two numbers and return the result:',
   '[{"id":"1","code":"def add(a, b):"},{"id":"2","code":"    return a + b"},{"id":"3","code":"result = add(10, 5)"},{"id":"4","code":"print(result)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["def add(a, b):","    return a + b","result = add(10, 5)","print(result)"]'::jsonb,
   'Define the function, then call it and store the result, then print it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a function called multiply(a, b) that returns a * b. Call it with 6 and 7 and print the result.',
   '# Write your function here' || chr(10) || '# Then call it' || chr(10),
   '42',
   'def multiply(a, b): return a * b then print(multiply(6, 7))',
   5, 20);

  -- ── Lesson 5.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Default Arguments and Scope', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'def greet(name, msg="Hello"):' || chr(10) || '    print(f"{msg}, {name}!")' || chr(10) || 'greet("Alice")',
   '0',
   '["Hello, Alice!", "Error: msg argument missing", "None, Alice!", "Alice, Hello!"]'::jsonb,
   'msg has a default value of "Hello", so it is used when no second argument is given.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the default value so greeting defaults to "Hi":',
   'def greet(name, greeting=___):',
   '"Hi"',
   '[""Hi"", "Hi", "hello", "default"]'::jsonb,
   'Default arguments are specified with = in the parameter list. Strings need quotes.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is "scope" in the context of Python functions?',
   '0',
   '["Where a variable is accessible and visible in the code", "The length of a function", "The number of parameters a function takes", "How fast a function runs"]'::jsonb,
   'Scope determines where in the code a variable can be read or modified.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a function with a default argument and call it in two ways:',
   '[{"id":"1","code":"def power(base, exp=2):"},{"id":"2","code":"    return base ** exp"},{"id":"3","code":"print(power(3))"},{"id":"4","code":"print(power(3, 3))"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["def power(base, exp=2):","    return base ** exp","print(power(3))","print(power(3, 3))"]'::jsonb,
   'Define the function first, then demonstrate both calling styles.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Define repeat(word, times=3) that prints word * times. Call repeat("Go!") — expected: Go!Go!Go!',
   '# Define and call repeat()' || chr(10),
   'Go!Go!Go!',
   'def repeat(word, times=3): print(word * times) then repeat("Go!")',
   5, 20);

  -- ── Lesson 5.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Lambda Functions', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a lambda function in Python?',
   '0',
   '["A small anonymous function defined in a single line", "A built-in function for math operations", "A function that runs in parallel", "A function that always returns None"]'::jsonb,
   'Lambda creates a function without a name, useful for short, one-off operations.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the lambda keyword:',
   'square = ___ x: x ** 2',
   'lambda',
   '["lambda", "def", "func", "arrow"]'::jsonb,
   'Lambda functions start with the keyword lambda.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'double = lambda n: n * 2' || chr(10) || 'print(double(7))',
   '0',
   '["14", "7", "n * 2", "Error: lambda cannot be called"]'::jsonb,
   'double(7) calls the lambda with n=7. 7 * 2 = 14.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to use a lambda that adds 10 to any number:',
   '[{"id":"1","code":"add_ten = lambda x: x + 10"},{"id":"2","code":"result = add_ten(5)"},{"id":"3","code":"print(result)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["add_ten = lambda x: x + 10","result = add_ten(5)","print(result)"]'::jsonb,
   'Define the lambda, call it, then print the result.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a lambda function called cube that returns x ** 3. Print cube(4). Expected: 64',
   '# Define your lambda function' || chr(10),
   '64',
   'cube = lambda x: x ** 3 then print(cube(4))',
   5, 20);


  -- ==============================================================
  -- UNIT 6: Lists and Dictionaries
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 6: Lists & Dictionaries',
          'Work with Python''s most powerful built-in data structures',
          'indigo', 6)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Lists and Dictionaries in Python', $note$
# Lists and Dictionaries in Python

## Lists

A list holds an ordered collection of items. Items can be any type and can repeat.

```python
fruits = ["apple", "banana", "cherry"]
nums   = [1, 2, 3, 4, 5]
mixed  = [1, "two", 3.0, True]
```

**Indexing** (starts at 0):
```python
print(fruits[0])    # apple
print(fruits[-1])   # cherry (last item)
```

**Slicing**:
```python
print(nums[1:3])    # [2, 3] — index 1 up to (not including) 3
print(nums[:2])     # [1, 2]
print(nums[2:])     # [3, 4, 5]
```

**Key List Methods**:
```python
fruits.append("mango")      # add to end
fruits.remove("banana")     # remove first occurrence
fruits.pop()                # remove and return the last item
fruits.sort()               # sort in place
len(fruits)                 # count items
"cherry" in fruits          # True — membership test
```

## Dictionaries

A dictionary stores key-value pairs. Keys must be unique.

```python
person = {
    "name": "Alice",
    "age":  30,
    "city": "Accra"
}

print(person["name"])       # Alice
person["age"] = 31          # update a value
person["job"] = "Engineer"  # add a new key
del person["city"]          # delete a key
```

**Useful Dictionary Methods**:
```python
person.keys()     # dict_keys(["name", "age", "job"])
person.values()   # dict_values(["Alice", 31, "Engineer"])
person.items()    # list of (key, value) tuples
```

**Looping**:
```python
for key, value in person.items():
    print(f"{key}: {value}")
```

## List Comprehensions

A concise way to build lists:

```python
squares = [x**2 for x in range(1, 6)]
# [1, 4, 9, 16, 25]

evens = [x for x in range(10) if x % 2 == 0]
# [0, 2, 4, 6, 8]
```

## Key Takeaways
- Lists use `[]`, are ordered, and allow duplicates
- Dictionaries use `{}` with `key: value` pairs, keys are unique
- `append()` adds to a list; `pop()` removes the last item
- Loop over dict.items() to get both key and value in each iteration
$note$, 0);

  -- ── Lesson 6.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Lists in Python', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'items = ["a", "b", "c"]' || chr(10) || 'print(items[1])',
   '0',
   '["b", "a", "c", "Error: index 1 out of range"]'::jsonb,
   'List indexing starts at 0. Index 0 = "a", index 1 = "b", index 2 = "c".',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the method to add "orange" to the end of the list:',
   'fruits = ["apple", "banana"]' || chr(10) || 'fruits.___("orange")',
   'append',
   '["append", "add", "push", "insert"]'::jsonb,
   'append() adds an item to the END of the list.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does len(["x", "y", "z"]) return?',
   '0',
   '["3", "2", "0", "Error"]'::jsonb,
   'len() counts the number of items in the list. Three items → 3.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to create a list, add an item, and print the length:',
   '[{"id":"1","code":"colors = [\"red\", \"green\"]"},{"id":"2","code":"colors.append(\"blue\")"},{"id":"3","code":"print(len(colors))"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["colors = [\"red\", \"green\"]","colors.append(\"blue\")","print(len(colors))"]'::jsonb,
   'Create the list, add to it, then check and print its length.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a list called nums with values [10, 20, 30]. Print the last item using index -1.',
   '# Create list and print last item' || chr(10),
   '30',
   'nums = [10, 20, 30] then print(nums[-1]). Index -1 is always the last item.',
   5, 20);

  -- ── Lesson 6.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'List Methods', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'nums = [3, 1, 4, 1, 5]' || chr(10) || 'nums.sort()' || chr(10) || 'print(nums[0])',
   '0',
   '["1", "3", "5", "4"]'::jsonb,
   'sort() reorders the list in ascending order. Smallest is 1, which becomes index 0.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the method to remove the last item from the list:',
   'items = [1, 2, 3]' || chr(10) || 'items.___',
   'pop()',
   '["pop()", "remove()", "delete()", "discard()"]'::jsonb,
   'pop() removes and returns the last element. pop(i) removes at index i.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which expression checks if "mango" is in the list fruits?',
   '0',
   '["\"mango\" in fruits", "fruits.contains(\"mango\")", "fruits.has(\"mango\")", "find(fruits, \"mango\")"]'::jsonb,
   'Python''s in operator tests membership: "item" in list returns True or False.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to build, sort, and print a list of scores:',
   '[{"id":"1","code":"scores = [85, 92, 70, 88]"},{"id":"2","code":"scores.sort()"},{"id":"3","code":"print(scores)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["scores = [85, 92, 70, 88]","scores.sort()","print(scores)"]'::jsonb,
   'Build the list, sort it in place, then print it.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Given nums = [5, 2, 8, 1], sort the list and print the maximum value (last after sort).',
   'nums = [5, 2, 8, 1]' || chr(10) || '# Sort and print the largest number' || chr(10),
   '8',
   'nums.sort() then print(nums[-1]) — the last item after sorting is the largest.',
   5, 20);

  -- ── Lesson 6.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Dictionaries', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the output of:' || chr(10) || 'person = {"name": "Alice", "age": 30}' || chr(10) || 'print(person["name"])',
   '0',
   '["Alice", "name", "30", "Error: key not found"]'::jsonb,
   'Dictionary values are accessed with their key in square brackets.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the syntax to add a new key "city" with value "Accra" to the dict:',
   'person = {"name": "Alice"}' || chr(10) || 'person[___] = "Accra"',
   '"city"',
   '[""city"", "city", "City", "new"]'::jsonb,
   'Add a new key by assigning to dict["new_key"] = value.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which method returns all the keys of a dictionary?',
   '0',
   '["dict.keys()", "dict.all()", "dict.list()", "dict.index()"]'::jsonb,
   'keys() returns a view of all keys in the dictionary.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to create a dictionary, update a value, and print it:',
   '[{"id":"1","code":"car = {\"brand\": \"Toyota\", \"year\": 2020}"},{"id":"2","code":"car[\"year\"] = 2024"},{"id":"3","code":"print(car[\"year\"])"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["car = {\"brand\": \"Toyota\", \"year\": 2020}","car[\"year\"] = 2024","print(car[\"year\"])"]'::jsonb,
   'Create the dict, update an existing key, then print the updated value.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Create a dictionary with keys "x" and "y" set to 10 and 20. Print their sum. Expected: 30',
   '# Create dict and print sum of x and y' || chr(10),
   '30',
   'd = {"x": 10, "y": 20} then print(d["x"] + d["y"])',
   5, 20);

  -- ── Lesson 6.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'List Comprehensions', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does this list comprehension produce?' || chr(10) || '[x * 2 for x in range(1, 4)]',
   '0',
   '["[2, 4, 6]", "[1, 2, 3]", "[2, 4, 6, 8]", "[x*2, x*2, x*2]"]'::jsonb,
   'range(1, 4) generates 1, 2, 3. Each is multiplied by 2: [2, 4, 6].',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the list comprehension to get squares of numbers 1-5:',
   'squares = [x ** ___ for x in range(1, 6)]',
   '2',
   '["2", "x", "2.0", "square"]'::jsonb,
   'x ** 2 computes the square of x. The comprehension builds [1, 4, 9, 16, 25].',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the if clause do inside a list comprehension?',
   '0',
   '["Filters items — only includes items where the condition is True", "Raises an error if the condition is False", "Runs the comprehension twice", "It has no effect"]'::jsonb,
   'Adding if condition filters which items get included in the resulting list.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these lines to build a list of even numbers from 0 to 9 using a comprehension:',
   '[{"id":"1","code":"# Build list of even numbers"},{"id":"2","code":"evens = [x for x in range(10) if x % 2 == 0]"},{"id":"3","code":"print(evens)"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["# Build list of even numbers","evens = [x for x in range(10) if x % 2 == 0]","print(evens)"]'::jsonb,
   'The comprehension is a single expression — comment, then comprehension, then print.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Use a list comprehension to create a list of the first 5 squares (1, 4, 9, 16, 25) and print it.',
   '# Use a list comprehension' || chr(10),
   '[1, 4, 9, 16, 25]',
   'squares = [x**2 for x in range(1, 6)] then print(squares)',
   5, 20);

END $$;