-- Visual inspection reports — job-site inspections, separate from
-- welder qualification. Same shape as the other data tables. Safe to
-- run twice.
create table if not exists inspections (
  org_id      uuid not null references orgs on delete cascade,
  id          text not null,
  data        jsonb not null default '{}',
  updated_at  timestamptz not null default now(),
  primary key (org_id, id)
);
alter table inspections enable row level security;
drop policy if exists "org rows" on inspections;
create policy "org rows" on inspections for all to authenticated using (org_id = my_org()) with check (org_id = my_org());
