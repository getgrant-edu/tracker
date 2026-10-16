-- GetGrant трекер: обновление 15 — анкета «Student personal information».
-- Supabase → SQL Editor → New query → вставить весь файл → Run. Повторный запуск безопасен.
-- Кураторы заполняют анкету в карточке студента (вкладка «Документы»), а функция drive
-- собирает из неё Google Doc в папке студента. Анкету видят только кураторы (правило "staff full access"):
-- student_portal() её не возвращает, студентам она не видна.

alter table public.tracker_students add column if not exists personal jsonb not null default '{}'::jsonb;
