-- Validation trigger to prevent invalid JSON in questions table
CREATE OR REPLACE FUNCTION public.validate_question_json()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = public
AS $fn$
DECLARE
  v_txt text;
BEGIN
  IF NEW.options IS NOT NULL AND jsonb_typeof(NEW.options) <> 'array' THEN
    RAISE EXCEPTION 'questions.options must be a JSON array, got %', jsonb_typeof(NEW.options);
  END IF;

  IF NEW.answer IS NOT NULL THEN
    v_txt := TRIM(NEW.answer);
    IF left(v_txt,1) IN ('{','[') THEN
      BEGIN
        PERFORM v_txt::jsonb;
      EXCEPTION WHEN others THEN
        RAISE EXCEPTION 'questions.answer contains invalid JSON: %', NEW.answer;
      END;
    END IF;
  END IF;

  IF NEW.hint IS NOT NULL THEN
    v_txt := TRIM(NEW.hint);
    IF left(v_txt,1) IN ('{','[') THEN
      BEGIN
        PERFORM v_txt::jsonb;
      EXCEPTION WHEN others THEN
        RAISE EXCEPTION 'questions.hint contains invalid JSON: %', NEW.hint;
      END;
    END IF;
  END IF;

  RETURN NEW;
END;
$fn$;

DROP TRIGGER IF EXISTS validate_question_json_trg ON public.questions;
CREATE TRIGGER validate_question_json_trg
  BEFORE INSERT OR UPDATE ON public.questions
  FOR EACH ROW EXECUTE FUNCTION public.validate_question_json();