-- ============================================================
-- REAL HTML CURRICULUM
-- Replaces all existing HTML content with accurate, educational
-- notes, lessons and questions.
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

  SELECT id INTO v_lang_id FROM public.languages WHERE slug = 'html';
  IF v_lang_id IS NULL THEN
    INSERT INTO public.languages (name, slug, icon, description)
    VALUES ('HTML', 'html', '🌐', 'The standard markup language for building web pages')
    RETURNING id INTO v_lang_id;
  END IF;

  DELETE FROM public.units WHERE language_id = v_lang_id;

  -- ==============================================================
  -- UNIT 1: HTML Foundations
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 1: HTML Foundations',
          'Learn how HTML documents are structured and how tags work',
          'orange', 1)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Introduction to HTML', $note$
# Introduction to HTML

HTML (HyperText Markup Language) is the standard language for creating web pages. Every webpage you visit is built on HTML. It describes the **structure** and **content** of a page — not the visual style (that's CSS) or behaviour (that's JavaScript).

## How HTML Works

HTML uses **elements** made up of **tags** to mark up content:

```html
<p>This is a paragraph.</p>
```

- `<p>` is the **opening tag**
- `</p>` is the **closing tag**
- The text between them is the **content**
- Together, they form an **element**

## The Anatomy of a Webpage

Every valid HTML page has this structure:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My First Page</title>
  </head>
  <body>
    <h1>Hello, World!</h1>
    <p>This is my first web page.</p>
  </body>
</html>
```

| Part             | Purpose                                           |
|------------------|---------------------------------------------------|
| `<!DOCTYPE html>`| Tells the browser this is HTML5                  |
| `<html>`         | Root element wrapping the entire document         |
| `<head>`         | Metadata — title, character set, links to CSS/JS |
| `<title>`        | Text shown in the browser tab                    |
| `<body>`         | All visible page content goes here               |

## Attributes

Attributes give extra information to elements:

```html
<a href="https://example.com">Click here</a>
<img src="photo.jpg" alt="A photo">
<p class="intro" id="first-para">Welcome</p>
```

- Attributes go inside the **opening tag**
- Format: `name="value"`
- Common attributes: `href`, `src`, `alt`, `class`, `id`, `type`

## Self-Closing Tags (Void Elements)

Some elements have no content and no closing tag:

```html
<img src="logo.png" alt="Logo">
<br>
<hr>
<input type="text">
<meta charset="UTF-8">
```

## Key Takeaways
- HTML describes structure; CSS handles style; JS adds behaviour
- Every page needs `<!DOCTYPE html>`, `<html>`, `<head>`, and `<body>`
- Tags come in pairs (open + close) unless they are void elements
- Attributes provide extra information inside the opening tag
$note$, 0);

  -- ── Lesson 1.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'What is HTML?', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does HTML stand for?',
   '0',
   '["HyperText Markup Language", "High Transfer Markup Language", "HyperText Machine Language", "Home Tool Markup Language"]'::jsonb,
   'HTML = HyperText Markup Language. It marks up content on the web.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the DOCTYPE declaration that tells the browser to use HTML5:',
   '<!___ html>',
   'DOCTYPE',
   '["DOCTYPE", "doctype", "TYPE", "HTML5"]'::jsonb,
   '<!DOCTYPE html> must be the very first line of every HTML5 document.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the role of HTML on a web page?',
   '0',
   '["It defines the structure and content", "It controls the visual styling", "It handles user interactions and logic", "It manages the server database"]'::jsonb,
   'HTML = structure. CSS = style. JavaScript = behaviour. Each has its own role.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange the correct order of the main sections in an HTML document:',
   '[{"id":"1","code":"<!DOCTYPE html>"},{"id":"2","code":"<html lang=\"en\">"},{"id":"3","code":"  <head>...</head>"},{"id":"4","code":"  <body>...</body>"},{"id":"5","code":"</html>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<!DOCTYPE html>","<html lang=\"en\">","  <head>...</head>","  <body>...</body>","</html>"]'::jsonb,
   'DOCTYPE first, then html wrapper, head section, body section, close html.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write the tag that sets the page title shown in the browser tab to "My Page".',
   '<!-- Write the title tag -->',
   '<title>My Page</title>',
   '<title> goes inside <head>. Its content appears in the browser tab.',
   5, 20);

  -- ── Lesson 1.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Tags and Elements', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which of these is a correctly formed HTML element?',
   '0',
   '["<p>Hello</p>", "<p>Hello</P>", "p>Hello</p>", "<p Hello/p>"]'::jsonb,
   'A valid element has a matching opening and closing tag. Tags are lowercase by convention.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the closing tag for a paragraph element:',
   '<p>Welcome to HTML.</___>',
   'p',
   '["p", "para", "/para", "P"]'::jsonb,
   'The closing tag matches the opening tag name with a forward slash: </p>.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is a "void element" in HTML?',
   '0',
   '["An element with no content and no closing tag", "An empty <div> tag", "An element that is hidden from the user", "A deprecated HTML4 element"]'::jsonb,
   'Void elements like <br>, <img>, and <input> cannot have children and do not need </tag>.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these to form a complete paragraph element:',
   '[{"id":"1","code":"<p>"},{"id":"2","code":"Learning HTML is fun!"},{"id":"3","code":"</p>"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["<p>","Learning HTML is fun!","</p>"]'::jsonb,
   'Opening tag first, content second, closing tag last.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an HTML paragraph element containing the text: HTML is awesome!',
   '<!-- Write your paragraph element -->',
   '<p>HTML is awesome!</p>',
   'Use <p> and </p> tags wrapping the text.',
   5, 20);

  -- ── Lesson 1.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'HTML Attributes', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Where in an HTML element do attributes go?',
   '0',
   '["Inside the opening tag", "Inside the closing tag", "Between the tags", "Before the opening tag"]'::jsonb,
   'Attributes always go inside the opening tag: <tag attribute="value">',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the attribute that specifies a link destination:',
   '<a ___="https://google.com">Google</a>',
   'href',
   '["href", "src", "link", "url"]'::jsonb,
   'The href (hypertext reference) attribute specifies the URL a link points to.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the purpose of the alt attribute on an <img> element?',
   '0',
   '["Provides alternative text displayed when the image cannot load (and for screen readers)", "Sets the image size", "Specifies the image file path", "Controls image opacity"]'::jsonb,
   'alt text makes images accessible and appears when the image fails to load.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these parts to form a valid image element:',
   '[{"id":"1","code":"<img"},{"id":"2","code":"  src=\"logo.png\""},{"id":"3","code":"  alt=\"Company logo\""},{"id":"4","code":">"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["<img","  src=\"logo.png\"","  alt=\"Company logo\"",">"]'::jsonb,
   '<img tag opens, then src, then alt, then the closing >.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a link element that displays "Visit Ghana" and links to https://ghana.travel',
   '<!-- Write your anchor tag -->',
   '<a href="https://ghana.travel">Visit Ghana</a>',
   '<a href="URL">link text</a>',
   5, 20);

  -- ── Lesson 1.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'head vs body', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What kind of content goes inside the <head> element?',
   '0',
   '["Metadata — title, character set, CSS links, scripts", "All visible page content", "Navigation menus and headings", "Images and paragraphs"]'::jsonb,
   '<head> holds information ABOUT the page, not content displayed to the user.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the meta tag that sets the character encoding to UTF-8:',
   '<meta ___="UTF-8">',
   'charset',
   '["charset", "encoding", "lang", "type"]'::jsonb,
   'charset sets the character encoding. UTF-8 supports virtually all characters.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which tag links an external CSS stylesheet to an HTML page?',
   '0',
   '["<link rel=\"stylesheet\" href=\"style.css\">", "<style src=\"style.css\">", "<css href=\"style.css\">", "<import url=\"style.css\">"]'::jsonb,
   '<link rel="stylesheet" href="style.css"> goes in the <head> to load external CSS.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a complete minimal HTML5 page structure:',
   '[{"id":"1","code":"<!DOCTYPE html>"},{"id":"2","code":"<html lang=\"en\">"},{"id":"3","code":"<head><title>Home</title></head>"},{"id":"4","code":"<body><h1>Welcome</h1></body>"},{"id":"5","code":"</html>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<!DOCTYPE html>","<html lang=\"en\">","<head><title>Home</title></head>","<body><h1>Welcome</h1></body>","</html>"]'::jsonb,
   'DOCTYPE, html open, head, body, html close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write the meta viewport tag used for responsive design. Expected exact output:' || chr(10) || '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
   '<!-- Write the viewport meta tag -->',
   '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
   'Use name="viewport" and content="width=device-width, initial-scale=1.0".',
   5, 20);


  -- ==============================================================
  -- UNIT 2: Text and Headings
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 2: Text and Headings',
          'Structure text with headings, paragraphs, emphasis, and semantic tags',
          'blue', 2)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Text Elements in HTML', $note$
# Text Elements in HTML

## Headings

HTML has six levels of headings, `<h1>` through `<h6>`. `<h1>` is the most important (largest by default); `<h6>` is the least.

```html
<h1>Main Page Title</h1>
<h2>Section Title</h2>
<h3>Subsection</h3>
<h4>Sub-subsection</h4>
<h5>Minor heading</h5>
<h6>Smallest heading</h6>
```

Best practice: use only ONE `<h1>` per page; it signals the page's main topic to search engines.

## Paragraphs

```html
<p>This is a paragraph of text. Browsers add space above and below paragraphs automatically.</p>
<p>This is a second paragraph.</p>
```

A single line break in the source does NOT create a new paragraph — you need another `<p>` tag.

## Inline Text Formatting

```html
<strong>Bold (important text)</strong>
<em>Italic (emphasised text)</em>
<mark>Highlighted text</mark>
<code>inline code snippet</code>
<s>Strikethrough</s>
<u>Underlined</u>
<sup>Superscript</sup>  — e.g. x²
<sub>Subscript</sub>    — e.g. H₂O
```

## Line Breaks and Horizontal Rules

```html
<p>Line one<br>Line two in the same paragraph</p>
<hr>   <!-- A thematic break / horizontal rule -->
```

`<br>` forces a line break within a paragraph. `<hr>` draws a horizontal line.

## Semantic Text Elements

HTML5 introduced semantic elements that describe meaning:

```html
<article>  — standalone content
<section>  — thematic grouping
<aside>    — sidebar content
<header>   — introductory content for a page or section
<footer>   — footer for a page or section
<main>     — the dominant content of the body
<nav>      — navigation links
<figure>   — self-contained media (images, diagrams)
<figcaption> — caption for a figure
```

## blockquote and cite

```html
<blockquote cite="https://source.com">
  <p>A famous quote goes here.</p>
