-- Merge duplicate C++ language rows (legacy slug 'c++' vs canonical 'cpp').
-- Keeps the real curriculum on slug 'cpp' and removes the legacy duplicate.

DO $$
DECLARE
  v_legacy_id   uuid;
  v_canonical_id uuid;
BEGIN
  SELECT id INTO v_legacy_id
  FROM public.languages
  WHERE slug = 'c++'
  LIMIT 1;

  IF v_legacy_id IS NULL THEN
    RETURN;
  END IF;

  SELECT id INTO v_canonical_id
  FROM public.languages
  WHERE slug = 'cpp'
  LIMIT 1;

  IF v_canonical_id IS NULL THEN
    UPDATE public.languages
    SET slug = 'cpp',
        name = 'C++',
        icon = COALESCE(NULLIF(icon, ''), '⚙️'),
        description = COALESCE(
          description,
          'A powerful, fast, systems-level programming language'
        )
    WHERE id = v_legacy_id;
    RETURN;
  END IF;

  -- Both rows exist: point user prefs at canonical, drop legacy curriculum + row.
  UPDATE public.profiles
  SET active_language_id = v_canonical_id
  WHERE active_language_id = v_legacy_id;

  DELETE FROM public.units
  WHERE language_id = v_legacy_id;

  DELETE FROM public.languages
  WHERE id = v_legacy_id;
END $$;
