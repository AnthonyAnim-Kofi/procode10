-- ============================================================
-- REAL JAVA CURRICULUM
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

  -- Prefer slug 'java' (used by the app)
  SELECT id INTO v_lang_id
  FROM public.languages
  WHERE slug = 'java'
  LIMIT 1;

  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('Java', 'java', '☕', 'A high-level, class-based, object-oriented language designed to run anywhere')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: Getting Started with Java
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id, 'Unit 1: Getting Started', 'Write your first Java programs and understand the JVM', 'blue', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to Java', $note$
# Introduction to Java

Java is a popular, class-based, object-oriented programming language created by Sun Microsystems (now owned by Oracle) in 1995. Its mantra is "Write Once, Run Anywhere" because Java code is compiled into bytecode that runs on the Java Virtual Machine (JVM).

## Your First Program

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}

```

Breaking it down:

* `public class Main` — Every Java program must have at least one class, and the filename must match the public class name (e.g., `Main.java`).
* `public static void main(String[] args)` — The entry point of every Java application.
* `System.out.println("...");` — Prints text to the console and adds a new line.
* Every statement ends with a semicolon `;`.

## How Java Runs

1. Write `Main.java`
2. Compile: `javac Main.java` (Creates `Main.class` bytecode)
3. Run: `java Main` (The JVM executes the bytecode)

## Variables and Types

Java is statically typed — you must explicitly declare the data type.

```java
int age = 25;
double price = 19.99;
char grade = 'A';       // Single quotes for chars
boolean active = true;
String name = "Alice";  // Double quotes for Strings (String is an object, capital 'S')

```

## Input (Scanner)

To read input from the user, Java uses the `Scanner` class.

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your name: ");
        String name = scanner.nextLine();
        System.out.println("Hello, " + name);
    }
}

```

## Key Takeaways

* Every Java program requires a `class` and a `main` method.
* Capitalization matters: `String` is capitalized because it is a class, while `int`, `double`, and `boolean` are lowercase primitives.
* Use `System.out.print()` for output without a newline, and `println()` with a newline.
* Code is compiled to bytecode `.class` files, not raw machine code.
$note$, 0);
-- Lesson 1.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Hello, Java!', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the mandatory entry point method for a Java application?',
'0',
'["public static void main(String[] args)","void start()","public void Main()","int main()"]'::jsonb,
'The JVM specifically looks for `public static void main(String[] args)` to start execution.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the command to output text with a newline:',
'System.out.___("Hello!");',
'println',
'["println","print","write","log"]'::jsonb,
'`println` prints the string and then moves the cursor to a new line.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which component allows Java to achieve its "Write Once, Run Anywhere" capability?',
'0',
'["The Java Virtual Machine (JVM)","The C++ Compiler","The HTML Browser","The Operating System Kernel"]'::jsonb,
'Java compiles to bytecode, which the JVM translates into machine code specific to the host operating system.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the lines to create a working Hello World program:',
'[{"id":"1","code":"public class Hello {"},{"id":"2","code":"  public static void main(String[] args) {"},{"id":"3","code":"    System.out.println(\"Hi\");"},{"id":"4","code":"  }"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["public class Hello {","  public static void main(String[] args) {","    System.out.println(\"Hi\");","  }","}"]'::jsonb,
'Class definition, main method, print statement, close main, close class.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write a Java program that prints: Hello Java',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Write your code here' || chr(10) || '    }' || chr(10) || '}',
'Hello Java',
'System.out.println("Hello Java");',
5, 20);
-- Lesson 1.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Variables and Primitives', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which data type is a reference type (an object) in Java, not a primitive?',
'0',
'["String","int","boolean","char"]'::jsonb,
'Primitives in Java are lowercase. `String` is capitalized because it is a full class.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the type for a true/false variable:',
'___ isOnline = true;',
'boolean',
'["boolean","bool","bit","flag"]'::jsonb,
'Unlike C++ and C# which use `bool`, Java uses the full word `boolean`.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the result of `5 / 2` when both operands are `int` in Java?',
'0',
'["2", "2.5", "3", "Error"]'::jsonb,
'Integer division truncates the decimal portion. To get 2.5, you must use doubles: `5.0 / 2`.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Declare a double, an int, and a String in that order:',
'[{"id":"1","code":"double price = 4.99;"},{"id":"2","code":"int quantity = 10;"},{"id":"3","code":"String item = \"Book\";"},{"id":"4","code":"System.out.println(item);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["double price = 4.99;","int quantity = 10;","String item = \"Book\";","System.out.println(item);"]'::jsonb,
'double first, int second, String third, then output.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Declare an `int` named `score` = 100, and print it.',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Declare and print' || chr(10) || '    }' || chr(10) || '}',
'100',
'int score = 100; System.out.println(score);',
5, 20);
-- Lesson 1.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Scanner and Input', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which package must you import to use the Scanner class?',
'0',
'["java.util.Scanner","java.io.Scanner","java.sys.Scanner","java.lang.Scanner"]'::jsonb,
'The Scanner class is located in the `java.util` utility package.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the instantiation of a new Scanner reading from the console:',
'Scanner scan = new Scanner(System.___);',
'in',
'["in","out","console","read"]'::jsonb,
'`System.in` represents standard input (the keyboard), just as `System.out` is standard output.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which method reads a full line of string input from the user?',
'0',
'["nextLine()","nextString()","readLine()","getLine()"]'::jsonb,
'`nextLine()` reads all text until the user presses Enter.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to read an integer from the user:',
'[{"id":"1","code":"import java.util.Scanner;"},{"id":"2","code":"Scanner scan = new Scanner(System.in);"},{"id":"3","code":"int age = scan.nextInt();"},{"id":"4","code":"System.out.println(age);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["import java.util.Scanner;","Scanner scan = new Scanner(System.in);","int age = scan.nextInt();","System.out.println(age);"]'::jsonb,
'Import, instantiate Scanner, call nextInt(), print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Use concatenation to print "Your id is 50" where 50 comes from `int id = 50;`.',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        int id = 50;' || chr(10) || '        // Print result' || chr(10) || '    }' || chr(10) || '}',
'Your id is 50',
'System.out.println("Your id is " + id);',
5, 20);
-- Lesson 1.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Type Casting and Parsing', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you manually cast a `double` variable `d` into an `int` in Java?',
'0',
'["(int) d","int(d)","d.toInt()","cast(d)"]'::jsonb,
'Java uses C-style casting: `(TargetType) value`. This truncates the decimal.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the method to parse a String into an int:',
'int x = Integer.___("42");',
'parseInt',
'["parseInt","parse","toInteger","valueOf"]'::jsonb,
'`Integer.parseInt(String)` is the standard way to convert text to a primitive int.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is implicit casting (widening) in Java?',
'0',
'["When Java automatically converts a smaller type (like int) to a larger type (like double)","When a double is converted to an int automatically","When a String becomes an int","When an object becomes a primitive"]'::jsonb,
'Going from `int` to `double` is safe and happens automatically: `double d = 5;` becomes `5.0`.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange the code to safely divide two integers and get a decimal result:',
'[{"id":"1","code":"int a = 5; int b = 2;"},{"id":"2","code":"double result = (double) a / b;"},{"id":"3","code":"System.out.println(result);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["int a = 5; int b = 2;","double result = (double) a / b;","System.out.println(result);"]'::jsonb,
'Declare ints, cast one to double during division, print result (2.5).',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Cast the double `9.9` to an `int` and print it. Expected: 9',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        double d = 9.9;' || chr(10) || '        // Cast and print' || chr(10) || '    }' || chr(10) || '}',
'9',
'System.out.println((int) d);',
5, 20);
-- ==============================================================
-- UNIT 2: Control Flow
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 2: Control Flow', 'Make decisions and repeat code with loops and conditionals', 'green', 2)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Control Flow in Java', $note$

