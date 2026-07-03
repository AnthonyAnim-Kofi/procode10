-- ============================================================
-- REAL RUST CURRICULUM
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

  -- Prefer slug 'rust' (used by the app); fall back to 'rs' if present.
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug IN ('rust', 'rs')
  ORDER BY CASE WHEN slug = 'rust' THEN 0 ELSE 1 END
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('Rust', 'rust', '🦀', 'A blazing fast, memory-safe systems programming language without a garbage collector.')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with Rust
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Learn Cargo, variables, mutability, and basic control flow', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to Rust', $note$
# Introduction to Rust

Rust is a systems programming language that guarantees memory safety and thread safety without relying on a garbage collector. It's known for performance, reliability, and its strict compiler.

## Your First Program

Rust programs are usually managed by `Cargo`, Rust's build system and package manager. A new project is created with `cargo new my_project`.

```rust
fn main() {
    println!("Hello, World!");
}

```
Breaking it down:
 * fn main() — The entry point of every Rust executable.
 * println! — A macro (denoted by the !) that prints text to the console and adds a new line.
## Variables and Mutability
By default, variables in Rust are **immutable** (they cannot be changed once assigned). To make them changeable, you must use the mut keyword.
```rust
let x = 5;       // Immutable
// x = 10;       // Error!

let mut y = 5;   // Mutable
y = 10;          // Allowed!

```
## Data Types
Rust is statically typed. It can infer types, but sometimes you must annotate them.
```rust
let age: i32 = 25;       // 32-bit signed integer
let price: f64 = 19.99;  // 64-bit floating point
let is_active: bool = true;
let initial: char = 'A';

```
## Functions
Functions use fn and require you to specify parameter types and return types using ->.
```rust
fn add(a: i32, b: i32) -> i32 {
    a + b // No semicolon means this is the return value!
}

```
## Key Takeaways
 * Use let to declare variables. They are immutable by default.
 * Use let mut for variables you need to change.
 * println! is a macro, not a regular function.
 * In a function, an expression without a trailing semicolon is implicitly returned.
   $note$, 0);
   -- Lesson 1.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Hello, Cargo!', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the ! signify in println!("Hello");?',
   '0',
   '["It means println is a macro, not a regular function","It is used to force printing","It indicates an asynchronous call","It indicates a panic"]'::jsonb,
   'Macros write code for you at compile time. In Rust, any "function" call ending with ! is a macro.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the declaration for the entry point of a Rust program:',
   '___ main() { }',
   'fn',
   '["fn","func","def","function"]'::jsonb,
   'Rust uses fn to declare functions.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is Cargo in the Rust ecosystem?',
   '0',
   '["Rust''s build system and package manager","The Rust compiler itself","A web framework for Rust","A garbage collector"]'::jsonb,
   'Cargo is used to build projects (cargo build), run them (cargo run), and fetch dependencies.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the lines to create a minimal Hello World program:',
   '[{"id":"1","code":"fn main() {"},{"id":"2","code":"  println!(\"Hello\");"},{"id":"3","code":"}"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["fn main() {","  println!(\"Hello\");","}"]'::jsonb,
   'Function declaration, body, closing brace.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write a Rust program that prints: Learning Rust',
   'fn main() {' || chr(10) || '    // Write your code here' || chr(10) || '}',
   'Learning Rust',
   'println!("Learning Rust");',
   5, 20);
   -- Lesson 1.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Variables and Mutability', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What happens if you run this code: let x = 5; x = 10;?',
   '0',
   '["The compiler throws an error because variables are immutable by default","It works fine and updates x to 10","It creates a new variable shadowing the old one","x becomes a float"]'::jsonb,
   'Rust forces you to explicitly opt-in to mutability using the mut keyword.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the code to make the variable changeable:',
   'let ___ score = 0;',
   'mut',
   '["mut","var","let","change"]'::jsonb,
   'mut stands for mutable.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does variable "shadowing" allow you to do in Rust?',
   '0',
   '["Re-declare a variable with the same name using let, effectively creating a new variable","Change an immutable variable without let","Hide a variable from the compiler","Delete a variable"]'::jsonb,
   'Shadowing is useful when converting types (e.g., let spaces = "   "; let spaces = spaces.len();).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to declare a mutable variable, change it, and print it:',
   '[{"id":"1","code":"fn main() {"},{"id":"2","code":"  let mut count = 0;"},{"id":"3","code":"  count = 1;"},{"id":"4","code":"  println!(\"{}\", count);"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["fn main() {","  let mut count = 0;","  count = 1;","  println!(\"{}\", count);","}"]'::jsonb,
   'Open main, declare mut, reassign, print using {} formatting, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Declare a mutable variable age as 20. Update it to 21, and print it using println!("{}", age);.',
   'fn main() {' || chr(10) || '    // Declare, update, print' || chr(10) || '}',
   '21',
   'let mut age = 20; age = 21; println!("{}", age);',
   5, 20);
   -- Lesson 1.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Functions', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'How do you specify the return type of a function in Rust?',
   '0',
   '["By placing an arrow -> followed by the type after the parameters","By writing the type before the function name","By using a colon :","Rust does not allow specifying return types"]'::jsonb,
   'Example: fn calculate() -> i32 { ... }',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the function signature to return a 32-bit integer:',
   'fn get_id() ___ i32 { 101 }',
   '->',
   '["->",":","=>","returns"]'::jsonb,
   'The thin arrow -> is used for function return types.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the preferred way to return a value from a Rust function?',
   '0',
   '["Leave off the semicolon on the final expression in the block","Use the return keyword exclusively","Assign to a variable named result","Rust functions cannot return values"]'::jsonb,
   'In Rust, blocks evaluate to the last expression. If you add a semicolon, it becomes a statement and returns () (the unit type).',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a complete function that adds two integers:',
   '[{"id":"1","code":"fn add(a: i32, b: i32) -> i32 {"},{"id":"2","code":"  a + b"},{"id":"3","code":"}"},{"id":"4","code":"fn main() { println!(\"{}\", add(2, 3)); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["fn add(a: i32, b: i32) -> i32 {","  a + b","}","fn main() { println!(\"{}\", add(2, 3)); }"]'::jsonb,
   'Signature, implicit return (no semicolon), close, main func.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write fn double(n: i32) -> i32 that returns n * 2. In main, print the result of double(5).',
   '// Write fn double' || chr(10) || 'fn main() {' || chr(10) || '    // Call and print' || chr(10) || '}',
   '10',
   'fn double(n: i32) -> i32 { n * 2 } fn main() { println!("{}", double(5)); }',
   5, 20);
   -- Lesson 1.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Control Flow', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'Which keyword is used to create an infinite loop in Rust?',
   '0',
   '["loop","while true","for ever","repeat"]'::jsonb,
   'loop { ... } will run forever until you explicitly break.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Because if is an expression in Rust, you can assign it directly to a variable:',
   'let result = ___ condition { 5 } else { 10 };',
   'if',
   '["if","match","when","loop"]'::jsonb,
   'Rust has no ternary operator (? :). You just use if/else inline.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does for x in 0..5 do?',
   '0',
   '["Loops 5 times, with x taking values 0, 1, 2, 3, 4","Loops 6 times, up to 5","Loops infinite times","Syntax Error"]'::jsonb,
   '0..5 is an exclusive range. To include 5, use 0..=5.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange an inline if expression assignment:',
   '[{"id":"1","code":"let is_admin = true;"},{"id":"2","code":"let role = if is_admin {"},{"id":"3","code":"  \"Admin\""},{"id":"4","code":"} else {"},{"id":"5","code":"  \"User\" };"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["let is_admin = true;","let role = if is_admin {","  \"Admin\"","} else {","  \"User\" };"]'::jsonb,
   'Declare bool, assign using if, true branch (no semicolon), else, false branch with semicolon.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Use a for loop over 1..4 to print 1, 2, and 3 on separate lines.',
   'fn main() {' || chr(10) || '    // Write for loop' || chr(10) || '}',
   '1' || chr(10) || '2' || chr(10) || '3',
   'for i in 1..4 { println!("{}", i); }',
   5, 20);
   -- ==============================================================
   -- UNIT 2: Ownership and Borrowing
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 2: Ownership & Borrowing', 'Understand Rust''s core memory management system without garbage collection', 'green', 2)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Ownership and Borrowing', $note$
# Ownership and Borrowing
Ownership is Rust’s most unique feature and enables it to make memory safety guarantees without needing a garbage collector.
## The Rules of Ownership
 1. Each value in Rust has an owner.
 2. There can only be one owner at a time.
 3. When the owner goes out of scope, the value will be dropped (memory freed).
