SELECT cron.schedule(
  'send-notifications-of-walk',
  '0 12 * * *', -- Every day at 09 AM (12 PM UTC)
  $$
  with reminder_walk_info as (
    with latest_walks as (
      SELECT
        pet_id,
        MAX(date_end) AS max_date_end
      FROM public.pets_walks
      GROUP BY pet_id
    )
    select
      pf.id uid,
      pf.full_name,
      pf.settings->>'exponent_push_token' push_token,
      pf.settings->>'language' user_language,
      case
        when pf.settings->>'language' = 'pt-BR' then 'Olá! Já faz um tempo desde sua última caminhada com seu(s) amigão(ões)! Que tal dar um passeio hoje?'
        when pf.settings->>'language' = 'en' then 'Hey there! It''s been a while since you took your pet(s) for a walk! How about going today?'
        when pf.settings->>'language' <> 'en' and pf.settings->>'language' <> 'pt-BR' then 'Hey there! It''s been a while since you took your pet(s) for a walk! How about going today?'
      end notification_message,
      case
        when pf.settings->>'language' = 'pt-BR' then 'Nova mensagem de Petvidade'
        when pf.settings->>'language' = 'en' then 'New Petvidade message'
        when pf.settings->>'language' <> 'en' and pf.settings->>'language' <> 'pt-BR' then 'New Petvidade message'
      end notification_title
    from public.pets p
    join public.pets_walks pw on p.id = pw.pet_id
    join public.profiles pf on p.user_id = pf.id
    join latest_walks lw on lw.pet_id = pw.pet_id and lw.max_date_end = pw.date_end
    where
      pf.settings->>'remember_walk' is not null and
      pf.settings->>'exponent_push_token' is not null and
      pf.settings->>'language' is not null and
      (pf.settings->>'remember_walk')::int >= 1 and
      pw.date_end + (pf.settings->>'remember_walk')::int * interval '1 day' <= NOW()
    group by uid
  ),
  result_cte as (
    select
      push_token,
      notification_message,
      notification_title
    from reminder_walk_info
  )
  select
    net.http_post(
      url := 'https://exp.host/--/api/v2/push/send',
      headers := '{"content-type": "application/json"}'::jsonb,
      body := (
        select json_agg(
          json_build_object(
            'to', result_cte.push_token,
            'title', result_cte.notification_title,
            'body', result_cte.notification_message
          )
        )
        from result_cte
      )::jsonb
    ) as request_id;
  $$
);
