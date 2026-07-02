DELETE FROM public.units
WHERE language_id IN (
  SELECT id FROM public.languages WHERE slug IN ('javascript', 'html')
);