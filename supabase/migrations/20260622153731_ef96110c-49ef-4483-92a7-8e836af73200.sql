
-- Add theme preference column
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS theme_preference TEXT NOT NULL DEFAULT 'emerald';

-- Update handle_new_user to read theme_preference from metadata
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $function$
BEGIN
  INSERT INTO public.profiles (user_id, display_name, username, coding_experience, theme_preference)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'Learner'),
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'coding_experience', 'beginner'),
    COALESCE(NEW.raw_user_meta_data->>'theme_preference', 'emerald')
  )
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$function$;

-- Attach trigger on auth.users (drop first to be safe)
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Backfill profiles for any auth users that don't have one
INSERT INTO public.profiles (user_id, display_name, username, coding_experience, theme_preference)
SELECT u.id,
       COALESCE(u.raw_user_meta_data->>'full_name', 'Learner'),
       u.email,
       COALESCE(u.raw_user_meta_data->>'coding_experience', 'beginner'),
       COALESCE(u.raw_user_meta_data->>'theme_preference', 'emerald')
FROM auth.users u
LEFT JOIN public.profiles p ON p.user_id = u.id
WHERE p.user_id IS NULL;
