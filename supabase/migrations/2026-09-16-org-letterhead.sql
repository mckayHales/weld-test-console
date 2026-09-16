-- Run this on a live project instead of re-running schema.sql (which
-- wipes data). Adds the letterhead address and phone to the org, for the
-- header on printed records. Safe to run twice.
alter table orgs add column if not exists address text not null default '';
alter table orgs add column if not exists phone   text not null default '';
