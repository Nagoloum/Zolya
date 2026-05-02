-- =========================================================================
-- ZOLYA — Schéma initial (MVP niveau 1)
-- PostgreSQL / Supabase
-- =========================================================================

create extension if not exists "pgcrypto";
create extension if not exists "uuid-ossp";

-- =========================================================================
-- 1. ZONES DE LIVRAISON (référentiel)
-- =========================================================================
create table if not exists delivery_zones (
    id uuid primary key default gen_random_uuid(),
    code varchar(20) unique not null,           -- zone1, zone2, zone3
    name varchar(60) not null,
    fee integer not null,                        -- FCFA
    description text,
    created_at timestamptz default now()
);

create table if not exists zone_neighborhoods (
    id uuid primary key default gen_random_uuid(),
    zone_id uuid not null references delivery_zones(id) on delete cascade,
    neighborhood varchar(80) not null,
    unique (zone_id, neighborhood)
);

-- =========================================================================
-- 2. UTILISATEURS & AUTH
-- =========================================================================
create table if not exists users (
    id uuid primary key default gen_random_uuid(),
    full_name varchar(120) not null,
    phone varchar(20) unique not null,
    email varchar(150) unique,
    password_hash text not null,
    avatar_url text,
    is_phone_verified boolean default false,
    is_courier boolean default false,
    is_admin boolean default false,
    is_banned boolean default false,
    rating_avg numeric(3,2) default 0,
    rating_count integer default 0,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create index if not exists idx_users_phone on users(phone);
create index if not exists idx_users_is_courier on users(is_courier) where is_courier = true;

create table if not exists otp_codes (
    id uuid primary key default gen_random_uuid(),
    phone varchar(20) not null,
    code varchar(6) not null,
    purpose varchar(30) not null,                -- signup, login, reset
    expires_at timestamptz not null,
    consumed boolean default false,
    created_at timestamptz default now()
);

create index if not exists idx_otp_phone on otp_codes(phone, purpose);

create table if not exists user_addresses (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references users(id) on delete cascade,
    label varchar(50),
    zone_id uuid references delivery_zones(id),
    neighborhood varchar(80) not null,
    street text,
    landmark text,
    phone_contact varchar(20),
    instructions text,
    is_default boolean default false,
    created_at timestamptz default now()
);

create index if not exists idx_addresses_user on user_addresses(user_id);

-- =========================================================================
-- 3. CATALOGUE / ARTICLES
-- =========================================================================
create table if not exists categories (
    id uuid primary key default gen_random_uuid(),
    name varchar(80) not null,
    slug varchar(80) unique not null,
    parent_id uuid references categories(id) on delete set null,
    icon_url text,
    sort_order integer default 0,
    is_active boolean default true
);

create table if not exists items (
    id uuid primary key default gen_random_uuid(),
    seller_id uuid not null references users(id) on delete cascade,
    category_id uuid references categories(id),
    title varchar(150) not null,
    description text not null,
    price integer not null check (price > 0),
    size varchar(20),
    brand varchar(80),
    color varchar(40),
    condition varchar(30) not null,              -- neuf, very_good, good, acceptable
    status varchar(20) not null default 'active',-- active, sold, paused, blocked
    views_count integer default 0,
    likes_count integer default 0,
    video_url text not null,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create index if not exists idx_items_seller on items(seller_id);
create index if not exists idx_items_category on items(category_id);
create index if not exists idx_items_status on items(status);
create index if not exists idx_items_created on items(created_at desc);

create table if not exists item_photos (
    id uuid primary key default gen_random_uuid(),
    item_id uuid not null references items(id) on delete cascade,
    url text not null,
    position integer default 0
);

create index if not exists idx_item_photos_item on item_photos(item_id, position);

create table if not exists favorites (
    user_id uuid references users(id) on delete cascade,
    item_id uuid references items(id) on delete cascade,
    created_at timestamptz default now(),
    primary key (user_id, item_id)
);

-- =========================================================================
-- 4. PROFIL LIVREUR
-- =========================================================================
create table if not exists couriers (
    id uuid primary key default gen_random_uuid(),
    user_id uuid unique not null references users(id) on delete cascade,
    id_card_url text,
    vehicle_type varchar(40),                    -- moto, voiture, velo
    vehicle_plate varchar(30),
    active_zone_id uuid references delivery_zones(id),
    is_available boolean default true,
    total_deliveries integer default 0,
    rating_avg numeric(3,2) default 0,
    activated_at timestamptz,
    activated_by uuid references users(id),
    created_at timestamptz default now()
);

create index if not exists idx_couriers_available on couriers(is_available) where is_available = true;

-- =========================================================================
-- 5. COMMANDES
-- =========================================================================
create table if not exists orders (
    id uuid primary key default gen_random_uuid(),
    order_number varchar(20) unique not null,
    buyer_id uuid not null references users(id),
    seller_id uuid not null references users(id),
    item_id uuid not null references items(id),
    courier_id uuid references users(id),
    delivery_address_id uuid references user_addresses(id),
    zone_id uuid references delivery_zones(id),

    item_price integer not null,
    delivery_fee integer not null,
    total_amount integer not null,
    commission_rate numeric(5,4) not null default 0.15,
    commission_amount integer not null,
    seller_payout integer not null,
    courier_payout integer not null,

    status varchar(30) not null default 'pending_payment',
    -- pending_payment, paid, awaiting_courier, picked_up,
    -- in_delivery, delivered, cancelled, disputed, refunded

    delivery_instructions text,

    paid_at timestamptz,
    assigned_at timestamptz,
    picked_up_at timestamptz,
    delivered_at timestamptz,
    released_at timestamptz,
    cancelled_at timestamptz,

    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create index if not exists idx_orders_buyer on orders(buyer_id, created_at desc);
create index if not exists idx_orders_seller on orders(seller_id, created_at desc);
create index if not exists idx_orders_courier on orders(courier_id, created_at desc);
create index if not exists idx_orders_status on orders(status);
create index if not exists idx_orders_number on orders(order_number);

create table if not exists order_status_history (
    id uuid primary key default gen_random_uuid(),
    order_id uuid not null references orders(id) on delete cascade,
    from_status varchar(30),
    to_status varchar(30) not null,
    changed_by uuid references users(id),
    note text,
    created_at timestamptz default now()
);

create index if not exists idx_order_history_order on order_status_history(order_id, created_at);

-- =========================================================================
-- 6. PAIEMENTS & ESCROW
-- =========================================================================
create table if not exists payments (
    id uuid primary key default gen_random_uuid(),
    order_id uuid not null references orders(id) on delete cascade,
    user_id uuid not null references users(id),
    provider varchar(30) not null,               -- mtn_momo, orange_money
    provider_tx_id varchar(120),
    phone_number varchar(20),
    amount integer not null,
    currency varchar(5) default 'XAF',
    status varchar(20) not null,                 -- initiated, success, failed, cancelled
    raw_response jsonb,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create index if not exists idx_payments_order on payments(order_id);
create index if not exists idx_payments_provider_tx on payments(provider, provider_tx_id);

create table if not exists escrow_transactions (
    id uuid primary key default gen_random_uuid(),
    order_id uuid unique not null references orders(id) on delete cascade,
    amount_locked integer not null,
    status varchar(20) not null,                 -- locked, released, refunded
    locked_at timestamptz default now(),
    released_at timestamptz,
    refunded_at timestamptz,
    note text
);

-- =========================================================================
-- 7. PORTEFEUILLES
-- =========================================================================
create table if not exists wallets (
    id uuid primary key default gen_random_uuid(),
    user_id uuid unique not null references users(id) on delete cascade,
    balance integer default 0,
    pending_balance integer default 0,
    total_earned integer default 0,
    total_withdrawn integer default 0,
    updated_at timestamptz default now()
);

create table if not exists wallet_transactions (
    id uuid primary key default gen_random_uuid(),
    wallet_id uuid not null references wallets(id) on delete cascade,
    order_id uuid references orders(id),
    type varchar(30) not null,
    -- credit_sale, credit_delivery, debit_withdraw, commission, refund, adjustment
    amount integer not null,
    balance_after integer not null,
    description text,
    created_at timestamptz default now()
);

create index if not exists idx_wallet_tx_wallet on wallet_transactions(wallet_id, created_at desc);

create table if not exists withdrawals (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references users(id),
    amount integer not null,
    provider varchar(30) not null,
    phone_number varchar(20) not null,
    status varchar(20) not null default 'pending', -- pending, processing, paid, rejected
    processed_by uuid references users(id),
    processed_at timestamptz,
    rejection_reason text,
    created_at timestamptz default now()
);

create index if not exists idx_withdrawals_user on withdrawals(user_id, created_at desc);
create index if not exists idx_withdrawals_status on withdrawals(status);

-- =========================================================================
-- 8. PAIE HEBDOMADAIRE LIVREURS
-- =========================================================================
create table if not exists courier_payouts (
    id uuid primary key default gen_random_uuid(),
    courier_id uuid not null references couriers(id),
    week_start date not null,
    week_end date not null,
    deliveries_count integer not null,
    rate_per_delivery integer not null,
    total_amount integer not null,
    status varchar(20) not null default 'pending', -- pending, paid
    paid_at timestamptz,
    paid_by uuid references users(id),
    created_at timestamptz default now(),
    unique (courier_id, week_start)
);

-- =========================================================================
-- 9. LITIGES / SIGNALEMENTS
-- =========================================================================
create table if not exists disputes (
    id uuid primary key default gen_random_uuid(),
    order_id uuid not null references orders(id),
    opened_by uuid not null references users(id),
    reason varchar(60) not null,                 -- non_conforme, non_recu, autre
    description text not null,
    status varchar(30) not null default 'open',
    -- open, investigating, resolved_buyer, resolved_seller, closed
    resolution_note text,
    resolved_by uuid references users(id),
    created_at timestamptz default now(),
    resolved_at timestamptz
);

create index if not exists idx_disputes_status on disputes(status);
create index if not exists idx_disputes_order on disputes(order_id);

create table if not exists dispute_attachments (
    id uuid primary key default gen_random_uuid(),
    dispute_id uuid not null references disputes(id) on delete cascade,
    url text not null,
    type varchar(20) not null                    -- image, video
);

-- =========================================================================
-- 10. ÉVALUATIONS
-- =========================================================================
create table if not exists reviews (
    id uuid primary key default gen_random_uuid(),
    order_id uuid not null references orders(id),
    reviewer_id uuid not null references users(id),
    reviewee_id uuid not null references users(id),
    role varchar(20) not null,                   -- seller, buyer, courier
    rating integer not null check (rating between 1 and 5),
    comment text,
    created_at timestamptz default now(),
    unique (order_id, reviewer_id, role)
);

create index if not exists idx_reviews_reviewee on reviews(reviewee_id, created_at desc);

-- =========================================================================
-- 11. MESSAGERIE (lié à une commande)
-- =========================================================================
create table if not exists conversations (
    id uuid primary key default gen_random_uuid(),
    order_id uuid references orders(id) on delete cascade,
    user_a uuid not null references users(id),
    user_b uuid not null references users(id),
    last_message_at timestamptz,
    created_at timestamptz default now()
);

create table if not exists messages (
    id uuid primary key default gen_random_uuid(),
    conversation_id uuid not null references conversations(id) on delete cascade,
    sender_id uuid not null references users(id),
    body text not null,
    is_read boolean default false,
    created_at timestamptz default now()
);

create index if not exists idx_messages_conv on messages(conversation_id, created_at);

-- =========================================================================
-- 12. NOTIFICATIONS & DEVICES
-- =========================================================================
create table if not exists notifications (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references users(id) on delete cascade,
    type varchar(40) not null,
    title varchar(160) not null,
    body text,
    data jsonb,
    is_read boolean default false,
    created_at timestamptz default now()
);

create index if not exists idx_notifications_user on notifications(user_id, is_read, created_at desc);

create table if not exists device_tokens (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references users(id) on delete cascade,
    token text unique not null,
    platform varchar(10) not null,               -- android, ios
    created_at timestamptz default now(),
    last_used_at timestamptz default now()
);

-- =========================================================================
-- 13. ADMIN & PARAMÈTRES
-- =========================================================================
create table if not exists admin_logs (
    id uuid primary key default gen_random_uuid(),
    admin_id uuid not null references users(id),
    action varchar(60) not null,
    target_table varchar(60),
    target_id uuid,
    metadata jsonb,
    created_at timestamptz default now()
);

create table if not exists app_settings (
    key varchar(80) primary key,
    value jsonb not null,
    updated_at timestamptz default now(),
    updated_by uuid references users(id)
);

-- =========================================================================
-- 14. TRIGGERS — updated_at automatique
-- =========================================================================
create or replace function set_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

create trigger trg_users_updated before update on users
    for each row execute function set_updated_at();
create trigger trg_items_updated before update on items
    for each row execute function set_updated_at();
create trigger trg_orders_updated before update on orders
    for each row execute function set_updated_at();
create trigger trg_payments_updated before update on payments
    for each row execute function set_updated_at();
