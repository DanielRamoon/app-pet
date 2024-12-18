--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.3

-- Started on 2024-06-02 14:53:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 45 (class 2615 OID 28533)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 6039 (class 0 OID 0)
-- Dependencies: 45
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 3 (class 3079 OID 28543)
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- TOC entry 6041 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data';


--
-- TOC entry 50 (class 2615 OID 28538)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 17 (class 3079 OID 32043)
-- Name: pg_cron; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_cron WITH SCHEMA public;


--
-- TOC entry 6043 (class 0 OID 0)
-- Dependencies: 17
-- Name: EXTENSION pg_cron; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pg_cron IS 'Job scheduler for PostgreSQL';


--
-- TOC entry 47 (class 2615 OID 28540)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 28 (class 2615 OID 28534)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 27 (class 2615 OID 28535)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 2 (class 3079 OID 32084)
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA public;


--
-- TOC entry 6046 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- TOC entry 22 (class 2615 OID 16385)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 37 (class 2615 OID 16645)
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- TOC entry 12 (class 3079 OID 29236)
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- TOC entry 6048 (class 0 OID 0)
-- Dependencies: 12
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- TOC entry 26 (class 2615 OID 28537)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 48 (class 2615 OID 28539)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 40 (class 2615 OID 29533)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- TOC entry 41 (class 2615 OID 28536)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 13 (class 3079 OID 29534)
-- Name: autoinc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS autoinc WITH SCHEMA public;


--
-- TOC entry 6051 (class 0 OID 0)
-- Dependencies: 13
-- Name: EXTENSION autoinc; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION autoinc IS 'functions for autoincrementing fields';


--
-- TOC entry 14 (class 3079 OID 29536)
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA extensions;


--
-- TOC entry 6052 (class 0 OID 0)
-- Dependencies: 14
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- TOC entry 15 (class 3079 OID 29664)
-- Name: insert_username; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS insert_username WITH SCHEMA extensions;


--
-- TOC entry 6053 (class 0 OID 0)
-- Dependencies: 15
-- Name: EXTENSION insert_username; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION insert_username IS 'functions for tracking who changed a table';


--
-- TOC entry 16 (class 3079 OID 29666)
-- Name: moddatetime; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS moddatetime WITH SCHEMA public;


--
-- TOC entry 6054 (class 0 OID 0)
-- Dependencies: 16
-- Name: EXTENSION moddatetime; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION moddatetime IS 'functions for tracking last modification time';


--
-- TOC entry 11 (class 3079 OID 31539)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 6055 (class 0 OID 0)
-- Dependencies: 11
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 4 (class 3079 OID 29678)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 6056 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 5 (class 3079 OID 29709)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 6057 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 6 (class 3079 OID 29746)
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- TOC entry 6058 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- TOC entry 7 (class 3079 OID 29753)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA extensions;


--
-- TOC entry 6059 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 8 (class 3079 OID 30799)
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA extensions;


--
-- TOC entry 6060 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- TOC entry 9 (class 3079 OID 30824)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 6061 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 10 (class 3079 OID 30852)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 6062 (class 0 OID 0)
-- Dependencies: 10
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 2642 (class 1247 OID 30864)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 2645 (class 1247 OID 30872)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 2648 (class 1247 OID 30878)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 2651 (class 1247 OID 30884)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 2351 (class 1247 OID 34349)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 2336 (class 1247 OID 33672)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 2360 (class 1247 OID 33633)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 2369 (class 1247 OID 33647)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 2342 (class 1247 OID 33714)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 2339 (class 1247 OID 33685)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 1664 (class 1255 OID 30889)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 6123 (class 0 OID 0)
-- Dependencies: 1664
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 1665 (class 1255 OID 30890)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 1666 (class 1255 OID 30891)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 6126 (class 0 OID 0)
-- Dependencies: 1666
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 1667 (class 1255 OID 30892)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 6128 (class 0 OID 0)
-- Dependencies: 1667
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 1668 (class 1255 OID 30893)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;
    grant all on all functions in schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- TOC entry 6340 (class 0 OID 0)
-- Dependencies: 1668
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 1669 (class 1255 OID 30894)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 6342 (class 0 OID 0)
-- Dependencies: 1669
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 1670 (class 1255 OID 30895)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- TOC entry 6344 (class 0 OID 0)
-- Dependencies: 1670
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 1671 (class 1255 OID 30896)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 1672 (class 1255 OID 30897)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 1673 (class 1255 OID 30898)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 6487 (class 0 OID 0)
-- Dependencies: 1673
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 431 (class 1255 OID 16386)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- TOC entry 1674 (class 1255 OID 30899)
-- Name: check_pet_owner(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_pet_owner(pet_id uuid, auth_user_id uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1
    FROM public.pets
    WHERE id = pet_id
    AND user_id = auth_user_id
  );
END;
$$;


ALTER FUNCTION public.check_pet_owner(pet_id uuid, auth_user_id uuid) OWNER TO postgres;

--
-- TOC entry 1675 (class 1255 OID 30900)
-- Name: create_pet_health_record(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_pet_health_record() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO pets_health (pet_id, weight, length, height, created_at, updated_at, created_by, updated_by) VALUES (NEW.id, 0, 0, 0, now(), now(), NEW.created_by, NEW.updated_by);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_pet_health_record() OWNER TO postgres;

--
-- TOC entry 1676 (class 1255 OID 30901)
-- Name: get_pet_user_id(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_pet_user_id(uid uuid) RETURNS TABLE(row_id uuid)
    LANGUAGE sql
    AS $_$
    SELECT id FROM public.pets WHERE user_id = $1;
$_$;


ALTER FUNCTION public.get_pet_user_id(uid uuid) OWNER TO postgres;

--
-- TOC entry 1677 (class 1255 OID 30902)
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
begin
    insert into public.profiles (id, full_name, birth_date, gender, user_name, avatar_url)
    values (new.id,
            COALESCE(NULLIF(new.raw_user_meta_data ->> 'full_name', ''), new.email),
            new.created_at,
            3,
            COALESCE(NULLIF(new.raw_user_meta_data ->> 'user_name', ''), new.raw_user_meta_data ->> 'name'),
            new.raw_user_meta_data ->> 'avatar_url');
    return new;
end;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- TOC entry 1708 (class 1255 OID 33021)
-- Name: send_push_notification_to_requested_friends(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.send_push_notification_to_requested_friends() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.send_push_notification_to_requested_friends() OWNER TO postgres;

--
-- TOC entry 1709 (class 1255 OID 33057)
-- Name: send_push_notification_to_requester(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.send_push_notification_to_requester() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.send_push_notification_to_requester() OWNER TO postgres;

--
-- TOC entry 1715 (class 1255 OID 33707)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
    declare
        -- Regclass of the table e.g. public.notes
        entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

        -- I, U, D, T: insert, update ...
        action realtime.action = (
            case wal ->> 'action'
                when 'I' then 'INSERT'
                when 'U' then 'UPDATE'
                when 'D' then 'DELETE'
                else 'ERROR'
            end
        );

        -- Is row level security enabled for the table
        is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

        subscriptions realtime.subscription[] = array_agg(subs)
            from
                realtime.subscription subs
            where
                subs.entity = entity_;

        -- Subscription vars
        roles regrole[] = array_agg(distinct us.claims_role)
            from
                unnest(subscriptions) us;

        working_role regrole;
        claimed_role regrole;
        claims jsonb;

        subscription_id uuid;
        subscription_has_access bool;
        visible_to_subscription_ids uuid[] = '{}';

        -- structured info for wal's columns
        columns realtime.wal_column[];
        -- previous identity values for update/delete
        old_columns realtime.wal_column[];

        error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

        -- Primary jsonb output for record
        output jsonb;

    begin
        perform set_config('role', null, true);

        columns =
            array_agg(
                (
                    x->>'name',
                    x->>'type',
                    x->>'typeoid',
                    realtime.cast(
                        (x->'value') #>> '{}',
                        coalesce(
                            (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                            (x->>'type')::regtype
                        )
                    ),
                    (pks ->> 'name') is not null,
                    true
                )::realtime.wal_column
            )
            from
                jsonb_array_elements(wal -> 'columns') x
                left join jsonb_array_elements(wal -> 'pk') pks
                    on (x ->> 'name') = (pks ->> 'name');

        old_columns =
            array_agg(
                (
                    x->>'name',
                    x->>'type',
                    x->>'typeoid',
                    realtime.cast(
                        (x->'value') #>> '{}',
                        coalesce(
                            (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                            (x->>'type')::regtype
                        )
                    ),
                    (pks ->> 'name') is not null,
                    true
                )::realtime.wal_column
            )
            from
                jsonb_array_elements(wal -> 'identity') x
                left join jsonb_array_elements(wal -> 'pk') pks
                    on (x ->> 'name') = (pks ->> 'name');

        for working_role in select * from unnest(roles) loop

            -- Update `is_selectable` for columns and old_columns
            columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(columns) c;

            old_columns =
                    array_agg(
                        (
                            c.name,
                            c.type_name,
                            c.type_oid,
                            c.value,
                            c.is_pkey,
                            pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                        )::realtime.wal_column
                    )
                    from
                        unnest(old_columns) c;

            if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    -- subscriptions is already filtered by entity
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;

            -- The claims role does not have SELECT permission to the primary key of entity
            elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;

            else
                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Create the prepared statement
                if is_rls_enabled and action <> 'DELETE' then
                    if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                        deallocate walrus_rls_stmt;
                    end if;
                    execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
                end if;

                visible_to_subscription_ids = '{}';

                for subscription_id, claims in (
                        select
                            subs.subscription_id,
                            subs.claims
                        from
                            unnest(subscriptions) subs
                        where
                            subs.entity = entity_
                            and subs.claims_role = working_role
                            and (
                                realtime.is_visible_through_filters(columns, subs.filters)
                                or action = 'DELETE'
                            )
                ) loop

                    if not is_rls_enabled or action = 'DELETE' then
                        visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                    else
                        -- Check if RLS allows the role to see the record
                        perform
                            set_config('role', working_role::text, true),
                            set_config('request.jwt.claims', claims::text, true);

                        execute 'execute walrus_rls_stmt' into subscription_has_access;

                        if subscription_has_access then
                            visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                        end if;
                    end if;
                end loop;

                perform set_config('role', null, true);

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;

            end if;
        end loop;

        perform set_config('role', null, true);
    end;
    $$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 1717 (class 1255 OID 33719)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 1713 (class 1255 OID 33669)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 1719 (class 1255 OID 33736)
-- Name: channel_name(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.channel_name() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.channel_name', true), '')::text;
$$;


ALTER FUNCTION realtime.channel_name() OWNER TO supabase_realtime_admin;

--
-- TOC entry 1712 (class 1255 OID 33664)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 1716 (class 1255 OID 33715)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 1718 (class 1255 OID 33726)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 1711 (class 1255 OID 33663)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 1710 (class 1255 OID 33661)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 1714 (class 1255 OID 33696)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 1678 (class 1255 OID 30903)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 1679 (class 1255 OID 30904)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
    select string_to_array(name, '/') into _parts;
    select _parts[array_length(_parts,1)] into _filename;
    -- @todo return the last part instead of 2
    return split_part(_filename, '.', 2);
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1680 (class 1255 OID 30905)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
    select string_to_array(name, '/') into _parts;
    return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1681 (class 1255 OID 30906)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
    select string_to_array(name, '/') into _parts;
    return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1682 (class 1255 OID 30907)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 1721 (class 1255 OID 33863)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1720 (class 1255 OID 33826)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1683 (class 1255 OID 30908)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1684 (class 1255 OID 30909)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- TOC entry 1651 (class 1255 OID 30848)
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 351 (class 1259 OID 30910)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 7093 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 352 (class 1259 OID 30916)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 7095 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 353 (class 1259 OID 30921)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 7097 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 7098 (class 0 OID 0)
-- Dependencies: 353
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 354 (class 1259 OID 30927)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 7100 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 355 (class 1259 OID 30932)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 7102 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 356 (class 1259 OID 30937)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 7104 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 357 (class 1259 OID 30942)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 7106 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 415 (class 1259 OID 34361)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 358 (class 1259 OID 30947)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 7109 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 359 (class 1259 OID 30952)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 7111 (class 0 OID 0)
-- Dependencies: 359
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 360 (class 1259 OID 30953)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 7113 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 361 (class 1259 OID 30961)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 7115 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 362 (class 1259 OID 30967)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 7117 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 363 (class 1259 OID 30970)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 7119 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 7120 (class 0 OID 0)
-- Dependencies: 363
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 364 (class 1259 OID 30973)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 7122 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 365 (class 1259 OID 30979)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 7124 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 7125 (class 0 OID 0)
-- Dependencies: 365
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 366 (class 1259 OID 30985)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 7127 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 7128 (class 0 OID 0)
-- Dependencies: 366
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 399 (class 1259 OID 32921)
-- Name: account_deletions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_deletions (
    id bigint NOT NULL,
    who text,
    why text,
    "when" text
);


ALTER TABLE public.account_deletions OWNER TO postgres;

--
-- TOC entry 400 (class 1259 OID 32924)
-- Name: account_deletions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.account_deletions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_deletions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 367 (class 1259 OID 30999)
-- Name: health_medicines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_medicines (
    id bigint NOT NULL,
    health_id uuid NOT NULL,
    description text NOT NULL,
    dose bigint NOT NULL,
    amount bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL,
    type smallint DEFAULT '0'::smallint NOT NULL
);


ALTER TABLE public.health_medicines OWNER TO postgres;

--
-- TOC entry 7142 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN health_medicines.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.health_medicines.type IS 'GenericProduct = 0, Medicine = 1';


--
-- TOC entry 368 (class 1259 OID 31006)
-- Name: health_medicines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.health_medicines ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_medicines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 369 (class 1259 OID 31007)
-- Name: health_vaccines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_vaccines (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    health_id uuid NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL
);


ALTER TABLE public.health_vaccines OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 31015)
-- Name: locale_cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locale_cities (
    id bigint NOT NULL,
    state_id bigint NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.locale_cities OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 31021)
-- Name: locale_cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.locale_cities ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.locale_cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 372 (class 1259 OID 31022)
-- Name: locale_countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locale_countries (
    id bigint NOT NULL,
    name text NOT NULL,
    iso text NOT NULL,
    phone_code text NOT NULL,
    tz jsonb,
    emoji text,
    extras jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.locale_countries OWNER TO postgres;

--
-- TOC entry 373 (class 1259 OID 31028)
-- Name: locale_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.locale_countries ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.locale_countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 374 (class 1259 OID 31029)
-- Name: locale_states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locale_states (
    id bigint NOT NULL,
    country_id bigint NOT NULL,
    name text NOT NULL,
    state_code text NOT NULL,
    type text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.locale_states OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 31035)
-- Name: locale_states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.locale_states ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.locale_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 376 (class 1259 OID 31047)
-- Name: pets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pets (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    breed_id_old bigint,
    name text NOT NULL,
    birth_date date,
    gender smallint NOT NULL,
    has_stud_book boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    type smallint DEFAULT '6'::smallint NOT NULL,
    description text,
    breed text,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL
);


ALTER TABLE public.pets OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 31056)
-- Name: pets_health; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pets_health (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    pet_id uuid NOT NULL,
    weight double precision DEFAULT '0'::double precision NOT NULL,
    height double precision DEFAULT '0'::double precision NOT NULL,
    length double precision DEFAULT '0'::double precision NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL
);


ALTER TABLE public.pets_health OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 32126)
-- Name: pets_reminders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pets_reminders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    pet_id uuid NOT NULL,
    text text NOT NULL,
    description text,
    triggered boolean DEFAULT false NOT NULL,
    remember_when timestamp with time zone NOT NULL,
    remember_again_in text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid DEFAULT auth.uid() NOT NULL,
    updated_at timestamp without time zone,
    updated_by uuid NOT NULL,
    medicine_id bigint
);


ALTER TABLE public.pets_reminders OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 31065)
-- Name: pets_walks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pets_walks (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    pet_id uuid NOT NULL,
    date_start timestamp with time zone DEFAULT now() NOT NULL,
    date_end timestamp with time zone,
    distance jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    duration integer DEFAULT 0 NOT NULL,
    total_distance jsonb DEFAULT '{"humanDistance": 0, "animalDistance": 0}'::jsonb NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL
);


ALTER TABLE public.pets_walks OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 31922)
-- Name: places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.places (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    address_street text NOT NULL,
    address_number bigint NOT NULL,
    address_district text NOT NULL,
    address_location text NOT NULL,
    address_cep text NOT NULL,
    maps_url text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    coordinates double precision[] NOT NULL,
    address_phone text,
    approved boolean DEFAULT false NOT NULL,
    requested_by uuid NOT NULL,
    place_type text NOT NULL
);


ALTER TABLE public.places OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 31076)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    full_name text DEFAULT ''::text,
    birth_date date NOT NULL,
    gender smallint NOT NULL,
    address json,
    user_name text,
    settings json,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    pronouns smallint,
    verified boolean DEFAULT false NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    phones jsonb,
    completed boolean DEFAULT false NOT NULL,
    private boolean DEFAULT false NOT NULL
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 31088)
-- Name: user_follows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_follows (
    id bigint NOT NULL,
    requester uuid NOT NULL,
    requested uuid,
    accepted boolean DEFAULT false,
    created_at date NOT NULL,
    updated_at date NOT NULL,
    notification_sent boolean DEFAULT false
);


ALTER TABLE public.user_follows OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 31092)
-- Name: user_follows_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_follows ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 382 (class 1259 OID 31093)
-- Name: vaccines_doses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vaccines_doses (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    vaccine_id uuid NOT NULL,
    dose bigint,
    injection_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL
);


ALTER TABLE public.vaccines_doses OWNER TO postgres;

--
-- TOC entry 416 (class 1259 OID 34567)
-- Name: walks_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.walks_likes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    walk_id uuid,
    user_id uuid,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.walks_likes OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 33739)
-- Name: broadcasts; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.broadcasts (
    id bigint NOT NULL,
    channel_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.broadcasts OWNER TO supabase_realtime_admin;

--
-- TOC entry 409 (class 1259 OID 33738)
-- Name: broadcasts_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.broadcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE realtime.broadcasts_id_seq OWNER TO supabase_realtime_admin;

--
-- TOC entry 7163 (class 0 OID 0)
-- Dependencies: 409
-- Name: broadcasts_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.broadcasts_id_seq OWNED BY realtime.broadcasts.id;


--
-- TOC entry 408 (class 1259 OID 33728)
-- Name: channels; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.channels (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.channels OWNER TO supabase_realtime_admin;

--
-- TOC entry 407 (class 1259 OID 33727)
-- Name: channels_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE realtime.channels_id_seq OWNER TO supabase_realtime_admin;

--
-- TOC entry 7166 (class 0 OID 0)
-- Dependencies: 407
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.channels_id_seq OWNED BY realtime.channels.id;


--
-- TOC entry 412 (class 1259 OID 33753)
-- Name: presences; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.presences (
    id bigint NOT NULL,
    channel_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.presences OWNER TO supabase_realtime_admin;

--
-- TOC entry 411 (class 1259 OID 33752)
-- Name: presences_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.presences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE realtime.presences_id_seq OWNER TO supabase_realtime_admin;

--
-- TOC entry 7169 (class 0 OID 0)
-- Dependencies: 411
-- Name: presences_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.presences_id_seq OWNED BY realtime.presences.id;


--
-- TOC entry 401 (class 1259 OID 33627)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 404 (class 1259 OID 33649)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 403 (class 1259 OID 33648)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 383 (class 1259 OID 31099)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 7174 (class 0 OID 0)
-- Dependencies: 383
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 384 (class 1259 OID 31108)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 385 (class 1259 OID 31112)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 7177 (class 0 OID 0)
-- Dependencies: 385
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 413 (class 1259 OID 33828)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 414 (class 1259 OID 33842)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 386 (class 1259 OID 31122)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 30844)
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER VIEW vault.decrypted_secrets OWNER TO supabase_admin;

--
-- TOC entry 5330 (class 2604 OID 31127)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 5405 (class 2604 OID 33742)
-- Name: broadcasts id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.broadcasts ALTER COLUMN id SET DEFAULT nextval('realtime.broadcasts_id_seq'::regclass);


--
-- TOC entry 5404 (class 2604 OID 33731)
-- Name: channels id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.channels ALTER COLUMN id SET DEFAULT nextval('realtime.channels_id_seq'::regclass);


--
-- TOC entry 5406 (class 2604 OID 33756)
-- Name: presences id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.presences ALTER COLUMN id SET DEFAULT nextval('realtime.presences_id_seq'::regclass);


--
-- TOC entry 5288 (class 0 OID 28937)
-- Dependencies: 314
-- Data for Name: cache_inval_bgw_job; Type: TABLE DATA; Schema: _timescaledb_cache; Owner: supabase_admin
--

COPY _timescaledb_cache.cache_inval_bgw_job  FROM stdin;
\.


--
-- TOC entry 5287 (class 0 OID 28940)
-- Dependencies: 315
-- Data for Name: cache_inval_extension; Type: TABLE DATA; Schema: _timescaledb_cache; Owner: supabase_admin
--

COPY _timescaledb_cache.cache_inval_extension  FROM stdin;
\.


--
-- TOC entry 5286 (class 0 OID 28934)
-- Dependencies: 313
-- Data for Name: cache_inval_hypertable; Type: TABLE DATA; Schema: _timescaledb_cache; Owner: supabase_admin
--

COPY _timescaledb_cache.cache_inval_hypertable  FROM stdin;
\.


--
-- TOC entry 5257 (class 0 OID 28561)
-- Dependencies: 278
-- Data for Name: hypertable; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.hypertable (id, schema_name, table_name, associated_schema_name, associated_table_prefix, num_dimensions, chunk_sizing_func_schema, chunk_sizing_func_name, chunk_target_size, compression_state, compressed_hypertable_id, replication_factor) FROM stdin;
\.


--
-- TOC entry 5265 (class 0 OID 28655)
-- Dependencies: 288
-- Data for Name: chunk; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.chunk (id, hypertable_id, schema_name, table_name, compressed_chunk_id, dropped, status, osm_chunk) FROM stdin;
\.


--
-- TOC entry 5260 (class 0 OID 28609)
-- Dependencies: 283
-- Data for Name: dimension; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.dimension (id, hypertable_id, column_name, column_type, aligned, num_slices, partitioning_func_schema, partitioning_func, interval_length, compress_interval_length, integer_now_func_schema, integer_now_func) FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 28640)
-- Dependencies: 286
-- Data for Name: dimension_slice; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.dimension_slice (id, dimension_id, range_start, range_end) FROM stdin;
\.


--
-- TOC entry 5267 (class 0 OID 28679)
-- Dependencies: 289
-- Data for Name: chunk_constraint; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.chunk_constraint (chunk_id, dimension_slice_id, constraint_name, hypertable_constraint_name) FROM stdin;
\.


--
-- TOC entry 5270 (class 0 OID 28712)
-- Dependencies: 292
-- Data for Name: chunk_data_node; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.chunk_data_node (chunk_id, node_chunk_id, node_name) FROM stdin;
\.


--
-- TOC entry 5269 (class 0 OID 28696)
-- Dependencies: 291
-- Data for Name: chunk_index; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.chunk_index (chunk_id, index_name, hypertable_id, hypertable_index_name) FROM stdin;
\.


--
-- TOC entry 5280 (class 0 OID 28865)
-- Dependencies: 305
-- Data for Name: compression_chunk_size; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.compression_chunk_size (chunk_id, compressed_chunk_id, uncompressed_heap_size, uncompressed_toast_size, uncompressed_index_size, compressed_heap_size, compressed_toast_size, compressed_index_size, numrows_pre_compression, numrows_post_compression) FROM stdin;
\.


--
-- TOC entry 5274 (class 0 OID 28777)
-- Dependencies: 298
-- Data for Name: continuous_agg; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_agg (mat_hypertable_id, raw_hypertable_id, parent_mat_hypertable_id, user_view_schema, user_view_name, partial_view_schema, partial_view_name, bucket_width, direct_view_schema, direct_view_name, materialized_only, finalized) FROM stdin;
\.


--
-- TOC entry 5282 (class 0 OID 28901)
-- Dependencies: 309
-- Data for Name: continuous_agg_migrate_plan; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_agg_migrate_plan (mat_hypertable_id, start_ts, end_ts) FROM stdin;
\.


--
-- TOC entry 5283 (class 0 OID 28913)
-- Dependencies: 311
-- Data for Name: continuous_agg_migrate_plan_step; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_agg_migrate_plan_step (mat_hypertable_id, step_id, status, start_ts, end_ts, type, config) FROM stdin;
\.


--
-- TOC entry 5275 (class 0 OID 28804)
-- Dependencies: 299
-- Data for Name: continuous_aggs_bucket_function; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_aggs_bucket_function (mat_hypertable_id, experimental, name, bucket_width, origin, timezone) FROM stdin;
\.


--
-- TOC entry 5277 (class 0 OID 28826)
-- Dependencies: 301
-- Data for Name: continuous_aggs_hypertable_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_aggs_hypertable_invalidation_log (hypertable_id, lowest_modified_value, greatest_modified_value) FROM stdin;
\.


--
-- TOC entry 5276 (class 0 OID 28816)
-- Dependencies: 300
-- Data for Name: continuous_aggs_invalidation_threshold; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_aggs_invalidation_threshold (hypertable_id, watermark) FROM stdin;
\.


--
-- TOC entry 5278 (class 0 OID 28830)
-- Dependencies: 302
-- Data for Name: continuous_aggs_materialization_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.continuous_aggs_materialization_invalidation_log (materialization_id, lowest_modified_value, greatest_modified_value) FROM stdin;
\.


--
-- TOC entry 5262 (class 0 OID 28627)
-- Dependencies: 284
-- Data for Name: dimension_partition; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.dimension_partition (dimension_id, range_start, data_nodes) FROM stdin;
\.


--
-- TOC entry 5279 (class 0 OID 28846)
-- Dependencies: 304
-- Data for Name: hypertable_compression; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.hypertable_compression (hypertable_id, attname, compression_algorithm_id, segmentby_column_index, orderby_column_index, orderby_asc, orderby_nullsfirst) FROM stdin;
\.


--
-- TOC entry 5258 (class 0 OID 28582)
-- Dependencies: 279
-- Data for Name: hypertable_data_node; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.hypertable_data_node (hypertable_id, node_hypertable_id, node_name, block_chunks) FROM stdin;
\.


--
-- TOC entry 5273 (class 0 OID 28770)
-- Dependencies: 297
-- Data for Name: metadata; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.metadata (key, value, include_in_telemetry) FROM stdin;
exported_uuid	d77b28e1-9543-4655-b2ac-1497edc586ae	t
\.


--
-- TOC entry 5281 (class 0 OID 28880)
-- Dependencies: 306
-- Data for Name: remote_txn; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.remote_txn (data_node_name, remote_transaction_id) FROM stdin;
\.


--
-- TOC entry 5259 (class 0 OID 28595)
-- Dependencies: 281
-- Data for Name: tablespace; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: supabase_admin
--

COPY _timescaledb_catalog.tablespace (id, hypertable_id, tablespace_name) FROM stdin;
\.


--
-- TOC entry 5272 (class 0 OID 28726)
-- Dependencies: 294
-- Data for Name: bgw_job; Type: TABLE DATA; Schema: _timescaledb_config; Owner: supabase_admin
--

COPY _timescaledb_config.bgw_job (id, application_name, schedule_interval, max_runtime, max_retries, retry_period, proc_schema, proc_name, owner, scheduled, fixed_schedule, initial_start, hypertable_id, config, check_schema, check_name, timezone) FROM stdin;
\.


--
-- TOC entry 5984 (class 0 OID 30927)
-- Dependencies: 354
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5986 (class 0 OID 30937)
-- Dependencies: 356
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address) FROM stdin;
\.


--
-- TOC entry 5987 (class 0 OID 30942)
-- Dependencies: 357
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret) FROM stdin;
\.


--
-- TOC entry 6032 (class 0 OID 34361)
-- Dependencies: 415
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5990 (class 0 OID 30953)
-- Dependencies: 360
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 5991 (class 0 OID 30961)
-- Dependencies: 361
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 5994 (class 0 OID 30973)
-- Dependencies: 364
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5995 (class 0 OID 30979)
-- Dependencies: 365
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5293 (class 0 OID 32046)
-- Dependencies: 390
-- Data for Name: job; Type: TABLE DATA; Schema: cron; Owner: supabase_admin
--