# Control Flow in Java

## if / else if / else

```java
int score = 85;

if (score >= 90) {
    System.out.println("A");
} else if (score >= 80) {
    System.out.println("B");
} else {
    System.out.println("F");
}

```

## String Equality

**CRITICAL RULE:** Never use `==` to compare Strings in Java. `==` checks if they are the exact same object in memory. Use `.equals()` to check if the text is the same.

```java
String a = new String("hello");
String b = new String("hello");

System.out.println(a == b);      // false!
System.out.println(a.equals(b)); // true!

```

## switch Statement

```java
int day = 3;
switch (day) {
    case 1: 
        System.out.println("Mon"); 
        break; // break is required to stop fall-through!
    case 2: 
        System.out.println("Tue"); 
        break;
    default: 
        System.out.println("Other");
}

```

## for Loop

Used when you know exactly how many times to loop.

```java
for (int i = 0; i < 5; i++) {
    System.out.println(i);
}

```

## while Loop

Used when you want to loop as long as a condition is true.

```java
int i = 0;
while (i < 3) {
    System.out.println(i);
    i++;
}

```

## break and continue

* `break` completely exits the loop.
* `continue` skips the current iteration and jumps to the next one.

## Key Takeaways

* Use `.equals()` for Strings, NOT `==`.
* `switch` requires `break` statements.
* `&&` is logical AND, `||` is logical OR.
$note$, 0);
-- Lesson 2.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'If/Else and String Equality', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How must you compare if two Strings contain the exact same text in Java?',
'0',
'["string1.equals(string2)","string1 == string2","string1.isEqual(string2)","string1 = string2"]'::jsonb,
'`==` compares object references (memory addresses). `.equals()` compares the actual text content.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the condition to check if a user is logged in OR is an admin:',
'if (isLoggedIn ___ isAdmin) { System.out.println("Access"); }',
'||',
'["||","&&","OR","|"]'::jsonb,
'The logical OR operator is `||`. It evaluates to true if at least one side is true.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the output of `System.out.println(10 > 5 ? "Yes" : "No");`?',
'0',
'["Yes","No","true","Error"]'::jsonb,
'The ternary operator `condition ? trueValue : falseValue` evaluates 10 > 5 as true.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange an if/else block that correctly compares a password:',
'[{"id":"1","code":"String pass = \"1234\";"},{"id":"2","code":"if (pass.equals(\"1234\")) {"},{"id":"3","code":"  System.out.println(\"Welcome\");"},{"id":"4","code":"} else {"},{"id":"5","code":"  System.out.println(\"Denied\"); }"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["String pass = \"1234\";","if (pass.equals(\"1234\")) {","  System.out.println(\"Welcome\");","} else {","  System.out.println(\"Denied\"); }"]'::jsonb,
'Declare String, use .equals(), print true case, open else, print false case.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Print "Even" if `n = 4` is divisible by 2, else print "Odd". Expected: Even',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        int n = 4;' || chr(10) || '        // Write if/else' || chr(10) || '    }' || chr(10) || '}',
'Even',
'if (n % 2 == 0) System.out.println("Even"); else System.out.println("Odd");',
5, 20);
-- Lesson 2.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Loops (for & while)', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which loop guarantees that its body will execute at least once?',
'0',
'["do-while loop","while loop","for loop","enhanced for loop"]'::jsonb,
'The `do-while` loop executes the body first, then checks the condition at the end.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the for loop to run exactly 5 times (0 to 4):',
'for (int i = 0; i ___ 5; i++) { }',
'<',
'["<","<=","==","->"]'::jsonb,
'Starting at 0 and checking strictly less than `< 5` is the standard idiom for 5 iterations.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `continue` keyword do inside a loop?',
'0',
'["Skips the rest of the current iteration and jumps to the next one","Exits the loop entirely","Restarts the program","Nothing"]'::jsonb,
'`continue` bypasses the remaining code in the loop body for that specific iteration.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a while loop that prints 10 down to 1:',
'[{"id":"1","code":"int i = 10;"},{"id":"2","code":"while (i > 0) {"},{"id":"3","code":"  System.out.println(i);"},{"id":"4","code":"  i--;"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["int i = 10;","while (i > 0) {","  System.out.println(i);","  i--;","}"]'::jsonb,
'Initialize i=10, condition > 0, print i, decrement, close loop.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Use a `for` loop to print numbers 1, 2, 3 on separate lines.',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Loop and print' || chr(10) || '    }' || chr(10) || '}',
'1' || chr(10) || '2' || chr(10) || '3',
'for(int i=1; i<=3; i++) System.out.println(i);',
5, 20);
-- Lesson 2.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Switch Statements', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you omit the `break;` statement at the end of a switch case in Java?',
'0',
'["Execution falls through and runs the code in the next case(s)","The compiler throws an error","The switch exits normally","The default case runs"]'::jsonb,
'Unlike C#, Java allows "fall-through". You must manually include `break` to stop it.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the keyword that acts as the "else" for a switch statement:',
'___: System.out.println("Unknown case");',
'default',
'["default","else","case else","otherwise"]'::jsonb,
'The `default:` label is matched if no other cases match.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you use a `String` in a switch statement in modern Java?',
'0',
'["Yes, Strings have been supported since Java 7","No, only integers and chars","No, only enums","Yes, but you must cast it to int"]'::jsonb,
'Java 7 introduced the ability to switch on Strings, comparing them using `.equals()` automatically.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a switch statement for a grade:',
'[{"id":"1","code":"char grade = ''A'';"},{"id":"2","code":"switch (grade) {"},{"id":"3","code":"  case ''A'': System.out.println(\"Excellent\"); break;"},{"id":"4","code":"  default: System.out.println(\"Study harder\");"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["char grade = ''A'';","switch (grade) {","  case ''A'': System.out.println(\"Excellent\"); break;","  default: System.out.println(\"Study harder\");","}"]'::jsonb,
'Declare char, switch on it, case A with break, default, close switch.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write a switch on `code = 404`. If 404, print "Not Found". Provide a default. Expected: Not Found',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        int code = 404;' || chr(10) || '        // Write switch' || chr(10) || '    }' || chr(10) || '}',
'Not Found',
'switch(code){ case 404: System.out.println("Not Found"); break; default: break; }',
5, 20);
-- Lesson 2.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Enhanced For Loop (For-Each)', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the syntax for the Enhanced For Loop (For-Each) in Java?',
'0',
'["for (Type item : collection) { ... }","for (item in collection) { ... }","foreach (Type item in collection) { ... }","for (Type item of collection) { ... }"]'::jsonb,
'Java uses a colon `:` to separate the variable from the collection.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the loop to iterate through an array of Strings called `names`:',
'for (String n ___ names) { System.out.println(n); }',
':',
'[":","in","of","->"]'::jsonb,
'The colon `:` means "in" when used within an enhanced for loop in Java.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a limitation of the enhanced for loop?',
'0',
'["You do not have access to the index number (like i)","It can only run 10 times","It cannot be used on arrays","It is slower than a regular for loop"]'::jsonb,
'If you need to know the index of the item you are modifying, or need to modify the array backwards, you must use a traditional `for` loop.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange code to loop over an array of scores:',
'[{"id":"1","code":"int[] scores = { 10, 20, 30 };"},{"id":"2","code":"for (int s : scores) {"},{"id":"3","code":"  System.out.println(s);"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["int[] scores = { 10, 20, 30 };","for (int s : scores) {","  System.out.println(s);","}"]'::jsonb,
'Declare array, enhanced for loop with colon, print inside, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given `int[] arr = {7, 8};`, use an enhanced for loop to print each element on a new line.',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        int[] arr = { 7, 8 };' || chr(10) || '        // Write for-each loop' || chr(10) || '    }' || chr(10) || '}',
'7' || chr(10) || '8',
'for(int num : arr) { System.out.println(num); }',
5, 20);
-- ==============================================================
-- UNIT 3: Methods
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 3: Methods', 'Organize your code into reusable blocks', 'orange', 3)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Methods in Java', $note$