## Move Semantics
For complex data on the heap (like String), assigning a variable to another **moves** the ownership.
```rust
let s1 = String::from("hello");
let s2 = s1; 
// s1 is now invalid! Trying to use s1 here will cause a compile error.
// We say the value was "moved" to s2.

```
*Note: Simple stack data like integers are implicitly copied, so let a=5; let b=a; leaves both valid.*
## References and Borrowing (&)
Instead of moving ownership, you can "borrow" a value using references.
```rust
let s1 = String::from("hello");
let len = calculate_length(&s1); // Pass a reference
println!("{} is still valid!", s1); 

fn calculate_length(s: &String) -> usize {
    s.len()
}

```
## Mutable References (&mut)
You can borrow a value mutably to change it, but **you can only have ONE mutable reference to a particular piece of data in a particular scope.** This prevents data races at compile time!
```rust
let mut s = String::from("hello");
change(&mut s);

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}

```
## Slices (&str)
A slice lets you reference a contiguous sequence of elements in a collection rather than the whole collection.
```rust
let s = String::from("hello world");
let hello: &str = &s[0..5]; // borrows just "hello"

```
$note$, 0);
-- Lesson 2.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Ownership Basics', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens when a variable that owns heap data (like a String) goes out of scope?',
'0',
'["Rust automatically calls the drop function and cleans up the heap memory","The garbage collector deletes it eventually","It causes a memory leak","It stays in memory forever"]'::jsonb,
'Rust has no garbage collector. Memory is freed deterministically when the owner goes out of scope.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the rule: "There can only be ___ owner of a piece of data at a time."',
'___',
'one',
'["one","two","multiple","zero"]'::jsonb,
'This single ownership rule prevents double-free errors.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If s1 = String::from("hi"); and s2 = s1;, why can''t you use s1 afterward?',
'0',
'["Because ownership of the string was moved to s2","Because s1 is automatically deleted","Because they are not mutable","Because strings cannot be assigned"]'::jsonb,
'Rust prevents both variables from pointing to the same heap memory to avoid double-free errors. This is called a Move.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code that creates a String and then clones it (creating a deep copy) to avoid moving:',
'[{"id":"1","code":"let s1 = String::from(\"Rust\");"},{"id":"2","code":"let s2 = s1.clone();"},{"id":"3","code":"println!(\"{} and {}\", s1, s2);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["let s1 = String::from(\"Rust\");","let s2 = s1.clone();","println!(\"{} and {}\", s1, s2);"]'::jsonb,
'Declare s1, clone it to s2, then safely print both.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create let x = 5; let y = x;. Print x and y. (This works because integers are Copied, not Moved). Expected: 5 5',
'fn main() {' || chr(10) || '    // Declare, copy, print' || chr(10) || '}',
'5 5',
'let x = 5; let y = x; println!("{} {}", x, y);',
5, 20);
-- Lesson 2.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'References and Borrowing', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you pass a variable to a function without transferring ownership (moving) it?',
'0',
'["By passing a reference to it using &","By casting it","By making it global","You must always transfer ownership"]'::jsonb,
'Using & creates a reference, allowing the function to "borrow" the data without taking ownership.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the function signature to accept a borrowed String reference:',
'fn get_len(s: ___) -> usize',
'&String',
'["&String","String","*String","ref String"]'::jsonb,
'& indicates a reference type.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Are borrowed references (&T) mutable by default?',
'0',
'["No, references are immutable by default","Yes, you can always change borrowed data","Only if the original variable is immutable","Yes, but only for Strings"]'::jsonb,
'Just like variables, references are immutable. You cannot modify something you have an immutable borrow to.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to pass a borrowed String and print its length:',
'[{"id":"1","code":"fn main() {"},{"id":"2","code":"  let s = String::from(\"Hi\");"},{"id":"3","code":"  print_len(&s);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["fn main() {","  let s = String::from(\"Hi\");","  print_len(&s);","}"]'::jsonb,
'Open main, declare String, pass reference &s, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given let s = String::from("A");. Print s by dereferencing a reference let r = &s;. Expected: A',
'fn main() {' || chr(10) || '    let s = String::from("A");' || chr(10) || '    // Create ref and print' || chr(10) || '}',
'A',
'let r = &s; println!("{}", r);',
5, 20);
-- Lesson 2.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Mutable References', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the strictest rule regarding mutable references in Rust?',
'0',
'["You can only have one mutable reference to a piece of data in a particular scope","You must use the unsafe keyword","They can only be used on integers","They are heavily garbage collected"]'::jsonb,
'This rule prevents data races at compile time! No two pointers can mutate the same data simultaneously.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to create a mutable reference:',
'let r = ___ s;',
'&mut',
'["&mut","mut &","*mut","ref mut"]'::jsonb,
'&mut explicitly denotes a mutable reference.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you have an immutable reference (&) and a mutable reference (&mut) in the same scope at the same time?',
'0',
'["No, this is a compile-time error","Yes, Rust handles it automatically","Yes, if they are on different threads","Only for arrays"]'::jsonb,
'Users of an immutable reference do not expect the value to suddenly change underneath them. Rust prevents this.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to mutate a String via a reference:',
'[{"id":"1","code":"let mut s = String::from(\"Hello\");"},{"id":"2","code":"change(&mut s);"},{"id":"3","code":"fn change(s: &mut String) {"},{"id":"4","code":"  s.push_str(\", world\"); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let mut s = String::from(\"Hello\");","change(&mut s);","fn change(s: &mut String) {","  s.push_str(\", world\"); }"]'::jsonb,
'Declare mut String, pass &mut to func, define func taking &mut String, modify inside func.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create let mut x = 5;. Create a mut ref let r = &mut x;. Dereference and add 1 *r += 1;. Print x. Expected: 6',
'fn main() {' || chr(10) || '    // Write code' || chr(10) || '}',
'6',
'let mut x = 5; { let r = &mut x; *r += 1; } println!("{}", x);',
5, 20);
-- Lesson 2.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'The Slice Type', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does a slice (&str or &[T]) let you do?',
'0',
'["It lets you reference a contiguous sequence of elements in a collection without taking ownership","It copies half of an array","It deletes elements from memory","It modifies the collection"]'::jsonb,
'Slices are references to parts of a collection (like a view).',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to slice the first 3 characters of s:',
'let slice = &s[0___3];',
'..',
'["..",":","-","..."]'::jsonb,
'.. is the range operator. It includes the start index and excludes the end index.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the type of a string literal, e.g., let s = "Hello";?',
'0',
'["&str (a string slice pointing to a specific point in the binary)","String (an allocated heap string)","char[]","char"]'::jsonb,
'String literals are immutable slices (&str) baked directly into the compiled executable.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to get the word "world" from a string:',
'[{"id":"1","code":"let s = String::from(\"hello world\");"},{"id":"2","code":"let word = &s[6..11];"},{"id":"3","code":"println!(\"{}\", word);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["let s = String::from(\"hello world\");","let word = &s[6..11];","println!(\"{}\", word);"]'::jsonb,
'Declare heap string, slice it using range, print the slice.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given let a = [1, 2, 3, 4];. Create a slice s of the first two elements. Print s[1]. Expected: 2',
'fn main() {' || chr(10) || '    let a = [1, 2, 3, 4];' || chr(10) || '    // Slice and print' || chr(10) || '}',
'2',
'let s = &a[0..2]; println!("{}", s[1]);',
5, 20);
-- ==============================================================
-- UNIT 3: Structs, Enums, and Pattern Matching
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 3: Structs & Enums', 'Model complex data using structs, enums, and powerful pattern matching', 'orange', 3)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Structs and Enums', $note$
# Structs, Enums, and Pattern Matching
Rust does not have classes or inheritance. Instead, it uses **structs** to hold data, and **traits** to define behavior.
## Structs
```rust
struct User {
    username: String,
    active: bool,
}

let user1 = User {
    username: String::from("anthony"),
    active: true,
};

```
## Methods and the impl block
To attach functions to a struct, use an impl (implementation) block. The first parameter is usually &self.
```rust
impl User {
    // A method taking an immutable reference to the instance
    fn get_name(&self) -> &str {
        &self.username
    }
}

```
## Enums
Enums in Rust are extremely powerful. They allow you to define a type by enumerating its possible variants, and those variants can hold data!
```rust
enum IpAddr {
    V4(u8, u8, u8, u8),
    V6(String),
}

let home = IpAddr::V4(127, 0, 0, 1);
let loopback = IpAddr::V6(String::from("::1"));

```
## The Option Enum
Rust doesn't have null. Instead, it has the Option<T> enum. A value can be Some(T) or None.
```rust
let some_number: Option<i32> = Some(5);
let absent_number: Option<i32> = None;

```
## The match Control Flow Construct
match allows you to compare a value against a series of patterns. It is exhaustive (you must handle all cases).
```rust
let coin = 1;
match coin {
    1 => println!("Penny"),
    5 => println!("Nickel"),
    _ => println!("Other"), // The _ acts as a default/catch-all
}

```
$note$, 0);
-- Lesson 3.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Defining Structs', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you group multiple related values of different types into a single custom type?',
'0',
'["Using a struct","Using an array","Using an enum","Using a class"]'::jsonb,
'Structs are custom data types that let you package together and name multiple related values.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the struct declaration:',
'___ Point { x: i32, y: i32 }',
'struct',
'["struct","class","type","impl"]'::jsonb,
'The struct keyword defines the shape of the data.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If you make a struct instance mutable (let mut p = Point{...}), can you choose to make only specific fields mutable?',
'0',
'["No, the entire instance must be mutable","Yes, you can specify mut on individual fields","Yes, but only for integers","No, structs cannot be mutable"]'::jsonb,
'Rust doesn''t allow field-level mutability in safe code. The entire instance is either mutable or immutable.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to define a struct and instantiate it:',
'[{"id":"1","code":"struct Rect { w: u32, h: u32 }"},{"id":"2","code":"fn main() {"},{"id":"3","code":"  let r = Rect { w: 10, h: 20 };"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["struct Rect { w: u32, h: u32 }","fn main() {","  let r = Rect { w: 10, h: 20 };","}"]'::jsonb,
'Struct def, main function, instantiate struct, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given struct Box { val: i32 }. In main, create a box with val 55 and print it. Expected: 55',
'struct Box { val: i32 }' || chr(10) || 'fn main() {' || chr(10) || '    // Instantiate and print' || chr(10) || '}',
'55',
'let b = Box { val: 55 }; println!("{}", b.val);',
5, 20);
-- Lesson 3.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Methods and impl Blocks', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which keyword is used to associate methods with a struct?',
'0',
'["impl","struct","method","attach"]'::jsonb,
'You define the struct, then create an impl (implementation) block for its methods.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'What must the first parameter of a struct method be if you want to read data from the instance?',
'fn get_area(___) -> u32',
'&self',
'["&self","this","self","&this"]'::jsonb,
'&self is short for self: &Self. It borrows the instance immutably.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is an "associated function" in Rust (often used as constructors like String::new())?',
'0',
'["A function inside an impl block that does NOT take self as a parameter","A function that takes &mut self","A function outside an impl block","A macro"]'::jsonb,
'Associated functions are called using :: (e.g., Struct::function()) rather than dot notation on an instance.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange an impl block to add a method to a struct:',
'[{"id":"1","code":"struct Circle { r: u32 }"},{"id":"2","code":"impl Circle {"},{"id":"3","code":"  fn dia(&self) -> u32 { self.r * 2 }"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["struct Circle { r: u32 }","impl Circle {","  fn dia(&self) -> u32 { self.r * 2 }","}"]'::jsonb,
'Struct def, impl block, method definition with &self, close block.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Add a method fn get() -> i32 inside impl Box returning self.v. Call it in main. Expected: 9',
'struct Box { v: i32 }' || chr(10) || 'impl Box {' || chr(10) || '    // Write method' || chr(10) || '}' || chr(10) || 'fn main() {' || chr(10) || '    let b = Box { v: 9 };' || chr(10) || '    // Call and print' || chr(10) || '}',
'9',
'fn get(&self) -> i32 { self.v } ... println!("{}", b.get());',
5, 20);
-- Lesson 3.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Enums and Option', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What advantage do Rust enums have over enums in many other languages like C or Java?',
'0',
'["Rust enum variants can store arbitrary data directly inside them","Rust enums are always strings","Rust enums are faster","Rust enums can inherit from each other"]'::jsonb,
'e.g., enum Msg { Quit, Move(i32, i32), Write(String) }.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration of Rust''s built-in Option enum:',
'enum Option<T> { ___(T), None }',
'Some',
'["Some","Any","Value","Exists"]'::jsonb,
'Option forces you to explicitly handle the possibility of a value being missing (None), eliminating Null Pointer Exceptions.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why does Rust not have a null feature?',
'0',
'["To prevent billion-dollar mistakes (null pointer dereferences); Rust uses Option<T> instead","Because it uses undefined instead","Because garbage collection handles it","Because all variables must be zero"]'::jsonb,
'If something can be null, its type must be Option<T>. The compiler forces you to check for None before using the T.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to create an enum and instantiate a variant with data:',
'[{"id":"1","code":"enum IP {"},{"id":"2","code":"  V4(u8, u8, u8, u8)"},{"id":"3","code":"}"},{"id":"4","code":"let localhost = IP::V4(127, 0, 0, 1);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["enum IP {","  V4(u8, u8, u8, u8)","}","let localhost = IP::V4(127, 0, 0, 1);"]'::jsonb,
'Enum open, variant with tuple data, enum close, instantiation.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Assign Some(5) to a variable x. Unpack it using unwrap() and print. Expected: 5',
'fn main() {' || chr(10) || '    // Declare Option and unwrap' || chr(10) || '}',
'5',
'let x: Option<i32> = Some(5); println!("{}", x.unwrap());',
5, 20);
-- Lesson 3.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Pattern Matching (match)', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does it mean that the match expression in Rust is "exhaustive"?',
'0',
'["You must explicitly handle every possible case/variant of the value being matched","It runs slowly","It can only be used on strings","It matches everything automatically"]'::jsonb,
'The compiler will refuse to compile if you forget to handle an enum variant or a potential number.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax for a match arm:',
'match num { 1 ___ println!("One"), _ => () }',
'=>',
'["=>","->",":","="]'::jsonb,
'pattern => code, is the syntax for a match arm.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the underscore _ pattern do in a match expression?',
'0',
'["It is a catch-all that matches any value not specified in previous arms","It hides variables","It returns nil","It panics"]'::jsonb,
'It is similar to default in a switch statement.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a match expression to extract a value from an Option:',
'[{"id":"1","code":"let opt = Some(10);"},{"id":"2","code":"match opt {"},{"id":"3","code":"  Some(val) => println!(\"{}\", val),"},{"id":"4","code":"  None => println!(\"Empty\"),"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["let opt = Some(10);","match opt {","  Some(val) => println!(\"{}\", val),","  None => println!(\"Empty\"),","}"]'::jsonb,
'Declare Option, start match, Some arm, None arm, close block.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Match x = 2. 1 => print A, 2 => print B, _ => print C. Expected: B',
'fn main() {' || chr(10) || '    let x = 2;' || chr(10) || '    // Match and print' || chr(10) || '}',
'B',
'match x { 1 => println!("A"), 2 => println!("B"), _ => println!("C") }',
5, 20);
-- ==============================================================
-- UNIT 4: Packages, Crates, and Modules
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 4: Packages & Modules', 'Organize large Rust projects using modules, paths, and visibility rules', 'purple', 4)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Modules and Organization', $note$
# Packages, Crates, and Modules
As a project grows, you need to organize code into multiple files and namespaces.
## Crates and Packages
 * A **crate** is a binary or library.
 * A **package** is one or more crates that provide a set of functionality (managed via Cargo.toml).