COPY cron.job (jobid, schedule, command, nodename, nodeport, database, username, active, jobname) FROM stdin;
26	50 7 * * *	\r\n        truncate cron.job_run_details, net."_http_response";\r\n    	localhost	5432	postgres	postgres	t	cleanup-job
8	0 12 * * *	\r\n  with reminder_walk_info as (\r\n    with latest_walks as (\r\n      SELECT\r\n        pet_id,\r\n        MAX(date_end) AS max_date_end\r\n      FROM public.pets_walks\r\n      GROUP BY pet_id\r\n    )\r\n    select\r\n      pf.id uid,\r\n      pf.full_name,\r\n      pf.settings->>'exponent_push_token' push_token,\r\n      pf.settings->>'language' user_language,\r\n      case\r\n        when pf.settings->>'language' = 'pt-BR' then 'Olá! Já faz um tempo desde sua última caminhada com seu(s) amigão(ões)! Que tal dar um passeio hoje?'\r\n        when pf.settings->>'language' = 'en' then 'Hey there! It''s been a while since you took your pet(s) for a walk! How about going today?'\r\n        when pf.settings->>'language' <> 'en' and pf.settings->>'language' <> 'pt-BR' then 'Hey there! It''s been a while since you took your pet(s) for a walk! How about going today?'\r\n      end notification_message,\r\n      case\r\n        when pf.settings->>'language' = 'pt-BR' then 'Nova mensagem de Petvidade'\r\n        when pf.settings->>'language' = 'en' then 'New Petvidade message'\r\n        when pf.settings->>'language' <> 'en' and pf.settings->>'language' <> 'pt-BR' then 'New Petvidade message'\r\n      end notification_title\r\n    from public.pets p\r\n    join public.pets_walks pw on p.id = pw.pet_id\r\n    join public.profiles pf on p.user_id = pf.id\r\n    join latest_walks lw on lw.pet_id = pw.pet_id and lw.max_date_end = pw.date_end\r\n    where\r\n      pf.settings->>'remember_walk' is not null and\r\n      pf.settings->>'exponent_push_token' is not null and\r\n      pf.settings->>'language' is not null and\r\n      (pf.settings->>'remember_walk')::int >= 1 and\r\n      pw.date_end + (pf.settings->>'remember_walk')::int * interval '1 day' <= NOW()\r\n    group by uid\r\n  ),\r\n  result_cte as (\r\n    select\r\n      push_token,\r\n      notification_message,\r\n      notification_title\r\n    from reminder_walk_info\r\n  )\r\n  select\r\n    net.http_post(\r\n      url := 'https://exp.host/--/api/v2/push/send',\r\n      headers := '{"content-type": "application/json"}'::jsonb,\r\n      body := (\r\n        select json_agg(\r\n          json_build_object(\r\n            'to', result_cte.push_token,\r\n            'title', result_cte.notification_title,\r\n            'body', result_cte.notification_message\r\n          )\r\n        )\r\n        from result_cte\r\n      )::jsonb\r\n    ) as request_id;\r\n  	localhost	5432	postgres	postgres	t	send-notifications-of-walk
23	0 7 * * *	VACUUM	localhost	5432	postgres	postgres	t	nightly-vacuum
7	* * * * *	\r\n    with reminder_info as (\r\n      select\r\n        p.id as pet_id,\r\n        pr.id as reminder_id,\r\n        pf.settings,\r\n        p.name as pet_name,\r\n        pr.text,\r\n        pr.description,\r\n        pr.triggered,\r\n        pr.remember_when,\r\n        pr.remember_again_in\r\n      from public.pets as p\r\n      join public.pets_reminders pr on p.id = pr.pet_id\r\n      join public.profiles pf on p.user_id = pf.id\r\n      where pr.triggered = false\r\n        and pr.remember_when between now() - interval '30 seconds' and now() + interval '30 seconds'\r\n    ),\r\n    update_reminders as (\r\n      update public.pets_reminders pr\r\n      set\r\n        remember_when = case when reminder_info.remember_again_in is not null then reminder_info.remember_when + reminder_info.remember_again_in::interval else now() end,\r\n        triggered = case when reminder_info.remember_again_in is not null then false else true end,\r\n        updated_at = NOW()\r\n      from reminder_info\r\n      where\r\n        pr.id = reminder_info.reminder_id\r\n      returning pr.id\r\n    )\r\n    select\r\n      net.http_post(\r\n        url := 'https://exp.host/--/api/v2/push/send',\r\n        headers := '{"content-type": "application/json"}'::jsonb,\r\n        body := (\r\n          select json_agg(\r\n            json_build_object(\r\n              'to', reminder_info.settings->>'exponent_push_token',\r\n              'title', 'Nova mensagem de ' || reminder_info.pet_name,\r\n              'body', concat(reminder_info.text,CHR(13),CHR(10),reminder_info.description)\r\n            )\r\n          )\r\n          from reminder_info\r\n        )::jsonb\r\n      ) as request_id;\r\n    	localhost	5432	postgres	postgres	t	send-notifications-every-minute
\.


--
-- TOC entry 6027 (class 0 OID 33739)
-- Dependencies: 410
-- Data for Name: broadcasts; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.broadcasts (id, channel_id, inserted_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6025 (class 0 OID 33728)
-- Dependencies: 408
-- Data for Name: channels; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.channels (id, name, inserted_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6029 (class 0 OID 33753)
-- Dependencies: 412
-- Data for Name: presences; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.presences (id, channel_id, inserted_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6023 (class 0 OID 33649)
-- Dependencies: 404
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- TOC entry 6013 (class 0 OID 31099)
-- Dependencies: 383
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
avatars	avatars	\N	2023-08-20 18:49:34.875268+00	2023-08-20 18:49:34.875268+00	t	f	\N	\N	\N
pets	pets	\N	2023-08-20 18:49:46.86317+00	2023-08-20 18:49:46.86317+00	t	f	\N	\N	\N
app-image	app-image	\N	2024-02-18 18:15:40.289267+00	2024-02-18 18:15:40.289267+00	t	f	\N	\N	\N
\.


--
-- TOC entry 6014 (class 0 OID 31108)
-- Dependencies: 384
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2024-04-15 22:29:28.236955
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2024-04-15 22:29:28.267125
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2024-04-15 22:29:28.365266
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2024-04-15 22:29:28.43981
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2024-01-26 14:55:19.723032
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2024-01-26 14:55:19.723032
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2024-01-26 14:55:19.723032
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2024-01-26 14:55:19.723032
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2024-01-26 14:55:19.723032
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2024-01-26 14:55:19.723032
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2024-01-26 14:55:19.723032
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2024-01-26 14:55:19.723032
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2024-01-26 14:55:19.723032
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2024-01-26 14:55:19.723032
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2024-01-26 14:55:19.723032
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2024-01-26 14:55:19.723032
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2024-01-26 14:55:19.723032
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2024-01-26 14:55:19.723032
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2024-01-26 14:55:19.723032
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2024-01-26 14:55:19.723032
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2024-01-26 14:55:19.723032
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2024-01-26 14:55:19.723032
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2024-01-26 14:55:19.723032
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2024-01-26 14:55:19.841848
\.


--
-- TOC entry 6015 (class 0 OID 31112)
-- Dependencies: 385
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id) FROM stdin;
a9ec6b52-8f2d-4211-a3c6-332ea5663863	pets	default-pet-image.png	\N	2023-08-20 18:50:15.175462+00	2023-08-20 18:50:15.175462+00	2023-08-20 18:50:15.175462+00	{"eTag": "\\"31a03d2872171d2d816e81d8d3de89e5\\"", "size": 11221, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2023-08-20T18:50:16.000Z", "contentLength": 11221, "httpStatusCode": 200}	2c2db317-973e-4e7f-998a-679fbf7cacfd	\N
\.


--
-- TOC entry 6030 (class 0 OID 33828)
-- Dependencies: 413
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at) FROM stdin;
\.


--
-- TOC entry 6031 (class 0 OID 33842)
-- Dependencies: 414
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 6016 (class 0 OID 31122)
-- Dependencies: 386
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version) FROM stdin;
\.


--
-- TOC entry 5290 (class 0 OID 30825)
-- Dependencies: 349
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 7181 (class 0 OID 0)
-- Dependencies: 290
-- Name: chunk_constraint_name; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_constraint_name', 1, false);


--
-- TOC entry 7182 (class 0 OID 0)
-- Dependencies: 287
-- Name: chunk_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_id_seq', 1, false);


--
-- TOC entry 7183 (class 0 OID 0)
-- Dependencies: 310
-- Name: continuous_agg_migrate_plan_step_step_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_catalog.continuous_agg_migrate_plan_step_step_id_seq', 1, false);


--
-- TOC entry 7184 (class 0 OID 0)
-- Dependencies: 282
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_id_seq', 1, false);


--
-- TOC entry 7185 (class 0 OID 0)
-- Dependencies: 285
-- Name: dimension_slice_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_slice_id_seq', 1, false);


--
-- TOC entry 7186 (class 0 OID 0)
-- Dependencies: 277
-- Name: hypertable_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_catalog.hypertable_id_seq', 1, false);


--
-- TOC entry 7187 (class 0 OID 0)
-- Dependencies: 293
-- Name: bgw_job_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_config; Owner: supabase_admin
--

SELECT pg_catalog.setval('_timescaledb_config.bgw_job_id_seq', 1000, false);


--
-- TOC entry 7188 (class 0 OID 0)
-- Dependencies: 359
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 866, true);


--
-- TOC entry 7189 (class 0 OID 0)
-- Dependencies: 389
-- Name: jobid_seq; Type: SEQUENCE SET; Schema: cron; Owner: supabase_admin
--

SELECT pg_catalog.setval('cron.jobid_seq', 36, true);


--
-- TOC entry 7190 (class 0 OID 0)
-- Dependencies: 391
-- Name: runid_seq; Type: SEQUENCE SET; Schema: cron; Owner: supabase_admin
--

SELECT pg_catalog.setval('cron.runid_seq', 252303, true);


--
-- TOC entry 7191 (class 0 OID 0)
-- Dependencies: 335
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- TOC entry 7192 (class 0 OID 0)
-- Dependencies: 400
-- Name: account_deletions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_deletions_id_seq', 20, true);


--
-- TOC entry 7193 (class 0 OID 0)
-- Dependencies: 368
-- Name: health_medicines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_medicines_id_seq', 113, true);


--
-- TOC entry 7194 (class 0 OID 0)
-- Dependencies: 371
-- Name: locale_cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locale_cities_id_seq', 1, false);


--
-- TOC entry 7195 (class 0 OID 0)
-- Dependencies: 373
-- Name: locale_countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locale_countries_id_seq', 1, false);


--
-- TOC entry 7196 (class 0 OID 0)
-- Dependencies: 375
-- Name: locale_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locale_states_id_seq', 1, false);


--
-- TOC entry 7197 (class 0 OID 0)
-- Dependencies: 381
-- Name: user_follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_follows_id_seq', 60, true);


--
-- TOC entry 7198 (class 0 OID 0)
-- Dependencies: 409
-- Name: broadcasts_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.broadcasts_id_seq', 1, false);


--
-- TOC entry 7199 (class 0 OID 0)
-- Dependencies: 407
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.channels_id_seq', 1, false);


--
-- TOC entry 7200 (class 0 OID 0)
-- Dependencies: 411
-- Name: presences_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.presences_id_seq', 1, false);


--
-- TOC entry 7201 (class 0 OID 0)
-- Dependencies: 403
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 5545 (class 2606 OID 31130)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 5529 (class 2606 OID 31132)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 5533 (class 2606 OID 31134)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 5538 (class 2606 OID 31989)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 5540 (class 2606 OID 31999)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 5543 (class 2606 OID 31138)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 5547 (class 2606 OID 31140)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 5550 (class 2606 OID 31142)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 5553 (class 2606 OID 31144)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 5674 (class 2606 OID 34370)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5560 (class 2606 OID 31146)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5563 (class 2606 OID 31148)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 5566 (class 2606 OID 31150)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 5568 (class 2606 OID 31152)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 5573 (class 2606 OID 31154)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 5576 (class 2606 OID 31156)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 5579 (class 2606 OID 31158)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5584 (class 2606 OID 31160)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 5587 (class 2606 OID 31162)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 5599 (class 2606 OID 31164)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 5601 (class 2606 OID 31166)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5652 (class 2606 OID 32931)
-- Name: account_deletions account_deletions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_deletions
    ADD CONSTRAINT account_deletions_pkey PRIMARY KEY (id);


--
-- TOC entry 5603 (class 2606 OID 31168)
-- Name: health_medicines health_medicines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_medicines
    ADD CONSTRAINT health_medicines_pkey PRIMARY KEY (id);


--
-- TOC entry 5605 (class 2606 OID 31170)
-- Name: health_vaccines health_vaccines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_vaccines
    ADD CONSTRAINT health_vaccines_pkey PRIMARY KEY (id);


--
-- TOC entry 5607 (class 2606 OID 31172)
-- Name: locale_cities locale_cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locale_cities
    ADD CONSTRAINT locale_cities_pkey PRIMARY KEY (id);


--
-- TOC entry 5609 (class 2606 OID 31174)
-- Name: locale_countries locale_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locale_countries
    ADD CONSTRAINT locale_countries_pkey PRIMARY KEY (id);


--
-- TOC entry 5611 (class 2606 OID 31176)
-- Name: locale_states locale_states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locale_states
    ADD CONSTRAINT locale_states_pkey PRIMARY KEY (id);


--
-- TOC entry 5615 (class 2606 OID 31180)
-- Name: pets_health pets_health_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_health
    ADD CONSTRAINT pets_health_pk PRIMARY KEY (id);


--
-- TOC entry 5613 (class 2606 OID 31182)
-- Name: pets pets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_pkey PRIMARY KEY (id);


--
-- TOC entry 5650 (class 2606 OID 32139)
-- Name: pets_reminders pets_reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_reminders
    ADD CONSTRAINT pets_reminders_pkey PRIMARY KEY (id);


--
-- TOC entry 5617 (class 2606 OID 31184)
-- Name: pets_walks pets_walks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_walks
    ADD CONSTRAINT pets_walks_pkey PRIMARY KEY (id);


--
-- TOC entry 5640 (class 2606 OID 31932)
-- Name: places places_maps_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_maps_url_key UNIQUE (maps_url);


--
-- TOC entry 5642 (class 2606 OID 31935)
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (id);


--
-- TOC entry 5619 (class 2606 OID 31186)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5622 (class 2606 OID 31188)
-- Name: user_follows user_follows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_follows
    ADD CONSTRAINT user_follows_pkey PRIMARY KEY (id);


--
-- TOC entry 5624 (class 2606 OID 31192)
-- Name: vaccines_doses vaccines_doses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccines_doses
    ADD CONSTRAINT vaccines_doses_pkey PRIMARY KEY (id);


--
-- TOC entry 5679 (class 2606 OID 34584)
-- Name: walks_likes walks_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.walks_likes
    ADD CONSTRAINT walks_likes_pkey PRIMARY KEY (id);


--
-- TOC entry 5664 (class 2606 OID 33745)
-- Name: broadcasts broadcasts_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.broadcasts
    ADD CONSTRAINT broadcasts_pkey PRIMARY KEY (id);


--
-- TOC entry 5661 (class 2606 OID 33733)
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- TOC entry 5657 (class 2606 OID 33657)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 5667 (class 2606 OID 33759)
-- Name: presences presences_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.presences
    ADD CONSTRAINT presences_pkey PRIMARY KEY (id);


--
-- TOC entry 5654 (class 2606 OID 33631)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 5627 (class 2606 OID 31194)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 5629 (class 2606 OID 31196)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 5631 (class 2606 OID 31198)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 5636 (class 2606 OID 31200)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 5672 (class 2606 OID 33851)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 5670 (class 2606 OID 33836)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 5638 (class 2606 OID 31202)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 5530 (class 1259 OID 31203)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 5589 (class 1259 OID 31204)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5590 (class 1259 OID 31205)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5591 (class 1259 OID 31206)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5551 (class 1259 OID 31207)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 5531 (class 1259 OID 31208)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 5536 (class 1259 OID 31209)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 7202 (class 0 OID 0)
-- Dependencies: 5536
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 5541 (class 1259 OID 31210)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 5534 (class 1259 OID 31211)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 5535 (class 1259 OID 31212)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 5548 (class 1259 OID 31213)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 5554 (class 1259 OID 31214)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 5555 (class 1259 OID 31215)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 5675 (class 1259 OID 34377)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 5676 (class 1259 OID 34376)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 5677 (class 1259 OID 34378)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 5592 (class 1259 OID 31216)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5593 (class 1259 OID 31217)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5556 (class 1259 OID 31218)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 5557 (class 1259 OID 31219)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 5558 (class 1259 OID 31220)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 5561 (class 1259 OID 31221)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 5564 (class 1259 OID 31222)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 5569 (class 1259 OID 31223)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 5570 (class 1259 OID 31224)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 5571 (class 1259 OID 31225)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 5574 (class 1259 OID 31226)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 5577 (class 1259 OID 31227)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 5580 (class 1259 OID 31228)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 5582 (class 1259 OID 31229)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 5585 (class 1259 OID 31230)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 5588 (class 1259 OID 31231)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 5581 (class 1259 OID 31232)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 5594 (class 1259 OID 31233)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 7203 (class 0 OID 0)
-- Dependencies: 5594
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 5595 (class 1259 OID 31234)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 5596 (class 1259 OID 31235)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 5597 (class 1259 OID 33299)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 5620 (class 1259 OID 31236)
-- Name: profiles_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX profiles_username_key ON public.profiles USING btree (user_name);


--
-- TOC entry 5680 (class 1259 OID 34581)
-- Name: walks_likes_walk_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX walks_likes_walk_id_index ON public.walks_likes USING btree (walk_id);


--
-- TOC entry 5662 (class 1259 OID 33751)
-- Name: broadcasts_channel_id_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX broadcasts_channel_id_index ON realtime.broadcasts USING btree (channel_id);


--
-- TOC entry 5659 (class 1259 OID 33734)
-- Name: channels_name_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX channels_name_index ON realtime.channels USING btree (name);


--
-- TOC entry 5655 (class 1259 OID 33660)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING hash (entity);


--
-- TOC entry 5665 (class 1259 OID 33765)
-- Name: presences_channel_id_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX presences_channel_id_index ON realtime.presences USING btree (channel_id);


--
-- TOC entry 5658 (class 1259 OID 33706)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 5625 (class 1259 OID 31237)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 5632 (class 1259 OID 31238)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 5668 (class 1259 OID 33862)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 5633 (class 1259 OID 33827)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 5634 (class 1259 OID 31239)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 5728 (class 2620 OID 31240)
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- TOC entry 5731 (class 2620 OID 31241)
-- Name: pets handle_new_pet; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_new_pet AFTER INSERT ON public.pets FOR EACH ROW EXECUTE FUNCTION public.create_pet_health_record();


--
-- TOC entry 5729 (class 2620 OID 31242)
-- Name: health_medicines handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.health_medicines FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5730 (class 2620 OID 31243)
-- Name: health_vaccines handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.health_vaccines FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5732 (class 2620 OID 31245)
-- Name: pets handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.pets FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5733 (class 2620 OID 31246)
-- Name: pets_health handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.pets_health FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5734 (class 2620 OID 31247)
-- Name: pets_walks handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.pets_walks FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5735 (class 2620 OID 31248)
-- Name: profiles handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5738 (class 2620 OID 31249)
-- Name: vaccines_doses handle_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.vaccines_doses FOR EACH ROW EXECUTE FUNCTION public.moddatetime('updated_at');


--
-- TOC entry 5736 (class 2620 OID 33059)
-- Name: user_follows send_push_notification_to_requester_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER send_push_notification_to_requester_trigger AFTER UPDATE ON public.user_follows FOR EACH ROW WHEN (((new.accepted = true) AND (new.requester IS NOT NULL))) EXECUTE FUNCTION public.send_push_notification_to_requester();


--
-- TOC entry 5737 (class 2620 OID 33023)
-- Name: user_follows send_push_notification_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER send_push_notification_trigger AFTER INSERT ON public.user_follows FOR EACH ROW WHEN (((new.accepted = false) AND (new.requested IS NOT NULL))) EXECUTE FUNCTION public.send_push_notification_to_requested_friends();


--
-- TOC entry 5740 (class 2620 OID 33662)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 5739 (class 2620 OID 31250)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 5681 (class 2606 OID 31251)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 5682 (class 2606 OID 31256)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 5683 (class 2606 OID 31261)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 5684 (class 2606 OID 31266)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 5725 (class 2606 OID 34371)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 5685 (class 2606 OID 31271)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 5686 (class 2606 OID 31276)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 5687 (class 2606 OID 31281)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 5688 (class 2606 OID 31286)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 5689 (class 2606 OID 31291)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 5690 (class 2606 OID 31296)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 5691 (class 2606 OID 31301)
-- Name: health_medicines health_medicines_pets_health_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_medicines
    ADD CONSTRAINT health_medicines_pets_health_id_fk FOREIGN KEY (health_id) REFERENCES public.pets_health(id) ON DELETE CASCADE;


--
-- TOC entry 5692 (class 2606 OID 32800)
-- Name: health_medicines health_medicines_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_medicines
    ADD CONSTRAINT health_medicines_users_id_fk FOREIGN KEY (created_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5693 (class 2606 OID 32805)
-- Name: health_medicines health_medicines_users_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_medicines
    ADD CONSTRAINT health_medicines_users_id_fk_2 FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5694 (class 2606 OID 32810)
-- Name: health_vaccines health_vaccines_pets_health_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_vaccines
    ADD CONSTRAINT health_vaccines_pets_health_id_fk FOREIGN KEY (health_id) REFERENCES public.pets_health(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5695 (class 2606 OID 32815)
-- Name: health_vaccines health_vaccines_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_vaccines
    ADD CONSTRAINT health_vaccines_users_id_fk FOREIGN KEY (created_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5696 (class 2606 OID 32820)
-- Name: health_vaccines health_vaccines_users_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_vaccines
    ADD CONSTRAINT health_vaccines_users_id_fk_2 FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5697 (class 2606 OID 31331)
-- Name: locale_cities locale_cities_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locale_cities
    ADD CONSTRAINT locale_cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.locale_states(id);


--
-- TOC entry 5698 (class 2606 OID 31336)
-- Name: locale_states locale_states_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locale_states
    ADD CONSTRAINT locale_states_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.locale_countries(id);


--
-- TOC entry 5702 (class 2606 OID 32825)
-- Name: pets_health pets_health_pets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_health
    ADD CONSTRAINT pets_health_pets_id_fk FOREIGN KEY (pet_id) REFERENCES public.pets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5703 (class 2606 OID 32830)
-- Name: pets_health pets_health_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_health
    ADD CONSTRAINT pets_health_users_id_fk FOREIGN KEY (created_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5704 (class 2606 OID 32835)
-- Name: pets_health pets_health_users_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_health
    ADD CONSTRAINT pets_health_users_id_fk_2 FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5716 (class 2606 OID 34667)
-- Name: pets_reminders pets_reminders_health_medicines_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_reminders
    ADD CONSTRAINT pets_reminders_health_medicines_id_fk FOREIGN KEY (medicine_id) REFERENCES public.health_medicines(id) ON DELETE CASCADE;


--
-- TOC entry 5717 (class 2606 OID 32840)
-- Name: pets_reminders pets_reminders_pets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_reminders
    ADD CONSTRAINT pets_reminders_pets_id_fk FOREIGN KEY (pet_id) REFERENCES public.pets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5718 (class 2606 OID 32845)
-- Name: pets_reminders pets_reminders_profiles_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_reminders
    ADD CONSTRAINT pets_reminders_profiles_id_fk FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5719 (class 2606 OID 32850)
-- Name: pets_reminders pets_reminders_profiles_id_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_reminders
    ADD CONSTRAINT pets_reminders_profiles_id_fk2 FOREIGN KEY (updated_by) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5699 (class 2606 OID 32785)
-- Name: pets pets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5700 (class 2606 OID 32790)
-- Name: pets pets_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_users_id_fk FOREIGN KEY (created_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5701 (class 2606 OID 32795)
-- Name: pets pets_users_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_users_id_fk_2 FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5705 (class 2606 OID 32855)
-- Name: pets_walks pets_walks_pet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_walks
    ADD CONSTRAINT pets_walks_pet_id_fkey FOREIGN KEY (pet_id) REFERENCES public.pets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5706 (class 2606 OID 32860)
-- Name: pets_walks pets_walks_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_walks
    ADD CONSTRAINT pets_walks_users_id_fk FOREIGN KEY (created_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5707 (class 2606 OID 32865)
-- Name: pets_walks pets_walks_users_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets_walks
    ADD CONSTRAINT pets_walks_users_id_fk_2 FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5715 (class 2606 OID 31966)
-- Name: places places_requested_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_requested_by_fkey FOREIGN KEY (requested_by) REFERENCES auth.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5708 (class 2606 OID 32870)
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5709 (class 2606 OID 31401)
-- Name: user_follows user_follows_requested_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_follows
    ADD CONSTRAINT user_follows_requested_fkey FOREIGN KEY (requested) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 5710 (class 2606 OID 31406)
-- Name: user_follows user_follows_requester_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_follows
    ADD CONSTRAINT user_follows_requester_fkey FOREIGN KEY (requester) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 5711 (class 2606 OID 32875)
-- Name: vaccines_doses vaccines_doses_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccines_doses
    ADD CONSTRAINT vaccines_doses_users_id_fk FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 5712 (class 2606 OID 32880)
-- Name: vaccines_doses vaccines_doses_users_id_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccines_doses
    ADD CONSTRAINT vaccines_doses_users_id_fk2 FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 5713 (class 2606 OID 31421)
-- Name: vaccines_doses vaccines_doses_vaccine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccines_doses
    ADD CONSTRAINT vaccines_doses_vaccine_id_fkey FOREIGN KEY (vaccine_id) REFERENCES public.health_vaccines(id) ON DELETE CASCADE;


--
-- TOC entry 5726 (class 2606 OID 34571)
-- Name: walks_likes walks_likes_pets_walks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.walks_likes
    ADD CONSTRAINT walks_likes_pets_walks_id_fk FOREIGN KEY (walk_id) REFERENCES public.pets_walks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5727 (class 2606 OID 34576)
-- Name: walks_likes walks_likes_profiles_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.walks_likes
    ADD CONSTRAINT walks_likes_profiles_id_fk FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5720 (class 2606 OID 33746)
-- Name: broadcasts broadcasts_channel_id_fkey; Type: FK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.broadcasts
    ADD CONSTRAINT broadcasts_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES realtime.channels(id) ON DELETE CASCADE;


--
-- TOC entry 5721 (class 2606 OID 33760)
-- Name: presences presences_channel_id_fkey; Type: FK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.presences
    ADD CONSTRAINT presences_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES realtime.channels(id) ON DELETE CASCADE;


--
-- TOC entry 5714 (class 2606 OID 31426)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 5722 (class 2606 OID 33837)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 5723 (class 2606 OID 33857)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 5724 (class 2606 OID 33852)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 5963 (class 3256 OID 31802)
-- Name: health_medicines Allow create if pet_id matches user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow create if pet_id matches user_id" ON public.health_medicines FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5961 (class 3256 OID 31755)
-- Name: health_vaccines Allow create if pet_id matches user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow create if pet_id matches user_id" ON public.health_vaccines FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5967 (class 3256 OID 31896)
-- Name: vaccines_doses Allow create if pet_id matches user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow create if pet_id matches user_id" ON public.vaccines_doses FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM (((public.vaccines_doses vd
     JOIN public.health_vaccines hv ON ((vd.vaccine_id = hv.id)))
     JOIN public.pets_health ph ON ((hv.health_id = ph.id)))
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE ((hv.id = vd.vaccine_id) AND (p.user_id = auth.uid())))));


--
-- TOC entry 5977 (class 3256 OID 31800)
-- Name: health_medicines Allow delete if user_id matches auth.uid(); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow delete if user_id matches auth.uid()" ON public.health_medicines FOR DELETE USING ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5976 (class 3256 OID 31753)
-- Name: health_vaccines Allow delete if user_id matches auth.uid(); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow delete if user_id matches auth.uid()" ON public.health_vaccines FOR DELETE USING ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5965 (class 3256 OID 31892)
-- Name: vaccines_doses Allow delete if user_id matches auth.uid(); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow delete if user_id matches auth.uid()" ON public.vaccines_doses FOR DELETE USING (( SELECT true
   FROM (((public.vaccines_doses vd
     JOIN public.health_vaccines hv ON ((vd.vaccine_id = hv.id)))
     JOIN public.pets_health ph ON ((hv.health_id = ph.id)))
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE ((hv.id = vd.vaccine_id) AND (p.user_id = auth.uid()))));


--
-- TOC entry 5964 (class 3256 OID 31803)
-- Name: health_medicines Allow select for associated user; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow select for associated user" ON public.health_medicines FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5962 (class 3256 OID 31756)
-- Name: health_vaccines Allow select for associated user; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow select for associated user" ON public.health_vaccines FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5968 (class 3256 OID 31898)
-- Name: vaccines_doses Allow select for associated user; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow select for associated user" ON public.vaccines_doses FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (((public.vaccines_doses vd
     JOIN public.health_vaccines hv ON ((vd.vaccine_id = hv.id)))
     JOIN public.pets_health ph ON ((hv.health_id = ph.id)))
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE ((hv.id = vd.vaccine_id) AND (p.user_id = auth.uid())))));


--
-- TOC entry 5978 (class 3256 OID 31801)
-- Name: health_medicines Allow update if user_id matches auth.uid(); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update if user_id matches auth.uid()" ON public.health_medicines FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid()))));


--
-- TOC entry 5960 (class 3256 OID 31754)
-- Name: health_vaccines Allow update if user_id matches auth.uid(); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update if user_id matches auth.uid()" ON public.health_vaccines FOR UPDATE USING (( SELECT true
   FROM (public.pets_health ph
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE (p.user_id = auth.uid())));


--
-- TOC entry 5966 (class 3256 OID 31894)
-- Name: vaccines_doses Allow update if user_id matches auth.uid(); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update if user_id matches auth.uid()" ON public.vaccines_doses FOR UPDATE USING (( SELECT true
   FROM (((public.vaccines_doses vd
     JOIN public.health_vaccines hv ON ((vd.vaccine_id = hv.id)))
     JOIN public.pets_health ph ON ((hv.health_id = ph.id)))
     JOIN public.pets p ON ((ph.pet_id = p.id)))
  WHERE ((hv.id = vd.vaccine_id) AND (p.user_id = auth.uid()))));


--
-- TOC entry 5930 (class 3256 OID 31431)
-- Name: user_follows Aprovação de follow; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Aprovação de follow" ON public.user_follows FOR UPDATE TO authenticated USING ((requested = auth.uid())) WITH CHECK (true);


--
-- TOC entry 5932 (class 3256 OID 31435)
-- Name: pets_walks Enable delete for authenticated user and if user is it's owner; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for authenticated user and if user is it's owner" ON public.pets_walks FOR DELETE TO authenticated USING ((pet_id IN ( SELECT pets.id
   FROM public.pets
  WHERE (pets.user_id = auth.uid()))));


--
-- TOC entry 5933 (class 3256 OID 31436)
-- Name: pets Enable delete for users based on user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for users based on user_id" ON public.pets FOR DELETE TO authenticated USING ((auth.uid() = user_id));


--
-- TOC entry 5975 (class 3256 OID 32410)
-- Name: pets_reminders Enable delete for users based on user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for users based on user_id" ON public.pets_reminders FOR DELETE TO authenticated USING ((auth.uid() = created_by));


--
-- TOC entry 5959 (class 3256 OID 34628)
-- Name: walks_likes Enable delete for users based on user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for users based on user_id" ON public.walks_likes FOR DELETE TO authenticated USING ((( SELECT auth.uid() AS uid) = user_id));


--
-- TOC entry 5934 (class 3256 OID 31437)
-- Name: pets_walks Enable insert for authenticated user and if user is its owner; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated user and if user is its owner" ON public.pets_walks FOR INSERT TO authenticated WITH CHECK ((pet_id IN ( SELECT pets.id
   FROM public.pets
  WHERE (pets.user_id = auth.uid()))));


