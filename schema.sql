-- ModeStore Supabase setup
-- Run this entire script in Supabase Dashboard > SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric(10,2) not null check (price >= 0),
  category text not null,
  quality text not null,
  size text default '',
  condition text default 'Bon état',
  description text default '',
  photo_url text default '',
  is_available boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.products enable row level security;

-- Public visitors can only see available products.
drop policy if exists "Public can view available products" on public.products;
create policy "Public can view available products"
on public.products for select
using (is_available = true);

-- Only signed-in users can insert/update/delete. Create the admin account yourself
-- in Supabase Dashboard > Authentication > Users. Do NOT enable public signups.
drop policy if exists "Authenticated admins can insert products" on public.products;
create policy "Authenticated admins can insert products"
on public.products for insert to authenticated
with check (true);

drop policy if exists "Authenticated admins can update products" on public.products;
create policy "Authenticated admins can update products"
on public.products for update to authenticated
using (true) with check (true);

drop policy if exists "Authenticated admins can delete products" on public.products;
create policy "Authenticated admins can delete products"
on public.products for delete to authenticated
using (true);

-- Public product image bucket. Product records remain protected by table policies.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('product-photos', 'product-photos', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true;

drop policy if exists "Public can view product photos" on storage.objects;
create policy "Public can view product photos"
on storage.objects for select
using (bucket_id = 'product-photos');

drop policy if exists "Authenticated users can upload product photos" on storage.objects;
create policy "Authenticated users can upload product photos"
on storage.objects for insert to authenticated
with check (bucket_id = 'product-photos');

drop policy if exists "Authenticated users can update product photos" on storage.objects;
create policy "Authenticated users can update product photos"
on storage.objects for update to authenticated
using (bucket_id = 'product-photos') with check (bucket_id = 'product-photos');

drop policy if exists "Authenticated users can delete product photos" on storage.objects;
create policy "Authenticated users can delete product photos"
on storage.objects for delete to authenticated
using (bucket_id = 'product-photos');
