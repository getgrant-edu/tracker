-- GetGrant трекер: обновление 16 — этап работы и метки студента (доска и таблица в «Сводке»).
-- Supabase → SQL Editor → New query → вставить весь файл → Run. Повторный запуск безопасен.
--   stage — этап на доске («Выбирает вузы», «Готовит документы», …). Пусто = трекер определяет этап сам по заявкам.
--   tags  — свои метки кураторов («олимпиадник», «нужен IELTS» …).
-- Оба поля видят только кураторы (правило "staff full access"); student_portal() их не возвращает.

alter table public.tracker_students add column if not exists stage text;
alter table public.tracker_students add column if not exists tags text[] not null default '{}';
