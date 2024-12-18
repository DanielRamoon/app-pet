create table "public"."pets_reminders" (
  id uuid primary key not null default gen_random_uuid(),
  pet_id uuid not null,
  text text not null,
  description text,
  triggered boolean not null default false,
  remember_when timestamp without time zone not null,
  remember_again_in bigint,
  created_at timestamp with time zone not null default now(),
  created_by uuid not null default "auth".uid(),
  updated_at timestamp with time zone not null default now(),
  updated_by uuid not null
);

alter table "public"."pets_reminders"
    owner to postgres;

grant delete, insert, references, select, trigger, truncate, update on "public"."pets_reminders" to anon;

grant delete, insert, references, select, trigger, truncate, update on "public"."pets_reminders" to authenticated;

grant delete, insert, references, select, trigger, truncate, update on "public"."pets_reminders" to service_role;