-- Criar a função de notificação
CREATE OR REPLACE FUNCTION send_push_notification_to_requested_friends()
RETURNS TRIGGER AS $$
DECLARE
    push_tokens JSONB;
BEGIN
    -- Seleciona os dados necessários
    SELECT
        json_agg(
            json_build_object(
                'to', p_requested.settings->>'exponent_push_token',
                'title', 'Você tem uma nova solicitação de amizade!',
                'body', p_requester.full_name || ' ' || 'lhe enviou uma nova solicitação de amizade!'
            )
        )
    INTO push_tokens
    FROM profiles p_requester
    JOIN profiles p_requested ON p_requested.id = NEW.requested
    WHERE p_requester.id = NEW.requester AND NEW.accepted = false AND p_requested.settings->>'exponent_push_token' IS NOT NULL;

    -- Envia a requisição HTTP
    PERFORM net.http_post(
        url := 'https://exp.host/--/api/v2/push/send',
        headers := '{"content-type": "application/json"}'::jsonb,
        body := push_tokens
    );

    -- Atualiza a coluna notification_sent
    UPDATE user_follows uf
    SET notification_sent = true
    FROM profiles uf_requested
    WHERE uf.accepted = false
        AND uf_requested.id = NEW.requested
        AND uf_requested.settings->>'exponent_push_token' IS NOT NULL;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar o trigger
CREATE OR REPLACE TRIGGER send_push_notification_trigger
AFTER INSERT ON user_follows
FOR EACH ROW
WHEN (NEW.accepted = false AND NEW.requested IS NOT NULL)
EXECUTE FUNCTION send_push_notification_to_requested_friends();