</blockquote>
<cite>— Source Name</cite>
```

## Key Takeaways
- Use `<h1>`–`<h6>` for structure, not just to change font size
- `<strong>` conveys importance; `<em>` conveys emphasis
- Semantic elements make pages accessible and SEO-friendly
- `<br>` is a line break; `<hr>` is a horizontal divider
$note$, 0);

  -- ── Lesson 2.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Headings and Paragraphs', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How many heading levels does HTML provide?',
   '0',
   '["6 (h1 through h6)", "3 (h1, h2, h3)", "4 (h1 through h4)", "Unlimited"]'::jsonb,
   'HTML has heading tags h1, h2, h3, h4, h5, and h6 — six in total.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the tag for the most important (largest) heading:',
   '<___>Welcome to My Site</___>',
   'h1',
   '["h1", "h6", "heading", "title"]'::jsonb,
   '<h1> is the top-level heading. Use only one per page for best SEO practice.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What HTML element creates a paragraph?',
   '0',
   '["<p>", "<para>", "<text>", "<pg>"]'::jsonb,
   '<p> is the paragraph element. Browsers add vertical space above and below it automatically.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a page body with a heading and two paragraphs:',
   '[{"id":"1","code":"<h1>About Us</h1>"},{"id":"2","code":"<p>We are a tech company.</p>"},{"id":"3","code":"<p>Founded in 2020.</p>"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["<h1>About Us</h1>","<p>We are a tech company.</p>","<p>Founded in 2020.</p>"]'::jsonb,
   'Heading comes first, then the paragraphs in reading order.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an h2 heading with the text "Our Services".',
   '<!-- Write your h2 heading -->',
   '<h2>Our Services</h2>',
   'Use <h2> and </h2> around the text.',
   5, 20);

  -- ── Lesson 2.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Text Formatting Tags', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which tag marks text as important (renders bold by default)?',
   '0',
   '["<strong>", "<b>", "<bold>", "<important>"]'::jsonb,
   '<strong> conveys semantic importance. <b> only makes text visually bold with no semantic meaning.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the tag to italicise (emphasise) text semantically:',
   '<___>This is important</___>',
   'em',
   '["em", "i", "italic", "emphasis"]'::jsonb,
   '<em> marks text with stress emphasis (renders italic). <i> is purely visual.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which element creates a line break within a paragraph?',
   '0',
   '["<br>", "<lb>", "<newline>", "<hr>"]'::jsonb,
   '<br> is a line break (void element — no closing tag). <hr> is a horizontal rule.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange inline elements to form: This is <strong>bold</strong> and <em>italic</em> text.',
   '[{"id":"1","code":"This is "},{"id":"2","code":"<strong>bold</strong>"},{"id":"3","code":" and "},{"id":"4","code":"<em>italic</em>"},{"id":"5","code":" text."}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["This is ","<strong>bold</strong>"," and ","<em>italic</em>"," text."]'::jsonb,
   'Plain text, then strong, then connector text, then em, then end.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a paragraph containing the word "Warning" in bold (strong) followed by ": check your inputs."',
   '<!-- Write your paragraph with strong tag -->',
   '<p><strong>Warning</strong>: check your inputs.</p>',
   'Nest <strong> inside <p>: <p><strong>...</strong>rest of text</p>',
   5, 20);

  -- ── Lesson 2.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Semantic HTML5 Elements', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the purpose of semantic HTML elements?',
   '0',
   '["They describe the meaning of content, improving accessibility and SEO", "They add visual styling automatically", "They replace JavaScript for interactions", "They are only for older browsers"]'::jsonb,
   'Semantic elements like <article> and <nav> tell browsers AND humans what the content means.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the semantic element used for the main site navigation:',
   '<___>' || chr(10) || '  <a href="/">Home</a>' || chr(10) || '  <a href="/about">About</a>' || chr(10) || '</___>',
   'nav',
   '["nav", "menu", "navigation", "header"]'::jsonb,
   '<nav> marks a section of navigation links.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which element is used for the main content of a page (should appear only once)?',
   '0',
   '["<main>", "<content>", "<body>", "<article>"]'::jsonb,
   '<main> identifies the primary content. There should be only one per page.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a semantic page structure for a blog post:',
   '[{"id":"1","code":"<header><h1>My Blog</h1></header>"},{"id":"2","code":"<main>"},{"id":"3","code":"  <article><h2>Post Title</h2><p>Content</p></article>"},{"id":"4","code":"</main>"},{"id":"5","code":"<footer><p>© 2026</p></footer>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<header><h1>My Blog</h1></header>","<main>","  <article><h2>Post Title</h2><p>Content</p></article>","</main>","<footer><p>© 2026</p></footer>"]'::jsonb,
   'header at top, main wraps articles, footer at bottom.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a <footer> element containing a paragraph that says "© 2026 ProCode".',
   '<!-- Write your footer -->',
   '<footer><p>© 2026 ProCode</p></footer>',
   '<footer> wraps the content, with <p> inside for the text.',
   5, 20);

  -- ── Lesson 2.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Block vs Inline Elements', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the difference between block-level and inline elements?',
   '0',
   '["Block elements start on a new line and fill the full width; inline elements flow within text", "Block elements are larger; inline elements are smaller", "Block elements are only for containers; inline elements are for text", "There is no difference in HTML5"]'::jsonb,
   '<div> and <p> are block. <span> and <a> are inline — they sit inside text flow.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the generic inline container element used to style parts of text:',
   '<___>highlighted word</___>',
   'span',
   '["span", "div", "inline", "text"]'::jsonb,
   '<span> is the generic inline container. <div> is the generic block container.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which of these is a block-level element?',
   '0',
   '["<div>", "<span>", "<a>", "<strong>"]'::jsonb,
   '<div> is the generic block container. <span>, <a>, and <strong> are inline.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these elements from block-level to inline: div, p, h1, span, a',
   '[{"id":"1","code":"Block: <div>"},{"id":"2","code":"Block: <p>"},{"id":"3","code":"Block: <h1>"},{"id":"4","code":"Inline: <span>"},{"id":"5","code":"Inline: <a>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["Block: <div>","Block: <p>","Block: <h1>","Inline: <span>","Inline: <a>"]'::jsonb,
   'Block elements first (div, p, h1), then inline (span, a).',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a paragraph where the word "HTML" is wrapped in a <span> with no other attributes.',
   '<!-- Write the paragraph with a span -->',
   '<p><span>HTML</span> is the backbone of the web.</p>',
   '<p> block, with <span>HTML</span> inline inside it, followed by the rest of the text.',
   5, 20);


  -- ==============================================================
  -- UNIT 3: Lists and Links
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 3: Lists and Links',
          'Create ordered, unordered, and definition lists and working hyperlinks',
          'green', 3)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Lists and Links in HTML', $note$
# Lists and Links in HTML

## Unordered Lists

Items without a specific order — displayed with bullet points:

```html
<ul>
  <li>Apple</li>
  <li>Banana</li>
  <li>Cherry</li>
