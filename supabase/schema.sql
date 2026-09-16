-- Weld Test Console — database schema
-- Paste the whole file into Supabase → SQL Editor → New query → Run.
--
-- Re-runnable: it drops and recreates everything below. That WIPES all
-- records, companies, WPSs and tickets. Fine on a fresh project; on a
-- live one, back up first (Settings → Export in the app) or don't run it.

drop function if exists submit_ticket(text, jsonb);
drop function if exists get_ticket(text);
drop function if exists create_org(text, text, text, text, text);
drop table if exists tickets   cascade;
drop table if exists records   cascade;
drop table if exists wps       cascade;
drop table if exists companies cascade;
drop table if exists profiles  cascade;
drop table if exists orgs      cascade;
drop function if exists my_org();

-- ---------------------------------------------------------------
-- Tenancy. An org is one inspection company (Yeti Welding, the
-- coworker's outfit, a CWI who buys the app later). A profile ties a
-- signed-in user to exactly one org.
-- ---------------------------------------------------------------
create table orgs (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  city        text not null default '',
  address     text not null default '',   -- letterhead line on printed records
  phone       text not null default '',
  code        text not null default 'AWS D1.1:2025',
  created_at  timestamptz not null default now()
);

create table profiles (
  user_id     uuid primary key references auth.users on delete cascade,
  org_id      uuid not null references orgs on delete cascade,
  name        text not null default '',
  cert        text not null default '',
  created_at  timestamptz not null default now()
);

-- The org of whoever is calling. Every row-level policy below hangs off this.
create function my_org() returns uuid
language sql stable security definer set search_path = public as $$
  select org_id from profiles where user_id = auth.uid()
$$;

-- ---------------------------------------------------------------
-- The inspector's data. Each row is one front-end object stored as
-- jsonb, keyed by the short id the app already generates. (org_id, id)
-- is the key so two orgs can both hold "demo-co-1" without colliding.
-- ---------------------------------------------------------------
create table companies (
  org_id      uuid not null references orgs on delete cascade,
  id          text not null,
  data        jsonb not null default '{}',
  updated_at  timestamptz not null default now(),
  primary key (org_id, id)
);

create table wps (
  org_id      uuid not null references orgs on delete cascade,
  id          text not null,
  data        jsonb not null default '{}',
  updated_at  timestamptz not null default now(),
  primary key (org_id, id)
);

create table records (
  org_id      uuid not null references orgs on delete cascade,
  id          text not null,
  ticket_id   text,
  data        jsonb not null default '{}',
  updated_at  timestamptz not null default now(),
  primary key (org_id, id)
);

-- A ticket is what the inspector texts to a welder. Its id is the
-- whole secret: long, random, and the only thing the welder's link
-- carries. It snapshots the WPS and the shop header at creation so the
-- welder sees exactly what the inspector saw.
create table tickets (
  id            text primary key,
  org_id        uuid not null references orgs on delete cascade,
  data          jsonb not null default '{}',   -- prefill: companyId, company, name, wpsId, wps, position, process
  wps           jsonb,                          -- snapshot of the WPS object, or null
  org_info      jsonb not null default '{}',   -- { shop, city, inspector, code }
  status        text not null default 'open',  -- open | submitted
  submission    jsonb,                          -- the welder's answers, once sent
  record_id     text,
  created_at    timestamptz not null default now(),
  submitted_at  timestamptz
);

-- ---------------------------------------------------------------
-- Row-level security. Signed-in inspectors see their own org, full stop.
-- Anonymous (welder) traffic gets no table access at all; it goes
-- through the two functions further down.
-- ---------------------------------------------------------------
alter table orgs      enable row level security;
alter table profiles  enable row level security;
alter table companies enable row level security;
alter table wps       enable row level security;
alter table records   enable row level security;
alter table tickets   enable row level security;

create policy "own org"     on orgs     for select to authenticated using (id = my_org());
create policy "edit own org" on orgs    for update to authenticated using (id = my_org()) with check (id = my_org());

create policy "own profile"  on profiles for select to authenticated using (user_id = auth.uid());
create policy "edit profile" on profiles for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "org rows" on companies for all to authenticated using (org_id = my_org()) with check (org_id = my_org());
create policy "org rows" on wps       for all to authenticated using (org_id = my_org()) with check (org_id = my_org());
create policy "org rows" on records   for all to authenticated using (org_id = my_org()) with check (org_id = my_org());
create policy "org rows" on tickets   for all to authenticated using (org_id = my_org()) with check (org_id = my_org());

-- ---------------------------------------------------------------
-- First sign-in: make the org and the profile in one step.
-- ---------------------------------------------------------------
create function create_org(p_name text, p_city text, p_code text, p_inspector text, p_cert text)
returns uuid language plpgsql security definer set search_path = public as $$
declare oid uuid;
begin
  if auth.uid() is null then raise exception 'not signed in'; end if;
  if exists (select 1 from profiles where user_id = auth.uid()) then raise exception 'already set up'; end if;
  insert into orgs (name, city, code) values (p_name, coalesce(p_city,''), coalesce(nullif(p_code,''),'AWS D1.1:2025')) returning id into oid;
  insert into profiles (user_id, org_id, name, cert) values (auth.uid(), oid, coalesce(p_inspector,''), coalesce(p_cert,''));
  return oid;
end $$;

-- ---------------------------------------------------------------
-- The welder's side. No login. The ticket id is the credential.
-- ---------------------------------------------------------------
create function get_ticket(tid text) returns jsonb
language sql stable security definer set search_path = public as $$
  select jsonb_build_object('id', id, 'status', status, 'data', data, 'wps', wps, 'org', org_info)
  from tickets where id = tid
$$;

-- Turns an open ticket into a record the inspector will find waiting.
-- Returns 'ok', 'missing', or 'closed'.
create function submit_ticket(tid text, payload jsonb) returns text
language plpgsql security definer set search_path = public as $$
declare t tickets%rowtype; rid text;
begin
  select * into t from tickets where id = tid for update;
  if t.id is null then return 'missing'; end if;
  if t.status <> 'open' then return 'closed'; end if;
  rid := 'r' || substr(replace(gen_random_uuid()::text, '-', ''), 1, 12);
  insert into records (org_id, id, ticket_id, data)
    values (t.org_id, rid, tid,
      jsonb_build_object('w', payload, 'r', '{}'::jsonb, 'status', 'Awaiting test',
                         'updated', (extract(epoch from now()) * 1000)::bigint));
  update tickets set status = 'submitted', submission = payload, record_id = rid, submitted_at = now()
    where id = tid;
  return 'ok';
end $$;

revoke all on function get_ticket(text) from public;
revoke all on function submit_ticket(text, jsonb) from public;
revoke all on function create_org(text, text, text, text, text) from public;
grant execute on function get_ticket(text) to anon, authenticated;
grant execute on function submit_ticket(text, jsonb) to anon, authenticated;
grant execute on function create_org(text, text, text, text, text) to authenticated;
