-- Kangaroo: almacenamiento sincronizado y aislado por usuario autenticado.
-- Ejecutar una sola vez en Supabase SQL Editor o mediante Supabase CLI.

create extension if not exists pgcrypto;

create table if not exists public.kangaroo_workspaces (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null default 'Mi inventario Kangaroo',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.kangaroo_collections (
  workspace_id uuid not null references public.kangaroo_workspaces(id) on delete cascade,
  collection text not null check (collection in ('products','providers','movements','dispatches','settings')),
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (workspace_id, collection)
);

alter table public.kangaroo_workspaces enable row level security;
alter table public.kangaroo_collections enable row level security;

-- Permite ejecutar esta migración nuevamente si una ejecución anterior se interrumpió.
drop policy if exists "Users manage only their Kangaroo workspace" on public.kangaroo_workspaces;
drop policy if exists "Users read only their Kangaroo collections" on public.kangaroo_collections;
drop policy if exists "Users write only their Kangaroo collections" on public.kangaroo_collections;
drop policy if exists "Users update only their Kangaroo collections" on public.kangaroo_collections;
drop policy if exists "Users delete only their Kangaroo collections" on public.kangaroo_collections;

create policy "Users manage only their Kangaroo workspace"
on public.kangaroo_workspaces for all to authenticated
using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy "Users read only their Kangaroo collections"
on public.kangaroo_collections for select to authenticated
using (exists (select 1 from public.kangaroo_workspaces w where w.id = workspace_id and w.owner_id = auth.uid()));

create policy "Users write only their Kangaroo collections"
on public.kangaroo_collections for insert to authenticated
with check (exists (select 1 from public.kangaroo_workspaces w where w.id = workspace_id and w.owner_id = auth.uid()));

create policy "Users update only their Kangaroo collections"
on public.kangaroo_collections for update to authenticated
using (exists (select 1 from public.kangaroo_workspaces w where w.id = workspace_id and w.owner_id = auth.uid()))
with check (exists (select 1 from public.kangaroo_workspaces w where w.id = workspace_id and w.owner_id = auth.uid()));

create policy "Users delete only their Kangaroo collections"
on public.kangaroo_collections for delete to authenticated
using (exists (select 1 from public.kangaroo_workspaces w where w.id = workspace_id and w.owner_id = auth.uid()));

create or replace function public.kangaroo_touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists kangaroo_workspaces_touch on public.kangaroo_workspaces;
create trigger kangaroo_workspaces_touch before update on public.kangaroo_workspaces
for each row execute function public.kangaroo_touch_updated_at();

drop trigger if exists kangaroo_collections_touch on public.kangaroo_collections;
create trigger kangaroo_collections_touch before update on public.kangaroo_collections
for each row execute function public.kangaroo_touch_updated_at();