</ul>
```

## Ordered Lists

Items in a numbered sequence:

```html
<ol>
  <li>Preheat oven to 180°C</li>
  <li>Mix ingredients</li>
  <li>Bake for 30 minutes</li>
</ol>
```

`<ol>` supports the `type` attribute: `type="A"` (A, B, C), `type="i"` (i, ii, iii), `type="1"` (default).

## Definition Lists

Key-term pairs:

```html
<dl>
  <dt>HTML</dt>
  <dd>HyperText Markup Language — the standard for web pages</dd>
  <dt>CSS</dt>
  <dd>Cascading Style Sheets — controls visual presentation</dd>
</dl>
```

## Nested Lists

Lists can be nested inside `<li>` items:

```html
<ul>
  <li>Frontend
    <ul>
      <li>HTML</li>
      <li>CSS</li>
    </ul>
  </li>
  <li>Backend</li>
</ul>
```

## Hyperlinks (`<a>`)

```html
<!-- External link -->
<a href="https://example.com">Visit Example</a>

<!-- Open in new tab -->
<a href="https://example.com" target="_blank" rel="noopener noreferrer">Open</a>

<!-- Internal link (same site) -->
<a href="/about">About Us</a>

<!-- Link to ID on the same page (anchor link) -->
<a href="#contact">Jump to Contact</a>

<!-- Email link -->
<a href="mailto:hello@example.com">Email Us</a>

