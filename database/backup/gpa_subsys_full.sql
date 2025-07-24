--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18
-- Dumped by pg_dump version 14.18 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_permissions OWNER TO strapi;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_id_seq OWNER TO strapi;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);


ALTER TABLE public.admin_permissions_role_links OWNER TO strapi;

--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_role_links_id_seq OWNER TO strapi;

--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_roles OWNER TO strapi;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_roles_id_seq OWNER TO strapi;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_users OWNER TO strapi;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO strapi;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_users_roles_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_order double precision,
    user_order double precision
);


ALTER TABLE public.admin_users_roles_links OWNER TO strapi;

--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_users_roles_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_roles_links_id_seq OWNER TO strapi;

--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;


--
-- Name: components_a_features; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_features (
    id integer NOT NULL
);


ALTER TABLE public.components_a_features OWNER TO strapi;

--
-- Name: components_a_features_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_features_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_features_id_seq OWNER TO strapi;

--
-- Name: components_a_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_features_id_seq OWNED BY public.components_a_features.id;


--
-- Name: entitlements; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.entitlements (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    ismetered boolean,
    defaultlimit integer,
    reset_period character varying(255)
);


ALTER TABLE public.entitlements OWNER TO strapi;

--
-- Name: entitlements_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.entitlements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entitlements_id_seq OWNER TO strapi;

--
-- Name: entitlements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.entitlements_id_seq OWNED BY public.entitlements.id;


--
-- Name: features; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.features (
    id integer NOT NULL,
    feature character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    "order" integer
);


ALTER TABLE public.features OWNER TO strapi;

--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.features_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.features_id_seq OWNER TO strapi;

--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- Name: features_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.features_localizations_links (
    id integer NOT NULL,
    feature_id integer,
    inv_feature_id integer,
    feature_order double precision
);


ALTER TABLE public.features_localizations_links OWNER TO strapi;

--
-- Name: features_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.features_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.features_localizations_links_id_seq OWNER TO strapi;

--
-- Name: features_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.features_localizations_links_id_seq OWNED BY public.features_localizations_links.id;


--
-- Name: features_plans_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.features_plans_links (
    id integer NOT NULL,
    feature_id integer,
    plan_id integer,
    plan_order double precision,
    feature_order double precision
);


ALTER TABLE public.features_plans_links OWNER TO strapi;

--
-- Name: features_plans_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.features_plans_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.features_plans_links_id_seq OWNER TO strapi;

--
-- Name: features_plans_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.features_plans_links_id_seq OWNED BY public.features_plans_links.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files (
    id integer NOT NULL,
    name character varying(255),
    alternative_text character varying(255),
    caption character varying(255),
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url character varying(255),
    preview_url character varying(255),
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.files OWNER TO strapi;

--
-- Name: files_folder_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files_folder_links (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_order double precision
);


ALTER TABLE public.files_folder_links OWNER TO strapi;

--
-- Name: files_folder_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_folder_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_folder_links_id_seq OWNER TO strapi;

--
-- Name: files_folder_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_id_seq OWNER TO strapi;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_morphs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files_related_morphs (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.files_related_morphs OWNER TO strapi;

--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_related_morphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_related_morphs_id_seq OWNER TO strapi;

--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.i18n_locale OWNER TO strapi;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i18n_locale_id_seq OWNER TO strapi;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: pings; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.pings (
    id integer NOT NULL,
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.pings OWNER TO strapi;

--
-- Name: pings_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.pings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pings_id_seq OWNER TO strapi;

--
-- Name: pings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.pings_id_seq OWNED BY public.pings.id;


--
-- Name: plan_ent_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.plan_ent_links (
    id integer NOT NULL,
    limit_override integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.plan_ent_links OWNER TO strapi;

--
-- Name: plan_ent_links_entitlement_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.plan_ent_links_entitlement_links (
    id integer NOT NULL,
    plan_ent_link_id integer,
    entitlement_id integer,
    plan_ent_link_order double precision
);


ALTER TABLE public.plan_ent_links_entitlement_links OWNER TO strapi;

--
-- Name: plan_ent_links_entitlement_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.plan_ent_links_entitlement_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plan_ent_links_entitlement_links_id_seq OWNER TO strapi;

--
-- Name: plan_ent_links_entitlement_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.plan_ent_links_entitlement_links_id_seq OWNED BY public.plan_ent_links_entitlement_links.id;


--
-- Name: plan_ent_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.plan_ent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plan_ent_links_id_seq OWNER TO strapi;

--
-- Name: plan_ent_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.plan_ent_links_id_seq OWNED BY public.plan_ent_links.id;


--
-- Name: plan_ent_links_plan_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.plan_ent_links_plan_links (
    id integer NOT NULL,
    plan_ent_link_id integer,
    plan_id integer,
    plan_ent_link_order double precision
);


ALTER TABLE public.plan_ent_links_plan_links OWNER TO strapi;

--
-- Name: plan_ent_links_plan_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.plan_ent_links_plan_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plan_ent_links_plan_links_id_seq OWNER TO strapi;

--
-- Name: plan_ent_links_plan_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.plan_ent_links_plan_links_id_seq OWNED BY public.plan_ent_links_plan_links.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.plans (
    id integer NOT NULL,
    name character varying(255),
    product_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    sale_product_id character varying(255),
    sale_start_date timestamp(6) without time zone,
    sale_end_date timestamp(6) without time zone,
    "order" integer,
    role character varying(255)
);


ALTER TABLE public.plans OWNER TO strapi;

--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plans_id_seq OWNER TO strapi;

--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;


--
-- Name: plans_inherit_from_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.plans_inherit_from_links (
    id integer NOT NULL,
    plan_id integer,
    inv_plan_id integer,
    plan_order double precision
);


ALTER TABLE public.plans_inherit_from_links OWNER TO strapi;

--
-- Name: plans_inherit_from_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.plans_inherit_from_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plans_inherit_from_links_id_seq OWNER TO strapi;

--
-- Name: plans_inherit_from_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.plans_inherit_from_links_id_seq OWNED BY public.plans_inherit_from_links.id;


--
-- Name: plans_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.plans_localizations_links (
    id integer NOT NULL,
    plan_id integer,
    inv_plan_id integer,
    plan_order double precision
);


ALTER TABLE public.plans_localizations_links OWNER TO strapi;

--
-- Name: plans_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.plans_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plans_localizations_links_id_seq OWNER TO strapi;

--
-- Name: plans_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.plans_localizations_links_id_seq OWNED BY public.plans_localizations_links.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_api_token_permissions OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_id_seq OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_token_permissions_token_links (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_order double precision
);


ALTER TABLE public.strapi_api_token_permissions_token_links OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_token_links_id_seq OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_api_tokens OWNER TO strapi;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_tokens_id_seq OWNER TO strapi;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.strapi_core_store_settings OWNER TO strapi;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_core_store_settings_id_seq OWNER TO strapi;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


ALTER TABLE public.strapi_database_schema OWNER TO strapi;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_database_schema_id_seq OWNER TO strapi;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations OWNER TO strapi;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_id_seq OWNER TO strapi;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_transfer_token_permissions OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_token_permissions_token_links (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_order double precision
);


ALTER TABLE public.strapi_transfer_token_permissions_token_links OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_token_links_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_transfer_tokens OWNER TO strapi;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_tokens_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_webhooks_id_seq OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    strapi_user_id integer,
    status character varying(255),
    expire_date timestamp(6) without time zone,
    original_transaction_id character varying(255),
    latest_transaction_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    start_date timestamp(6) without time zone
);


ALTER TABLE public.subscriptions OWNER TO strapi;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_id_seq OWNER TO strapi;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: subscriptions_plan_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.subscriptions_plan_links (
    id integer NOT NULL,
    subscription_id integer,
    plan_id integer,
    subscription_order double precision
);


ALTER TABLE public.subscriptions_plan_links OWNER TO strapi;

--
-- Name: subscriptions_plan_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.subscriptions_plan_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_plan_links_id_seq OWNER TO strapi;

--
-- Name: subscriptions_plan_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.subscriptions_plan_links_id_seq OWNED BY public.subscriptions_plan_links.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_permissions OWNER TO strapi;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_id_seq OWNER TO strapi;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);


ALTER TABLE public.up_permissions_role_links OWNER TO strapi;

--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_role_links_id_seq OWNER TO strapi;

--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_roles OWNER TO strapi;

--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_roles_id_seq OWNER TO strapi;

--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_users OWNER TO strapi;

--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_id_seq OWNER TO strapi;

--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_role_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_users_role_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_order double precision
);


ALTER TABLE public.up_users_role_links OWNER TO strapi;

--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_users_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_role_links_id_seq OWNER TO strapi;

--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.upload_folders OWNER TO strapi;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_id_seq OWNER TO strapi;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_folders_parent_links (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_order double precision
);


ALTER TABLE public.upload_folders_parent_links OWNER TO strapi;

--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_folders_parent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_parent_links_id_seq OWNER TO strapi;

--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;


--
-- Name: usageledgers; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usageledgers (
    id integer NOT NULL,
    strapi_user_id integer,
    consumed_at timestamp(6) without time zone,
    amount integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.usageledgers OWNER TO strapi;

--
-- Name: usageledgers_entitlement_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usageledgers_entitlement_links (
    id integer NOT NULL,
    usageledger_id integer,
    entitlement_id integer,
    usageledger_order double precision
);


ALTER TABLE public.usageledgers_entitlement_links OWNER TO strapi;

--
-- Name: usageledgers_entitlement_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usageledgers_entitlement_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usageledgers_entitlement_links_id_seq OWNER TO strapi;

--
-- Name: usageledgers_entitlement_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usageledgers_entitlement_links_id_seq OWNED BY public.usageledgers_entitlement_links.id;


--
-- Name: usageledgers_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usageledgers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usageledgers_id_seq OWNER TO strapi;

--
-- Name: usageledgers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usageledgers_id_seq OWNED BY public.usageledgers.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);


--
-- Name: components_a_features id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_features ALTER COLUMN id SET DEFAULT nextval('public.components_a_features_id_seq'::regclass);


--
-- Name: entitlements id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.entitlements ALTER COLUMN id SET DEFAULT nextval('public.entitlements_id_seq'::regclass);


--
-- Name: features id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- Name: features_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.features_localizations_links_id_seq'::regclass);


--
-- Name: features_plans_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_plans_links ALTER COLUMN id SET DEFAULT nextval('public.features_plans_links_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);


--
-- Name: files_related_morphs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: pings id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.pings ALTER COLUMN id SET DEFAULT nextval('public.pings_id_seq'::regclass);


--
-- Name: plan_ent_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links ALTER COLUMN id SET DEFAULT nextval('public.plan_ent_links_id_seq'::regclass);


--
-- Name: plan_ent_links_entitlement_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_entitlement_links ALTER COLUMN id SET DEFAULT nextval('public.plan_ent_links_entitlement_links_id_seq'::regclass);


--
-- Name: plan_ent_links_plan_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_plan_links ALTER COLUMN id SET DEFAULT nextval('public.plan_ent_links_plan_links_id_seq'::regclass);


--
-- Name: plans id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);


--
-- Name: plans_inherit_from_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_inherit_from_links ALTER COLUMN id SET DEFAULT nextval('public.plans_inherit_from_links_id_seq'::regclass);


--
-- Name: plans_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.plans_localizations_links_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: subscriptions_plan_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions_plan_links ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_plan_links_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_role_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);