## Defining Modules (mod)
Modules let you organize code within a crate into groups for readability and easy reuse.
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

```
## Visibility (pub)
In Rust, **everything is private by default** (functions, structs, fields, modules). You must use the pub keyword to make an item public.
```rust
pub struct Breakfast {
    pub toast: String, // Public field
    seasonal_fruit: String, // Private field
}

```
## Bringing Paths into Scope (use)
Typing out long module paths is tedious. You can bring a path into scope with use.
```rust
use crate::front_of_house::hosting;

fn eat_at_restaurant() {
    hosting::add_to_waitlist(); // Much shorter!
}

```
## Key Takeaways
 * Use mod to declare a new module.
 * Items are private by default; use pub to expose them.
 * use creates a shortcut to an item to save typing.
 * Cargo.toml manages your package dependencies and metadata.
   $note$, 0);
   -- Lesson 4.1
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Cargo and Crates', 1) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What file does Cargo use to manage project metadata and dependencies?',
   '0',
   '["Cargo.toml","package.json","build.gradle","rust.yaml"]'::jsonb,
   'Rust uses TOML (Tom''s Obvious, Minimal Language) for configuration.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the command to build and execute a Cargo project in one step:',
   'cargo ___',
   'run',
   '["run","build","start","execute"]'::jsonb,
   'cargo run compiles the code (if changed) and then immediately runs the resulting binary.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is a "Crate" in Rust?',
   '0',
   '["A compilation unit: either a library crate or a binary crate","A wooden box","A variable type","A garbage collection cycle"]'::jsonb,
   'When you compile a project, the compiler produces a crate. Dependencies downloaded from crates.io are also crates.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the standard Cargo project structure:',
   '[{"id":"1","code":"my_project/"},{"id":"2","code":"\u251c\u2500\u2500 Cargo.toml"},{"id":"3","code":"\u2514\u2500\u2500 src/"},{"id":"4","code":"    \u2514\u2500\u2500 main.rs"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["my_project/","\u251c\u2500\u2500 Cargo.toml","\u2514\u2500\u2500 src/","    \u2514\u2500\u2500 main.rs"]'::jsonb,
   'Root folder, Cargo config, src folder, main source file.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print exactly: Cargo.toml',
   'fn main() {' || chr(10) || '    // Print the file name' || chr(10) || '}',
   'Cargo.toml',
   'println!("Cargo.toml");',
   5, 20);
   -- Lesson 4.2
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Modules and Visibility', 2) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the default visibility of an item (function, struct, module) in Rust?',
   '0',
   '["Private (only visible within its own module and sub-modules)","Public","Protected","Package-private"]'::jsonb,
   'Rust forces you to explicitly declare what is part of your public API to prevent accidental exposure of internal logic.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the keyword to expose a function to outer modules:',
   '___ fn process() {}',
   'pub',
   '["pub","public","export","expose"]'::jsonb,
   'pub makes an item public.',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If a struct is marked pub, are its fields automatically public?',
   '0',
   '["No, struct fields remain private by default; each field must be marked pub individually","Yes, pub on a struct applies to all fields","Yes, but only for strings","No, structs cannot have public fields"]'::jsonb,
   'This allows a struct to have a mix of public data and hidden internal state.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange a module with a public function:',
   '[{"id":"1","code":"mod math {"},{"id":"2","code":"  pub fn add(a: i32) -> i32 {"},{"id":"3","code":"    a + 1 }"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["mod math {","  pub fn add(a: i32) -> i32 {","    a + 1 }","}"]'::jsonb,
   'Module declaration, pub function signature, body, close module.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Inside mod my { pub fn a() { println!("A"); } }. In main, call it using my::a();. Expected: A',
   'mod my { pub fn a() { println!("A"); } }' || chr(10) || 'fn main() {' || chr(10) || '    // Call function' || chr(10) || '}',
   'A',
   'my::a();',
   5, 20);
   -- Lesson 4.3
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'Paths and the use Keyword', 3) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does the use keyword do in Rust?',
   '0',
   '["It brings a path into scope, so you don''t have to type the full path every time","It imports a new package from the internet","It executes a module","It creates an alias for a variable"]'::jsonb,
   'Similar to import in Java or Python, use std::collections::HashMap; allows you to just type HashMap.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Complete the path to refer to the root of the current crate:',
   'use ___::my_module::my_func;',
   'crate',
   '["crate","root","self","super"]'::jsonb,
   'crate:: is an absolute path starting from the crate root (e.g., main.rs or lib.rs).',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What does super:: do in a module path?',
   '0',
   '["It accesses the parent module, similar to .. in a filesystem","It accesses the root crate","It accesses a superclass","It imports everything"]'::jsonb,
   'super:: allows a sub-module to reach up and use an item from the module that contains it.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the code to bring a standard library type into scope and use it:',
   '[{"id":"1","code":"use std::collections::HashMap;"},{"id":"2","code":"fn main() {"},{"id":"3","code":"  let map: HashMap<i32, i32> = HashMap::new();"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["use std::collections::HashMap;","fn main() {","  let map: HashMap<i32, i32> = HashMap::new();","}"]'::jsonb,
   'use statement, main func open, instantiate map, close.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Write use std::cmp::max;. In main, print max(5, 10). Expected: 10',
   '// write use statement' || chr(10) || 'fn main() {' || chr(10) || '    // call max and print' || chr(10) || '}',
   '10',
   'use std::cmp::max; fn main() { println!("{}", max(5, 10)); }',
   5, 20);
   -- Lesson 4.4
   INSERT INTO public.lessons (unit_id, title, order_index)
   VALUES (v_unit_id, 'External Crates', 4) RETURNING id INTO v_lesson_id;
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'What is the primary repository for finding and downloading Rust crates?',
   '0',
   '["crates.io","npm","maven","pip"]'::jsonb,
   'Cargo automatically fetches packages listed in Cargo.toml from crates.io.',
   1, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'fill-blank',
   'Under which section in Cargo.toml do you add external crates?',
   '[___]',
   'dependencies',
   '["dependencies","crates","packages","imports"]'::jsonb,
   'Example: [dependencies]\nrand = "0.8.5"',
   2, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'multiple-choice',
   'If you add rand = "0.8.5" to Cargo.toml, how do you access it in main.rs?',
   '0',
   '["By using use rand::*; or calling rand::some_function()","By running an import command","You must write #include <rand>","It replaces the standard library"]'::jsonb,
   'External dependencies automatically become available as a crate in your project''s scope.',
   3, 10);
   INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'drag-order',
   'Arrange the typical Cargo.toml file structure:',
   '[{"id":"1","code":"[package]"},{"id":"2","code":"name = \"my_game\""},{"id":"3","code":"version = \"0.1.0\""},{"id":"4","code":"[dependencies]"},{"id":"5","code":"rand = \"0.8\""}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["[package]","name = \"my_game\"","version = \"0.1.0\"","[dependencies]","rand = \"0.8\""]'::jsonb,
   'Package header, name, version, dependencies header, crate.',
   4, 15);
   INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
   (v_lesson_id, 'code-runner',
   'Print exactly: [dependencies]',
   'fn main() {' || chr(10) || '    // print it' || chr(10) || '}',
   '[dependencies]',
   'println!("[dependencies]");',
   5, 20);
   -- ==============================================================
   -- UNIT 5: Collections and Error Handling
   -- ==============================================================
   INSERT INTO public.units (language_id, title, description, color, order_index)
   VALUES (v_lang_id, 'Unit 5: Collections & Errors', 'Manage heap data and handle expected vs unexpected failures', 'teal', 5)
   RETURNING id INTO v_unit_id;
   INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
   (v_unit_id, 'Collections and Errors', $note$
# Collections and Error Handling
## Vectors (Vec<T>)
A vector is a growable array allocated on the heap.
```rust
// Using the vec! macro
let mut nums = vec![1, 2, 3];
nums.push(4);