<!-- Phone link -->
<a href="tel:+233201234567">Call Us</a>
```

## Key Takeaways
- `<ul>` = unordered (bullets); `<ol>` = ordered (numbers); `<dl>` = definition list
- Every list item uses `<li>` inside `<ul>` or `<ol>`
- `href` is the required attribute on `<a>` — it sets the destination URL
- Use `target="_blank"` with `rel="noopener noreferrer"` for security when opening new tabs
$note$, 0);

  -- ── Lesson 3.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Unordered and Ordered Lists', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which element creates a bulleted (unordered) list?',
   '0',
   '["<ul>", "<ol>", "<li>", "<list>"]'::jsonb,
   '<ul> = unordered list (bullets). <ol> = ordered list (numbers). <li> = list item.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the list item tag:',
   '<ul>' || chr(10) || '  <___>Accra</___>' || chr(10) || '  <___>Kumasi</___>' || chr(10) || '</ul>',
   'li',
   '["li", "item", "el", "bullet"]'::jsonb,
   '<li> marks each list item inside both <ul> and <ol>.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which list type would you use for step-by-step cooking instructions?',
   '0',
   '["<ol> — ordered list (the order matters)", "<ul> — unordered list", "<dl> — definition list", "<steps> — HTML5 steps element"]'::jsonb,
   'When order matters (steps, rankings, instructions), use <ol>. For unordered groups, use <ul>.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a numbered list with three steps:',
   '[{"id":"1","code":"<ol>"},{"id":"2","code":"  <li>Open the app</li>"},{"id":"3","code":"  <li>Sign in</li>"},{"id":"4","code":"  <li>Start learning</li>"},{"id":"5","code":"</ol>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<ol>","  <li>Open the app</li>","  <li>Sign in</li>","  <li>Start learning</li>","</ol>"]'::jsonb,
   'Open <ol>, then three <li> items, then close </ol>.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a bulleted list with two items: "HTML" and "CSS".',
   '<!-- Write your unordered list -->',
   '<ul>' || chr(10) || '  <li>HTML</li>' || chr(10) || '  <li>CSS</li>' || chr(10) || '</ul>',
   '<ul> containing two <li> items.',
   5, 20);

  -- ── Lesson 3.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Hyperlinks', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the required attribute on an anchor element to specify its destination?',
   '0',
   '["href", "src", "link", "to"]'::jsonb,
   'href (HyperText Reference) is the required attribute that tells the link where to go.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the attribute value to open a link in a new browser tab:',
   '<a href="https://example.com" ___="_blank">Open</a>',
   'target',
   '["target", "open", "tab", "window"]'::jsonb,
   'target="_blank" opens the link in a new tab or window.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which href value creates a link that opens the user''s email client?',
   '0',
   '["href=\"mailto:info@example.com\"", "href=\"email:info@example.com\"", "href=\"send:info@example.com\"", "href=\"#email\""]'::jsonb,
   'mailto: is the URL scheme for email links. Clicking it opens the default mail app.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a nav with two links that open in the same tab:',
   '[{"id":"1","code":"<nav>"},{"id":"2","code":"  <a href=\"/\">Home</a>"},{"id":"3","code":"  <a href=\"/about\">About</a>"},{"id":"4","code":"</nav>"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["<nav>","  <a href=\"/\">Home</a>","  <a href=\"/about\">About</a>","</nav>"]'::jsonb,
   '<nav> wraps the anchor elements.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a link that displays "ProCode" and goes to https://procode.app opening in a new tab.',
   '<!-- Write your anchor element -->',
   '<a href="https://procode.app" target="_blank">ProCode</a>',
   '<a href="url" target="_blank">text</a>',
   5, 20);

  -- ── Lesson 3.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Definition Lists and Nesting', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which element contains the term in a definition list?',
   '0',
   '["<dt>", "<dd>", "<dl>", "<def>"]'::jsonb,
   '<dl> = definition list container. <dt> = definition term. <dd> = definition description.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the definition description tag:',
   '<dl>' || chr(10) || '  <dt>HTML</dt>' || chr(10) || '  <___>Markup language for web pages</___>' || chr(10) || '</dl>',
   'dd',
   '["dd", "dt", "def", "desc"]'::jsonb,
   '<dd> (definition description) holds the explanation that follows a <dt> term.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How do you create a nested list in HTML?',
   '0',
   '["Place a <ul> or <ol> inside an <li> element", "Use the nested attribute on <ul>", "Place a <li> directly inside another <li>", "Add indent attribute to the child <ul>"]'::jsonb,
   'Nesting: put the child <ul> or <ol> INSIDE a parent <li>, before the </li> closing tag.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a definition list for the term "CSS":',
   '[{"id":"1","code":"<dl>"},{"id":"2","code":"  <dt>CSS</dt>"},{"id":"3","code":"  <dd>Cascading Style Sheets — controls visual presentation</dd>"},{"id":"4","code":"</dl>"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["<dl>","  <dt>CSS</dt>","  <dd>Cascading Style Sheets — controls visual presentation</dd>","</dl>"]'::jsonb,
   'Open dl, then dt, then dd, then close dl.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a definition list with one term "Python" and description "A programming language".',
   '<!-- Write your definition list -->',
   '<dl>' || chr(10) || '  <dt>Python</dt>' || chr(10) || '  <dd>A programming language</dd>' || chr(10) || '</dl>',
   '<dl><dt>term</dt><dd>description</dd></dl>',
   5, 20);

  -- ── Lesson 3.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Navigation Menus', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the best semantic element to wrap a website navigation menu?',
   '0',
   '["<nav>", "<menu>", "<ul>", "<header>"]'::jsonb,
   '<nav> is the HTML5 semantic element specifically for navigation links.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the href to link to the section with id="contact" on the same page:',
   '<a href="___">Contact</a>',
   '"#contact"',
   '[""#contact"", ""contact"", ""#"", ""/contact""]'::jsonb,
   'Anchor links use # followed by the element''s id to jump to a section on the same page.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why should you add rel="noopener noreferrer" when using target="_blank"?',
   '0',
   '["Security — prevents the new tab from accessing the opening page via window.opener", "It makes the page load faster in new tabs", "It is required for the link to work", "It adds a visual indicator that the link opens a new tab"]'::jsonb,
   'noopener blocks the new page from controlling the original via window.opener — a security best practice.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a navigation bar with links to Home, Blog, and Contact:',
   '[{"id":"1","code":"<nav>"},{"id":"2","code":"  <ul>"},{"id":"3","code":"    <li><a href=\"/\">Home</a></li>"},{"id":"4","code":"    <li><a href=\"/blog\">Blog</a></li>"},{"id":"5","code":"    <li><a href=\"/contact\">Contact</a></li>"},{"id":"6","code":"  </ul>"},{"id":"7","code":"</nav>"}]'::jsonb,
   '["1","2","3","4","5","6","7"]'::jsonb,
   '["<nav>","  <ul>","    <li><a href=\"/\">Home</a></li>","    <li><a href=\"/blog\">Blog</a></li>","    <li><a href=\"/contact\">Contact</a></li>","  </ul>","</nav>"]'::jsonb,
   'nav wraps ul, each nav link is an li containing an a tag.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a link to a section with id="services" on the same page. Display text: "Our Services".',
   '<!-- Write your anchor link -->',
   '<a href="#services">Our Services</a>',
   'Use href="#services" to link to an element with that id on the same page.',
   5, 20);


  -- ==============================================================
  -- UNIT 4: Images and Media
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 4: Images and Media',
          'Embed images, audio, and video into web pages correctly',
          'purple', 4)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Images and Media in HTML', $note$
# Images and Media in HTML

## Images

```html
<img src="photo.jpg" alt="A sunset over the ocean" width="800" height="600">
```

| Attribute | Purpose                                 | Required? |
|-----------|-----------------------------------------|-----------|
| `src`     | Path or URL to the image file           | Yes       |
| `alt`     | Alternative text for accessibility      | Yes       |
| `width`   | Width in pixels (or use CSS)            | No        |
| `height`  | Height in pixels (or use CSS)           | No        |
| `loading` | `lazy` = loads only when near viewport  | No        |

### Image file formats

| Format | Best for                        |
|--------|---------------------------------|
| JPEG   | Photographs                     |
| PNG    | Logos, icons needing transparency|
| WebP   | Modern format — smaller files   |
| SVG    | Logos, icons (infinitely scalable)|
| GIF    | Simple animations               |

### `<figure>` and `<figcaption>`

Wraps an image with a semantic caption:

```html
<figure>
  <img src="chart.png" alt="Bar chart of monthly sales">
  <figcaption>Fig. 1 — Monthly sales for 2024</figcaption>
</figure>
```

## Audio

```html
<audio controls>
  <source src="audio.mp3" type="audio/mpeg">
  <source src="audio.ogg" type="audio/ogg">
  Your browser does not support the audio element.
</audio>
```

Useful attributes: `controls`, `autoplay`, `loop`, `muted`

## Video

```html
<video width="640" height="360" controls poster="thumbnail.jpg">
  <source src="video.mp4" type="video/mp4">
  <source src="video.webm" type="video/webm">
  Your browser does not support the video tag.
</video>
```

## Responsive Images

Use `srcset` to serve different sizes:

```html
<img
  src="photo.jpg"
  srcset="photo-400.jpg 400w, photo-800.jpg 800w"
  sizes="(max-width: 600px) 400px, 800px"
  alt="Responsive photo">
```

## iframes

Embed another webpage (e.g. YouTube video, Google Maps):

```html
<iframe
  src="https://www.youtube.com/embed/VIDEO_ID"
  width="560"
  height="315"
  title="YouTube video"
  allowfullscreen>