# Methods in Java

Methods (functions) allow you to break your program into reusable pieces. In Java, all methods must be declared inside a class.

## Defining a Method

```java
public class Calculator {
    // public: accessible from anywhere
    // static: belongs to the class, not an object
    // int: return type
    public static int add(int a, int b) {
        return a + b; // return passes the value back
    }

    public static void main(String[] args) {
        int sum = add(5, 10);
        System.out.println(sum); // 15
    }
}

```

## void Return Type

If a method performs an action but doesn't return any data, use the `void` keyword.

```java
public static void printWelcome(String name) {
    System.out.println("Welcome, " + name);
}

```

## Method Overloading

Java allows multiple methods with the *exact same name*, as long as their parameter lists are different (different types or different number of parameters).

```java
public static int multiply(int a, int b) {
    return a * b;
}

// Overloaded method: Takes doubles instead of ints
public static double multiply(double a, double b) {
    return a * b;
}

```

The Java compiler automatically determines which method to call based on the arguments you pass.

## Scope

Variables declared inside a method only exist inside that method. This is called **local scope**.

## Key Takeaways

* The return type must match the type of the value being returned.
* `void` means no return value.
* Overloading allows same-named methods with different signatures.
* `static` methods can be called directly without instantiating the class with `new`.
$note$, 0);
-- Lesson 3.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Defining and Calling Methods', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the return type of a method that does not return any data to its caller?',
'0',
'["void","null","empty","static"]'::jsonb,
'`void` literally means "empty" or "nothing" in this context.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the method signature that returns a text string:',
'public static ___ getRole() { return "Admin"; }',
'String',
'["String","void","text","char"]'::jsonb,
'The return type `String` specifies that the method will return an object of type String.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why do we often use `static` for methods in a simple `Main` class?',
'0',
'["It allows the main method (which is static) to call them directly without needing to create an object of the Main class first","It makes the method faster","It protects the code from being overridden","It is required for all Java methods"]'::jsonb,
'A static method belongs to the class itself. `public static void main` can easily call other `static` methods in the same class.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a complete class with a method that doubles a number:',
'[{"id":"1","code":"public class Main {"},{"id":"2","code":"  public static int doubleIt(int n) { return n * 2; }"},{"id":"3","code":"  public static void main(String[] args) {"},{"id":"4","code":"    System.out.println(doubleIt(5)); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["public class Main {","  public static int doubleIt(int n) { return n * 2; }","  public static void main(String[] args) {","    System.out.println(doubleIt(5)); } }"]'::jsonb,
'Class open, helper method definition, main method calling the helper, close braces.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write `public static int add(int a, int b)` that returns their sum. Call it in main with 3 and 7, and print it. Expected: 10',
'public class Main {' || chr(10) || '    // Write add method here' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Call add and print' || chr(10) || '    }' || chr(10) || '}',
'10',
'public static int add(int a, int b) { return a + b; } ... System.out.println(add(3, 7));',
5, 20);
-- Lesson 3.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Method Overloading', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is method overloading in Java?',
'0',
'["Creating multiple methods with the exact same name but different parameter lists","Creating a method that takes too many parameters","Overriding a parent class method","Returning a different type from the same method"]'::jsonb,
'Overloading allows methods like `System.out.println()` to accept an `int`, a `String`, or a `double` using the same method name.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the parameter to overload the existing `void log(String msg)` method:',
'public static void log(String msg, ___ level) { }',
'int',
'["int","String","void","return"]'::jsonb,
'Adding a second parameter (like an int) changes the method signature, making it a valid overload.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Can you overload a method by ONLY changing its return type (e.g., `int calc()` vs `double calc()`)?',
'0',
'["No, the parameter list must be different for the compiler to distinguish them","Yes, changing the return type is enough","Yes, but only if they are private","No, overloading only works for constructors"]'::jsonb,
'The compiler determines which method to call based on the arguments passed, not what you plan to do with the return value.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange overloaded methods to calculate area for a square and a rectangle:',
'[{"id":"1","code":"public static int area(int side) {"},{"id":"2","code":"  return side * side; }"},{"id":"3","code":"public static int area(int len, int width) {"},{"id":"4","code":"  return len * width; }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["public static int area(int side) {","  return side * side; }","public static int area(int len, int width) {","  return len * width; }"]'::jsonb,
'First method (1 param) and its body, then second method (2 params) and its body.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Call the overloaded `print` method twice in main: first with `5`, then with `"Five"`.',
'public class Main {' || chr(10) || '    public static void print(int n) { System.out.println("Num: " + n); }' || chr(10) || '    public static void print(String s) { System.out.println("Str: " + s); }' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Call print twice' || chr(10) || '    }' || chr(10) || '}',
'Num: 5' || chr(10) || 'Str: Five',
'print(5); print("Five");',
5, 20);
-- Lesson 3.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Scope and Recursion', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is block scope in Java?',
'0',
'["Variables declared inside curly braces {} are only visible and usable within those braces","Variables are visible anywhere in the class","Variables can be used across multiple files","Variables that cannot be changed"]'::jsonb,
'If you declare `int x = 5;` inside an `if` statement, you cannot print `x` outside of that `if` statement.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the base case for a recursive factorial method:',
'if (n <= ___) return 1;',
'1',
'["1", "0", "n", "-1"]'::jsonb,
'A recursive method must have a base case to stop calling itself. For factorial, 1! is 1.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if a recursive method lacks a base case?',
'0',
'["It will call itself infinitely until the JVM throws a StackOverflowError","It will return 0","It will crash the compiler","It will run once and stop"]'::jsonb,
'Every method call is pushed onto the call stack. Infinite recursion fills the stack memory, causing an error.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a recursive countdown method:',
'[{"id":"1","code":"public static void count(int n) {"},{"id":"2","code":"  if (n <= 0) return;"},{"id":"3","code":"  System.out.println(n);"},{"id":"4","code":"  count(n - 1);"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["public static void count(int n) {","  if (n <= 0) return;","  System.out.println(n);","  count(n - 1);","}"]'::jsonb,
'Method signature, base case, action (print), recursive step, close brace.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Call `factorial(4)` and print the result. Expected: 24',
'public class Main {' || chr(10) || '    public static int factorial(int n) {' || chr(10) || '        if (n <= 1) return 1;' || chr(10) || '        return n * factorial(n - 1);' || chr(10) || '    }' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Call and print' || chr(10) || '    }' || chr(10) || '}',
'24',
'System.out.println(factorial(4));',
5, 20);
-- Lesson 3.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Pass by Value', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How does Java pass primitive variables (like `int` or `double`) to methods?',
'0',
'["Strictly by value (a copy of the variable is passed)","By reference","As a pointer","As a global variable"]'::jsonb,
'If you pass `int x = 5` to a method and the method changes it to 10, the original `x` remains 5.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'When you pass an Object (like an array) to a method, you are passing the value of the ___, so modifying its contents affects the original:',
'// Passes the object''s ___',
'reference',
'["reference","value","pointer","size"]'::jsonb,
'Java is always pass-by-value. However, for objects, the "value" passed is the reference (memory address) to the object.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the output?' || chr(10) || 'void change(int x) { x = 10; }' || chr(10) || 'int y = 5; change(y); System.out.print(y);',
'0',
'["5", "10", "Error", "0"]'::jsonb,
'Because primitives are passed by value, the `x` inside the method is a separate copy from `y`. `y` remains 5.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange code showing that arrays (objects) are modified when passed:',
'[{"id":"1","code":"public static void modify(int[] arr) {"},{"id":"2","code":"  arr[0] = 99; }"},{"id":"3","code":"public static void main(String[] args) {"},{"id":"4","code":"  int[] nums = { 1 }; modify(nums); System.out.println(nums[0]); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["public static void modify(int[] arr) {","  arr[0] = 99; }","public static void main(String[] args) {","  int[] nums = { 1 }; modify(nums); System.out.println(nums[0]); }"]'::jsonb,
'Method definition, modify array, main method, declare array and call method.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write `static int square(int x) { return x * x; }`. Pass `y = 4` to it and print the result. Expected: 16',
'public class Main {' || chr(10) || '    // Write square method' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        int y = 4;' || chr(10) || '        // Call and print' || chr(10) || '    }' || chr(10) || '}',
'16',
'public static int square(int x) { return x * x; } ... System.out.println(square(y));',
5, 20);
-- ==============================================================
-- UNIT 4: Arrays and Collections
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 4: Arrays & Collections', 'Store multiple values using Arrays, ArrayLists, and HashMaps', 'purple', 4)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Collections in Java', $note$

