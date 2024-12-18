-- Criar a função de notificação
CREATE OR REPLACE FUNCTION send_push_notification_to_requester()
RETURNS TRIGGER AS $$
DECLARE
    push_tokens JSONB;
BEGIN
    SELECT
        json_agg(
            json_build_object(
                'to', p_requester.settings->>'exponent_push_token',
                'title', 'Solicitação de amizade aceita!',
                'body', p_requested.full_name || ' ' || 'aceitou sua solicitação de amizade!'
            )
        )
    INTO push_tokens
    FROM profiles p_requested
    JOIN profiles p_requester ON p_requester.id = NEW.requester
    WHERE p_requested.id = NEW.requested AND NEW.accepted = true AND p_requester.settings->>'exponent_push_token' IS NOT NULL;

    -- Envia a requisição HTTP
    PERFORM net.http_post(
        url := 'https://exp.host/--/api/v2/push/send',
        headers := '{"content-type": "application/json"}'::jsonb,
        body := push_tokens
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar o novo trigger
CREATE OR REPLACE TRIGGER send_push_notification_to_requester_trigger
AFTER UPDATE ON user_follows
FOR EACH ROW
WHEN (NEW.accepted = true AND NEW.requester IS NOT NULL)
EXECUTE FUNCTION send_push_notification_to_requester();
