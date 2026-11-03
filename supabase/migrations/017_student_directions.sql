-- GetGrant трекер: обновление 17 — вкладка «Направления» (Common App, Китай, Гонконг, Корея, Партнёрские, Hungaricum, ОАЭ, Катар).
-- Supabase → SQL Editor → New query → вставить весь файл → Run. Повторный запуск безопасен.
--   directions     — в каких направлениях студент (список названий)
--   direction_data — колонки направлений: {"Китай": {"csca": "Math", "med": "Готово", ...}, ...}
-- Поля видят только кураторы (правило "staff full access"); student_portal() их не возвращает.

alter table public.tracker_students add column if not exists directions text[] not null default '{}';
alter table public.tracker_students add column if not exists direction_data jsonb not null default '{}'::jsonb;