# Arrays and Collections in Java

## Arrays (Fixed Size)

Standard arrays in Java have a fixed length. Once created, they cannot grow or shrink.

```java
int[] scores = new int[3]; // Array of 3 integers
scores[0] = 90;
scores[1] = 85;
scores[2] = 100;

// Shortcut:
String[] names = {"Alice", "Bob"};
System.out.println(names.length); // 2 (No parentheses on length!)

```

## ArrayList (Dynamic Size)

`ArrayList` is part of the `java.util` package. It grows automatically when you add items.
*Note: Collections like ArrayList can only hold Objects. Use Wrapper classes like `Integer` instead of `int`.*

```java
import java.util.ArrayList;

ArrayList<String> list = new ArrayList<>();
list.add("Apple");
list.add("Banana");
list.remove("Apple");

System.out.println(list.size()); // 1 (Use size() for collections)
System.out.println(list.get(0)); // Banana (Use get(), not [])

```

## HashMap (Key-Value Pairs)

`HashMap` stores data in Key-Value pairs, allowing fast lookups.

```java
import java.util.HashMap;

HashMap<String, Integer> ages = new HashMap<>();
ages.put("Anthony", 22);
ages.put("Sarah", 21);

System.out.println(ages.get("Anthony")); // 22

```

## String Manipulation

