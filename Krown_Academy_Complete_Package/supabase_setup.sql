-- Krown Academy Supabase Setup Script

-- 1. Create the Students Table
CREATE TABLE public.students (
    id TEXT PRIMARY KEY,
    pin TEXT NOT NULL,
    name TEXT NOT NULL,
    grade TEXT NOT NULL,
    credits_earned INTEGER NOT NULL DEFAULT 0,
    credits_needed INTEGER NOT NULL,
    taken JSONB DEFAULT '[]'::jsonb,
    needed JSONB DEFAULT '[]'::jsonb
);

-- Turn on Row Level Security (RLS) policies for security
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;

-- Allow anonymous read access to specific rows if they know the ID and PIN (This will be enforced by the Next.js API/Client logic)
CREATE POLICY "Enable read access for all users" ON public.students FOR SELECT USING (true);

-- Insert the Demo Student from the codebase
INSERT INTO public.students (id, pin, name, grade, credits_earned, credits_needed, taken, needed)
VALUES (
    'KNDL01',
    '2024',
    'Kendall Junior',
    '11th Grade',
    16,
    22,
    '["English I", "English II", "Algebra I", "Geometry", "Earth Science", "Biology", "World History", "Civics", "Health/PE", "Spanish I", "Expressive Writing"]',
    '["English III", "English IV", "Algebra II", "4th Math", "Chemistry/Physical Science", "US History", "Economics/Personal Finance", "Spanish II"]'
);


-- 2. Create the Applications/Forms Table
CREATE TABLE public.applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    form_type TEXT NOT NULL,
    data JSONB NOT NULL,
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Turn on Row Level Security (RLS)
ALTER TABLE public.applications ENABLE ROW LEVEL SECURITY;

-- Allow anyone to INSERT a new application, but NO ONE can select/read them except authorized admins using the Supabase Dashboard
CREATE POLICY "Enable insert for all users" ON public.applications FOR INSERT WITH CHECK (true);
