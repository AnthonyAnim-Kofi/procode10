-- ============================================================
-- REAL RUBY CURRICULUM
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

  -- Prefer slug 'ruby' (used by the app)
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug = 'ruby'
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('Ruby', 'ruby', '💎', 'A dynamic, open-source programming language with a focus on simplicity and productivity.')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with Ruby
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Write your first Ruby programs and understand dynamic typing', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to Ruby', $note$
# Introduction to Ruby

Ruby is a dynamic, open-source programming language created by Yukihiro "Matz" Matsumoto. It was designed to make programming fun and productive, reading much like plain English.

## Your First Program

```ruby
puts "Hello, World!"

```
Breaking it down:
 * puts — The standard way to print output in Ruby. It stands for "put string" and automatically adds a new line at the end.
 * Unlike C++ or Java, there is **no need for a main function**, semicolons, or even parentheses for method calls (most of the time).
## Variables and Types
Ruby is **dynamically typed**. You do not need to declare a variable's type, and you do not use keywords like let or var to create one.
```ruby
age = 25
price = 19.99
name = "Alice"
is_active = true

```
## String Interpolation
To inject a variable directly into a string, wrap it in #{}. This only works with **double-quoted** strings.
```ruby
name = "Anthony"
puts "Welcome, #{name}!"

```
## User Input
You can get input from the user using gets. Because the user presses "Enter", gets includes a newline character. Use .chomp to remove it.
```ruby
puts "What is your name?"
user_name = gets.chomp
puts "Hello, #{user_name}!"

```
## Key Takeaways
 * No semicolons or boilerplate main functions are needed.
 * puts prints text with a newline.
 * Variables are created simply by assigning a value (name = "Bob").
 * Use #{variable} inside double quotes to interpolate values.
   $note$, 0);
   -- Lesson 1.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Hello, Ruby!', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which command is used to print text to the console with a new line at the end in Ruby?',
   '0',
   '["puts", "print", "echo", "console.log"]'::jsonb,
   'puts (put string) automatically adds a newline. print does not.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the statement to print a greeting:',
   '___ "Hello, Ruby!"',
   'puts',
   '["puts", "write", "display", "out"]'::jsonb,
   'Use puts to display output in Ruby.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Do you need to write a main() function to run a basic Ruby script?',
   '0',
   '["No, Ruby scripts run top-to-bottom automatically", "Yes, it is required", "Only for object-oriented code", "Yes, but it is called start()"]'::jsonb,
   'Ruby is a scripting language. It executes statements directly as it reads the file.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the simplest Ruby program to output a message:',
   '[{"id":"1","code":"# This is a comment"},{"id":"2","code":"puts \"Starting...\""}]'::jsonb,
   '["1","2"]'::jsonb,
   '["# This is a comment","puts \"Starting...\""]'::jsonb,
   'Ruby uses # for comments and puts for printing.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write a Ruby program that prints exactly: Learning Ruby',
   '# Write your code here',
   'Learning Ruby',
   'puts "Learning Ruby"',
   5, 20);
   -- Lesson 1.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Variables and Dynamic Typing', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you declare a new variable in Ruby?',
   '0',
   '["You just assign a value to a name, e.g., score = 100", "Using the var keyword", "Using the let keyword", "By stating the type, e.g., int score = 100"]'::jsonb,
   'Ruby is dynamically typed and doesn''t use declaration keywords for standard variables.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Create a variable named age and set it to 20:',
   '___ = 20',
   'age',
   '["age", "var age", "let age", "int age"]'::jsonb,
   'Just type the variable name and assign it.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Because Ruby is dynamically typed, what happens if you do: x = 5, then x = "Hello"?',
   '0',
   '["It works perfectly; the variable simply changes type", "It throws a compiler error", "The program crashes at runtime", "It converts \"Hello\" to a number"]'::jsonb,
   'Variables in Ruby do not have fixed types. They just point to objects, and can point to different types of objects at any time.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to assign a string, reassign it to an integer, and print it:',
   '[{"id":"1","code":"data = \"Text\""},{"id":"2","code":"data = 42"},{"id":"3","code":"puts data"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["data = \"Text\"","data = 42","puts data"]'::jsonb,
   'Declare as string, reassign to integer, print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Declare a variable count equal to 5. Update it to 6, and print it.',
   '# Declare, update, print',
   '6',
   'count = 5; count = 6; puts count',
   5, 20);
   -- Lesson 1.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'String Interpolation', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which syntax is used to interpolate (inject) a variable into a string in Ruby?',
   '0',
   '["#{variable}", "${variable}", "$variable", "\\(variable)"]'::jsonb,
   'Example: "My name is #{name}".',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the interpolation to print the score:',
   'puts "Your score is ___"',
   '#{score}',
   '["#{score}", "${score}", "(score)", "$score"]'::jsonb,
   'Ruby uses the hash/pound sign followed by curly braces.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is an important rule about string interpolation in Ruby?',
   '0',
   '["It only works with double-quoted strings (\"\"), not single-quoted strings ('''')", "It only works with integers", "It requires the printf command", "It cannot evaluate math expressions"]'::jsonb,
   'puts ''#{name}'' literally prints #{name}. puts "#{name}" evaluates it.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to greet a user using string interpolation:',
   '[{"id":"1","code":"name = \"Alice\""},{"id":"2","code":"age = 30"},{"id":"3","code":"puts \"Hi #{name}, age #{age}\""}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["name = \"Alice\"","age = 30","puts \"Hi #{name}, age #{age}\""]'::jsonb,
   'Declare variables, then print the interpolated double-quoted string.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given x = 10. Print exactly "x is 10" using string interpolation.',
   'x = 10' || chr(10) || '# Interpolate and print',
   'x is 10',
   'puts "x is #{x}"',
   5, 20);
   -- Lesson 1.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Input and Chomp', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which method is used to get a line of string input from the user in Ruby?',
   '0',
   '["gets", "input()", "read()", "console.read"]'::jsonb,
   'gets stands for "get string".',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the method chain used to remove the trailing newline from user input:',
   'name = gets.___',
   'chomp',
   '["chomp", "strip", "trim", "clean"]'::jsonb,
   'When you hit Enter, gets captures "Alice\n". .chomp chops off the \n.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If the user types a number, gets still returns a String. How do you convert it to an integer?',
   '0',
   '["Using the .to_i method (e.g., gets.to_i)", "Using Integer(gets)", "By casting (int)gets", "It automatically converts"]'::jsonb,
   'Ruby objects have convenient conversion methods like .to_i (integer) and .to_s (string).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to safely read and print an integer from a string:',
   '[{"id":"1","code":"input = \"42\\n\""},{"id":"2","code":"clean_string = input.chomp"},{"id":"3","code":"number = clean_string.to_i"},{"id":"4","code":"puts number"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["input = \"42\\n\"","clean_string = input.chomp","number = clean_string.to_i","puts number"]'::jsonb,
   'Input with newline, chomp to clean, convert to integer, print.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Convert the string str = "99" to an integer using .to_i, add 1, and print the result. Expected: 100',
   'str = "99"' || chr(10) || '# Convert, add, and print',
   '100',
   'puts str.to_i + 1',
   5, 20);
   -- ==============================================================
   -- UNIT 2: Control Flow
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 2: Control Flow', 'Make decisions using if, unless, and iterate with times and each', 'green', 2)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Control Flow in Ruby', $note$
# Control Flow in Ruby
Ruby provides very expressive ways to control the flow of your program.
## if / elsif / else
Notice the spelling of elsif. No parentheses are needed around conditions. The block must be closed with the end keyword.
```ruby
score = 85

if score >= 90
  puts "A"
elsif score >= 80
  puts "B"
else
  puts "F"
end

```
## Statement Modifiers (Inline Conditionals)
Ruby allows you to put the condition at the end of a line to make it read like English.
```ruby
puts "You passed!" if score >= 50

```
## Unless
unless is the exact opposite of if. It means "if not".
```ruby
is_admin = false
puts "Access Denied" unless is_admin
# Same as: puts "Access Denied" if !is_admin

```
## Iteration and Loops
While Ruby has while and for loops, Rubyists rarely use them. Instead, they use iteration methods.
**The .times loop:**
```ruby
5.times do
  puts "Hello!"
end

```
**The .each loop (with ranges):**
```ruby
(1..3).each do |i|
  puts "Number #{i}"
end

```
*Note: (1..3) is a range from 1 to 3 inclusive. |i| is block syntax assigning the current number to the variable i.*
## Key Takeaways
 * Use end to close if statements and loops.
 * elsif has no second 'e'.
 * unless is a more readable way to write if !.
 * Ruby favors methods like .times and .each over traditional for loops.
   $note$, 0);
   -- Lesson 2.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'If, Elsif, and Else', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What keyword is required to close an if block in Ruby?',
   '0',
   '["end", "}", "endif", "stop"]'::jsonb,
   'Ruby uses end instead of closing curly braces } for control structures.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword for an alternative condition (else if):',
   'if x > 10' || chr(10) || '  puts "Big"' || chr(10) || '___ x > 5' || chr(10) || '  puts "Medium"' || chr(10) || 'end',
   'elsif',
   '["elsif", "elseif", "else if", "elif"]'::jsonb,
   'In Ruby, it is spelled exactly elsif without the second "e".',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a "statement modifier" in Ruby?',
   '0',
   '["Placing the if condition at the end of a single line of code (e.g., puts \"Hi\" if active)", "A way to modify a variable", "A special class", "A keyword that changes true to false"]'::jsonb,
   'This reads like plain English and saves you from writing if ... end for simple checks.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange an if/else block to check a password:',
   '[{"id":"1","code":"pass = \"1234\""},{"id":"2","code":"if pass == \"1234\""},{"id":"3","code":"  puts \"Welcome\""},{"id":"4","code":"else"},{"id":"5","code":"  puts \"Denied\"\\nend"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["pass = \"1234\"","if pass == \"1234\"","  puts \"Welcome\"","else","  puts \"Denied\"\\nend"]'::jsonb,
   'Declare, open if, print welcome, else, print denied and end.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print "Even" if num = 8 is divisible by 2, else print "Odd". Close with end. Expected: Even',
   'num = 8' || chr(10) || '# Write if/else',
   'Even',
   'if num % 2 == 0; puts "Even"; else; puts "Odd"; end',
   5, 20);
   -- Lesson 2.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Unless', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the unless keyword do in Ruby?',
   '0',
   '["It executes code ONLY if the condition is false (the exact opposite of if)", "It executes code if the condition is true", "It acts like a while loop", "It throws an error"]'::jsonb,
   'unless empty is often much more readable than if !empty.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the inline statement to print an error if the user is NOT valid:',
   'puts "Error" ___ valid',
   'unless',
   '["unless", "if", "not", "except"]'::jsonb,
   'unless can be used as an inline modifier just like if.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Is it good practice to use else with an unless statement in Ruby?',
   '0',
   '["No, it is highly discouraged because it makes the logic confusing (unless...else is a double negative)", "Yes, it is the standard way to write Ruby", "Yes, but only for numbers", "Ruby doesn''t allow else with unless"]'::jsonb,
   'If you need an else branch, you should just write a standard if...else block.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the block using unless:',
   '[{"id":"1","code":"locked = true"},{"id":"2","code":"unless locked"},{"id":"3","code":"  puts \"Opening door\""},{"id":"4","code":"end"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["locked = true","unless locked","  puts \"Opening door\"","end"]'::jsonb,
   'Declare variable, open unless, print statement, end.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use the inline modifier to print "Go" unless the boolean red_light = false. Expected: Go',
   'red_light = false' || chr(10) || '# Print Go using inline unless',
   'Go',
   'puts "Go" unless red_light',
   5, 20);
   -- Lesson 2.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Loops (times)', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How does an integer know how to loop itself in Ruby?',
   '0',
   '["Because everything in Ruby is an Object, integers have methods like .times", "It relies on a global for function", "It is evaluated by the compiler as a while loop", "Integers cannot loop themselves"]'::jsonb,
   '5.times { puts "Hi" } works because 5 is an instance of the Integer class, which has a times method.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to execute a block 3 times:',
   '3.___ do' || chr(10) || '  puts "Run"' || chr(10) || 'end',
   'times',
   '["times", "loop", "each", "run"]'::jsonb,
   'The .times method is the most Ruby-esque way to do something N times.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If you use 3.times do |i|, what values will i take during the loop?',
   '0',
   '["0, 1, 2", "1, 2, 3", "3, 2, 1", "nil"]'::jsonb,
   'The block variable i is zero-indexed, exactly like iterating through an array.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a loop that prints 0 and 1:',
   '[{"id":"1","code":"2.times do |i|"},{"id":"2","code":"  puts i"},{"id":"3","code":"end"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["2.times do |i|","  puts i","end"]'::jsonb,
   'Start loop with block variable, print it, end.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use 3.times to print the word "Hello" three times on separate lines.',
   '# Write times loop',
   'Hello' || chr(10) || 'Hello' || chr(10) || 'Hello',
   '3.times { puts "Hello" }',
   5, 20);
   -- Lesson 2.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Ranges and Each', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the range (1..5) represent in Ruby?',
   '0',
   '["A sequence of numbers from 1 to 5 INCLUSIVE", "A sequence from 1 to 4 (exclusive)", "An array of two numbers [1, 5]", "A floating point limit"]'::jsonb,
   'Two dots .. is an inclusive range. Three dots ... is an exclusive range (1...5 means 1 to 4).',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the method used to iterate over a range or array:',
   '(1..3).___ do |num|' || chr(10) || '  puts num' || chr(10) || 'end',
   'each',
   '["each", "loop", "times", "for"]'::jsonb,
   '.each is the universal iteration method in Ruby. It passes each element to the block.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What are the pipes | | used for in a Ruby block (e.g., do |x|)?',
   '0',
   '["They define block parameters, catching the value passed by the iteration method (like .each)", "They indicate logical OR", "They format the output", "They make the loop run backwards"]'::jsonb,
   'If .each is handing out numbers, |x| catches the number so you can use it inside the block.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange code to iterate through an exclusive range (1 to 2):',
   '[{"id":"1","code":"(1...3).each do |num|"},{"id":"2","code":"  puts num"},{"id":"3","code":"end"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["(1...3).each do |num|","  puts num","end"]'::jsonb,
   'Range with each and block var, print, end.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use (1..3).each do |n| to print numbers 1, 2, 3 on separate lines.',
   '# Write each loop',
   '1' || chr(10) || '2' || chr(10) || '3',
   '(1..3).each do |n|; puts n; end',
   5, 20);
   -- ==============================================================
   -- UNIT 3: Methods and Blocks
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 3: Methods & Blocks', 'Define methods, use implicit returns, and master Ruby blocks', 'orange', 3)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Methods and Blocks', $note$
# Methods and Blocks
## Defining Methods
Methods are defined using the def keyword and closed with end.
```ruby
def greet(name)
  puts "Hello, #{name}!"
end

greet("Anthony")
# Note: Parentheses are optional when calling! greet "Anthony" works too.

```
## Implicit Return
In Ruby, **you rarely see the return keyword.** A method automatically evaluates and returns the result of the *last line of code* executed in the method.
```ruby
def add(a, b)
  a + b # This value is automatically returned
end

sum = add(5, 10)

```
## Default Parameters
```ruby
def say_hi(name = "Guest")
  puts "Hi, #{name}"
end

```
## Blocks and yield
A "Block" is a chunk of code passed to a method. Blocks can be written with { ... } (for single lines) or do ... end (for multiple lines).
Methods can accept a block implicitly and execute it using the yield keyword.
```ruby
def my_timer
  puts "Starting timer"
  yield # This runs the block passed to the method!
  puts "Timer finished"
end

my_timer do
  puts "Doing heavy work..."
end
# Output:
# Starting timer
# Doing heavy work...
# Timer finished

```
## Key Takeaways
 * Use def to define methods.
 * The last line of a method is implicitly returned.
 * A block is just anonymous code passed to a method.
 * yield pauses the method, runs the block, then resumes the method.
   $note$, 0);
   -- Lesson 3.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Defining Methods', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which keyword is used to declare a method in Ruby?',
   '0',
   '["def", "func", "fn", "method"]'::jsonb,
   'def stands for define.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to properly close a method definition:',
   'def say_hi' || chr(10) || '  puts "Hi"' || chr(10) || '___',
   'end',
   '["end", "}", "done", "close"]'::jsonb,
   'Almost all structures in Ruby (methods, classes, loops, ifs) are closed with end.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Is it necessary to use parentheses when calling a method in Ruby (e.g., puts("Hi"))?',
   '0',
   '["No, parentheses are optional and often omitted for simple method calls", "Yes, they are strictly required", "Only if the method has no parameters", "Only when calling core library methods"]'::jsonb,
   'Ruby allows puts "Hi" or add 2, 3. However, parentheses are recommended when chaining methods or for complex logic to prevent ambiguity.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a complete method with a parameter:',
   '[{"id":"1","code":"def double(n)"},{"id":"2","code":"  puts n * 2"},{"id":"3","code":"end"},{"id":"4","code":"double(5)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["def double(n)","  puts n * 2","end","double(5)"]'::jsonb,
   'Method def with parameter, body, end, call method.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Define def greet(name) to puts "Hi, #{name}". Call it with "Bob". Expected: Hi, Bob',
   '# Write method and call',
   'Hi, Bob',
   'def greet(name); puts "Hi, #{name}"; end; greet("Bob")',
   5, 20);
   -- Lesson 3.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Implicit Return', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does "implicit return" mean in Ruby?',
   '0',
   '["A method automatically evaluates and returns the value of its very last line of code, without needing the return keyword", "It returns nil randomly", "Methods return the first variable declared", "You must use the return keyword"]'::jsonb,
   'Using return is considered un-idiomatic in Ruby unless you are returning early from a method.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'What will this method return?',
   'def get_number' || chr(10) || '  5' || chr(10) || '  ___' || chr(10) || 'end',
   '10',
   '["10", "5", "nil", "15"]'::jsonb,
   'The last evaluated expression is 10. The 5 is evaluated but ignored.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If the last line of a method is puts "Done", what does the method return?',
   '0',
   '["nil, because the puts method itself always returns nil", "The string \"Done\"", "True", "An error"]'::jsonb,
   'puts outputs to the console but returns nil. If you want to return the string, just write "Done" on the last line.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a method that adds two numbers and returns the result implicitly:',
   '[{"id":"1","code":"def add(a, b)"},{"id":"2","code":"  a + b"},{"id":"3","code":"end"},{"id":"4","code":"puts add(3, 4)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["def add(a, b)","  a + b","end","puts add(3, 4)"]'::jsonb,
   'Method def, implicit return math, end, puts call.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write def get_value, on the next line write 42, then end. Print the result of get_value. Expected: 42',
   '# Write method and puts call',
   '42',
   'def get_value; 42; end; puts get_value',
   5, 20);
   -- Lesson 3.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Blocks and Yield', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a Block in Ruby?',
   '0',
   '["An anonymous chunk of code enclosed in {} or do...end that can be passed to a method", "A local variable", "A type of array", "A syntax error"]'::jsonb,
   'When you write 3.times { puts "Hi" }, the { puts "Hi" } is the block.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword inside a method that executes the block passed to it:',
   'def wrapper' || chr(10) || '  puts "Before"' || chr(10) || '  ___' || chr(10) || 'end',
   'yield',
   '["yield", "call", "block", "execute"]'::jsonb,
   'yield halts the method, runs the block, and then resumes the method.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if a method calls yield but no block was passed to the method when it was invoked?',
   '0',
   '["The program raises a LocalJumpError (no block given)", "It ignores the yield", "It returns nil", "It creates an empty block"]'::jsonb,
   'You can safely check if a block was provided using the block_given? keyword.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the definition and execution of a method yielding to a block:',
   '[{"id":"1","code":"def run_it"},{"id":"2","code":"  yield"},{"id":"3","code":"end"},{"id":"4","code":"run_it { puts \"Running!\" }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["def run_it","  yield","end","run_it { puts \"Running!\" }"]'::jsonb,
   'Method def, yield, end, call with a brace block.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write def run_twice, inside it write yield twice, then end. Call run_twice { puts "Go" }. Expected: Go \n Go',
   '# Define method with yield, then call it',
   'Go' || chr(10) || 'Go',
   'def run_twice; yield; yield; end; run_twice { puts "Go" }',
   5, 20);
   -- Lesson 3.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Yielding with Arguments', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How does .each pass the current array element into the block?',
   '0',
   '["The .each method calls yield(element). The block catches it using |variable|", "It uses global variables", "It relies on return values", "It passes it as a string"]'::jsonb,
   'You can yield data from your method to the block: yield("Alice").',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to catch the argument yielded to the block:',
   'def say_name' || chr(10) || '  yield("Bob")' || chr(10) || 'end' || chr(10) || 'say_name { |___| puts n }',
   'n',
   '["n", "Bob", "yield", "var"]'::jsonb,
   'The block uses |n| to accept the string "Bob".',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Can a method capture a block as a variable instead of using yield?',
   '0',
   '["Yes, by placing &block as the last parameter in the method signature (e.g., def run(&block))", "No, yield is the only way", "Yes, using the var block syntax", "Only in classes"]'::jsonb,
   'Once captured as &block, you can execute it by calling block.call.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to yield a name to a block:',
   '[{"id":"1","code":"def pass_name"},{"id":"2","code":"  yield(\"Alice\")"},{"id":"3","code":"end"},{"id":"4","code":"pass_name { |n| puts n }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["def pass_name","  yield(\"Alice\")","end","pass_name { |n| puts n }"]'::jsonb,
   'Method, yield with arg, end, call with block catching arg.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write def calc, yield 5 and 10 yield(5, 10), end. Call calc { |a, b| puts a + b }. Expected: 15',
   '# Method yielding args, call with block adding them',
   '15',
   'def calc; yield(5, 10); end; calc { |a, b| puts a + b }',
   5, 20);
   -- ==============================================================
   -- UNIT 4: Arrays and Hashes
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 4: Arrays & Hashes', 'Store and manipulate collections using Arrays, Hashes, and Symbols', 'purple', 4)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Collections in Ruby', $note$
# Arrays and Hashes
## Arrays
An array is an ordered, dynamically-sized list of items.
```ruby
nums = [1, 2, 3]

# Adding items
nums.push(4)
nums << 5     # The << operator (shovel) is identical to push!

puts nums[0]  # 1
puts nums[-1] # 5 (Negative indices read from the end!)

```
## Hashes
A Hash is a collection of Key-Value pairs (like a Dictionary or Map).
```ruby
# The old "hash rocket" syntax
scores = { "Alice" => 100, "Bob" => 85 }
puts scores["Alice"]

```
## Symbols (:symbol)
Symbols look like strings with a colon at the front: :name, :age, :status.
They are lightweight, immutable strings. In Ruby, if you use the same symbol multiple times, it references the exact same object in memory, making them incredibly fast.
Symbols are the preferred keys for Hashes:
```ruby
# Modern JSON-style Hash syntax (the keys are automatically Symbols!)
user = { name: "Anthony", age: 25 }

puts user[:name] # "Anthony"

```
## Iterating with .each
Iterating over Hashes yields both the key and the value to the block.
```ruby
user.each do |key, value|
  puts "#{key} is #{value}"
end

```
## Key Takeaways
 * Use the shovel operator << to quickly append to arrays.
 * Negative indices array[-1] grab the last element.
 * Symbols :like_this are memory-efficient strings, best used as Hash keys.
 * Hash iteration uses |key, value|.
   $note$, 0);
   -- Lesson 4.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Arrays', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the shovel operator << do to an array in Ruby?',
   '0',
   '["It appends an element to the end of the array (same as .push)", "It removes the last element", "It shifts all elements left", "It bitwise shifts the memory"]'::jsonb,
   'arr << 5 is incredibly common in Ruby for adding items to an array.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'What index is used to cleanly access the very LAST element of an array?',
   'last_item = arr[___]',
   '-1',
   '["-1", "last", "end", "0"]'::jsonb,
   'Ruby supports negative indexing. -1 is the last, -2 is the second to last.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which method tells you how many items are in a Ruby array?',
   '0',
   '[".length, .size, or .count (they all do essentially the same thing)", ".size() only", ".capacity", ".items"]'::jsonb,
   'Ruby is built for developer happiness, so it provides aliases. .length and .size are identical.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange to create an array, append an item, and print the last element:',
   '[{"id":"1","code":"data = [10, 20]"},{"id":"2","code":"data << 30"},{"id":"3","code":"puts data[-1]"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["data = [10, 20]","data << 30","puts data[-1]"]'::jsonb,
   'Declare array, shovel 30, print index -1.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create arr = [5]. Use << to append 10. Print arr[1]. Expected: 10',
   '# Array, append, print',
   '10',
   'arr = [5]; arr << 10; puts arr[1]',
   5, 20);
   -- Lesson 4.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Hashes', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a Hash in Ruby?',
   '0',
   '["A collection of Key-Value pairs, similar to a Dictionary in other languages", "A cryptographic function", "An array of numbers", "A block of code"]'::jsonb,
   'Hashes allow fast lookups of data based on a key.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the "hash rocket" syntax to map a string key to a value:',
   'map = { "A" ___ 1 }',
   '=>',
   '["=>", ":", "->", "="]'::jsonb,
   'The hash rocket => is the traditional way to associate keys and values, especially if keys are strings.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does a Hash return if you request a key that does not exist (e.g., map["missing"])?',
   '0',
   '["nil", "It throws an error/exception", "0", "An empty string"]'::jsonb,
   'Ruby gracefully returns nil unless you configure the hash with a different default value using Hash.new(default).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to create a hash and update a value:',
   '[{"id":"1","code":"scores = { \"Bob\" => 80 }"},{"id":"2","code":"scores[\"Bob\"] = 90"},{"id":"3","code":"puts scores[\"Bob\"]"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["scores = { \"Bob\" => 80 }","scores[\"Bob\"] = 90","puts scores[\"Bob\"]"]'::jsonb,
   'Declare hash, reassign key, print key.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create h = { "A" => 1 }. Print the value of "A". Expected: 1',
   '# Hash and print',
   '1',
   'h = { "A" => 1 }; puts h["A"]',
   5, 20);
   -- Lesson 4.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Symbols', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a Symbol in Ruby (e.g., :status)?',
   '0',
   '["An immutable, memory-efficient string. The same symbol always refers to the exact same object in memory", "A secret password", "A type of hash", "A function pointer"]'::jsonb,
   'If you use "name" 100 times, Ruby creates 100 string objects. If you use :name 100 times, Ruby references the same 1 object.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the modern JSON-style hash syntax, which automatically creates a Symbol key :id:',
   'user = { ___ 5 }',
   'id:',
   '["id:", ":id =>", "id =", "id =>"]'::jsonb,
   '{ id: 5 } is syntactic sugar for { :id => 5 }.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If you create a hash user = { age: 25 }, how do you access the value?',
   '0',
   '["user[:age]", "user[\"age\"]", "user.age", "user[age]"]'::jsonb,
   'Because the JSON-style syntax creates a Symbol key, you must query the hash using the Symbol :age.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code using the modern Symbol hash syntax:',
   '[{"id":"1","code":"config = {"},{"id":"2","code":"  theme: \"dark\""},{"id":"3","code":"}"},{"id":"4","code":"puts config[:theme]"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["config = {","  theme: \"dark\"","}","puts config[:theme]"]'::jsonb,
   'Open hash, modern symbol key, close hash, access via :symbol.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Create opt = { active: true }. Print opt[:active]. Expected: true',
   '# Hash with symbol and print',
   'true',
   'opt = { active: true }; puts opt[:active]',
   5, 20);
   -- Lesson 4.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Iterating Collections', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'When you use .each on a Hash, how many block variables do you need to catch the data?',
   '0',
   '["Two (e.g., |key, value|)", "One (it passes an array)", "Three", "None"]'::jsonb,
   'hash.each do |k, v| is the standard way to iterate over keys and values simultaneously.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the block variables to iterate over a Hash:',
   'map.each do |___, value|' || chr(10) || '  puts key' || chr(10) || 'end',
   'key',
   '["key", "k", "index", "id"]'::jsonb,
   'The first variable catches the Key, the second catches the Value.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the .each_with_index method do on an Array?',
   '0',
   '["It yields the array element AND its index number to the block |item, index|", "It sorts the array", "It creates a hash", "It removes the index"]'::jsonb,
   'This is useful when you need both the value and its position (0, 1, 2...).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to print all values in a hash:',
   '[{"id":"1","code":"h = { a: 1, b: 2 }"},{"id":"2","code":"h.each do |k, v|"},{"id":"3","code":"  puts v"},{"id":"4","code":"end"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["h = { a: 1, b: 2 }","h.each do |k, v|","  puts v","end"]'::jsonb,
   'Declare hash, each with |k,v|, print v, end.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Given h = { a: 7 }. Use .each with |k, v| to print the value v. Expected: 7',
   'h = { a: 7 }' || chr(10) || '# Iterate and print value',
   '7',
   'h.each do |k, v| puts v end',
   5, 20);
   -- ==============================================================
   -- UNIT 5: Object-Oriented Ruby
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 5: Object-Oriented Ruby', 'Build classes, manage state with instance variables, and use inheritance', 'teal', 5)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Object-Oriented Ruby', $note$
# Object-Oriented Ruby
Everything in Ruby is an Object, even simple numbers!
## Classes and Instantiation
You define a class using the class keyword. To create an object, you call .new on the class.
```ruby
class Car
  def honk
    puts "Beep!"
  end
end

my_car = Car.new
my_car.honk

```
## The initialize Method
When you call Class.new, Ruby automatically looks for a method named initialize to set up the object. (This is the constructor).
```ruby
class User
  def initialize(name)
    @name = name # The @ symbol makes it an Instance Variable
  end
end

bob = User.new("Bob")

```
## Instance Variables (@var)
Variables that start with an @ symbol belong to the specific instance of the object. They are available anywhere inside the class.
However, **instance variables are completely private from the outside.**
```ruby
# puts bob.@name # ERROR! You cannot access @name directly.

```
## Getters, Setters, and attr_accessor
To read or change an instance variable from the outside, you need methods. Ruby provides a macro to generate these methods automatically!
 * attr_reader :name (Generates a getter)
 * attr_writer :name (Generates a setter)
 * attr_accessor :name (Generates both!)
```ruby
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = User.new("Bob")
puts bob.name   # Uses the generated getter
bob.name = "Al" # Uses the generated setter

```
## Inheritance (<)
A class can inherit behavior from a parent class using the < symbol.
```ruby
class Animal
  def breathe; puts "Inhale"; end
end

class Dog < Animal
  def bark; puts "Woof"; end
end

dog = Dog.new
dog.breathe # Inherited!

```
$note$, 0);
-- Lesson 5.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Classes and initialize', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the name of the special method that acts as the constructor in Ruby?',
'0',
'["initialize", "constructor", "new", "start"]'::jsonb,
'When you call Class.new, Ruby creates the memory space and then immediately calls the initialize method.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to create a new instance of the App class:',
'my_app = App.___()',
'new',
'["new", "init", "create", "start"]'::jsonb,
'In Ruby, you call .new on the Class constant.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is true about class names in Ruby?',
'0',
'["They must start with a Capital letter (they are Constants)", "They must start with a lowercase letter", "They must use underscores", "They must be strings"]'::jsonb,
'class User is correct. class user will throw an error.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the class definition and instantiation:',
'[{"id":"1","code":"class Bot"},{"id":"2","code":"  def initialize(id)"},{"id":"3","code":"    puts id"},{"id":"4","code":"  end\nend"},{"id":"5","code":"b = Bot.new(5)"}]'::jsonb,
'["1","2","3","4","5"]'::jsonb,
'["class Bot","  def initialize(id)","    puts id","  end\nend","b = Bot.new(5)"]'::jsonb,
'Class open, init method, body, ends, instantiation.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create class Box, add def initialize, puts "Made", end, end. Call Box.new. Expected: Made',
'# Write class and instantiate',
'Made',
'class Box; def initialize; puts "Made"; end; end; Box.new',
5, 20);
-- Lesson 5.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Instance Variables', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you denote that a variable is an "Instance Variable" that belongs to the object state?',
'0',
'["By prefixing it with an @ symbol (e.g., @name)", "By using this.name", "By using self.name", "By marking it private"]'::jsonb,
'@name is available to any method inside the class instance.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the assignment of an instance variable inside initialize:',
'def initialize(age)' || chr(10) || '  ___age = age' || chr(10) || 'end',
'@',
'["@", "$", "self.", "this."]'::jsonb,
'The @ symbol is mandatory for instance variables in Ruby.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you access an instance variable directly from outside the class (e.g., puts my_object.@name)?',
'0',
'["No, instance variables are strictly private from the outside. You must use a getter method", "Yes, anytime", "Yes, but only if it is a string", "No, they are destroyed after initialize"]'::jsonb,
'Ruby enforces encapsulation. You cannot touch @var from the outside.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a class that saves an instance variable and reads it via a custom method:',
'[{"id":"1","code":"class Item"},{"id":"2","code":"  def initialize(price)"},{"id":"3","code":"    @price = price\n  end"},{"id":"4","code":"  def get_price\n    @price\n  end\nend"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["class Item","  def initialize(price)","    @price = price\n  end","  def get_price\n    @price\n  end\nend"]'::jsonb,
'Class open, init, set @price/end, getter method/end.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given class A; def initialize; @x = 5; end; def get; @x; end; end. Make A.new, call .get, and puts the result. Expected: 5',
'class A' || chr(10) || '  def initialize; @x = 5; end' || chr(10) || '  def get; @x; end' || chr(10) || 'end' || chr(10) || '# Instantiate, get, and puts',
'5',
'puts A.new.get',
5, 20);
-- Lesson 5.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'attr_accessor', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does attr_accessor :name do in a Ruby class?',
'0',
'["It automatically generates both a getter (def name) and a setter (def name=) method for the @name instance variable", "It makes the variable private", "It creates a database column", "It initializes the object"]'::jsonb,
'It saves you from writing boring boilerplate getter and setter methods.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to generate ONLY a getter (read-only) method for @score:',
'attr____ :score',
'reader',
'["reader", "accessor", "writer", "getter"]'::jsonb,
'attr_reader creates def score; @score; end.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What type of argument do attr_accessor, attr_reader, and attr_writer expect?',
'0',
'["A Symbol (e.g., :name)", "A String (e.g., \"name\")", "An Instance Variable (e.g., @name)", "A Class"]'::jsonb,
'You pass the name of the attribute as a Symbol, and Ruby writes the methods for the @ variable under the hood.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the class to use attr_accessor and update the property:',
'[{"id":"1","code":"class User"},{"id":"2","code":"  attr_accessor :age\nend"},{"id":"3","code":"u = User.new"},{"id":"4","code":"u.age = 20"},{"id":"5","code":"puts u.age"}]'::jsonb,
'["1","2","3","4","5"]'::jsonb,
'["class User","  attr_accessor :age\nend","u = User.new","u.age = 20","puts u.age"]'::jsonb,
'Class open, attr_accessor, instantiation, use setter, use getter.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Make class C; attr_accessor :val; end. Create c = C.new. Set c.val = 99. Puts c.val. Expected: 99',
'# Write class, instantiate, set, puts',
'99',
'class C; attr_accessor :val; end; c = C.new; c.val = 99; puts c.val',
5, 20);
-- Lesson 5.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Inheritance', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which symbol is used to indicate that a class inherits from a parent class in Ruby?',
'0',
'["< (e.g., class Dog < Animal)", ":", "extends", "->"]'::jsonb,
'The less-than sign indicates that Dog is a subclass of Animal.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Inside a child method, what keyword calls the parent class''s method of the exact same name?',
'def setup' || chr(10) || '  ___ # Calls parent setup' || chr(10) || 'end',
'super',
'["super", "parent", "base", "yield"]'::jsonb,
'super automatically invokes the parent method, passing along any arguments.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Does Ruby support multiple inheritance (a class inheriting from more than one parent class)?',
'0',
'["No, a class can only have one parent class (<)", "Yes, by separating them with commas", "Yes, using the && operator", "No, Ruby does not support inheritance at all"]'::jsonb,
'To share behavior across multiple classes without inheritance, Ruby uses Modules (Mixins).',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange an inheritance hierarchy:',
'[{"id":"1","code":"class Pet"},{"id":"2","code":"  def speak; puts \"...\"; end\\nend"},{"id":"3","code":"class Cat < Pet"},{"id":"4","code":"  def speak; puts \"Meow\"; end\\nend"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["class Pet","  def speak; puts \"...\"; end\\nend","class Cat < Pet","  def speak; puts \"Meow\"; end\\nend"]'::jsonb,
'Base class, base method, derived class with <, overridden method.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Make class Base; def v; 1; end; end. Make class Sub < Base; def v; super + 1; end; end. Puts Sub.new.v. Expected: 2',
'# Base, Sub, output',
'2',
'class Base; def v; 1; end; end; class Sub < Base; def v; super + 1; end; end; puts Sub.new.v',
5, 20);
-- ==============================================================
-- UNIT 6: Advanced Ruby
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 6: Advanced Ruby', 'Master modules, mixins, Enumerable methods, and error handling', 'red', 6)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Advanced Ruby Features', $note$
# Advanced Ruby Concepts
## Modules and Mixins
Ruby doesn't support multiple inheritance. If you want to share a set of methods across unrelated classes, you put them in a module, and then include the module in the class. This is called a **Mixin**.
```ruby
module Swimmable
  def swim
    puts "I am swimming!"
  end
end

class Fish
  include Swimmable # Injects the swim method
end

Fish.new.swim

```
## The Enumerable Module
The Enumerable module provides dozens of powerful methods for arrays and hashes. The most famous are map and select.
 * .map transforms every item in an array and returns a NEW array.
```ruby
nums = [1, 2, 3]
doubles = nums.map { |n| n * 2 }
# doubles is [2, 4, 6]

```
 * .select filters an array based on a condition.
```ruby
evens = nums.select { |n| n.even? }
# evens is [2]

```
## Error Handling
In Ruby, error handling is done with begin, rescue, and ensure.
```ruby
begin
  # Dangerous code
  10 / 0
rescue ZeroDivisionError
  # Handle the specific error
  puts "You cannot divide by zero!"
rescue StandardError => e
  # Catch any other standard error
  puts "An error occurred: #{e.message}"
ensure
  # This code ALWAYS runs
  puts "Cleanup complete."
end

```
## The Splat Operator *
If a method needs to accept an unknown number of arguments, use the splat operator. It gathers the arguments into an array.
```ruby
def greet_all(*names)
  names.each { |n| puts "Hi #{n}" }
end

greet_all("Alice", "Bob", "Charlie")

```
$note$, 0);
-- Lesson 6.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Modules and Mixins', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a Mixin in Ruby?',
'0',
'["A Module whose methods have been injected into a Class using the include keyword", "A class with multiple parents", "A hash with string keys", "A built-in method for mixing strings"]'::jsonb,
'Mixins are Ruby''s elegant solution to the lack of multiple inheritance.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the keyword to inject a module''s methods into a class as instance methods:',
'class User' || chr(10) || '  ___ Authenticatable' || chr(10) || 'end',
'include',
'["include", "extend", "require", "import"]'::jsonb,
'include brings the methods in as instance methods. (extend would bring them in as Class methods).',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you instantiate a Module using Module.new?',
'0',
'["No, modules cannot be instantiated. They are just collections of methods and constants", "Yes, they work exactly like classes", "Yes, but they take no parameters", "Only if they contain no methods"]'::jsonb,
'Classes are for creating objects. Modules are for storing shared behavior or creating namespaces.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a module and include it in a class:',
'[{"id":"1","code":"module Flyable"},{"id":"2","code":"  def fly; puts \"Up\"; end\\nend"},{"id":"3","code":"class Bird"},{"id":"4","code":"  include Flyable\\nend"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["module Flyable","  def fly; puts \"Up\"; end\\nend","class Bird","  include Flyable\\nend"]'::jsonb,
'Module open, method and end, class open, include module and end.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Make module M; def p; puts "M"; end; end. Make class C; include M; end. Call C.new.p. Expected: M',
'# Module, Class, call',
'M',
'module M; def p; puts "M"; end; end; class C; include M; end; C.new.p',
5, 20);
-- Lesson 6.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Enumerable: Map and Select', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the .map method do to an array?',
'0',
'["It returns a NEW array containing the transformed results of running the block on each element", "It modifies the original array in place", "It searches for an element", "It sums the elements"]'::jsonb,
'[1, 2].map { |n| n*2 } returns [2, 4]. The original array remains [1, 2].',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the method to filter an array to only include elements where the block returns true:',
'evens = nums.___ { |n| n.even? }',
'select',
'["select", "filter", "where", "find"]'::jsonb,
'.select (also known as filter in other languages) keeps elements that pass the condition.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'In Ruby, methods that end with a question mark ? (like n.even?) conventionally indicate what?',
'0',
'["The method returns a boolean (true or false)", "The method might throw an error", "The method requires arguments", "The method mutates the object"]'::jsonb,
'Examples: empty?, nil?, even?. They make if array.empty? read beautifully.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to map an array of numbers to their squares:',
'[{"id":"1","code":"nums = [1, 2, 3]"},{"id":"2","code":"squares = nums.map do |n|"},{"id":"3","code":"  n * n"},{"id":"4","code":"end"}]'::jsonb,
'["1","2","3","4"]'::jsonb,
'["nums = [1, 2, 3]","squares = nums.map do |n|","  n * n","end"]'::jsonb,
'Declare array, map with block variable, math logic, end.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Use .map to multiply [3, 4] by 2. puts the resulting array. Expected: 6 \n 8',
'a = [3, 4]' || chr(10) || '# map and puts',
'6' || chr(10) || '8',
'puts a.map { |n| n * 2 }',
5, 20);
-- Lesson 6.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Error Handling', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What keywords create an exception handling block in Ruby?',
'0',
'["begin and rescue", "try and catch", "do and error", "attempt and fail"]'::jsonb,
'Ruby uses begin to start the safe zone, and rescue to catch errors.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the keyword to catch a StandardError into a variable e:',
'___ StandardError => e',
'rescue',
'["rescue", "catch", "except", "error"]'::jsonb,
'rescue ExceptionType => variable allows you to inspect the error message via e.message.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the ensure block do?',
'0',
'["It executes code regardless of whether an exception was raised or not", "It forces the program to crash", "It ensures the variable is not nil", "It creates a backup of the database"]'::jsonb,
'Similar to finally in other languages, it is used to close files or connections.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a safe division block:',
'[{"id":"1","code":"begin"},{"id":"2","code":"  puts 10 / 0"},{"id":"3","code":"rescue ZeroDivisionError"},{"id":"4","code":"  puts \"Cannot divide by 0\""},{"id":"5","code":"end"}]'::jsonb,
'["1","2","3","4","5"]'::jsonb,
'["begin","  puts 10 / 0","rescue ZeroDivisionError","  puts \"Cannot divide by 0\"","end"]'::jsonb,
'begin, dangerous code, rescue specific error, handle it, end.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write a begin block. Inside, 1/0. Catch with rescue. Inside rescue, puts "Err". Close with end. Expected: Err',
'# Write begin rescue end',
'Err',
'begin; 1/0; rescue; puts "Err"; end',
5, 20);
-- Lesson 6.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'The Splat Operator', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the splat operator * do when placed before a parameter in a method definition (e.g., def run(*args))?',
'0',
'["It gathers an unknown/variable number of arguments into a single Array", "It multiplies the parameter by itself", "It marks the parameter as a pointer", "It makes the parameter optional"]'::jsonb,
'If you call run(1, 2, 3), args becomes the array [1, 2, 3].',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the parameter to gather all passed names into an array called names:',
'def greet(___names) { puts names.length }',
'*',
'["*", "&", "...", "**"]'::jsonb,
'The single asterisk is the splat operator.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you use the splat operator on an array when CALLING a method (e.g., method(*[1, 2, 3]))?',
'0',
'["It \"un-splats\" or unpacks the array into individual separate arguments", "It crashes the program", "It passes the array as a single object", "It converts the array to a hash"]'::jsonb,
'This is incredibly useful if a method expects 3 separate arguments, but you have your data stored in an array.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a method taking variable arguments and calling it:',
'[{"id":"1","code":"def sum(*nums)"},{"id":"2","code":"  puts nums.sum\nend"},{"id":"3","code":"sum(1, 2, 3)"}]'::jsonb,
'["1","2","3"]'::jsonb,
'["def sum(*nums)","  puts nums.sum\nend","sum(1, 2, 3)"]'::jsonb,
'Method with splat, body using array method, call with 3 args.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write def count(*args); puts args.size; end. Call count(1, 2, 3, 4). Expected: 4',
'# Method with splat and call',
'4',
'def count(*args); puts args.size; end; count(1,2,3,4)',
5, 20);
END $$;