Strings are immutable in Java (they cannot be changed once created). Methods return *new* Strings.

```java
String word = "Hello";
System.out.println(word.toUpperCase()); // "HELLO"
System.out.println(word.substring(0, 4)); // "Hell"

```

## Key Takeaways

* Use Arrays `[]` when the size is fixed. Use `.length`.
* Use `ArrayList` when you need to add/remove items dynamically. Use `.size()` and `.get()`.
* Use `HashMap` for fast key-value lookups. Use `.put()` and `.get()`.
* Generics `<String>` force collections to only accept a specific type.
$note$, 0);
-- Lesson 4.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Arrays', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is a primary limitation of standard Arrays `[]` in Java?',
'0',
'["Their size is fixed upon creation and cannot be changed","They can only hold integers","They cannot be looped over","They are slower than ArrayLists"]'::jsonb,
'If you write `new int[5]`, that array will always hold exactly 5 elements.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration of a 5-element integer array:',
'int[] nums = ___ int[5];',
'new',
'["new","create","make","array"]'::jsonb,
'Arrays are objects in Java, so they must be instantiated with the `new` keyword.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which property gives you the capacity of a standard array?',
'0',
'["array.length","array.size()","array.length()","array.capacity"]'::jsonb,
'For arrays, `length` is a property (no parentheses). For Strings, `length()` is a method.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create an array, set the first element, and print it:',
'[{"id":"1","code":"String[] colors = new String[3];"},{"id":"2","code":"colors[0] = \"Red\";"},{"id":"3","code":"System.out.println(colors[0]);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["String[] colors = new String[3];","colors[0] = \"Red\";","System.out.println(colors[0]);"]'::jsonb,
'Instantiate array, assign index 0, print index 0.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create an integer array with values {5, 10, 15}. Print the third value. Expected: 15',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Array and print' || chr(10) || '    }' || chr(10) || '}',
'15',
'int[] arr = {5, 10, 15}; System.out.println(arr[2]);',
5, 20);
-- Lesson 4.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'ArrayLists', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why must you use `ArrayList<Integer>` instead of `ArrayList<int>`?',
'0',
'["Java Collections can only hold Objects, so primitives must use their Wrapper Classes","Integer is faster than int","int is not a valid keyword","ArrayLists only hold Strings"]'::jsonb,
'Primitives (int, double, boolean) cannot be put into generic collections directly. Use Integer, Double, Boolean.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the method to add an item to an ArrayList:',
'list.___("New Item");',
'add',
'["add","push","append","insert"]'::jsonb,
'Use `.add()` to append to an ArrayList.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you retrieve the item at index 0 from an ArrayList called `list`?',
'0',
'["list.get(0)","list[0]","list.at(0)","list.fetch(0)"]'::jsonb,
'Unlike standard arrays, you cannot use bracket notation `[]` on an ArrayList in Java.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Create an ArrayList, add an item, and print the total count:',
'[{"id":"1","code":"import java.util.ArrayList;"},{"id":"2","code":"ArrayList list = new ArrayList<>();"},{"id":"3","code":"list.add(\"Study\");"},{"id":"4","code":"System.out.println(list.size());"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["import java.util.ArrayList;","ArrayList list = new ArrayList<>();","list.add(\"Study\");","System.out.println(list.size());"]'::jsonb,
'Import, instantiate, add, print size().',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create an `ArrayList<Integer>`. Add 50, then 60. Print index 1 using `.get()`. Expected: 60',
'import java.util.ArrayList;' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // List, add, print' || chr(10) || '    }' || chr(10) || '}',
'60',
'ArrayList list = new ArrayList<>(); list.add(50); list.add(60); System.out.println(list.get(1));',
5, 20);
-- Lesson 4.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'HashMaps', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the structure of data inside a `HashMap<K, V>`?',
'0',
'["Key-Value pairs where each Key is unique","An ordered list of items","A set of random numbers","A 2D Array"]'::jsonb,
'HashMaps are perfect for lookups. E.g., looking up a Student Object using their String index number.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the method to add a key-value pair to a HashMap:',
'map.___("HP", 100);',
'put',
'["put","add","set","insert"]'::jsonb,
'HashMaps use `.put(key, value)` to add or update entries.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What happens if you use `.put("Key", 5)` and then `.put("Key", 10)` in a HashMap?',
'0',
'["The value 10 overwrites the value 5 for that key","An Exception is thrown","Both values are kept in a list","The map ignores the second put"]'::jsonb,
'Keys must be unique. `put` will update the value if the key already exists.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange code to map a username to a role and retrieve it:',
'[{"id":"1","code":"import java.util.HashMap;"},{"id":"2","code":"HashMap<String, String> roles = new HashMap<>();"},{"id":"3","code":"roles.put(\"Anthony\", \"Admin\");"},{"id":"4","code":"System.out.println(roles.get(\"Anthony\"));"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["import java.util.HashMap;","HashMap<String, String> roles = new HashMap<>();","roles.put(\"Anthony\", \"Admin\");","System.out.println(roles.get(\"Anthony\"));"]'::jsonb,
'Import, instantiate, put pair, get pair and print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create a `HashMap<String, Integer>`. Put key "MP" with value 50. Print the value of "MP". Expected: 50',
'import java.util.HashMap;' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Map, put, print' || chr(10) || '    }' || chr(10) || '}',
'50',
'HashMap<String, Integer> map = new HashMap<>(); map.put("MP", 50); System.out.println(map.get("MP"));',
5, 20);
-- Lesson 4.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'String Manipulation', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does it mean that Strings are "immutable" in Java?',
'0',
'["Once a String object is created, its data cannot be changed. String methods return a NEW String","Strings cannot contain numbers","Strings cannot be passed to methods","Strings are automatically converted to char arrays"]'::jsonb,
'Because they are immutable, `word.toUpperCase()` does nothing to `word` unless you assign it: `word = word.toUpperCase()`.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the method to get a portion of a string:',
'String part = word.___ (0, 4);',
'substring',
'["substring","split","slice","substr"]'::jsonb,
'`.substring(start, end)` extracts characters from the start index up to (but not including) the end index.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does `String.split(",")` return?',
'0',
'["An array of Strings `String[]` separated by commas","A single String with commas removed","An ArrayList of Strings","A character array `char[]`"]'::jsonb,
'`split()` is the primary way to parse CSV files or space-separated user inputs.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange code to convert a string to uppercase and print it:',
'[{"id":"1","code":"String msg = \"hello\";"},{"id":"2","code":"String upper = msg.toUpperCase();"},{"id":"3","code":"System.out.println(upper);"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["String msg = \"hello\";","String upper = msg.toUpperCase();","System.out.println(upper);"]'::jsonb,
'Declare, call toUpperCase(), print.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Print the first 3 characters of `word = "Computer"` using `.substring()`. Expected: Com',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        String word = "Computer";' || chr(10) || '        // Substring and print' || chr(10) || '    }' || chr(10) || '}',
'Com',
'System.out.println(word.substring(0, 3));',
5, 20);
-- ==============================================================
-- UNIT 5: Object-Oriented Programming (OOP)
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 5: Classes & OOP', 'Build robust applications using Classes, Encapsulation, and Inheritance', 'teal', 5)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'OOP in Java', $note$

