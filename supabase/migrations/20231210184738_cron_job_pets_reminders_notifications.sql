SELECT
  cron.schedule(
    'send-notifications-every-minute',
    '* * * * *', -- a cada minuto
    $$
    with reminder_info as (
      select
        p.id as pet_id,
        pr.id as reminder_id,
        pf.settings,
        p.name as pet_name,
        pr.text,
        pr.description,
        pr.triggered,
        pr.remember_when,
        pr.remember_again_in
      from public.pets as p
      join public.pets_reminders pr on p.id = pr.pet_id
      join public.profiles pf on p.user_id = pf.id
      where pr.triggered = false
        and pr.remember_when between now() - interval '30 seconds' and now() + interval '30 seconds'
    ),
    update_reminders as (
      update public.pets_reminders pr
      set
        remember_when = case when reminder_info.remember_again_in is not null then reminder_info.remember_when + reminder_info.remember_again_in::interval else now() end,
        triggered = case when reminder_info.remember_again_in is not null then false else true end,
        updated_at = NOW()
      from reminder_info
      where
        pr.id = reminder_info.reminder_id
      returning pr.id
    )
    select
      net.http_post(
        url := 'https://exp.host/--/api/v2/push/send',
        headers := '{"content-type": "application/json"}'::jsonb,
        body := (
          select json_agg(
            json_build_object(
              'to', reminder_info.settings->>'exponent_push_token',
              'title', 'Nova mensagem de ' || reminder_info.pet_name,
              'body', concat(reminder_info.text,CHR(13),CHR(10),reminder_info.description)
            )
          )
          from reminder_info
        )::jsonb
      ) as request_id;
    $$
  );