</iframe>
```

## Key Takeaways
- `alt` text is required for accessibility and SEO — describe the image content
- Use `<figure>` + `<figcaption>` for captioned images
- Always provide multiple `<source>` formats for `<audio>` and `<video>`
- `loading="lazy"` defers off-screen image loading to improve performance
$note$, 0);

  -- ── Lesson 4.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'The <img> Element', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which attribute specifies the file path or URL of an image?',
   '0',
   '["src", "href", "alt", "url"]'::jsonb,
   'src (source) tells the browser where to fetch the image file.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the attribute that provides accessibility text for an image:',
   '<img src="dog.jpg" ___="A golden retriever playing fetch">',
   'alt',
   '["alt", "title", "desc", "caption"]'::jsonb,
   'alt text is read by screen readers and shown if the image fails to load.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why is the alt attribute important even when an image loads successfully?',
   '0',
   '["Screen readers use it to describe the image to visually impaired users", "It controls the image display size", "It helps the browser cache the image", "It sets the image file format"]'::jsonb,
   'Screen readers announce alt text to blind users. Without it, the image is meaningless to them.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a figure element with an image and caption:',
   '[{"id":"1","code":"<figure>"},{"id":"2","code":"  <img src=\"sunset.jpg\" alt=\"Sunset over the ocean\">"},{"id":"3","code":"  <figcaption>Sunset at Cape Coast, Ghana</figcaption>"},{"id":"4","code":"</figure>"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["<figure>","  <img src=\"sunset.jpg\" alt=\"Sunset over the ocean\">","  <figcaption>Sunset at Cape Coast, Ghana</figcaption>","</figure>"]'::jsonb,
   'Open figure, place img with alt, then figcaption, then close figure.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a complete img element: src="banner.png", alt="Site banner", width 1200.',
   '<!-- Write your img element -->',
   '<img src="banner.png" alt="Site banner" width="1200">',
   '<img src="..." alt="..." width="..."> — no closing tag needed (void element).',
   5, 20);

  -- ── Lesson 4.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Image Formats and Performance', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which image format is best for photographs on the web?',
   '0',
   '["JPEG", "PNG", "SVG", "BMP"]'::jsonb,
   'JPEG uses lossy compression ideal for photos with many colours. PNG is better for logos and icons.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the attribute that defers loading of off-screen images:',
   '<img src="hero.jpg" alt="Hero image" ___="lazy">',
   'loading',
   '["loading", "defer", "lazy", "preload"]'::jsonb,
   'loading="lazy" tells the browser to delay fetching the image until it is near the viewport.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What makes SVG ideal for logos and icons?',
   '0',
   '["SVGs are vector-based and scale to any size without losing quality", "SVGs load faster than JPEG always", "SVGs support more colours than PNG", "SVGs are the only format supported by all browsers"]'::jsonb,
   'Vector graphics are made of mathematical paths, so they look sharp at any resolution or zoom level.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Rank these image formats from best to worst for a photo gallery (performance):',
   '[{"id":"1","code":"1st: WebP — modern, smallest file size"},{"id":"2","code":"2nd: JPEG — widely supported, good compression"},{"id":"3","code":"3rd: PNG — larger files, use only when transparency needed"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["1st: WebP — modern, smallest file size","2nd: JPEG — widely supported, good compression","3rd: PNG — larger files, use only when transparency needed"]'::jsonb,
   'WebP first (modern best), JPEG second (classic photos), PNG last (largest files).',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an img tag with lazy loading: src="gallery.jpg", alt="Gallery photo", loading lazy.',
   '<!-- Write your lazy-loading img tag -->',
   '<img src="gallery.jpg" alt="Gallery photo" loading="lazy">',
   '<img src="..." alt="..." loading="lazy">',
   5, 20);

  -- ── Lesson 4.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Audio and Video', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which attribute displays built-in browser controls (play, pause, volume) for audio/video?',
   '0',
   '["controls", "autoplay", "src", "play"]'::jsonb,
   'The controls attribute (no value needed) tells the browser to show default media controls.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the element used to specify an audio source inside <audio>:',
   '<audio controls>' || chr(10) || '  <___ src="song.mp3" type="audio/mpeg">' || chr(10) || '</audio>',
   'source',
   '["source", "src", "media", "file"]'::jsonb,
   '<source> inside <audio> or <video> specifies the media file and its MIME type.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why should you provide multiple <source> elements inside <video>?',
   '0',
   '["Different browsers support different video formats — providing both MP4 and WebM covers all browsers", "It makes the video load faster", "It allows the video to play in two resolutions at once", "It is required by the HTML spec"]'::jsonb,
   'Browsers have varying codec support. MP4 is most compatible; WebM is better quality at smaller size.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a video element with controls and two source formats:',
   '[{"id":"1","code":"<video controls width=\"640\">"},{"id":"2","code":"  <source src=\"clip.mp4\" type=\"video/mp4\">"},{"id":"3","code":"  <source src=\"clip.webm\" type=\"video/webm\">"},{"id":"4","code":"  Your browser does not support video."},{"id":"5","code":"</video>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<video controls width=\"640\">","  <source src=\"clip.mp4\" type=\"video/mp4\">","  <source src=\"clip.webm\" type=\"video/webm\">","  Your browser does not support video.","</video>"]'::jsonb,
   'Video tag, MP4 source, WebM source, fallback text, close tag.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an <audio> tag with controls and one source: src="podcast.mp3", type audio/mpeg.',
   '<!-- Write your audio element -->',
   '<audio controls>' || chr(10) || '  <source src="podcast.mp3" type="audio/mpeg">' || chr(10) || '</audio>',
   '<audio controls><source src="..." type="..."></audio>',
   5, 20);

  -- ── Lesson 4.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Embedding with iframes', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the <iframe> element do?',
   '0',
   '["Embeds another HTML page or external content inside the current page", "Inlines an image from another server", "Creates a scrollable frame within a page", "Loads a JavaScript file"]'::jsonb,
   'iframe (inline frame) renders another complete web document inside a box on your page.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the attribute that allows fullscreen on an embedded video iframe:',
   '<iframe src="..." width="560" height="315" ___></iframe>',
   'allowfullscreen',
   '["allowfullscreen", "fullscreen", "allow-fullscreen", "full"]'::jsonb,
   'allowfullscreen (boolean attribute) permits the embedded content to go fullscreen.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which attribute should ALWAYS be set on an iframe for accessibility?',
   '0',
   '["title", "id", "class", "name"]'::jsonb,
   'title describes the iframe content to screen readers: <iframe title="YouTube video">.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a properly formed iframe for embedding a YouTube video:',
   '[{"id":"1","code":"<iframe"},{"id":"2","code":"  src=\"https://www.youtube.com/embed/abc123\""},{"id":"3","code":"  width=\"560\" height=\"315\""},{"id":"4","code":"  title=\"Demo video\""},{"id":"5","code":"  allowfullscreen>"},{"id":"6","code":"</iframe>"}]'::jsonb,
   '["1","2","3","4","5","6"]'::jsonb,
   '["<iframe","  src=\"https://www.youtube.com/embed/abc123\"","  width=\"560\" height=\"315\"","  title=\"Demo video\"","  allowfullscreen>","</iframe>"]'::jsonb,
   'Open tag, src, dimensions, title, allowfullscreen to close opening tag, then closing tag.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an iframe: src="https://example.com", width 800, height 600, title "Example site".',
   '<!-- Write your iframe element -->',
   '<iframe src="https://example.com" width="800" height="600" title="Example site"></iframe>',
   '<iframe src="..." width="..." height="..." title="..."></iframe>',
   5, 20);


  -- ==============================================================
  -- UNIT 5: Forms
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 5: Forms',
          'Collect user input with form controls, labels, and validation',
          'teal', 5)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'HTML Forms', $note$
# HTML Forms

Forms let users send data to a server or trigger JavaScript actions.

## Basic Form Structure

```html
<form action="/submit" method="post">
  <label for="name">Name:</label>
  <input type="text" id="name" name="name" required>

  <label for="email">Email:</label>
  <input type="email" id="email" name="email" required>

  <button type="submit">Send</button>
