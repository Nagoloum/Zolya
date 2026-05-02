-- =========================================================================
-- ZOLYA — Données initiales (zones, catégories, paramètres)
-- =========================================================================

-- Zones de livraison
insert into delivery_zones (code, name, fee, description) values
('zone1', 'Zone 1 — Centre-ville', 1500, 'Zone dense, forte activite commerciale'),
('zone2', 'Zone 2 — Proche centre', 1000, 'Zones residentielles et commerciales mixtes'),
('zone3', 'Zone 3 — Peripherie', 2000, 'Longues distances, couts logistiques eleves')
on conflict (code) do nothing;

-- Quartiers Zone 1
insert into zone_neighborhoods (zone_id, neighborhood)
select id, n from delivery_zones, unnest(array[
    'Akwa', 'Bonanjo', 'Bali', 'Deido centre', 'Bonapriso', 'New Bell'
]) as n
where code = 'zone1'
on conflict do nothing;

-- Quartiers Zone 2
insert into zone_neighborhoods (zone_id, neighborhood)
select id, n from delivery_zones, unnest(array[
    'Bonamoussadi', 'Makepe', 'Kotto', 'Bepanda', 'Ndokoti',
    'PK8', 'Logbaba', 'Akwa Nord', 'Logpom'
]) as n
where code = 'zone2'
on conflict do nothing;

-- Quartiers Zone 3
insert into zone_neighborhoods (zone_id, neighborhood)
select id, n from delivery_zones, unnest(array[
    'PK10', 'PK11', 'PK12', 'Yassa', 'Nyalla', 'Japoma', 'Bonaberi', 'Lendi'
]) as n
where code = 'zone3'
on conflict do nothing;

-- Catégories de base
insert into categories (name, slug, sort_order) values
('Femme', 'femme', 1),
('Homme', 'homme', 2),
('Enfant', 'enfant', 3),
('Chaussures', 'chaussures', 4),
('Accessoires', 'accessoires', 5),
('Sport', 'sport', 6)
on conflict (slug) do nothing;

-- Paramètres globaux
insert into app_settings (key, value) values
('commission_rate',         '0.15'::jsonb),
('courier_rate_per_delivery','500'::jsonb),
('payout_day_of_week',      '"friday"'::jsonb),
('otp_expiry_minutes',      '5'::jsonb),
('min_withdrawal_amount',   '2000'::jsonb)
on conflict (key) do nothing;