// Accessing
let third: &i32 = &nums[2];

```
## Strings (String vs &str)
Rust has two main string types:
 * String: A growable, mutable, owned, UTF-8 encoded string type allocated on the heap.
 * &str: A string slice. A fixed-size, immutable reference to some UTF-8 data.
```rust
let mut s = String::from("foo"); // Owned heap string
s.push_str("bar");

let slice: &str = &s[0..3]; // Borrowed slice

```
## Error Handling
Rust groups errors into two categories:
 1. **Unrecoverable errors:** Bugs like array out-of-bounds. Rust uses the panic! macro to immediately stop execution.
 2. **Recoverable errors:** Expected failures like "file not found". Rust uses the Result<T, E> enum.
```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}

```
## The ? Operator
Instead of writing giant match blocks to check if a Result is Ok or Err, you can use the ? operator. It unwraps Ok values, or immediately returns the Err to the calling function.
```rust
fn read_file() -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?; // Returns early if error!
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}

```
$note$, 0);
-- Lesson 5.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Vectors', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a Vec<T> in Rust?',
'0',
'["A growable array type that stores its elements on the heap","A fixed-size array on the stack","A type of string","A mathematical coordinate"]'::jsonb,
'Vectors are useful when you have a list of items and you don''t know the total number of elements at compile time.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the macro to easily initialize a vector with values:',
'let v = ___![1, 2, 3];',
'vec',
'["vec","vector","arr","list"]'::jsonb,
'The vec! macro is a convenient shortcut for Vec::new() followed by .push().',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you use v[10] to access an element out of bounds on a vector with 3 items?',
'0',
'["The program panics (crashes) at runtime","It returns None","It returns 0","It corrupts memory silently"]'::jsonb,
'Direct indexing [] assumes the element exists. To check safely, use v.get(10) which returns an Option.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to create a mutable vector, add an item, and print it:',
'[{"id":"1","code":"let mut v = Vec::new();"},{"id":"2","code":"v.push(42);"},{"id":"3","code":"println!(\"{}\", v[0]);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["let mut v = Vec::new();","v.push(42);","println!(\"{}\", v[0]);"]'::jsonb,
'Create new mut Vec, push item, access and print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Use vec![7, 8] to create v. Push 9 to v. Print v[2]. Expected: 9',
'fn main() {' || chr(10) || '    // Write vector code' || chr(10) || '}',
'9',
'let mut v = vec![7, 8]; v.push(9); println!("{}", v[2]);',
5, 20);
-- Lesson 5.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Strings', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the difference between String and &str?',
'0',
'["String is an owned, growable heap allocation; &str is a borrowed, fixed-size slice","String is primitive, &str is an object","They are identical","&str is mutable, String is immutable"]'::jsonb,
'Use String when you need to own and modify text. Use &str when you just need to view it.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the associated function to convert a static slice into an owned String:',
'let s = String::___("hello");',
'from',
'["from","new","create","make"]'::jsonb,
'String::from() allocates memory on the heap for the string data.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why can''t you index into a String like s[0] in Rust?',
'0',
'["Because Strings are UTF-8 encoded, so a single character might take more than 1 byte; indexing bytes might split a character","Because Strings are encrypted","Because Rust is memory safe","Because Strings are stored in reverse"]'::jsonb,
'Rust forces you to be explicit about whether you want bytes, chars, or string slices to prevent weird UTF-8 bugs.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange to append a slice to an owned String:',
'[{"id":"1","code":"let mut s = String::from(\"foo\");"},{"id":"2","code":"let slice = \"bar\";"},{"id":"3","code":"s.push_str(slice);"},{"id":"4","code":"println!(\"{}\", s);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let mut s = String::from(\"foo\");","let slice = \"bar\";","s.push_str(slice);","println!(\"{}\", s);"]'::jsonb,
'Declare mut String, declare slice, push slice to string, print result.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create let mut s = String::from("A");. Use .push_str("B");. Print s. Expected: AB',
'fn main() {' || chr(10) || '    // string code' || chr(10) || '}',
'AB',
'let mut s = String::from("A"); s.push_str("B"); println!("{}", s);',
5, 20);
-- Lesson 5.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Recoverable Errors with Result', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What are the two variants of the Result<T, E> enum?',
'0',
'["Ok(T) for success and Err(E) for failure","Some(T) and None","True and False","Pass and Fail"]'::jsonb,
'If a function returns Result, you must handle the possibility that it is an Err.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Which method forces a panic if a Result is an Err, but extracts the value if it is Ok?',
'let file = File::open("file.txt").___();',
'unwrap',
'["unwrap","open","get","force"]'::jsonb,
'.unwrap() is useful for quick prototyping, but dangerous in production code because it crashes the app on failure.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the ? operator do when placed after a function call returning a Result?',
'0',
'["It returns the inner Ok value if successful, or immediately returns the Err to the calling function if it fails","It acts as a ternary operator","It ignores errors","It crashes the program"]'::jsonb,
'The ? operator is Rust''s elegant way to propagate errors up the call stack without writing nested match blocks.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a safe error handling match block:',
'[{"id":"1","code":"let res: Result<i32, &str> = Err(\"Failed\");"},{"id":"2","code":"match res {"},{"id":"3","code":"  Ok(val) => println!(\"Got {}\", val),"},{"id":"4","code":"  Err(e) => println!(\"Error: {}\", e),"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["let res: Result<i32, &str> = Err(\"Failed\");","match res {","  Ok(val) => println!(\"Got {}\", val),","  Err(e) => println!(\"Error: {}\", e),","}"]'::jsonb,
'Declare Err result, start match, Ok arm, Err arm, close match.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write let res: Result<i32, &str> = Ok(99);. Use .unwrap() and print it. Expected: 99',
'fn main() {' || chr(10) || '    // Write result code' || chr(10) || '}',
'99',
'let res: Result<i32, &str> = Ok(99); println!("{}", res.unwrap());',
5, 20);
-- Lesson 5.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Unrecoverable Errors', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the panic! macro do?',
'0',
'["It stops execution, unwinds and cleans up the stack, and quits the program with an error message","It creates a recoverable error","It reboots the application","It sends an alert to the OS"]'::jsonb,
'Use panic! when the program gets into a state it cannot logically recover from.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the macro to intentionally crash the program:',
'___!("Something went terribly wrong!");',
'panic',
'["panic","error","crash","stop"]'::jsonb,
'The panic! macro is used for unrecoverable errors.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which method is similar to .unwrap() but allows you to specify the panic message?',
'0',
'[".expect(\"msg\")",".unwrap_or()",".panic_msg()",".assert()"]'::jsonb,
'let f = File::open("x").expect("Failed to open x"); provides better debugging info than unwrap().',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to use expect on a Result:',
'[{"id":"1","code":"let res: Result<i32, &str> = Ok(1);"},{"id":"2","code":"let val = res"},{"id":"3","code":"  .expect(\"Should not fail\");"},{"id":"4","code":"println!(\"{}\", val);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["let res: Result<i32, &str> = Ok(1);","let val = res","  .expect(\"Should not fail\");","println!(\"{}\", val);"]'::jsonb,
'Declare result, assign val by calling expect on result, print val.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Print exactly: panic',
'fn main() {' || chr(10) || '    // just print it' || chr(10) || '}',
'panic',
'println!("panic");',
5, 20);
-- ==============================================================
-- UNIT 6: Generics, Traits, and Lifetimes
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 6: Generics & Traits', 'Write reusable code with Generics, Traits, and Lifetimes', 'red', 6)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Advanced Rust Types', $note$
# Generics, Traits, and Lifetimes
## Generics <T>
Generics let you write code for multiple types without duplicating it. The Rust compiler uses "monomorphization" to generate specific code for each type at compile time, meaning generics have **zero runtime cost**.
```rust
struct Point<T> {
    x: T,
    y: T,
}
let integer_point = Point { x: 5, y: 10 };
let float_point = Point { x: 1.0, y: 4.0 };