</form>
```

| Attribute    | Meaning                                     |
|--------------|---------------------------------------------|
| `action`     | URL to send the form data to                |
| `method`     | HTTP method — `get` or `post`               |
| `for`        | On `<label>` — must match the input's `id`  |
| `name`       | Key used when submitting the form           |
| `required`   | Makes the field mandatory                   |

## Input Types

```html
<input type="text">        <!-- single-line text -->
<input type="email">       <!-- validates email format -->
<input type="password">    <!-- hidden characters -->
<input type="number">      <!-- numeric input -->
<input type="checkbox">    <!-- tick/untick -->
<input type="radio">       <!-- one of a group -->
<input type="date">        <!-- date picker -->
<input type="file">        <!-- file upload -->
<input type="hidden">      <!-- invisible field -->
<input type="range">       <!-- slider -->
<input type="color">       <!-- colour picker -->
<input type="submit">      <!-- submit button -->
<input type="reset">       <!-- reset all fields -->
```

## Textarea and Select

```html
<!-- Multi-line text input -->
<textarea name="message" rows="4" cols="40" placeholder="Write here..."></textarea>

<!-- Dropdown menu -->
<select name="country">
  <option value="gh">Ghana</option>
  <option value="ng">Nigeria</option>
  <option value="ke">Kenya</option>
</select>
```

## Radio Buttons and Checkboxes

```html
<!-- Radio (pick one) — same name groups them -->
<input type="radio" id="male" name="gender" value="male">
<label for="male">Male</label>
<input type="radio" id="female" name="gender" value="female">
<label for="female">Female</label>

<!-- Checkboxes (pick any) -->
<input type="checkbox" id="html" name="skills" value="html">
<label for="html">HTML</label>
```

## Validation Attributes

```html
<input type="text" required minlength="3" maxlength="50" pattern="[A-Za-z]+">
<input type="number" min="0" max="100" step="5">
```

## Key Takeaways
- Always pair `<label>` with its input using matching `for` and `id` values
- Choose the right `type` — it provides built-in validation and mobile-friendly keyboards
- `method="post"` is more secure for sensitive data than `method="get"`
- `required`, `minlength`, `pattern`, and `min`/`max` add built-in HTML validation
$note$, 0);

  -- ── Lesson 5.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Form Basics', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the action attribute on a <form> element specify?',
   '0',
   '["The URL where the form data is sent when submitted", "The type of input field", "The HTTP method to use", "The form styling class"]'::jsonb,
   'action tells the browser where to send the form data (e.g. a server endpoint).',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the method attribute for a form that sends data securely in the request body:',
   '<form action="/submit" method="___">',
   'post',
   '["post", "get", "send", "submit"]'::jsonb,
   'POST sends data in the request body (not in the URL), making it more secure for sensitive data.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why should <label> elements be used with form inputs?',
   '0',
   '["They describe the input to users and screen readers, and clicking a label focuses the input", "They are required for the form to submit", "They control the visual styling of the input", "They encrypt the input value"]'::jsonb,
   'Labels improve accessibility — screen readers read them, and clicking a label activates its input.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a basic login form with email, password, and submit button:',
   '[{"id":"1","code":"<form action=\"/login\" method=\"post\">"},{"id":"2","code":"  <label for=\"email\">Email:</label>"},{"id":"3","code":"  <input type=\"email\" id=\"email\" name=\"email\">"},{"id":"4","code":"  <button type=\"submit\">Login</button>"},{"id":"5","code":"</form>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<form action=\"/login\" method=\"post\">","  <label for=\"email\">Email:</label>","  <input type=\"email\" id=\"email\" name=\"email\">","  <button type=\"submit\">Login</button>","</form>"]'::jsonb,
   'Open form, then label, then input, then submit button, then close form.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a text input with id="username", name="username", and the required attribute.',
   '<!-- Write your input element -->',
   '<input type="text" id="username" name="username" required>',
   '<input type="text" id="..." name="..." required>',
   5, 20);

  -- ── Lesson 5.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Input Types', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does <input type="email"> do that <input type="text"> does not?',
   '0',
   '["Validates that the value contains an @ symbol and domain before submitting", "Encrypts the email address", "Shows an email icon inside the field", "Sends the form to an email address"]'::jsonb,
   'type="email" adds built-in format validation. Mobile keyboards also show the @ key.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the input type that hides the characters as the user types:',
   '<input type="___" name="password">',
   'password',
   '["password", "hidden", "secret", "encrypt"]'::jsonb,
   'type="password" masks characters with dots or asterisks as you type.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What input type creates a file upload button?',
   '0',
   '["<input type=\"file\">", "<input type=\"upload\">", "<input type=\"attach\">", "<input type=\"doc\">"]'::jsonb,
   'type="file" opens the OS file picker when clicked.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a form with text, email, and password fields:',
   '[{"id":"1","code":"<input type=\"text\" name=\"name\" placeholder=\"Your name\">"},{"id":"2","code":"<input type=\"email\" name=\"email\" placeholder=\"Your email\">"},{"id":"3","code":"<input type=\"password\" name=\"pwd\" placeholder=\"Password\">"}]'::jsonb,
   '["1","2","3"]'::jsonb,
   '["<input type=\"text\" name=\"name\" placeholder=\"Your name\">","<input type=\"email\" name=\"email\" placeholder=\"Your email\">","<input type=\"password\" name=\"pwd\" placeholder=\"Password\">"]'::jsonb,
   'Text first, email second, password last — standard registration order.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a number input with name="age", min 1, and max 120.',
   '<!-- Write your number input -->',
   '<input type="number" name="age" min="1" max="120">',
   '<input type="number" name="..." min="..." max="...">',
   5, 20);

  -- ── Lesson 5.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Select, Textarea, and Radio', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What element creates a multi-line text input box?',
   '0',
   '["<textarea>", "<input type=\"multiline\">", "<input type=\"text\" rows=\"4\">", "<multiline>"]'::jsonb,
   '<textarea> is the dedicated multi-line text element. Unlike <input>, it has an opening and closing tag.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the element that creates a dropdown/select menu:',
   '<___  name="country">' || chr(10) || '  <option value="gh">Ghana</option>' || chr(10) || '</___>',
   'select',
   '["select", "dropdown", "option", "menu"]'::jsonb,
   '<select> creates the dropdown container. Each option goes inside as <option>.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'How do you group radio buttons so only one can be selected at a time?',
   '0',
   '["Give all related radio inputs the same name attribute", "Wrap them in a <radiogroup> tag", "Use the group attribute on each", "Add exclusive=\"true\" to each input"]'::jsonb,
   'Radio buttons in the same group must share the same name value. The browser enforces one selection.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a dropdown menu for selecting a programming language:',
   '[{"id":"1","code":"<label for=\"lang\">Language:</label>"},{"id":"2","code":"<select id=\"lang\" name=\"lang\">"},{"id":"3","code":"  <option value=\"py\">Python</option>"},{"id":"4","code":"  <option value=\"js\">JavaScript</option>"},{"id":"5","code":"</select>"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<label for=\"lang\">Language:</label>","<select id=\"lang\" name=\"lang\">","  <option value=\"py\">Python</option>","  <option value=\"js\">JavaScript</option>","</select>"]'::jsonb,
   'Label, then select open, then options, then close select.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a textarea with name="bio", 4 rows, and placeholder "Tell us about yourself".',
   '<!-- Write your textarea -->',
   '<textarea name="bio" rows="4" placeholder="Tell us about yourself"></textarea>',
   '<textarea name="..." rows="..." placeholder="..."></textarea>',
   5, 20);

  -- ── Lesson 5.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Form Validation', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Which attribute prevents a form from submitting when a field is empty?',
   '0',
   '["required", "nosubmit", "validate", "mandatory"]'::jsonb,
   'The required attribute (no value needed) blocks submission and shows an error if the field is empty.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the attribute that sets the minimum character count for a text field:',
   '<input type="text" name="username" ___="3">',
   'minlength',
   '["minlength", "min", "minimum", "minchar"]'::jsonb,
   'minlength sets the minimum number of characters required in the field.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the pattern attribute do on an input element?',
   '0',
   '["Validates the input against a regular expression", "Sets a background pattern for the input", "Groups related inputs", "Adds placeholder text"]'::jsonb,
   'pattern accepts a regex. Example: pattern="[0-9]{4}" requires exactly 4 digits.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a validated form field: required, minlength 5, maxlength 30:',
   '[{"id":"1","code":"<label for=\"user\">Username:</label>"},{"id":"2","code":"<input"},{"id":"3","code":"  type=\"text\""},{"id":"4","code":"  id=\"user\" name=\"user\""},{"id":"5","code":"  required minlength=\"5\" maxlength=\"30\">"}]'::jsonb,
   '["1","2","3","4","5"]'::jsonb,
   '["<label for=\"user\">Username:</label>","<input","  type=\"text\"","  id=\"user\" name=\"user\"","  required minlength=\"5\" maxlength=\"30\">"]'::jsonb,
   'Label, then input opening, type, id/name, then validation attributes to close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write an email input that is required and has placeholder "Enter your email".',
   '<!-- Write your validated email input -->',
   '<input type="email" name="email" required placeholder="Enter your email">',
   '<input type="email" name="email" required placeholder="...">',
   5, 20);


  -- ==============================================================
  -- UNIT 6: Tables and Accessibility
  -- ==============================================================
  INSERT INTO public.units (language_id, title, description, color, order_index)
  VALUES (v_lang_id,
          'Unit 6: Tables and Accessibility',
          'Build accessible data tables and follow WCAG best practices',
          'indigo', 6)
  RETURNING id INTO v_unit_id;

  INSERT INTO public.unit_notes (unit_id, title, content, order_index) VALUES
  (v_unit_id, 'Tables and Web Accessibility', $note$
# Tables and Web Accessibility

## HTML Tables

Tables are for displaying tabular data — not for layout (CSS handles that).

```html
<table>
  <caption>Monthly Sales</caption>
  <thead>
    <tr>
      <th scope="col">Month</th>
      <th scope="col">Revenue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>January</td>
      <td>$12,000</td>
    </tr>
    <tr>
      <td>February</td>
      <td>$15,000</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>Total</td>
      <td>$27,000</td>
    </tr>
  </tfoot>
