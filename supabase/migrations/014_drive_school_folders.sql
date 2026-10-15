-- GetGrant трекер: обновление 14 — папки на Google Диске по школам.
-- Supabase → SQL Editor → New query → вставить весь файл → Run. Повторный запуск безопасен. Нужна миграция 013 (поле «Где учится»).
-- drive_access() теперь сообщает функции drive ещё и школу ученика, чтобы новая папка создавалась
-- внутри папки школы: «Центр GetGrant», «Келечек MIT» или «Звёздочка» в корневой папке Диска.
-- Кто к чему имеет доступ — не меняется.

create or replace function public.drive_access(sid text default null) returns json
language plpgsql stable security definer set search_path = public as $$
declare
  is_staff boolean := public.tracker_is_staff();
  me text := public.tracker_my_student_id();
  r record;
begin
  if not is_staff then
    if me is null or (sid is not null and sid <> me) then return null; end if;
    sid := me;
  end if;
  if sid is null then return null; end if;
  select id, name, drive_folder_id, school into r from public.tracker_students where id = sid;
  if not found then return null; end if;
  return json_build_object(
    'role', case when is_staff then 'staff' else 'student' end,
    'id', r.id, 'name', r.name, 'folderId', r.drive_folder_id,
    'school', coalesce(nullif(r.school, ''), 'Центр GetGrant'),
    'email', lower(auth.jwt() ->> 'email'));
end $$;

revoke all on function public.drive_access(text) from public, anon;
grant execute on function public.drive_access(text) to authenticated;