# Object-Oriented Programming in Java

## Classes and Objects

A `class` is a blueprint. An `object` is a specific instance in memory created from that blueprint using the `new` keyword.

```java
class Car {
    String brand;
    
    // Constructor (runs when `new Car()` is called)
    public Car(String b) {
        brand = b;
    }
    
    public void honk() {
        System.out.println("Beep!");
    }
}

// In main method:
Car myCar = new Car("Toyota");
myCar.honk();

```

## Encapsulation

Good OOP practice hides internal data using `private`, and exposes it safely using `public` getter and setter methods.

```java
class Student {
    private int score; // Hidden

    // Getter
    public int getScore() { return score; }

    // Setter with validation
    public void setScore(int s) {
        if (s >= 0) score = s;
    }
}

```

## Inheritance (`extends`)

A class can inherit fields and methods from ONE parent class using `extends`.

```java
class Animal {
    public void speak() { System.out.println("..."); }
}

class Dog extends Animal {
    // Overriding the parent's method
    @Override
    public void speak() { System.out.println("Woof"); }
}

```

## Interfaces (`implements`)

Interfaces define a contract. A class can implement MULTIPLE interfaces.

```java
interface Payable {
    void pay(); // Abstract method (no body)
}

class Employee implements Payable {
    public void pay() {
        System.out.println("Paid Salary");
    }
}

```

## Key Takeaways