--
-- TOC entry 5979 (class 3256 OID 32952)
-- Name: account_deletions Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.account_deletions FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5935 (class 3256 OID 31438)
-- Name: pets Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.pets FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5973 (class 3256 OID 32408)
-- Name: pets_reminders Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.pets_reminders FOR INSERT TO authenticated WITH CHECK ((auth.uid() = created_by));


--
-- TOC entry 5969 (class 3256 OID 31964)
-- Name: places Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.places FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5936 (class 3256 OID 31439)
-- Name: user_follows Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.user_follows FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5941 (class 3256 OID 34627)
-- Name: walks_likes Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.walks_likes FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5972 (class 3256 OID 32344)
-- Name: pets_reminders Enable read access for all reminders from user; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all reminders from user" ON public.pets_reminders FOR SELECT TO authenticated USING ((auth.uid() = created_by));


--
-- TOC entry 5937 (class 3256 OID 31442)
-- Name: locale_cities Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.locale_cities FOR SELECT USING (true);


--
-- TOC entry 5938 (class 3256 OID 31443)
-- Name: locale_countries Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.locale_countries FOR SELECT USING (true);


--
-- TOC entry 5939 (class 3256 OID 31444)
-- Name: locale_states Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.locale_states FOR SELECT USING (true);


--
-- TOC entry 5940 (class 3256 OID 31445)
-- Name: pets_health Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.pets_health FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5970 (class 3256 OID 31965)
-- Name: places Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.places FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5942 (class 3256 OID 31447)
-- Name: pets_walks Enable read access only for rows that are of authenticated user; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access only for rows that are of authenticated user" ON public.pets_walks FOR SELECT TO authenticated USING ((auth.uid() IN ( SELECT pets.user_id
   FROM public.pets
  WHERE (pets.user_id = auth.uid()))));


--
-- TOC entry 5971 (class 3256 OID 31449)
-- Name: pets Enable select for users based on user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable select for users based on user_id" ON public.pets FOR SELECT TO authenticated USING (((EXISTS ( SELECT 1
   FROM public.user_follows uf
  WHERE ((uf.requested = pets.user_id) AND (uf.requester = auth.uid()) AND (uf.accepted = true)))) OR (auth.uid() = user_id)));


--
-- TOC entry 5974 (class 3256 OID 32409)
-- Name: pets_reminders Enable update for users based on created_by; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for users based on created_by" ON public.pets_reminders FOR UPDATE TO authenticated USING ((auth.uid() = created_by)) WITH CHECK ((auth.uid() = created_by));


--
-- TOC entry 5943 (class 3256 OID 31450)
-- Name: pets Enable update for users based on email; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for users based on email" ON public.pets FOR UPDATE TO authenticated USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 5944 (class 3256 OID 31451)
-- Name: pets_health Enable update to own pet health; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update to own pet health" ON public.pets_health FOR UPDATE USING ((id IN ( SELECT pets_health_1.id
   FROM public.pets_health pets_health_1
  WHERE (pets_health_1.pet_id IN ( SELECT pets.id
           FROM public.pets
          WHERE (pets.user_id = auth.uid())))))) WITH CHECK (true);


--
-- TOC entry 5945 (class 3256 OID 31452)
-- Name: user_follows Exclusão de follow; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Exclusão de follow" ON public.user_follows FOR DELETE TO authenticated, anon USING (((requester = auth.uid()) OR (requested = auth.uid())));


--
-- TOC entry 5946 (class 3256 OID 31453)
-- Name: pets_health New pets_health; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "New pets_health" ON public.pets_health FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5947 (class 3256 OID 31454)
-- Name: user_follows Obtenção dos follows ; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Obtenção dos follows " ON public.user_follows FOR SELECT TO authenticated, anon USING (((requester = auth.uid()) OR (requested = auth.uid())));


--
-- TOC entry 5948 (class 3256 OID 31455)
-- Name: profiles Public profiles are viewable by everyone.; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles FOR SELECT USING (true);


--
-- TOC entry 5931 (class 3256 OID 34626)
-- Name: walks_likes Select only if you liked; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Select only if you liked" ON public.walks_likes FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5949 (class 3256 OID 31456)
-- Name: profiles Users can insert their own profile.; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own profile." ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- TOC entry 5950 (class 3256 OID 31457)
-- Name: profiles Users can update own profile.; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own profile." ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 5923 (class 0 OID 32921)
-- Dependencies: 399
-- Name: account_deletions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.account_deletions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5908 (class 0 OID 30999)
-- Dependencies: 367
-- Name: health_medicines; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.health_medicines ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5909 (class 0 OID 31007)
-- Dependencies: 369
-- Name: health_vaccines; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.health_vaccines ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5910 (class 0 OID 31015)
-- Dependencies: 370
-- Name: locale_cities; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.locale_cities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5911 (class 0 OID 31022)
-- Dependencies: 372
-- Name: locale_countries; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.locale_countries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5912 (class 0 OID 31029)
-- Dependencies: 374
-- Name: locale_states; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.locale_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5913 (class 0 OID 31047)
-- Dependencies: 376
-- Name: pets; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.pets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5914 (class 0 OID 31056)
-- Dependencies: 377
-- Name: pets_health; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.pets_health ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5922 (class 0 OID 32126)
-- Dependencies: 398
-- Name: pets_reminders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.pets_reminders ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5915 (class 0 OID 31065)
-- Dependencies: 378
-- Name: pets_walks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.pets_walks ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5921 (class 0 OID 31922)
-- Dependencies: 388
-- Name: places; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.places ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5916 (class 0 OID 31076)
-- Dependencies: 379
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5917 (class 0 OID 31088)
-- Dependencies: 380
-- Name: user_follows; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_follows ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5929 (class 0 OID 34567)
-- Dependencies: 416
-- Name: walks_likes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.walks_likes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5925 (class 0 OID 33739)
-- Dependencies: 410
-- Name: broadcasts; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.broadcasts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5924 (class 0 OID 33728)
-- Dependencies: 408
-- Name: channels; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.channels ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5926 (class 0 OID 33753)
-- Dependencies: 412
-- Name: presences; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.presences ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5951 (class 3256 OID 31458)
-- Name: objects Give authenticated users access to own files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give authenticated users access to own files" ON storage.objects FOR SELECT USING (((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text) AND (auth.uid() = owner)));


--
-- TOC entry 5952 (class 3256 OID 31459)
-- Name: objects Give authenticated users the control their own files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give authenticated users the control their own files" ON storage.objects FOR DELETE USING (((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text) AND (auth.uid() = owner)));


--
-- TOC entry 5953 (class 3256 OID 31460)
-- Name: objects Give authenticated users the possibility to upload files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give authenticated users the possibility to upload files" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text)));


--
-- TOC entry 5954 (class 3256 OID 31461)
-- Name: objects Give user the possibility to update own avatar file; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give user the possibility to update own avatar file" ON storage.objects FOR UPDATE USING (((bucket_id = 'avatars'::text) AND (storage.filename(name) = concat((auth.uid())::text, '.png'))));


--
-- TOC entry 5955 (class 3256 OID 31462)
-- Name: objects Give users permission to delete own pet photo; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give users permission to delete own pet photo" ON storage.objects FOR DELETE TO authenticated USING (((bucket_id = 'pets'::text) AND ((storage.foldername(name))[2] = 'photos'::text) AND ((storage.foldername(name))[3] = (auth.uid())::text)));


--
-- TOC entry 5956 (class 3256 OID 31463)
-- Name: objects Give users permission to update own pet photo; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give users permission to update own pet photo" ON storage.objects FOR UPDATE TO authenticated USING ((bucket_id = 'pets'::text)) WITH CHECK ((((auth.uid())::text = (storage.foldername(name))[3]) OR ((auth.uid())::text = (storage.foldername(name))[2]) OR ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 5957 (class 3256 OID 31464)
-- Name: objects Give users permission to upload own pet photo; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give users permission to upload own pet photo" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((((bucket_id = 'pets'::text) AND ((storage.foldername(name))[2] = 'photos'::text) AND ((auth.uid())::text = (storage.foldername(name))[3])) OR ((bucket_id = 'pets'::text) AND ((storage.foldername(name))[1] = 'photos'::text) AND ((auth.uid())::text = (storage.foldername(name))[2]))));


--
-- TOC entry 5958 (class 3256 OID 31465)
-- Name: objects Give users permission to view own pet photos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Give users permission to view own pet photos" ON storage.objects FOR SELECT TO authenticated USING ((((bucket_id = 'pets'::text) AND ((storage.foldername(name))[1] = 'photos'::text) AND (((storage.foldername(name))[2])::uuid = auth.uid()) AND (auth.role() = 'authenticated'::text)) OR ((bucket_id = 'pets'::text) AND ((storage.foldername(name))[2] = 'photos'::text) AND (((storage.foldername(name))[3])::uuid = auth.uid()) AND (auth.role() = 'authenticated'::text))));


--
-- TOC entry 5918 (class 0 OID 31099)
-- Dependencies: 383
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5919 (class 0 OID 31108)
-- Dependencies: 384
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5920 (class 0 OID 31112)
-- Dependencies: 385
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5927 (class 0 OID 33828)
-- Dependencies: 413
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5928 (class 0 OID 33842)
-- Dependencies: 414
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5980 (class 6104 OID 16419)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 6040 (class 0 OID 0)
-- Dependencies: 45
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 6042 (class 0 OID 0)
-- Dependencies: 50
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- TOC entry 6044 (class 0 OID 0)
-- Dependencies: 65
-- Name: SCHEMA cron; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA cron TO postgres WITH GRANT OPTION;