</table>
```

Key table elements:
- `<table>` — the container
- `<caption>` — title for the table (first child of `<table>`)
- `<thead>` — header rows
- `<tbody>` — data rows
- `<tfoot>` — footer rows (e.g. totals)
- `<tr>` — table row
- `<th>` — header cell (bold and centred by default)
- `<td>` — data cell

## Spanning Cells

```html
<td colspan="2">Spans two columns</td>
<td rowspan="3">Spans three rows</td>
```

## Web Accessibility (WCAG)

**WCAG** (Web Content Accessibility Guidelines) makes the web usable for everyone, including people with disabilities.

Four core principles — **POUR**:
1. **Perceivable** — content can be seen or heard (alt text, captions)
2. **Operable** — navigable by keyboard and assistive tech
3. **Understandable** — clear language, predictable behaviour
4. **Robust** — works with current and future assistive technologies

### Key Practices

```html
<!-- 1. Use alt text on images -->
<img src="chart.png" alt="Bar chart showing Q1 revenue increase of 20%">

<!-- 2. Label every form field -->
<label for="name">Full name</label>
<input id="name" type="text">

<!-- 3. Use semantic HTML -->
<nav>, <main>, <article>, <aside>, <header>, <footer>

<!-- 4. Provide sufficient colour contrast (WCAG AA requires 4.5:1 ratio) -->

<!-- 5. Make interactive elements keyboard accessible -->
<button type="button">Submit</button>  <!-- not a <div onclick="..."> -->