* Use `private` fields and `public` getters/setters (Encapsulation).
* Use `extends` to inherit from a class. Java does NOT support multiple inheritance for classes.
* Use `implements` to sign a contract with an interface.
* `@Override` is a helpful annotation to ensure you correctly replaced a parent's method.
$note$, 0);
-- Lesson 5.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Classes and Constructors', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the purpose of a Constructor in a Java class?',
'0',
'["To initialize the object''s data when it is created with the `new` keyword","To destroy the object","To define the return type","To make the class static"]'::jsonb,
'The constructor is a special method with the exact same name as the class and no return type.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the code to create a new instance of the User class:',
'User u = ___ User();',
'new',
'["new","create","make","init"]'::jsonb,
'Classes are reference types. You must allocate them in memory using `new`.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'If you don''t write a constructor for a class, what happens?',
'0',
'["The Java compiler automatically provides a parameterless default constructor","You cannot instantiate the class","The class is marked as static","A compile-time error occurs"]'::jsonb,
'If you write NO constructors, Java gives you an empty one automatically. If you write one with parameters, the automatic one is removed.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a simple Player class with a constructor:',
'[{"id":"1","code":"class Player {"},{"id":"2","code":"  public String name;"},{"id":"3","code":"  public Player(String n) { name = n; }"},{"id":"4","code":"}"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Player {","  public String name;","  public Player(String n) { name = n; }","}"]'::jsonb,
'Class, public field, constructor matching class name setting the field, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Create an instance of `Box` passing `10` to the constructor. Print its `size`. Expected: 10',
'class Box { public int size; public Box(int s) { size = s; } }' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Instantiate Box and print size' || chr(10) || '    }' || chr(10) || '}',
'10',
'Box b = new Box(10); System.out.println(b.size);',
5, 20);
-- Lesson 5.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Encapsulation', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why do we mark fields as `private` and provide public `get` and `set` methods?',
'0',
'["To hide internal state and allow validation before changing data (Encapsulation)","To make the code run faster","Because the Java compiler requires it","To save memory"]'::jsonb,
'If `score` is public, anyone can set it to -500. If it is private, the `setScore` method can block negative numbers.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the access modifier to hide the password field:',
'___ String password;',
'private',
'["private","hidden","protected","public"]'::jsonb,
'`private` fields cannot be accessed by code outside of the class they are declared in.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `this` keyword refer to in Java?',
'0',
'["The current instance (object) of the class","The parent class","The main method","A static variable"]'::jsonb,
'When a parameter name shadows a field name (e.g., `this.name = name`), `this` clarifies that you mean the object''s field.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a class with a private field and a getter/setter:',
'[{"id":"1","code":"class User {"},{"id":"2","code":"  private int age;"},{"id":"3","code":"  public int getAge() { return age; }"},{"id":"4","code":"  public void setAge(int a) { age = a; }"},{"id":"5","code":"}"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["class User {","  private int age;","  public int getAge() { return age; }","  public void setAge(int a) { age = a; }","}"]'::jsonb,
'Class open, private field, public getter, public setter, close.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Set `c.setName("EduManage");`, then print `c.getName()`. Expected: EduManage',
'class App { private String name; public String getName() { return name; } public void setName(String n) { name = n; } }' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        App c = new App();' || chr(10) || '        // Set Name and print' || chr(10) || '    }' || chr(10) || '}',
'EduManage',
'c.setName("EduManage"); System.out.println(c.getName());',
5, 20);
-- Lesson 5.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Inheritance', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which keyword establishes an inheritance relationship between classes in Java?',
'0',
'["extends","implements","inherits","super"]'::jsonb,
'`class Child extends Parent {}`',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'What keyword is used inside a child class to call the parent class''s constructor?',
'___(args);',
'super',
'["super","parent","base","this"]'::jsonb,
'You must call `super()` in the child constructor to ensure the parent state is initialized properly.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `@Override` annotation do?',
'0',
'["It tells the compiler to verify that you are actually replacing a method from the parent class","It prevents the method from being overridden","It makes the method run faster","It makes the method private"]'::jsonb,
'If you misspell the method name, `@Override` causes a compile error, saving you from a subtle bug.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a Base and Derived class overriding a method:',
'[{"id":"1","code":"class Shape { public void draw() { System.out.println(\"Shape\"); } }"},{"id":"2","code":"class Circle extends Shape {"},{"id":"3","code":"  @Override"},{"id":"4","code":"  public void draw() { System.out.println(\"Circle\"); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Shape { public void draw() { System.out.println(\"Shape\"); } }","class Circle extends Shape {","  @Override","  public void draw() { System.out.println(\"Circle\"); } }"]'::jsonb,
'Base class, derived class extending base, @Override annotation, overridden method body.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Instantiate a `Cat`, which inherits from `Pet`, and call `speak()`. Expected: Meow',
'class Pet { public void speak() {} }' || chr(10) || 'class Cat extends Pet { @Override public void speak() { System.out.println("Meow"); } }' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Instantiate and call speak' || chr(10) || '    }' || chr(10) || '}',
'Meow',
'Cat c = new Cat(); c.speak();',
5, 20);
-- Lesson 5.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Interfaces', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What is the purpose of `class MyClass implements MyInterface`?',
'0',
'["It forces the class to provide implementations for all abstract methods defined in the interface","It copies variables from the interface","It turns the class into an abstract class","It extends another class"]'::jsonb,
'`implements` is a contract. If the class misses a method from the interface, Java throws a compile error.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration to implement an interface:',
'class UserRepository ___ Repository { }',
'implements',
'["implements","extends","uses","binds"]'::jsonb,
'Java uses `extends` for classes, and `implements` for interfaces.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which statement about inheritance and interfaces in Java is true?',
'0',
'["A class can implement multiple interfaces, but can only extend ONE parent class","An interface can contain private fields","A class can only implement one interface","Interfaces are instantiated using `new`"]'::jsonb,
'`class MyClass extends BaseClass implements IFirst, ISecond` is perfectly valid. Java prevents multiple inheritance of classes to avoid the "Diamond Problem".',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Define an interface and a class that implements it:',
'[{"id":"1","code":"interface Runnable { void run(); }"},{"id":"2","code":"class Engine implements Runnable {"},{"id":"3","code":"  public void run() {"},{"id":"4","code":"    System.out.println(\"Vroom\"); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["interface Runnable { void run(); }","class Engine implements Runnable {","  public void run() {","    System.out.println(\"Vroom\"); } }"]'::jsonb,
'Interface without body, class implements interface, public method matching signature, body.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Implement `Payable.pay()` inside `Employee`. Print "Paid". Create an Employee and call pay(). Expected: Paid',
'interface Payable { void pay(); }' || chr(10) || 'class Employee implements Payable {' || chr(10) || '    // Implement pay here' || chr(10) || '}' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Instantiate and call' || chr(10) || '    }' || chr(10) || '}',
'Paid',
'public void pay() { System.out.println("Paid"); } ... Employee e = new Employee(); e.pay();',
5, 20);
-- ==============================================================
-- UNIT 6: Advanced Java Concepts
-- ==============================================================
INSERT INTO public.units (language_id, title, description, color, order_index)
VALUES (v_lang_id, 'Unit 6: Advanced Java', 'Exceptions, Generics, and the Stream API', 'red', 6)
RETURNING id INTO v_unit_id;
INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
(v_unit_id, 'Advanced Java Features', $note$

# Advanced Java Features

## Exception Handling

Wrap dangerous code (like file access or parsing user input) in `try-catch` to prevent your app from crashing.

```java
try {
    int num = Integer.parseInt("NotANumber");
} catch (NumberFormatException ex) {
    System.out.println("Invalid input!");
} finally {
    // This block always runs, crash or no crash
    System.out.println("Cleanup code here.");
}

```

## Generics `<T>`

Generics let you write methods or classes that work with ANY object type safely. `ArrayList<T>` is a generic class.

```java
// T is a placeholder for a type
public static <T> void printItem(T item) {
    System.out.println(item);
}

```

## Streams and Lambdas (Java 8+)

Streams allow you to process collections of objects (like Lists) using a functional, declarative syntax.

```java
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("Anthony", "Bob", "Alice");

        // Filter and print names starting with 'A'
        names.stream()
             .filter(name -> name.startsWith("A"))
             .forEach(System.out::println);
    }
}

```

## Key Takeaways

* Use `try-catch` for predictable errors.
* Generics `<T>` avoid code duplication and dangerous casting.
* The Stream API combined with Lambda expressions (`->`) provides powerful data manipulation tools similar to SQL or JavaScript arrays.
$note$, 0);
-- Lesson 6.1
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Exceptions', 1) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What block of code is guaranteed to run whether an exception occurs or not?',
'0',
'["finally","catch","try","default"]'::jsonb,
'The `finally` block is generally used to close files, Scanners, or database connections so they aren''t left hanging if a crash occurs.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the block that catches the error:',
'___ (Exception ex) { System.out.println(ex.getMessage()); }',
'catch',
'["catch","try","except","error"]'::jsonb,
'`try { ... } catch (Exception ex) { ... }`',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'How do you manually trigger an exception in Java?',
'0',
'["throw new Exception(\\\"Message\\\");\\\", \\\"raise Exception(\\\"Message\\\");\\\", \\\"catch new Exception();\\\", \\\"return Exception;\\\"]"]'::jsonb,
'The `throw` keyword creates an error state and halts execution unless caught.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a safe parse operation using try-catch:',
'[{"id":"1","code":"try {"},{"id":"2","code":"  int x = Integer.parseInt(\"A\"); }"},{"id":"3","code":"catch (NumberFormatException e) {"},{"id":"4","code":"  System.out.println(\"Fail\"); }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["try {","  int x = Integer.parseInt(\"A\"); }","catch (NumberFormatException e) {","  System.out.println(\"Fail\"); }"]'::jsonb,
'try block open, dangerous code, catch block open, handle error.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Wrap `int x = 5 / 0;` in a try/catch. In the catch block, print "Error". Expected: Error',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Write try catch' || chr(10) || '    }' || chr(10) || '}',
'Error',
'try { int x = 5 / 0; } catch (Exception e) { System.out.println("Error"); }',
5, 20);
-- Lesson 6.2
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Generics', 2) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Why use a Generic Type `<T>` instead of standard `Object`?',
'0',
'["Generics provide compile-time type safety, eliminating the need to cast objects","Generics take less memory","Using Object is actually preferred","Generics automatically encrypt data"]'::jsonb,
'With `Object`, you have to cast values back and forth, which is prone to ClassCastException errors. Generics enforce the type at compile-time.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the syntax for a generic method declaration in Java:',
'public static ___ void printItem(T item) { System.out.println(item); }',
'',
'["","(T)","{T}","[T]"]'::jsonb,
'Angle brackets `<T>` define the type parameter directly before the return type.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the "Diamond Operator" `<>` do when instantiating a generic class like `new ArrayList<>()`?',
'0',
'["It infers the type parameter from the variable declaration so you don''t have to type it twice","It clears the list","It creates a multi-dimensional array","It restricts the list to numbers"]'::jsonb,
'`ArrayList<String> list = new ArrayList<>();` is shorter than typing `new ArrayList<String>();`.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a generic class that holds a value:',
'[{"id":"1","code":"class Box<T> {"},{"id":"2","code":"  public T content;"},{"id":"3","code":"}"},{"id":"4","code":"Box<T> b = new Box<>();"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Box<T> {","  public T content;","}","Box<T> b = new Box<>();"]'::jsonb,
'Class generic signature, generic field, close, instantiation.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Write `public static <T> T returnIt(T val) { return val; }`. Call it with `"Test"` and print the result. Expected: Test',
'public class Main {' || chr(10) || '    // Write method here' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Call and print' || chr(10) || '    }' || chr(10) || '}',
'Test',
'public static  T returnIt(T val) { return val; } ... System.out.println(returnIt("Test"));',
5, 20);
-- Lesson 6.3
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Streams and Lambdas', 3) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'Which Stream method is used to keep only elements that match a certain condition?',
'0',
'["filter()","map()","reduce()","find()"]'::jsonb,
'`.filter(n -> n > 5)` keeps items greater than 5. `.map()` is used for transforming data.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the Lambda expression syntax (arrow function) in Java:',
'list.removeIf(name ___ name.equals("Bob"));',
'->',
'["->","=>","==",">"]'::jsonb,
'Java uses `->` for lambdas, whereas C# and JS use `=>`.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does `System.out::println` represent in the Stream API?',
'0',
'["A method reference, equivalent to writing `x -> System.out.println(x)`","A syntax error","A static import","A generic parameter"]'::jsonb,
'Method references `::` are a shorthand way to pass an existing method as a lambda.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a Stream pipeline to filter and print elements:',
'[{"id":"1","code":"List nums = Arrays.asList(1, 4, 7);"},{"id":"2","code":"nums.stream()"},{"id":"3","code":"  .filter(n -> n > 3)"},{"id":"4","code":"  .forEach(System.out::println);"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["List nums = Arrays.asList(1, 4, 7);","nums.stream()","  .filter(n -> n > 3)","  .forEach(System.out::println);"]'::jsonb,
'List, open stream(), filter elements, terminate with forEach.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Given `List<Integer> list = Arrays.asList(2, 9, 4);`. Use `.stream().filter(n -> n % 2 == 0).forEach(System.out::println);` Expected: 2 4 (on separate lines)',
'import java.util.Arrays;' || chr(10) || 'import java.util.List;' || chr(10) || 'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        List list = Arrays.asList(2, 9, 4);' || chr(10) || '        // Stream, filter, print' || chr(10) || '    }' || chr(10) || '}',
'2' || chr(10) || '4',
'list.stream().filter(n -> n % 2 == 0).forEach(System.out::println);',
5, 20);
-- Lesson 6.4
INSERT INTO public.lessons (unit_id, title, order_index)
VALUES (v_unit_id, 'Final Keyword and Constants', 4) RETURNING id INTO v_lesson_id;
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `final` keyword do when applied to a variable?',
'0',
'["It makes the variable a constant; its value cannot be changed once assigned","It makes the variable accessible globally","It deletes the variable after use","It forces the variable to be private"]'::jsonb,
'`final double PI = 3.14;` prevents reassignment. Equivalent to `const` in other languages.',
1, 10);
INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'fill-blank',
'Complete the declaration of a constant string:',
'public static ___ String APP_NAME = "My App";',
'final',
'["final","const","static","readonly"]'::jsonb,
'`public static final` is the standard way to declare constants in Java.',
2, 15);
INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'multiple-choice',
'What does the `final` keyword do when applied to a class?',
'0',
'["It prevents any other class from inheriting (extending) it","It prevents the class from being instantiated","It makes all methods inside it private","It acts like an interface"]'::jsonb,
'For security and design reasons, classes like `String` are marked `final` so they cannot be overridden.',
3, 10);
INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'drag-order',
'Arrange a class defining and using a constant:',
'[{"id":"1","code":"class Config {"},{"id":"2","code":"  public static final int MAX = 100; }"},{"id":"3","code":"public class Main {"},{"id":"4","code":"  public static void main(String[] args) { System.out.println(Config.MAX); } }"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["class Config {","  public static final int MAX = 100; }","public class Main {","  public static void main(String[] args) { System.out.println(Config.MAX); } }"]'::jsonb,
'Config class, final static field, Main class, print the constant.',
4, 15);
INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
(v_lesson_id, 'code-runner',
'Declare a `final int LIMIT = 5;`. Print `LIMIT * 2`. Expected: 10',
'public class Main {' || chr(10) || '    public static void main(String[] args) {' || chr(10) || '        // Declare final and print' || chr(10) || '    }' || chr(10) || '}',
'10',
'final int LIMIT = 5; System.out.println(LIMIT * 2);',
5, 20);

END $$;
