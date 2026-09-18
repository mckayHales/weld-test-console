-- Logo for the letterhead, stored as a small PNG data URL. Safe to run twice.
alter table orgs add column if not exists logo text;
