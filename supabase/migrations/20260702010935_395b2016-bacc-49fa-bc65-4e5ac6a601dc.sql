CREATE OR REPLACE FUNCTION public.validate_question_json()
RETURNS trigger
LANGUAGE plpgsql
SET search_path TO 'public'
AS $$
BEGIN
  IF NEW.options IS NOT NULL AND jsonb_typeof(NEW.options) <> 'array' THEN
    RAISE EXCEPTION 'questions.options must be a JSON array, got %', jsonb_typeof(NEW.options);
  END IF;
  RETURN NEW;
END;
$$;

DELETE FROM public.units
WHERE language_id IN (
  SELECT id FROM public.languages WHERE slug IN ('javascript', 'html')
);