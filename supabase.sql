-- OPTIONAL cloud sync setup. Run in Supabase SQL Editor.
-- Use anon/public key only in the app. Never put service_role key in the client.
create table if not exists public.ledger_books (
  id text primary key,
  data jsonb not null default '{"people":[],"moves":[]}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.ledger_books enable row level security;
-- Initial simple shared-book policy: anyone with the public API key can read/write.
-- WARNING: this is not private/authenticated. Use only for testing with non-sensitive data.
-- Before using real customer records, replace with authenticated user + membership policies.
create policy "test read ledger" on public.ledger_books for select to anon using (true);
create policy "test insert ledger" on public.ledger_books for insert to anon with check (true);
create policy "test update ledger" on public.ledger_books for update to anon using (true) with check (true);