<!-- 6. Use ARIA roles when needed -->
<div role="alert" aria-live="polite">Error message</div>
```

## Key Takeaways
- `<th>` cells should have `scope="col"` or `scope="row"` for screen readers
- Always include `<caption>` to describe what the table contains
- Never use tables for layout — use CSS Flexbox or Grid instead
- The four WCAG principles: Perceivable, Operable, Understandable, Robust (POUR)
$note$, 0);

  -- ── Lesson 6.1 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'HTML Tables', 1)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What element defines a header cell in a table?',
   '0',
   '["<th>", "<td>", "<tr>", "<thead>"]'::jsonb,
   '<th> is a header cell (bold/centred by default). <td> is a regular data cell.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the element that wraps the header rows of a table:',
   '<table>' || chr(10) || '  <___>' || chr(10) || '    <tr><th>Name</th><th>Score</th></tr>' || chr(10) || '  </___>' || chr(10) || '</table>',
   'thead',
   '["thead", "header", "th", "head"]'::jsonb,
   '<thead> groups the header rows. <tbody> groups data rows. <tfoot> groups footer rows.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What attribute makes a table cell span two columns?',
   '0',
   '["colspan=\"2\"", "span=\"2\"", "width=\"2\"", "cols=\"2\""]'::jsonb,
   'colspan merges cells horizontally. rowspan merges cells vertically.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a table with a header row and one data row:',
   '[{"id":"1","code":"<table>"},{"id":"2","code":"  <thead><tr><th>Name</th><th>Age</th></tr></thead>"},{"id":"3","code":"  <tbody>"},{"id":"4","code":"    <tr><td>Alice</td><td>30</td></tr>"},{"id":"5","code":"  </tbody>"},{"id":"6","code":"</table>"}]'::jsonb,
   '["1","2","3","4","5","6"]'::jsonb,
   '["<table>","  <thead><tr><th>Name</th><th>Age</th></tr></thead>","  <tbody>","    <tr><td>Alice</td><td>30</td></tr>","  </tbody>","</table>"]'::jsonb,
   'table, thead with headers, tbody open, data row, tbody close, table close.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a <caption> element inside a table with the text "Student Grades".',
   '<table>' || chr(10) || '  <!-- Write the caption here -->' || chr(10) || '</table>',
   '<table>' || chr(10) || '  <caption>Student Grades</caption>' || chr(10) || '</table>',
   '<caption> is the first child of <table> and describes its content.',
   5, 20);

  -- ── Lesson 6.2 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Table Structure', 2)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What is the correct use of HTML tables according to web standards?',
   '0',
   '["Displaying tabular data only — not for page layout", "Controlling page layout and grid structures", "Embedding images in a structured way", "Replacing CSS Grid for all layouts"]'::jsonb,
   'CSS Flexbox and Grid handle layout. Tables are semantically for data (like spreadsheets).',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the scope attribute value that marks a <th> as a column header:',
   '<th scope="___">Month</th>',
   'col',
   '["col", "row", "column", "header"]'::jsonb,
   'scope="col" tells screen readers this is a column header. scope="row" marks a row header.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does the <tfoot> element represent?',
   '0',
   '["Footer rows of a table — often used for totals or summaries", "The last row of data in tbody", "A footnote below the table", "A hidden footer that is not rendered"]'::jsonb,
   '<tfoot> groups footer rows semantically. Browsers may repeat it when a table spans printed pages.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange a full table with caption, thead, tbody, and tfoot:',
   '[{"id":"1","code":"<table>"},{"id":"2","code":"  <caption>Scores</caption>"},{"id":"3","code":"  <thead><tr><th scope=\"col\">Player</th><th scope=\"col\">Score</th></tr></thead>"},{"id":"4","code":"  <tbody><tr><td>Alice</td><td>95</td></tr></tbody>"},{"id":"5","code":"  <tfoot><tr><td>Average</td><td>95</td></tr></tfoot>"},{"id":"6","code":"</table>"}]'::jsonb,
   '["1","2","3","4","5","6"]'::jsonb,
   '["<table>","  <caption>Scores</caption>","  <thead><tr><th scope=\"col\">Player</th><th scope=\"col\">Score</th></tr></thead>","  <tbody><tr><td>Alice</td><td>95</td></tr></tbody>","  <tfoot><tr><td>Average</td><td>95</td></tr></tfoot>","</table>"]'::jsonb,
   'table, caption, thead, tbody, tfoot, close table.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a table row with a header cell "Total" (scope row) and a data cell "100".',
   '<!-- Write a table row -->',
   '<tr><th scope="row">Total</th><td>100</td></tr>',
   '<tr><th scope="row">...</th><td>...</td></tr>',
   5, 20);

  -- ── Lesson 6.3 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'Web Accessibility Basics', 3)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does WCAG stand for?',
   '0',
   '["Web Content Accessibility Guidelines", "Web Colour and Graphics", "World Computer Access Group", "Web Control and Guidance"]'::jsonb,
   'WCAG = Web Content Accessibility Guidelines — the international standard for accessible web content.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the WCAG principle that means content must be perceivable by all users:',
   'The four WCAG principles are: ___, Operable, Understandable, Robust.',
   'Perceivable',
   '["Perceivable", "Programmable", "Predictable", "Portable"]'::jsonb,
   'The POUR principles: Perceivable, Operable, Understandable, Robust.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'Why should you use <button> rather than <div onclick="..."> for interactive elements?',
   '0',
   '["Buttons are keyboard accessible and announced by screen readers automatically", "Buttons render faster", "div cannot have onclick attributes in HTML5", "Buttons have built-in styling that divs lack"]'::jsonb,
   'Native HTML elements are accessible by default. A <div> with onclick is invisible to keyboard and screen reader users.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange these accessibility best practices from most to least critical:',
   '[{"id":"1","code":"1. Add alt text to all meaningful images"},{"id":"2","code":"2. Label every form input with <label>"},{"id":"3","code":"3. Ensure sufficient colour contrast (4.5:1 ratio)"},{"id":"4","code":"4. Use semantic HTML elements (nav, main, article)"}]'::jsonb,
   '["1","2","3","4"]'::jsonb,
   '["1. Add alt text to all meaningful images","2. Label every form input with <label>","3. Ensure sufficient colour contrast (4.5:1 ratio)","4. Use semantic HTML elements (nav, main, article)"]'::jsonb,
   'All four are important; alt text and labels are the most common issues found in audits.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a button element (type submit) with accessible text "Submit Form".',
   '<!-- Write an accessible submit button -->',
   '<button type="submit">Submit Form</button>',
   '<button type="submit">visible label text</button>',
   5, 20);

  -- ── Lesson 6.4 ─────────────────────────────────────────────
  INSERT INTO public.lessons (unit_id, title, order_index)
  VALUES (v_unit_id, 'ARIA and Keyboard Navigation', 4)
  RETURNING id INTO v_lesson_id;

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does ARIA stand for?',
   '0',
   '["Accessible Rich Internet Applications", "Advanced Rendering Interface API", "Automated Responsive Interface Attributes", "Application and Resource Integration API"]'::jsonb,
   'ARIA = Accessible Rich Internet Applications — a set of attributes to bridge accessibility gaps.',
   1, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, code, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'fill-blank',
   'Complete the ARIA attribute that provides an accessible label for an element without visible text:',
   '<button ___-label="Close dialog">×</button>',
   'aria',
   '["aria", "role", "label", "alt"]'::jsonb,
   'aria-label gives screen readers a text description when the visual label is insufficient.',
   2, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, answer, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'multiple-choice',
   'What does tabindex="0" do on a non-interactive element like a <div>?',
   '0',
   '["Makes it focusable and reachable via keyboard Tab key", "Hides it from screen readers", "Sets its z-index in the stacking context", "Moves it to the first tab stop on the page"]'::jsonb,
   'tabindex="0" adds an element to the natural tab order. tabindex="-1" makes it programmatically focusable but removes it from the tab order.',
   3, 10);

  INSERT INTO public.questions (lesson_id, type, instruction, blocks, correct_order, options, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'drag-order',
   'Arrange the ARIA attributes for a live error message region:',
   '[{"id":"1","code":"<div"},{"id":"2","code":"  role=\"alert\""},{"id":"3","code":"  aria-live=\"assertive\""},{"id":"4","code">"},{"id":"5","code":"  Password must be at least 8 characters."},{"id":"6","code":"</div>"}]'::jsonb,
   '["1","2","3","4","5","6"]'::jsonb,
   '["<div","  role=\"alert\"","  aria-live=\"assertive\">","  Password must be at least 8 characters.","</div>"]'::jsonb,
   'Open div tag, add role="alert", then aria-live, close opening tag, content, close div.',
   4, 15);

  INSERT INTO public.questions (lesson_id, type, instruction, initial_code, expected_output, hint, order_index, xp_reward) VALUES
  (v_lesson_id, 'code-runner',
   'Write a button that has an aria-label of "Open navigation menu" and contains a hamburger ☰ icon.',
   '<!-- Write the accessible button -->',
   '<button type="button" aria-label="Open navigation menu">☰</button>',
   '<button type="button" aria-label="...">icon</button>',
   5, 20);

END $$;