--
-- TOC entry 6045 (class 0 OID 0)
-- Dependencies: 47
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 6047 (class 0 OID 0)
-- Dependencies: 66
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- TOC entry 6049 (class 0 OID 0)
-- Dependencies: 26
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 6050 (class 0 OID 0)
-- Dependencies: 48
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 6063 (class 0 OID 0)
-- Dependencies: 927
-- Name: FUNCTION box2d_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6064 (class 0 OID 0)
-- Dependencies: 928
-- Name: FUNCTION box2d_out(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d_out(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6065 (class 0 OID 0)
-- Dependencies: 929
-- Name: FUNCTION box2df_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2df_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6066 (class 0 OID 0)
-- Dependencies: 930
-- Name: FUNCTION box2df_out(extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2df_out(extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6067 (class 0 OID 0)
-- Dependencies: 925
-- Name: FUNCTION box3d_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6068 (class 0 OID 0)
-- Dependencies: 926
-- Name: FUNCTION box3d_out(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d_out(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6069 (class 0 OID 0)
-- Dependencies: 1451
-- Name: FUNCTION geography_analyze(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_analyze(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6070 (class 0 OID 0)
-- Dependencies: 1447
-- Name: FUNCTION geography_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6071 (class 0 OID 0)
-- Dependencies: 1448
-- Name: FUNCTION geography_out(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_out(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6072 (class 0 OID 0)
-- Dependencies: 1449
-- Name: FUNCTION geography_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6073 (class 0 OID 0)
-- Dependencies: 1450
-- Name: FUNCTION geography_send(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_send(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6074 (class 0 OID 0)
-- Dependencies: 1445
-- Name: FUNCTION geography_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6075 (class 0 OID 0)
-- Dependencies: 1446
-- Name: FUNCTION geography_typmod_out(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_typmod_out(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6076 (class 0 OID 0)
-- Dependencies: 911
-- Name: FUNCTION geometry_analyze(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_analyze(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6077 (class 0 OID 0)
-- Dependencies: 907
-- Name: FUNCTION geometry_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6078 (class 0 OID 0)
-- Dependencies: 908
-- Name: FUNCTION geometry_out(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_out(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6079 (class 0 OID 0)
-- Dependencies: 912
-- Name: FUNCTION geometry_recv(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_recv(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6080 (class 0 OID 0)
-- Dependencies: 913
-- Name: FUNCTION geometry_send(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_send(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6081 (class 0 OID 0)
-- Dependencies: 909
-- Name: FUNCTION geometry_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6082 (class 0 OID 0)
-- Dependencies: 910
-- Name: FUNCTION geometry_typmod_out(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_typmod_out(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6083 (class 0 OID 0)
-- Dependencies: 842
-- Name: FUNCTION ghstore_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6084 (class 0 OID 0)
-- Dependencies: 843
-- Name: FUNCTION ghstore_out(extensions.ghstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_out(extensions.ghstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6085 (class 0 OID 0)
-- Dependencies: 931
-- Name: FUNCTION gidx_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gidx_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6086 (class 0 OID 0)
-- Dependencies: 932
-- Name: FUNCTION gidx_out(extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gidx_out(extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6087 (class 0 OID 0)
-- Dependencies: 797
-- Name: FUNCTION hstore_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6088 (class 0 OID 0)
-- Dependencies: 798
-- Name: FUNCTION hstore_out(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_out(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6089 (class 0 OID 0)
-- Dependencies: 799
-- Name: FUNCTION hstore_recv(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_recv(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6090 (class 0 OID 0)
-- Dependencies: 800
-- Name: FUNCTION hstore_send(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_send(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6091 (class 0 OID 0)
-- Dependencies: 856
-- Name: FUNCTION hstore_subscript_handler(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_subscript_handler(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6092 (class 0 OID 0)
-- Dependencies: 905
-- Name: FUNCTION spheroid_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.spheroid_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6093 (class 0 OID 0)
-- Dependencies: 906
-- Name: FUNCTION spheroid_out(extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.spheroid_out(extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6094 (class 0 OID 0)
-- Dependencies: 820
-- Name: FUNCTION hstore(text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore(text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6095 (class 0 OID 0)
-- Dependencies: 1159
-- Name: FUNCTION box3d(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6096 (class 0 OID 0)
-- Dependencies: 1163
-- Name: FUNCTION geometry(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6097 (class 0 OID 0)
-- Dependencies: 1160
-- Name: FUNCTION box(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6098 (class 0 OID 0)
-- Dependencies: 1158
-- Name: FUNCTION box2d(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6099 (class 0 OID 0)
-- Dependencies: 1164
-- Name: FUNCTION geometry(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6100 (class 0 OID 0)
-- Dependencies: 1453
-- Name: FUNCTION geography(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6101 (class 0 OID 0)
-- Dependencies: 1166
-- Name: FUNCTION geometry(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6102 (class 0 OID 0)
-- Dependencies: 1454
-- Name: FUNCTION bytea(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.bytea(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6103 (class 0 OID 0)
-- Dependencies: 1452
-- Name: FUNCTION geography(extensions.geography, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(extensions.geography, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6104 (class 0 OID 0)
-- Dependencies: 1465
-- Name: FUNCTION geometry(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6105 (class 0 OID 0)
-- Dependencies: 1157
-- Name: FUNCTION box(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6106 (class 0 OID 0)
-- Dependencies: 1155
-- Name: FUNCTION box2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6107 (class 0 OID 0)
-- Dependencies: 1156
-- Name: FUNCTION box3d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6108 (class 0 OID 0)
-- Dependencies: 1167
-- Name: FUNCTION bytea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.bytea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6109 (class 0 OID 0)
-- Dependencies: 1464
-- Name: FUNCTION geography(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6110 (class 0 OID 0)
-- Dependencies: 914
-- Name: FUNCTION geometry(extensions.geometry, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.geometry, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6111 (class 0 OID 0)
-- Dependencies: 1323
-- Name: FUNCTION json(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.json(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6112 (class 0 OID 0)
-- Dependencies: 1324
-- Name: FUNCTION jsonb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.jsonb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6113 (class 0 OID 0)
-- Dependencies: 918
-- Name: FUNCTION path(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.path(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6114 (class 0 OID 0)
-- Dependencies: 916
-- Name: FUNCTION point(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.point(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6115 (class 0 OID 0)
-- Dependencies: 920
-- Name: FUNCTION polygon(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.polygon(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6116 (class 0 OID 0)
-- Dependencies: 1161
-- Name: FUNCTION text(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.text(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6117 (class 0 OID 0)
-- Dependencies: 821
-- Name: FUNCTION hstore_to_json(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_to_json(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6118 (class 0 OID 0)
-- Dependencies: 823
-- Name: FUNCTION hstore_to_jsonb(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_to_jsonb(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6119 (class 0 OID 0)
-- Dependencies: 917
-- Name: FUNCTION geometry(path); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(path) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6120 (class 0 OID 0)
-- Dependencies: 915
-- Name: FUNCTION geometry(point); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(point) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6121 (class 0 OID 0)
-- Dependencies: 919
-- Name: FUNCTION geometry(polygon); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(polygon) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6122 (class 0 OID 0)
-- Dependencies: 1165
-- Name: FUNCTION geometry(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6124 (class 0 OID 0)
-- Dependencies: 1664
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- TOC entry 6125 (class 0 OID 0)
-- Dependencies: 1665
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 6127 (class 0 OID 0)
-- Dependencies: 1666
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- TOC entry 6129 (class 0 OID 0)
-- Dependencies: 1667
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- TOC entry 6130 (class 0 OID 0)
-- Dependencies: 1697
-- Name: FUNCTION alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6131 (class 0 OID 0)
-- Dependencies: 1694
-- Name: FUNCTION job_cache_invalidate(); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.job_cache_invalidate() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6132 (class 0 OID 0)
-- Dependencies: 1692
-- Name: FUNCTION schedule(schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6133 (class 0 OID 0)
-- Dependencies: 1696
-- Name: FUNCTION schedule(job_name text, schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(job_name text, schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6134 (class 0 OID 0)
-- Dependencies: 1698
-- Name: FUNCTION schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6135 (class 0 OID 0)
-- Dependencies: 1693
-- Name: FUNCTION unschedule(job_id bigint); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_id bigint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6136 (class 0 OID 0)
-- Dependencies: 1695
-- Name: FUNCTION unschedule(job_name name); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_name name) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6137 (class 0 OID 0)
-- Dependencies: 904
-- Name: FUNCTION _postgis_deprecate(oldname text, newname text, version text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_deprecate(oldname text, newname text, version text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6138 (class 0 OID 0)
-- Dependencies: 953
-- Name: FUNCTION _postgis_index_extent(tbl regclass, col text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_index_extent(tbl regclass, col text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6139 (class 0 OID 0)
-- Dependencies: 951
-- Name: FUNCTION _postgis_join_selectivity(regclass, text, regclass, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_join_selectivity(regclass, text, regclass, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6140 (class 0 OID 0)
-- Dependencies: 1152
-- Name: FUNCTION _postgis_pgsql_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_pgsql_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6141 (class 0 OID 0)
-- Dependencies: 1151
-- Name: FUNCTION _postgis_scripts_pgsql_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_scripts_pgsql_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6142 (class 0 OID 0)
-- Dependencies: 950
-- Name: FUNCTION _postgis_selectivity(tbl regclass, att_name text, geom extensions.geometry, mode text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_selectivity(tbl regclass, att_name text, geom extensions.geometry, mode text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6143 (class 0 OID 0)
-- Dependencies: 952
-- Name: FUNCTION _postgis_stats(tbl regclass, att_name text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_stats(tbl regclass, att_name text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6144 (class 0 OID 0)
-- Dependencies: 1270
-- Name: FUNCTION _st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6145 (class 0 OID 0)
-- Dependencies: 1269
-- Name: FUNCTION _st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6146 (class 0 OID 0)
-- Dependencies: 1271
-- Name: FUNCTION _st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6147 (class 0 OID 0)
-- Dependencies: 1317
-- Name: FUNCTION _st_asgml(integer, extensions.geometry, integer, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_asgml(integer, extensions.geometry, integer, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6148 (class 0 OID 0)
-- Dependencies: 1595
-- Name: FUNCTION _st_asx3d(integer, extensions.geometry, integer, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_asx3d(integer, extensions.geometry, integer, integer, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6149 (class 0 OID 0)
-- Dependencies: 1515
-- Name: FUNCTION _st_bestsrid(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_bestsrid(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6150 (class 0 OID 0)
-- Dependencies: 1514
-- Name: FUNCTION _st_bestsrid(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_bestsrid(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6151 (class 0 OID 0)
-- Dependencies: 1593
-- Name: FUNCTION _st_concavehull(param_inputgeom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_concavehull(param_inputgeom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6152 (class 0 OID 0)
-- Dependencies: 1262
-- Name: FUNCTION _st_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6153 (class 0 OID 0)
-- Dependencies: 1263
-- Name: FUNCTION _st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6154 (class 0 OID 0)
-- Dependencies: 1538
-- Name: FUNCTION _st_coveredby(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_coveredby(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6155 (class 0 OID 0)
-- Dependencies: 1265
-- Name: FUNCTION _st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6156 (class 0 OID 0)
-- Dependencies: 1536
-- Name: FUNCTION _st_covers(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_covers(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6157 (class 0 OID 0)
-- Dependencies: 1264
-- Name: FUNCTION _st_covers(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_covers(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6158 (class 0 OID 0)
-- Dependencies: 1261
-- Name: FUNCTION _st_crosses(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_crosses(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6159 (class 0 OID 0)
-- Dependencies: 1268
-- Name: FUNCTION _st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6160 (class 0 OID 0)
-- Dependencies: 1502
-- Name: FUNCTION _st_distancetree(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distancetree(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6161 (class 0 OID 0)
-- Dependencies: 1501
-- Name: FUNCTION _st_distancetree(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distancetree(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6162 (class 0 OID 0)
-- Dependencies: 1500
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6163 (class 0 OID 0)
-- Dependencies: 1499
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6164 (class 0 OID 0)
-- Dependencies: 1498
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6165 (class 0 OID 0)
-- Dependencies: 1258
-- Name: FUNCTION _st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6166 (class 0 OID 0)
-- Dependencies: 1537
-- Name: FUNCTION _st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6167 (class 0 OID 0)
-- Dependencies: 1504
-- Name: FUNCTION _st_dwithinuncached(extensions.geography, extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithinuncached(extensions.geography, extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6168 (class 0 OID 0)
-- Dependencies: 1503
-- Name: FUNCTION _st_dwithinuncached(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithinuncached(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6169 (class 0 OID 0)
-- Dependencies: 1273
-- Name: FUNCTION _st_equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6170 (class 0 OID 0)
-- Dependencies: 1497
-- Name: FUNCTION _st_expand(extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_expand(extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6171 (class 0 OID 0)
-- Dependencies: 1302
-- Name: FUNCTION _st_geomfromgml(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_geomfromgml(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6172 (class 0 OID 0)
-- Dependencies: 1260
-- Name: FUNCTION _st_intersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_intersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6173 (class 0 OID 0)
-- Dependencies: 1257
-- Name: FUNCTION _st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6174 (class 0 OID 0)
-- Dependencies: 1426
-- Name: FUNCTION _st_longestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_longestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6175 (class 0 OID 0)
-- Dependencies: 1422
-- Name: FUNCTION _st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6176 (class 0 OID 0)
-- Dependencies: 1272
-- Name: FUNCTION _st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6177 (class 0 OID 0)
-- Dependencies: 1267
-- Name: FUNCTION _st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6178 (class 0 OID 0)
-- Dependencies: 1512
-- Name: FUNCTION _st_pointoutside(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_pointoutside(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6179 (class 0 OID 0)
-- Dependencies: 1346
-- Name: FUNCTION _st_sortablehash(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_sortablehash(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6180 (class 0 OID 0)
-- Dependencies: 1259
-- Name: FUNCTION _st_touches(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_touches(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6181 (class 0 OID 0)
-- Dependencies: 1229
-- Name: FUNCTION _st_voronoi(g1 extensions.geometry, clip extensions.geometry, tolerance double precision, return_polygons boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_voronoi(g1 extensions.geometry, clip extensions.geometry, tolerance double precision, return_polygons boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6182 (class 0 OID 0)
-- Dependencies: 1266
-- Name: FUNCTION _st_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6183 (class 0 OID 0)
-- Dependencies: 1437
-- Name: FUNCTION addauth(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addauth(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6184 (class 0 OID 0)
-- Dependencies: 1119
-- Name: FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6185 (class 0 OID 0)
-- Dependencies: 1118
-- Name: FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6186 (class 0 OID 0)
-- Dependencies: 1117
-- Name: FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6187 (class 0 OID 0)
-- Dependencies: 828
-- Name: FUNCTION akeys(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.akeys(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6188 (class 0 OID 0)
-- Dependencies: 900
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 6189 (class 0 OID 0)
-- Dependencies: 894
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 6190 (class 0 OID 0)
-- Dependencies: 895
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 6191 (class 0 OID 0)
-- Dependencies: 829
-- Name: FUNCTION avals(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.avals(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6192 (class 0 OID 0)
-- Dependencies: 1162
-- Name: FUNCTION box3dtobox(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3dtobox(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6193 (class 0 OID 0)
-- Dependencies: 1439
-- Name: FUNCTION checkauth(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauth(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6194 (class 0 OID 0)
-- Dependencies: 1438
-- Name: FUNCTION checkauth(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauth(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6195 (class 0 OID 0)
-- Dependencies: 1440
-- Name: FUNCTION checkauthtrigger(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauthtrigger() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6196 (class 0 OID 0)
-- Dependencies: 1581
-- Name: FUNCTION contains_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6197 (class 0 OID 0)
-- Dependencies: 1577
-- Name: FUNCTION contains_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6198 (class 0 OID 0)
-- Dependencies: 1583
-- Name: FUNCTION contains_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6199 (class 0 OID 0)
-- Dependencies: 866
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 6200 (class 0 OID 0)
-- Dependencies: 896
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 6201 (class 0 OID 0)
-- Dependencies: 870
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6202 (class 0 OID 0)
-- Dependencies: 872
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6203 (class 0 OID 0)
-- Dependencies: 810
-- Name: FUNCTION defined(extensions.hstore, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.defined(extensions.hstore, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6204 (class 0 OID 0)
-- Dependencies: 813
-- Name: FUNCTION delete(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.delete(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6205 (class 0 OID 0)
-- Dependencies: 812
-- Name: FUNCTION delete(extensions.hstore, text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.delete(extensions.hstore, text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6206 (class 0 OID 0)
-- Dependencies: 811
-- Name: FUNCTION delete(extensions.hstore, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.delete(extensions.hstore, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6207 (class 0 OID 0)
-- Dependencies: 863
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 6208 (class 0 OID 0)
-- Dependencies: 862
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 6209 (class 0 OID 0)
-- Dependencies: 1444
-- Name: FUNCTION disablelongtransactions(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.disablelongtransactions() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6210 (class 0 OID 0)
-- Dependencies: 1122
-- Name: FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6211 (class 0 OID 0)
-- Dependencies: 1121
-- Name: FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6212 (class 0 OID 0)
-- Dependencies: 1120
-- Name: FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6213 (class 0 OID 0)
-- Dependencies: 1125
-- Name: FUNCTION dropgeometrytable(table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(table_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6214 (class 0 OID 0)
-- Dependencies: 1124
-- Name: FUNCTION dropgeometrytable(schema_name character varying, table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(schema_name character varying, table_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6215 (class 0 OID 0)
-- Dependencies: 1123
-- Name: FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6216 (class 0 OID 0)
-- Dependencies: 832
-- Name: FUNCTION each(hs extensions.hstore, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.each(hs extensions.hstore, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6217 (class 0 OID 0)
-- Dependencies: 1442
-- Name: FUNCTION enablelongtransactions(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.enablelongtransactions() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6218 (class 0 OID 0)
-- Dependencies: 869
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6219 (class 0 OID 0)
-- Dependencies: 871
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6220 (class 0 OID 0)
-- Dependencies: 1301
-- Name: FUNCTION equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6221 (class 0 OID 0)
-- Dependencies: 806
-- Name: FUNCTION exist(extensions.hstore, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.exist(extensions.hstore, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6222 (class 0 OID 0)
-- Dependencies: 808
-- Name: FUNCTION exists_all(extensions.hstore, text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.exists_all(extensions.hstore, text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6223 (class 0 OID 0)
-- Dependencies: 807
-- Name: FUNCTION exists_any(extensions.hstore, text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.exists_any(extensions.hstore, text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6224 (class 0 OID 0)
-- Dependencies: 802
-- Name: FUNCTION fetchval(extensions.hstore, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.fetchval(extensions.hstore, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6225 (class 0 OID 0)
-- Dependencies: 1129
-- Name: FUNCTION find_srid(character varying, character varying, character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.find_srid(character varying, character varying, character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6226 (class 0 OID 0)
-- Dependencies: 873
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 6227 (class 0 OID 0)
-- Dependencies: 874
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 6228 (class 0 OID 0)
-- Dependencies: 867
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 6229 (class 0 OID 0)
-- Dependencies: 868
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 6230 (class 0 OID 0)
-- Dependencies: 1479
-- Name: FUNCTION geog_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6231 (class 0 OID 0)
-- Dependencies: 1485
-- Name: FUNCTION geography_cmp(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_cmp(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6232 (class 0 OID 0)
-- Dependencies: 1474
-- Name: FUNCTION geography_distance_knn(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_distance_knn(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6233 (class 0 OID 0)
-- Dependencies: 1484
-- Name: FUNCTION geography_eq(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_eq(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6234 (class 0 OID 0)
-- Dependencies: 1483
-- Name: FUNCTION geography_ge(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_ge(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6235 (class 0 OID 0)
-- Dependencies: 1467
-- Name: FUNCTION geography_gist_compress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_compress(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6236 (class 0 OID 0)
-- Dependencies: 1466
-- Name: FUNCTION geography_gist_consistent(internal, extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_consistent(internal, extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6237 (class 0 OID 0)
-- Dependencies: 1472
-- Name: FUNCTION geography_gist_decompress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_decompress(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6238 (class 0 OID 0)
-- Dependencies: 1475
-- Name: FUNCTION geography_gist_distance(internal, extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_distance(internal, extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6239 (class 0 OID 0)
-- Dependencies: 1468
-- Name: FUNCTION geography_gist_penalty(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_penalty(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6240 (class 0 OID 0)
-- Dependencies: 1469
-- Name: FUNCTION geography_gist_picksplit(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_picksplit(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6241 (class 0 OID 0)
-- Dependencies: 1471
-- Name: FUNCTION geography_gist_same(extensions.box2d, extensions.box2d, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_same(extensions.box2d, extensions.box2d, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6242 (class 0 OID 0)
-- Dependencies: 1470
-- Name: FUNCTION geography_gist_union(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_union(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6243 (class 0 OID 0)
-- Dependencies: 1482
-- Name: FUNCTION geography_gt(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gt(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6244 (class 0 OID 0)
-- Dependencies: 1481
-- Name: FUNCTION geography_le(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_le(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6245 (class 0 OID 0)
-- Dependencies: 1480
-- Name: FUNCTION geography_lt(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_lt(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6246 (class 0 OID 0)
-- Dependencies: 1473
-- Name: FUNCTION geography_overlaps(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_overlaps(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6247 (class 0 OID 0)
-- Dependencies: 1622
-- Name: FUNCTION geography_spgist_choose_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_choose_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6248 (class 0 OID 0)
-- Dependencies: 1626
-- Name: FUNCTION geography_spgist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6249 (class 0 OID 0)
-- Dependencies: 1621
-- Name: FUNCTION geography_spgist_config_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_config_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6250 (class 0 OID 0)
-- Dependencies: 1624
-- Name: FUNCTION geography_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_inner_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6251 (class 0 OID 0)
-- Dependencies: 1625
-- Name: FUNCTION geography_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_leaf_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6252 (class 0 OID 0)
-- Dependencies: 1623
-- Name: FUNCTION geography_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6253 (class 0 OID 0)
-- Dependencies: 1589
-- Name: FUNCTION geom2d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6254 (class 0 OID 0)
-- Dependencies: 1590
-- Name: FUNCTION geom3d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6255 (class 0 OID 0)
-- Dependencies: 1591
-- Name: FUNCTION geom4d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6256 (class 0 OID 0)
-- Dependencies: 971
-- Name: FUNCTION geometry_above(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_above(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6257 (class 0 OID 0)
-- Dependencies: 966
-- Name: FUNCTION geometry_below(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_below(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6258 (class 0 OID 0)
-- Dependencies: 938
-- Name: FUNCTION geometry_cmp(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_cmp(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6259 (class 0 OID 0)
-- Dependencies: 1607
-- Name: FUNCTION geometry_contained_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contained_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6260 (class 0 OID 0)
-- Dependencies: 962
-- Name: FUNCTION geometry_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6261 (class 0 OID 0)
-- Dependencies: 1606
-- Name: FUNCTION geometry_contains_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6262 (class 0 OID 0)
-- Dependencies: 980
-- Name: FUNCTION geometry_contains_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6263 (class 0 OID 0)
-- Dependencies: 961
-- Name: FUNCTION geometry_distance_box(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_box(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6264 (class 0 OID 0)
-- Dependencies: 960
-- Name: FUNCTION geometry_distance_centroid(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_centroid(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6265 (class 0 OID 0)
-- Dependencies: 983
-- Name: FUNCTION geometry_distance_centroid_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_centroid_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6266 (class 0 OID 0)
-- Dependencies: 984
-- Name: FUNCTION geometry_distance_cpa(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_cpa(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6267 (class 0 OID 0)
-- Dependencies: 937
-- Name: FUNCTION geometry_eq(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_eq(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6268 (class 0 OID 0)
-- Dependencies: 936
-- Name: FUNCTION geometry_ge(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_ge(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6269 (class 0 OID 0)
-- Dependencies: 943
-- Name: FUNCTION geometry_gist_compress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_compress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6270 (class 0 OID 0)
-- Dependencies: 973
-- Name: FUNCTION geometry_gist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6271 (class 0 OID 0)
-- Dependencies: 942
-- Name: FUNCTION geometry_gist_consistent_2d(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_consistent_2d(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6272 (class 0 OID 0)
-- Dependencies: 972
-- Name: FUNCTION geometry_gist_consistent_nd(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_consistent_nd(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6273 (class 0 OID 0)
-- Dependencies: 948
-- Name: FUNCTION geometry_gist_decompress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_decompress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6274 (class 0 OID 0)
-- Dependencies: 978
-- Name: FUNCTION geometry_gist_decompress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_decompress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6275 (class 0 OID 0)
-- Dependencies: 941
-- Name: FUNCTION geometry_gist_distance_2d(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_distance_2d(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6276 (class 0 OID 0)
-- Dependencies: 985
-- Name: FUNCTION geometry_gist_distance_nd(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_distance_nd(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6277 (class 0 OID 0)
-- Dependencies: 944
-- Name: FUNCTION geometry_gist_penalty_2d(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_penalty_2d(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6278 (class 0 OID 0)
-- Dependencies: 974
-- Name: FUNCTION geometry_gist_penalty_nd(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_penalty_nd(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6279 (class 0 OID 0)
-- Dependencies: 945
-- Name: FUNCTION geometry_gist_picksplit_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_picksplit_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6280 (class 0 OID 0)
-- Dependencies: 975
-- Name: FUNCTION geometry_gist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6281 (class 0 OID 0)
-- Dependencies: 947
-- Name: FUNCTION geometry_gist_same_2d(geom1 extensions.geometry, geom2 extensions.geometry, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_same_2d(geom1 extensions.geometry, geom2 extensions.geometry, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6282 (class 0 OID 0)
-- Dependencies: 977
-- Name: FUNCTION geometry_gist_same_nd(extensions.geometry, extensions.geometry, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_same_nd(extensions.geometry, extensions.geometry, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6283 (class 0 OID 0)
-- Dependencies: 949
-- Name: FUNCTION geometry_gist_sortsupport_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_sortsupport_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6284 (class 0 OID 0)
-- Dependencies: 946
-- Name: FUNCTION geometry_gist_union_2d(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_union_2d(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6285 (class 0 OID 0)
-- Dependencies: 976
-- Name: FUNCTION geometry_gist_union_nd(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_union_nd(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6286 (class 0 OID 0)
-- Dependencies: 935
-- Name: FUNCTION geometry_gt(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gt(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6287 (class 0 OID 0)
-- Dependencies: 940
-- Name: FUNCTION geometry_hash(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_hash(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6288 (class 0 OID 0)
-- Dependencies: 934
-- Name: FUNCTION geometry_le(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_le(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6289 (class 0 OID 0)
-- Dependencies: 964
-- Name: FUNCTION geometry_left(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_left(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6290 (class 0 OID 0)
-- Dependencies: 933
-- Name: FUNCTION geometry_lt(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_lt(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6291 (class 0 OID 0)
-- Dependencies: 970
-- Name: FUNCTION geometry_overabove(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overabove(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6292 (class 0 OID 0)
-- Dependencies: 967
-- Name: FUNCTION geometry_overbelow(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overbelow(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6293 (class 0 OID 0)
-- Dependencies: 958
-- Name: FUNCTION geometry_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6294 (class 0 OID 0)
-- Dependencies: 1605
-- Name: FUNCTION geometry_overlaps_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6295 (class 0 OID 0)
-- Dependencies: 979
-- Name: FUNCTION geometry_overlaps_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6296 (class 0 OID 0)
-- Dependencies: 965
-- Name: FUNCTION geometry_overleft(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overleft(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6297 (class 0 OID 0)
-- Dependencies: 968
-- Name: FUNCTION geometry_overright(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overright(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6298 (class 0 OID 0)
-- Dependencies: 969
-- Name: FUNCTION geometry_right(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_right(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6299 (class 0 OID 0)
-- Dependencies: 959
-- Name: FUNCTION geometry_same(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6300 (class 0 OID 0)
-- Dependencies: 1608
-- Name: FUNCTION geometry_same_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6301 (class 0 OID 0)
-- Dependencies: 982
-- Name: FUNCTION geometry_same_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6302 (class 0 OID 0)
-- Dependencies: 939
-- Name: FUNCTION geometry_sortsupport(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_sortsupport(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6303 (class 0 OID 0)
-- Dependencies: 1600
-- Name: FUNCTION geometry_spgist_choose_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6304 (class 0 OID 0)
-- Dependencies: 1610
-- Name: FUNCTION geometry_spgist_choose_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6305 (class 0 OID 0)
-- Dependencies: 1616
-- Name: FUNCTION geometry_spgist_choose_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6306 (class 0 OID 0)
-- Dependencies: 1604
-- Name: FUNCTION geometry_spgist_compress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6307 (class 0 OID 0)
-- Dependencies: 1614
-- Name: FUNCTION geometry_spgist_compress_3d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_3d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6308 (class 0 OID 0)
-- Dependencies: 1620
-- Name: FUNCTION geometry_spgist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6309 (class 0 OID 0)
-- Dependencies: 1599
-- Name: FUNCTION geometry_spgist_config_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6310 (class 0 OID 0)
-- Dependencies: 1609
-- Name: FUNCTION geometry_spgist_config_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6311 (class 0 OID 0)
-- Dependencies: 1615
-- Name: FUNCTION geometry_spgist_config_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6312 (class 0 OID 0)
-- Dependencies: 1602
-- Name: FUNCTION geometry_spgist_inner_consistent_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6313 (class 0 OID 0)
-- Dependencies: 1612
-- Name: FUNCTION geometry_spgist_inner_consistent_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6314 (class 0 OID 0)
-- Dependencies: 1618
-- Name: FUNCTION geometry_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6315 (class 0 OID 0)
-- Dependencies: 1603
-- Name: FUNCTION geometry_spgist_leaf_consistent_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6316 (class 0 OID 0)
-- Dependencies: 1613
-- Name: FUNCTION geometry_spgist_leaf_consistent_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6317 (class 0 OID 0)
-- Dependencies: 1619
-- Name: FUNCTION geometry_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6318 (class 0 OID 0)
-- Dependencies: 1601
-- Name: FUNCTION geometry_spgist_picksplit_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6319 (class 0 OID 0)
-- Dependencies: 1611
-- Name: FUNCTION geometry_spgist_picksplit_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6320 (class 0 OID 0)
-- Dependencies: 1617
-- Name: FUNCTION geometry_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6321 (class 0 OID 0)
-- Dependencies: 963
-- Name: FUNCTION geometry_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6322 (class 0 OID 0)
-- Dependencies: 981
-- Name: FUNCTION geometry_within_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_within_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6323 (class 0 OID 0)
-- Dependencies: 1529
-- Name: FUNCTION geometrytype(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometrytype(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6324 (class 0 OID 0)
-- Dependencies: 1358
-- Name: FUNCTION geometrytype(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometrytype(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6325 (class 0 OID 0)
-- Dependencies: 1067
-- Name: FUNCTION geomfromewkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geomfromewkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6326 (class 0 OID 0)
-- Dependencies: 1070
-- Name: FUNCTION geomfromewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geomfromewkt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6327 (class 0 OID 0)
-- Dependencies: 1130
-- Name: FUNCTION get_proj4_from_srid(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.get_proj4_from_srid(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6328 (class 0 OID 0)
-- Dependencies: 1441
-- Name: FUNCTION gettransactionid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gettransactionid() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6329 (class 0 OID 0)
-- Dependencies: 844
-- Name: FUNCTION ghstore_compress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_compress(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6330 (class 0 OID 0)
-- Dependencies: 850
-- Name: FUNCTION ghstore_consistent(internal, extensions.hstore, smallint, oid, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_consistent(internal, extensions.hstore, smallint, oid, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6331 (class 0 OID 0)
-- Dependencies: 845
-- Name: FUNCTION ghstore_decompress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_decompress(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6332 (class 0 OID 0)
-- Dependencies: 855
-- Name: FUNCTION ghstore_options(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_options(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6333 (class 0 OID 0)
-- Dependencies: 846
-- Name: FUNCTION ghstore_penalty(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_penalty(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6334 (class 0 OID 0)
-- Dependencies: 847
-- Name: FUNCTION ghstore_picksplit(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_picksplit(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6335 (class 0 OID 0)
-- Dependencies: 849
-- Name: FUNCTION ghstore_same(extensions.ghstore, extensions.ghstore, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_same(extensions.ghstore, extensions.ghstore, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6336 (class 0 OID 0)
-- Dependencies: 848
-- Name: FUNCTION ghstore_union(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ghstore_union(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6337 (class 0 OID 0)
-- Dependencies: 853
-- Name: FUNCTION gin_consistent_hstore(internal, smallint, extensions.hstore, integer, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gin_consistent_hstore(internal, smallint, extensions.hstore, integer, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6338 (class 0 OID 0)
-- Dependencies: 851
-- Name: FUNCTION gin_extract_hstore(extensions.hstore, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gin_extract_hstore(extensions.hstore, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6339 (class 0 OID 0)
-- Dependencies: 852
-- Name: FUNCTION gin_extract_hstore_query(extensions.hstore, internal, smallint, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gin_extract_hstore_query(extensions.hstore, internal, smallint, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6341 (class 0 OID 0)
-- Dependencies: 1668
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 6343 (class 0 OID 0)
-- Dependencies: 1669
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6345 (class 0 OID 0)
-- Dependencies: 1670
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 6346 (class 0 OID 0)
-- Dependencies: 956
-- Name: FUNCTION gserialized_gist_joinsel_2d(internal, oid, internal, smallint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6347 (class 0 OID 0)
-- Dependencies: 957
-- Name: FUNCTION gserialized_gist_joinsel_nd(internal, oid, internal, smallint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6348 (class 0 OID 0)
-- Dependencies: 954
-- Name: FUNCTION gserialized_gist_sel_2d(internal, oid, internal, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_sel_2d(internal, oid, internal, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6349 (class 0 OID 0)
-- Dependencies: 955
-- Name: FUNCTION gserialized_gist_sel_nd(internal, oid, internal, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_sel_nd(internal, oid, internal, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6350 (class 0 OID 0)
-- Dependencies: 865
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6351 (class 0 OID 0)
-- Dependencies: 864
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 6352 (class 0 OID 0)
-- Dependencies: 814
-- Name: FUNCTION hs_concat(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hs_concat(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6353 (class 0 OID 0)
-- Dependencies: 816
-- Name: FUNCTION hs_contained(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hs_contained(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6354 (class 0 OID 0)
-- Dependencies: 815
-- Name: FUNCTION hs_contains(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hs_contains(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6355 (class 0 OID 0)
-- Dependencies: 825
-- Name: FUNCTION hstore(record); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore(record) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6356 (class 0 OID 0)
-- Dependencies: 819
-- Name: FUNCTION hstore(text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore(text[], text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6357 (class 0 OID 0)
-- Dependencies: 818
-- Name: FUNCTION hstore(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6358 (class 0 OID 0)
-- Dependencies: 840
-- Name: FUNCTION hstore_cmp(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_cmp(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6359 (class 0 OID 0)
-- Dependencies: 834
-- Name: FUNCTION hstore_eq(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_eq(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6360 (class 0 OID 0)
-- Dependencies: 837
-- Name: FUNCTION hstore_ge(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_ge(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6361 (class 0 OID 0)
-- Dependencies: 836
-- Name: FUNCTION hstore_gt(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_gt(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6362 (class 0 OID 0)
-- Dependencies: 841
-- Name: FUNCTION hstore_hash(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_hash(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6363 (class 0 OID 0)
-- Dependencies: 854
-- Name: FUNCTION hstore_hash_extended(extensions.hstore, bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_hash_extended(extensions.hstore, bigint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6364 (class 0 OID 0)
-- Dependencies: 839
-- Name: FUNCTION hstore_le(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_le(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6365 (class 0 OID 0)
-- Dependencies: 838
-- Name: FUNCTION hstore_lt(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_lt(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6366 (class 0 OID 0)
-- Dependencies: 835
-- Name: FUNCTION hstore_ne(extensions.hstore, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_ne(extensions.hstore, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6367 (class 0 OID 0)
-- Dependencies: 826
-- Name: FUNCTION hstore_to_array(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_to_array(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6368 (class 0 OID 0)
-- Dependencies: 822
-- Name: FUNCTION hstore_to_json_loose(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_to_json_loose(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6369 (class 0 OID 0)
-- Dependencies: 824
-- Name: FUNCTION hstore_to_jsonb_loose(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_to_jsonb_loose(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6370 (class 0 OID 0)
-- Dependencies: 827
-- Name: FUNCTION hstore_to_matrix(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_to_matrix(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6371 (class 0 OID 0)
-- Dependencies: 801
-- Name: FUNCTION hstore_version_diag(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hstore_version_diag(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6372 (class 0 OID 0)
-- Dependencies: 857
-- Name: FUNCTION insert_username(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.insert_username() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6373 (class 0 OID 0)
-- Dependencies: 1582
-- Name: FUNCTION is_contained_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6374 (class 0 OID 0)
-- Dependencies: 1578
-- Name: FUNCTION is_contained_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6375 (class 0 OID 0)
-- Dependencies: 1584
-- Name: FUNCTION is_contained_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6376 (class 0 OID 0)
-- Dependencies: 809
-- Name: FUNCTION isdefined(extensions.hstore, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.isdefined(extensions.hstore, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6377 (class 0 OID 0)
-- Dependencies: 805
-- Name: FUNCTION isexists(extensions.hstore, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.isexists(extensions.hstore, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6378 (class 0 OID 0)
-- Dependencies: 1435
-- Name: FUNCTION lockrow(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6379 (class 0 OID 0)
-- Dependencies: 1434
-- Name: FUNCTION lockrow(text, text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6380 (class 0 OID 0)
-- Dependencies: 1436
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, timestamp without time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6381 (class 0 OID 0)
-- Dependencies: 1433
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, text, timestamp without time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6382 (class 0 OID 0)
-- Dependencies: 1443
-- Name: FUNCTION longtransactionsenabled(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.longtransactionsenabled() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6383 (class 0 OID 0)
-- Dependencies: 1580
-- Name: FUNCTION overlaps_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6384 (class 0 OID 0)
-- Dependencies: 1579
-- Name: FUNCTION overlaps_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6385 (class 0 OID 0)
-- Dependencies: 1585
-- Name: FUNCTION overlaps_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6386 (class 0 OID 0)
-- Dependencies: 1478
-- Name: FUNCTION overlaps_geog(extensions.geography, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.geography, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6387 (class 0 OID 0)
-- Dependencies: 1476
-- Name: FUNCTION overlaps_geog(extensions.gidx, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.gidx, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6388 (class 0 OID 0)
-- Dependencies: 1477
-- Name: FUNCTION overlaps_geog(extensions.gidx, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.gidx, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6389 (class 0 OID 0)
-- Dependencies: 1588
-- Name: FUNCTION overlaps_nd(extensions.geometry, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.geometry, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6390 (class 0 OID 0)
-- Dependencies: 1586
-- Name: FUNCTION overlaps_nd(extensions.gidx, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.gidx, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6391 (class 0 OID 0)
-- Dependencies: 1587
-- Name: FUNCTION overlaps_nd(extensions.gidx, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.gidx, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6392 (class 0 OID 0)
-- Dependencies: 861
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- TOC entry 6393 (class 0 OID 0)
-- Dependencies: 860
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 6394 (class 0 OID 0)
-- Dependencies: 859
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- TOC entry 6395 (class 0 OID 0)
-- Dependencies: 1342
-- Name: FUNCTION pgis_asflatgeobuf_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6396 (class 0 OID 0)
-- Dependencies: 1339
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6397 (class 0 OID 0)
-- Dependencies: 1340
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6398 (class 0 OID 0)
-- Dependencies: 1341
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6399 (class 0 OID 0)
-- Dependencies: 1338
-- Name: FUNCTION pgis_asgeobuf_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6400 (class 0 OID 0)
-- Dependencies: 1336
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6401 (class 0 OID 0)
-- Dependencies: 1337
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_transfn(internal, anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6402 (class 0 OID 0)
-- Dependencies: 1331
-- Name: FUNCTION pgis_asmvt_combinefn(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_combinefn(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6403 (class 0 OID 0)
-- Dependencies: 1333
-- Name: FUNCTION pgis_asmvt_deserialfn(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_deserialfn(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6404 (class 0 OID 0)
-- Dependencies: 1330
-- Name: FUNCTION pgis_asmvt_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6405 (class 0 OID 0)
-- Dependencies: 1332
-- Name: FUNCTION pgis_asmvt_serialfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_serialfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6406 (class 0 OID 0)
-- Dependencies: 1325
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6407 (class 0 OID 0)
-- Dependencies: 1326
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6408 (class 0 OID 0)
-- Dependencies: 1327
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6409 (class 0 OID 0)
-- Dependencies: 1328
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6410 (class 0 OID 0)
-- Dependencies: 1329
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6411 (class 0 OID 0)
-- Dependencies: 1237
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6412 (class 0 OID 0)
-- Dependencies: 1238
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6413 (class 0 OID 0)
-- Dependencies: 1239
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6414 (class 0 OID 0)
-- Dependencies: 1242
-- Name: FUNCTION pgis_geometry_clusterintersecting_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_clusterintersecting_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6415 (class 0 OID 0)
-- Dependencies: 1243
-- Name: FUNCTION pgis_geometry_clusterwithin_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_clusterwithin_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6416 (class 0 OID 0)
-- Dependencies: 1240
-- Name: FUNCTION pgis_geometry_collect_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_collect_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6417 (class 0 OID 0)
-- Dependencies: 1244
-- Name: FUNCTION pgis_geometry_makeline_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_makeline_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6418 (class 0 OID 0)
-- Dependencies: 1241
-- Name: FUNCTION pgis_geometry_polygonize_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_polygonize_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6419 (class 0 OID 0)
-- Dependencies: 1247
-- Name: FUNCTION pgis_geometry_union_parallel_combinefn(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_combinefn(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6420 (class 0 OID 0)
-- Dependencies: 1249
-- Name: FUNCTION pgis_geometry_union_parallel_deserialfn(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6421 (class 0 OID 0)
-- Dependencies: 1250
-- Name: FUNCTION pgis_geometry_union_parallel_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6422 (class 0 OID 0)
-- Dependencies: 1248
-- Name: FUNCTION pgis_geometry_union_parallel_serialfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_serialfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6423 (class 0 OID 0)
-- Dependencies: 1245
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_transfn(internal, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6424 (class 0 OID 0)
-- Dependencies: 1246
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_transfn(internal, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6425 (class 0 OID 0)
-- Dependencies: 897
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 6426 (class 0 OID 0)
-- Dependencies: 893
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 6427 (class 0 OID 0)
-- Dependencies: 887
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 6428 (class 0 OID 0)
-- Dependencies: 889
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6429 (class 0 OID 0)
-- Dependencies: 891
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 6430 (class 0 OID 0)
-- Dependencies: 888
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 6431 (class 0 OID 0)
-- Dependencies: 890
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6432 (class 0 OID 0)
-- Dependencies: 892
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 6433 (class 0 OID 0)
-- Dependencies: 883
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 6434 (class 0 OID 0)
-- Dependencies: 885
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 6435 (class 0 OID 0)
-- Dependencies: 884
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 6436 (class 0 OID 0)
-- Dependencies: 886
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 6437 (class 0 OID 0)
-- Dependencies: 879
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 6438 (class 0 OID 0)
-- Dependencies: 881
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 6439 (class 0 OID 0)
-- Dependencies: 880
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 6440 (class 0 OID 0)
-- Dependencies: 882
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 6441 (class 0 OID 0)
-- Dependencies: 875
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 6442 (class 0 OID 0)
-- Dependencies: 877
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 6443 (class 0 OID 0)
-- Dependencies: 876
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 6444 (class 0 OID 0)
-- Dependencies: 878
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 6445 (class 0 OID 0)
-- Dependencies: 1671
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6446 (class 0 OID 0)
-- Dependencies: 1672
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6447 (class 0 OID 0)
-- Dependencies: 1115
-- Name: FUNCTION populate_geometry_columns(use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_geometry_columns(use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6448 (class 0 OID 0)
-- Dependencies: 1116
-- Name: FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6449 (class 0 OID 0)
-- Dependencies: 833
-- Name: FUNCTION populate_record(anyelement, extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_record(anyelement, extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6450 (class 0 OID 0)
-- Dependencies: 1003
-- Name: FUNCTION postgis_addbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_addbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6451 (class 0 OID 0)
-- Dependencies: 1072
-- Name: FUNCTION postgis_cache_bbox(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_cache_bbox() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6452 (class 0 OID 0)
-- Dependencies: 1551
-- Name: FUNCTION postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6453 (class 0 OID 0)
-- Dependencies: 1550
-- Name: FUNCTION postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6454 (class 0 OID 0)
-- Dependencies: 1552
-- Name: FUNCTION postgis_constraint_type(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6455 (class 0 OID 0)
-- Dependencies: 1004
-- Name: FUNCTION postgis_dropbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_dropbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6456 (class 0 OID 0)
-- Dependencies: 1153
-- Name: FUNCTION postgis_extensions_upgrade(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_extensions_upgrade() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6457 (class 0 OID 0)
-- Dependencies: 1154
-- Name: FUNCTION postgis_full_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_full_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6458 (class 0 OID 0)
-- Dependencies: 1054
-- Name: FUNCTION postgis_geos_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_geos_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6459 (class 0 OID 0)
-- Dependencies: 1145
-- Name: FUNCTION postgis_geos_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_geos_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6460 (class 0 OID 0)
-- Dependencies: 996
-- Name: FUNCTION postgis_getbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_getbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6461 (class 0 OID 0)
-- Dependencies: 1005
-- Name: FUNCTION postgis_hasbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_hasbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6462 (class 0 OID 0)
-- Dependencies: 1274
-- Name: FUNCTION postgis_index_supportfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_index_supportfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6463 (class 0 OID 0)
-- Dependencies: 1150
-- Name: FUNCTION postgis_lib_build_date(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_build_date() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6464 (class 0 OID 0)
-- Dependencies: 1146
-- Name: FUNCTION postgis_lib_revision(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_revision() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6465 (class 0 OID 0)
-- Dependencies: 1143
-- Name: FUNCTION postgis_lib_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6466 (class 0 OID 0)
-- Dependencies: 1313
-- Name: FUNCTION postgis_libjson_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libjson_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6467 (class 0 OID 0)
-- Dependencies: 1139
-- Name: FUNCTION postgis_liblwgeom_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_liblwgeom_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6468 (class 0 OID 0)
-- Dependencies: 1335
-- Name: FUNCTION postgis_libprotobuf_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libprotobuf_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6469 (class 0 OID 0)
-- Dependencies: 1148
-- Name: FUNCTION postgis_libxml_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libxml_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6470 (class 0 OID 0)
-- Dependencies: 1053
-- Name: FUNCTION postgis_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6471 (class 0 OID 0)
-- Dependencies: 1140
-- Name: FUNCTION postgis_proj_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_proj_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6472 (class 0 OID 0)
-- Dependencies: 1149
-- Name: FUNCTION postgis_scripts_build_date(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_build_date() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6473 (class 0 OID 0)
-- Dependencies: 1142
-- Name: FUNCTION postgis_scripts_installed(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_installed() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6474 (class 0 OID 0)
-- Dependencies: 1144
-- Name: FUNCTION postgis_scripts_released(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_released() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6475 (class 0 OID 0)
-- Dependencies: 1630
-- Name: FUNCTION postgis_sfcgal_full_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_sfcgal_full_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6476 (class 0 OID 0)
-- Dependencies: 1631
-- Name: FUNCTION postgis_sfcgal_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_sfcgal_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6477 (class 0 OID 0)
-- Dependencies: 1628
-- Name: FUNCTION postgis_sfcgal_scripts_installed(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_sfcgal_scripts_installed() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6478 (class 0 OID 0)
-- Dependencies: 1629
-- Name: FUNCTION postgis_sfcgal_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_sfcgal_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6479 (class 0 OID 0)
-- Dependencies: 1147
-- Name: FUNCTION postgis_svn_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_svn_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6480 (class 0 OID 0)
-- Dependencies: 1133
-- Name: FUNCTION postgis_transform_geometry(geom extensions.geometry, text, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_transform_geometry(geom extensions.geometry, text, text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6481 (class 0 OID 0)
-- Dependencies: 1549
-- Name: FUNCTION postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6482 (class 0 OID 0)
-- Dependencies: 1461
-- Name: FUNCTION postgis_typmod_dims(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_dims(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6483 (class 0 OID 0)
-- Dependencies: 1462
-- Name: FUNCTION postgis_typmod_srid(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_srid(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6484 (class 0 OID 0)
-- Dependencies: 1463
-- Name: FUNCTION postgis_typmod_type(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_type(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6485 (class 0 OID 0)
-- Dependencies: 1138
-- Name: FUNCTION postgis_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6486 (class 0 OID 0)
-- Dependencies: 1141
-- Name: FUNCTION postgis_wagyu_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_wagyu_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6488 (class 0 OID 0)
-- Dependencies: 1673
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 6489 (class 0 OID 0)
-- Dependencies: 901
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 6490 (class 0 OID 0)
-- Dependencies: 830
-- Name: FUNCTION skeys(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.skeys(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6491 (class 0 OID 0)
-- Dependencies: 804
-- Name: FUNCTION slice(extensions.hstore, text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.slice(extensions.hstore, text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6492 (class 0 OID 0)
-- Dependencies: 803
-- Name: FUNCTION slice_array(extensions.hstore, text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.slice_array(extensions.hstore, text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6493 (class 0 OID 0)
-- Dependencies: 1636
-- Name: FUNCTION st_3darea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3darea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6494 (class 0 OID 0)
-- Dependencies: 1555
-- Name: FUNCTION st_3dclosestpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dclosestpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6495 (class 0 OID 0)
-- Dependencies: 1648
-- Name: FUNCTION st_3dconvexhull(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dconvexhull(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6496 (class 0 OID 0)
-- Dependencies: 1288
-- Name: FUNCTION st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6497 (class 0 OID 0)
-- Dependencies: 1633
-- Name: FUNCTION st_3ddifference(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddifference(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6498 (class 0 OID 0)
-- Dependencies: 1553
-- Name: FUNCTION st_3ddistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6499 (class 0 OID 0)
-- Dependencies: 1287
-- Name: FUNCTION st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6500 (class 0 OID 0)
-- Dependencies: 1632
-- Name: FUNCTION st_3dintersection(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dintersection(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6501 (class 0 OID 0)
-- Dependencies: 1289
-- Name: FUNCTION st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6502 (class 0 OID 0)
-- Dependencies: 1011
-- Name: FUNCTION st_3dlength(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlength(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6503 (class 0 OID 0)
-- Dependencies: 1598
-- Name: FUNCTION st_3dlineinterpolatepoint(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlineinterpolatepoint(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6504 (class 0 OID 0)
-- Dependencies: 1557
-- Name: FUNCTION st_3dlongestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlongestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6505 (class 0 OID 0)
-- Dependencies: 1077
-- Name: FUNCTION st_3dmakebox(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dmakebox(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6506 (class 0 OID 0)
-- Dependencies: 1554
-- Name: FUNCTION st_3dmaxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dmaxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6507 (class 0 OID 0)
-- Dependencies: 1016
-- Name: FUNCTION st_3dperimeter(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dperimeter(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6508 (class 0 OID 0)
-- Dependencies: 1556
-- Name: FUNCTION st_3dshortestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dshortestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6509 (class 0 OID 0)
-- Dependencies: 1634
-- Name: FUNCTION st_3dunion(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dunion(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6510 (class 0 OID 0)
-- Dependencies: 1183
-- Name: FUNCTION st_addmeasure(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addmeasure(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6511 (class 0 OID 0)
-- Dependencies: 1081
-- Name: FUNCTION st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6512 (class 0 OID 0)
-- Dependencies: 1082
-- Name: FUNCTION st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6513 (class 0 OID 0)
-- Dependencies: 1097
-- Name: FUNCTION st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6514 (class 0 OID 0)
-- Dependencies: 1096
-- Name: FUNCTION st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6515 (class 0 OID 0)
-- Dependencies: 1649
-- Name: FUNCTION st_alphashape(g1 extensions.geometry, alpha double precision, allow_holes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_alphashape(g1 extensions.geometry, alpha double precision, allow_holes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6516 (class 0 OID 0)
-- Dependencies: 1597
-- Name: FUNCTION st_angle(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_angle(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6517 (class 0 OID 0)
-- Dependencies: 1028
-- Name: FUNCTION st_angle(pt1 extensions.geometry, pt2 extensions.geometry, pt3 extensions.geometry, pt4 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_angle(pt1 extensions.geometry, pt2 extensions.geometry, pt3 extensions.geometry, pt4 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6518 (class 0 OID 0)
-- Dependencies: 1642
-- Name: FUNCTION st_approximatemedialaxis(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_approximatemedialaxis(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6519 (class 0 OID 0)
-- Dependencies: 1020
-- Name: FUNCTION st_area(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6520 (class 0 OID 0)
-- Dependencies: 1506
-- Name: FUNCTION st_area(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6521 (class 0 OID 0)
-- Dependencies: 1505
-- Name: FUNCTION st_area(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6522 (class 0 OID 0)
-- Dependencies: 1019
-- Name: FUNCTION st_area2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6523 (class 0 OID 0)
-- Dependencies: 1524
-- Name: FUNCTION st_asbinary(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6524 (class 0 OID 0)
-- Dependencies: 1368
-- Name: FUNCTION st_asbinary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6525 (class 0 OID 0)
-- Dependencies: 1525
-- Name: FUNCTION st_asbinary(extensions.geography, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geography, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6526 (class 0 OID 0)
-- Dependencies: 1367
-- Name: FUNCTION st_asbinary(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6527 (class 0 OID 0)
-- Dependencies: 1315
-- Name: FUNCTION st_asencodedpolyline(geom extensions.geometry, nprecision integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asencodedpolyline(geom extensions.geometry, nprecision integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6528 (class 0 OID 0)
-- Dependencies: 1062
-- Name: FUNCTION st_asewkb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6529 (class 0 OID 0)
-- Dependencies: 1065
-- Name: FUNCTION st_asewkb(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkb(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6530 (class 0 OID 0)
-- Dependencies: 1526
-- Name: FUNCTION st_asewkt(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6531 (class 0 OID 0)
-- Dependencies: 1058
-- Name: FUNCTION st_asewkt(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6532 (class 0 OID 0)
-- Dependencies: 1528
-- Name: FUNCTION st_asewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6533 (class 0 OID 0)
-- Dependencies: 1527
-- Name: FUNCTION st_asewkt(extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6534 (class 0 OID 0)
-- Dependencies: 1059
-- Name: FUNCTION st_asewkt(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6535 (class 0 OID 0)
-- Dependencies: 1494
-- Name: FUNCTION st_asgeojson(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6536 (class 0 OID 0)
-- Dependencies: 1493
-- Name: FUNCTION st_asgeojson(geog extensions.geography, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(geog extensions.geography, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6537 (class 0 OID 0)
-- Dependencies: 1321
-- Name: FUNCTION st_asgeojson(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6538 (class 0 OID 0)
-- Dependencies: 1322
-- Name: FUNCTION st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6539 (class 0 OID 0)
-- Dependencies: 1490
-- Name: FUNCTION st_asgml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6540 (class 0 OID 0)
-- Dependencies: 1318
-- Name: FUNCTION st_asgml(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6541 (class 0 OID 0)
-- Dependencies: 1489
-- Name: FUNCTION st_asgml(geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6542 (class 0 OID 0)
-- Dependencies: 1488
-- Name: FUNCTION st_asgml(version integer, geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(version integer, geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6543 (class 0 OID 0)
-- Dependencies: 1319
-- Name: FUNCTION st_asgml(version integer, geom extensions.geometry, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(version integer, geom extensions.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6544 (class 0 OID 0)
-- Dependencies: 1063
-- Name: FUNCTION st_ashexewkb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ashexewkb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6545 (class 0 OID 0)
-- Dependencies: 1064
-- Name: FUNCTION st_ashexewkb(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ashexewkb(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6546 (class 0 OID 0)
-- Dependencies: 1492
-- Name: FUNCTION st_askml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6547 (class 0 OID 0)
-- Dependencies: 1491
-- Name: FUNCTION st_askml(geog extensions.geography, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(geog extensions.geography, maxdecimaldigits integer, nprefix text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6548 (class 0 OID 0)
-- Dependencies: 1320
-- Name: FUNCTION st_askml(geom extensions.geometry, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(geom extensions.geometry, maxdecimaldigits integer, nprefix text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6549 (class 0 OID 0)
-- Dependencies: 1066
-- Name: FUNCTION st_aslatlontext(geom extensions.geometry, tmpl text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_aslatlontext(geom extensions.geometry, tmpl text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6550 (class 0 OID 0)
-- Dependencies: 1309
-- Name: FUNCTION st_asmarc21(geom extensions.geometry, format text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmarc21(geom extensions.geometry, format text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6551 (class 0 OID 0)
-- Dependencies: 1334
-- Name: FUNCTION st_asmvtgeom(geom extensions.geometry, bounds extensions.box2d, extent integer, buffer integer, clip_geom boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvtgeom(geom extensions.geometry, bounds extensions.box2d, extent integer, buffer integer, clip_geom boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6552 (class 0 OID 0)
-- Dependencies: 1487
-- Name: FUNCTION st_assvg(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6553 (class 0 OID 0)
-- Dependencies: 1486
-- Name: FUNCTION st_assvg(geog extensions.geography, rel integer, maxdecimaldigits integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(geog extensions.geography, rel integer, maxdecimaldigits integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6554 (class 0 OID 0)
-- Dependencies: 1316
-- Name: FUNCTION st_assvg(geom extensions.geometry, rel integer, maxdecimaldigits integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(geom extensions.geometry, rel integer, maxdecimaldigits integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6555 (class 0 OID 0)
-- Dependencies: 1455
-- Name: FUNCTION st_astext(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6556 (class 0 OID 0)
-- Dependencies: 1369
-- Name: FUNCTION st_astext(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6557 (class 0 OID 0)
-- Dependencies: 1457
-- Name: FUNCTION st_astext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6558 (class 0 OID 0)
-- Dependencies: 1456
-- Name: FUNCTION st_astext(extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6559 (class 0 OID 0)
-- Dependencies: 1370
-- Name: FUNCTION st_astext(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6560 (class 0 OID 0)
-- Dependencies: 1060
-- Name: FUNCTION st_astwkb(geom extensions.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astwkb(geom extensions.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6561 (class 0 OID 0)
-- Dependencies: 1061
-- Name: FUNCTION st_astwkb(geom extensions.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astwkb(geom extensions.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6562 (class 0 OID 0)
-- Dependencies: 1596
-- Name: FUNCTION st_asx3d(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asx3d(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6563 (class 0 OID 0)
-- Dependencies: 1510
-- Name: FUNCTION st_azimuth(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_azimuth(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6564 (class 0 OID 0)
-- Dependencies: 1027
-- Name: FUNCTION st_azimuth(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_azimuth(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6565 (class 0 OID 0)
-- Dependencies: 1431
-- Name: FUNCTION st_bdmpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_bdmpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6566 (class 0 OID 0)
-- Dependencies: 1430
-- Name: FUNCTION st_bdpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_bdpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6567 (class 0 OID 0)
-- Dependencies: 1208
-- Name: FUNCTION st_boundary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_boundary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6568 (class 0 OID 0)
-- Dependencies: 1047
-- Name: FUNCTION st_boundingdiagonal(geom extensions.geometry, fits boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_boundingdiagonal(geom extensions.geometry, fits boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6569 (class 0 OID 0)
-- Dependencies: 1347
-- Name: FUNCTION st_box2dfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_box2dfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6570 (class 0 OID 0)
-- Dependencies: 1516
-- Name: FUNCTION st_buffer(extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6571 (class 0 OID 0)
-- Dependencies: 1519
-- Name: FUNCTION st_buffer(text, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6572 (class 0 OID 0)
-- Dependencies: 1517
-- Name: FUNCTION st_buffer(extensions.geography, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6573 (class 0 OID 0)
-- Dependencies: 1518
-- Name: FUNCTION st_buffer(extensions.geography, double precision, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6574 (class 0 OID 0)
-- Dependencies: 1190
-- Name: FUNCTION st_buffer(geom extensions.geometry, radius double precision, quadsegs integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(geom extensions.geometry, radius double precision, quadsegs integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6575 (class 0 OID 0)
-- Dependencies: 1189
-- Name: FUNCTION st_buffer(geom extensions.geometry, radius double precision, options text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(geom extensions.geometry, radius double precision, options text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6576 (class 0 OID 0)
-- Dependencies: 1520
-- Name: FUNCTION st_buffer(text, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6577 (class 0 OID 0)
-- Dependencies: 1521
-- Name: FUNCTION st_buffer(text, double precision, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6578 (class 0 OID 0)
-- Dependencies: 1089
-- Name: FUNCTION st_buildarea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buildarea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6579 (class 0 OID 0)
-- Dependencies: 1295
-- Name: FUNCTION st_centroid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6580 (class 0 OID 0)
-- Dependencies: 1535
-- Name: FUNCTION st_centroid(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6581 (class 0 OID 0)
-- Dependencies: 1534
-- Name: FUNCTION st_centroid(extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6582 (class 0 OID 0)
-- Dependencies: 1173
-- Name: FUNCTION st_chaikinsmoothing(extensions.geometry, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_chaikinsmoothing(extensions.geometry, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6583 (class 0 OID 0)
-- Dependencies: 1221
-- Name: FUNCTION st_cleangeometry(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_cleangeometry(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6584 (class 0 OID 0)
-- Dependencies: 1216
-- Name: FUNCTION st_clipbybox2d(geom extensions.geometry, box extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clipbybox2d(geom extensions.geometry, box extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6585 (class 0 OID 0)
-- Dependencies: 1424
-- Name: FUNCTION st_closestpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_closestpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6586 (class 0 OID 0)
-- Dependencies: 1184
-- Name: FUNCTION st_closestpointofapproach(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_closestpointofapproach(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6587 (class 0 OID 0)
-- Dependencies: 1093
-- Name: FUNCTION st_clusterdbscan(extensions.geometry, eps double precision, minpoints integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterdbscan(extensions.geometry, eps double precision, minpoints integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6588 (class 0 OID 0)
-- Dependencies: 1091
-- Name: FUNCTION st_clusterintersecting(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterintersecting(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6589 (class 0 OID 0)
-- Dependencies: 1252
-- Name: FUNCTION st_clusterkmeans(geom extensions.geometry, k integer, max_radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterkmeans(geom extensions.geometry, k integer, max_radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6590 (class 0 OID 0)
-- Dependencies: 1092
-- Name: FUNCTION st_clusterwithin(extensions.geometry[], double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterwithin(extensions.geometry[], double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6591 (class 0 OID 0)
-- Dependencies: 1236
-- Name: FUNCTION st_collect(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6592 (class 0 OID 0)
-- Dependencies: 1235
-- Name: FUNCTION st_collect(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6593 (class 0 OID 0)
-- Dependencies: 1036
-- Name: FUNCTION st_collectionextract(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionextract(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6594 (class 0 OID 0)
-- Dependencies: 1035
-- Name: FUNCTION st_collectionextract(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionextract(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6595 (class 0 OID 0)
-- Dependencies: 1037
-- Name: FUNCTION st_collectionhomogenize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionhomogenize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6596 (class 0 OID 0)
-- Dependencies: 1234
-- Name: FUNCTION st_combinebbox(extensions.box2d, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box2d, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6597 (class 0 OID 0)
-- Dependencies: 1233
-- Name: FUNCTION st_combinebbox(extensions.box3d, extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box3d, extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6598 (class 0 OID 0)
-- Dependencies: 1232
-- Name: FUNCTION st_combinebbox(extensions.box3d, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box3d, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6599 (class 0 OID 0)
-- Dependencies: 1594
-- Name: FUNCTION st_concavehull(param_geom extensions.geometry, param_pctconvex double precision, param_allow_holes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_concavehull(param_geom extensions.geometry, param_pctconvex double precision, param_allow_holes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6600 (class 0 OID 0)
-- Dependencies: 1647
-- Name: FUNCTION st_constraineddelaunaytriangles(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_constraineddelaunaytriangles(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6601 (class 0 OID 0)
-- Dependencies: 1280
-- Name: FUNCTION st_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6602 (class 0 OID 0)
-- Dependencies: 1281
-- Name: FUNCTION st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6603 (class 0 OID 0)
-- Dependencies: 1197
-- Name: FUNCTION st_convexhull(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_convexhull(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6604 (class 0 OID 0)
-- Dependencies: 1558
-- Name: FUNCTION st_coorddim(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coorddim(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6605 (class 0 OID 0)
-- Dependencies: 1541
-- Name: FUNCTION st_coveredby(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6606 (class 0 OID 0)
-- Dependencies: 1284
-- Name: FUNCTION st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6607 (class 0 OID 0)
-- Dependencies: 1544
-- Name: FUNCTION st_coveredby(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6608 (class 0 OID 0)
-- Dependencies: 1539
-- Name: FUNCTION st_covers(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6609 (class 0 OID 0)
-- Dependencies: 1283
-- Name: FUNCTION st_covers(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6610 (class 0 OID 0)
-- Dependencies: 1543
-- Name: FUNCTION st_covers(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6611 (class 0 OID 0)
-- Dependencies: 1186
-- Name: FUNCTION st_cpawithin(extensions.geometry, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_cpawithin(extensions.geometry, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6612 (class 0 OID 0)
-- Dependencies: 1279
-- Name: FUNCTION st_crosses(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_crosses(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6613 (class 0 OID 0)
-- Dependencies: 1559
-- Name: FUNCTION st_curvetoline(geom extensions.geometry, tol double precision, toltype integer, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_curvetoline(geom extensions.geometry, tol double precision, toltype integer, flags integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6614 (class 0 OID 0)
-- Dependencies: 1227
-- Name: FUNCTION st_delaunaytriangles(g1 extensions.geometry, tolerance double precision, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_delaunaytriangles(g1 extensions.geometry, tolerance double precision, flags integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6615 (class 0 OID 0)
-- Dependencies: 1286
-- Name: FUNCTION st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6616 (class 0 OID 0)
-- Dependencies: 1207
-- Name: FUNCTION st_difference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_difference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6617 (class 0 OID 0)
-- Dependencies: 1353
-- Name: FUNCTION st_dimension(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dimension(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6618 (class 0 OID 0)
-- Dependencies: 1256
-- Name: FUNCTION st_disjoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_disjoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6619 (class 0 OID 0)
-- Dependencies: 1025
-- Name: FUNCTION st_distance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6620 (class 0 OID 0)
-- Dependencies: 1496
-- Name: FUNCTION st_distance(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6621 (class 0 OID 0)
-- Dependencies: 1495
-- Name: FUNCTION st_distance(geog1 extensions.geography, geog2 extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(geog1 extensions.geography, geog2 extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6622 (class 0 OID 0)
-- Dependencies: 1185
-- Name: FUNCTION st_distancecpa(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancecpa(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6623 (class 0 OID 0)
-- Dependencies: 1547
-- Name: FUNCTION st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6624 (class 0 OID 0)
-- Dependencies: 1548
-- Name: FUNCTION st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry, radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry, radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6625 (class 0 OID 0)
-- Dependencies: 1024
-- Name: FUNCTION st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6626 (class 0 OID 0)
-- Dependencies: 1023
-- Name: FUNCTION st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6627 (class 0 OID 0)
-- Dependencies: 1111
-- Name: FUNCTION st_dump(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dump(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6628 (class 0 OID 0)
-- Dependencies: 1113
-- Name: FUNCTION st_dumppoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumppoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6629 (class 0 OID 0)
-- Dependencies: 1112
-- Name: FUNCTION st_dumprings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumprings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6630 (class 0 OID 0)
-- Dependencies: 1114
-- Name: FUNCTION st_dumpsegments(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumpsegments(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6631 (class 0 OID 0)
-- Dependencies: 1276
-- Name: FUNCTION st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6632 (class 0 OID 0)
-- Dependencies: 1545
-- Name: FUNCTION st_dwithin(text, text, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(text, text, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6633 (class 0 OID 0)
-- Dependencies: 1540
-- Name: FUNCTION st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6634 (class 0 OID 0)
-- Dependencies: 1364
-- Name: FUNCTION st_endpoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_endpoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6635 (class 0 OID 0)
-- Dependencies: 1046
-- Name: FUNCTION st_envelope(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_envelope(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6636 (class 0 OID 0)
-- Dependencies: 1291
-- Name: FUNCTION st_equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6637 (class 0 OID 0)
-- Dependencies: 1000
-- Name: FUNCTION st_estimatedextent(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6638 (class 0 OID 0)
-- Dependencies: 999
-- Name: FUNCTION st_estimatedextent(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6639 (class 0 OID 0)
-- Dependencies: 998
-- Name: FUNCTION st_estimatedextent(text, text, text, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text, text, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6640 (class 0 OID 0)
-- Dependencies: 994
-- Name: FUNCTION st_expand(extensions.box2d, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.box2d, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6641 (class 0 OID 0)
-- Dependencies: 1042
-- Name: FUNCTION st_expand(extensions.box3d, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.box3d, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6642 (class 0 OID 0)
-- Dependencies: 1044
-- Name: FUNCTION st_expand(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6643 (class 0 OID 0)
-- Dependencies: 995
-- Name: FUNCTION st_expand(box extensions.box2d, dx double precision, dy double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(box extensions.box2d, dx double precision, dy double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6644 (class 0 OID 0)
-- Dependencies: 1043
-- Name: FUNCTION st_expand(box extensions.box3d, dx double precision, dy double precision, dz double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(box extensions.box3d, dx double precision, dy double precision, dz double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6645 (class 0 OID 0)
-- Dependencies: 1045
-- Name: FUNCTION st_expand(geom extensions.geometry, dx double precision, dy double precision, dz double precision, dm double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(geom extensions.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6646 (class 0 OID 0)
-- Dependencies: 1354
-- Name: FUNCTION st_exteriorring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_exteriorring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6647 (class 0 OID 0)
-- Dependencies: 1637
-- Name: FUNCTION st_extrude(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_extrude(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6648 (class 0 OID 0)
-- Dependencies: 1172
-- Name: FUNCTION st_filterbym(extensions.geometry, double precision, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_filterbym(extensions.geometry, double precision, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6649 (class 0 OID 0)
-- Dependencies: 1002
-- Name: FUNCTION st_findextent(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_findextent(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6650 (class 0 OID 0)
-- Dependencies: 1001
-- Name: FUNCTION st_findextent(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_findextent(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6651 (class 0 OID 0)
-- Dependencies: 1429
-- Name: FUNCTION st_flipcoordinates(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_flipcoordinates(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6652 (class 0 OID 0)
-- Dependencies: 1029
-- Name: FUNCTION st_force2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6653 (class 0 OID 0)
-- Dependencies: 1031
-- Name: FUNCTION st_force3d(geom extensions.geometry, zvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3d(geom extensions.geometry, zvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6654 (class 0 OID 0)
-- Dependencies: 1032
-- Name: FUNCTION st_force3dm(geom extensions.geometry, mvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3dm(geom extensions.geometry, mvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6655 (class 0 OID 0)
-- Dependencies: 1030
-- Name: FUNCTION st_force3dz(geom extensions.geometry, zvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3dz(geom extensions.geometry, zvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6656 (class 0 OID 0)
-- Dependencies: 1033
-- Name: FUNCTION st_force4d(geom extensions.geometry, zvalue double precision, mvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force4d(geom extensions.geometry, zvalue double precision, mvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6657 (class 0 OID 0)
-- Dependencies: 1034
-- Name: FUNCTION st_forcecollection(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcecollection(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6658 (class 0 OID 0)
-- Dependencies: 1039
-- Name: FUNCTION st_forcecurve(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcecurve(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6659 (class 0 OID 0)
-- Dependencies: 1638
-- Name: FUNCTION st_forcelhr(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcelhr(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6660 (class 0 OID 0)
-- Dependencies: 1051
-- Name: FUNCTION st_forcepolygonccw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcepolygonccw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6661 (class 0 OID 0)
-- Dependencies: 1050
-- Name: FUNCTION st_forcepolygoncw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcepolygoncw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6662 (class 0 OID 0)
-- Dependencies: 1052
-- Name: FUNCTION st_forcerhr(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcerhr(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6663 (class 0 OID 0)
-- Dependencies: 1040
-- Name: FUNCTION st_forcesfs(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcesfs(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6664 (class 0 OID 0)
-- Dependencies: 1041
-- Name: FUNCTION st_forcesfs(extensions.geometry, version text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcesfs(extensions.geometry, version text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6665 (class 0 OID 0)
-- Dependencies: 1205
-- Name: FUNCTION st_frechetdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_frechetdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6666 (class 0 OID 0)
-- Dependencies: 1344
-- Name: FUNCTION st_fromflatgeobuf(anyelement, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_fromflatgeobuf(anyelement, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6667 (class 0 OID 0)
-- Dependencies: 1343
-- Name: FUNCTION st_fromflatgeobuftotable(text, text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_fromflatgeobuftotable(text, text, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6668 (class 0 OID 0)
-- Dependencies: 1195
-- Name: FUNCTION st_generatepoints(area extensions.geometry, npoints integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_generatepoints(area extensions.geometry, npoints integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6669 (class 0 OID 0)
-- Dependencies: 1196
-- Name: FUNCTION st_generatepoints(area extensions.geometry, npoints integer, seed integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_generatepoints(area extensions.geometry, npoints integer, seed integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6670 (class 0 OID 0)
-- Dependencies: 1459
-- Name: FUNCTION st_geogfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geogfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6671 (class 0 OID 0)
-- Dependencies: 1460
-- Name: FUNCTION st_geogfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geogfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6672 (class 0 OID 0)
-- Dependencies: 1458
-- Name: FUNCTION st_geographyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geographyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6673 (class 0 OID 0)
-- Dependencies: 1531
-- Name: FUNCTION st_geohash(geog extensions.geography, maxchars integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geohash(geog extensions.geography, maxchars integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6674 (class 0 OID 0)
-- Dependencies: 1345
-- Name: FUNCTION st_geohash(geom extensions.geometry, maxchars integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geohash(geom extensions.geometry, maxchars integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6675 (class 0 OID 0)
-- Dependencies: 1396
-- Name: FUNCTION st_geomcollfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6676 (class 0 OID 0)
-- Dependencies: 1395
-- Name: FUNCTION st_geomcollfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6677 (class 0 OID 0)
-- Dependencies: 1421
-- Name: FUNCTION st_geomcollfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6678 (class 0 OID 0)
-- Dependencies: 1420
-- Name: FUNCTION st_geomcollfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6679 (class 0 OID 0)
-- Dependencies: 1296
-- Name: FUNCTION st_geometricmedian(g extensions.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometricmedian(g extensions.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6680 (class 0 OID 0)
-- Dependencies: 1371
-- Name: FUNCTION st_geometryfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6681 (class 0 OID 0)
-- Dependencies: 1372
-- Name: FUNCTION st_geometryfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6682 (class 0 OID 0)
-- Dependencies: 1352
-- Name: FUNCTION st_geometryn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6683 (class 0 OID 0)
-- Dependencies: 1359
-- Name: FUNCTION st_geometrytype(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometrytype(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6684 (class 0 OID 0)
-- Dependencies: 1068
-- Name: FUNCTION st_geomfromewkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromewkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6685 (class 0 OID 0)
-- Dependencies: 1071
-- Name: FUNCTION st_geomfromewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromewkt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6686 (class 0 OID 0)
-- Dependencies: 1349
-- Name: FUNCTION st_geomfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6687 (class 0 OID 0)
-- Dependencies: 1311
-- Name: FUNCTION st_geomfromgeojson(json); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(json) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6688 (class 0 OID 0)
-- Dependencies: 1312
-- Name: FUNCTION st_geomfromgeojson(jsonb); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(jsonb) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6689 (class 0 OID 0)
-- Dependencies: 1310
-- Name: FUNCTION st_geomfromgeojson(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6690 (class 0 OID 0)
-- Dependencies: 1304
-- Name: FUNCTION st_geomfromgml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6691 (class 0 OID 0)
-- Dependencies: 1303
-- Name: FUNCTION st_geomfromgml(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgml(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6692 (class 0 OID 0)
-- Dependencies: 1307
-- Name: FUNCTION st_geomfromkml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromkml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6693 (class 0 OID 0)
-- Dependencies: 1308
-- Name: FUNCTION st_geomfrommarc21(marc21xml text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfrommarc21(marc21xml text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6694 (class 0 OID 0)
-- Dependencies: 1373
-- Name: FUNCTION st_geomfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6695 (class 0 OID 0)
-- Dependencies: 1374
-- Name: FUNCTION st_geomfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6696 (class 0 OID 0)
-- Dependencies: 1069
-- Name: FUNCTION st_geomfromtwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6697 (class 0 OID 0)
-- Dependencies: 1397
-- Name: FUNCTION st_geomfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6698 (class 0 OID 0)
-- Dependencies: 1398
-- Name: FUNCTION st_geomfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6699 (class 0 OID 0)
-- Dependencies: 1305
-- Name: FUNCTION st_gmltosql(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_gmltosql(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6700 (class 0 OID 0)
-- Dependencies: 1306
-- Name: FUNCTION st_gmltosql(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_gmltosql(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6701 (class 0 OID 0)
-- Dependencies: 1560
-- Name: FUNCTION st_hasarc(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hasarc(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6702 (class 0 OID 0)
-- Dependencies: 1203
-- Name: FUNCTION st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6703 (class 0 OID 0)
-- Dependencies: 1204
-- Name: FUNCTION st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6704 (class 0 OID 0)
-- Dependencies: 1573
-- Name: FUNCTION st_hexagon(size double precision, cell_i integer, cell_j integer, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hexagon(size double precision, cell_i integer, cell_j integer, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6705 (class 0 OID 0)
-- Dependencies: 1575
-- Name: FUNCTION st_hexagongrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hexagongrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6706 (class 0 OID 0)
-- Dependencies: 1357
-- Name: FUNCTION st_interiorringn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_interiorringn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6707 (class 0 OID 0)
-- Dependencies: 1572
-- Name: FUNCTION st_interpolatepoint(line extensions.geometry, point extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_interpolatepoint(line extensions.geometry, point extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6708 (class 0 OID 0)
-- Dependencies: 1522
-- Name: FUNCTION st_intersection(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6709 (class 0 OID 0)
-- Dependencies: 1523
-- Name: FUNCTION st_intersection(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6710 (class 0 OID 0)
-- Dependencies: 1188
-- Name: FUNCTION st_intersection(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6711 (class 0 OID 0)
-- Dependencies: 1542
-- Name: FUNCTION st_intersects(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6712 (class 0 OID 0)
-- Dependencies: 1278
-- Name: FUNCTION st_intersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6713 (class 0 OID 0)
-- Dependencies: 1546
-- Name: FUNCTION st_intersects(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6714 (class 0 OID 0)
-- Dependencies: 1365
-- Name: FUNCTION st_isclosed(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isclosed(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6715 (class 0 OID 0)
-- Dependencies: 1300
-- Name: FUNCTION st_iscollection(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_iscollection(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6716 (class 0 OID 0)
-- Dependencies: 1366
-- Name: FUNCTION st_isempty(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isempty(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6717 (class 0 OID 0)
-- Dependencies: 1643
-- Name: FUNCTION st_isplanar(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isplanar(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6718 (class 0 OID 0)
-- Dependencies: 1022
-- Name: FUNCTION st_ispolygonccw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ispolygonccw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6719 (class 0 OID 0)
-- Dependencies: 1021
-- Name: FUNCTION st_ispolygoncw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ispolygoncw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6720 (class 0 OID 0)
-- Dependencies: 1297
-- Name: FUNCTION st_isring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6721 (class 0 OID 0)
-- Dependencies: 1299
-- Name: FUNCTION st_issimple(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_issimple(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6722 (class 0 OID 0)
-- Dependencies: 1646
-- Name: FUNCTION st_issolid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_issolid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6723 (class 0 OID 0)
-- Dependencies: 1292
-- Name: FUNCTION st_isvalid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6724 (class 0 OID 0)
-- Dependencies: 1202
-- Name: FUNCTION st_isvalid(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalid(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6725 (class 0 OID 0)
-- Dependencies: 1200
-- Name: FUNCTION st_isvaliddetail(geom extensions.geometry, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvaliddetail(geom extensions.geometry, flags integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6726 (class 0 OID 0)
-- Dependencies: 1199
-- Name: FUNCTION st_isvalidreason(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidreason(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6727 (class 0 OID 0)
-- Dependencies: 1201
-- Name: FUNCTION st_isvalidreason(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidreason(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6728 (class 0 OID 0)
-- Dependencies: 1187
-- Name: FUNCTION st_isvalidtrajectory(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidtrajectory(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6729 (class 0 OID 0)
-- Dependencies: 1013
-- Name: FUNCTION st_length(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6730 (class 0 OID 0)
-- Dependencies: 1508
-- Name: FUNCTION st_length(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6731 (class 0 OID 0)
-- Dependencies: 1507
-- Name: FUNCTION st_length(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6732 (class 0 OID 0)
-- Dependencies: 1012
-- Name: FUNCTION st_length2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6733 (class 0 OID 0)
-- Dependencies: 1015
-- Name: FUNCTION st_length2dspheroid(extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length2dspheroid(extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6734 (class 0 OID 0)
-- Dependencies: 1014
-- Name: FUNCTION st_lengthspheroid(extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lengthspheroid(extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6735 (class 0 OID 0)
-- Dependencies: 1627
-- Name: FUNCTION st_letters(letters text, font json); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_letters(letters text, font json) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6736 (class 0 OID 0)
-- Dependencies: 1275
-- Name: FUNCTION st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6737 (class 0 OID 0)
-- Dependencies: 1314
-- Name: FUNCTION st_linefromencodedpolyline(txtin text, nprecision integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromencodedpolyline(txtin text, nprecision integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6738 (class 0 OID 0)
-- Dependencies: 1079
-- Name: FUNCTION st_linefrommultipoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefrommultipoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6739 (class 0 OID 0)
-- Dependencies: 1378
-- Name: FUNCTION st_linefromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6740 (class 0 OID 0)
-- Dependencies: 1379
-- Name: FUNCTION st_linefromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6741 (class 0 OID 0)
-- Dependencies: 1402
-- Name: FUNCTION st_linefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6742 (class 0 OID 0)
-- Dependencies: 1401
-- Name: FUNCTION st_linefromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6743 (class 0 OID 0)
-- Dependencies: 1179
-- Name: FUNCTION st_lineinterpolatepoint(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lineinterpolatepoint(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6744 (class 0 OID 0)
-- Dependencies: 1180
-- Name: FUNCTION st_lineinterpolatepoints(extensions.geometry, double precision, repeat boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lineinterpolatepoints(extensions.geometry, double precision, repeat boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6745 (class 0 OID 0)
-- Dependencies: 1182
-- Name: FUNCTION st_linelocatepoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linelocatepoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6746 (class 0 OID 0)
-- Dependencies: 1094
-- Name: FUNCTION st_linemerge(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linemerge(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6747 (class 0 OID 0)
-- Dependencies: 1095
-- Name: FUNCTION st_linemerge(extensions.geometry, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linemerge(extensions.geometry, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6748 (class 0 OID 0)
-- Dependencies: 1404
-- Name: FUNCTION st_linestringfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linestringfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6749 (class 0 OID 0)
-- Dependencies: 1403
-- Name: FUNCTION st_linestringfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linestringfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6750 (class 0 OID 0)
-- Dependencies: 1181
-- Name: FUNCTION st_linesubstring(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linesubstring(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6751 (class 0 OID 0)
-- Dependencies: 1561
-- Name: FUNCTION st_linetocurve(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linetocurve(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6752 (class 0 OID 0)
-- Dependencies: 1570
-- Name: FUNCTION st_locatealong(geometry extensions.geometry, measure double precision, leftrightoffset double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatealong(geometry extensions.geometry, measure double precision, leftrightoffset double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6753 (class 0 OID 0)
-- Dependencies: 1569
-- Name: FUNCTION st_locatebetween(geometry extensions.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatebetween(geometry extensions.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6754 (class 0 OID 0)
-- Dependencies: 1571
-- Name: FUNCTION st_locatebetweenelevations(geometry extensions.geometry, fromelevation double precision, toelevation double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatebetweenelevations(geometry extensions.geometry, fromelevation double precision, toelevation double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6755 (class 0 OID 0)
-- Dependencies: 1427
-- Name: FUNCTION st_longestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_longestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6756 (class 0 OID 0)
-- Dependencies: 924
-- Name: FUNCTION st_m(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_m(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6757 (class 0 OID 0)
-- Dependencies: 997
-- Name: FUNCTION st_makebox2d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makebox2d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6758 (class 0 OID 0)
-- Dependencies: 1085
-- Name: FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6759 (class 0 OID 0)
-- Dependencies: 1078
-- Name: FUNCTION st_makeline(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6760 (class 0 OID 0)
-- Dependencies: 1080
-- Name: FUNCTION st_makeline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6761 (class 0 OID 0)
-- Dependencies: 1073
-- Name: FUNCTION st_makepoint(double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6762 (class 0 OID 0)
-- Dependencies: 1074
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6763 (class 0 OID 0)
-- Dependencies: 1075
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6764 (class 0 OID 0)
-- Dependencies: 1076
-- Name: FUNCTION st_makepointm(double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepointm(double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6765 (class 0 OID 0)
-- Dependencies: 1088
-- Name: FUNCTION st_makepolygon(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepolygon(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6766 (class 0 OID 0)
-- Dependencies: 1087
-- Name: FUNCTION st_makepolygon(extensions.geometry, extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepolygon(extensions.geometry, extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6767 (class 0 OID 0)
-- Dependencies: 1645
-- Name: FUNCTION st_makesolid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makesolid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6768 (class 0 OID 0)
-- Dependencies: 1219
-- Name: FUNCTION st_makevalid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makevalid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6769 (class 0 OID 0)
-- Dependencies: 1220
-- Name: FUNCTION st_makevalid(geom extensions.geometry, params text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makevalid(geom extensions.geometry, params text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6770 (class 0 OID 0)
-- Dependencies: 1423
-- Name: FUNCTION st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6771 (class 0 OID 0)
-- Dependencies: 1206
-- Name: FUNCTION st_maximuminscribedcircle(extensions.geometry, OUT center extensions.geometry, OUT nearest extensions.geometry, OUT radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_maximuminscribedcircle(extensions.geometry, OUT center extensions.geometry, OUT nearest extensions.geometry, OUT radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6772 (class 0 OID 0)
-- Dependencies: 1007
-- Name: FUNCTION st_memsize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memsize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6773 (class 0 OID 0)
-- Dependencies: 1192
-- Name: FUNCTION st_minimumboundingcircle(inputgeom extensions.geometry, segs_per_quarter integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumboundingcircle(inputgeom extensions.geometry, segs_per_quarter integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6774 (class 0 OID 0)
-- Dependencies: 1191
-- Name: FUNCTION st_minimumboundingradius(extensions.geometry, OUT center extensions.geometry, OUT radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumboundingradius(extensions.geometry, OUT center extensions.geometry, OUT radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6775 (class 0 OID 0)
-- Dependencies: 1293
-- Name: FUNCTION st_minimumclearance(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumclearance(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6776 (class 0 OID 0)
-- Dependencies: 1294
-- Name: FUNCTION st_minimumclearanceline(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumclearanceline(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6777 (class 0 OID 0)
-- Dependencies: 1640
-- Name: FUNCTION st_minkowskisum(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minkowskisum(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6778 (class 0 OID 0)
-- Dependencies: 1385
-- Name: FUNCTION st_mlinefromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6779 (class 0 OID 0)
-- Dependencies: 1384
-- Name: FUNCTION st_mlinefromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6780 (class 0 OID 0)
-- Dependencies: 1415
-- Name: FUNCTION st_mlinefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6781 (class 0 OID 0)
-- Dependencies: 1414
-- Name: FUNCTION st_mlinefromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6782 (class 0 OID 0)
-- Dependencies: 1389
-- Name: FUNCTION st_mpointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6783 (class 0 OID 0)
-- Dependencies: 1388
-- Name: FUNCTION st_mpointfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6784 (class 0 OID 0)
-- Dependencies: 1410
-- Name: FUNCTION st_mpointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6785 (class 0 OID 0)
-- Dependencies: 1409
-- Name: FUNCTION st_mpointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6786 (class 0 OID 0)
-- Dependencies: 1392
-- Name: FUNCTION st_mpolyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6787 (class 0 OID 0)
-- Dependencies: 1391
-- Name: FUNCTION st_mpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6788 (class 0 OID 0)
-- Dependencies: 1417
-- Name: FUNCTION st_mpolyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6789 (class 0 OID 0)
-- Dependencies: 1416
-- Name: FUNCTION st_mpolyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6790 (class 0 OID 0)
-- Dependencies: 1038
-- Name: FUNCTION st_multi(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multi(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6791 (class 0 OID 0)
-- Dependencies: 1413
-- Name: FUNCTION st_multilinefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6792 (class 0 OID 0)
-- Dependencies: 1386
-- Name: FUNCTION st_multilinestringfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinestringfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6793 (class 0 OID 0)
-- Dependencies: 1387
-- Name: FUNCTION st_multilinestringfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinestringfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6794 (class 0 OID 0)
-- Dependencies: 1390
-- Name: FUNCTION st_multipointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6795 (class 0 OID 0)
-- Dependencies: 1412
-- Name: FUNCTION st_multipointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6796 (class 0 OID 0)
-- Dependencies: 1411
-- Name: FUNCTION st_multipointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6797 (class 0 OID 0)
-- Dependencies: 1419
-- Name: FUNCTION st_multipolyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6798 (class 0 OID 0)
-- Dependencies: 1418
-- Name: FUNCTION st_multipolyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6799 (class 0 OID 0)
-- Dependencies: 1394
-- Name: FUNCTION st_multipolygonfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolygonfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6800 (class 0 OID 0)
-- Dependencies: 1393
-- Name: FUNCTION st_multipolygonfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolygonfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6801 (class 0 OID 0)
-- Dependencies: 1057
-- Name: FUNCTION st_ndims(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ndims(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6802 (class 0 OID 0)
-- Dependencies: 1226
-- Name: FUNCTION st_node(g extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_node(g extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6803 (class 0 OID 0)
-- Dependencies: 1055
-- Name: FUNCTION st_normalize(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_normalize(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6804 (class 0 OID 0)
-- Dependencies: 1009
-- Name: FUNCTION st_npoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_npoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6805 (class 0 OID 0)
-- Dependencies: 1010
-- Name: FUNCTION st_nrings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_nrings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6806 (class 0 OID 0)
-- Dependencies: 1351
-- Name: FUNCTION st_numgeometries(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numgeometries(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6807 (class 0 OID 0)
-- Dependencies: 1356
-- Name: FUNCTION st_numinteriorring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numinteriorring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6808 (class 0 OID 0)
-- Dependencies: 1355
-- Name: FUNCTION st_numinteriorrings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numinteriorrings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6809 (class 0 OID 0)
-- Dependencies: 1361
-- Name: FUNCTION st_numpatches(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numpatches(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6810 (class 0 OID 0)
-- Dependencies: 1350
-- Name: FUNCTION st_numpoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numpoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6811 (class 0 OID 0)
-- Dependencies: 1194
-- Name: FUNCTION st_offsetcurve(line extensions.geometry, distance double precision, params text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_offsetcurve(line extensions.geometry, distance double precision, params text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6812 (class 0 OID 0)
-- Dependencies: 1650
-- Name: FUNCTION st_optimalalphashape(g1 extensions.geometry, allow_holes boolean, nb_components integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_optimalalphashape(g1 extensions.geometry, allow_holes boolean, nb_components integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6813 (class 0 OID 0)
-- Dependencies: 1290
-- Name: FUNCTION st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6814 (class 0 OID 0)
-- Dependencies: 1639
-- Name: FUNCTION st_orientation(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orientation(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6815 (class 0 OID 0)
-- Dependencies: 1193
-- Name: FUNCTION st_orientedenvelope(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orientedenvelope(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6816 (class 0 OID 0)
-- Dependencies: 1285
-- Name: FUNCTION st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6817 (class 0 OID 0)
-- Dependencies: 1362
-- Name: FUNCTION st_patchn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_patchn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6818 (class 0 OID 0)
-- Dependencies: 1018
-- Name: FUNCTION st_perimeter(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6819 (class 0 OID 0)
-- Dependencies: 1511
-- Name: FUNCTION st_perimeter(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6820 (class 0 OID 0)
-- Dependencies: 1017
-- Name: FUNCTION st_perimeter2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6821 (class 0 OID 0)
-- Dependencies: 1562
-- Name: FUNCTION st_point(double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_point(double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6822 (class 0 OID 0)
-- Dependencies: 1563
-- Name: FUNCTION st_point(double precision, double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_point(double precision, double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6823 (class 0 OID 0)
-- Dependencies: 1348
-- Name: FUNCTION st_pointfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6824 (class 0 OID 0)
-- Dependencies: 1376
-- Name: FUNCTION st_pointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6825 (class 0 OID 0)
-- Dependencies: 1377
-- Name: FUNCTION st_pointfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6826 (class 0 OID 0)
-- Dependencies: 1400
-- Name: FUNCTION st_pointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6827 (class 0 OID 0)
-- Dependencies: 1399
-- Name: FUNCTION st_pointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6828 (class 0 OID 0)
-- Dependencies: 1026
-- Name: FUNCTION st_pointinsidecircle(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointinsidecircle(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6829 (class 0 OID 0)
-- Dependencies: 1565
-- Name: FUNCTION st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6830 (class 0 OID 0)
-- Dependencies: 1360
-- Name: FUNCTION st_pointn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6831 (class 0 OID 0)
-- Dependencies: 1298
-- Name: FUNCTION st_pointonsurface(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointonsurface(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6832 (class 0 OID 0)
-- Dependencies: 1209
-- Name: FUNCTION st_points(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_points(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6833 (class 0 OID 0)
-- Dependencies: 1564
-- Name: FUNCTION st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6834 (class 0 OID 0)
-- Dependencies: 1566
-- Name: FUNCTION st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6835 (class 0 OID 0)
-- Dependencies: 1380
-- Name: FUNCTION st_polyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6836 (class 0 OID 0)
-- Dependencies: 1381
-- Name: FUNCTION st_polyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6837 (class 0 OID 0)
-- Dependencies: 1406
-- Name: FUNCTION st_polyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6838 (class 0 OID 0)
-- Dependencies: 1405
-- Name: FUNCTION st_polyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6839 (class 0 OID 0)
-- Dependencies: 1567
-- Name: FUNCTION st_polygon(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygon(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6840 (class 0 OID 0)
-- Dependencies: 1383
-- Name: FUNCTION st_polygonfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6841 (class 0 OID 0)
-- Dependencies: 1382
-- Name: FUNCTION st_polygonfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6842 (class 0 OID 0)
-- Dependencies: 1408
-- Name: FUNCTION st_polygonfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6843 (class 0 OID 0)
-- Dependencies: 1407
-- Name: FUNCTION st_polygonfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6844 (class 0 OID 0)
-- Dependencies: 1090
-- Name: FUNCTION st_polygonize(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonize(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6845 (class 0 OID 0)
-- Dependencies: 1509
-- Name: FUNCTION st_project(geog extensions.geography, distance double precision, azimuth double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_project(geog extensions.geography, distance double precision, azimuth double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6846 (class 0 OID 0)
-- Dependencies: 1006
-- Name: FUNCTION st_quantizecoordinates(g extensions.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_quantizecoordinates(g extensions.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6847 (class 0 OID 0)
-- Dependencies: 1218
-- Name: FUNCTION st_reduceprecision(geom extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_reduceprecision(geom extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6848 (class 0 OID 0)
-- Dependencies: 1253
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6849 (class 0 OID 0)
-- Dependencies: 1254
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6850 (class 0 OID 0)
-- Dependencies: 1255
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6851 (class 0 OID 0)
-- Dependencies: 1225
-- Name: FUNCTION st_relatematch(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relatematch(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6852 (class 0 OID 0)
-- Dependencies: 1083
-- Name: FUNCTION st_removepoint(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_removepoint(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6853 (class 0 OID 0)
-- Dependencies: 1215
-- Name: FUNCTION st_removerepeatedpoints(geom extensions.geometry, tolerance double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_removerepeatedpoints(geom extensions.geometry, tolerance double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6854 (class 0 OID 0)
-- Dependencies: 1048
-- Name: FUNCTION st_reverse(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_reverse(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6855 (class 0 OID 0)
-- Dependencies: 1098
-- Name: FUNCTION st_rotate(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6856 (class 0 OID 0)
-- Dependencies: 1100
-- Name: FUNCTION st_rotate(extensions.geometry, double precision, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6857 (class 0 OID 0)
-- Dependencies: 1099
-- Name: FUNCTION st_rotate(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6858 (class 0 OID 0)
-- Dependencies: 1102
-- Name: FUNCTION st_rotatex(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatex(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6859 (class 0 OID 0)
-- Dependencies: 1103
-- Name: FUNCTION st_rotatey(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatey(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6860 (class 0 OID 0)
-- Dependencies: 1101
-- Name: FUNCTION st_rotatez(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatez(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6861 (class 0 OID 0)
-- Dependencies: 1106
-- Name: FUNCTION st_scale(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6862 (class 0 OID 0)
-- Dependencies: 1107
-- Name: FUNCTION st_scale(extensions.geometry, extensions.geometry, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, extensions.geometry, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6863 (class 0 OID 0)
-- Dependencies: 1109
-- Name: FUNCTION st_scale(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6864 (class 0 OID 0)
-- Dependencies: 1108
-- Name: FUNCTION st_scale(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6865 (class 0 OID 0)
-- Dependencies: 1049
-- Name: FUNCTION st_scroll(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scroll(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6866 (class 0 OID 0)
-- Dependencies: 1513
-- Name: FUNCTION st_segmentize(geog extensions.geography, max_segment_length double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_segmentize(geog extensions.geography, max_segment_length double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6867 (class 0 OID 0)
-- Dependencies: 1178
-- Name: FUNCTION st_segmentize(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_segmentize(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6868 (class 0 OID 0)
-- Dependencies: 1171
-- Name: FUNCTION st_seteffectivearea(extensions.geometry, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_seteffectivearea(extensions.geometry, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6869 (class 0 OID 0)
-- Dependencies: 1084
-- Name: FUNCTION st_setpoint(extensions.geometry, integer, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setpoint(extensions.geometry, integer, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6870 (class 0 OID 0)
-- Dependencies: 1533
-- Name: FUNCTION st_setsrid(geog extensions.geography, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setsrid(geog extensions.geography, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6871 (class 0 OID 0)
-- Dependencies: 1131
-- Name: FUNCTION st_setsrid(geom extensions.geometry, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setsrid(geom extensions.geometry, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6872 (class 0 OID 0)
-- Dependencies: 1223
-- Name: FUNCTION st_sharedpaths(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_sharedpaths(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6873 (class 0 OID 0)
-- Dependencies: 986
-- Name: FUNCTION st_shiftlongitude(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_shiftlongitude(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6874 (class 0 OID 0)
-- Dependencies: 1425
-- Name: FUNCTION st_shortestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_shortestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6875 (class 0 OID 0)
-- Dependencies: 1168
-- Name: FUNCTION st_simplify(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplify(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6876 (class 0 OID 0)
-- Dependencies: 1169
-- Name: FUNCTION st_simplify(extensions.geometry, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplify(extensions.geometry, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6877 (class 0 OID 0)
-- Dependencies: 1592
-- Name: FUNCTION st_simplifypolygonhull(geom extensions.geometry, vertex_fraction double precision, is_outer boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifypolygonhull(geom extensions.geometry, vertex_fraction double precision, is_outer boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6878 (class 0 OID 0)
-- Dependencies: 1198
-- Name: FUNCTION st_simplifypreservetopology(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifypreservetopology(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6879 (class 0 OID 0)
-- Dependencies: 1170
-- Name: FUNCTION st_simplifyvw(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifyvw(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6880 (class 0 OID 0)
-- Dependencies: 1224
-- Name: FUNCTION st_snap(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snap(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6881 (class 0 OID 0)
-- Dependencies: 1176
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6882 (class 0 OID 0)
-- Dependencies: 1175
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6883 (class 0 OID 0)
-- Dependencies: 1174
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6884 (class 0 OID 0)
-- Dependencies: 1177
-- Name: FUNCTION st_snaptogrid(geom1 extensions.geometry, geom2 extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(geom1 extensions.geometry, geom2 extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6885 (class 0 OID 0)
-- Dependencies: 1222
-- Name: FUNCTION st_split(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_split(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6886 (class 0 OID 0)
-- Dependencies: 1574
-- Name: FUNCTION st_square(size double precision, cell_i integer, cell_j integer, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_square(size double precision, cell_i integer, cell_j integer, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6887 (class 0 OID 0)
-- Dependencies: 1576
-- Name: FUNCTION st_squaregrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_squaregrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6888 (class 0 OID 0)
-- Dependencies: 1532
-- Name: FUNCTION st_srid(geog extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_srid(geog extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6889 (class 0 OID 0)
-- Dependencies: 1132
-- Name: FUNCTION st_srid(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_srid(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6890 (class 0 OID 0)
-- Dependencies: 1363
-- Name: FUNCTION st_startpoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_startpoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6891 (class 0 OID 0)
-- Dependencies: 1641
-- Name: FUNCTION st_straightskeleton(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_straightskeleton(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6892 (class 0 OID 0)
-- Dependencies: 1217
-- Name: FUNCTION st_subdivide(geom extensions.geometry, maxvertices integer, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_subdivide(geom extensions.geometry, maxvertices integer, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6893 (class 0 OID 0)
-- Dependencies: 1530
-- Name: FUNCTION st_summary(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_summary(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6894 (class 0 OID 0)
-- Dependencies: 1008
-- Name: FUNCTION st_summary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_summary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6895 (class 0 OID 0)
-- Dependencies: 1428
-- Name: FUNCTION st_swapordinates(geom extensions.geometry, ords cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_swapordinates(geom extensions.geometry, ords cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6896 (class 0 OID 0)
-- Dependencies: 1210
-- Name: FUNCTION st_symdifference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_symdifference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6897 (class 0 OID 0)
-- Dependencies: 1211
-- Name: FUNCTION st_symmetricdifference(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_symmetricdifference(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6898 (class 0 OID 0)
-- Dependencies: 1635
-- Name: FUNCTION st_tesselate(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_tesselate(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6899 (class 0 OID 0)
-- Dependencies: 1086
-- Name: FUNCTION st_tileenvelope(zoom integer, x integer, y integer, bounds extensions.geometry, margin double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_tileenvelope(zoom integer, x integer, y integer, bounds extensions.geometry, margin double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6900 (class 0 OID 0)
-- Dependencies: 1277
-- Name: FUNCTION st_touches(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_touches(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6901 (class 0 OID 0)
-- Dependencies: 1134
-- Name: FUNCTION st_transform(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6902 (class 0 OID 0)
-- Dependencies: 1135
-- Name: FUNCTION st_transform(geom extensions.geometry, to_proj text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, to_proj text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6903 (class 0 OID 0)
-- Dependencies: 1137
-- Name: FUNCTION st_transform(geom extensions.geometry, from_proj text, to_srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, from_proj text, to_srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6904 (class 0 OID 0)
-- Dependencies: 1136
-- Name: FUNCTION st_transform(geom extensions.geometry, from_proj text, to_proj text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, from_proj text, to_proj text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6905 (class 0 OID 0)
-- Dependencies: 1105
-- Name: FUNCTION st_translate(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_translate(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6906 (class 0 OID 0)
-- Dependencies: 1104
-- Name: FUNCTION st_translate(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_translate(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6907 (class 0 OID 0)
-- Dependencies: 1110
-- Name: FUNCTION st_transscale(extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transscale(extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6908 (class 0 OID 0)
-- Dependencies: 1228
-- Name: FUNCTION st_triangulatepolygon(g1 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_triangulatepolygon(g1 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6909 (class 0 OID 0)
-- Dependencies: 1214
-- Name: FUNCTION st_unaryunion(extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_unaryunion(extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6910 (class 0 OID 0)
-- Dependencies: 1251
-- Name: FUNCTION st_union(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6911 (class 0 OID 0)
-- Dependencies: 1212
-- Name: FUNCTION st_union(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6912 (class 0 OID 0)
-- Dependencies: 1213
-- Name: FUNCTION st_union(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6913 (class 0 OID 0)
-- Dependencies: 1644
-- Name: FUNCTION st_volume(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_volume(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6914 (class 0 OID 0)
-- Dependencies: 1231
-- Name: FUNCTION st_voronoilines(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_voronoilines(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6915 (class 0 OID 0)
-- Dependencies: 1230
-- Name: FUNCTION st_voronoipolygons(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_voronoipolygons(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6916 (class 0 OID 0)
-- Dependencies: 1282
-- Name: FUNCTION st_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6917 (class 0 OID 0)
-- Dependencies: 1568
-- Name: FUNCTION st_wkbtosql(wkb bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wkbtosql(wkb bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6918 (class 0 OID 0)
-- Dependencies: 1375
-- Name: FUNCTION st_wkttosql(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wkttosql(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6919 (class 0 OID 0)
-- Dependencies: 987
-- Name: FUNCTION st_wrapx(geom extensions.geometry, wrap double precision, move double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wrapx(geom extensions.geometry, wrap double precision, move double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6920 (class 0 OID 0)
-- Dependencies: 921
-- Name: FUNCTION st_x(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_x(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6921 (class 0 OID 0)
-- Dependencies: 991
-- Name: FUNCTION st_xmax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_xmax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6922 (class 0 OID 0)
-- Dependencies: 988
-- Name: FUNCTION st_xmin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_xmin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6923 (class 0 OID 0)
-- Dependencies: 922
-- Name: FUNCTION st_y(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_y(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6924 (class 0 OID 0)
-- Dependencies: 992
-- Name: FUNCTION st_ymax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ymax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6925 (class 0 OID 0)
-- Dependencies: 989
-- Name: FUNCTION st_ymin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ymin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6926 (class 0 OID 0)
-- Dependencies: 923
-- Name: FUNCTION st_z(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_z(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6927 (class 0 OID 0)
-- Dependencies: 993
-- Name: FUNCTION st_zmax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6928 (class 0 OID 0)
-- Dependencies: 1056
-- Name: FUNCTION st_zmflag(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmflag(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6929 (class 0 OID 0)
-- Dependencies: 990
-- Name: FUNCTION st_zmin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6930 (class 0 OID 0)
-- Dependencies: 831
-- Name: FUNCTION svals(extensions.hstore); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.svals(extensions.hstore) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6931 (class 0 OID 0)
-- Dependencies: 817
-- Name: FUNCTION tconvert(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.tconvert(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6932 (class 0 OID 0)
-- Dependencies: 903
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- TOC entry 6933 (class 0 OID 0)
-- Dependencies: 1432
-- Name: FUNCTION unlockrows(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.unlockrows(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6934 (class 0 OID 0)
-- Dependencies: 1128
-- Name: FUNCTION updategeometrysrid(character varying, character varying, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(character varying, character varying, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6935 (class 0 OID 0)
-- Dependencies: 1127
-- Name: FUNCTION updategeometrysrid(character varying, character varying, character varying, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(character varying, character varying, character varying, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6936 (class 0 OID 0)
-- Dependencies: 1126
-- Name: FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6937 (class 0 OID 0)
-- Dependencies: 899
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- TOC entry 6938 (class 0 OID 0)
-- Dependencies: 898
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- TOC entry 6939 (class 0 OID 0)
-- Dependencies: 1659
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 6940 (class 0 OID 0)
-- Dependencies: 1660
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 6941 (class 0 OID 0)
-- Dependencies: 1661
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 6942 (class 0 OID 0)
-- Dependencies: 1662
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 6943 (class 0 OID 0)
-- Dependencies: 1663
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 6944 (class 0 OID 0)
-- Dependencies: 1654
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 6945 (class 0 OID 0)
-- Dependencies: 1655
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 6946 (class 0 OID 0)
-- Dependencies: 1657
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 6947 (class 0 OID 0)
-- Dependencies: 1656
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 6948 (class 0 OID 0)
-- Dependencies: 1658
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 6949 (class 0 OID 0)
-- Dependencies: 902
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 6950 (class 0 OID 0)
-- Dependencies: 1691
-- Name: FUNCTION comment_directive(comment_ text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO postgres;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO anon;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO authenticated;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO service_role;


--
-- TOC entry 6951 (class 0 OID 0)
-- Dependencies: 1690
-- Name: FUNCTION exception(message text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.exception(message text) TO postgres;
GRANT ALL ON FUNCTION graphql.exception(message text) TO anon;
GRANT ALL ON FUNCTION graphql.exception(message text) TO authenticated;
GRANT ALL ON FUNCTION graphql.exception(message text) TO service_role;


--
-- TOC entry 6952 (class 0 OID 0)
-- Dependencies: 1689
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 6953 (class 0 OID 0)
-- Dependencies: 1703
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- TOC entry 6954 (class 0 OID 0)
-- Dependencies: 1704
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- TOC entry 6955 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION lo_export(oid, text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_export(oid, text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_export(oid, text) TO supabase_admin;


--
-- TOC entry 6956 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION lo_import(text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text) TO supabase_admin;


--
-- TOC entry 6957 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION lo_import(text, oid); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text, oid) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text, oid) TO supabase_admin;


--
-- TOC entry 6958 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- TOC entry 6959 (class 0 OID 0)
-- Dependencies: 763
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- TOC entry 6960 (class 0 OID 0)
-- Dependencies: 762
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- TOC entry 6961 (class 0 OID 0)
-- Dependencies: 745
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- TOC entry 6962 (class 0 OID 0)
-- Dependencies: 617
-- Name: FUNCTION add_compression_policy(hypertable regclass, compress_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_compression_policy(hypertable regclass, compress_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO postgres;
GRANT ALL ON FUNCTION public.add_compression_policy(hypertable regclass, compress_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO anon;
GRANT ALL ON FUNCTION public.add_compression_policy(hypertable regclass, compress_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO authenticated;
GRANT ALL ON FUNCTION public.add_compression_policy(hypertable regclass, compress_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO service_role;


--
-- TOC entry 6963 (class 0 OID 0)
-- Dependencies: 619
-- Name: FUNCTION add_continuous_aggregate_policy(continuous_aggregate regclass, start_offset "any", end_offset "any", schedule_interval interval, if_not_exists boolean, initial_start timestamp with time zone, timezone text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_continuous_aggregate_policy(continuous_aggregate regclass, start_offset "any", end_offset "any", schedule_interval interval, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO postgres;
GRANT ALL ON FUNCTION public.add_continuous_aggregate_policy(continuous_aggregate regclass, start_offset "any", end_offset "any", schedule_interval interval, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO anon;
GRANT ALL ON FUNCTION public.add_continuous_aggregate_policy(continuous_aggregate regclass, start_offset "any", end_offset "any", schedule_interval interval, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO authenticated;
GRANT ALL ON FUNCTION public.add_continuous_aggregate_policy(continuous_aggregate regclass, start_offset "any", end_offset "any", schedule_interval interval, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO service_role;


--
-- TOC entry 6964 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION add_data_node(node_name name, host text, database name, port integer, if_not_exists boolean, bootstrap boolean, password text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_data_node(node_name name, host text, database name, port integer, if_not_exists boolean, bootstrap boolean, password text) TO postgres;
GRANT ALL ON FUNCTION public.add_data_node(node_name name, host text, database name, port integer, if_not_exists boolean, bootstrap boolean, password text) TO anon;
GRANT ALL ON FUNCTION public.add_data_node(node_name name, host text, database name, port integer, if_not_exists boolean, bootstrap boolean, password text) TO authenticated;
GRANT ALL ON FUNCTION public.add_data_node(node_name name, host text, database name, port integer, if_not_exists boolean, bootstrap boolean, password text) TO service_role;


--
-- TOC entry 6965 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION add_dimension(hypertable regclass, column_name name, number_partitions integer, chunk_time_interval anyelement, partitioning_func regproc, if_not_exists boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_dimension(hypertable regclass, column_name name, number_partitions integer, chunk_time_interval anyelement, partitioning_func regproc, if_not_exists boolean) TO postgres;
GRANT ALL ON FUNCTION public.add_dimension(hypertable regclass, column_name name, number_partitions integer, chunk_time_interval anyelement, partitioning_func regproc, if_not_exists boolean) TO anon;
GRANT ALL ON FUNCTION public.add_dimension(hypertable regclass, column_name name, number_partitions integer, chunk_time_interval anyelement, partitioning_func regproc, if_not_exists boolean) TO authenticated;
GRANT ALL ON FUNCTION public.add_dimension(hypertable regclass, column_name name, number_partitions integer, chunk_time_interval anyelement, partitioning_func regproc, if_not_exists boolean) TO service_role;


--
-- TOC entry 6966 (class 0 OID 0)
-- Dependencies: 608
-- Name: FUNCTION add_job(proc regproc, schedule_interval interval, config jsonb, initial_start timestamp with time zone, scheduled boolean, check_config regproc, fixed_schedule boolean, timezone text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_job(proc regproc, schedule_interval interval, config jsonb, initial_start timestamp with time zone, scheduled boolean, check_config regproc, fixed_schedule boolean, timezone text) TO postgres;
GRANT ALL ON FUNCTION public.add_job(proc regproc, schedule_interval interval, config jsonb, initial_start timestamp with time zone, scheduled boolean, check_config regproc, fixed_schedule boolean, timezone text) TO anon;
GRANT ALL ON FUNCTION public.add_job(proc regproc, schedule_interval interval, config jsonb, initial_start timestamp with time zone, scheduled boolean, check_config regproc, fixed_schedule boolean, timezone text) TO authenticated;
GRANT ALL ON FUNCTION public.add_job(proc regproc, schedule_interval interval, config jsonb, initial_start timestamp with time zone, scheduled boolean, check_config regproc, fixed_schedule boolean, timezone text) TO service_role;


--
-- TOC entry 6967 (class 0 OID 0)
-- Dependencies: 615
-- Name: FUNCTION add_reorder_policy(hypertable regclass, index_name name, if_not_exists boolean, initial_start timestamp with time zone, timezone text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_reorder_policy(hypertable regclass, index_name name, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO postgres;
GRANT ALL ON FUNCTION public.add_reorder_policy(hypertable regclass, index_name name, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO anon;
GRANT ALL ON FUNCTION public.add_reorder_policy(hypertable regclass, index_name name, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO authenticated;
GRANT ALL ON FUNCTION public.add_reorder_policy(hypertable regclass, index_name name, if_not_exists boolean, initial_start timestamp with time zone, timezone text) TO service_role;


--
-- TOC entry 6968 (class 0 OID 0)
-- Dependencies: 613
-- Name: FUNCTION add_retention_policy(relation regclass, drop_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.add_retention_policy(relation regclass, drop_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO postgres;
GRANT ALL ON FUNCTION public.add_retention_policy(relation regclass, drop_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO anon;
GRANT ALL ON FUNCTION public.add_retention_policy(relation regclass, drop_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO authenticated;
GRANT ALL ON FUNCTION public.add_retention_policy(relation regclass, drop_after "any", if_not_exists boolean, schedule_interval interval, initial_start timestamp with time zone, timezone text) TO service_role;


--
-- TOC entry 6969 (class 0 OID 0)
-- Dependencies: 514
-- Name: FUNCTION alter_data_node(node_name name, host text, database name, port integer, available boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.alter_data_node(node_name name, host text, database name, port integer, available boolean) TO postgres;
GRANT ALL ON FUNCTION public.alter_data_node(node_name name, host text, database name, port integer, available boolean) TO anon;
GRANT ALL ON FUNCTION public.alter_data_node(node_name name, host text, database name, port integer, available boolean) TO authenticated;
GRANT ALL ON FUNCTION public.alter_data_node(node_name name, host text, database name, port integer, available boolean) TO service_role;


--
-- TOC entry 6970 (class 0 OID 0)
-- Dependencies: 611
-- Name: FUNCTION alter_job(job_id integer, schedule_interval interval, max_runtime interval, max_retries integer, retry_period interval, scheduled boolean, config jsonb, next_start timestamp with time zone, if_exists boolean, check_config regproc); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.alter_job(job_id integer, schedule_interval interval, max_runtime interval, max_retries integer, retry_period interval, scheduled boolean, config jsonb, next_start timestamp with time zone, if_exists boolean, check_config regproc) TO postgres;
GRANT ALL ON FUNCTION public.alter_job(job_id integer, schedule_interval interval, max_runtime interval, max_retries integer, retry_period interval, scheduled boolean, config jsonb, next_start timestamp with time zone, if_exists boolean, check_config regproc) TO anon;
GRANT ALL ON FUNCTION public.alter_job(job_id integer, schedule_interval interval, max_runtime interval, max_retries integer, retry_period interval, scheduled boolean, config jsonb, next_start timestamp with time zone, if_exists boolean, check_config regproc) TO authenticated;
GRANT ALL ON FUNCTION public.alter_job(job_id integer, schedule_interval interval, max_runtime interval, max_retries integer, retry_period interval, scheduled boolean, config jsonb, next_start timestamp with time zone, if_exists boolean, check_config regproc) TO service_role;


--
-- TOC entry 6971 (class 0 OID 0)
-- Dependencies: 561
-- Name: FUNCTION approximate_row_count(relation regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.approximate_row_count(relation regclass) TO postgres;
GRANT ALL ON FUNCTION public.approximate_row_count(relation regclass) TO anon;
GRANT ALL ON FUNCTION public.approximate_row_count(relation regclass) TO authenticated;
GRANT ALL ON FUNCTION public.approximate_row_count(relation regclass) TO service_role;


--
-- TOC entry 6972 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION attach_data_node(node_name name, hypertable regclass, if_not_attached boolean, repartition boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.attach_data_node(node_name name, hypertable regclass, if_not_attached boolean, repartition boolean) TO postgres;
GRANT ALL ON FUNCTION public.attach_data_node(node_name name, hypertable regclass, if_not_attached boolean, repartition boolean) TO anon;
GRANT ALL ON FUNCTION public.attach_data_node(node_name name, hypertable regclass, if_not_attached boolean, repartition boolean) TO authenticated;
GRANT ALL ON FUNCTION public.attach_data_node(node_name name, hypertable regclass, if_not_attached boolean, repartition boolean) TO service_role;


--
-- TOC entry 6973 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION attach_tablespace(tablespace name, hypertable regclass, if_not_attached boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.attach_tablespace(tablespace name, hypertable regclass, if_not_attached boolean) TO postgres;
GRANT ALL ON FUNCTION public.attach_tablespace(tablespace name, hypertable regclass, if_not_attached boolean) TO anon;
GRANT ALL ON FUNCTION public.attach_tablespace(tablespace name, hypertable regclass, if_not_attached boolean) TO authenticated;
GRANT ALL ON FUNCTION public.attach_tablespace(tablespace name, hypertable regclass, if_not_attached boolean) TO service_role;


--
-- TOC entry 6974 (class 0 OID 0)
-- Dependencies: 796
-- Name: FUNCTION autoinc(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.autoinc() TO postgres;
GRANT ALL ON FUNCTION public.autoinc() TO anon;
GRANT ALL ON FUNCTION public.autoinc() TO authenticated;
GRANT ALL ON FUNCTION public.autoinc() TO service_role;


--
-- TOC entry 6975 (class 0 OID 0)
-- Dependencies: 657
-- Name: PROCEDURE cagg_migrate(IN cagg regclass, IN override boolean, IN drop_old boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON PROCEDURE public.cagg_migrate(IN cagg regclass, IN override boolean, IN drop_old boolean) TO postgres;
GRANT ALL ON PROCEDURE public.cagg_migrate(IN cagg regclass, IN override boolean, IN drop_old boolean) TO anon;
GRANT ALL ON PROCEDURE public.cagg_migrate(IN cagg regclass, IN override boolean, IN drop_old boolean) TO authenticated;
GRANT ALL ON PROCEDURE public.cagg_migrate(IN cagg regclass, IN override boolean, IN drop_old boolean) TO service_role;


--
-- TOC entry 6976 (class 0 OID 0)
-- Dependencies: 1674
-- Name: FUNCTION check_pet_owner(pet_id uuid, auth_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_pet_owner(pet_id uuid, auth_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.check_pet_owner(pet_id uuid, auth_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.check_pet_owner(pet_id uuid, auth_user_id uuid) TO service_role;


--
-- TOC entry 6977 (class 0 OID 0)
-- Dependencies: 565
-- Name: FUNCTION chunk_compression_stats(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.chunk_compression_stats(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.chunk_compression_stats(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.chunk_compression_stats(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.chunk_compression_stats(hypertable regclass) TO service_role;


--
-- TOC entry 6978 (class 0 OID 0)
-- Dependencies: 559
-- Name: FUNCTION chunks_detailed_size(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.chunks_detailed_size(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.chunks_detailed_size(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.chunks_detailed_size(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.chunks_detailed_size(hypertable regclass) TO service_role;


--
-- TOC entry 6979 (class 0 OID 0)
-- Dependencies: 600
-- Name: FUNCTION compress_chunk(uncompressed_chunk regclass, if_not_compressed boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.compress_chunk(uncompressed_chunk regclass, if_not_compressed boolean) TO postgres;
GRANT ALL ON FUNCTION public.compress_chunk(uncompressed_chunk regclass, if_not_compressed boolean) TO anon;
GRANT ALL ON FUNCTION public.compress_chunk(uncompressed_chunk regclass, if_not_compressed boolean) TO authenticated;
GRANT ALL ON FUNCTION public.compress_chunk(uncompressed_chunk regclass, if_not_compressed boolean) TO service_role;


--
-- TOC entry 6980 (class 0 OID 0)
-- Dependencies: 495
-- Name: FUNCTION create_distributed_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.create_distributed_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[]) TO postgres;
GRANT ALL ON FUNCTION public.create_distributed_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[]) TO anon;
GRANT ALL ON FUNCTION public.create_distributed_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[]) TO authenticated;
GRANT ALL ON FUNCTION public.create_distributed_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[]) TO service_role;


--
-- TOC entry 6981 (class 0 OID 0)
-- Dependencies: 511
-- Name: FUNCTION create_distributed_restore_point(name text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.create_distributed_restore_point(name text) TO postgres;
GRANT ALL ON FUNCTION public.create_distributed_restore_point(name text) TO anon;
GRANT ALL ON FUNCTION public.create_distributed_restore_point(name text) TO authenticated;
GRANT ALL ON FUNCTION public.create_distributed_restore_point(name text) TO service_role;


--
-- TOC entry 6982 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION create_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[], distributed boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.create_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[], distributed boolean) TO postgres;
GRANT ALL ON FUNCTION public.create_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[], distributed boolean) TO anon;
GRANT ALL ON FUNCTION public.create_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[], distributed boolean) TO authenticated;
GRANT ALL ON FUNCTION public.create_hypertable(relation regclass, time_column_name name, partitioning_column name, number_partitions integer, associated_schema_name name, associated_table_prefix name, chunk_time_interval anyelement, create_default_indexes boolean, if_not_exists boolean, partitioning_func regproc, migrate_data boolean, chunk_target_size text, chunk_sizing_func regproc, time_partitioning_func regproc, replication_factor integer, data_nodes name[], distributed boolean) TO service_role;


--
-- TOC entry 6983 (class 0 OID 0)
-- Dependencies: 1675
-- Name: FUNCTION create_pet_health_record(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_pet_health_record() TO anon;
GRANT ALL ON FUNCTION public.create_pet_health_record() TO authenticated;
GRANT ALL ON FUNCTION public.create_pet_health_record() TO service_role;


--
-- TOC entry 6984 (class 0 OID 0)
-- Dependencies: 601
-- Name: FUNCTION decompress_chunk(uncompressed_chunk regclass, if_compressed boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.decompress_chunk(uncompressed_chunk regclass, if_compressed boolean) TO postgres;
GRANT ALL ON FUNCTION public.decompress_chunk(uncompressed_chunk regclass, if_compressed boolean) TO anon;
GRANT ALL ON FUNCTION public.decompress_chunk(uncompressed_chunk regclass, if_compressed boolean) TO authenticated;
GRANT ALL ON FUNCTION public.decompress_chunk(uncompressed_chunk regclass, if_compressed boolean) TO service_role;


--
-- TOC entry 6985 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION delete_data_node(node_name name, if_exists boolean, force boolean, repartition boolean, drop_database boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.delete_data_node(node_name name, if_exists boolean, force boolean, repartition boolean, drop_database boolean) TO postgres;
GRANT ALL ON FUNCTION public.delete_data_node(node_name name, if_exists boolean, force boolean, repartition boolean, drop_database boolean) TO anon;
GRANT ALL ON FUNCTION public.delete_data_node(node_name name, if_exists boolean, force boolean, repartition boolean, drop_database boolean) TO authenticated;
GRANT ALL ON FUNCTION public.delete_data_node(node_name name, if_exists boolean, force boolean, repartition boolean, drop_database boolean) TO service_role;


--
-- TOC entry 6986 (class 0 OID 0)
-- Dependencies: 609
-- Name: FUNCTION delete_job(job_id integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.delete_job(job_id integer) TO postgres;
GRANT ALL ON FUNCTION public.delete_job(job_id integer) TO anon;
GRANT ALL ON FUNCTION public.delete_job(job_id integer) TO authenticated;
GRANT ALL ON FUNCTION public.delete_job(job_id integer) TO service_role;


--
-- TOC entry 6987 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION detach_data_node(node_name name, hypertable regclass, if_attached boolean, force boolean, repartition boolean, drop_remote_data boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.detach_data_node(node_name name, hypertable regclass, if_attached boolean, force boolean, repartition boolean, drop_remote_data boolean) TO postgres;
GRANT ALL ON FUNCTION public.detach_data_node(node_name name, hypertable regclass, if_attached boolean, force boolean, repartition boolean, drop_remote_data boolean) TO anon;
GRANT ALL ON FUNCTION public.detach_data_node(node_name name, hypertable regclass, if_attached boolean, force boolean, repartition boolean, drop_remote_data boolean) TO authenticated;
GRANT ALL ON FUNCTION public.detach_data_node(node_name name, hypertable regclass, if_attached boolean, force boolean, repartition boolean, drop_remote_data boolean) TO service_role;


--
-- TOC entry 6988 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION detach_tablespace(tablespace name, hypertable regclass, if_attached boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.detach_tablespace(tablespace name, hypertable regclass, if_attached boolean) TO postgres;
GRANT ALL ON FUNCTION public.detach_tablespace(tablespace name, hypertable regclass, if_attached boolean) TO anon;
GRANT ALL ON FUNCTION public.detach_tablespace(tablespace name, hypertable regclass, if_attached boolean) TO authenticated;
GRANT ALL ON FUNCTION public.detach_tablespace(tablespace name, hypertable regclass, if_attached boolean) TO service_role;


--
-- TOC entry 6989 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION detach_tablespaces(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.detach_tablespaces(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.detach_tablespaces(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.detach_tablespaces(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.detach_tablespaces(hypertable regclass) TO service_role;


--
-- TOC entry 6990 (class 0 OID 0)
-- Dependencies: 510
-- Name: PROCEDURE distributed_exec(IN query text, IN node_list name[], IN transactional boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON PROCEDURE public.distributed_exec(IN query text, IN node_list name[], IN transactional boolean) TO postgres;
GRANT ALL ON PROCEDURE public.distributed_exec(IN query text, IN node_list name[], IN transactional boolean) TO anon;
GRANT ALL ON PROCEDURE public.distributed_exec(IN query text, IN node_list name[], IN transactional boolean) TO authenticated;
GRANT ALL ON PROCEDURE public.distributed_exec(IN query text, IN node_list name[], IN transactional boolean) TO service_role;


--
-- TOC entry 6991 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION drop_chunks(relation regclass, older_than "any", newer_than "any", "verbose" boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.drop_chunks(relation regclass, older_than "any", newer_than "any", "verbose" boolean) TO postgres;
GRANT ALL ON FUNCTION public.drop_chunks(relation regclass, older_than "any", newer_than "any", "verbose" boolean) TO anon;
GRANT ALL ON FUNCTION public.drop_chunks(relation regclass, older_than "any", newer_than "any", "verbose" boolean) TO authenticated;
GRANT ALL ON FUNCTION public.drop_chunks(relation regclass, older_than "any", newer_than "any", "verbose" boolean) TO service_role;


--
-- TOC entry 6992 (class 0 OID 0)
-- Dependencies: 1676
-- Name: FUNCTION get_pet_user_id(uid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_pet_user_id(uid uuid) TO anon;
GRANT ALL ON FUNCTION public.get_pet_user_id(uid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_pet_user_id(uid uuid) TO service_role;


--
-- TOC entry 6993 (class 0 OID 0)
-- Dependencies: 660
-- Name: FUNCTION get_telemetry_report(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.get_telemetry_report() TO postgres;
GRANT ALL ON FUNCTION public.get_telemetry_report() TO anon;
GRANT ALL ON FUNCTION public.get_telemetry_report() TO authenticated;
GRANT ALL ON FUNCTION public.get_telemetry_report() TO service_role;


--
-- TOC entry 6994 (class 0 OID 0)
-- Dependencies: 1677
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- TOC entry 6995 (class 0 OID 0)
-- Dependencies: 566
-- Name: FUNCTION hypertable_compression_stats(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.hypertable_compression_stats(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.hypertable_compression_stats(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.hypertable_compression_stats(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.hypertable_compression_stats(hypertable regclass) TO service_role;


--
-- TOC entry 6996 (class 0 OID 0)
-- Dependencies: 555
-- Name: FUNCTION hypertable_detailed_size(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.hypertable_detailed_size(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.hypertable_detailed_size(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.hypertable_detailed_size(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.hypertable_detailed_size(hypertable regclass) TO service_role;


--
-- TOC entry 6997 (class 0 OID 0)
-- Dependencies: 570
-- Name: FUNCTION hypertable_index_size(index_name regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.hypertable_index_size(index_name regclass) TO postgres;
GRANT ALL ON FUNCTION public.hypertable_index_size(index_name regclass) TO anon;
GRANT ALL ON FUNCTION public.hypertable_index_size(index_name regclass) TO authenticated;
GRANT ALL ON FUNCTION public.hypertable_index_size(index_name regclass) TO service_role;


--
-- TOC entry 6998 (class 0 OID 0)
-- Dependencies: 556
-- Name: FUNCTION hypertable_size(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.hypertable_size(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.hypertable_size(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.hypertable_size(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.hypertable_size(hypertable regclass) TO service_role;


--
-- TOC entry 6999 (class 0 OID 0)
-- Dependencies: 595
-- Name: FUNCTION interpolate(value real, prev record, next record); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.interpolate(value real, prev record, next record) TO postgres;
GRANT ALL ON FUNCTION public.interpolate(value real, prev record, next record) TO anon;
GRANT ALL ON FUNCTION public.interpolate(value real, prev record, next record) TO authenticated;
GRANT ALL ON FUNCTION public.interpolate(value real, prev record, next record) TO service_role;


--
-- TOC entry 7000 (class 0 OID 0)
-- Dependencies: 596
-- Name: FUNCTION interpolate(value double precision, prev record, next record); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.interpolate(value double precision, prev record, next record) TO postgres;
GRANT ALL ON FUNCTION public.interpolate(value double precision, prev record, next record) TO anon;
GRANT ALL ON FUNCTION public.interpolate(value double precision, prev record, next record) TO authenticated;
GRANT ALL ON FUNCTION public.interpolate(value double precision, prev record, next record) TO service_role;


--
-- TOC entry 7001 (class 0 OID 0)
-- Dependencies: 592
-- Name: FUNCTION interpolate(value smallint, prev record, next record); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.interpolate(value smallint, prev record, next record) TO postgres;
GRANT ALL ON FUNCTION public.interpolate(value smallint, prev record, next record) TO anon;
GRANT ALL ON FUNCTION public.interpolate(value smallint, prev record, next record) TO authenticated;
GRANT ALL ON FUNCTION public.interpolate(value smallint, prev record, next record) TO service_role;


--
-- TOC entry 7002 (class 0 OID 0)
-- Dependencies: 593
-- Name: FUNCTION interpolate(value integer, prev record, next record); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.interpolate(value integer, prev record, next record) TO postgres;
GRANT ALL ON FUNCTION public.interpolate(value integer, prev record, next record) TO anon;
GRANT ALL ON FUNCTION public.interpolate(value integer, prev record, next record) TO authenticated;
GRANT ALL ON FUNCTION public.interpolate(value integer, prev record, next record) TO service_role;


--
-- TOC entry 7003 (class 0 OID 0)
-- Dependencies: 594
-- Name: FUNCTION interpolate(value bigint, prev record, next record); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.interpolate(value bigint, prev record, next record) TO postgres;
GRANT ALL ON FUNCTION public.interpolate(value bigint, prev record, next record) TO anon;
GRANT ALL ON FUNCTION public.interpolate(value bigint, prev record, next record) TO authenticated;
GRANT ALL ON FUNCTION public.interpolate(value bigint, prev record, next record) TO service_role;


--
-- TOC entry 7004 (class 0 OID 0)
-- Dependencies: 591
-- Name: FUNCTION locf(value anyelement, prev anyelement, treat_null_as_missing boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.locf(value anyelement, prev anyelement, treat_null_as_missing boolean) TO postgres;
GRANT ALL ON FUNCTION public.locf(value anyelement, prev anyelement, treat_null_as_missing boolean) TO anon;
GRANT ALL ON FUNCTION public.locf(value anyelement, prev anyelement, treat_null_as_missing boolean) TO authenticated;
GRANT ALL ON FUNCTION public.locf(value anyelement, prev anyelement, treat_null_as_missing boolean) TO service_role;


--
-- TOC entry 7005 (class 0 OID 0)
-- Dependencies: 858
-- Name: FUNCTION moddatetime(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.moddatetime() TO postgres;
GRANT ALL ON FUNCTION public.moddatetime() TO anon;
GRANT ALL ON FUNCTION public.moddatetime() TO authenticated;
GRANT ALL ON FUNCTION public.moddatetime() TO service_role;


--
-- TOC entry 7006 (class 0 OID 0)
-- Dependencies: 598
-- Name: FUNCTION move_chunk(chunk regclass, destination_tablespace name, index_destination_tablespace name, reorder_index regclass, "verbose" boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.move_chunk(chunk regclass, destination_tablespace name, index_destination_tablespace name, reorder_index regclass, "verbose" boolean) TO postgres;
GRANT ALL ON FUNCTION public.move_chunk(chunk regclass, destination_tablespace name, index_destination_tablespace name, reorder_index regclass, "verbose" boolean) TO anon;
GRANT ALL ON FUNCTION public.move_chunk(chunk regclass, destination_tablespace name, index_destination_tablespace name, reorder_index regclass, "verbose" boolean) TO authenticated;
GRANT ALL ON FUNCTION public.move_chunk(chunk regclass, destination_tablespace name, index_destination_tablespace name, reorder_index regclass, "verbose" boolean) TO service_role;


--
-- TOC entry 7007 (class 0 OID 0)
-- Dependencies: 602
-- Name: PROCEDURE recompress_chunk(IN chunk regclass, IN if_not_compressed boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON PROCEDURE public.recompress_chunk(IN chunk regclass, IN if_not_compressed boolean) TO postgres;
GRANT ALL ON PROCEDURE public.recompress_chunk(IN chunk regclass, IN if_not_compressed boolean) TO anon;
GRANT ALL ON PROCEDURE public.recompress_chunk(IN chunk regclass, IN if_not_compressed boolean) TO authenticated;
GRANT ALL ON PROCEDURE public.recompress_chunk(IN chunk regclass, IN if_not_compressed boolean) TO service_role;


--
-- TOC entry 7008 (class 0 OID 0)
-- Dependencies: 513
-- Name: PROCEDURE refresh_continuous_aggregate(IN continuous_aggregate regclass, IN window_start "any", IN window_end "any"); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON PROCEDURE public.refresh_continuous_aggregate(IN continuous_aggregate regclass, IN window_start "any", IN window_end "any") TO postgres;
GRANT ALL ON PROCEDURE public.refresh_continuous_aggregate(IN continuous_aggregate regclass, IN window_start "any", IN window_end "any") TO anon;
GRANT ALL ON PROCEDURE public.refresh_continuous_aggregate(IN continuous_aggregate regclass, IN window_start "any", IN window_end "any") TO authenticated;
GRANT ALL ON PROCEDURE public.refresh_continuous_aggregate(IN continuous_aggregate regclass, IN window_start "any", IN window_end "any") TO service_role;


--
-- TOC entry 7009 (class 0 OID 0)
-- Dependencies: 618
-- Name: FUNCTION remove_compression_policy(hypertable regclass, if_exists boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.remove_compression_policy(hypertable regclass, if_exists boolean) TO postgres;
GRANT ALL ON FUNCTION public.remove_compression_policy(hypertable regclass, if_exists boolean) TO anon;
GRANT ALL ON FUNCTION public.remove_compression_policy(hypertable regclass, if_exists boolean) TO authenticated;
GRANT ALL ON FUNCTION public.remove_compression_policy(hypertable regclass, if_exists boolean) TO service_role;


--
-- TOC entry 7010 (class 0 OID 0)
-- Dependencies: 620
-- Name: FUNCTION remove_continuous_aggregate_policy(continuous_aggregate regclass, if_not_exists boolean, if_exists boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.remove_continuous_aggregate_policy(continuous_aggregate regclass, if_not_exists boolean, if_exists boolean) TO postgres;
GRANT ALL ON FUNCTION public.remove_continuous_aggregate_policy(continuous_aggregate regclass, if_not_exists boolean, if_exists boolean) TO anon;
GRANT ALL ON FUNCTION public.remove_continuous_aggregate_policy(continuous_aggregate regclass, if_not_exists boolean, if_exists boolean) TO authenticated;
GRANT ALL ON FUNCTION public.remove_continuous_aggregate_policy(continuous_aggregate regclass, if_not_exists boolean, if_exists boolean) TO service_role;


--
-- TOC entry 7011 (class 0 OID 0)
-- Dependencies: 616
-- Name: FUNCTION remove_reorder_policy(hypertable regclass, if_exists boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.remove_reorder_policy(hypertable regclass, if_exists boolean) TO postgres;
GRANT ALL ON FUNCTION public.remove_reorder_policy(hypertable regclass, if_exists boolean) TO anon;
GRANT ALL ON FUNCTION public.remove_reorder_policy(hypertable regclass, if_exists boolean) TO authenticated;
GRANT ALL ON FUNCTION public.remove_reorder_policy(hypertable regclass, if_exists boolean) TO service_role;


--
-- TOC entry 7012 (class 0 OID 0)
-- Dependencies: 614
-- Name: FUNCTION remove_retention_policy(relation regclass, if_exists boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.remove_retention_policy(relation regclass, if_exists boolean) TO postgres;
GRANT ALL ON FUNCTION public.remove_retention_policy(relation regclass, if_exists boolean) TO anon;
GRANT ALL ON FUNCTION public.remove_retention_policy(relation regclass, if_exists boolean) TO authenticated;
GRANT ALL ON FUNCTION public.remove_retention_policy(relation regclass, if_exists boolean) TO service_role;


--
-- TOC entry 7013 (class 0 OID 0)
-- Dependencies: 597
-- Name: FUNCTION reorder_chunk(chunk regclass, index regclass, "verbose" boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.reorder_chunk(chunk regclass, index regclass, "verbose" boolean) TO postgres;
GRANT ALL ON FUNCTION public.reorder_chunk(chunk regclass, index regclass, "verbose" boolean) TO anon;
GRANT ALL ON FUNCTION public.reorder_chunk(chunk regclass, index regclass, "verbose" boolean) TO authenticated;
GRANT ALL ON FUNCTION public.reorder_chunk(chunk regclass, index regclass, "verbose" boolean) TO service_role;


--
-- TOC entry 7014 (class 0 OID 0)
-- Dependencies: 610
-- Name: PROCEDURE run_job(IN job_id integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON PROCEDURE public.run_job(IN job_id integer) TO postgres;
GRANT ALL ON PROCEDURE public.run_job(IN job_id integer) TO anon;
GRANT ALL ON PROCEDURE public.run_job(IN job_id integer) TO authenticated;
GRANT ALL ON PROCEDURE public.run_job(IN job_id integer) TO service_role;


--
-- TOC entry 7015 (class 0 OID 0)
-- Dependencies: 1708
-- Name: FUNCTION send_push_notification_to_requested_friends(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.send_push_notification_to_requested_friends() TO anon;
GRANT ALL ON FUNCTION public.send_push_notification_to_requested_friends() TO authenticated;
GRANT ALL ON FUNCTION public.send_push_notification_to_requested_friends() TO service_role;


--
-- TOC entry 7016 (class 0 OID 0)
-- Dependencies: 1709
-- Name: FUNCTION send_push_notification_to_requester(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.send_push_notification_to_requester() TO anon;
GRANT ALL ON FUNCTION public.send_push_notification_to_requester() TO authenticated;
GRANT ALL ON FUNCTION public.send_push_notification_to_requester() TO service_role;


--
-- TOC entry 7017 (class 0 OID 0)
-- Dependencies: 496
-- Name: FUNCTION set_adaptive_chunking(hypertable regclass, chunk_target_size text, INOUT chunk_sizing_func regproc, OUT chunk_target_size bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.set_adaptive_chunking(hypertable regclass, chunk_target_size text, INOUT chunk_sizing_func regproc, OUT chunk_target_size bigint) TO postgres;
GRANT ALL ON FUNCTION public.set_adaptive_chunking(hypertable regclass, chunk_target_size text, INOUT chunk_sizing_func regproc, OUT chunk_target_size bigint) TO anon;
GRANT ALL ON FUNCTION public.set_adaptive_chunking(hypertable regclass, chunk_target_size text, INOUT chunk_sizing_func regproc, OUT chunk_target_size bigint) TO authenticated;
GRANT ALL ON FUNCTION public.set_adaptive_chunking(hypertable regclass, chunk_target_size text, INOUT chunk_sizing_func regproc, OUT chunk_target_size bigint) TO service_role;


--
-- TOC entry 7018 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION set_chunk_time_interval(hypertable regclass, chunk_time_interval anyelement, dimension_name name); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.set_chunk_time_interval(hypertable regclass, chunk_time_interval anyelement, dimension_name name) TO postgres;
GRANT ALL ON FUNCTION public.set_chunk_time_interval(hypertable regclass, chunk_time_interval anyelement, dimension_name name) TO anon;
GRANT ALL ON FUNCTION public.set_chunk_time_interval(hypertable regclass, chunk_time_interval anyelement, dimension_name name) TO authenticated;
GRANT ALL ON FUNCTION public.set_chunk_time_interval(hypertable regclass, chunk_time_interval anyelement, dimension_name name) TO service_role;


--
-- TOC entry 7019 (class 0 OID 0)
-- Dependencies: 442
-- Name: FUNCTION set_integer_now_func(hypertable regclass, integer_now_func regproc, replace_if_exists boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.set_integer_now_func(hypertable regclass, integer_now_func regproc, replace_if_exists boolean) TO postgres;
GRANT ALL ON FUNCTION public.set_integer_now_func(hypertable regclass, integer_now_func regproc, replace_if_exists boolean) TO anon;
GRANT ALL ON FUNCTION public.set_integer_now_func(hypertable regclass, integer_now_func regproc, replace_if_exists boolean) TO authenticated;
GRANT ALL ON FUNCTION public.set_integer_now_func(hypertable regclass, integer_now_func regproc, replace_if_exists boolean) TO service_role;


--
-- TOC entry 7020 (class 0 OID 0)
-- Dependencies: 498
-- Name: FUNCTION set_number_partitions(hypertable regclass, number_partitions integer, dimension_name name); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.set_number_partitions(hypertable regclass, number_partitions integer, dimension_name name) TO postgres;
GRANT ALL ON FUNCTION public.set_number_partitions(hypertable regclass, number_partitions integer, dimension_name name) TO anon;
GRANT ALL ON FUNCTION public.set_number_partitions(hypertable regclass, number_partitions integer, dimension_name name) TO authenticated;
GRANT ALL ON FUNCTION public.set_number_partitions(hypertable regclass, number_partitions integer, dimension_name name) TO service_role;


--
-- TOC entry 7021 (class 0 OID 0)
-- Dependencies: 512
-- Name: FUNCTION set_replication_factor(hypertable regclass, replication_factor integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.set_replication_factor(hypertable regclass, replication_factor integer) TO postgres;
GRANT ALL ON FUNCTION public.set_replication_factor(hypertable regclass, replication_factor integer) TO anon;
GRANT ALL ON FUNCTION public.set_replication_factor(hypertable regclass, replication_factor integer) TO authenticated;
GRANT ALL ON FUNCTION public.set_replication_factor(hypertable regclass, replication_factor integer) TO service_role;


--
-- TOC entry 7022 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION show_chunks(relation regclass, older_than "any", newer_than "any"); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.show_chunks(relation regclass, older_than "any", newer_than "any") TO postgres;
GRANT ALL ON FUNCTION public.show_chunks(relation regclass, older_than "any", newer_than "any") TO anon;
GRANT ALL ON FUNCTION public.show_chunks(relation regclass, older_than "any", newer_than "any") TO authenticated;
GRANT ALL ON FUNCTION public.show_chunks(relation regclass, older_than "any", newer_than "any") TO service_role;


--
-- TOC entry 7023 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION show_tablespaces(hypertable regclass); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.show_tablespaces(hypertable regclass) TO postgres;
GRANT ALL ON FUNCTION public.show_tablespaces(hypertable regclass) TO anon;
GRANT ALL ON FUNCTION public.show_tablespaces(hypertable regclass) TO authenticated;
GRANT ALL ON FUNCTION public.show_tablespaces(hypertable regclass) TO service_role;


--
-- TOC entry 7024 (class 0 OID 0)
-- Dependencies: 533
-- Name: FUNCTION time_bucket(bucket_width smallint, ts smallint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint) TO service_role;


--
-- TOC entry 7025 (class 0 OID 0)
-- Dependencies: 534
-- Name: FUNCTION time_bucket(bucket_width integer, ts integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer) TO service_role;


--
-- TOC entry 7026 (class 0 OID 0)
-- Dependencies: 535
-- Name: FUNCTION time_bucket(bucket_width bigint, ts bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint) TO service_role;


--
-- TOC entry 7027 (class 0 OID 0)
-- Dependencies: 525
-- Name: FUNCTION time_bucket(bucket_width interval, ts date); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date) TO service_role;


--
-- TOC entry 7028 (class 0 OID 0)
-- Dependencies: 523
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp without time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone) TO service_role;


--
-- TOC entry 7029 (class 0 OID 0)
-- Dependencies: 524
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp with time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone) TO service_role;


--
-- TOC entry 7030 (class 0 OID 0)
-- Dependencies: 536
-- Name: FUNCTION time_bucket(bucket_width smallint, ts smallint, "offset" smallint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint, "offset" smallint) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint, "offset" smallint) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint, "offset" smallint) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width smallint, ts smallint, "offset" smallint) TO service_role;


--
-- TOC entry 7031 (class 0 OID 0)
-- Dependencies: 537
-- Name: FUNCTION time_bucket(bucket_width integer, ts integer, "offset" integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer, "offset" integer) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer, "offset" integer) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer, "offset" integer) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width integer, ts integer, "offset" integer) TO service_role;


--
-- TOC entry 7032 (class 0 OID 0)
-- Dependencies: 538
-- Name: FUNCTION time_bucket(bucket_width bigint, ts bigint, "offset" bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint, "offset" bigint) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint, "offset" bigint) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint, "offset" bigint) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width bigint, ts bigint, "offset" bigint) TO service_role;


--
-- TOC entry 7033 (class 0 OID 0)
-- Dependencies: 528
-- Name: FUNCTION time_bucket(bucket_width interval, ts date, origin date); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, origin date) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, origin date) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, origin date) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, origin date) TO service_role;


--
-- TOC entry 7034 (class 0 OID 0)
-- Dependencies: 531
-- Name: FUNCTION time_bucket(bucket_width interval, ts date, "offset" interval); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, "offset" interval) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, "offset" interval) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, "offset" interval) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts date, "offset" interval) TO service_role;


--
-- TOC entry 7035 (class 0 OID 0)
-- Dependencies: 529
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp without time zone, "offset" interval); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, "offset" interval) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, "offset" interval) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, "offset" interval) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, "offset" interval) TO service_role;


--
-- TOC entry 7036 (class 0 OID 0)
-- Dependencies: 526
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp without time zone, origin timestamp without time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, origin timestamp without time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, origin timestamp without time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, origin timestamp without time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp without time zone, origin timestamp without time zone) TO service_role;


--
-- TOC entry 7037 (class 0 OID 0)
-- Dependencies: 530
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp with time zone, "offset" interval); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, "offset" interval) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, "offset" interval) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, "offset" interval) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, "offset" interval) TO service_role;


--
-- TOC entry 7038 (class 0 OID 0)
-- Dependencies: 527
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp with time zone, origin timestamp with time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, origin timestamp with time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, origin timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, origin timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, origin timestamp with time zone) TO service_role;


--
-- TOC entry 7039 (class 0 OID 0)
-- Dependencies: 532
-- Name: FUNCTION time_bucket(bucket_width interval, ts timestamp with time zone, timezone text, origin timestamp with time zone, "offset" interval); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, timezone text, origin timestamp with time zone, "offset" interval) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, timezone text, origin timestamp with time zone, "offset" interval) TO anon;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, timezone text, origin timestamp with time zone, "offset" interval) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket(bucket_width interval, ts timestamp with time zone, timezone text, origin timestamp with time zone, "offset" interval) TO service_role;


--
-- TOC entry 7040 (class 0 OID 0)
-- Dependencies: 584
-- Name: FUNCTION time_bucket_gapfill(bucket_width smallint, ts smallint, start smallint, finish smallint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width smallint, ts smallint, start smallint, finish smallint) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width smallint, ts smallint, start smallint, finish smallint) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width smallint, ts smallint, start smallint, finish smallint) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width smallint, ts smallint, start smallint, finish smallint) TO service_role;


--
-- TOC entry 7041 (class 0 OID 0)
-- Dependencies: 585
-- Name: FUNCTION time_bucket_gapfill(bucket_width integer, ts integer, start integer, finish integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width integer, ts integer, start integer, finish integer) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width integer, ts integer, start integer, finish integer) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width integer, ts integer, start integer, finish integer) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width integer, ts integer, start integer, finish integer) TO service_role;


--
-- TOC entry 7042 (class 0 OID 0)
-- Dependencies: 586
-- Name: FUNCTION time_bucket_gapfill(bucket_width bigint, ts bigint, start bigint, finish bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width bigint, ts bigint, start bigint, finish bigint) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width bigint, ts bigint, start bigint, finish bigint) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width bigint, ts bigint, start bigint, finish bigint) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width bigint, ts bigint, start bigint, finish bigint) TO service_role;


--
-- TOC entry 7043 (class 0 OID 0)
-- Dependencies: 587
-- Name: FUNCTION time_bucket_gapfill(bucket_width interval, ts date, start date, finish date); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts date, start date, finish date) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts date, start date, finish date) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts date, start date, finish date) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts date, start date, finish date) TO service_role;


--
-- TOC entry 7044 (class 0 OID 0)
-- Dependencies: 588
-- Name: FUNCTION time_bucket_gapfill(bucket_width interval, ts timestamp without time zone, start timestamp without time zone, finish timestamp without time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp without time zone, start timestamp without time zone, finish timestamp without time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp without time zone, start timestamp without time zone, finish timestamp without time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp without time zone, start timestamp without time zone, finish timestamp without time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp without time zone, start timestamp without time zone, finish timestamp without time zone) TO service_role;


--
-- TOC entry 7045 (class 0 OID 0)
-- Dependencies: 589
-- Name: FUNCTION time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, start timestamp with time zone, finish timestamp with time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, start timestamp with time zone, finish timestamp with time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, start timestamp with time zone, finish timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, start timestamp with time zone, finish timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, start timestamp with time zone, finish timestamp with time zone) TO service_role;


--
-- TOC entry 7046 (class 0 OID 0)
-- Dependencies: 590
-- Name: FUNCTION time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, timezone text, start timestamp with time zone, finish timestamp with time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, timezone text, start timestamp with time zone, finish timestamp with time zone) TO postgres;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, timezone text, start timestamp with time zone, finish timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, timezone text, start timestamp with time zone, finish timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, timezone text, start timestamp with time zone, finish timestamp with time zone) TO service_role;


--
-- TOC entry 7047 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION timescaledb_fdw_handler(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.timescaledb_fdw_handler() TO postgres;
GRANT ALL ON FUNCTION public.timescaledb_fdw_handler() TO anon;
GRANT ALL ON FUNCTION public.timescaledb_fdw_handler() TO authenticated;
GRANT ALL ON FUNCTION public.timescaledb_fdw_handler() TO service_role;


--
-- TOC entry 7048 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION timescaledb_fdw_validator(text[], oid); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.timescaledb_fdw_validator(text[], oid) TO postgres;
GRANT ALL ON FUNCTION public.timescaledb_fdw_validator(text[], oid) TO anon;
GRANT ALL ON FUNCTION public.timescaledb_fdw_validator(text[], oid) TO authenticated;
GRANT ALL ON FUNCTION public.timescaledb_fdw_validator(text[], oid) TO service_role;


--
-- TOC entry 7049 (class 0 OID 0)
-- Dependencies: 607
-- Name: FUNCTION timescaledb_post_restore(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.timescaledb_post_restore() TO postgres;
GRANT ALL ON FUNCTION public.timescaledb_post_restore() TO anon;
GRANT ALL ON FUNCTION public.timescaledb_post_restore() TO authenticated;
GRANT ALL ON FUNCTION public.timescaledb_post_restore() TO service_role;


--
-- TOC entry 7050 (class 0 OID 0)
-- Dependencies: 606
-- Name: FUNCTION timescaledb_pre_restore(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.timescaledb_pre_restore() TO postgres;
GRANT ALL ON FUNCTION public.timescaledb_pre_restore() TO anon;
GRANT ALL ON FUNCTION public.timescaledb_pre_restore() TO authenticated;
GRANT ALL ON FUNCTION public.timescaledb_pre_restore() TO service_role;


--
-- TOC entry 7051 (class 0 OID 0)
-- Dependencies: 1715
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 7052 (class 0 OID 0)
-- Dependencies: 1717
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 7053 (class 0 OID 0)
-- Dependencies: 1713
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 7054 (class 0 OID 0)
-- Dependencies: 1719
-- Name: FUNCTION channel_name(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.channel_name() TO postgres;
GRANT ALL ON FUNCTION realtime.channel_name() TO dashboard_user;


--
-- TOC entry 7055 (class 0 OID 0)
-- Dependencies: 1712
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 7056 (class 0 OID 0)
-- Dependencies: 1716
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 7057 (class 0 OID 0)
-- Dependencies: 1718
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 7058 (class 0 OID 0)
-- Dependencies: 1711
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 7059 (class 0 OID 0)
-- Dependencies: 1710
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 7060 (class 0 OID 0)
-- Dependencies: 1714
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 7061 (class 0 OID 0)
-- Dependencies: 1678
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- TOC entry 7062 (class 0 OID 0)
-- Dependencies: 1679
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO anon;
GRANT ALL ON FUNCTION storage.extension(name text) TO authenticated;
GRANT ALL ON FUNCTION storage.extension(name text) TO service_role;
GRANT ALL ON FUNCTION storage.extension(name text) TO dashboard_user;
GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- TOC entry 7063 (class 0 OID 0)
-- Dependencies: 1680
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO anon;
GRANT ALL ON FUNCTION storage.filename(name text) TO authenticated;
GRANT ALL ON FUNCTION storage.filename(name text) TO service_role;
GRANT ALL ON FUNCTION storage.filename(name text) TO dashboard_user;
GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- TOC entry 7064 (class 0 OID 0)
-- Dependencies: 1681
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO anon;
GRANT ALL ON FUNCTION storage.foldername(name text) TO authenticated;
GRANT ALL ON FUNCTION storage.foldername(name text) TO service_role;
GRANT ALL ON FUNCTION storage.foldername(name text) TO dashboard_user;
GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- TOC entry 7065 (class 0 OID 0)
-- Dependencies: 1682
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- TOC entry 7066 (class 0 OID 0)
-- Dependencies: 1683
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- TOC entry 7067 (class 0 OID 0)
-- Dependencies: 1684
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- TOC entry 7068 (class 0 OID 0)
-- Dependencies: 2761
-- Name: FUNCTION st_3dextent(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dextent(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7069 (class 0 OID 0)
-- Dependencies: 2771
-- Name: FUNCTION st_3dunion(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dunion(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7070 (class 0 OID 0)
-- Dependencies: 2752
-- Name: FUNCTION st_asflatgeobuf(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7071 (class 0 OID 0)
-- Dependencies: 2753
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7072 (class 0 OID 0)
-- Dependencies: 2754
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement, boolean, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7073 (class 0 OID 0)
-- Dependencies: 2764
-- Name: FUNCTION st_asgeobuf(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeobuf(anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7074 (class 0 OID 0)
-- Dependencies: 2765
-- Name: FUNCTION st_asgeobuf(anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeobuf(anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7075 (class 0 OID 0)
-- Dependencies: 2766
-- Name: FUNCTION st_asmvt(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7076 (class 0 OID 0)
-- Dependencies: 2767
-- Name: FUNCTION st_asmvt(anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7077 (class 0 OID 0)
-- Dependencies: 2768
-- Name: FUNCTION st_asmvt(anyelement, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7078 (class 0 OID 0)
-- Dependencies: 2769
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7079 (class 0 OID 0)
-- Dependencies: 2770
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7080 (class 0 OID 0)
-- Dependencies: 2755
-- Name: FUNCTION st_clusterintersecting(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterintersecting(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7081 (class 0 OID 0)
-- Dependencies: 2756
-- Name: FUNCTION st_clusterwithin(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterwithin(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7082 (class 0 OID 0)
-- Dependencies: 2757
-- Name: FUNCTION st_collect(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7083 (class 0 OID 0)
-- Dependencies: 2762
-- Name: FUNCTION st_extent(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_extent(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7084 (class 0 OID 0)
-- Dependencies: 2758
-- Name: FUNCTION st_makeline(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7085 (class 0 OID 0)
-- Dependencies: 2763
-- Name: FUNCTION st_memcollect(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memcollect(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7086 (class 0 OID 0)
-- Dependencies: 2749
-- Name: FUNCTION st_memunion(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memunion(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7087 (class 0 OID 0)
-- Dependencies: 2772
-- Name: FUNCTION st_polygonize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7088 (class 0 OID 0)
-- Dependencies: 2759
-- Name: FUNCTION st_union(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7089 (class 0 OID 0)
-- Dependencies: 2760
-- Name: FUNCTION st_union(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7090 (class 0 OID 0)
-- Dependencies: 2745
-- Name: FUNCTION first(anyelement, "any"); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.first(anyelement, "any") TO postgres;
GRANT ALL ON FUNCTION public.first(anyelement, "any") TO anon;
GRANT ALL ON FUNCTION public.first(anyelement, "any") TO authenticated;
GRANT ALL ON FUNCTION public.first(anyelement, "any") TO service_role;


--
-- TOC entry 7091 (class 0 OID 0)
-- Dependencies: 2747
-- Name: FUNCTION histogram(double precision, double precision, double precision, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.histogram(double precision, double precision, double precision, integer) TO postgres;
GRANT ALL ON FUNCTION public.histogram(double precision, double precision, double precision, integer) TO anon;
GRANT ALL ON FUNCTION public.histogram(double precision, double precision, double precision, integer) TO authenticated;
GRANT ALL ON FUNCTION public.histogram(double precision, double precision, double precision, integer) TO service_role;


--
-- TOC entry 7092 (class 0 OID 0)
-- Dependencies: 2746
-- Name: FUNCTION last(anyelement, "any"); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.last(anyelement, "any") TO postgres;
GRANT ALL ON FUNCTION public.last(anyelement, "any") TO anon;
GRANT ALL ON FUNCTION public.last(anyelement, "any") TO authenticated;
GRANT ALL ON FUNCTION public.last(anyelement, "any") TO service_role;


--
-- TOC entry 7094 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT ALL ON TABLE auth.audit_log_entries TO postgres;


--
-- TOC entry 7096 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.flow_state TO postgres;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 7099 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.identities TO postgres;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 7101 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT ALL ON TABLE auth.instances TO postgres;


--
-- TOC entry 7103 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_amr_claims TO postgres;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 7105 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_challenges TO postgres;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 7107 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.mfa_factors TO postgres;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 7108 (class 0 OID 0)
-- Dependencies: 415
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.one_time_tokens TO postgres;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 7110 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT ALL ON TABLE auth.refresh_tokens TO postgres;


--
-- TOC entry 7112 (class 0 OID 0)
-- Dependencies: 359
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 7114 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.saml_providers TO postgres;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 7116 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.saml_relay_states TO postgres;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 7118 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT ALL ON TABLE auth.schema_migrations TO postgres;


--
-- TOC entry 7121 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sessions TO postgres;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 7123 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sso_domains TO postgres;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 7126 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.sso_providers TO postgres;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 7129 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT ALL ON TABLE auth.users TO postgres;


--
-- TOC entry 7130 (class 0 OID 0)
-- Dependencies: 390
-- Name: TABLE job; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT ON TABLE cron.job TO postgres WITH GRANT OPTION;


--
-- TOC entry 7131 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE job_run_details; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON TABLE cron.job_run_details TO postgres WITH GRANT OPTION;


--
-- TOC entry 7132 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE geography_columns; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.geography_columns TO postgres WITH GRANT OPTION;


--
-- TOC entry 7133 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE geometry_columns; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.geometry_columns TO postgres WITH GRANT OPTION;


--
-- TOC entry 7134 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 7135 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 7136 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE spatial_ref_sys; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.spatial_ref_sys TO postgres WITH GRANT OPTION;


--
-- TOC entry 7137 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- TOC entry 7138 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- TOC entry 7139 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- TOC entry 7140 (class 0 OID 0)
-- Dependencies: 399
-- Name: TABLE account_deletions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.account_deletions TO anon;
GRANT ALL ON TABLE public.account_deletions TO authenticated;
GRANT ALL ON TABLE public.account_deletions TO service_role;


--
-- TOC entry 7141 (class 0 OID 0)
-- Dependencies: 400
-- Name: SEQUENCE account_deletions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.account_deletions_id_seq TO anon;
GRANT ALL ON SEQUENCE public.account_deletions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.account_deletions_id_seq TO service_role;


--
-- TOC entry 7143 (class 0 OID 0)
-- Dependencies: 367
-- Name: TABLE health_medicines; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.health_medicines TO anon;
GRANT ALL ON TABLE public.health_medicines TO authenticated;
GRANT ALL ON TABLE public.health_medicines TO service_role;


--
-- TOC entry 7144 (class 0 OID 0)
-- Dependencies: 368
-- Name: SEQUENCE health_medicines_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.health_medicines_id_seq TO anon;
GRANT ALL ON SEQUENCE public.health_medicines_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.health_medicines_id_seq TO service_role;


--
-- TOC entry 7145 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE health_vaccines; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.health_vaccines TO anon;
GRANT ALL ON TABLE public.health_vaccines TO authenticated;
GRANT ALL ON TABLE public.health_vaccines TO service_role;


--
-- TOC entry 7146 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE locale_cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.locale_cities TO anon;
GRANT ALL ON TABLE public.locale_cities TO authenticated;
GRANT ALL ON TABLE public.locale_cities TO service_role;


--
-- TOC entry 7147 (class 0 OID 0)
-- Dependencies: 371
-- Name: SEQUENCE locale_cities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.locale_cities_id_seq TO anon;
GRANT ALL ON SEQUENCE public.locale_cities_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.locale_cities_id_seq TO service_role;


--
-- TOC entry 7148 (class 0 OID 0)
-- Dependencies: 372
-- Name: TABLE locale_countries; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.locale_countries TO anon;
GRANT ALL ON TABLE public.locale_countries TO authenticated;
GRANT ALL ON TABLE public.locale_countries TO service_role;


--
-- TOC entry 7149 (class 0 OID 0)
-- Dependencies: 373
-- Name: SEQUENCE locale_countries_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.locale_countries_id_seq TO anon;
GRANT ALL ON SEQUENCE public.locale_countries_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.locale_countries_id_seq TO service_role;


--
-- TOC entry 7150 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE locale_states; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.locale_states TO anon;
GRANT ALL ON TABLE public.locale_states TO authenticated;
GRANT ALL ON TABLE public.locale_states TO service_role;


--
-- TOC entry 7151 (class 0 OID 0)
-- Dependencies: 375
-- Name: SEQUENCE locale_states_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.locale_states_id_seq TO anon;
GRANT ALL ON SEQUENCE public.locale_states_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.locale_states_id_seq TO service_role;


--
-- TOC entry 7152 (class 0 OID 0)
-- Dependencies: 376
-- Name: TABLE pets; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pets TO anon;
GRANT ALL ON TABLE public.pets TO authenticated;
GRANT ALL ON TABLE public.pets TO service_role;


--
-- TOC entry 7153 (class 0 OID 0)
-- Dependencies: 377
-- Name: TABLE pets_health; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pets_health TO anon;
GRANT ALL ON TABLE public.pets_health TO authenticated;
GRANT ALL ON TABLE public.pets_health TO service_role;


--
-- TOC entry 7154 (class 0 OID 0)
-- Dependencies: 398
-- Name: TABLE pets_reminders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pets_reminders TO anon;
GRANT ALL ON TABLE public.pets_reminders TO authenticated;
GRANT ALL ON TABLE public.pets_reminders TO service_role;


--
-- TOC entry 7155 (class 0 OID 0)
-- Dependencies: 378
-- Name: TABLE pets_walks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pets_walks TO anon;
GRANT ALL ON TABLE public.pets_walks TO authenticated;
GRANT ALL ON TABLE public.pets_walks TO service_role;


--
-- TOC entry 7156 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE places; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.places TO anon;
GRANT ALL ON TABLE public.places TO authenticated;
GRANT ALL ON TABLE public.places TO service_role;


--
-- TOC entry 7157 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- TOC entry 7158 (class 0 OID 0)
-- Dependencies: 380
-- Name: TABLE user_follows; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_follows TO anon;
GRANT ALL ON TABLE public.user_follows TO authenticated;
GRANT ALL ON TABLE public.user_follows TO service_role;


--
-- TOC entry 7159 (class 0 OID 0)
-- Dependencies: 381
-- Name: SEQUENCE user_follows_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_follows_id_seq TO anon;
GRANT ALL ON SEQUENCE public.user_follows_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.user_follows_id_seq TO service_role;


--
-- TOC entry 7160 (class 0 OID 0)
-- Dependencies: 382
-- Name: TABLE vaccines_doses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vaccines_doses TO anon;
GRANT ALL ON TABLE public.vaccines_doses TO authenticated;
GRANT ALL ON TABLE public.vaccines_doses TO service_role;


--
-- TOC entry 7161 (class 0 OID 0)
-- Dependencies: 416
-- Name: TABLE walks_likes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.walks_likes TO anon;
GRANT ALL ON TABLE public.walks_likes TO authenticated;
GRANT ALL ON TABLE public.walks_likes TO service_role;


--
-- TOC entry 7162 (class 0 OID 0)
-- Dependencies: 410
-- Name: TABLE broadcasts; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.broadcasts TO postgres;
GRANT ALL ON TABLE realtime.broadcasts TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.broadcasts TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.broadcasts TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.broadcasts TO service_role;


--
-- TOC entry 7164 (class 0 OID 0)
-- Dependencies: 409
-- Name: SEQUENCE broadcasts_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.broadcasts_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.broadcasts_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.broadcasts_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.broadcasts_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.broadcasts_id_seq TO service_role;


--
-- TOC entry 7165 (class 0 OID 0)
-- Dependencies: 408
-- Name: TABLE channels; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.channels TO postgres;
GRANT ALL ON TABLE realtime.channels TO dashboard_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE realtime.channels TO anon;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE realtime.channels TO authenticated;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE realtime.channels TO service_role;


--
-- TOC entry 7167 (class 0 OID 0)
-- Dependencies: 407
-- Name: SEQUENCE channels_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.channels_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.channels_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.channels_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.channels_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.channels_id_seq TO service_role;


--
-- TOC entry 7168 (class 0 OID 0)
-- Dependencies: 412
-- Name: TABLE presences; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.presences TO postgres;
GRANT ALL ON TABLE realtime.presences TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.presences TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.presences TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.presences TO service_role;


--
-- TOC entry 7170 (class 0 OID 0)
-- Dependencies: 411
-- Name: SEQUENCE presences_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.presences_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.presences_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.presences_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.presences_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.presences_id_seq TO service_role;


--
-- TOC entry 7171 (class 0 OID 0)
-- Dependencies: 401
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 7172 (class 0 OID 0)
-- Dependencies: 404
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 7173 (class 0 OID 0)
-- Dependencies: 403
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 7175 (class 0 OID 0)
-- Dependencies: 383
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- TOC entry 7176 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- TOC entry 7178 (class 0 OID 0)
-- Dependencies: 385
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- TOC entry 7179 (class 0 OID 0)
-- Dependencies: 413
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 7180 (class 0 OID 0)
-- Dependencies: 414
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4079 (class 826 OID 31470)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 4080 (class 826 OID 31471)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 4078 (class 826 OID 31472)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 4074 (class 826 OID 32083)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 4076 (class 826 OID 32082)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 4075 (class 826 OID 32081)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 4098 (class 826 OID 31473)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 4097 (class 826 OID 31474)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 4095 (class 826 OID 31475)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 4103 (class 826 OID 31476)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4101 (class 826 OID 31477)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4100 (class 826 OID 31478)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4088 (class 826 OID 31479)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4091 (class 826 OID 31480)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4089 (class 826 OID 31481)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4084 (class 826 OID 16839)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;


--
-- TOC entry 4085 (class 826 OID 16838)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES TO pgsodium_keyholder;


--
-- TOC entry 4086 (class 826 OID 29422)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;


--
-- TOC entry 4087 (class 826 OID 29423)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;


--
-- TOC entry 4090 (class 826 OID 29421)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES TO pgsodium_keyiduser;


--
-- TOC entry 4092 (class 826 OID 31482)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4093 (class 826 OID 31483)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4094 (class 826 OID 31484)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4096 (class 826 OID 31485)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4099 (class 826 OID 31486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4102 (class 826 OID 31487)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4082 (class 826 OID 31488)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 4083 (class 826 OID 31489)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 4081 (class 826 OID 31490)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 4104 (class 826 OID 31491)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4105 (class 826 OID 31492)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4077 (class 826 OID 31493)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 5250 (class 3466 OID 31508)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 5255 (class 3466 OID 31640)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 5249 (class 3466 OID 31507)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 5248 (class 3466 OID 31497)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 5251 (class 3466 OID 31509)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 5252 (class 3466 OID 31510)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2024-06-02 14:53:31

--
-- PostgreSQL database dump complete
--