--
-- Name: usageledgers id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers ALTER COLUMN id SET DEFAULT nextval('public.usageledgers_id_seq'::regclass);


--
-- Name: usageledgers_entitlement_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers_entitlement_links ALTER COLUMN id SET DEFAULT nextval('public.usageledgers_entitlement_links_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	plugin::upload.read	{}	\N	{}	[]	2025-07-04 13:47:48.832	2025-07-04 13:47:48.832	\N	\N
2	plugin::upload.configure-view	{}	\N	{}	[]	2025-07-04 13:47:49.005	2025-07-04 13:47:49.005	\N	\N
3	plugin::upload.assets.create	{}	\N	{}	[]	2025-07-04 13:47:49.188	2025-07-04 13:47:49.188	\N	\N
4	plugin::upload.assets.update	{}	\N	{}	[]	2025-07-04 13:47:49.378	2025-07-04 13:47:49.378	\N	\N
5	plugin::upload.assets.download	{}	\N	{}	[]	2025-07-04 13:47:49.56	2025-07-04 13:47:49.56	\N	\N
6	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-07-04 13:47:49.741	2025-07-04 13:47:49.741	\N	\N
7	plugin::upload.read	{}	\N	{}	["admin::is-creator"]	2025-07-04 13:47:49.916	2025-07-04 13:47:49.916	\N	\N
8	plugin::upload.configure-view	{}	\N	{}	[]	2025-07-04 13:47:50.091	2025-07-04 13:47:50.091	\N	\N
9	plugin::upload.assets.create	{}	\N	{}	[]	2025-07-04 13:47:50.275	2025-07-04 13:47:50.275	\N	\N
10	plugin::upload.assets.update	{}	\N	{}	["admin::is-creator"]	2025-07-04 13:47:50.454	2025-07-04 13:47:50.454	\N	\N
11	plugin::upload.assets.download	{}	\N	{}	[]	2025-07-04 13:47:50.644	2025-07-04 13:47:50.644	\N	\N
12	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-07-04 13:47:50.821	2025-07-04 13:47:50.821	\N	\N
13	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2025-07-04 13:47:51.157	2025-07-04 13:47:51.157	\N	\N
14	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2025-07-04 13:47:51.336	2025-07-04 13:47:51.336	\N	\N
15	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2025-07-04 13:47:51.506	2025-07-04 13:47:51.506	\N	\N
16	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2025-07-04 13:47:51.685	2025-07-04 13:47:51.685	\N	\N
17	plugin::content-manager.single-types.configure-view	{}	\N	{}	[]	2025-07-04 13:47:51.87	2025-07-04 13:47:51.87	\N	\N
18	plugin::content-manager.collection-types.configure-view	{}	\N	{}	[]	2025-07-04 13:47:52.046	2025-07-04 13:47:52.046	\N	\N
19	plugin::content-manager.components.configure-layout	{}	\N	{}	[]	2025-07-04 13:47:52.237	2025-07-04 13:47:52.237	\N	\N
20	plugin::content-type-builder.read	{}	\N	{}	[]	2025-07-04 13:47:52.42	2025-07-04 13:47:52.42	\N	\N
21	plugin::email.settings.read	{}	\N	{}	[]	2025-07-04 13:47:52.603	2025-07-04 13:47:52.603	\N	\N
22	plugin::upload.read	{}	\N	{}	[]	2025-07-04 13:47:52.784	2025-07-04 13:47:52.784	\N	\N
23	plugin::upload.assets.create	{}	\N	{}	[]	2025-07-04 13:47:52.966	2025-07-04 13:47:52.966	\N	\N
24	plugin::upload.assets.update	{}	\N	{}	[]	2025-07-04 13:47:53.157	2025-07-04 13:47:53.157	\N	\N
25	plugin::upload.assets.download	{}	\N	{}	[]	2025-07-04 13:47:53.343	2025-07-04 13:47:53.343	\N	\N
26	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-07-04 13:47:53.525	2025-07-04 13:47:53.525	\N	\N
27	plugin::upload.configure-view	{}	\N	{}	[]	2025-07-04 13:47:53.706	2025-07-04 13:47:53.706	\N	\N
28	plugin::upload.settings.read	{}	\N	{}	[]	2025-07-04 13:47:53.888	2025-07-04 13:47:53.888	\N	\N
29	plugin::users-permissions.roles.create	{}	\N	{}	[]	2025-07-04 13:47:54.057	2025-07-04 13:47:54.057	\N	\N
30	plugin::users-permissions.roles.read	{}	\N	{}	[]	2025-07-04 13:47:54.238	2025-07-04 13:47:54.238	\N	\N
31	plugin::users-permissions.roles.update	{}	\N	{}	[]	2025-07-04 13:47:54.418	2025-07-04 13:47:54.418	\N	\N
32	plugin::users-permissions.roles.delete	{}	\N	{}	[]	2025-07-04 13:47:54.598	2025-07-04 13:47:54.598	\N	\N
33	plugin::users-permissions.providers.read	{}	\N	{}	[]	2025-07-04 13:47:54.788	2025-07-04 13:47:54.788	\N	\N
34	plugin::users-permissions.providers.update	{}	\N	{}	[]	2025-07-04 13:47:54.976	2025-07-04 13:47:54.976	\N	\N
35	plugin::users-permissions.email-templates.read	{}	\N	{}	[]	2025-07-04 13:47:55.151	2025-07-04 13:47:55.151	\N	\N
36	plugin::users-permissions.email-templates.update	{}	\N	{}	[]	2025-07-04 13:47:55.331	2025-07-04 13:47:55.331	\N	\N
37	plugin::users-permissions.advanced-settings.read	{}	\N	{}	[]	2025-07-04 13:47:55.51	2025-07-04 13:47:55.51	\N	\N
38	plugin::users-permissions.advanced-settings.update	{}	\N	{}	[]	2025-07-04 13:47:55.69	2025-07-04 13:47:55.69	\N	\N
39	plugin::i18n.locale.create	{}	\N	{}	[]	2025-07-04 13:47:55.869	2025-07-04 13:47:55.869	\N	\N
40	plugin::i18n.locale.read	{}	\N	{}	[]	2025-07-04 13:47:56.052	2025-07-04 13:47:56.052	\N	\N
41	plugin::i18n.locale.update	{}	\N	{}	[]	2025-07-04 13:47:56.233	2025-07-04 13:47:56.233	\N	\N
42	plugin::i18n.locale.delete	{}	\N	{}	[]	2025-07-04 13:47:56.413	2025-07-04 13:47:56.413	\N	\N
43	admin::marketplace.read	{}	\N	{}	[]	2025-07-04 13:47:56.593	2025-07-04 13:47:56.593	\N	\N
44	admin::webhooks.create	{}	\N	{}	[]	2025-07-04 13:47:56.774	2025-07-04 13:47:56.774	\N	\N
45	admin::webhooks.read	{}	\N	{}	[]	2025-07-04 13:47:56.957	2025-07-04 13:47:56.957	\N	\N
46	admin::webhooks.update	{}	\N	{}	[]	2025-07-04 13:47:57.139	2025-07-04 13:47:57.139	\N	\N
47	admin::webhooks.delete	{}	\N	{}	[]	2025-07-04 13:47:57.318	2025-07-04 13:47:57.318	\N	\N
48	admin::users.create	{}	\N	{}	[]	2025-07-04 13:47:57.498	2025-07-04 13:47:57.498	\N	\N
49	admin::users.read	{}	\N	{}	[]	2025-07-04 13:47:57.68	2025-07-04 13:47:57.68	\N	\N
50	admin::users.update	{}	\N	{}	[]	2025-07-04 13:47:57.857	2025-07-04 13:47:57.857	\N	\N
51	admin::users.delete	{}	\N	{}	[]	2025-07-04 13:47:58.038	2025-07-04 13:47:58.038	\N	\N
52	admin::roles.create	{}	\N	{}	[]	2025-07-04 13:47:58.217	2025-07-04 13:47:58.217	\N	\N
53	admin::roles.read	{}	\N	{}	[]	2025-07-04 13:47:58.393	2025-07-04 13:47:58.393	\N	\N
54	admin::roles.update	{}	\N	{}	[]	2025-07-04 13:47:58.573	2025-07-04 13:47:58.573	\N	\N
55	admin::roles.delete	{}	\N	{}	[]	2025-07-04 13:47:58.743	2025-07-04 13:47:58.743	\N	\N
56	admin::api-tokens.access	{}	\N	{}	[]	2025-07-04 13:47:58.936	2025-07-04 13:47:58.936	\N	\N
57	admin::api-tokens.create	{}	\N	{}	[]	2025-07-04 13:47:59.101	2025-07-04 13:47:59.101	\N	\N
58	admin::api-tokens.read	{}	\N	{}	[]	2025-07-04 13:47:59.274	2025-07-04 13:47:59.274	\N	\N
59	admin::api-tokens.update	{}	\N	{}	[]	2025-07-04 13:47:59.456	2025-07-04 13:47:59.456	\N	\N
60	admin::api-tokens.regenerate	{}	\N	{}	[]	2025-07-04 13:47:59.641	2025-07-04 13:47:59.641	\N	\N
61	admin::api-tokens.delete	{}	\N	{}	[]	2025-07-04 13:47:59.82	2025-07-04 13:47:59.82	\N	\N
62	admin::project-settings.update	{}	\N	{}	[]	2025-07-04 13:48:00.005	2025-07-04 13:48:00.005	\N	\N
63	admin::project-settings.read	{}	\N	{}	[]	2025-07-04 13:48:00.175	2025-07-04 13:48:00.175	\N	\N
64	admin::transfer.tokens.access	{}	\N	{}	[]	2025-07-04 13:48:00.358	2025-07-04 13:48:00.358	\N	\N
65	admin::transfer.tokens.create	{}	\N	{}	[]	2025-07-04 13:48:00.536	2025-07-04 13:48:00.536	\N	\N
66	admin::transfer.tokens.read	{}	\N	{}	[]	2025-07-04 13:48:00.718	2025-07-04 13:48:00.718	\N	\N
67	admin::transfer.tokens.update	{}	\N	{}	[]	2025-07-04 13:48:00.881	2025-07-04 13:48:00.881	\N	\N
68	admin::transfer.tokens.regenerate	{}	\N	{}	[]	2025-07-04 13:48:01.064	2025-07-04 13:48:01.064	\N	\N
69	admin::transfer.tokens.delete	{}	\N	{}	[]	2025-07-04 13:48:01.243	2025-07-04 13:48:01.243	\N	\N
73	plugin::content-manager.explorer.delete	{}	api::plan.plan	{"locales": ["en"]}	[]	2025-07-04 15:09:06.125	2025-07-04 15:09:06.125	\N	\N
77	plugin::content-manager.explorer.delete	{}	api::entitlement.entitlement	{}	[]	2025-07-04 15:10:07.509	2025-07-04 15:10:07.509	\N	\N
94	plugin::content-manager.explorer.delete	{}	api::subscription.subscription	{}	[]	2025-07-04 15:29:11.944	2025-07-04 15:29:11.944	\N	\N
95	plugin::content-manager.explorer.create	{}	api::subscription.subscription	{"fields": ["strapiUserId", "plan", "status", "expireDate", "originalTransactionId", "latestTransactionId", "startDate"]}	[]	2025-07-04 20:36:23.845	2025-07-04 20:36:23.845	\N	\N
96	plugin::content-manager.explorer.read	{}	api::subscription.subscription	{"fields": ["strapiUserId", "plan", "status", "expireDate", "originalTransactionId", "latestTransactionId", "startDate"]}	[]	2025-07-04 20:36:24.081	2025-07-04 20:36:24.081	\N	\N
97	plugin::content-manager.explorer.update	{}	api::subscription.subscription	{"fields": ["strapiUserId", "plan", "status", "expireDate", "originalTransactionId", "latestTransactionId", "startDate"]}	[]	2025-07-04 20:36:24.653	2025-07-04 20:36:24.653	\N	\N
101	plugin::content-manager.explorer.delete	{}	api::feature.feature	{"locales": ["en"]}	[]	2025-07-05 17:33:41.113	2025-07-05 17:33:41.113	\N	\N
108	plugin::content-manager.explorer.create	{}	api::feature.feature	{"fields": ["feature", "plans", "order"], "locales": ["en"]}	[]	2025-07-05 17:43:32.607	2025-07-05 17:43:32.607	\N	\N
109	plugin::content-manager.explorer.read	{}	api::feature.feature	{"fields": ["feature", "plans", "order"], "locales": ["en"]}	[]	2025-07-05 17:43:32.777	2025-07-05 17:43:32.777	\N	\N
110	plugin::content-manager.explorer.update	{}	api::feature.feature	{"fields": ["feature", "plans", "order"], "locales": ["en"]}	[]	2025-07-05 17:43:32.951	2025-07-05 17:43:32.951	\N	\N
112	plugin::content-manager.explorer.create	{}	api::usageledger.usageledger	{"fields": ["strapiUserId", "entitlement", "consumedAt", "amount"]}	[]	2025-07-05 19:03:54.729	2025-07-05 19:03:54.729	\N	\N
114	plugin::content-manager.explorer.read	{}	api::usageledger.usageledger	{"fields": ["strapiUserId", "entitlement", "consumedAt", "amount"]}	[]	2025-07-05 19:03:55.068	2025-07-05 19:03:55.068	\N	\N
116	plugin::content-manager.explorer.update	{}	api::usageledger.usageledger	{"fields": ["strapiUserId", "entitlement", "consumedAt", "amount"]}	[]	2025-07-05 19:03:55.419	2025-07-05 19:03:55.419	\N	\N
117	plugin::content-manager.explorer.delete	{}	api::usageledger.usageledger	{}	[]	2025-07-05 19:03:55.591	2025-07-05 19:03:55.591	\N	\N
123	plugin::content-manager.explorer.create	{}	api::plan-ent-link.plan-ent-link	{"fields": ["plan", "entitlement", "limitOverride"]}	[]	2025-07-05 21:05:33.949	2025-07-05 21:05:33.949	\N	\N
126	plugin::content-manager.explorer.read	{}	api::plan-ent-link.plan-ent-link	{"fields": ["plan", "entitlement", "limitOverride"]}	[]	2025-07-05 21:05:34.483	2025-07-05 21:05:34.483	\N	\N
129	plugin::content-manager.explorer.update	{}	api::plan-ent-link.plan-ent-link	{"fields": ["plan", "entitlement", "limitOverride"]}	[]	2025-07-05 21:05:35.02	2025-07-05 21:05:35.02	\N	\N
130	plugin::content-manager.explorer.delete	{}	api::plan-ent-link.plan-ent-link	{}	[]	2025-07-05 21:05:35.198	2025-07-05 21:05:35.198	\N	\N
131	plugin::content-manager.explorer.create	{}	api::entitlement.entitlement	{"fields": ["name", "slug", "usageledgers", "ismetered", "defaultlimit", "resetPeriod", "plan_ent_links"]}	[]	2025-07-05 21:23:10.109	2025-07-05 21:23:10.109	\N	\N
133	plugin::content-manager.explorer.read	{}	api::entitlement.entitlement	{"fields": ["name", "slug", "usageledgers", "ismetered", "defaultlimit", "resetPeriod", "plan_ent_links"]}	[]	2025-07-05 21:23:10.468	2025-07-05 21:23:10.468	\N	\N
135	plugin::content-manager.explorer.update	{}	api::entitlement.entitlement	{"fields": ["name", "slug", "usageledgers", "ismetered", "defaultlimit", "resetPeriod", "plan_ent_links"]}	[]	2025-07-05 21:23:10.819	2025-07-05 21:23:10.819	\N	\N
144	plugin::content-manager.explorer.create	{}	api::ping.ping	{"fields": ["status"]}	[]	2025-07-23 09:41:28.193	2025-07-23 09:41:28.193	\N	\N
145	plugin::content-manager.explorer.read	{}	api::ping.ping	{"fields": ["status"]}	[]	2025-07-23 09:41:28.367	2025-07-23 09:41:28.367	\N	\N
146	plugin::content-manager.explorer.update	{}	api::ping.ping	{"fields": ["status"]}	[]	2025-07-23 09:41:28.532	2025-07-23 09:41:28.532	\N	\N
147	plugin::content-manager.explorer.delete	{}	api::ping.ping	{}	[]	2025-07-23 09:41:28.707	2025-07-23 09:41:28.707	\N	\N
148	plugin::content-manager.explorer.create	{}	api::plan.plan	{"fields": ["name", "productId", "inherit_from", "childPlans", "saleProductId", "saleStartDate", "saleEndDate", "subscriptions", "features", "plan_ent_links", "order", "role"], "locales": ["en"]}	[]	2025-07-23 21:47:45.355	2025-07-23 21:47:45.355	\N	\N
149	plugin::content-manager.explorer.read	{}	api::plan.plan	{"fields": ["name", "productId", "inherit_from", "childPlans", "saleProductId", "saleStartDate", "saleEndDate", "subscriptions", "features", "plan_ent_links", "order", "role"], "locales": ["en"]}	[]	2025-07-23 21:47:45.505	2025-07-23 21:47:45.505	\N	\N
150	plugin::content-manager.explorer.update	{}	api::plan.plan	{"fields": ["name", "productId", "inherit_from", "childPlans", "saleProductId", "saleStartDate", "saleEndDate", "subscriptions", "features", "plan_ent_links", "order", "role"], "locales": ["en"]}	[]	2025-07-23 21:47:45.671	2025-07-23 21:47:45.671	\N	\N
\.


--
-- Data for Name: admin_permissions_role_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
1	1	2	1
2	2	2	2
3	3	2	3
4	4	2	4
5	5	2	5
6	6	2	6
7	7	3	1
8	8	3	2
9	9	3	3
10	10	3	4
11	11	3	5
12	12	3	6
13	13	1	1
14	14	1	2
15	15	1	3
16	16	1	4
17	17	1	5
18	18	1	6
19	19	1	7
20	20	1	8
21	21	1	9
22	22	1	10
23	23	1	11
24	24	1	12
25	25	1	13
26	26	1	14
27	27	1	15
28	28	1	16
29	29	1	17
30	30	1	18
31	31	1	19
32	32	1	20
33	33	1	21
34	34	1	22
35	35	1	23
36	36	1	24
37	37	1	25
38	38	1	26
39	39	1	27
40	40	1	28
41	41	1	29
42	42	1	30
43	43	1	31
44	44	1	32
45	45	1	33
46	46	1	34
47	47	1	35
48	48	1	36
49	49	1	37
50	50	1	38
51	51	1	39
52	52	1	40
53	53	1	41
54	54	1	42
55	55	1	43
56	56	1	44
57	57	1	45
58	58	1	46
59	59	1	47
60	60	1	48
61	61	1	49
62	62	1	50
63	63	1	51
64	64	1	52
65	65	1	53
66	66	1	54
67	67	1	55
68	68	1	56
69	69	1	57
73	73	1	61
77	77	1	65
94	94	1	77
95	95	1	78
96	96	1	79
97	97	1	80
101	101	1	84
108	108	1	91
109	109	1	92
110	110	1	93
112	112	1	95
114	114	1	97
116	116	1	99
117	117	1	100
123	123	1	103
126	126	1	106
129	129	1	109
130	130	1	110
131	131	1	111
133	133	1	113
135	135	1	115
144	144	1	119
145	145	1	120
146	146	1	121
147	147	1	122
148	148	1	123
149	149	1	124
150	150	1	125
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2025-07-04 13:47:48.354	2025-07-04 13:47:48.354	\N	\N
2	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2025-07-04 13:47:48.546	2025-07-04 13:47:48.546	\N	\N
3	Author	strapi-author	Authors can manage the content they have created.	2025-07-04 13:47:48.702	2025-07-04 13:47:48.702	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	admin	gpa	\N	support@geniusparentingai.ca	$2a$10$T2GAR7rdyRIBA8dfOtloFuVR8jZCZ9MsqiU6lN1OE0pi.N1cKCSZ6	\N	\N	t	f	\N	2025-07-04 13:56:31.331	2025-07-23 08:58:59.05	\N	\N
\.


--
-- Data for Name: admin_users_roles_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
1	1	1	1	1
\.


--
-- Data for Name: components_a_features; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_features (id) FROM stdin;
1
3
6
4
5
7
9
11
8
10
12
2
\.


--
-- Data for Name: entitlements; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.entitlements (id, name, slug, created_at, updated_at, created_by_id, updated_by_id, ismetered, defaultlimit, reset_period) FROM stdin;
1	basic courses	basic-courses	2025-07-04 15:32:12.339	2025-07-04 15:32:12.339	1	1	\N	\N	\N
2	membership courses	membership-courses	2025-07-04 15:32:34.753	2025-07-04 15:32:34.753	1	1	\N	\N	\N
3	parenting tools	parenting-tools	2025-07-04 15:32:55.582	2025-07-04 15:32:55.582	1	1	\N	\N	\N
4	community post	community-post	2025-07-04 15:33:17.674	2025-07-04 15:33:17.674	1	1	\N	\N	\N
5	AI chatbot	ai-chatbot	2025-07-04 15:33:31.991	2025-07-11 14:18:50.276	1	1	t	5	day
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.features (id, feature, created_at, updated_at, created_by_id, updated_by_id, locale, "order") FROM stdin;
9	Learning from parenting tools	2025-07-05 17:42:14.393	2025-07-05 17:53:50.54	1	1	en	9
8	Learning Hot topics every day	2025-07-05 17:41:42.641	2025-07-05 17:54:06.074	1	1	en	8
1	Learning from basic parenting courses	2025-07-05 17:35:56.786	2025-07-05 17:54:16.952	1	1	en	1
2	Learning membership course	2025-07-05 17:36:32.837	2025-07-05 17:54:24.544	1	1	en	2
3	Talk to AI Parenting Consulting	2025-07-05 17:37:27.583	2025-07-05 17:54:47.487	1	1	en	3
4	Share experience in community	2025-07-05 17:38:09.064	2025-07-05 17:54:56.577	1	1	en	4
5	Get daily tips on parenting	2025-07-05 17:39:04.14	2025-07-05 17:55:06.733	1	1	en	5
6	Consulting experts	2025-07-05 17:40:31.524	2025-07-05 17:55:14.812	1	1	en	6
7	Eligible for Offline events	2025-07-05 17:40:53.675	2025-07-05 17:55:24.823	1	1	en	7
\.


--
-- Data for Name: features_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.features_localizations_links (id, feature_id, inv_feature_id, feature_order) FROM stdin;
\.


--
-- Data for Name: features_plans_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.features_plans_links (id, feature_id, plan_id, plan_order, feature_order) FROM stdin;
1	9	1	1	1
2	8	1	1	2
3	1	1	1	3
4	2	2	1	1
5	3	1	1	4
6	4	1	1	5
7	5	1	1	6
8	6	3	1	1
9	7	3	1	2
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: files_folder_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
\.


--
-- Data for Name: files_related_morphs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	English (en)	en	2025-07-04 13:47:47.995	2025-07-04 13:47:47.995	\N	\N
\.


--
-- Data for Name: pings; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.pings (id, status, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: plan_ent_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plan_ent_links (id, limit_override, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
2	20	2025-07-05 21:48:48.885	2025-07-05 21:48:48.885	1	1
3	50	2025-07-05 21:49:12.25	2025-07-05 21:49:12.25	1	1
4	\N	2025-07-05 22:08:37.782	2025-07-05 22:08:37.782	1	1
5	\N	2025-07-05 22:08:59.872	2025-07-05 22:08:59.872	1	1
6	\N	2025-07-05 22:09:34.888	2025-07-05 22:09:34.888	1	1
7	\N	2025-07-05 22:09:45.764	2025-07-05 22:09:45.764	1	1
1	5	2025-07-05 21:48:19.003	2025-07-05 22:35:28.042	1	1
\.


--
-- Data for Name: plan_ent_links_entitlement_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plan_ent_links_entitlement_links (id, plan_ent_link_id, entitlement_id, plan_ent_link_order) FROM stdin;
1	1	5	1
2	2	5	2
3	3	5	3
4	4	1	1
5	5	4	1
6	6	2	1
7	7	3	1
\.


--
-- Data for Name: plan_ent_links_plan_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plan_ent_links_plan_links (id, plan_ent_link_id, plan_id, plan_ent_link_order) FROM stdin;
3	3	3	1
4	4	1	1
7	7	1	2
2	2	2	1
5	5	2	2
6	6	2	3
8	1	1	3
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plans (id, name, product_id, created_at, updated_at, created_by_id, updated_by_id, locale, sale_product_id, sale_start_date, sale_end_date, "order", role) FROM stdin;
1	Free Plan	gpa-free-plan	2025-07-04 16:08:44.044	2025-07-23 21:49:25.848	1	1	en	\N	\N	\N	1	free
2	Basic monthly plan	basic-monthly-plan	2025-07-04 16:16:32.586	2025-07-23 21:49:35.3	1	1	en	\N	\N	\N	2	basic
3	Premium Yearly Plan	gpa-premium-yearly-plan	2025-07-04 16:18:29.184	2025-07-23 21:49:45.324	1	1	en	\N	\N	\N	3	premium
\.


--
-- Data for Name: plans_inherit_from_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plans_inherit_from_links (id, plan_id, inv_plan_id, plan_order) FROM stdin;
1	2	1	1
2	3	2	1
\.


--
-- Data for Name: plans_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plans_localizations_links (id, plan_id, inv_plan_id, plan_order) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	server-to-server		full-access	8dcf40ddfaa3b509b912ec00a8563df27c5762ada955d61a27e0e7efe38f7288300b3c674d93f4303e17f14cad50b691d430afc7ab018f8f81a9fe8358609876	\N	\N	\N	2025-07-04 16:55:52.718	2025-07-04 16:56:03.544	\N	\N
2	new-key		full-access	e8dc50b979ec6b755e6e286f5cf27b9d4561b9254652e4bffe0e00987599ec6aad0c8ec7c33ecd189be0d96805ea3dab206abefac797ba1d34ff6276ee8c0e2b	\N	\N	\N	2025-07-06 18:49:45.951	2025-07-06 18:49:55.282	\N	\N
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
2	plugin_content_manager_configuration_content_types::admin::user	{"uid":"admin::user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]}}	object	\N	\N
3	plugin_content_manager_configuration_content_types::admin::api-token	{"uid":"admin::api-token","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"lastUsedAt","size":6},{"name":"permissions","size":6}],[{"name":"expiresAt","size":6},{"name":"lifespan","size":4}]]}}	object	\N	\N
5	plugin_content_manager_configuration_content_types::admin::role	{"uid":"admin::role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]}}	object	\N	\N
4	plugin_content_manager_configuration_content_types::admin::permission	{"uid":"admin::permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]}}	object	\N	\N
7	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"uid":"admin::transfer-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
6	plugin_content_manager_configuration_content_types::admin::transfer-token	{"uid":"admin::transfer-token","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]}}	object	\N	\N
8	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"uid":"plugin::users-permissions.permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]}}	object	\N	\N
9	plugin_content_manager_configuration_content_types::plugin::upload.file	{"uid":"plugin::upload.file","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]}}	object	\N	\N
15	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false}	object	\N	\N
16	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object	\N	\N
10	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"uid":"admin::api-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
28	plugin_content_manager_configuration_content_types::api::feature.feature	{"uid":"api::feature.feature","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"feature","defaultSortBy":"feature","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"feature":{"edit":{"label":"feature","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"feature","searchable":true,"sortable":true}},"plans":{"edit":{"label":"plans","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"plans","searchable":false,"sortable":false}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"feature","size":6},{"name":"plans","size":6}],[{"name":"order","size":4}]],"list":["id","order","feature"]}}	object	\N	\N
17	plugin_upload_metrics	{"weeklySchedule":"4 55 13 * * 5","lastWeeklyUpdate":1752872104293}	object	\N	\N
14	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"uid":"plugin::users-permissions.user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}]]}}	object	\N	\N
13	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"uid":"plugin::i18n.locale","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]}}	object	\N	\N
29	plugin_content_manager_configuration_content_types::api::usageledger.usageledger	{"uid":"api::usageledger.usageledger","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"entitlement":{"edit":{"label":"entitlement","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"entitlement","searchable":true,"sortable":true}},"consumedAt":{"edit":{"label":"consumedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"consumedAt","searchable":true,"sortable":true}},"amount":{"edit":{"label":"amount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"amount","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","strapiUserId","entitlement","consumedAt"],"edit":[[{"name":"strapiUserId","size":4},{"name":"entitlement","size":6}],[{"name":"consumedAt","size":6},{"name":"amount","size":4}]]}}	object	\N	\N
32	plugin_content_manager_configuration_content_types::api::ping.ping	{"uid":"api::ping.ping","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"status","defaultSortBy":"status","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","status","createdAt","updatedAt"],"edit":[[{"name":"status","size":6}]]}}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"uid":"plugin::users-permissions.role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]}}	object	\N	\N
30	plugin_content_manager_configuration_content_types::api::plan-ent-link.plan-ent-link	{"uid":"api::plan-ent-link.plan-ent-link","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"plan":{"edit":{"label":"plan","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"plan","searchable":true,"sortable":true}},"entitlement":{"edit":{"label":"entitlement","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"entitlement","searchable":true,"sortable":true}},"limitOverride":{"edit":{"label":"limitOverride","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"limitOverride","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","plan","entitlement","limitOverride"],"edit":[[{"name":"plan","size":6},{"name":"entitlement","size":6}],[{"name":"limitOverride","size":4}]]}}	object	\N	\N
18	plugin_users-permissions_grant	{"email":{"enabled":true,"icon":"envelope"},"discord":{"enabled":false,"icon":"discord","key":"","secret":"","callback":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"enabled":false,"icon":"facebook-square","key":"","secret":"","callback":"api/auth/facebook/callback","scope":["email"]},"google":{"enabled":false,"icon":"google","key":"","secret":"","callback":"api/auth/google/callback","scope":["email"]},"github":{"enabled":false,"icon":"github","key":"","secret":"","callback":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"enabled":false,"icon":"windows","key":"","secret":"","callback":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"enabled":false,"icon":"twitter","key":"","secret":"","callback":"api/auth/twitter/callback"},"instagram":{"enabled":false,"icon":"instagram","key":"","secret":"","callback":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"enabled":false,"icon":"vk","key":"","secret":"","callback":"api/auth/vk/callback","scope":["email"]},"twitch":{"enabled":false,"icon":"twitch","key":"","secret":"","callback":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"enabled":false,"icon":"linkedin","key":"","secret":"","callback":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"enabled":false,"icon":"aws","key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"enabled":false,"icon":"reddit","key":"","secret":"","state":true,"callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"enabled":false,"icon":"","key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"enabled":false,"icon":"book","key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"enabled":false,"icon":"","key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]}}	object	\N	\N
19	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
20	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
1	strapi_content_types_schema	{"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"admin::permission","plugin":"admin","globalId":"AdminPermission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"admin::user","plugin":"admin","globalId":"AdminUser"},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"admin::role","plugin":"admin","globalId":"AdminRole"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token","connection":"default","uid":"admin::api-token","plugin":"admin","globalId":"AdminApiToken"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token-permission","connection":"default","uid":"admin::api-token-permission","plugin":"admin","globalId":"AdminApiTokenPermission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token","connection":"default","uid":"admin::transfer-token","plugin":"admin","globalId":"AdminTransferToken"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token-permission","connection":"default","uid":"admin::transfer-token-permission","plugin":"admin","globalId":"AdminTransferTokenPermission"},"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"file","connection":"default","uid":"plugin::upload.file","plugin":"upload","globalId":"UploadFile"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"folder","connection":"default","uid":"plugin::upload.folder","plugin":"upload","globalId":"UploadFolder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"locale","connection":"default","uid":"plugin::i18n.locale","plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"plugin::users-permissions.permission","plugin":"users-permissions","globalId":"UsersPermissionsPermission"},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"plugin::users-permissions.role","plugin":"users-permissions","globalId":"UsersPermissionsRole"},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"plugin::users-permissions.user","plugin":"users-permissions","globalId":"UsersPermissionsUser"},"api::entitlement.entitlement":{"kind":"collectionType","collectionName":"entitlements","info":{"singularName":"entitlement","pluralName":"entitlements","displayName":"entitlement","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"uid","targetField":"name"},"usageledgers":{"type":"relation","relation":"oneToMany","target":"api::usageledger.usageledger","mappedBy":"entitlement"},"ismetered":{"type":"boolean","default":false,"required":true},"defaultlimit":{"type":"integer"},"resetPeriod":{"type":"enumeration","enum":["minute","hour","day","week","two weeks","month","year","lifetime"]},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"entitlement"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"entitlements","info":{"singularName":"entitlement","pluralName":"entitlements","displayName":"entitlement","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"uid","targetField":"name"},"usageledgers":{"type":"relation","relation":"oneToMany","target":"api::usageledger.usageledger","mappedBy":"entitlement"},"ismetered":{"type":"boolean","default":false,"required":true},"defaultlimit":{"type":"integer"},"resetPeriod":{"type":"enumeration","enum":["minute","hour","day","week","two weeks","month","year","lifetime"]},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"entitlement"}},"kind":"collectionType"},"modelType":"contentType","modelName":"entitlement","connection":"default","uid":"api::entitlement.entitlement","apiName":"entitlement","globalId":"Entitlement","actions":{},"lifecycles":{}},"api::feature.feature":{"kind":"collectionType","collectionName":"features","info":{"singularName":"feature","pluralName":"features","displayName":"feature","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"feature":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"plans":{"type":"relation","relation":"manyToMany","target":"api::plan.plan","inversedBy":"features"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::feature.feature"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"features","info":{"singularName":"feature","pluralName":"features","displayName":"feature","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"feature":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"plans":{"type":"relation","relation":"manyToMany","target":"api::plan.plan","inversedBy":"features"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"feature","connection":"default","uid":"api::feature.feature","apiName":"feature","globalId":"Feature","actions":{},"lifecycles":{}},"api::ping.ping":{"kind":"collectionType","collectionName":"pings","info":{"singularName":"ping","pluralName":"pings","displayName":"ping"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"status":{"type":"string","default":"OK","required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"pings","info":{"singularName":"ping","pluralName":"pings","displayName":"ping"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"status":{"type":"string","default":"OK","required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"ping","connection":"default","uid":"api::ping.ping","apiName":"ping","globalId":"Ping","actions":{},"lifecycles":{}},"api::plan.plan":{"kind":"collectionType","collectionName":"plans","info":{"singularName":"plan","pluralName":"plans","displayName":"plan","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"productId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":true},"inherit_from":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"childPlans"},"childPlans":{"type":"relation","relation":"oneToMany","target":"api::plan.plan","mappedBy":"inherit_from"},"saleProductId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":false},"saleStartDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"saleEndDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"subscriptions":{"type":"relation","relation":"oneToMany","target":"api::subscription.subscription","mappedBy":"plan"},"features":{"type":"relation","relation":"manyToMany","target":"api::feature.feature","mappedBy":"plans"},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"plan"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"role":{"pluginOptions":{"i18n":{"localized":false}},"type":"enumeration","enum":["free","basic","premium","pro"]},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::plan.plan"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"plans","info":{"singularName":"plan","pluralName":"plans","displayName":"plan","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"productId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":true},"inherit_from":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"childPlans"},"childPlans":{"type":"relation","relation":"oneToMany","target":"api::plan.plan","mappedBy":"inherit_from"},"saleProductId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":false},"saleStartDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"saleEndDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"subscriptions":{"type":"relation","relation":"oneToMany","target":"api::subscription.subscription","mappedBy":"plan"},"features":{"type":"relation","relation":"manyToMany","target":"api::feature.feature","mappedBy":"plans"},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"plan"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"role":{"pluginOptions":{"i18n":{"localized":false}},"type":"enumeration","enum":["free","basic","premium","pro"]}},"kind":"collectionType"},"modelType":"contentType","modelName":"plan","connection":"default","uid":"api::plan.plan","apiName":"plan","globalId":"Plan","actions":{},"lifecycles":{}},"api::plan-ent-link.plan-ent-link":{"kind":"collectionType","collectionName":"plan_ent_links","info":{"singularName":"plan-ent-link","pluralName":"plan-ent-links","displayName":"PlanEntLink"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"plan_ent_links"},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"plan_ent_links"},"limitOverride":{"type":"integer"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"plan_ent_links","info":{"singularName":"plan-ent-link","pluralName":"plan-ent-links","displayName":"PlanEntLink"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"plan_ent_links"},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"plan_ent_links"},"limitOverride":{"type":"integer"}},"kind":"collectionType"},"modelType":"contentType","modelName":"plan-ent-link","connection":"default","uid":"api::plan-ent-link.plan-ent-link","apiName":"plan-ent-link","globalId":"PlanEntLink","actions":{},"lifecycles":{}},"api::subscription.subscription":{"kind":"collectionType","collectionName":"subscriptions","info":{"singularName":"subscription","pluralName":"subscriptions","displayName":"subscription","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"subscriptions"},"status":{"type":"enumeration","enum":["active","canceled","expired"],"required":true,"default":"active"},"expireDate":{"type":"datetime"},"originalTransactionId":{"type":"string"},"latestTransactionId":{"type":"string"},"startDate":{"type":"datetime"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"subscriptions","info":{"singularName":"subscription","pluralName":"subscriptions","displayName":"subscription","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"subscriptions"},"status":{"type":"enumeration","enum":["active","canceled","expired"],"required":true,"default":"active"},"expireDate":{"type":"datetime"},"originalTransactionId":{"type":"string"},"latestTransactionId":{"type":"string"},"startDate":{"type":"datetime"}},"kind":"collectionType"},"modelType":"contentType","modelName":"subscription","connection":"default","uid":"api::subscription.subscription","apiName":"subscription","globalId":"Subscription","actions":{},"lifecycles":{}},"api::usageledger.usageledger":{"kind":"collectionType","collectionName":"usageledgers","info":{"singularName":"usageledger","pluralName":"usageledgers","displayName":"usageledger"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"usageledgers"},"consumedAt":{"type":"datetime"},"amount":{"type":"integer","default":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"usageledgers","info":{"singularName":"usageledger","pluralName":"usageledgers","displayName":"usageledger"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"usageledgers"},"consumedAt":{"type":"datetime"},"amount":{"type":"integer","default":1,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"usageledger","connection":"default","uid":"api::usageledger.usageledger","apiName":"usageledger","globalId":"Usageledger","actions":{},"lifecycles":{}}}	object	\N	\N
23	plugin_content_manager_configuration_components::a.features	{"uid":"a.features","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}}},"layouts":{"list":["id"],"edit":[]},"isComponent":true}	object	\N	\N
24	plugin_content_manager_configuration_content_types::api::plan.plan	{"uid":"api::plan.plan","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"productId":{"edit":{"label":"productId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"productId","searchable":true,"sortable":true}},"inherit_from":{"edit":{"label":"inherit_from","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"inherit_from","searchable":true,"sortable":true}},"childPlans":{"edit":{"label":"childPlans","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"childPlans","searchable":false,"sortable":false}},"saleProductId":{"edit":{"label":"saleProductId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"saleProductId","searchable":true,"sortable":true}},"saleStartDate":{"edit":{"label":"saleStartDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"saleStartDate","searchable":true,"sortable":true}},"saleEndDate":{"edit":{"label":"saleEndDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"saleEndDate","searchable":true,"sortable":true}},"subscriptions":{"edit":{"label":"subscriptions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"originalTransactionId"},"list":{"label":"subscriptions","searchable":false,"sortable":false}},"features":{"edit":{"label":"features","description":"","placeholder":"","visible":true,"editable":true,"mainField":"feature"},"list":{"label":"features","searchable":false,"sortable":false}},"plan_ent_links":{"edit":{"label":"plan_ent_links","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"plan_ent_links","searchable":false,"sortable":false}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","productId","features"],"edit":[[{"name":"name","size":6},{"name":"productId","size":6}],[{"name":"features","size":12}],[{"name":"inherit_from","size":6}],[{"name":"childPlans","size":6},{"name":"saleProductId","size":6}],[{"name":"saleStartDate","size":6},{"name":"saleEndDate","size":6}],[{"name":"subscriptions","size":6},{"name":"plan_ent_links","size":6}],[{"name":"order","size":4},{"name":"role","size":6}]]}}	object	\N	\N
25	plugin_content_manager_configuration_content_types::api::entitlement.entitlement	{"uid":"api::entitlement.entitlement","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"usageledgers":{"edit":{"label":"usageledgers","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"usageledgers","searchable":false,"sortable":false}},"ismetered":{"edit":{"label":"ismetered","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ismetered","searchable":true,"sortable":true}},"defaultlimit":{"edit":{"label":"defaultlimit","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"defaultlimit","searchable":true,"sortable":true}},"resetPeriod":{"edit":{"label":"resetPeriod","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"resetPeriod","searchable":true,"sortable":true}},"plan_ent_links":{"edit":{"label":"plan_ent_links","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"plan_ent_links","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","slug","createdAt"],"edit":[[{"name":"name","size":6},{"name":"slug","size":6}],[{"name":"usageledgers","size":6}],[{"name":"ismetered","size":4},{"name":"defaultlimit","size":4}],[{"name":"resetPeriod","size":6},{"name":"plan_ent_links","size":6}]]}}	object	\N	\N
27	plugin_content_manager_configuration_content_types::api::subscription.subscription	{"uid":"api::subscription.subscription","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":100,"mainField":"originalTransactionId","defaultSortBy":"id","defaultSortOrder":"DESC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"plan":{"edit":{"label":"plan","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"plan","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"expireDate":{"edit":{"label":"expireDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expireDate","searchable":true,"sortable":true}},"originalTransactionId":{"edit":{"label":"originalTransactionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"originalTransactionId","searchable":true,"sortable":true}},"latestTransactionId":{"edit":{"label":"latestTransactionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"latestTransactionId","searchable":true,"sortable":true}},"startDate":{"edit":{"label":"startDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startDate","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"strapiUserId","size":4},{"name":"plan","size":6}],[{"name":"status","size":6},{"name":"expireDate","size":6}],[{"name":"originalTransactionId","size":6},{"name":"latestTransactionId","size":6}],[{"name":"startDate","size":6}]],"list":["id","strapiUserId","plan","status"]}}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"uid":"plugin::upload.folder","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]}}	object	\N	\N
21	plugin_i18n_default_locale	"en"	string	\N	\N
22	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
22	{"tables":[{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users","indexes":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_roles","indexes":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users","indexes":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"entitlements","indexes":[{"type":"unique","name":"entitlements_slug_unique","columns":["slug"]},{"name":"entitlements_created_by_id_fk","columns":["created_by_id"]},{"name":"entitlements_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"entitlements_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"entitlements_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false,"unique":true},{"name":"ismetered","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"defaultlimit","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_period","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"features","indexes":[{"name":"features_created_by_id_fk","columns":["created_by_id"]},{"name":"features_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"features_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"features_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"pings","indexes":[{"name":"pings_created_by_id_fk","columns":["created_by_id"]},{"name":"pings_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"pings_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"pings_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plans","indexes":[{"name":"plans_created_by_id_fk","columns":["created_by_id"]},{"name":"plans_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"plans_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"plans_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"product_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_product_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_start_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_end_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"role","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"plan_ent_links","indexes":[{"name":"plan_ent_links_created_by_id_fk","columns":["created_by_id"]},{"name":"plan_ent_links_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"plan_ent_links_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"plan_ent_links_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"limit_override","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"subscriptions","indexes":[{"name":"subscriptions_created_by_id_fk","columns":["created_by_id"]},{"name":"subscriptions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"subscriptions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"subscriptions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expire_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"original_transaction_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"latest_transaction_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usageledgers","indexes":[{"name":"usageledgers_created_by_id_fk","columns":["created_by_id"]},{"name":"usageledgers_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"usageledgers_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"usageledgers_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"consumed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_a_features","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"admin_permissions_role_links","indexes":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"]},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"admin_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_links","indexes":[{"name":"admin_users_roles_links_fk","columns":["user_id"]},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"]},{"name":"admin_users_roles_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_links_order_fk","columns":["role_order"]},{"name":"admin_users_roles_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"admin_users_roles_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_links","indexes":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_links_unique","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_links_order_inv_fk","columns":["api_token_permission_order"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_links","indexes":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_links_unique","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_links_order_inv_fk","columns":["transfer_token_permission_order"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_morphs","indexes":[{"name":"files_related_morphs_fk","columns":["file_id"]},{"name":"files_related_morphs_order_index","columns":["order"]},{"name":"files_related_morphs_id_column_index","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_morphs_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_links","indexes":[{"name":"files_folder_links_fk","columns":["file_id"]},{"name":"files_folder_links_inv_fk","columns":["folder_id"]},{"name":"files_folder_links_unique","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_links_order_inv_fk","columns":["file_order"]}],"foreignKeys":[{"name":"files_folder_links_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_links_inv_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_links","indexes":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"]},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_links_unique","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_links_order_inv_fk","columns":["folder_order"]}],"foreignKeys":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_links","indexes":[{"name":"up_permissions_role_links_fk","columns":["permission_id"]},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"up_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"up_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_links","indexes":[{"name":"up_users_role_links_fk","columns":["user_id"]},{"name":"up_users_role_links_inv_fk","columns":["role_id"]},{"name":"up_users_role_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"up_users_role_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"features_plans_links","indexes":[{"name":"features_plans_links_fk","columns":["feature_id"]},{"name":"features_plans_links_inv_fk","columns":["plan_id"]},{"name":"features_plans_links_unique","columns":["feature_id","plan_id"],"type":"unique"},{"name":"features_plans_links_order_fk","columns":["plan_order"]},{"name":"features_plans_links_order_inv_fk","columns":["feature_order"]}],"foreignKeys":[{"name":"features_plans_links_fk","columns":["feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"},{"name":"features_plans_links_inv_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"features_localizations_links","indexes":[{"name":"features_localizations_links_fk","columns":["feature_id"]},{"name":"features_localizations_links_inv_fk","columns":["inv_feature_id"]},{"name":"features_localizations_links_unique","columns":["feature_id","inv_feature_id"],"type":"unique"},{"name":"features_localizations_links_order_fk","columns":["feature_order"]}],"foreignKeys":[{"name":"features_localizations_links_fk","columns":["feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"},{"name":"features_localizations_links_inv_fk","columns":["inv_feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plans_inherit_from_links","indexes":[{"name":"plans_inherit_from_links_fk","columns":["plan_id"]},{"name":"plans_inherit_from_links_inv_fk","columns":["inv_plan_id"]},{"name":"plans_inherit_from_links_unique","columns":["plan_id","inv_plan_id"],"type":"unique"},{"name":"plans_inherit_from_links_order_inv_fk","columns":["plan_order"]}],"foreignKeys":[{"name":"plans_inherit_from_links_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"},{"name":"plans_inherit_from_links_inv_fk","columns":["inv_plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plans_localizations_links","indexes":[{"name":"plans_localizations_links_fk","columns":["plan_id"]},{"name":"plans_localizations_links_inv_fk","columns":["inv_plan_id"]},{"name":"plans_localizations_links_unique","columns":["plan_id","inv_plan_id"],"type":"unique"},{"name":"plans_localizations_links_order_fk","columns":["plan_order"]}],"foreignKeys":[{"name":"plans_localizations_links_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"},{"name":"plans_localizations_links_inv_fk","columns":["inv_plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plan_ent_links_plan_links","indexes":[{"name":"plan_ent_links_plan_links_fk","columns":["plan_ent_link_id"]},{"name":"plan_ent_links_plan_links_inv_fk","columns":["plan_id"]},{"name":"plan_ent_links_plan_links_unique","columns":["plan_ent_link_id","plan_id"],"type":"unique"},{"name":"plan_ent_links_plan_links_order_inv_fk","columns":["plan_ent_link_order"]}],"foreignKeys":[{"name":"plan_ent_links_plan_links_fk","columns":["plan_ent_link_id"],"referencedColumns":["id"],"referencedTable":"plan_ent_links","onDelete":"CASCADE"},{"name":"plan_ent_links_plan_links_inv_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_ent_link_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_ent_link_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plan_ent_links_entitlement_links","indexes":[{"name":"plan_ent_links_entitlement_links_fk","columns":["plan_ent_link_id"]},{"name":"plan_ent_links_entitlement_links_inv_fk","columns":["entitlement_id"]},{"name":"plan_ent_links_entitlement_links_unique","columns":["plan_ent_link_id","entitlement_id"],"type":"unique"},{"name":"plan_ent_links_entitlement_links_order_inv_fk","columns":["plan_ent_link_order"]}],"foreignKeys":[{"name":"plan_ent_links_entitlement_links_fk","columns":["plan_ent_link_id"],"referencedColumns":["id"],"referencedTable":"plan_ent_links","onDelete":"CASCADE"},{"name":"plan_ent_links_entitlement_links_inv_fk","columns":["entitlement_id"],"referencedColumns":["id"],"referencedTable":"entitlements","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_ent_link_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"entitlement_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_ent_link_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"subscriptions_plan_links","indexes":[{"name":"subscriptions_plan_links_fk","columns":["subscription_id"]},{"name":"subscriptions_plan_links_inv_fk","columns":["plan_id"]},{"name":"subscriptions_plan_links_unique","columns":["subscription_id","plan_id"],"type":"unique"},{"name":"subscriptions_plan_links_order_inv_fk","columns":["subscription_order"]}],"foreignKeys":[{"name":"subscriptions_plan_links_fk","columns":["subscription_id"],"referencedColumns":["id"],"referencedTable":"subscriptions","onDelete":"CASCADE"},{"name":"subscriptions_plan_links_inv_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"subscription_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"subscription_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usageledgers_entitlement_links","indexes":[{"name":"usageledgers_entitlement_links_fk","columns":["usageledger_id"]},{"name":"usageledgers_entitlement_links_inv_fk","columns":["entitlement_id"]},{"name":"usageledgers_entitlement_links_unique","columns":["usageledger_id","entitlement_id"],"type":"unique"},{"name":"usageledgers_entitlement_links_order_inv_fk","columns":["usageledger_order"]}],"foreignKeys":[{"name":"usageledgers_entitlement_links_fk","columns":["usageledger_id"],"referencedColumns":["id"],"referencedTable":"usageledgers","onDelete":"CASCADE"},{"name":"usageledgers_entitlement_links_inv_fk","columns":["entitlement_id"],"referencedColumns":["id"],"referencedTable":"entitlements","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"usageledger_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"entitlement_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"usageledger_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2025-07-23 21:47:43.395	3f0de5ab7c07b74f06bed8601493a27d
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.subscriptions (id, strapi_user_id, status, expire_date, original_transaction_id, latest_transaction_id, created_at, updated_at, created_by_id, updated_by_id, start_date) FROM stdin;
1	456	canceled	\N	\N	\N	2025-07-04 17:01:08.999	2025-07-04 20:24:54.346	\N	\N	\N
2	456	canceled	\N	\N	\N	2025-07-04 20:24:54.568	2025-07-04 20:31:24.1	\N	\N	\N
3	456	canceled	2025-08-03 20:31:29.5	\N	\N	2025-07-04 20:31:24.331	2025-07-04 20:39:11.599	\N	\N	\N
4	456	canceled	\N	\N	\N	2025-07-04 20:39:11.765	2025-07-04 20:39:16.727	\N	\N	2025-07-04 20:39:11.733
5	456	canceled	2025-08-03 20:39:16.694	\N	\N	2025-07-04 20:39:16.895	2025-07-04 22:25:21.617	\N	\N	2025-07-04 20:39:16.863
6	456	active	\N	\N	\N	2025-07-04 22:25:22.054	2025-07-04 22:25:22.054	\N	\N	2025-07-04 22:25:22.009
7	36	canceled	\N	\N	\N	2025-07-04 22:33:47.19	2025-07-04 22:41:28.505	\N	\N	2025-07-04 22:33:47.155
8	36	active	\N	\N	\N	2025-07-04 22:41:28.695	2025-07-04 22:41:28.695	\N	\N	2025-07-04 22:41:28.663
9	37	active	\N	\N	\N	2025-07-04 22:41:43.916	2025-07-04 22:41:43.916	\N	\N	2025-07-04 22:41:43.881
10	38	active	\N	\N	\N	2025-07-04 22:46:57.422	2025-07-04 22:46:57.422	\N	\N	2025-07-04 22:46:57.388
11	46	active	\N	\N	\N	2025-07-05 00:27:12.71	2025-07-05 00:27:12.71	\N	\N	2025-07-05 00:27:12.673
12	47	active	\N	\N	\N	2025-07-05 00:28:07.221	2025-07-05 00:28:07.221	\N	\N	2025-07-05 00:28:07.189
13	48	active	\N	\N	\N	2025-07-05 00:35:45.652	2025-07-05 00:35:45.652	\N	\N	2025-07-05 00:35:45.619
14	49	active	\N	\N	\N	2025-07-05 00:49:26.523	2025-07-05 00:49:26.523	\N	\N	2025-07-05 00:49:26.491
15	50	active	\N	\N	\N	2025-07-05 00:52:42.093	2025-07-05 00:52:42.093	\N	\N	2025-07-05 00:52:42.058
16	999	active	\N	\N	\N	2025-07-05 00:55:16.559	2025-07-05 00:55:16.559	\N	\N	2025-07-05 00:55:16.527
17	51	active	\N	\N	\N	2025-07-05 00:56:37.536	2025-07-05 00:56:37.536	\N	\N	2025-07-05 00:56:37.502
18	52	active	\N	\N	\N	2025-07-05 00:59:32.003	2025-07-05 00:59:32.003	\N	\N	2025-07-05 00:59:31.968
19	53	active	\N	\N	\N	2025-07-05 13:37:44.646	2025-07-05 13:37:44.646	\N	\N	2025-07-05 13:37:44.581
20	54	active	\N	\N	\N	2025-07-05 13:49:24.603	2025-07-05 13:49:24.603	\N	\N	2025-07-05 13:49:24.568
21	56	active	\N	\N	\N	2025-07-06 18:54:35.297	2025-07-06 18:54:35.297	\N	\N	2025-07-06 18:54:35.086
22	57	active	\N	\N	\N	2025-07-06 18:56:12.17	2025-07-06 18:56:12.17	\N	\N	2025-07-06 18:56:12.137
23	59	active	\N	\N	\N	2025-07-11 17:17:39.284	2025-07-11 17:17:39.284	\N	\N	2025-07-11 17:17:39.25
24	60	active	\N	\N	\N	2025-07-11 18:31:03.248	2025-07-11 18:31:03.248	\N	\N	2025-07-11 18:31:03.185
28	23	canceled	\N	\N	\N	2025-07-11 21:59:11.362	2025-07-11 22:06:16.281	\N	\N	2025-07-11 21:59:11.326
29	23	canceled	\N	\N	\N	2025-07-11 22:06:16.444	2025-07-11 22:11:28.378	\N	\N	2025-07-11 22:06:16.409
30	23	canceled	\N	\N	\N	2025-07-11 22:11:28.553	2025-07-11 22:14:11.396	\N	\N	2025-07-11 22:11:28.52
31	23	canceled	\N	\N	\N	2025-07-11 22:14:11.594	2025-07-11 23:06:47.829	\N	\N	2025-07-11 22:14:11.548
32	23	canceled	\N	\N	\N	2025-07-11 23:06:48.014	2025-07-11 23:08:07.474	\N	\N	2025-07-11 23:06:47.982
33	23	canceled	\N	\N	\N	2025-07-11 23:08:07.731	2025-07-11 23:09:57.666	\N	\N	2025-07-11 23:08:07.703
34	23	canceled	2025-08-10 23:19:20.537	\N	\N	2025-07-11 23:09:57.819	2025-07-11 23:19:32.302	\N	\N	2025-07-11 23:09:57.8
35	23	canceled	\N	\N	\N	2025-07-11 23:19:32.488	2025-07-11 23:20:10.843	\N	\N	2025-07-11 23:19:32.455
36	23	canceled	\N	\N	\N	2025-07-11 23:20:10.997	2025-07-11 23:22:58.307	\N	\N	2025-07-11 23:20:10.965
37	23	canceled	\N	\N	\N	2025-07-11 23:22:58.884	2025-07-11 23:23:34.43	\N	\N	2025-07-11 23:22:58.849
38	23	canceled	2025-08-10 23:23:34.399	\N	\N	2025-07-11 23:23:34.622	2025-07-11 23:49:52.168	\N	\N	2025-07-11 23:23:34.587
43	64	active	\N	\N	\N	2025-07-12 00:06:12.939	2025-07-12 00:06:12.939	\N	\N	2025-07-12 00:06:12.91
41	23	canceled	\N	\N	\N	2025-07-11 23:49:52.356	2025-07-12 00:38:46.451	\N	\N	2025-07-11 23:49:52.324
44	23	canceled	\N	\N	\N	2025-07-12 00:38:46.648	2025-07-12 00:42:40.206	\N	\N	2025-07-12 00:38:46.615
45	23	canceled	\N	\N	\N	2025-07-12 00:42:40.383	2025-07-12 00:43:20.329	\N	\N	2025-07-12 00:42:40.351
47	65	active	\N	\N	\N	2025-07-12 00:47:45.524	2025-07-12 00:47:45.524	\N	\N	2025-07-12 00:47:45.492
46	23	canceled	2025-08-11 00:43:20.296	\N	\N	2025-07-12 00:43:20.519	2025-07-17 14:48:13.564	\N	\N	2025-07-12 00:43:20.489
48	23	canceled	\N	\N	\N	2025-07-17 14:48:13.745	2025-07-17 14:48:25.708	\N	\N	2025-07-17 14:48:13.711
49	23	active	2025-08-16 14:48:25.676	\N	\N	2025-07-17 14:48:25.898	2025-07-17 14:48:25.898	\N	\N	2025-07-17 14:48:25.86
50	69	active	\N	\N	\N	2025-07-23 11:02:12.757	2025-07-23 11:02:12.757	\N	\N	2025-07-23 11:02:12.718
51	70	active	\N	\N	\N	2025-07-23 11:02:23.102	2025-07-23 11:02:23.102	\N	\N	2025-07-23 11:02:23.068
\.


--
-- Data for Name: subscriptions_plan_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.subscriptions_plan_links (id, subscription_id, plan_id, subscription_order) FROM stdin;
1	1	1	1
2	2	1	2
3	3	2	1
4	4	1	3
5	5	2	2
6	6	1	4
7	7	1	5
8	8	1	6
9	9	1	7
10	10	1	8
11	11	1	9
12	12	1	10
13	13	1	11
14	14	1	12
15	15	1	13
16	16	1	14
17	17	1	15
18	18	1	16
19	19	1	17
20	20	1	18
21	21	1	19
22	22	1	20
23	23	1	21
24	24	1	22
28	28	1	23
29	29	1	24
30	30	1	25
31	31	1	26
32	32	1	27
33	33	1	28
34	34	2	3
35	35	1	29
36	36	1	30
37	37	1	31
38	38	2	4
41	41	1	33
43	43	1	34
44	44	1	35
45	45	1	36
46	46	2	5
47	47	1	37
48	48	1	38
49	49	2	6
50	50	1	39
51	51	1	40
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	plugin::users-permissions.user.me	2025-07-04 13:47:47.605	2025-07-04 13:47:47.605	\N	\N
2	plugin::users-permissions.auth.changePassword	2025-07-04 13:47:47.605	2025-07-04 13:47:47.605	\N	\N
3	plugin::users-permissions.auth.callback	2025-07-04 13:47:47.777	2025-07-04 13:47:47.777	\N	\N
5	plugin::users-permissions.auth.connect	2025-07-04 13:47:47.778	2025-07-04 13:47:47.778	\N	\N
4	plugin::users-permissions.auth.forgotPassword	2025-07-04 13:47:47.778	2025-07-04 13:47:47.778	\N	\N
6	plugin::users-permissions.auth.emailConfirmation	2025-07-04 13:47:47.778	2025-07-04 13:47:47.778	\N	\N
7	plugin::users-permissions.auth.resetPassword	2025-07-04 13:47:47.778	2025-07-04 13:47:47.778	\N	\N
8	plugin::users-permissions.auth.register	2025-07-04 13:47:47.778	2025-07-04 13:47:47.778	\N	\N
9	plugin::users-permissions.auth.sendEmailConfirmation	2025-07-04 13:47:47.778	2025-07-04 13:47:47.778	\N	\N
15	api::ping.ping.findOne	2025-07-23 09:36:25.586	2025-07-23 09:36:25.586	\N	\N
16	api::ping.ping.find	2025-07-23 09:36:25.586	2025-07-23 09:36:25.586	\N	\N
\.


--
-- Data for Name: up_permissions_role_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
1	2	1	1
2	1	1	1
4	4	2	1
3	8	2	1
5	6	2	1
6	3	2	1
7	7	2	1
8	5	2	1
9	9	2	1
15	16	2	2
16	15	2	2
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Authenticated	Default role given to authenticated user.	authenticated	2025-07-04 13:47:47.292	2025-07-04 13:47:47.292	\N	\N
2	Public	Default role given to unauthenticated user.	public	2025-07-04 13:47:47.421	2025-07-23 09:36:25.436	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	testuser	test@example.com	local	$2a$10$VDKq3oorXKwNKXZpqV4wPOtwVN3SwIFOtTXpzzilQDVGpaXyJWGAS	\N	\N	t	f	2025-07-05 00:03:36.44	2025-07-11 23:32:59.806	\N	1
\.


--
-- Data for Name: up_users_role_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
1	1	1	1
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: upload_folders_parent_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
\.


--
-- Data for Name: usageledgers; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usageledgers (id, strapi_user_id, consumed_at, amount, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: usageledgers_entitlement_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usageledgers_entitlement_links (id, usageledger_id, entitlement_id, usageledger_order) FROM stdin;
\.


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 150, true);


--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 150, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 2, true);


--
-- Name: components_a_features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_features_id_seq', 12, true);


--
-- Name: entitlements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.entitlements_id_seq', 5, true);


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.features_id_seq', 9, true);


--
-- Name: features_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.features_localizations_links_id_seq', 1, false);


--
-- Name: features_plans_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.features_plans_links_id_seq', 9, true);


--
-- Name: files_folder_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_id_seq', 1, false);


--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: pings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.pings_id_seq', 1, false);


--
-- Name: plan_ent_links_entitlement_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plan_ent_links_entitlement_links_id_seq', 7, true);


--
-- Name: plan_ent_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plan_ent_links_id_seq', 7, true);


--
-- Name: plan_ent_links_plan_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plan_ent_links_plan_links_id_seq', 8, true);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plans_id_seq', 3, true);


--
-- Name: plans_inherit_from_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plans_inherit_from_links_id_seq', 2, true);


--
-- Name: plans_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plans_localizations_links_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 2, true);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 32, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 22, true);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 51, true);


--
-- Name: subscriptions_plan_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.subscriptions_plan_links_id_seq', 51, true);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 16, true);


--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 16, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_users_id_seq', 1, true);


--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 1, true);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);


--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);


--
-- Name: usageledgers_entitlement_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usageledgers_entitlement_links_id_seq', 1, false);


--
-- Name: usageledgers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usageledgers_id_seq', 1, false);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_links admin_permissions_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_links admin_permissions_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_unique UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_links admin_users_roles_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_links admin_users_roles_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_unique UNIQUE (user_id, role_id);


--
-- Name: components_a_features components_a_features_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_features
    ADD CONSTRAINT components_a_features_pkey PRIMARY KEY (id);


--
-- Name: entitlements entitlements_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.entitlements
    ADD CONSTRAINT entitlements_pkey PRIMARY KEY (id);


--
-- Name: entitlements entitlements_slug_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.entitlements
    ADD CONSTRAINT entitlements_slug_unique UNIQUE (slug);


--
-- Name: features_localizations_links features_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_localizations_links
    ADD CONSTRAINT features_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: features_localizations_links features_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_localizations_links
    ADD CONSTRAINT features_localizations_links_unique UNIQUE (feature_id, inv_feature_id);


--
-- Name: features features_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- Name: features_plans_links features_plans_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_plans_links
    ADD CONSTRAINT features_plans_links_pkey PRIMARY KEY (id);


--
-- Name: features_plans_links features_plans_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_plans_links
    ADD CONSTRAINT features_plans_links_unique UNIQUE (feature_id, plan_id);


--
-- Name: files_folder_links files_folder_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);


--
-- Name: files_folder_links files_folder_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_morphs files_related_morphs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: pings pings_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.pings
    ADD CONSTRAINT pings_pkey PRIMARY KEY (id);


--
-- Name: plan_ent_links_entitlement_links plan_ent_links_entitlement_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_entitlement_links
    ADD CONSTRAINT plan_ent_links_entitlement_links_pkey PRIMARY KEY (id);


--
-- Name: plan_ent_links_entitlement_links plan_ent_links_entitlement_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_entitlement_links
    ADD CONSTRAINT plan_ent_links_entitlement_links_unique UNIQUE (plan_ent_link_id, entitlement_id);


--
-- Name: plan_ent_links plan_ent_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links
    ADD CONSTRAINT plan_ent_links_pkey PRIMARY KEY (id);


--
-- Name: plan_ent_links_plan_links plan_ent_links_plan_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_plan_links
    ADD CONSTRAINT plan_ent_links_plan_links_pkey PRIMARY KEY (id);


--
-- Name: plan_ent_links_plan_links plan_ent_links_plan_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_plan_links
    ADD CONSTRAINT plan_ent_links_plan_links_unique UNIQUE (plan_ent_link_id, plan_id);


--
-- Name: plans_inherit_from_links plans_inherit_from_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_inherit_from_links
    ADD CONSTRAINT plans_inherit_from_links_pkey PRIMARY KEY (id);


--
-- Name: plans_inherit_from_links plans_inherit_from_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_inherit_from_links
    ADD CONSTRAINT plans_inherit_from_links_unique UNIQUE (plan_id, inv_plan_id);


--
-- Name: plans_localizations_links plans_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_localizations_links
    ADD CONSTRAINT plans_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: plans_localizations_links plans_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_localizations_links
    ADD CONSTRAINT plans_localizations_links_unique UNIQUE (plan_id, inv_plan_id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_unique UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: subscriptions_plan_links subscriptions_plan_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions_plan_links
    ADD CONSTRAINT subscriptions_plan_links_pkey PRIMARY KEY (id);


--
-- Name: subscriptions_plan_links subscriptions_plan_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions_plan_links
    ADD CONSTRAINT subscriptions_plan_links_unique UNIQUE (subscription_id, plan_id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_links up_permissions_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_links up_permissions_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_unique UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_links up_users_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_links up_users_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_unique UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_links upload_folders_parent_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_links upload_folders_parent_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_unique UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: usageledgers_entitlement_links usageledgers_entitlement_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers_entitlement_links
    ADD CONSTRAINT usageledgers_entitlement_links_pkey PRIMARY KEY (id);


--
-- Name: usageledgers_entitlement_links usageledgers_entitlement_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers_entitlement_links
    ADD CONSTRAINT usageledgers_entitlement_links_unique UNIQUE (usageledger_id, entitlement_id);


--
-- Name: usageledgers usageledgers_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers
    ADD CONSTRAINT usageledgers_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_role_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_links_fk ON public.admin_permissions_role_links USING btree (permission_id);


--
-- Name: admin_permissions_role_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_links_inv_fk ON public.admin_permissions_role_links USING btree (role_id);


--
-- Name: admin_permissions_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_links_order_inv_fk ON public.admin_permissions_role_links USING btree (permission_order);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_roles_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_fk ON public.admin_users_roles_links USING btree (user_id);


--
-- Name: admin_users_roles_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_inv_fk ON public.admin_users_roles_links USING btree (role_id);


--
-- Name: admin_users_roles_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_order_fk ON public.admin_users_roles_links USING btree (role_order);


--
-- Name: admin_users_roles_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_order_inv_fk ON public.admin_users_roles_links USING btree (user_order);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: entitlements_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX entitlements_created_by_id_fk ON public.entitlements USING btree (created_by_id);


--
-- Name: entitlements_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX entitlements_updated_by_id_fk ON public.entitlements USING btree (updated_by_id);


--
-- Name: features_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_created_by_id_fk ON public.features USING btree (created_by_id);


--
-- Name: features_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_localizations_links_fk ON public.features_localizations_links USING btree (feature_id);


--
-- Name: features_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_localizations_links_inv_fk ON public.features_localizations_links USING btree (inv_feature_id);


--
-- Name: features_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_localizations_links_order_fk ON public.features_localizations_links USING btree (feature_order);


--
-- Name: features_plans_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_plans_links_fk ON public.features_plans_links USING btree (feature_id);


--
-- Name: features_plans_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_plans_links_inv_fk ON public.features_plans_links USING btree (plan_id);


--
-- Name: features_plans_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_plans_links_order_fk ON public.features_plans_links USING btree (plan_order);


--
-- Name: features_plans_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_plans_links_order_inv_fk ON public.features_plans_links USING btree (feature_order);


--
-- Name: features_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX features_updated_by_id_fk ON public.features USING btree (updated_by_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_folder_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);


--
-- Name: files_folder_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);


--
-- Name: files_folder_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);


--
-- Name: files_related_morphs_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);


--
-- Name: files_related_morphs_id_column_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);


--
-- Name: files_related_morphs_order_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: pings_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX pings_created_by_id_fk ON public.pings USING btree (created_by_id);


--
-- Name: pings_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX pings_updated_by_id_fk ON public.pings USING btree (updated_by_id);


--
-- Name: plan_ent_links_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_created_by_id_fk ON public.plan_ent_links USING btree (created_by_id);


--
-- Name: plan_ent_links_entitlement_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_entitlement_links_fk ON public.plan_ent_links_entitlement_links USING btree (plan_ent_link_id);


--
-- Name: plan_ent_links_entitlement_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_entitlement_links_inv_fk ON public.plan_ent_links_entitlement_links USING btree (entitlement_id);


--
-- Name: plan_ent_links_entitlement_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_entitlement_links_order_inv_fk ON public.plan_ent_links_entitlement_links USING btree (plan_ent_link_order);


--
-- Name: plan_ent_links_plan_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_plan_links_fk ON public.plan_ent_links_plan_links USING btree (plan_ent_link_id);


--
-- Name: plan_ent_links_plan_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_plan_links_inv_fk ON public.plan_ent_links_plan_links USING btree (plan_id);


--
-- Name: plan_ent_links_plan_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_plan_links_order_inv_fk ON public.plan_ent_links_plan_links USING btree (plan_ent_link_order);


--
-- Name: plan_ent_links_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plan_ent_links_updated_by_id_fk ON public.plan_ent_links USING btree (updated_by_id);


--
-- Name: plans_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_created_by_id_fk ON public.plans USING btree (created_by_id);


--
-- Name: plans_inherit_from_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_inherit_from_links_fk ON public.plans_inherit_from_links USING btree (plan_id);


--
-- Name: plans_inherit_from_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_inherit_from_links_inv_fk ON public.plans_inherit_from_links USING btree (inv_plan_id);


--
-- Name: plans_inherit_from_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_inherit_from_links_order_inv_fk ON public.plans_inherit_from_links USING btree (plan_order);


--
-- Name: plans_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_localizations_links_fk ON public.plans_localizations_links USING btree (plan_id);


--
-- Name: plans_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_localizations_links_inv_fk ON public.plans_localizations_links USING btree (inv_plan_id);


--
-- Name: plans_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_localizations_links_order_fk ON public.plans_localizations_links USING btree (plan_order);


--
-- Name: plans_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX plans_updated_by_id_fk ON public.plans USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_token_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_token_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: subscriptions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX subscriptions_created_by_id_fk ON public.subscriptions USING btree (created_by_id);


--
-- Name: subscriptions_plan_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX subscriptions_plan_links_fk ON public.subscriptions_plan_links USING btree (subscription_id);


--
-- Name: subscriptions_plan_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX subscriptions_plan_links_inv_fk ON public.subscriptions_plan_links USING btree (plan_id);


--
-- Name: subscriptions_plan_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX subscriptions_plan_links_order_inv_fk ON public.subscriptions_plan_links USING btree (subscription_order);


--
-- Name: subscriptions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX subscriptions_updated_by_id_fk ON public.subscriptions USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_role_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_links_fk ON public.up_permissions_role_links USING btree (permission_id);


--
-- Name: up_permissions_role_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_links_inv_fk ON public.up_permissions_role_links USING btree (role_id);


--
-- Name: up_permissions_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_links_order_inv_fk ON public.up_permissions_role_links USING btree (permission_order);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_role_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_links_fk ON public.up_users_role_links USING btree (user_id);


--
-- Name: up_users_role_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_links_inv_fk ON public.up_users_role_links USING btree (role_id);


--
-- Name: up_users_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_links_order_inv_fk ON public.up_users_role_links USING btree (user_order);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_parent_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_links_fk ON public.upload_folders_parent_links USING btree (folder_id);


--
-- Name: upload_folders_parent_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_links_inv_fk ON public.upload_folders_parent_links USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_links_order_inv_fk ON public.upload_folders_parent_links USING btree (folder_order);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: usageledgers_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usageledgers_created_by_id_fk ON public.usageledgers USING btree (created_by_id);


--
-- Name: usageledgers_entitlement_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usageledgers_entitlement_links_fk ON public.usageledgers_entitlement_links USING btree (usageledger_id);


--
-- Name: usageledgers_entitlement_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usageledgers_entitlement_links_inv_fk ON public.usageledgers_entitlement_links USING btree (entitlement_id);


--
-- Name: usageledgers_entitlement_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usageledgers_entitlement_links_order_inv_fk ON public.usageledgers_entitlement_links USING btree (usageledger_order);


--
-- Name: usageledgers_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usageledgers_updated_by_id_fk ON public.usageledgers USING btree (updated_by_id);


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_links admin_permissions_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_links admin_permissions_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_links admin_users_roles_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_links admin_users_roles_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: entitlements entitlements_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.entitlements
    ADD CONSTRAINT entitlements_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: entitlements entitlements_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.entitlements
    ADD CONSTRAINT entitlements_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: features features_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: features_localizations_links features_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_localizations_links
    ADD CONSTRAINT features_localizations_links_fk FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- Name: features_localizations_links features_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_localizations_links
    ADD CONSTRAINT features_localizations_links_inv_fk FOREIGN KEY (inv_feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- Name: features_plans_links features_plans_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_plans_links
    ADD CONSTRAINT features_plans_links_fk FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- Name: features_plans_links features_plans_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features_plans_links
    ADD CONSTRAINT features_plans_links_inv_fk FOREIGN KEY (plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: features features_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_links files_folder_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_links files_folder_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_morphs files_related_morphs_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: pings pings_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.pings
    ADD CONSTRAINT pings_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: pings pings_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.pings
    ADD CONSTRAINT pings_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: plan_ent_links plan_ent_links_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links
    ADD CONSTRAINT plan_ent_links_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: plan_ent_links_entitlement_links plan_ent_links_entitlement_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_entitlement_links
    ADD CONSTRAINT plan_ent_links_entitlement_links_fk FOREIGN KEY (plan_ent_link_id) REFERENCES public.plan_ent_links(id) ON DELETE CASCADE;


--
-- Name: plan_ent_links_entitlement_links plan_ent_links_entitlement_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_entitlement_links
    ADD CONSTRAINT plan_ent_links_entitlement_links_inv_fk FOREIGN KEY (entitlement_id) REFERENCES public.entitlements(id) ON DELETE CASCADE;


--
-- Name: plan_ent_links_plan_links plan_ent_links_plan_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_plan_links
    ADD CONSTRAINT plan_ent_links_plan_links_fk FOREIGN KEY (plan_ent_link_id) REFERENCES public.plan_ent_links(id) ON DELETE CASCADE;


--
-- Name: plan_ent_links_plan_links plan_ent_links_plan_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links_plan_links
    ADD CONSTRAINT plan_ent_links_plan_links_inv_fk FOREIGN KEY (plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: plan_ent_links plan_ent_links_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plan_ent_links
    ADD CONSTRAINT plan_ent_links_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: plans plans_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: plans_inherit_from_links plans_inherit_from_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_inherit_from_links
    ADD CONSTRAINT plans_inherit_from_links_fk FOREIGN KEY (plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: plans_inherit_from_links plans_inherit_from_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_inherit_from_links
    ADD CONSTRAINT plans_inherit_from_links_inv_fk FOREIGN KEY (inv_plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: plans_localizations_links plans_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_localizations_links
    ADD CONSTRAINT plans_localizations_links_fk FOREIGN KEY (plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: plans_localizations_links plans_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans_localizations_links
    ADD CONSTRAINT plans_localizations_links_inv_fk FOREIGN KEY (inv_plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: plans plans_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: subscriptions subscriptions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: subscriptions_plan_links subscriptions_plan_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions_plan_links
    ADD CONSTRAINT subscriptions_plan_links_fk FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- Name: subscriptions_plan_links subscriptions_plan_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions_plan_links
    ADD CONSTRAINT subscriptions_plan_links_inv_fk FOREIGN KEY (plan_id) REFERENCES public.plans(id) ON DELETE CASCADE;


--
-- Name: subscriptions subscriptions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_links up_permissions_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_links up_permissions_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_role_links up_users_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_links up_users_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_links upload_folders_parent_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_links upload_folders_parent_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usageledgers usageledgers_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers
    ADD CONSTRAINT usageledgers_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usageledgers_entitlement_links usageledgers_entitlement_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers_entitlement_links
    ADD CONSTRAINT usageledgers_entitlement_links_fk FOREIGN KEY (usageledger_id) REFERENCES public.usageledgers(id) ON DELETE CASCADE;


--
-- Name: usageledgers_entitlement_links usageledgers_entitlement_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers_entitlement_links
    ADD CONSTRAINT usageledgers_entitlement_links_inv_fk FOREIGN KEY (entitlement_id) REFERENCES public.entitlements(id) ON DELETE CASCADE;


--
-- Name: usageledgers usageledgers_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers
    ADD CONSTRAINT usageledgers_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: cloudsqlsuperuser
--

REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