```
## Traits
A trait defines functionality a particular type has and can share with other types (similar to Interfaces in Java/C#).
```rust
trait Summary {
    fn summarize(&self) -> String;
}

struct Article { headline: String }

impl Summary for Article {
    fn summarize(&self) -> String {
        format!("Breaking: {}", self.headline)
    }
}

```
## Trait Bounds
You can use generics and traits together to say "This function takes ANY type T, *as long as* T implements the Summary trait."
```rust
fn notify<T: Summary>(item: &T) {
    println!("News! {}", item.summarize());
}

```
## Lifetimes ('a)
The borrow checker ensures references are always valid. Usually it infers how long a reference lives. Sometimes, you must annotate it with a "lifetime" to tell the compiler how the lifetimes of references relate to each other.
```rust
// 'a specifies that the returned reference lives as long as the parameters
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}

```
$note$, 0);
-- Lesson 6.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Generics', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the performance cost of using Generics in Rust?',
'0',
'["Zero runtime cost. The compiler generates specific code for each used type at compile time","A small overhead due to type checking at runtime","It relies on a garbage collector","It slows down program execution significantly"]'::jsonb,
'This process is called monomorphization. It makes compilation slower, but execution blazing fast.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the generic struct definition:',
'struct Box___ { val: T }',
'<T>',
'["<T>","(T)","{T}","[T]"]'::jsonb,
'Angle brackets specify generic type parameters.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If struct Point<T, U> { x: T, y: U }, which of the following is valid?',
'0',
'["Point { x: 5, y: 4.0 } (x and y can be different types)","Point { x: 5, y: 4 } (x and y MUST be the same type)","It is invalid syntax","T and U must be strings"]'::jsonb,
'Using two generic parameters <T, U> allows the fields to hold different types.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a generic function that just returns the item passed to it:',
'[{"id":"1","code":"fn echo<T>(item: T) -> T {"},{"id":"2","code":"  item"},{"id":"3","code":"}"},{"id":"4","code":"fn main() { println!(\"{}\", echo(10)); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["fn echo<T>(item: T) -> T {","  item","}","fn main() { println!(\"{}\", echo(10)); }"]'::jsonb,
'Function signature with <T>, implicit return body, close, main calling it.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write struct Wrap<T> { v: T }. In main, make w = Wrap{v: 8}. Print w.v. Expected: 8',
'// write struct' || chr(10) || 'fn main() {' || chr(10) || '    // make w and print' || chr(10) || '}',
'8',
'struct Wrap<T> { v: T } fn main() { let w = Wrap{v: 8}; println!("{}", w.v); }',
5, 20);
-- Lesson 6.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Traits', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What feature in other languages are Rust Traits most comparable to?',
'0',
'["Interfaces (like in Java or C#)","Classes","Structs","Macros"]'::jsonb,
'Traits define shared behavior (method signatures) that different types can implement.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax to implement a trait for a specific type:',
'impl Summary ___ Article { }',
'for',
'["for","to","on","in"]'::jsonb,
'impl Trait for Type is the standard syntax.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does #[derive(Debug)] do when placed above a struct?',
'0',
'["It automatically generates an implementation of the Debug trait so you can print the struct using {:?}","It makes the struct public","It compiles the struct in debug mode","It generates tests"]'::jsonb,
'The compiler can provide basic implementations for standard traits like Debug, Clone, and Copy.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the definition and implementation of a trait:',
'[{"id":"1","code":"trait Speak { fn speak(&self); }"},{"id":"2","code":"struct Dog {}"},{"id":"3","code":"impl Speak for Dog {"},{"id":"4","code":"  fn speak(&self) { println!(\"Bark\"); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["trait Speak { fn speak(&self); }","struct Dog {}","impl Speak for Dog {","  fn speak(&self) { println!(\"Bark\"); } }"]'::jsonb,
'Trait definition, Struct definition, impl trait for struct, body of method.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Place #[derive(Debug)] above struct A { x: i32 }. Make a = A{x:5} and print using println!("{:?}", a);. Expected: A { x: 5 }',
'// derive and struct' || chr(10) || 'fn main() {' || chr(10) || '    // instantiate and print using {:?}' || chr(10) || '}',
'A { x: 5 }',
'#[derive(Debug)] struct A { x: i32 } fn main() { let a = A{x:5}; println!("{:?}", a); }',
5, 20);
-- Lesson 6.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Trait Bounds', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the trait bound <T: Display> mean in a generic function?',
'0',
'["The function accepts any type T, as long as it implements the Display trait","It defines a struct named Display","It means T is a String","T must be equal to Display"]'::jsonb,
'Trait bounds restrict generics. If the type doesn''t implement the trait, the code won''t compile.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the impl Trait syntax, which is a shorter way to write trait bounds for parameters:',
'fn notify(item: &___ Summary) { }',
'impl',
'["impl","trait","dyn","type"]'::jsonb,
'item: &impl Summary means "item is a reference to some type that implements Summary".',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How can you specify multiple trait bounds for a single generic type?',
'0',
'["Using the + syntax (e.g., <T: Display + Clone>)","Using a comma (e.g., <T: Display, Clone>)","Using && (e.g., <T: Display && Clone>)","It is not possible"]'::jsonb,
'The + operator enforces that T must implement ALL specified traits.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a generic function using a trait bound:',
'[{"id":"1","code":"fn print_it<T: std::fmt::Display>"},{"id":"2","code":"(item: T) {"},{"id":"3","code":"  println!(\"{}\", item);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["fn print_it<T: std::fmt::Display>","(item: T) {","  println!(\"{}\", item);","}"]'::jsonb,
'Signature with bound, parameters, body, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Print exactly: trait bounds',
'fn main() {' || chr(10) || '    // print it' || chr(10) || '}',
'trait bounds',
'println!("trait bounds");',
5, 20);
-- Lesson 6.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Lifetimes', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the primary purpose of lifetime annotations in Rust?',
'0',
'["To tell the borrow checker how long references are valid, preventing dangling pointers","To tell the garbage collector when to delete an object","To set a timeout for functions","To restrict file access"]'::jsonb,
'Lifetimes do not change how long a value lives; they just describe the relationships between the lifespans of references.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax for explicitly annotating a lifetime parameter (usually pronounced "tick a"):',
'fn longest<___>(x: &str) {}',
'''a',
'["''a","&a","a","$a"]'::jsonb,
'Lifetime parameters start with an apostrophe (tick) and are conventionally named ''a, ''b, etc.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If a function returns a reference, what must its lifetime be tied to?',
'0',
'["One of the parameters passed into the function","A new variable created inside the function","The static lifetime","The heap"]'::jsonb,
'You cannot return a reference to a variable created inside the function because that variable will be dropped when the function ends (creating a dangling pointer).',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a struct that holds a reference (requires a lifetime annotation):',
'[{"id":"1","code":"struct RefBox<''a> {"},{"id":"2","code":"  val: &''a str,"},{"id":"3","code":"}"},{"id":"4","code":"// Holds a string slice"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["struct RefBox<''a> {","  val: &''a str,","}","// Holds a string slice"]'::jsonb,
'Struct declaration with lifetime, field with lifetime, close struct, comment.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Print exactly: lifetimes',
'fn main() {' || chr(10) || '    // print it' || chr(10) || '}',
'lifetimes',
'println!("lifetimes");',
5, 20);
END $$;

