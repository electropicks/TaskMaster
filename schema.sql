create table
  public.users (
    id bigint generated by default as identity,
    name text null,
    email text null,
    created_at timestamp with time zone not null default now(),
    constraint users_pkey primary key (id)
  ) tablespace pg_default;
create table
  public.groups (
    id bigint generated by default as identity,
    name text null,
    created_at timestamp with time zone not null default now(),
    owner bigint not null,
    constraint groups_pkey primary key (id),
    constraint groups_owner_fkey foreign key (owner) references users (id)
  ) tablespace pg_default;
create table
  public.group_members (
    group_id bigint generated by default as identity,
    user_id bigint not null,
    constraint group_members_pkey primary key (group_id, user_id),
    constraint group_members_group_id_fkey foreign key (group_id) references groups (id)
  ) tablespace pg_default;
create table
  public.shopping_trips (
    id bigint generated by default as identity,
    description text null,
    payer_id bigint null,
    created_at timestamp with time zone not null default now(),
    constraint expenses_pkey primary key (id),
    constraint shopping_trips_payer_id_fkey foreign key (payer_id) references users (id)
  ) tablespace pg_default;
create table
  public.trip_line_items (
    expense_id bigint generated by default as identity,
    item_name text not null,
    price real null,
    quantity integer null,
    id bigint not null,
    constraint trip_line_items_pkey primary key (id),
    constraint trip_line_items_expense_id_fkey foreign key (expense_id) references shopping_trips (id)
  ) tablespace pg_default;
create table
  public.trip_item_members (
    user_id bigint generated by default as identity,
    trip_line_item_id bigint not null,
    constraint trip_item_members_pkey primary key (user_id, trip_line_item_id),
    constraint trip_item_members_trip_line_item_id_fkey foreign key (trip_line_item_id) references trip_line_items (id),
    constraint trip_item_members_user_id_fkey foreign key (user_id) references users (id)
  ) tablespace pg_default;
create table
  public.transactions (
    id bigint generated by default as identity,
    description text null,
    expense_id bigint null,
    timestamp timestamp with time zone not null default now(),
    constraint transactions_pkey primary key (id)
  ) tablespace pg_default;
create table
  public.transaction_ledger (
    transaction_id bigint not null,
    created_at timestamp with time zone not null default now(),
    to_id bigint null,
    from_id bigint null,
    change real null,
    constraint transaction_ledger_from_id_fkey foreign key (from_id) references users (id),
    constraint transaction_ledger_to_id_fkey foreign key (to_id) references users (id),
    constraint transaction_ledger_transaction_id_fkey foreign key (transaction_id) references transactions (id)
  ) tablespace pg_default;