--
-- PostgreSQL database dump
--

-- Dumped from database version 14.22
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

--
-- Name: achievement_system; Type: SCHEMA; Schema: -; Owner: strapi
--

CREATE SCHEMA achievement_system;


ALTER SCHEMA achievement_system OWNER TO strapi;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: as_achievement_translations; Type: TABLE; Schema: achievement_system; Owner: strapi
--

CREATE TABLE achievement_system.as_achievement_translations (
    id bigint NOT NULL,
    achievement_id bigint NOT NULL,
    locale character varying(50) DEFAULT 'en'::character varying NOT NULL,
    title character varying(255),
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE achievement_system.as_achievement_translations OWNER TO strapi;

--
-- Name: as_achievement_translations_id_seq; Type: SEQUENCE; Schema: achievement_system; Owner: strapi
--

CREATE SEQUENCE achievement_system.as_achievement_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE achievement_system.as_achievement_translations_id_seq OWNER TO strapi;

--
-- Name: as_achievement_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: achievement_system; Owner: strapi
--

ALTER SEQUENCE achievement_system.as_achievement_translations_id_seq OWNED BY achievement_system.as_achievement_translations.id;


--
-- Name: as_achievements; Type: TABLE; Schema: achievement_system; Owner: strapi
--

CREATE TABLE achievement_system.as_achievements (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    event_name character varying(255) NOT NULL,
    icon_name character varying(255),
    points integer DEFAULT 1 NOT NULL,
    goal integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE achievement_system.as_achievements OWNER TO strapi;

--
-- Name: as_achievements_id_seq; Type: SEQUENCE; Schema: achievement_system; Owner: strapi
--

CREATE SEQUENCE achievement_system.as_achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE achievement_system.as_achievements_id_seq OWNER TO strapi;

--
-- Name: as_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: achievement_system; Owner: strapi
--

ALTER SEQUENCE achievement_system.as_achievements_id_seq OWNED BY achievement_system.as_achievements.id;


--
-- Name: as_event_lists; Type: TABLE; Schema: achievement_system; Owner: strapi
--

CREATE TABLE achievement_system.as_event_lists (
    id bigint NOT NULL,
    event_name character varying(255) NOT NULL,
    points integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE achievement_system.as_event_lists OWNER TO strapi;

--
-- Name: as_event_lists_id_seq; Type: SEQUENCE; Schema: achievement_system; Owner: strapi
--

CREATE SEQUENCE achievement_system.as_event_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE achievement_system.as_event_lists_id_seq OWNER TO strapi;

--
-- Name: as_event_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: achievement_system; Owner: strapi
--

ALTER SEQUENCE achievement_system.as_event_lists_id_seq OWNED BY achievement_system.as_event_lists.id;


--
-- Name: as_user_achievements; Type: TABLE; Schema: achievement_system; Owner: strapi
--

CREATE TABLE achievement_system.as_user_achievements (
    id bigint NOT NULL,
    userid character varying(255) NOT NULL,
    username character varying(255),
    achievement_id bigint NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    achieved boolean DEFAULT false NOT NULL,
    achieved_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE achievement_system.as_user_achievements OWNER TO strapi;

--
-- Name: as_user_achievements_id_seq; Type: SEQUENCE; Schema: achievement_system; Owner: strapi
--

CREATE SEQUENCE achievement_system.as_user_achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE achievement_system.as_user_achievements_id_seq OWNER TO strapi;

--
-- Name: as_user_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: achievement_system; Owner: strapi
--

ALTER SEQUENCE achievement_system.as_user_achievements_id_seq OWNED BY achievement_system.as_user_achievements.id;


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
-- Name: apple_notifications; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.apple_notifications (
    id integer NOT NULL,
    notification_uuid character varying(255),
    notification_type character varying(255),
    subtype character varying(255),
    original_transaction_id character varying(255),
    processing_status character varying(255),
    raw_signed_payload text,
    transaction_info jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.apple_notifications OWNER TO strapi;

--
-- Name: apple_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.apple_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apple_notifications_id_seq OWNER TO strapi;

--
-- Name: apple_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.apple_notifications_id_seq OWNED BY public.apple_notifications.id;


--
-- Name: apple_notifications_subscription_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.apple_notifications_subscription_links (
    id integer NOT NULL,
    apple_notification_id integer,
    subscription_id integer,
    apple_notification_order double precision
);


ALTER TABLE public.apple_notifications_subscription_links OWNER TO strapi;

--
-- Name: apple_notifications_subscription_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.apple_notifications_subscription_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apple_notifications_subscription_links_id_seq OWNER TO strapi;

--
-- Name: apple_notifications_subscription_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.apple_notifications_subscription_links_id_seq OWNED BY public.apple_notifications_subscription_links.id;


--
-- Name: apple_receipts; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.apple_receipts (
    id integer NOT NULL,
    transaction_id character varying(255),
    user_id integer,
    raw_receipt text,
    status character varying(255),
    last_attempt_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.apple_receipts OWNER TO strapi;

--
-- Name: apple_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.apple_receipts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apple_receipts_id_seq OWNER TO strapi;

--
-- Name: apple_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.apple_receipts_id_seq OWNED BY public.apple_receipts.id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    event character varying(255),
    status character varying(255),
    message character varying(255),
    details jsonb,
    strapi_user_id integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.audit_logs OWNER TO strapi;

--
-- Name: audit_logs_apple_notification_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.audit_logs_apple_notification_links (
    id integer NOT NULL,
    audit_log_id integer,
    apple_notification_id integer
);


ALTER TABLE public.audit_logs_apple_notification_links OWNER TO strapi;

--
-- Name: audit_logs_apple_notification_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.audit_logs_apple_notification_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_apple_notification_links_id_seq OWNER TO strapi;

--
-- Name: audit_logs_apple_notification_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.audit_logs_apple_notification_links_id_seq OWNED BY public.audit_logs_apple_notification_links.id;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_id_seq OWNER TO strapi;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


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
-- Name: feature_i18ns; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.feature_i18ns (
    id integer NOT NULL,
    feature_name character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.feature_i18ns OWNER TO strapi;

--
-- Name: feature_i18ns_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.feature_i18ns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_i18ns_id_seq OWNER TO strapi;

--
-- Name: feature_i18ns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.feature_i18ns_id_seq OWNED BY public.feature_i18ns.id;


--
-- Name: feature_i_18_ns_feature_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.feature_i_18_ns_feature_links (
    id integer NOT NULL,
    feature_i_18_n_id integer,
    feature_id integer,
    feature_i_18_n_order double precision
);


ALTER TABLE public.feature_i_18_ns_feature_links OWNER TO strapi;

--
-- Name: feature_i_18_ns_feature_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.feature_i_18_ns_feature_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_i_18_ns_feature_links_id_seq OWNER TO strapi;

--
-- Name: feature_i_18_ns_feature_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.feature_i_18_ns_feature_links_id_seq OWNED BY public.feature_i_18_ns_feature_links.id;


--
-- Name: feature_i_18_ns_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.feature_i_18_ns_localizations_links (
    id integer NOT NULL,
    feature_i_18_n_id integer,
    inv_feature_i_18_n_id integer,
    feature_i_18_n_order double precision
);


ALTER TABLE public.feature_i_18_ns_localizations_links OWNER TO strapi;

--
-- Name: feature_i_18_ns_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.feature_i_18_ns_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_i_18_ns_localizations_links_id_seq OWNER TO strapi;

--
-- Name: feature_i_18_ns_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.feature_i_18_ns_localizations_links_id_seq OWNED BY public.feature_i_18_ns_localizations_links.id;


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
    start_date timestamp(6) without time zone,
    revocation_date timestamp(6) without time zone,
    revocation_reason character varying(255)
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
-- Name: usage_events; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usage_events (
    id integer NOT NULL,
    event_id character varying(255),
    event_name character varying(255),
    strapi_user_id integer,
    username character varying(255),
    payload jsonb,
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    handle_result text,
    handled_at timestamp(6) without time zone
);


ALTER TABLE public.usage_events OWNER TO strapi;

--
-- Name: usage_events_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usage_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_events_id_seq OWNER TO strapi;

--
-- Name: usage_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usage_events_id_seq OWNED BY public.usage_events.id;


--
-- Name: usage_records; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usage_records (
    id integer NOT NULL,
    strapi_user_id integer,
    period_start timestamp(6) without time zone,
    period_end timestamp(6) without time zone,
    used_amount integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.usage_records OWNER TO strapi;

--
-- Name: usage_records_entitlement_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usage_records_entitlement_links (
    id integer NOT NULL,
    usage_record_id integer,
    entitlement_id integer
);


ALTER TABLE public.usage_records_entitlement_links OWNER TO strapi;

--
-- Name: usage_records_entitlement_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usage_records_entitlement_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_records_entitlement_links_id_seq OWNER TO strapi;

--
-- Name: usage_records_entitlement_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usage_records_entitlement_links_id_seq OWNED BY public.usage_records_entitlement_links.id;


--
-- Name: usage_records_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usage_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_records_id_seq OWNER TO strapi;

--
-- Name: usage_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usage_records_id_seq OWNED BY public.usage_records.id;


--
-- Name: usage_rules; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usage_rules (
    id integer NOT NULL,
    event_name character varying(255),
    amount integer,
    enabled boolean,
    filter_json jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.usage_rules OWNER TO strapi;

--
-- Name: usage_rules_entitlement_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.usage_rules_entitlement_links (
    id integer NOT NULL,
    usage_rule_id integer,
    entitlement_id integer
);


ALTER TABLE public.usage_rules_entitlement_links OWNER TO strapi;

--
-- Name: usage_rules_entitlement_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usage_rules_entitlement_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_rules_entitlement_links_id_seq OWNER TO strapi;

--
-- Name: usage_rules_entitlement_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usage_rules_entitlement_links_id_seq OWNED BY public.usage_rules_entitlement_links.id;


--
-- Name: usage_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.usage_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_rules_id_seq OWNER TO strapi;

--
-- Name: usage_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.usage_rules_id_seq OWNED BY public.usage_rules.id;


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
-- Name: as_achievement_translations id; Type: DEFAULT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievement_translations ALTER COLUMN id SET DEFAULT nextval('achievement_system.as_achievement_translations_id_seq'::regclass);


--
-- Name: as_achievements id; Type: DEFAULT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievements ALTER COLUMN id SET DEFAULT nextval('achievement_system.as_achievements_id_seq'::regclass);


--
-- Name: as_event_lists id; Type: DEFAULT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_event_lists ALTER COLUMN id SET DEFAULT nextval('achievement_system.as_event_lists_id_seq'::regclass);


--
-- Name: as_user_achievements id; Type: DEFAULT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_user_achievements ALTER COLUMN id SET DEFAULT nextval('achievement_system.as_user_achievements_id_seq'::regclass);


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
-- Name: apple_notifications id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications ALTER COLUMN id SET DEFAULT nextval('public.apple_notifications_id_seq'::regclass);


--
-- Name: apple_notifications_subscription_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications_subscription_links ALTER COLUMN id SET DEFAULT nextval('public.apple_notifications_subscription_links_id_seq'::regclass);


--
-- Name: apple_receipts id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_receipts ALTER COLUMN id SET DEFAULT nextval('public.apple_receipts_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: audit_logs_apple_notification_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs_apple_notification_links ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_apple_notification_links_id_seq'::regclass);


--
-- Name: components_a_features id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_features ALTER COLUMN id SET DEFAULT nextval('public.components_a_features_id_seq'::regclass);


--
-- Name: entitlements id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.entitlements ALTER COLUMN id SET DEFAULT nextval('public.entitlements_id_seq'::regclass);


--
-- Name: feature_i18ns id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i18ns ALTER COLUMN id SET DEFAULT nextval('public.feature_i18ns_id_seq'::regclass);


--
-- Name: feature_i_18_ns_feature_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_feature_links ALTER COLUMN id SET DEFAULT nextval('public.feature_i_18_ns_feature_links_id_seq'::regclass);


--
-- Name: feature_i_18_ns_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.feature_i_18_ns_localizations_links_id_seq'::regclass);


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
-- Name: usage_events id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_events ALTER COLUMN id SET DEFAULT nextval('public.usage_events_id_seq'::regclass);


--
-- Name: usage_records id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records ALTER COLUMN id SET DEFAULT nextval('public.usage_records_id_seq'::regclass);


--
-- Name: usage_records_entitlement_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records_entitlement_links ALTER COLUMN id SET DEFAULT nextval('public.usage_records_entitlement_links_id_seq'::regclass);


--
-- Name: usage_rules id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules ALTER COLUMN id SET DEFAULT nextval('public.usage_rules_id_seq'::regclass);


--
-- Name: usage_rules_entitlement_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules_entitlement_links ALTER COLUMN id SET DEFAULT nextval('public.usage_rules_entitlement_links_id_seq'::regclass);


--
-- Name: usageledgers id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers ALTER COLUMN id SET DEFAULT nextval('public.usageledgers_id_seq'::regclass);


--
-- Name: usageledgers_entitlement_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usageledgers_entitlement_links ALTER COLUMN id SET DEFAULT nextval('public.usageledgers_entitlement_links_id_seq'::regclass);


--
-- Data for Name: as_achievement_translations; Type: TABLE DATA; Schema: achievement_system; Owner: strapi
--

COPY achievement_system.as_achievement_translations (id, achievement_id, locale, title, description, created_at, updated_at) FROM stdin;
1	1	en	Create 10 Flashcards	Create 10 flashcards in LangGo.	2026-05-04 21:05:25.127+00	2026-05-06 16:18:30.087242+00
3	2	en	Create 50 Flashcards	Create 50 flashcards in LangGo.	2026-05-04 21:06:05.884+00	2026-05-06 16:18:30.087242+00
5	3	en	Create 100 Flashcards	Create 100 flashcards in LangGo.	2026-05-04 21:06:27.41+00	2026-05-06 16:18:30.087242+00
7	4	en	Create 200 Flashcards	Create 200 flashcards in LangGo.	2026-05-04 21:06:49.498+00	2026-05-06 16:18:30.087242+00
9	5	en	Create 500 Flashcards	Create 500 flashcards in LangGo.	2026-05-04 21:07:12.125+00	2026-05-06 16:18:30.087242+00
11	6	en	Create 1000 Flashcards	Create 1000 flashcards in LangGo.	2026-05-04 21:07:24.168+00	2026-05-06 16:18:30.087242+00
13	7	en	Create 2000 Flashcards	Create 2000 flashcards in LangGo.	2026-05-04 21:07:42.908+00	2026-05-06 16:18:30.087242+00
15	8	en	Create 3000 Flashcards	Create 3000 flashcards in LangGo.	2026-05-04 21:08:00.024+00	2026-05-06 16:18:30.087242+00
17	9	en	Create 5000 Flashcards	Create 5000 flashcards in LangGo.	2026-05-04 21:08:17.555+00	2026-05-06 16:18:30.087242+00
19	10	en	Complete 100 Reviews	Complete 100 flashcard reviews in LangGo.	2026-05-04 21:09:14.216+00	2026-05-06 16:18:30.087242+00
21	11	en	Complete 200 Reviews	Complete 200 flashcard reviews in LangGo.	2026-05-04 21:09:51.515+00	2026-05-06 16:18:30.087242+00
23	12	en	Complete 500 Reviews	Complete 500 flashcard reviews in LangGo.	2026-05-04 21:10:14.686+00	2026-05-06 16:18:30.087242+00
25	13	en	Complete 1000 Reviews	Complete 1000 flashcard reviews in LangGo.	2026-05-04 21:11:00.936+00	2026-05-06 16:18:30.087242+00
27	14	en	Complete 2000 Reviews	Complete 2000 flashcard reviews in LangGo.	2026-05-04 21:11:27.529+00	2026-05-06 16:18:30.087242+00
29	15	en	Complete 3000 Reviews	Complete 3000 flashcard reviews in LangGo.	2026-05-04 21:12:08.462+00	2026-05-06 16:18:30.087242+00
31	16	en	Complete 5000 Reviews	Complete 5000 flashcard reviews in LangGo.	2026-05-04 21:12:50.558+00	2026-05-06 16:18:30.087242+00
33	17	en	Remember 10 Flashcards	Remember 10 flashcards in LangGo.	2026-05-04 21:47:22.961+00	2026-05-06 16:18:30.087242+00
35	18	en	Remember 20 Flashcards	Remember 20 flashcards in LangGo.	2026-05-04 21:47:51.873+00	2026-05-06 16:18:30.087242+00
37	19	en	Remember 50 Flashcards	Remember 50 flashcards in LangGo.	2026-05-04 21:48:14.065+00	2026-05-06 16:18:30.087242+00
39	20	en	Remember 100 Flashcards	Remember 100 flashcards in LangGo.	2026-05-04 21:48:36.776+00	2026-05-06 16:18:30.087242+00
41	21	en	Remember 200 Flashcards	Remember 200 flashcards in LangGo.	2026-05-04 21:49:18.334+00	2026-05-06 16:18:30.087242+00
43	22	en	Remember 500 Flashcards	Remember 500 flashcards in LangGo.	2026-05-04 21:49:56.678+00	2026-05-06 16:18:30.087242+00
45	23	en	Remember 1000 Flashcards	Remember 1000 flashcards in LangGo.	2026-05-04 21:50:31.416+00	2026-05-06 16:18:30.087242+00
47	24	en	Remember 2000 Flashcards	Remember 2000 flashcards in LangGo.	2026-05-04 21:50:48.995+00	2026-05-06 16:18:30.087242+00
49	25	en	Remember 3000 Flashcards	Remember 3000 flashcards in LangGo.	2026-05-04 21:51:18.454+00	2026-05-06 16:18:30.087242+00
51	26	en	Remember 5000 Flashcards	Remember 5000 flashcards in LangGo.	2026-05-04 21:51:39.33+00	2026-05-06 16:18:30.087242+00
\.


--
-- Data for Name: as_achievements; Type: TABLE DATA; Schema: achievement_system; Owner: strapi
--

COPY achievement_system.as_achievements (id, code, event_name, icon_name, points, goal, created_at, updated_at) FROM stdin;
1	FLASHCARD_CREATE_10	flashcard.create	pencil	1	10	2026-05-04 21:05:25.127+00	2026-05-06 15:53:20.515831+00
2	FLASHCARD_CREATE_50	flashcard.create	square.and.pencil	1	50	2026-05-04 21:06:05.884+00	2026-05-06 15:53:20.515831+00
3	FLASHCARD_CREATE_100	flashcard.create	note.text.badge.plus	1	100	2026-05-04 21:06:27.41+00	2026-05-06 15:53:20.515831+00
4	FLASHCARD_CREATE_200	flashcard.create	text.badge.plus	1	200	2026-05-04 21:06:49.498+00	2026-05-06 15:53:20.515831+00
5	FLASHCARD_CREATE_500	flashcard.create	plus.square.on.square	1	500	2026-05-04 21:07:12.125+00	2026-05-06 15:53:20.515831+00
6	FLASHCARD_CREATE_1000	flashcard.create	rectangle.stack.badge.plus	1	1000	2026-05-04 21:07:24.168+00	2026-05-06 15:53:20.515831+00
7	FLASHCARD_CREATE_2000	flashcard.create	square.stack.3d.up	1	2000	2026-05-04 21:07:42.908+00	2026-05-06 15:53:20.515831+00
8	FLASHCARD_CREATE_3000	flashcard.create	books.vertical.fill	1	3000	2026-05-04 21:08:00.024+00	2026-05-06 15:53:20.515831+00
9	FLASHCARD_CREATE_5000	flashcard.create	archivebox.fill	1	5000	2026-05-04 21:08:17.555+00	2026-05-06 15:53:20.515831+00
10	FLASHCARD_REVIEW_100	flashcard.review	play.circle	1	100	2026-05-04 21:09:14.216+00	2026-05-06 15:53:20.515831+00
11	FLASHCARD_REVIEW_200	flashcard.review	play.circle.fill	1	200	2026-05-04 21:09:51.515+00	2026-05-06 15:53:20.515831+00
12	FLASHCARD_REVIEW_500	flashcard.review	arrow.triangle.2.circlepath.circle	1	500	2026-05-04 21:10:14.686+00	2026-05-06 15:53:20.515831+00
13	FLASHCARD_REVIEW_1000	flashcard.review	checkmark.circle	1	1000	2026-05-04 21:11:00.936+00	2026-05-06 15:53:20.515831+00
14	FLASHCARD_REVIEW_2000	flashcard.review	checkmark.circle.fill	1	2000	2026-05-04 21:11:27.529+00	2026-05-06 15:53:20.515831+00
15	FLASHCARD_REVIEW_3000	flashcard.review	checkmark.seal	1	3000	2026-05-04 21:12:08.462+00	2026-05-06 15:53:20.515831+00
16	FLASHCARD_REVIEW_5000	flashcard.review	checkmark.seal.fill	1	5000	2026-05-04 21:12:50.558+00	2026-05-06 15:53:20.515831+00
17	FLASHCARD_REMEMBERED_10	flashcard.remembered	sparkles	1	10	2026-05-04 21:47:22.961+00	2026-05-06 15:53:20.515831+00
18	FLASHCARD_REMEMBERED_20	flashcard.remembered	star	1	20	2026-05-04 21:47:51.873+00	2026-05-06 15:53:20.515831+00
19	FLASHCARD_REMEMBERED_50	flashcard.remembered	star.fill	1	50	2026-05-04 21:48:14.065+00	2026-05-06 15:53:20.515831+00
20	FLASHCARD_REMEMBERED_100	flashcard.remembered	star.circle	1	100	2026-05-04 21:48:36.776+00	2026-05-06 15:53:20.515831+00
21	FLASHCARD_REMEMBERED_200	flashcard.remembered	star.circle.fill	1	200	2026-05-04 21:49:18.334+00	2026-05-06 15:53:20.515831+00
22	FLASHCARD_REMEMBERED_500	flashcard.remembered	flag.fill	1	500	2026-05-04 21:49:56.678+00	2026-05-06 15:53:20.515831+00
23	FLASHCARD_REMEMBERED_1000	flashcard.remembered	rosette	1	1000	2026-05-04 21:50:31.416+00	2026-05-06 15:53:20.515831+00
24	FLASHCARD_REMEMBERED_2000	flashcard.remembered	medal.fill	1	2000	2026-05-04 21:50:48.995+00	2026-05-06 15:53:20.515831+00
25	FLASHCARD_REMEMBERED_3000	flashcard.remembered	crown	1	3000	2026-05-04 21:51:18.454+00	2026-05-06 15:53:20.515831+00
26	FLASHCARD_REMEMBERED_5000	flashcard.remembered	crown.fill	1	5000	2026-05-04 21:51:39.33+00	2026-05-06 15:53:20.515831+00
\.


--
-- Data for Name: as_event_lists; Type: TABLE DATA; Schema: achievement_system; Owner: strapi
--

COPY achievement_system.as_event_lists (id, event_name, points, created_at, updated_at) FROM stdin;
1	flashcard.create	1	2026-05-04 21:38:27.732+00	2026-05-04 21:38:27.732+00
2	flashcard.review	1	2026-05-04 21:38:34.296+00	2026-05-04 21:38:34.296+00
3	flashcard.remembered	1	2026-05-04 21:38:49.875+00	2026-05-04 21:38:49.875+00
4	article.create	1	2026-05-04 21:39:52.327+00	2026-05-04 21:39:52.327+00
\.


--
-- Data for Name: as_user_achievements; Type: TABLE DATA; Schema: achievement_system; Owner: strapi
--

COPY achievement_system.as_user_achievements (id, userid, username, achievement_id, progress, achieved, achieved_at, created_at, updated_at) FROM stdin;
1	60	chinese2	1	10	t	2026-05-04 23:31:14.68+00	2026-05-04 22:29:34.025+00	2026-05-04 23:31:14.806+00
2	60	chinese2	2	11	f	\N	2026-05-04 22:29:34.667+00	2026-05-04 23:31:20.574+00
3	60	chinese2	3	11	f	\N	2026-05-04 22:29:34.911+00	2026-05-04 23:31:21.119+00
4	60	chinese2	4	11	f	\N	2026-05-04 22:29:35.142+00	2026-05-04 23:31:21.656+00
5	60	chinese2	5	11	f	\N	2026-05-04 22:29:35.372+00	2026-05-04 23:31:22.178+00
6	60	chinese2	6	11	f	\N	2026-05-04 22:29:35.597+00	2026-05-04 23:31:22.718+00
7	60	chinese2	7	11	f	\N	2026-05-04 22:29:35.828+00	2026-05-04 23:31:23.242+00
8	60	chinese2	8	11	f	\N	2026-05-04 22:29:36.062+00	2026-05-04 23:31:23.78+00
9	60	chinese2	9	11	f	\N	2026-05-04 22:29:36.296+00	2026-05-04 23:31:24.318+00
10	60	chinese2	10	100	t	2026-05-07 22:29:09.739+00	2026-05-04 22:29:36.526+00	2026-05-07 22:29:09.866+00
11	60	chinese2	11	184	f	\N	2026-05-04 22:29:36.751+00	2026-05-09 08:25:37.402+00
12	60	chinese2	12	184	f	\N	2026-05-04 22:29:36.981+00	2026-05-09 08:25:37.564+00
13	60	chinese2	13	184	f	\N	2026-05-04 22:29:37.213+00	2026-05-09 08:25:37.675+00
14	60	chinese2	14	184	f	\N	2026-05-04 22:29:37.441+00	2026-05-09 08:25:37.789+00
15	60	chinese2	15	184	f	\N	2026-05-04 22:29:37.663+00	2026-05-09 08:25:37.833+00
16	60	chinese2	16	184	f	\N	2026-05-04 22:29:37.886+00	2026-05-09 08:25:39.488+00
17	60	chinese2	17	0	f	\N	2026-05-04 22:29:38.109+00	2026-05-04 22:29:38.109+00
18	60	chinese2	18	0	f	\N	2026-05-04 22:29:38.332+00	2026-05-04 22:29:38.332+00
19	60	chinese2	19	0	f	\N	2026-05-04 22:29:38.552+00	2026-05-04 22:29:38.552+00
20	60	chinese2	20	0	f	\N	2026-05-04 22:29:38.763+00	2026-05-04 22:29:38.763+00
21	60	chinese2	21	0	f	\N	2026-05-04 22:29:38.984+00	2026-05-04 22:29:38.984+00
22	60	chinese2	22	0	f	\N	2026-05-04 22:29:39.245+00	2026-05-04 22:29:39.245+00
23	60	chinese2	23	0	f	\N	2026-05-04 22:29:39.469+00	2026-05-04 22:29:39.469+00
24	60	chinese2	24	0	f	\N	2026-05-04 22:29:39.694+00	2026-05-04 22:29:39.694+00
25	60	chinese2	25	0	f	\N	2026-05-04 22:29:39.922+00	2026-05-04 22:29:39.922+00
26	60	chinese2	26	0	f	\N	2026-05-04 22:29:40.155+00	2026-05-04 22:29:40.155+00
27	8	vivian	1	10	t	2026-05-06 06:02:12.072+00	2026-05-06 02:06:31.781+00	2026-05-06 06:02:12.087+00
28	8	vivian	2	50	t	2026-05-10 17:56:51.422+00	2026-05-06 02:06:32.152+00	2026-05-10 17:56:51.455+00
29	8	vivian	3	93	f	\N	2026-05-06 02:06:32.257+00	2026-05-10 19:06:21.774+00
30	8	vivian	4	93	f	\N	2026-05-06 02:06:32.441+00	2026-05-10 19:06:21.987+00
31	8	vivian	5	93	f	\N	2026-05-06 02:06:32.474+00	2026-05-10 19:06:22.157+00
32	8	vivian	6	93	f	\N	2026-05-06 02:06:32.521+00	2026-05-10 19:06:22.259+00
33	8	vivian	7	93	f	\N	2026-05-06 02:06:32.545+00	2026-05-10 19:06:22.325+00
34	8	vivian	8	93	f	\N	2026-05-06 02:06:32.564+00	2026-05-10 19:06:22.377+00
35	8	vivian	9	93	f	\N	2026-05-06 02:06:32.581+00	2026-05-10 19:06:22.416+00
36	8	vivian	10	100	t	2026-05-06 02:15:33.338+00	2026-05-06 02:06:32.63+00	2026-05-06 02:15:33.349+00
37	8	vivian	11	200	t	2026-05-07 04:41:36.998+00	2026-05-06 02:06:32.649+00	2026-05-07 04:41:37.018+00
38	8	vivian	12	500	t	2026-05-08 06:09:31.298+00	2026-05-06 02:06:32.717+00	2026-05-08 06:09:31.313+00
39	8	vivian	13	840	f	\N	2026-05-06 02:06:32.731+00	2026-05-10 05:19:20.657+00
40	8	vivian	14	840	f	\N	2026-05-06 02:06:32.751+00	2026-05-10 05:19:20.702+00
41	8	vivian	15	840	f	\N	2026-05-06 02:06:34.418+00	2026-05-10 05:19:20.768+00
42	8	vivian	16	840	f	\N	2026-05-06 02:06:34.439+00	2026-05-10 05:19:20.886+00
43	8	vivian	17	0	f	\N	2026-05-06 02:06:34.471+00	2026-05-06 02:06:34.471+00
44	8	vivian	18	0	f	\N	2026-05-06 02:06:34.535+00	2026-05-06 02:06:34.535+00
45	8	vivian	19	0	f	\N	2026-05-06 02:06:34.555+00	2026-05-06 02:06:34.555+00
46	8	vivian	20	0	f	\N	2026-05-06 02:06:34.581+00	2026-05-06 02:06:34.581+00
47	8	vivian	21	0	f	\N	2026-05-06 02:06:34.627+00	2026-05-06 02:06:34.627+00
48	8	vivian	22	0	f	\N	2026-05-06 02:06:34.646+00	2026-05-06 02:06:34.646+00
49	8	vivian	23	0	f	\N	2026-05-06 02:06:34.666+00	2026-05-06 02:06:34.666+00
50	8	vivian	24	0	f	\N	2026-05-06 02:06:34.684+00	2026-05-06 02:06:34.684+00
51	8	vivian	25	0	f	\N	2026-05-06 02:06:34.709+00	2026-05-06 02:06:34.709+00
52	8	vivian	26	0	f	\N	2026-05-06 02:06:34.732+00	2026-05-06 02:06:34.732+00
53	58	aug13	1	10	t	2026-05-05 23:56:56.811+00	2026-05-05 23:55:26.371+00	2026-05-05 23:56:56.931+00
54	58	aug13	2	14	f	\N	2026-05-05 23:55:26.655+00	2026-05-05 23:57:20.122+00
55	58	aug13	3	14	f	\N	2026-05-05 23:55:26.911+00	2026-05-05 23:57:20.654+00
56	58	aug13	4	14	f	\N	2026-05-05 23:55:27.126+00	2026-05-05 23:57:21.176+00
57	58	aug13	5	14	f	\N	2026-05-05 23:55:27.329+00	2026-05-05 23:57:21.703+00
58	58	aug13	6	14	f	\N	2026-05-05 23:55:27.553+00	2026-05-05 23:57:22.238+00
59	58	aug13	7	14	f	\N	2026-05-05 23:55:27.763+00	2026-05-05 23:57:22.73+00
60	58	aug13	8	14	f	\N	2026-05-05 23:55:27.972+00	2026-05-05 23:57:23.275+00
61	58	aug13	9	14	f	\N	2026-05-05 23:55:28.163+00	2026-05-05 23:57:23.888+00
62	58	aug13	10	0	f	\N	2026-05-05 23:55:28.356+00	2026-05-05 23:55:28.356+00
63	58	aug13	11	0	f	\N	2026-05-05 23:55:28.56+00	2026-05-05 23:55:28.56+00
64	58	aug13	12	0	f	\N	2026-05-05 23:55:28.762+00	2026-05-05 23:55:28.762+00
65	58	aug13	13	0	f	\N	2026-05-05 23:55:28.97+00	2026-05-05 23:55:28.97+00
66	58	aug13	14	0	f	\N	2026-05-05 23:55:29.174+00	2026-05-05 23:55:29.174+00
67	58	aug13	15	0	f	\N	2026-05-05 23:55:29.38+00	2026-05-05 23:55:29.38+00
68	58	aug13	16	0	f	\N	2026-05-05 23:55:29.591+00	2026-05-05 23:55:29.591+00
69	58	aug13	17	0	f	\N	2026-05-05 23:55:29.786+00	2026-05-05 23:55:29.786+00
70	58	aug13	18	0	f	\N	2026-05-05 23:55:30+00	2026-05-05 23:55:30+00
71	58	aug13	19	0	f	\N	2026-05-05 23:55:30.209+00	2026-05-05 23:55:30.209+00
72	58	aug13	20	0	f	\N	2026-05-05 23:55:30.419+00	2026-05-05 23:55:30.419+00
73	58	aug13	21	0	f	\N	2026-05-05 23:55:30.659+00	2026-05-05 23:55:30.659+00
74	58	aug13	22	0	f	\N	2026-05-05 23:55:30.862+00	2026-05-05 23:55:30.862+00
75	58	aug13	23	0	f	\N	2026-05-05 23:55:31.062+00	2026-05-05 23:55:31.062+00
76	58	aug13	24	0	f	\N	2026-05-05 23:55:31.309+00	2026-05-05 23:55:31.309+00
77	58	aug13	25	0	f	\N	2026-05-05 23:55:31.517+00	2026-05-05 23:55:31.517+00
78	58	aug13	26	0	f	\N	2026-05-05 23:55:31.73+00	2026-05-05 23:55:31.73+00
79	71	chinese3@langgo.ca	1	10	t	2026-05-06 00:09:58.865+00	2026-05-06 00:00:59.948+00	2026-05-06 00:09:58.997+00
80	71	chinese3@langgo.ca	2	17	f	\N	2026-05-06 00:01:00.735+00	2026-05-06 00:16:32.974+00
81	71	chinese3@langgo.ca	3	17	f	\N	2026-05-06 00:01:01.855+00	2026-05-06 00:16:33.522+00
82	71	chinese3@langgo.ca	4	17	f	\N	2026-05-06 00:01:02.487+00	2026-05-06 00:16:34.1+00
83	71	chinese3@langgo.ca	5	17	f	\N	2026-05-06 00:01:03.309+00	2026-05-06 00:16:34.679+00
84	71	chinese3@langgo.ca	6	17	f	\N	2026-05-06 00:01:03.725+00	2026-05-06 00:16:35.249+00
85	71	chinese3@langgo.ca	7	17	f	\N	2026-05-06 00:01:03.973+00	2026-05-06 00:16:35.803+00
86	71	chinese3@langgo.ca	8	17	f	\N	2026-05-06 00:01:05.296+00	2026-05-06 00:16:36.366+00
87	71	chinese3@langgo.ca	9	17	f	\N	2026-05-06 00:01:06.248+00	2026-05-06 00:16:36.962+00
88	71	chinese3@langgo.ca	10	17	f	\N	2026-05-06 00:01:06.662+00	2026-05-06 00:16:53.413+00
89	71	chinese3@langgo.ca	11	17	f	\N	2026-05-06 00:01:06.965+00	2026-05-06 00:16:53.956+00
90	71	chinese3@langgo.ca	12	17	f	\N	2026-05-06 00:01:07.215+00	2026-05-06 00:16:54.487+00
91	71	chinese3@langgo.ca	13	17	f	\N	2026-05-06 00:01:07.499+00	2026-05-06 00:16:55.011+00
92	71	chinese3@langgo.ca	14	17	f	\N	2026-05-06 00:01:07.749+00	2026-05-06 00:16:55.538+00
93	71	chinese3@langgo.ca	15	17	f	\N	2026-05-06 00:01:08.018+00	2026-05-06 00:16:56.07+00
94	71	chinese3@langgo.ca	16	17	f	\N	2026-05-06 00:01:08.366+00	2026-05-06 00:16:56.621+00
95	71	chinese3@langgo.ca	17	0	f	\N	2026-05-06 00:01:08.771+00	2026-05-06 00:01:08.771+00
96	71	chinese3@langgo.ca	18	0	f	\N	2026-05-06 00:01:09.155+00	2026-05-06 00:01:09.155+00
97	71	chinese3@langgo.ca	19	0	f	\N	2026-05-06 00:01:09.503+00	2026-05-06 00:01:09.503+00
98	71	chinese3@langgo.ca	20	0	f	\N	2026-05-06 00:01:09.754+00	2026-05-06 00:01:09.754+00
99	71	chinese3@langgo.ca	21	0	f	\N	2026-05-06 00:01:10.004+00	2026-05-06 00:01:10.004+00
100	71	chinese3@langgo.ca	22	0	f	\N	2026-05-06 00:01:10.257+00	2026-05-06 00:01:10.257+00
101	71	chinese3@langgo.ca	23	0	f	\N	2026-05-06 00:01:10.504+00	2026-05-06 00:01:10.504+00
102	71	chinese3@langgo.ca	24	0	f	\N	2026-05-06 00:01:10.738+00	2026-05-06 00:01:10.738+00
103	71	chinese3@langgo.ca	25	0	f	\N	2026-05-06 00:01:11.022+00	2026-05-06 00:01:11.022+00
104	71	chinese3@langgo.ca	26	0	f	\N	2026-05-06 00:01:11.273+00	2026-05-06 00:01:11.273+00
106	41	july15	1	0	f	\N	2026-05-08 23:32:39.09+00	2026-05-08 23:32:39.09+00
107	41	july15	2	0	f	\N	2026-05-08 23:32:39.317+00	2026-05-08 23:32:39.317+00
110	41	july15	3	0	f	\N	2026-05-08 23:32:39.53+00	2026-05-08 23:32:39.53+00
111	41	july15	4	0	f	\N	2026-05-08 23:32:39.753+00	2026-05-08 23:32:39.753+00
114	41	july15	5	0	f	\N	2026-05-08 23:32:39.965+00	2026-05-08 23:32:39.965+00
116	41	july15	6	0	f	\N	2026-05-08 23:32:40.181+00	2026-05-08 23:32:40.181+00
117	41	july15	7	0	f	\N	2026-05-08 23:32:40.41+00	2026-05-08 23:32:40.41+00
120	41	july15	8	0	f	\N	2026-05-08 23:32:40.621+00	2026-05-08 23:32:40.621+00
122	41	july15	9	0	f	\N	2026-05-08 23:32:40.827+00	2026-05-08 23:32:40.827+00
124	41	july15	10	0	f	\N	2026-05-08 23:32:41.041+00	2026-05-08 23:32:41.041+00
126	41	july15	11	0	f	\N	2026-05-08 23:32:41.255+00	2026-05-08 23:32:41.255+00
128	41	july15	12	0	f	\N	2026-05-08 23:32:41.454+00	2026-05-08 23:32:41.454+00
130	41	july15	13	0	f	\N	2026-05-08 23:32:41.657+00	2026-05-08 23:32:41.657+00
132	41	july15	14	0	f	\N	2026-05-08 23:32:41.866+00	2026-05-08 23:32:41.866+00
134	41	july15	15	0	f	\N	2026-05-08 23:32:42.078+00	2026-05-08 23:32:42.078+00
136	41	july15	16	0	f	\N	2026-05-08 23:32:42.286+00	2026-05-08 23:32:42.286+00
138	41	july15	17	0	f	\N	2026-05-08 23:32:42.501+00	2026-05-08 23:32:42.501+00
140	41	july15	18	0	f	\N	2026-05-08 23:32:42.746+00	2026-05-08 23:32:42.746+00
142	41	july15	19	0	f	\N	2026-05-08 23:32:42.954+00	2026-05-08 23:32:42.954+00
144	41	july15	20	0	f	\N	2026-05-08 23:32:43.153+00	2026-05-08 23:32:43.153+00
146	41	july15	21	0	f	\N	2026-05-08 23:32:43.374+00	2026-05-08 23:32:43.374+00
148	41	july15	22	0	f	\N	2026-05-08 23:32:43.581+00	2026-05-08 23:32:43.581+00
150	41	july15	23	0	f	\N	2026-05-08 23:32:43.786+00	2026-05-08 23:32:43.786+00
152	41	july15	24	0	f	\N	2026-05-08 23:32:43.999+00	2026-05-08 23:32:43.999+00
154	41	july15	25	0	f	\N	2026-05-08 23:32:44.198+00	2026-05-08 23:32:44.198+00
156	41	july15	26	0	f	\N	2026-05-08 23:32:44.409+00	2026-05-08 23:32:44.409+00
158	30	july7	1	0	f	\N	2026-05-09 00:50:53.525+00	2026-05-09 00:50:53.525+00
160	30	july7	2	0	f	\N	2026-05-09 00:50:53.75+00	2026-05-09 00:50:53.75+00
162	30	july7	3	0	f	\N	2026-05-09 00:50:53.96+00	2026-05-09 00:50:53.96+00
164	30	july7	4	0	f	\N	2026-05-09 00:50:54.169+00	2026-05-09 00:50:54.169+00
166	30	july7	5	0	f	\N	2026-05-09 00:50:54.378+00	2026-05-09 00:50:54.378+00
168	30	july7	6	0	f	\N	2026-05-09 00:50:54.586+00	2026-05-09 00:50:54.586+00
170	30	july7	7	0	f	\N	2026-05-09 00:50:54.795+00	2026-05-09 00:50:54.795+00
172	30	july7	8	0	f	\N	2026-05-09 00:50:55.006+00	2026-05-09 00:50:55.006+00
174	30	july7	9	0	f	\N	2026-05-09 00:50:55.216+00	2026-05-09 00:50:55.216+00
176	30	july7	10	0	f	\N	2026-05-09 00:50:55.428+00	2026-05-09 00:50:55.428+00
178	30	july7	11	0	f	\N	2026-05-09 00:50:55.637+00	2026-05-09 00:50:55.637+00
180	30	july7	12	0	f	\N	2026-05-09 00:50:55.849+00	2026-05-09 00:50:55.849+00
182	30	july7	13	0	f	\N	2026-05-09 00:50:56.057+00	2026-05-09 00:50:56.057+00
184	30	july7	14	0	f	\N	2026-05-09 00:50:56.264+00	2026-05-09 00:50:56.264+00
186	30	july7	15	0	f	\N	2026-05-09 00:50:56.473+00	2026-05-09 00:50:56.473+00
188	30	july7	16	0	f	\N	2026-05-09 00:50:56.68+00	2026-05-09 00:50:56.68+00
190	30	july7	17	0	f	\N	2026-05-09 00:50:56.891+00	2026-05-09 00:50:56.891+00
192	30	july7	18	0	f	\N	2026-05-09 00:50:57.099+00	2026-05-09 00:50:57.099+00
194	30	july7	19	0	f	\N	2026-05-09 00:50:57.313+00	2026-05-09 00:50:57.313+00
196	30	july7	20	0	f	\N	2026-05-09 00:50:57.52+00	2026-05-09 00:50:57.52+00
198	30	july7	21	0	f	\N	2026-05-09 00:50:57.729+00	2026-05-09 00:50:57.729+00
200	30	july7	22	0	f	\N	2026-05-09 00:50:57.942+00	2026-05-09 00:50:57.942+00
202	30	july7	23	0	f	\N	2026-05-09 00:50:58.153+00	2026-05-09 00:50:58.153+00
204	30	july7	24	0	f	\N	2026-05-09 00:50:58.365+00	2026-05-09 00:50:58.365+00
206	30	july7	25	0	f	\N	2026-05-09 00:50:58.571+00	2026-05-09 00:50:58.571+00
208	30	july7	26	0	f	\N	2026-05-09 00:50:58.78+00	2026-05-09 00:50:58.78+00
\.


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
101	plugin::content-manager.explorer.delete	{}	api::feature.feature	{"locales": ["en"]}	[]	2025-07-05 17:33:41.113	2025-07-05 17:33:41.113	\N	\N
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
140	plugin::content-manager.explorer.create	{}	api::apple-notification.apple-notification	{"fields": ["notificationUUID", "notificationType", "subtype", "originalTransactionId", "processingStatus", "rawSignedPayload", "transactionInfo", "subscription", "audit_log"]}	[]	2025-07-31 21:17:25.819	2025-07-31 21:17:25.819	\N	\N
141	plugin::content-manager.explorer.create	{}	api::apple-receipt.apple-receipt	{"fields": ["transactionId", "userId", "rawReceipt", "status", "lastAttemptAt"]}	[]	2025-07-31 21:17:26.014	2025-07-31 21:17:26.014	\N	\N
142	plugin::content-manager.explorer.create	{}	api::audit-log.audit-log	{"fields": ["event", "status", "message", "details", "strapiUserId", "apple_notification"]}	[]	2025-07-31 21:17:26.199	2025-07-31 21:17:26.199	\N	\N
143	plugin::content-manager.explorer.create	{}	api::ping.ping	{"fields": ["status"]}	[]	2025-07-31 21:17:26.395	2025-07-31 21:17:26.395	\N	\N
144	plugin::content-manager.explorer.create	{}	api::plan.plan	{"fields": ["name", "productId", "inherit_from", "childPlans", "saleProductId", "saleStartDate", "saleEndDate", "subscriptions", "features", "plan_ent_links", "order", "role"], "locales": ["en"]}	[]	2025-07-31 21:17:26.595	2025-07-31 21:17:26.595	\N	\N
145	plugin::content-manager.explorer.create	{}	api::subscription.subscription	{"fields": ["strapiUserId", "plan", "status", "expireDate", "originalTransactionId", "latestTransactionId", "startDate", "apple_notifications", "revocationDate", "revocationReason"]}	[]	2025-07-31 21:17:26.789	2025-07-31 21:17:26.789	\N	\N
146	plugin::content-manager.explorer.read	{}	api::apple-notification.apple-notification	{"fields": ["notificationUUID", "notificationType", "subtype", "originalTransactionId", "processingStatus", "rawSignedPayload", "transactionInfo", "subscription", "audit_log"]}	[]	2025-07-31 21:17:26.985	2025-07-31 21:17:26.985	\N	\N
147	plugin::content-manager.explorer.read	{}	api::apple-receipt.apple-receipt	{"fields": ["transactionId", "userId", "rawReceipt", "status", "lastAttemptAt"]}	[]	2025-07-31 21:17:27.172	2025-07-31 21:17:27.172	\N	\N
148	plugin::content-manager.explorer.read	{}	api::audit-log.audit-log	{"fields": ["event", "status", "message", "details", "strapiUserId", "apple_notification"]}	[]	2025-07-31 21:17:27.366	2025-07-31 21:17:27.366	\N	\N
149	plugin::content-manager.explorer.read	{}	api::ping.ping	{"fields": ["status"]}	[]	2025-07-31 21:17:27.56	2025-07-31 21:17:27.56	\N	\N
150	plugin::content-manager.explorer.read	{}	api::plan.plan	{"fields": ["name", "productId", "inherit_from", "childPlans", "saleProductId", "saleStartDate", "saleEndDate", "subscriptions", "features", "plan_ent_links", "order", "role"], "locales": ["en"]}	[]	2025-07-31 21:17:27.754	2025-07-31 21:17:27.754	\N	\N
151	plugin::content-manager.explorer.read	{}	api::subscription.subscription	{"fields": ["strapiUserId", "plan", "status", "expireDate", "originalTransactionId", "latestTransactionId", "startDate", "apple_notifications", "revocationDate", "revocationReason"]}	[]	2025-07-31 21:17:27.948	2025-07-31 21:17:27.948	\N	\N
152	plugin::content-manager.explorer.update	{}	api::apple-notification.apple-notification	{"fields": ["notificationUUID", "notificationType", "subtype", "originalTransactionId", "processingStatus", "rawSignedPayload", "transactionInfo", "subscription", "audit_log"]}	[]	2025-07-31 21:17:28.143	2025-07-31 21:17:28.143	\N	\N
153	plugin::content-manager.explorer.update	{}	api::apple-receipt.apple-receipt	{"fields": ["transactionId", "userId", "rawReceipt", "status", "lastAttemptAt"]}	[]	2025-07-31 21:17:28.345	2025-07-31 21:17:28.345	\N	\N
154	plugin::content-manager.explorer.update	{}	api::audit-log.audit-log	{"fields": ["event", "status", "message", "details", "strapiUserId", "apple_notification"]}	[]	2025-07-31 21:17:28.549	2025-07-31 21:17:28.549	\N	\N
155	plugin::content-manager.explorer.update	{}	api::ping.ping	{"fields": ["status"]}	[]	2025-07-31 21:17:28.741	2025-07-31 21:17:28.741	\N	\N
156	plugin::content-manager.explorer.update	{}	api::plan.plan	{"fields": ["name", "productId", "inherit_from", "childPlans", "saleProductId", "saleStartDate", "saleEndDate", "subscriptions", "features", "plan_ent_links", "order", "role"], "locales": ["en"]}	[]	2025-07-31 21:17:28.956	2025-07-31 21:17:28.956	\N	\N
157	plugin::content-manager.explorer.update	{}	api::subscription.subscription	{"fields": ["strapiUserId", "plan", "status", "expireDate", "originalTransactionId", "latestTransactionId", "startDate", "apple_notifications", "revocationDate", "revocationReason"]}	[]	2025-07-31 21:17:29.152	2025-07-31 21:17:29.152	\N	\N
158	plugin::content-manager.explorer.delete	{}	api::apple-notification.apple-notification	{}	[]	2025-07-31 21:17:29.345	2025-07-31 21:17:29.345	\N	\N
159	plugin::content-manager.explorer.delete	{}	api::apple-receipt.apple-receipt	{}	[]	2025-07-31 21:17:29.537	2025-07-31 21:17:29.537	\N	\N
160	plugin::content-manager.explorer.delete	{}	api::audit-log.audit-log	{}	[]	2025-07-31 21:17:29.732	2025-07-31 21:17:29.732	\N	\N
161	plugin::content-manager.explorer.delete	{}	api::ping.ping	{}	[]	2025-07-31 21:17:29.925	2025-07-31 21:17:29.925	\N	\N
162	plugin::documentation.read	{}	\N	{}	[]	2025-07-31 21:17:30.122	2025-07-31 21:17:30.122	\N	\N
163	plugin::documentation.settings.update	{}	\N	{}	[]	2025-07-31 21:17:30.308	2025-07-31 21:17:30.308	\N	\N
164	plugin::documentation.settings.regenerate	{}	\N	{}	[]	2025-07-31 21:17:30.496	2025-07-31 21:17:30.496	\N	\N
165	plugin::documentation.settings.read	{}	\N	{}	[]	2025-07-31 21:17:30.8	2025-07-31 21:17:30.8	\N	\N
167	plugin::content-manager.explorer.create	{}	api::usage-record.usage-record	{"fields": ["strapiUserId", "entitlement", "periodStart", "periodEnd", "usedAmount"]}	[]	2026-05-09 19:29:30.912	2026-05-09 19:29:30.912	\N	\N
168	plugin::content-manager.explorer.create	{}	api::usage-rule.usage-rule	{"fields": ["eventName", "entitlement", "amount", "enabled", "filterJson"]}	[]	2026-05-09 19:29:31.084	2026-05-09 19:29:31.084	\N	\N
170	plugin::content-manager.explorer.read	{}	api::usage-record.usage-record	{"fields": ["strapiUserId", "entitlement", "periodStart", "periodEnd", "usedAmount"]}	[]	2026-05-09 19:29:31.422	2026-05-09 19:29:31.422	\N	\N
171	plugin::content-manager.explorer.read	{}	api::usage-rule.usage-rule	{"fields": ["eventName", "entitlement", "amount", "enabled", "filterJson"]}	[]	2026-05-09 19:29:31.598	2026-05-09 19:29:31.598	\N	\N
173	plugin::content-manager.explorer.update	{}	api::usage-record.usage-record	{"fields": ["strapiUserId", "entitlement", "periodStart", "periodEnd", "usedAmount"]}	[]	2026-05-09 19:29:31.943	2026-05-09 19:29:31.943	\N	\N
174	plugin::content-manager.explorer.update	{}	api::usage-rule.usage-rule	{"fields": ["eventName", "entitlement", "amount", "enabled", "filterJson"]}	[]	2026-05-09 19:29:32.109	2026-05-09 19:29:32.109	\N	\N
175	plugin::content-manager.explorer.delete	{}	api::usage-event.usage-event	{}	[]	2026-05-09 19:29:32.284	2026-05-09 19:29:32.284	\N	\N
176	plugin::content-manager.explorer.delete	{}	api::usage-record.usage-record	{}	[]	2026-05-09 19:29:32.457	2026-05-09 19:29:32.457	\N	\N
177	plugin::content-manager.explorer.delete	{}	api::usage-rule.usage-rule	{}	[]	2026-05-09 19:29:32.631	2026-05-09 19:29:32.631	\N	\N
178	plugin::content-manager.explorer.create	{}	api::feature.feature	{"fields": ["feature", "plans", "order", "feature_i18ns"], "locales": ["en"]}	[]	2026-05-09 23:38:41.157	2026-05-09 23:38:41.157	\N	\N
179	plugin::content-manager.explorer.create	{}	api::feature-i18n.feature-i18n	{"fields": ["feature", "feature_name"], "locales": ["en"]}	[]	2026-05-09 23:38:41.342	2026-05-09 23:38:41.342	\N	\N
180	plugin::content-manager.explorer.read	{}	api::feature.feature	{"fields": ["feature", "plans", "order", "feature_i18ns"], "locales": ["en"]}	[]	2026-05-09 23:38:41.522	2026-05-09 23:38:41.522	\N	\N
181	plugin::content-manager.explorer.read	{}	api::feature-i18n.feature-i18n	{"fields": ["feature", "feature_name"], "locales": ["en"]}	[]	2026-05-09 23:38:41.701	2026-05-09 23:38:41.701	\N	\N
182	plugin::content-manager.explorer.update	{}	api::feature.feature	{"fields": ["feature", "plans", "order", "feature_i18ns"], "locales": ["en"]}	[]	2026-05-09 23:38:41.882	2026-05-09 23:38:41.882	\N	\N
183	plugin::content-manager.explorer.update	{}	api::feature-i18n.feature-i18n	{"fields": ["feature", "feature_name"], "locales": ["en"]}	[]	2026-05-09 23:38:42.062	2026-05-09 23:38:42.062	\N	\N
184	plugin::content-manager.explorer.delete	{}	api::feature-i18n.feature-i18n	{"locales": ["en"]}	[]	2026-05-09 23:38:42.232	2026-05-09 23:38:42.232	\N	\N
185	plugin::content-manager.explorer.create	{}	api::usage-event.usage-event	{"fields": ["eventId", "event_name", "strapiUserId", "username", "payload", "status", "handle_result", "handled_at"]}	[]	2026-05-10 00:24:48.983	2026-05-10 00:24:48.983	\N	\N
186	plugin::content-manager.explorer.read	{}	api::usage-event.usage-event	{"fields": ["eventId", "event_name", "strapiUserId", "username", "payload", "status", "handle_result", "handled_at"]}	[]	2026-05-10 00:24:49.222	2026-05-10 00:24:49.222	\N	\N
187	plugin::content-manager.explorer.update	{}	api::usage-event.usage-event	{"fields": ["eventId", "event_name", "strapiUserId", "username", "payload", "status", "handle_result", "handled_at"]}	[]	2026-05-10 00:24:49.459	2026-05-10 00:24:49.459	\N	\N
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
101	101	1	84
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
140	140	1	116
141	141	1	117
142	142	1	118
143	143	1	119
144	144	1	120
145	145	1	121
146	146	1	122
147	147	1	123
148	148	1	124
149	149	1	125
150	150	1	126
151	151	1	127
152	152	1	128
153	153	1	129
154	154	1	130
155	155	1	131
156	156	1	132
157	157	1	133
158	158	1	134
159	159	1	135
160	160	1	136
161	161	1	137
162	162	1	138
163	163	1	139
164	164	1	140
165	165	1	141
167	167	1	143
168	168	1	144
170	170	1	146
171	171	1	147
173	173	1	149
174	174	1	150
175	175	1	151
176	176	1	152
177	177	1	153
178	178	1	154
179	179	1	155
180	180	1	156
181	181	1	157
182	182	1	158
183	183	1	159
184	184	1	160
185	185	1	161
186	186	1	162
187	187	1	163
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
1	admin	\N	\N	support@geniusparentingai.ca	$2a$10$nmZs7gZjhHbH06hm7yqV7.fVynw.7PEX/tMxbC6SDSoxsJiAIgaV.	\N	\N	t	f	\N	2025-07-04 13:56:31.331	2026-05-09 10:47:28.56198	\N	\N
\.


--
-- Data for Name: admin_users_roles_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
1	1	1	1	1
\.


--
-- Data for Name: apple_notifications; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.apple_notifications (id, notification_uuid, notification_type, subtype, original_transaction_id, processing_status, raw_signed_payload, transaction_info, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: apple_notifications_subscription_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.apple_notifications_subscription_links (id, apple_notification_id, subscription_id, apple_notification_order) FROM stdin;
\.


--
-- Data for Name: apple_receipts; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.apple_receipts (id, transaction_id, user_id, raw_receipt, status, last_attempt_at, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.audit_logs (id, event, status, message, details, strapi_user_id, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: audit_logs_apple_notification_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.audit_logs_apple_notification_links (id, audit_log_id, apple_notification_id) FROM stdin;
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
1	vocabook.flashcard.review	vocabook-flashcard-review	2025-07-04 15:32:12.339	2026-05-09 22:30:47.551	1	1	t	30	\N
2	vocabook.flashcard.create	vocabook-flashcard-create	2025-07-04 15:32:34.753	2026-05-09 22:30:59.964	1	1	t	20	\N
3	vocabook.article.create	vocabook-article-create	2025-07-04 15:32:55.582	2026-05-09 22:31:05.981	1	1	t	1	\N
5	not used	not-used-1	2025-07-04 15:33:31.991	2026-05-09 22:31:37.82	1	1	f	\N	\N
6	not used	not-used-2	2026-05-09 20:09:42.646	2026-05-09 22:31:48.514	1	1	f	30	day
4	vocabook.word.ai.translation	vocabook-word-ai-translation	2025-07-04 15:33:17.674	2026-05-09 22:44:11.86	1	1	t	10	day
\.


--
-- Data for Name: feature_i18ns; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.feature_i18ns (id, feature_name, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
1	Create Flashcard in Vocabook	2026-05-09 23:39:35.26	2026-05-09 23:39:35.26	1	1	en
2	Review flashcards to learn the words	2026-05-09 23:40:13.798	2026-05-09 23:40:13.798	1	1	en
3	Save Articles to the vocabook, add new words from article by tapping	2026-05-09 23:41:37.747	2026-05-09 23:41:37.747	1	1	en
4	Use AI to translate word meanings in the context	2026-05-09 23:42:21.46	2026-05-09 23:42:21.46	1	1	en
\.


--
-- Data for Name: feature_i_18_ns_feature_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.feature_i_18_ns_feature_links (id, feature_i_18_n_id, feature_id, feature_i_18_n_order) FROM stdin;
1	1	2	1
2	2	1	1
3	3	3	1
4	4	10	1
\.


--
-- Data for Name: feature_i_18_ns_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.feature_i_18_ns_localizations_links (id, feature_i_18_n_id, inv_feature_i_18_n_id, feature_i_18_n_order) FROM stdin;
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.features (id, feature, created_at, updated_at, created_by_id, updated_by_id, locale, "order") FROM stdin;
1	Flashcard Review	2025-07-05 17:35:56.786	2026-05-09 22:20:37.704	1	1	en	1
2	Flashcard Create	2025-07-05 17:36:32.837	2026-05-09 22:21:04.954	1	1	en	2
3	Article Create	2025-07-05 17:37:27.583	2026-05-09 22:21:53.372	1	1	en	3
10	AI Translation	2026-05-09 22:44:51.145	2026-05-09 22:44:51.145	1	1	en	4
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
3	1	1	1	1
5	3	1	1	2
10	2	1	1	3
17	10	1	1	4
14	1	2	3	3
15	2	2	3	2
16	3	2	3	1
18	10	2	2	4
11	3	3	2	3
12	1	3	2	2
13	2	3	2	1
19	10	3	3	4
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
2	20	2025-07-05 21:48:48.885	2026-05-09 22:37:42.203	1	1
1	1	2025-07-05 21:48:19.003	2026-05-09 22:37:48.766	1	1
3	20	2025-07-05 21:49:12.25	2026-05-09 22:38:07.483	1	1
10	10	2026-05-09 22:46:10.644	2026-05-09 22:46:10.644	1	1
4	50	2025-07-05 22:08:37.782	2026-05-09 22:46:59.37	1	1
5	1000	2025-07-05 22:08:59.872	2026-05-09 22:47:05.881	1	1
6	2000	2025-07-05 22:09:34.888	2026-05-09 22:47:13.805	1	1
11	300	2026-05-09 22:46:26.639	2026-05-09 22:48:22.378	1	1
7	100	2025-07-05 22:09:45.764	2026-05-09 22:48:43.029	1	1
12	300	2026-05-09 22:49:25.646	2026-05-09 22:49:40.342	1	1
8	1000	2026-05-09 22:39:58.076	2026-05-09 22:49:48.407	1	1
9	2000	2026-05-09 22:40:11.349	2026-05-09 22:49:56.614	1	1
\.


--
-- Data for Name: plan_ent_links_entitlement_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plan_ent_links_entitlement_links (id, plan_ent_link_id, entitlement_id, plan_ent_link_order) FROM stdin;
8	1	3	1
9	2	2	1
10	3	1	1
11	4	3	2
12	5	2	2
13	6	1	2
14	7	3	3
15	8	2	3
16	9	1	3
17	10	4	1
18	11	4	2
19	12	4	3
\.


--
-- Data for Name: plan_ent_links_plan_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plan_ent_links_plan_links (id, plan_ent_link_id, plan_id, plan_ent_link_order) FROM stdin;
9	1	1	1
10	2	1	2
11	3	1	3
12	4	2	1
13	5	2	2
14	6	2	3
15	7	3	1
16	8	3	2
17	9	3	3
18	10	1	4
19	11	2	4
20	12	3	4
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.plans (id, name, product_id, created_at, updated_at, created_by_id, updated_by_id, locale, sale_product_id, sale_start_date, sale_end_date, "order", role) FROM stdin;
1	LangGo Vocabook Free Plan	langgo-vocabook-free-plan	2025-07-04 16:08:44.044	2026-05-09 22:45:09.822	1	1	en	\N	\N	\N	1	\N
2	LangGo Vocabook Monthly	com.langgo.vocabook.monthly	2025-07-04 16:16:32.586	2026-05-09 22:45:17.87	1	1	en	\N	\N	\N	2	\N
3	LangGo Vocabook Yearly	com.langgo.vocabook.yearly	2025-07-04 16:18:29.184	2026-05-09 22:45:25.127	1	1	en	\N	\N	\N	3	\N
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
1	server-to-server		full-access	98fc4e40f382acec5631e94c5fc06adc183e7117e61e98ae1112b4765d84a03d17a12b3a03d71a75cbc47b22bb5593a64ee44dc8f51875c617e07cbacbbd03b4	\N	\N	\N	2025-07-04 16:55:52.718	2025-08-02 00:09:52.004	\N	\N
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
17	plugin_upload_metrics	{"weeklySchedule":"6 52 9 * * 3","lastWeeklyUpdate":1778086327548}	object	\N	\N
10	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"uid":"admin::api-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
14	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"uid":"plugin::users-permissions.user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}]]}}	object	\N	\N
13	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"uid":"plugin::i18n.locale","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]}}	object	\N	\N
29	plugin_content_manager_configuration_content_types::api::usageledger.usageledger	{"uid":"api::usageledger.usageledger","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"entitlement":{"edit":{"label":"entitlement","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"entitlement","searchable":true,"sortable":true}},"consumedAt":{"edit":{"label":"consumedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"consumedAt","searchable":true,"sortable":true}},"amount":{"edit":{"label":"amount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"amount","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","strapiUserId","entitlement","consumedAt"],"edit":[[{"name":"strapiUserId","size":4},{"name":"entitlement","size":6}],[{"name":"consumedAt","size":6},{"name":"amount","size":4}]]}}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"uid":"plugin::users-permissions.role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]}}	object	\N	\N
33	plugin_content_manager_configuration_content_types::api::apple-receipt.apple-receipt	{"uid":"api::apple-receipt.apple-receipt","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"transactionId","defaultSortBy":"transactionId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"transactionId":{"edit":{"label":"transactionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"transactionId","searchable":true,"sortable":true}},"userId":{"edit":{"label":"userId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"userId","searchable":true,"sortable":true}},"rawReceipt":{"edit":{"label":"rawReceipt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rawReceipt","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"lastAttemptAt":{"edit":{"label":"lastAttemptAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastAttemptAt","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","transactionId","userId","rawReceipt"],"edit":[[{"name":"transactionId","size":6},{"name":"userId","size":4}],[{"name":"rawReceipt","size":6},{"name":"status","size":6}],[{"name":"lastAttemptAt","size":6}]]}}	object	\N	\N
30	plugin_content_manager_configuration_content_types::api::plan-ent-link.plan-ent-link	{"uid":"api::plan-ent-link.plan-ent-link","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"plan":{"edit":{"label":"plan","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"plan","searchable":true,"sortable":true}},"entitlement":{"edit":{"label":"entitlement","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"entitlement","searchable":true,"sortable":true}},"limitOverride":{"edit":{"label":"limitOverride","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"limitOverride","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","plan","entitlement","limitOverride"],"edit":[[{"name":"plan","size":6},{"name":"entitlement","size":6}],[{"name":"limitOverride","size":4}]]}}	object	\N	\N
18	plugin_users-permissions_grant	{"email":{"enabled":true,"icon":"envelope"},"discord":{"enabled":false,"icon":"discord","key":"","secret":"","callback":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"enabled":false,"icon":"facebook-square","key":"","secret":"","callback":"api/auth/facebook/callback","scope":["email"]},"google":{"enabled":false,"icon":"google","key":"","secret":"","callback":"api/auth/google/callback","scope":["email"]},"github":{"enabled":false,"icon":"github","key":"","secret":"","callback":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"enabled":false,"icon":"windows","key":"","secret":"","callback":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"enabled":false,"icon":"twitter","key":"","secret":"","callback":"api/auth/twitter/callback"},"instagram":{"enabled":false,"icon":"instagram","key":"","secret":"","callback":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"enabled":false,"icon":"vk","key":"","secret":"","callback":"api/auth/vk/callback","scope":["email"]},"twitch":{"enabled":false,"icon":"twitch","key":"","secret":"","callback":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"enabled":false,"icon":"linkedin","key":"","secret":"","callback":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"enabled":false,"icon":"aws","key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"enabled":false,"icon":"reddit","key":"","secret":"","state":true,"callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"enabled":false,"icon":"","key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"enabled":false,"icon":"book","key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"enabled":false,"icon":"","key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]}}	object	\N	\N
19	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
20	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
23	plugin_content_manager_configuration_components::a.features	{"uid":"a.features","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}}},"layouts":{"list":["id"],"edit":[]},"isComponent":true}	object	\N	\N
25	plugin_content_manager_configuration_content_types::api::entitlement.entitlement	{"uid":"api::entitlement.entitlement","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"usageledgers":{"edit":{"label":"usageledgers","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"usageledgers","searchable":false,"sortable":false}},"ismetered":{"edit":{"label":"ismetered","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ismetered","searchable":true,"sortable":true}},"defaultlimit":{"edit":{"label":"defaultlimit","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"defaultlimit","searchable":true,"sortable":true}},"resetPeriod":{"edit":{"label":"resetPeriod","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"resetPeriod","searchable":true,"sortable":true}},"plan_ent_links":{"edit":{"label":"plan_ent_links","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"plan_ent_links","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","slug","createdAt"],"edit":[[{"name":"name","size":6},{"name":"slug","size":6}],[{"name":"usageledgers","size":6}],[{"name":"ismetered","size":4},{"name":"defaultlimit","size":4}],[{"name":"resetPeriod","size":6},{"name":"plan_ent_links","size":6}]]}}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"uid":"plugin::upload.folder","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]}}	object	\N	\N
21	plugin_i18n_default_locale	"en"	string	\N	\N
31	plugin_content_manager_configuration_content_types::api::audit-log.audit-log	{"uid":"api::audit-log.audit-log","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"event","defaultSortBy":"event","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"event":{"edit":{"label":"event","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"event","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"message":{"edit":{"label":"message","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"message","searchable":true,"sortable":true}},"details":{"edit":{"label":"details","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"details","searchable":false,"sortable":false}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"apple_notification":{"edit":{"label":"apple_notification","description":"","placeholder":"","visible":true,"editable":true,"mainField":"notificationUUID"},"list":{"label":"apple_notification","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","event","status","message"],"edit":[[{"name":"event","size":6},{"name":"status","size":6}],[{"name":"message","size":6}],[{"name":"details","size":12}],[{"name":"strapiUserId","size":4},{"name":"apple_notification","size":6}]]}}	object	\N	\N
1	strapi_content_types_schema	{"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"admin::permission","plugin":"admin","globalId":"AdminPermission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"admin::user","plugin":"admin","globalId":"AdminUser"},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"admin::role","plugin":"admin","globalId":"AdminRole"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token","connection":"default","uid":"admin::api-token","plugin":"admin","globalId":"AdminApiToken"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token-permission","connection":"default","uid":"admin::api-token-permission","plugin":"admin","globalId":"AdminApiTokenPermission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token","connection":"default","uid":"admin::transfer-token","plugin":"admin","globalId":"AdminTransferToken"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token-permission","connection":"default","uid":"admin::transfer-token-permission","plugin":"admin","globalId":"AdminTransferTokenPermission"},"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"file","connection":"default","uid":"plugin::upload.file","plugin":"upload","globalId":"UploadFile"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"folder","connection":"default","uid":"plugin::upload.folder","plugin":"upload","globalId":"UploadFolder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"locale","connection":"default","uid":"plugin::i18n.locale","plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"plugin::users-permissions.permission","plugin":"users-permissions","globalId":"UsersPermissionsPermission"},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"plugin::users-permissions.role","plugin":"users-permissions","globalId":"UsersPermissionsRole"},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"plugin::users-permissions.user","plugin":"users-permissions","globalId":"UsersPermissionsUser"},"api::apple-notification.apple-notification":{"kind":"collectionType","collectionName":"apple_notifications","info":{"singularName":"apple-notification","pluralName":"apple-notifications","displayName":"apple notification","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"notificationUUID":{"type":"string","required":false,"unique":false},"notificationType":{"type":"string"},"subtype":{"type":"string"},"originalTransactionId":{"type":"string"},"processingStatus":{"type":"enumeration","enum":["received","processed","failed_verification","failed_not_found","duplicate"],"default":"received","required":true},"rawSignedPayload":{"type":"text"},"transactionInfo":{"type":"json"},"subscription":{"type":"relation","relation":"manyToOne","target":"api::subscription.subscription","inversedBy":"apple_notifications"},"audit_log":{"type":"relation","relation":"oneToOne","target":"api::audit-log.audit-log","mappedBy":"apple_notification"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"apple_notifications","info":{"singularName":"apple-notification","pluralName":"apple-notifications","displayName":"apple notification","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"notificationUUID":{"type":"string","required":false,"unique":false},"notificationType":{"type":"string"},"subtype":{"type":"string"},"originalTransactionId":{"type":"string"},"processingStatus":{"type":"enumeration","enum":["received","processed","failed_verification","failed_not_found","duplicate"],"default":"received","required":true},"rawSignedPayload":{"type":"text"},"transactionInfo":{"type":"json"},"subscription":{"type":"relation","relation":"manyToOne","target":"api::subscription.subscription","inversedBy":"apple_notifications"},"audit_log":{"type":"relation","relation":"oneToOne","target":"api::audit-log.audit-log","mappedBy":"apple_notification"}},"kind":"collectionType"},"modelType":"contentType","modelName":"apple-notification","connection":"default","uid":"api::apple-notification.apple-notification","apiName":"apple-notification","globalId":"AppleNotification","actions":{},"lifecycles":{}},"api::apple-receipt.apple-receipt":{"kind":"collectionType","collectionName":"apple_receipts","info":{"singularName":"apple-receipt","pluralName":"apple-receipts","displayName":"apple receipt"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"transactionId":{"type":"string","required":true,"unique":true},"userId":{"type":"integer","required":true},"rawReceipt":{"type":"text","required":true},"status":{"type":"enumeration","enum":["pending_verification","verified","failed_verification"],"default":"pending_verification","required":true},"lastAttemptAt":{"type":"datetime"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"apple_receipts","info":{"singularName":"apple-receipt","pluralName":"apple-receipts","displayName":"apple receipt"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"transactionId":{"type":"string","required":true,"unique":true},"userId":{"type":"integer","required":true},"rawReceipt":{"type":"text","required":true},"status":{"type":"enumeration","enum":["pending_verification","verified","failed_verification"],"default":"pending_verification","required":true},"lastAttemptAt":{"type":"datetime"}},"kind":"collectionType"},"modelType":"contentType","modelName":"apple-receipt","connection":"default","uid":"api::apple-receipt.apple-receipt","apiName":"apple-receipt","globalId":"AppleReceipt","actions":{},"lifecycles":{}},"api::audit-log.audit-log":{"kind":"collectionType","collectionName":"audit_logs","info":{"singularName":"audit-log","pluralName":"audit-logs","displayName":"audit log","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"event":{"type":"string"},"status":{"type":"enumeration","enum":["SUCCESS","FAILURE","WARNING","INFO"],"required":true},"message":{"type":"string"},"details":{"type":"json"},"strapiUserId":{"type":"integer"},"apple_notification":{"type":"relation","relation":"oneToOne","target":"api::apple-notification.apple-notification","inversedBy":"audit_log"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"audit_logs","info":{"singularName":"audit-log","pluralName":"audit-logs","displayName":"audit log","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"event":{"type":"string"},"status":{"type":"enumeration","enum":["SUCCESS","FAILURE","WARNING","INFO"],"required":true},"message":{"type":"string"},"details":{"type":"json"},"strapiUserId":{"type":"integer"},"apple_notification":{"type":"relation","relation":"oneToOne","target":"api::apple-notification.apple-notification","inversedBy":"audit_log"}},"kind":"collectionType"},"modelType":"contentType","modelName":"audit-log","connection":"default","uid":"api::audit-log.audit-log","apiName":"audit-log","globalId":"AuditLog","actions":{},"lifecycles":{}},"api::entitlement.entitlement":{"kind":"collectionType","collectionName":"entitlements","info":{"singularName":"entitlement","pluralName":"entitlements","displayName":"entitlement","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"uid","targetField":"name"},"usageledgers":{"type":"relation","relation":"oneToMany","target":"api::usageledger.usageledger","mappedBy":"entitlement"},"ismetered":{"type":"boolean","default":false,"required":true},"defaultlimit":{"type":"integer"},"resetPeriod":{"type":"enumeration","enum":["minute","hour","day","week","two weeks","month","year","lifetime"]},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"entitlement"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"entitlements","info":{"singularName":"entitlement","pluralName":"entitlements","displayName":"entitlement","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"uid","targetField":"name"},"usageledgers":{"type":"relation","relation":"oneToMany","target":"api::usageledger.usageledger","mappedBy":"entitlement"},"ismetered":{"type":"boolean","default":false,"required":true},"defaultlimit":{"type":"integer"},"resetPeriod":{"type":"enumeration","enum":["minute","hour","day","week","two weeks","month","year","lifetime"]},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"entitlement"}},"kind":"collectionType"},"modelType":"contentType","modelName":"entitlement","connection":"default","uid":"api::entitlement.entitlement","apiName":"entitlement","globalId":"Entitlement","actions":{},"lifecycles":{}},"api::feature.feature":{"kind":"collectionType","collectionName":"features","info":{"singularName":"feature","pluralName":"features","displayName":"feature","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"feature":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"plans":{"type":"relation","relation":"manyToMany","target":"api::plan.plan","inversedBy":"features"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"feature_i18ns":{"type":"relation","relation":"oneToMany","target":"api::feature-i18n.feature-i18n","mappedBy":"feature"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::feature.feature"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"features","info":{"singularName":"feature","pluralName":"features","displayName":"feature","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"feature":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"plans":{"type":"relation","relation":"manyToMany","target":"api::plan.plan","inversedBy":"features"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"feature_i18ns":{"type":"relation","relation":"oneToMany","target":"api::feature-i18n.feature-i18n","mappedBy":"feature"}},"kind":"collectionType"},"modelType":"contentType","modelName":"feature","connection":"default","uid":"api::feature.feature","apiName":"feature","globalId":"Feature","actions":{},"lifecycles":{}},"api::feature-i18n.feature-i18n":{"kind":"collectionType","collectionName":"feature_i18ns","info":{"singularName":"feature-i18n","pluralName":"feature-i18ns","displayName":"Feature i18n"},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"feature":{"type":"relation","relation":"manyToOne","target":"api::feature.feature","inversedBy":"feature_i18ns"},"feature_name":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::feature-i18n.feature-i18n"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"feature_i18ns","info":{"singularName":"feature-i18n","pluralName":"feature-i18ns","displayName":"Feature i18n"},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"feature":{"type":"relation","relation":"manyToOne","target":"api::feature.feature","inversedBy":"feature_i18ns"},"feature_name":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"}},"kind":"collectionType"},"modelType":"contentType","modelName":"feature-i18n","connection":"default","uid":"api::feature-i18n.feature-i18n","apiName":"feature-i18n","globalId":"FeatureI18N","actions":{},"lifecycles":{}},"api::ping.ping":{"kind":"collectionType","collectionName":"pings","info":{"singularName":"ping","pluralName":"pings","displayName":"ping"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"status":{"type":"string","default":"OK","required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"pings","info":{"singularName":"ping","pluralName":"pings","displayName":"ping"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"status":{"type":"string","default":"OK","required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"ping","connection":"default","uid":"api::ping.ping","apiName":"ping","globalId":"Ping","actions":{},"lifecycles":{}},"api::plan.plan":{"kind":"collectionType","collectionName":"plans","info":{"singularName":"plan","pluralName":"plans","displayName":"plan","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"productId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":true},"inherit_from":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"childPlans"},"childPlans":{"type":"relation","relation":"oneToMany","target":"api::plan.plan","mappedBy":"inherit_from"},"saleProductId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":false},"saleStartDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"saleEndDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"subscriptions":{"type":"relation","relation":"oneToMany","target":"api::subscription.subscription","mappedBy":"plan"},"features":{"type":"relation","relation":"manyToMany","target":"api::feature.feature","mappedBy":"plans"},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"plan"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"role":{"pluginOptions":{"i18n":{"localized":false}},"type":"enumeration","enum":["free","basic","premium","pro"]},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::plan.plan"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"plans","info":{"singularName":"plan","pluralName":"plans","displayName":"plan","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"pluginOptions":{"i18n":{"localized":true}},"type":"string","required":true},"productId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":true},"inherit_from":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"childPlans"},"childPlans":{"type":"relation","relation":"oneToMany","target":"api::plan.plan","mappedBy":"inherit_from"},"saleProductId":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":false},"saleStartDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"saleEndDate":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"subscriptions":{"type":"relation","relation":"oneToMany","target":"api::subscription.subscription","mappedBy":"plan"},"features":{"type":"relation","relation":"manyToMany","target":"api::feature.feature","mappedBy":"plans"},"plan_ent_links":{"type":"relation","relation":"oneToMany","target":"api::plan-ent-link.plan-ent-link","mappedBy":"plan"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"role":{"pluginOptions":{"i18n":{"localized":false}},"type":"enumeration","enum":["free","basic","premium","pro"]}},"kind":"collectionType"},"modelType":"contentType","modelName":"plan","connection":"default","uid":"api::plan.plan","apiName":"plan","globalId":"Plan","actions":{},"lifecycles":{}},"api::plan-ent-link.plan-ent-link":{"kind":"collectionType","collectionName":"plan_ent_links","info":{"singularName":"plan-ent-link","pluralName":"plan-ent-links","displayName":"Plan Entitle Link","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"plan_ent_links"},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"plan_ent_links"},"limitOverride":{"type":"integer"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"plan_ent_links","info":{"singularName":"plan-ent-link","pluralName":"plan-ent-links","displayName":"Plan Entitle Link","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"plan_ent_links"},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"plan_ent_links"},"limitOverride":{"type":"integer"}},"kind":"collectionType"},"modelType":"contentType","modelName":"plan-ent-link","connection":"default","uid":"api::plan-ent-link.plan-ent-link","apiName":"plan-ent-link","globalId":"PlanEntLink","actions":{},"lifecycles":{}},"api::subscription.subscription":{"kind":"collectionType","collectionName":"subscriptions","info":{"singularName":"subscription","pluralName":"subscriptions","displayName":"subscription","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"subscriptions"},"status":{"type":"enumeration","enum":["active","grace-period","billing-issue","cancelled","expired","revoked"],"required":true,"default":"active"},"expireDate":{"type":"datetime"},"originalTransactionId":{"type":"string"},"latestTransactionId":{"type":"string"},"startDate":{"type":"datetime"},"apple_notifications":{"type":"relation","relation":"oneToMany","target":"api::apple-notification.apple-notification","mappedBy":"subscription"},"revocationDate":{"type":"datetime"},"revocationReason":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"subscriptions","info":{"singularName":"subscription","pluralName":"subscriptions","displayName":"subscription","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"plan":{"type":"relation","relation":"manyToOne","target":"api::plan.plan","inversedBy":"subscriptions"},"status":{"type":"enumeration","enum":["active","grace-period","billing-issue","cancelled","expired","revoked"],"required":true,"default":"active"},"expireDate":{"type":"datetime"},"originalTransactionId":{"type":"string"},"latestTransactionId":{"type":"string"},"startDate":{"type":"datetime"},"apple_notifications":{"type":"relation","relation":"oneToMany","target":"api::apple-notification.apple-notification","mappedBy":"subscription"},"revocationDate":{"type":"datetime"},"revocationReason":{"type":"string"}},"kind":"collectionType"},"modelType":"contentType","modelName":"subscription","connection":"default","uid":"api::subscription.subscription","apiName":"subscription","globalId":"Subscription","actions":{},"lifecycles":{}},"api::usage-event.usage-event":{"kind":"collectionType","collectionName":"usage_events","info":{"singularName":"usage-event","pluralName":"usage-events","displayName":"Usage Event","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"eventId":{"type":"string","required":true,"unique":true},"event_name":{"type":"string","required":true},"strapiUserId":{"type":"integer","required":true},"username":{"type":"string"},"payload":{"type":"json"},"status":{"type":"enumeration","enum":["received","processed","skipped","failed"],"default":"received","required":true},"handle_result":{"type":"text"},"handled_at":{"type":"datetime"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"usage_events","info":{"singularName":"usage-event","pluralName":"usage-events","displayName":"Usage Event","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"eventId":{"type":"string","required":true,"unique":true},"event_name":{"type":"string","required":true},"strapiUserId":{"type":"integer","required":true},"username":{"type":"string"},"payload":{"type":"json"},"status":{"type":"enumeration","enum":["received","processed","skipped","failed"],"default":"received","required":true},"handle_result":{"type":"text"},"handled_at":{"type":"datetime"}},"kind":"collectionType"},"modelType":"contentType","modelName":"usage-event","connection":"default","uid":"api::usage-event.usage-event","apiName":"usage-event","globalId":"UsageEvent","actions":{},"lifecycles":{}},"api::usage-record.usage-record":{"kind":"collectionType","collectionName":"usage_records","info":{"singularName":"usage-record","pluralName":"usage-records","displayName":"Usage Record","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement"},"periodStart":{"type":"datetime","required":true},"periodEnd":{"type":"datetime","required":true},"usedAmount":{"type":"integer","default":0,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"usage_records","info":{"singularName":"usage-record","pluralName":"usage-records","displayName":"Usage Record","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement"},"periodStart":{"type":"datetime","required":true},"periodEnd":{"type":"datetime","required":true},"usedAmount":{"type":"integer","default":0,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"usage-record","connection":"default","uid":"api::usage-record.usage-record","apiName":"usage-record","globalId":"UsageRecord","actions":{},"lifecycles":{}},"api::usage-rule.usage-rule":{"kind":"collectionType","collectionName":"usage_rules","info":{"singularName":"usage-rule","pluralName":"usage-rules","displayName":"Usage Rule","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"eventName":{"type":"string","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement"},"amount":{"type":"integer","default":1,"required":true},"enabled":{"type":"boolean","default":true,"required":true},"filterJson":{"type":"json"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"usage_rules","info":{"singularName":"usage-rule","pluralName":"usage-rules","displayName":"Usage Rule","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"eventName":{"type":"string","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement"},"amount":{"type":"integer","default":1,"required":true},"enabled":{"type":"boolean","default":true,"required":true},"filterJson":{"type":"json"}},"kind":"collectionType"},"modelType":"contentType","modelName":"usage-rule","connection":"default","uid":"api::usage-rule.usage-rule","apiName":"usage-rule","globalId":"UsageRule","actions":{},"lifecycles":{}},"api::usageledger.usageledger":{"kind":"collectionType","collectionName":"usageledgers","info":{"singularName":"usageledger","pluralName":"usageledgers","displayName":"usage ledger","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"usageledgers"},"consumedAt":{"type":"datetime"},"amount":{"type":"integer","default":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"usageledgers","info":{"singularName":"usageledger","pluralName":"usageledgers","displayName":"usage ledger","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"strapiUserId":{"type":"integer","required":true},"entitlement":{"type":"relation","relation":"manyToOne","target":"api::entitlement.entitlement","inversedBy":"usageledgers"},"consumedAt":{"type":"datetime"},"amount":{"type":"integer","default":1,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"usageledger","connection":"default","uid":"api::usageledger.usageledger","apiName":"usageledger","globalId":"Usageledger","actions":{},"lifecycles":{}}}	object	\N	\N
22	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
27	plugin_content_manager_configuration_content_types::api::subscription.subscription	{"uid":"api::subscription.subscription","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"originalTransactionId","defaultSortBy":"originalTransactionId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"plan":{"edit":{"label":"plan","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"plan","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"expireDate":{"edit":{"label":"expireDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expireDate","searchable":true,"sortable":true}},"originalTransactionId":{"edit":{"label":"originalTransactionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"originalTransactionId","searchable":true,"sortable":true}},"latestTransactionId":{"edit":{"label":"latestTransactionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"latestTransactionId","searchable":true,"sortable":true}},"startDate":{"edit":{"label":"startDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startDate","searchable":true,"sortable":true}},"apple_notifications":{"edit":{"label":"apple_notifications","description":"","placeholder":"","visible":true,"editable":true,"mainField":"notificationUUID"},"list":{"label":"apple_notifications","searchable":false,"sortable":false}},"revocationDate":{"edit":{"label":"revocationDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"revocationDate","searchable":true,"sortable":true}},"revocationReason":{"edit":{"label":"revocationReason","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"revocationReason","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","strapiUserId","plan","status"],"edit":[[{"name":"strapiUserId","size":4},{"name":"plan","size":6}],[{"name":"status","size":6},{"name":"expireDate","size":6}],[{"name":"originalTransactionId","size":6},{"name":"latestTransactionId","size":6}],[{"name":"startDate","size":6},{"name":"apple_notifications","size":6}],[{"name":"revocationDate","size":6},{"name":"revocationReason","size":6}]]}}	object	\N	\N
35	plugin_documentation_config	{"restrictedAccess":false}	object	\N	\N
32	plugin_content_manager_configuration_content_types::api::ping.ping	{"uid":"api::ping.ping","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"status","defaultSortBy":"status","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","status","createdAt","updatedAt"],"edit":[[{"name":"status","size":6}]]}}	object	\N	\N
34	plugin_content_manager_configuration_content_types::api::apple-notification.apple-notification	{"uid":"api::apple-notification.apple-notification","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"notificationUUID","defaultSortBy":"notificationUUID","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"notificationUUID":{"edit":{"label":"notificationUUID","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"notificationUUID","searchable":true,"sortable":true}},"notificationType":{"edit":{"label":"notificationType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"notificationType","searchable":true,"sortable":true}},"subtype":{"edit":{"label":"subtype","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subtype","searchable":true,"sortable":true}},"originalTransactionId":{"edit":{"label":"originalTransactionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"originalTransactionId","searchable":true,"sortable":true}},"processingStatus":{"edit":{"label":"processingStatus","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"processingStatus","searchable":true,"sortable":true}},"rawSignedPayload":{"edit":{"label":"rawSignedPayload","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rawSignedPayload","searchable":true,"sortable":true}},"transactionInfo":{"edit":{"label":"transactionInfo","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"transactionInfo","searchable":false,"sortable":false}},"subscription":{"edit":{"label":"subscription","description":"","placeholder":"","visible":true,"editable":true,"mainField":"originalTransactionId"},"list":{"label":"subscription","searchable":true,"sortable":true}},"audit_log":{"edit":{"label":"audit_log","description":"","placeholder":"","visible":true,"editable":true,"mainField":"event"},"list":{"label":"audit_log","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","notificationUUID","notificationType","subtype"],"edit":[[{"name":"notificationUUID","size":6},{"name":"notificationType","size":6}],[{"name":"subtype","size":6},{"name":"originalTransactionId","size":6}],[{"name":"processingStatus","size":6},{"name":"rawSignedPayload","size":6}],[{"name":"transactionInfo","size":12}],[{"name":"subscription","size":6},{"name":"audit_log","size":6}]]}}	object	\N	\N
24	plugin_content_manager_configuration_content_types::api::plan.plan	{"uid":"api::plan.plan","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"productId":{"edit":{"label":"productId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"productId","searchable":true,"sortable":true}},"inherit_from":{"edit":{"label":"inherit_from","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"inherit_from","searchable":true,"sortable":true}},"childPlans":{"edit":{"label":"childPlans","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"childPlans","searchable":false,"sortable":false}},"saleProductId":{"edit":{"label":"saleProductId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"saleProductId","searchable":true,"sortable":true}},"saleStartDate":{"edit":{"label":"saleStartDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"saleStartDate","searchable":true,"sortable":true}},"saleEndDate":{"edit":{"label":"saleEndDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"saleEndDate","searchable":true,"sortable":true}},"subscriptions":{"edit":{"label":"subscriptions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"originalTransactionId"},"list":{"label":"subscriptions","searchable":false,"sortable":false}},"features":{"edit":{"label":"features","description":"","placeholder":"","visible":true,"editable":true,"mainField":"feature"},"list":{"label":"features","searchable":false,"sortable":false}},"plan_ent_links":{"edit":{"label":"plan_ent_links","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"plan_ent_links","searchable":false,"sortable":false}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","productId","features"],"edit":[[{"name":"name","size":6},{"name":"productId","size":6}],[{"name":"features","size":12}],[{"name":"inherit_from","size":6}],[{"name":"childPlans","size":6},{"name":"saleProductId","size":6}],[{"name":"saleStartDate","size":6},{"name":"saleEndDate","size":6}],[{"name":"subscriptions","size":6},{"name":"plan_ent_links","size":6}],[{"name":"order","size":4},{"name":"role","size":6}]]}}	object	\N	\N
36	plugin_content_manager_configuration_content_types::api::usage-record.usage-record	{"uid":"api::usage-record.usage-record","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"entitlement":{"edit":{"label":"entitlement","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"entitlement","searchable":true,"sortable":true}},"periodStart":{"edit":{"label":"periodStart","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"periodStart","searchable":true,"sortable":true}},"periodEnd":{"edit":{"label":"periodEnd","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"periodEnd","searchable":true,"sortable":true}},"usedAmount":{"edit":{"label":"usedAmount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usedAmount","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","strapiUserId","entitlement","periodStart"],"edit":[[{"name":"strapiUserId","size":4},{"name":"entitlement","size":6}],[{"name":"periodStart","size":6},{"name":"periodEnd","size":6}],[{"name":"usedAmount","size":4}]]}}	object	\N	\N
38	plugin_content_manager_configuration_content_types::api::usage-rule.usage-rule	{"uid":"api::usage-rule.usage-rule","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"eventName","defaultSortBy":"eventName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"eventName":{"edit":{"label":"eventName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"eventName","searchable":true,"sortable":true}},"entitlement":{"edit":{"label":"entitlement","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"entitlement","searchable":true,"sortable":true}},"amount":{"edit":{"label":"amount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"amount","searchable":true,"sortable":true}},"enabled":{"edit":{"label":"enabled","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"enabled","searchable":true,"sortable":true}},"filterJson":{"edit":{"label":"filterJson","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"filterJson","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","eventName","entitlement","amount"],"edit":[[{"name":"eventName","size":6},{"name":"entitlement","size":6}],[{"name":"amount","size":4},{"name":"enabled","size":4}],[{"name":"filterJson","size":12}]]}}	object	\N	\N
39	plugin_content_manager_configuration_content_types::api::feature-i18n.feature-i18n	{"uid":"api::feature-i18n.feature-i18n","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"feature_name","defaultSortBy":"feature_name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"feature":{"edit":{"label":"feature","description":"","placeholder":"","visible":true,"editable":true,"mainField":"feature"},"list":{"label":"feature","searchable":true,"sortable":true}},"feature_name":{"edit":{"label":"feature_name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"feature_name","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","feature","feature_name","createdAt"],"edit":[[{"name":"feature","size":6},{"name":"feature_name","size":6}]]}}	object	\N	\N
28	plugin_content_manager_configuration_content_types::api::feature.feature	{"uid":"api::feature.feature","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"feature","defaultSortBy":"feature","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"feature":{"edit":{"label":"feature","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"feature","searchable":true,"sortable":true}},"plans":{"edit":{"label":"plans","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"plans","searchable":false,"sortable":false}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"feature_i18ns":{"edit":{"label":"feature_i18ns","description":"","placeholder":"","visible":true,"editable":true,"mainField":"feature_name"},"list":{"label":"feature_i18ns","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","order","feature","feature_i18ns"],"edit":[[{"name":"feature","size":6},{"name":"plans","size":6}],[{"name":"order","size":4},{"name":"feature_i18ns","size":6}]]}}	object	\N	\N
37	plugin_content_manager_configuration_content_types::api::usage-event.usage-event	{"uid":"api::usage-event.usage-event","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"eventId","defaultSortBy":"eventId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"eventId":{"edit":{"label":"eventId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"eventId","searchable":true,"sortable":true}},"event_name":{"edit":{"label":"event_name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"event_name","searchable":true,"sortable":true}},"strapiUserId":{"edit":{"label":"strapiUserId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"strapiUserId","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"payload":{"edit":{"label":"payload","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"payload","searchable":false,"sortable":false}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"handle_result":{"edit":{"label":"handle_result","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"handle_result","searchable":true,"sortable":true}},"handled_at":{"edit":{"label":"handled_at","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"handled_at","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","eventId","strapiUserId","event_name"],"edit":[[{"name":"eventId","size":6}],[{"name":"strapiUserId","size":4},{"name":"username","size":6}],[{"name":"payload","size":12}],[{"name":"status","size":6},{"name":"event_name","size":6}],[{"name":"handle_result","size":6},{"name":"handled_at","size":6}]]}}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
22	{"tables":[{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users","indexes":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_roles","indexes":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users","indexes":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"apple_notifications","indexes":[{"name":"apple_notifications_created_by_id_fk","columns":["created_by_id"]},{"name":"apple_notifications_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"apple_notifications_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"apple_notifications_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"notification_uuid","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"notification_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subtype","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"original_transaction_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"processing_status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"raw_signed_payload","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"transaction_info","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"apple_receipts","indexes":[{"name":"apple_receipts_created_by_id_fk","columns":["created_by_id"]},{"name":"apple_receipts_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"apple_receipts_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"apple_receipts_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transaction_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"raw_receipt","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_attempt_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"audit_logs","indexes":[{"name":"audit_logs_created_by_id_fk","columns":["created_by_id"]},{"name":"audit_logs_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"audit_logs_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"audit_logs_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"event","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"message","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"details","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"entitlements","indexes":[{"type":"unique","name":"entitlements_slug_unique","columns":["slug"]},{"name":"entitlements_created_by_id_fk","columns":["created_by_id"]},{"name":"entitlements_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"entitlements_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"entitlements_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false,"unique":true},{"name":"ismetered","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"defaultlimit","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_period","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"features","indexes":[{"name":"features_created_by_id_fk","columns":["created_by_id"]},{"name":"features_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"features_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"features_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"feature_i18ns","indexes":[{"name":"feature_i18ns_created_by_id_fk","columns":["created_by_id"]},{"name":"feature_i18ns_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"feature_i18ns_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"feature_i18ns_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"pings","indexes":[{"name":"pings_created_by_id_fk","columns":["created_by_id"]},{"name":"pings_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"pings_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"pings_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plans","indexes":[{"name":"plans_created_by_id_fk","columns":["created_by_id"]},{"name":"plans_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"plans_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"plans_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"product_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_product_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_start_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_end_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"role","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"plan_ent_links","indexes":[{"name":"plan_ent_links_created_by_id_fk","columns":["created_by_id"]},{"name":"plan_ent_links_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"plan_ent_links_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"plan_ent_links_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"limit_override","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"subscriptions","indexes":[{"name":"subscriptions_created_by_id_fk","columns":["created_by_id"]},{"name":"subscriptions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"subscriptions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"subscriptions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expire_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"original_transaction_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"latest_transaction_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"revocation_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"revocation_reason","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usage_events","indexes":[{"name":"usage_events_created_by_id_fk","columns":["created_by_id"]},{"name":"usage_events_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"usage_events_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"usage_events_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"event_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"event_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"payload","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"handle_result","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"handled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usage_records","indexes":[{"name":"usage_records_created_by_id_fk","columns":["created_by_id"]},{"name":"usage_records_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"usage_records_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"usage_records_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"period_start","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"period_end","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"used_amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usage_rules","indexes":[{"name":"usage_rules_created_by_id_fk","columns":["created_by_id"]},{"name":"usage_rules_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"usage_rules_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"usage_rules_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"event_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"filter_json","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usageledgers","indexes":[{"name":"usageledgers_created_by_id_fk","columns":["created_by_id"]},{"name":"usageledgers_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"usageledgers_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"usageledgers_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"strapi_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"consumed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_a_features","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"admin_permissions_role_links","indexes":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"]},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"admin_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_links","indexes":[{"name":"admin_users_roles_links_fk","columns":["user_id"]},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"]},{"name":"admin_users_roles_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_links_order_fk","columns":["role_order"]},{"name":"admin_users_roles_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"admin_users_roles_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_links","indexes":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_links_unique","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_links_order_inv_fk","columns":["api_token_permission_order"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_links","indexes":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_links_unique","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_links_order_inv_fk","columns":["transfer_token_permission_order"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_morphs","indexes":[{"name":"files_related_morphs_fk","columns":["file_id"]},{"name":"files_related_morphs_order_index","columns":["order"]},{"name":"files_related_morphs_id_column_index","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_morphs_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_links","indexes":[{"name":"files_folder_links_fk","columns":["file_id"]},{"name":"files_folder_links_inv_fk","columns":["folder_id"]},{"name":"files_folder_links_unique","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_links_order_inv_fk","columns":["file_order"]}],"foreignKeys":[{"name":"files_folder_links_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_links_inv_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_links","indexes":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"]},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_links_unique","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_links_order_inv_fk","columns":["folder_order"]}],"foreignKeys":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_links","indexes":[{"name":"up_permissions_role_links_fk","columns":["permission_id"]},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"up_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"up_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_links","indexes":[{"name":"up_users_role_links_fk","columns":["user_id"]},{"name":"up_users_role_links_inv_fk","columns":["role_id"]},{"name":"up_users_role_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"up_users_role_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"apple_notifications_subscription_links","indexes":[{"name":"apple_notifications_subscription_links_fk","columns":["apple_notification_id"]},{"name":"apple_notifications_subscription_links_inv_fk","columns":["subscription_id"]},{"name":"apple_notifications_subscription_links_unique","columns":["apple_notification_id","subscription_id"],"type":"unique"},{"name":"apple_notifications_subscription_links_order_inv_fk","columns":["apple_notification_order"]}],"foreignKeys":[{"name":"apple_notifications_subscription_links_fk","columns":["apple_notification_id"],"referencedColumns":["id"],"referencedTable":"apple_notifications","onDelete":"CASCADE"},{"name":"apple_notifications_subscription_links_inv_fk","columns":["subscription_id"],"referencedColumns":["id"],"referencedTable":"subscriptions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"apple_notification_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"subscription_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"apple_notification_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"audit_logs_apple_notification_links","indexes":[{"name":"audit_logs_apple_notification_links_fk","columns":["audit_log_id"]},{"name":"audit_logs_apple_notification_links_inv_fk","columns":["apple_notification_id"]},{"name":"audit_logs_apple_notification_links_unique","columns":["audit_log_id","apple_notification_id"],"type":"unique"}],"foreignKeys":[{"name":"audit_logs_apple_notification_links_fk","columns":["audit_log_id"],"referencedColumns":["id"],"referencedTable":"audit_logs","onDelete":"CASCADE"},{"name":"audit_logs_apple_notification_links_inv_fk","columns":["apple_notification_id"],"referencedColumns":["id"],"referencedTable":"apple_notifications","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"audit_log_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"apple_notification_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"features_plans_links","indexes":[{"name":"features_plans_links_fk","columns":["feature_id"]},{"name":"features_plans_links_inv_fk","columns":["plan_id"]},{"name":"features_plans_links_unique","columns":["feature_id","plan_id"],"type":"unique"},{"name":"features_plans_links_order_fk","columns":["plan_order"]},{"name":"features_plans_links_order_inv_fk","columns":["feature_order"]}],"foreignKeys":[{"name":"features_plans_links_fk","columns":["feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"},{"name":"features_plans_links_inv_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"features_localizations_links","indexes":[{"name":"features_localizations_links_fk","columns":["feature_id"]},{"name":"features_localizations_links_inv_fk","columns":["inv_feature_id"]},{"name":"features_localizations_links_unique","columns":["feature_id","inv_feature_id"],"type":"unique"},{"name":"features_localizations_links_order_fk","columns":["feature_order"]}],"foreignKeys":[{"name":"features_localizations_links_fk","columns":["feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"},{"name":"features_localizations_links_inv_fk","columns":["inv_feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"feature_i_18_ns_feature_links","indexes":[{"name":"feature_i_18_ns_feature_links_fk","columns":["feature_i_18_n_id"]},{"name":"feature_i_18_ns_feature_links_inv_fk","columns":["feature_id"]},{"name":"feature_i_18_ns_feature_links_unique","columns":["feature_i_18_n_id","feature_id"],"type":"unique"},{"name":"feature_i_18_ns_feature_links_order_inv_fk","columns":["feature_i_18_n_order"]}],"foreignKeys":[{"name":"feature_i_18_ns_feature_links_fk","columns":["feature_i_18_n_id"],"referencedColumns":["id"],"referencedTable":"feature_i18ns","onDelete":"CASCADE"},{"name":"feature_i_18_ns_feature_links_inv_fk","columns":["feature_id"],"referencedColumns":["id"],"referencedTable":"features","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_i_18_n_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_i_18_n_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"feature_i_18_ns_localizations_links","indexes":[{"name":"feature_i_18_ns_localizations_links_fk","columns":["feature_i_18_n_id"]},{"name":"feature_i_18_ns_localizations_links_inv_fk","columns":["inv_feature_i_18_n_id"]},{"name":"feature_i_18_ns_localizations_links_unique","columns":["feature_i_18_n_id","inv_feature_i_18_n_id"],"type":"unique"},{"name":"feature_i_18_ns_localizations_links_order_fk","columns":["feature_i_18_n_order"]}],"foreignKeys":[{"name":"feature_i_18_ns_localizations_links_fk","columns":["feature_i_18_n_id"],"referencedColumns":["id"],"referencedTable":"feature_i18ns","onDelete":"CASCADE"},{"name":"feature_i_18_ns_localizations_links_inv_fk","columns":["inv_feature_i_18_n_id"],"referencedColumns":["id"],"referencedTable":"feature_i18ns","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"feature_i_18_n_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_feature_i_18_n_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"feature_i_18_n_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plans_inherit_from_links","indexes":[{"name":"plans_inherit_from_links_fk","columns":["plan_id"]},{"name":"plans_inherit_from_links_inv_fk","columns":["inv_plan_id"]},{"name":"plans_inherit_from_links_unique","columns":["plan_id","inv_plan_id"],"type":"unique"},{"name":"plans_inherit_from_links_order_inv_fk","columns":["plan_order"]}],"foreignKeys":[{"name":"plans_inherit_from_links_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"},{"name":"plans_inherit_from_links_inv_fk","columns":["inv_plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plans_localizations_links","indexes":[{"name":"plans_localizations_links_fk","columns":["plan_id"]},{"name":"plans_localizations_links_inv_fk","columns":["inv_plan_id"]},{"name":"plans_localizations_links_unique","columns":["plan_id","inv_plan_id"],"type":"unique"},{"name":"plans_localizations_links_order_fk","columns":["plan_order"]}],"foreignKeys":[{"name":"plans_localizations_links_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"},{"name":"plans_localizations_links_inv_fk","columns":["inv_plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plan_ent_links_plan_links","indexes":[{"name":"plan_ent_links_plan_links_fk","columns":["plan_ent_link_id"]},{"name":"plan_ent_links_plan_links_inv_fk","columns":["plan_id"]},{"name":"plan_ent_links_plan_links_unique","columns":["plan_ent_link_id","plan_id"],"type":"unique"},{"name":"plan_ent_links_plan_links_order_inv_fk","columns":["plan_ent_link_order"]}],"foreignKeys":[{"name":"plan_ent_links_plan_links_fk","columns":["plan_ent_link_id"],"referencedColumns":["id"],"referencedTable":"plan_ent_links","onDelete":"CASCADE"},{"name":"plan_ent_links_plan_links_inv_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_ent_link_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_ent_link_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"plan_ent_links_entitlement_links","indexes":[{"name":"plan_ent_links_entitlement_links_fk","columns":["plan_ent_link_id"]},{"name":"plan_ent_links_entitlement_links_inv_fk","columns":["entitlement_id"]},{"name":"plan_ent_links_entitlement_links_unique","columns":["plan_ent_link_id","entitlement_id"],"type":"unique"},{"name":"plan_ent_links_entitlement_links_order_inv_fk","columns":["plan_ent_link_order"]}],"foreignKeys":[{"name":"plan_ent_links_entitlement_links_fk","columns":["plan_ent_link_id"],"referencedColumns":["id"],"referencedTable":"plan_ent_links","onDelete":"CASCADE"},{"name":"plan_ent_links_entitlement_links_inv_fk","columns":["entitlement_id"],"referencedColumns":["id"],"referencedTable":"entitlements","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"plan_ent_link_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"entitlement_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_ent_link_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"subscriptions_plan_links","indexes":[{"name":"subscriptions_plan_links_fk","columns":["subscription_id"]},{"name":"subscriptions_plan_links_inv_fk","columns":["plan_id"]},{"name":"subscriptions_plan_links_unique","columns":["subscription_id","plan_id"],"type":"unique"},{"name":"subscriptions_plan_links_order_inv_fk","columns":["subscription_order"]}],"foreignKeys":[{"name":"subscriptions_plan_links_fk","columns":["subscription_id"],"referencedColumns":["id"],"referencedTable":"subscriptions","onDelete":"CASCADE"},{"name":"subscriptions_plan_links_inv_fk","columns":["plan_id"],"referencedColumns":["id"],"referencedTable":"plans","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"subscription_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"plan_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"subscription_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usage_records_entitlement_links","indexes":[{"name":"usage_records_entitlement_links_fk","columns":["usage_record_id"]},{"name":"usage_records_entitlement_links_inv_fk","columns":["entitlement_id"]},{"name":"usage_records_entitlement_links_unique","columns":["usage_record_id","entitlement_id"],"type":"unique"}],"foreignKeys":[{"name":"usage_records_entitlement_links_fk","columns":["usage_record_id"],"referencedColumns":["id"],"referencedTable":"usage_records","onDelete":"CASCADE"},{"name":"usage_records_entitlement_links_inv_fk","columns":["entitlement_id"],"referencedColumns":["id"],"referencedTable":"entitlements","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"usage_record_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"entitlement_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usage_rules_entitlement_links","indexes":[{"name":"usage_rules_entitlement_links_fk","columns":["usage_rule_id"]},{"name":"usage_rules_entitlement_links_inv_fk","columns":["entitlement_id"]},{"name":"usage_rules_entitlement_links_unique","columns":["usage_rule_id","entitlement_id"],"type":"unique"}],"foreignKeys":[{"name":"usage_rules_entitlement_links_fk","columns":["usage_rule_id"],"referencedColumns":["id"],"referencedTable":"usage_rules","onDelete":"CASCADE"},{"name":"usage_rules_entitlement_links_inv_fk","columns":["entitlement_id"],"referencedColumns":["id"],"referencedTable":"entitlements","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"usage_rule_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"entitlement_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"usageledgers_entitlement_links","indexes":[{"name":"usageledgers_entitlement_links_fk","columns":["usageledger_id"]},{"name":"usageledgers_entitlement_links_inv_fk","columns":["entitlement_id"]},{"name":"usageledgers_entitlement_links_unique","columns":["usageledger_id","entitlement_id"],"type":"unique"},{"name":"usageledgers_entitlement_links_order_inv_fk","columns":["usageledger_order"]}],"foreignKeys":[{"name":"usageledgers_entitlement_links_fk","columns":["usageledger_id"],"referencedColumns":["id"],"referencedTable":"usageledgers","onDelete":"CASCADE"},{"name":"usageledgers_entitlement_links_inv_fk","columns":["entitlement_id"],"referencedColumns":["id"],"referencedTable":"entitlements","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"usageledger_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"entitlement_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"usageledger_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2026-05-10 00:24:41.834	2b50d3a8edd5c50d07e6ca8ae5226612
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

COPY public.subscriptions (id, strapi_user_id, status, expire_date, original_transaction_id, latest_transaction_id, created_at, updated_at, created_by_id, updated_by_id, start_date, revocation_date, revocation_reason) FROM stdin;
1	456	canceled	\N	\N	\N	2025-07-04 17:01:08.999	2025-07-04 20:24:54.346	\N	\N	\N	\N	\N
2	456	canceled	\N	\N	\N	2025-07-04 20:24:54.568	2025-07-04 20:31:24.1	\N	\N	\N	\N	\N
3	456	canceled	2025-08-03 20:31:29.5	\N	\N	2025-07-04 20:31:24.331	2025-07-04 20:39:11.599	\N	\N	\N	\N	\N
4	456	canceled	\N	\N	\N	2025-07-04 20:39:11.765	2025-07-04 20:39:16.727	\N	\N	2025-07-04 20:39:11.733	\N	\N
5	456	canceled	2025-08-03 20:39:16.694	\N	\N	2025-07-04 20:39:16.895	2025-07-04 22:25:21.617	\N	\N	2025-07-04 20:39:16.863	\N	\N
6	456	active	\N	\N	\N	2025-07-04 22:25:22.054	2025-07-04 22:25:22.054	\N	\N	2025-07-04 22:25:22.009	\N	\N
7	36	canceled	\N	\N	\N	2025-07-04 22:33:47.19	2025-07-04 22:41:28.505	\N	\N	2025-07-04 22:33:47.155	\N	\N
8	36	active	\N	\N	\N	2025-07-04 22:41:28.695	2025-07-04 22:41:28.695	\N	\N	2025-07-04 22:41:28.663	\N	\N
9	37	active	\N	\N	\N	2025-07-04 22:41:43.916	2025-07-04 22:41:43.916	\N	\N	2025-07-04 22:41:43.881	\N	\N
10	38	active	\N	\N	\N	2025-07-04 22:46:57.422	2025-07-04 22:46:57.422	\N	\N	2025-07-04 22:46:57.388	\N	\N
11	46	active	\N	\N	\N	2025-07-05 00:27:12.71	2025-07-05 00:27:12.71	\N	\N	2025-07-05 00:27:12.673	\N	\N
13	48	active	\N	\N	\N	2025-07-05 00:35:45.652	2025-07-05 00:35:45.652	\N	\N	2025-07-05 00:35:45.619	\N	\N
16	999	active	\N	\N	\N	2025-07-05 00:55:16.559	2025-07-05 00:55:16.559	\N	\N	2025-07-05 00:55:16.527	\N	\N
18	52	active	\N	\N	\N	2025-07-05 00:59:32.003	2025-07-05 00:59:32.003	\N	\N	2025-07-05 00:59:31.968	\N	\N
20	54	active	\N	\N	\N	2025-07-05 13:49:24.603	2025-07-05 13:49:24.603	\N	\N	2025-07-05 13:49:24.568	\N	\N
12	47	cancelled	\N	\N	\N	2025-07-05 00:28:07.221	2025-08-06 04:18:57.394	\N	\N	2025-07-05 00:28:07.189	\N	\N
22	47	active	\N	\N	\N	2025-08-06 04:18:57.44	2025-08-06 04:18:57.44	\N	\N	2025-08-06 04:18:57.43	\N	\N
14	49	cancelled	\N	\N	\N	2025-07-05 00:49:26.523	2025-08-12 00:28:02.486	\N	\N	2025-07-05 00:49:26.491	\N	\N
23	49	active	\N	\N	\N	2025-08-12 00:28:02.761	2025-08-12 00:28:02.761	\N	\N	2025-08-12 00:28:02.725	\N	\N
15	50	cancelled	\N	\N	\N	2025-07-05 00:52:42.093	2025-08-13 14:05:50.543	\N	\N	2025-07-05 00:52:42.058	\N	\N
24	50	active	\N	\N	\N	2025-08-13 14:05:51.136	2025-08-13 14:05:51.136	\N	\N	2025-08-13 14:05:51.026	\N	\N
17	51	cancelled	\N	\N	\N	2025-07-05 00:56:37.536	2025-08-13 14:23:48.433	\N	\N	2025-07-05 00:56:37.502	\N	\N
25	51	active	\N	\N	\N	2025-08-13 14:23:48.961	2025-08-13 14:23:48.961	\N	\N	2025-08-13 14:23:48.885	\N	\N
19	53	cancelled	\N	\N	\N	2025-07-05 13:37:44.646	2025-08-13 23:07:06.84	\N	\N	2025-07-05 13:37:44.581	\N	\N
26	53	active	\N	\N	\N	2025-08-13 23:07:07.092	2025-08-13 23:07:07.092	\N	\N	2025-08-13 23:07:07.055	\N	\N
27	58	active	\N	\N	\N	2025-08-16 11:49:07.971	2025-08-16 11:49:07.971	\N	\N	2025-08-16 11:49:07.845	\N	\N
28	59	active	\N	\N	\N	2025-08-16 21:24:00.418	2025-08-16 21:24:00.418	\N	\N	2025-08-16 21:24:00.356	\N	\N
29	60	active	\N	\N	\N	2025-08-16 21:38:35.69	2025-08-16 21:38:35.69	\N	\N	2025-08-16 21:38:35.653	\N	\N
30	7	active	\N	\N	\N	2025-12-10 16:07:37.538	2025-12-10 16:07:37.538	\N	\N	2025-12-10 16:07:37.499	\N	\N
31	64	active	\N	\N	\N	2026-04-21 16:17:09.178	2026-04-21 16:17:09.178	\N	\N	2026-04-21 16:17:09.092	\N	\N
32	65	active	\N	\N	\N	2026-04-21 16:17:36.33	2026-04-21 16:17:36.33	\N	\N	2026-04-21 16:17:36.294	\N	\N
33	66	active	\N	\N	\N	2026-04-21 16:18:39.419	2026-04-21 16:18:39.419	\N	\N	2026-04-21 16:18:39.387	\N	\N
34	67	active	\N	\N	\N	2026-04-21 16:19:15.125	2026-04-21 16:19:15.125	\N	\N	2026-04-21 16:19:15.093	\N	\N
35	68	active	\N	\N	\N	2026-04-21 16:22:09.791	2026-04-21 16:22:09.791	\N	\N	2026-04-21 16:22:09.76	\N	\N
36	69	active	\N	\N	\N	2026-04-21 16:22:31.236	2026-04-21 16:22:31.236	\N	\N	2026-04-21 16:22:31.203	\N	\N
37	70	active	\N	\N	\N	2026-04-21 16:47:47.405	2026-04-21 16:47:47.405	\N	\N	2026-04-21 16:47:47.372	\N	\N
38	71	active	\N	\N	\N	2026-04-23 21:52:49.715	2026-04-23 21:52:49.715	\N	\N	2026-04-23 21:52:49.584	\N	\N
21	8	cancelled	\N	\N	\N	2025-08-02 10:08:21.486	2026-04-29 18:31:47.427	\N	\N	2025-08-02 10:08:21.47	\N	\N
39	8	active	\N	\N	\N	2026-04-29 18:31:47.461	2026-04-29 18:31:47.461	\N	\N	2026-04-29 18:31:47.452	\N	\N
40	72	active	\N	\N	\N	2026-05-01 10:44:26.242	2026-05-01 10:44:26.242	\N	\N	2026-05-01 10:44:26.172	\N	\N
41	41	active	\N	\N	\N	2026-05-08 23:32:27.404	2026-05-08 23:32:27.404	\N	\N	2026-05-08 23:32:27.362	\N	\N
42	30	active	\N	\N	\N	2026-05-09 00:49:29.59	2026-05-09 00:49:29.59	\N	\N	2026-05-09 00:49:29.557	\N	\N
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
25	25	1	23
26	26	1	24
27	27	1	25
28	28	1	26
29	29	1	27
30	30	1	28
31	31	1	29
32	32	1	30
33	33	1	31
34	34	1	32
35	35	1	33
36	36	1	34
37	37	1	35
38	38	1	36
39	39	1	37
40	40	1	38
41	41	1	39
42	42	1	40
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
11	api::ping.ping.find	2025-08-02 00:15:12.925	2025-08-02 00:15:12.925	\N	\N
10	api::ping.ping.findOne	2025-08-02 00:15:12.925	2025-08-02 00:15:12.925	\N	\N
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
10	11	2	2
11	10	2	2
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Authenticated	Default role given to authenticated user.	authenticated	2025-07-04 13:47:47.292	2025-07-04 13:47:47.292	\N	\N
2	Public	Default role given to unauthenticated user.	public	2025-07-04 13:47:47.421	2025-08-02 00:15:12.775	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	testuser	test@example.com	local	$2a$10$0cNNdWaCqV2jrO5OHh/r7OiuJ0edBk9D5mDzYO8MUVSeQEqd3AwG2	\N	\N	t	f	2025-07-05 00:03:36.44	2025-07-05 00:03:36.44	\N	\N
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
-- Data for Name: usage_events; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usage_events (id, event_id, event_name, strapi_user_id, username, payload, status, created_at, updated_at, created_by_id, updated_by_id, handle_result, handled_at) FROM stdin;
\.


--
-- Data for Name: usage_records; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usage_records (id, strapi_user_id, period_start, period_end, used_amount, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: usage_records_entitlement_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usage_records_entitlement_links (id, usage_record_id, entitlement_id) FROM stdin;
\.


--
-- Data for Name: usage_rules; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usage_rules (id, event_name, amount, enabled, filter_json, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	flashcard.review	1	t	\N	2026-05-09 22:54:21.915	2026-05-09 22:54:21.915	1	1
2	flashcard.create	1	t	\N	2026-05-09 22:55:06.707	2026-05-09 22:55:06.707	1	1
3	article.create	1	t	\N	2026-05-09 22:55:33.936	2026-05-09 22:55:33.936	1	1
4	word.ai.translate	1	t	\N	2026-05-09 23:33:16.616	2026-05-09 23:33:16.616	1	1
\.


--
-- Data for Name: usage_rules_entitlement_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.usage_rules_entitlement_links (id, usage_rule_id, entitlement_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
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
-- Name: as_achievement_translations_id_seq; Type: SEQUENCE SET; Schema: achievement_system; Owner: strapi
--

SELECT pg_catalog.setval('achievement_system.as_achievement_translations_id_seq', 51, true);


--
-- Name: as_achievements_id_seq; Type: SEQUENCE SET; Schema: achievement_system; Owner: strapi
--

SELECT pg_catalog.setval('achievement_system.as_achievements_id_seq', 26, true);


--
-- Name: as_event_lists_id_seq; Type: SEQUENCE SET; Schema: achievement_system; Owner: strapi
--

SELECT pg_catalog.setval('achievement_system.as_event_lists_id_seq', 4, true);


--
-- Name: as_user_achievements_id_seq; Type: SEQUENCE SET; Schema: achievement_system; Owner: strapi
--

SELECT pg_catalog.setval('achievement_system.as_user_achievements_id_seq', 208, true);


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 187, true);


--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 187, true);


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

SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);


--
-- Name: apple_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.apple_notifications_id_seq', 1, false);


--
-- Name: apple_notifications_subscription_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.apple_notifications_subscription_links_id_seq', 1, false);


--
-- Name: apple_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.apple_receipts_id_seq', 1, false);


--
-- Name: audit_logs_apple_notification_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.audit_logs_apple_notification_links_id_seq', 1, false);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 1, false);


--
-- Name: components_a_features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_features_id_seq', 12, true);


--
-- Name: entitlements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.entitlements_id_seq', 30, true);


--
-- Name: feature_i18ns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.feature_i18ns_id_seq', 4, true);


--
-- Name: feature_i_18_ns_feature_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.feature_i_18_ns_feature_links_id_seq', 4, true);


--
-- Name: feature_i_18_ns_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.feature_i_18_ns_localizations_links_id_seq', 1, false);


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.features_id_seq', 10, true);


--
-- Name: features_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.features_localizations_links_id_seq', 1, false);


--
-- Name: features_plans_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.features_plans_links_id_seq', 19, true);


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

SELECT pg_catalog.setval('public.plan_ent_links_entitlement_links_id_seq', 43, true);


--
-- Name: plan_ent_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plan_ent_links_id_seq', 36, true);


--
-- Name: plan_ent_links_plan_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plan_ent_links_plan_links_id_seq', 44, true);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.plans_id_seq', 11, true);


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

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, true);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 39, true);


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

SELECT pg_catalog.setval('public.subscriptions_id_seq', 49, true);


--
-- Name: subscriptions_plan_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.subscriptions_plan_links_id_seq', 49, true);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 11, true);


--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 11, true);


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
-- Name: usage_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usage_events_id_seq', 21, true);


--
-- Name: usage_records_entitlement_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usage_records_entitlement_links_id_seq', 16, true);


--
-- Name: usage_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usage_records_id_seq', 16, true);


--
-- Name: usage_rules_entitlement_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usage_rules_entitlement_links_id_seq', 40, true);


--
-- Name: usage_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usage_rules_id_seq', 40, true);


--
-- Name: usageledgers_entitlement_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usageledgers_entitlement_links_id_seq', 26, true);


--
-- Name: usageledgers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.usageledgers_id_seq', 26, true);


--
-- Name: as_achievement_translations as_achievement_translations_achievement_id_locale_key; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievement_translations
    ADD CONSTRAINT as_achievement_translations_achievement_id_locale_key UNIQUE (achievement_id, locale);


--
-- Name: as_achievement_translations as_achievement_translations_pkey; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievement_translations
    ADD CONSTRAINT as_achievement_translations_pkey PRIMARY KEY (id);


--
-- Name: as_achievements as_achievements_code_key; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievements
    ADD CONSTRAINT as_achievements_code_key UNIQUE (code);


--
-- Name: as_achievements as_achievements_pkey; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievements
    ADD CONSTRAINT as_achievements_pkey PRIMARY KEY (id);


--
-- Name: as_event_lists as_event_lists_pkey; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_event_lists
    ADD CONSTRAINT as_event_lists_pkey PRIMARY KEY (id);


--
-- Name: as_user_achievements as_user_achievements_pkey; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_user_achievements
    ADD CONSTRAINT as_user_achievements_pkey PRIMARY KEY (id);


--
-- Name: as_user_achievements as_user_achievements_userid_achievement_id_key; Type: CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_user_achievements
    ADD CONSTRAINT as_user_achievements_userid_achievement_id_key UNIQUE (userid, achievement_id);


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
-- Name: apple_notifications apple_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications
    ADD CONSTRAINT apple_notifications_pkey PRIMARY KEY (id);


--
-- Name: apple_notifications_subscription_links apple_notifications_subscription_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications_subscription_links
    ADD CONSTRAINT apple_notifications_subscription_links_pkey PRIMARY KEY (id);


--
-- Name: apple_notifications_subscription_links apple_notifications_subscription_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications_subscription_links
    ADD CONSTRAINT apple_notifications_subscription_links_unique UNIQUE (apple_notification_id, subscription_id);


--
-- Name: apple_receipts apple_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_receipts
    ADD CONSTRAINT apple_receipts_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_apple_notification_links audit_logs_apple_notification_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs_apple_notification_links
    ADD CONSTRAINT audit_logs_apple_notification_links_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_apple_notification_links audit_logs_apple_notification_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs_apple_notification_links
    ADD CONSTRAINT audit_logs_apple_notification_links_unique UNIQUE (audit_log_id, apple_notification_id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


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
-- Name: feature_i18ns feature_i18ns_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i18ns
    ADD CONSTRAINT feature_i18ns_pkey PRIMARY KEY (id);


--
-- Name: feature_i_18_ns_feature_links feature_i_18_ns_feature_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_feature_links
    ADD CONSTRAINT feature_i_18_ns_feature_links_pkey PRIMARY KEY (id);


--
-- Name: feature_i_18_ns_feature_links feature_i_18_ns_feature_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_feature_links
    ADD CONSTRAINT feature_i_18_ns_feature_links_unique UNIQUE (feature_i_18_n_id, feature_id);


--
-- Name: feature_i_18_ns_localizations_links feature_i_18_ns_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_localizations_links
    ADD CONSTRAINT feature_i_18_ns_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: feature_i_18_ns_localizations_links feature_i_18_ns_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_localizations_links
    ADD CONSTRAINT feature_i_18_ns_localizations_links_unique UNIQUE (feature_i_18_n_id, inv_feature_i_18_n_id);


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
-- Name: usage_events usage_events_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_events
    ADD CONSTRAINT usage_events_pkey PRIMARY KEY (id);


--
-- Name: usage_records_entitlement_links usage_records_entitlement_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records_entitlement_links
    ADD CONSTRAINT usage_records_entitlement_links_pkey PRIMARY KEY (id);


--
-- Name: usage_records_entitlement_links usage_records_entitlement_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records_entitlement_links
    ADD CONSTRAINT usage_records_entitlement_links_unique UNIQUE (usage_record_id, entitlement_id);


--
-- Name: usage_records usage_records_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records
    ADD CONSTRAINT usage_records_pkey PRIMARY KEY (id);


--
-- Name: usage_rules_entitlement_links usage_rules_entitlement_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules_entitlement_links
    ADD CONSTRAINT usage_rules_entitlement_links_pkey PRIMARY KEY (id);


--
-- Name: usage_rules_entitlement_links usage_rules_entitlement_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules_entitlement_links
    ADD CONSTRAINT usage_rules_entitlement_links_unique UNIQUE (usage_rule_id, entitlement_id);


--
-- Name: usage_rules usage_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules
    ADD CONSTRAINT usage_rules_pkey PRIMARY KEY (id);


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
-- Name: as_achievement_translations_locale_idx; Type: INDEX; Schema: achievement_system; Owner: strapi
--

CREATE INDEX as_achievement_translations_locale_idx ON achievement_system.as_achievement_translations USING btree (locale);


--
-- Name: as_achievements_event_name_idx; Type: INDEX; Schema: achievement_system; Owner: strapi
--

CREATE INDEX as_achievements_event_name_idx ON achievement_system.as_achievements USING btree (event_name);


--
-- Name: as_event_lists_event_name_idx; Type: INDEX; Schema: achievement_system; Owner: strapi
--

CREATE INDEX as_event_lists_event_name_idx ON achievement_system.as_event_lists USING btree (event_name);


--
-- Name: as_user_achievements_achievement_idx; Type: INDEX; Schema: achievement_system; Owner: strapi
--

CREATE INDEX as_user_achievements_achievement_idx ON achievement_system.as_user_achievements USING btree (achievement_id);


--
-- Name: as_user_achievements_userid_idx; Type: INDEX; Schema: achievement_system; Owner: strapi
--

CREATE INDEX as_user_achievements_userid_idx ON achievement_system.as_user_achievements USING btree (userid);


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
-- Name: apple_notifications_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_notifications_created_by_id_fk ON public.apple_notifications USING btree (created_by_id);


--
-- Name: apple_notifications_subscription_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_notifications_subscription_links_fk ON public.apple_notifications_subscription_links USING btree (apple_notification_id);


--
-- Name: apple_notifications_subscription_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_notifications_subscription_links_inv_fk ON public.apple_notifications_subscription_links USING btree (subscription_id);


--
-- Name: apple_notifications_subscription_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_notifications_subscription_links_order_inv_fk ON public.apple_notifications_subscription_links USING btree (apple_notification_order);


--
-- Name: apple_notifications_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_notifications_updated_by_id_fk ON public.apple_notifications USING btree (updated_by_id);


--
-- Name: apple_receipts_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_receipts_created_by_id_fk ON public.apple_receipts USING btree (created_by_id);


--
-- Name: apple_receipts_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX apple_receipts_updated_by_id_fk ON public.apple_receipts USING btree (updated_by_id);


--
-- Name: audit_logs_apple_notification_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX audit_logs_apple_notification_links_fk ON public.audit_logs_apple_notification_links USING btree (audit_log_id);


--
-- Name: audit_logs_apple_notification_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX audit_logs_apple_notification_links_inv_fk ON public.audit_logs_apple_notification_links USING btree (apple_notification_id);


--
-- Name: audit_logs_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX audit_logs_created_by_id_fk ON public.audit_logs USING btree (created_by_id);


--
-- Name: audit_logs_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX audit_logs_updated_by_id_fk ON public.audit_logs USING btree (updated_by_id);


--
-- Name: entitlements_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX entitlements_created_by_id_fk ON public.entitlements USING btree (created_by_id);


--
-- Name: entitlements_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX entitlements_updated_by_id_fk ON public.entitlements USING btree (updated_by_id);


--
-- Name: feature_i18ns_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i18ns_created_by_id_fk ON public.feature_i18ns USING btree (created_by_id);


--
-- Name: feature_i18ns_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i18ns_updated_by_id_fk ON public.feature_i18ns USING btree (updated_by_id);


--
-- Name: feature_i_18_ns_feature_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i_18_ns_feature_links_fk ON public.feature_i_18_ns_feature_links USING btree (feature_i_18_n_id);


--
-- Name: feature_i_18_ns_feature_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i_18_ns_feature_links_inv_fk ON public.feature_i_18_ns_feature_links USING btree (feature_id);


--
-- Name: feature_i_18_ns_feature_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i_18_ns_feature_links_order_inv_fk ON public.feature_i_18_ns_feature_links USING btree (feature_i_18_n_order);


--
-- Name: feature_i_18_ns_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i_18_ns_localizations_links_fk ON public.feature_i_18_ns_localizations_links USING btree (feature_i_18_n_id);


--
-- Name: feature_i_18_ns_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i_18_ns_localizations_links_inv_fk ON public.feature_i_18_ns_localizations_links USING btree (inv_feature_i_18_n_id);


--
-- Name: feature_i_18_ns_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX feature_i_18_ns_localizations_links_order_fk ON public.feature_i_18_ns_localizations_links USING btree (feature_i_18_n_order);


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
-- Name: usage_events_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_events_created_by_id_fk ON public.usage_events USING btree (created_by_id);


--
-- Name: usage_events_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_events_updated_by_id_fk ON public.usage_events USING btree (updated_by_id);


--
-- Name: usage_records_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_records_created_by_id_fk ON public.usage_records USING btree (created_by_id);


--
-- Name: usage_records_entitlement_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_records_entitlement_links_fk ON public.usage_records_entitlement_links USING btree (usage_record_id);


--
-- Name: usage_records_entitlement_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_records_entitlement_links_inv_fk ON public.usage_records_entitlement_links USING btree (entitlement_id);


--
-- Name: usage_records_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_records_updated_by_id_fk ON public.usage_records USING btree (updated_by_id);


--
-- Name: usage_rules_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_rules_created_by_id_fk ON public.usage_rules USING btree (created_by_id);


--
-- Name: usage_rules_entitlement_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_rules_entitlement_links_fk ON public.usage_rules_entitlement_links USING btree (usage_rule_id);


--
-- Name: usage_rules_entitlement_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_rules_entitlement_links_inv_fk ON public.usage_rules_entitlement_links USING btree (entitlement_id);


--
-- Name: usage_rules_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX usage_rules_updated_by_id_fk ON public.usage_rules USING btree (updated_by_id);


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
-- Name: as_achievement_translations as_achievement_translations_achievement_id_fkey; Type: FK CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_achievement_translations
    ADD CONSTRAINT as_achievement_translations_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES achievement_system.as_achievements(id) ON DELETE CASCADE;


--
-- Name: as_user_achievements as_user_achievements_achievement_id_fkey; Type: FK CONSTRAINT; Schema: achievement_system; Owner: strapi
--

ALTER TABLE ONLY achievement_system.as_user_achievements
    ADD CONSTRAINT as_user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES achievement_system.as_achievements(id) ON DELETE CASCADE;


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
-- Name: apple_notifications apple_notifications_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications
    ADD CONSTRAINT apple_notifications_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: apple_notifications_subscription_links apple_notifications_subscription_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications_subscription_links
    ADD CONSTRAINT apple_notifications_subscription_links_fk FOREIGN KEY (apple_notification_id) REFERENCES public.apple_notifications(id) ON DELETE CASCADE;


--
-- Name: apple_notifications_subscription_links apple_notifications_subscription_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications_subscription_links
    ADD CONSTRAINT apple_notifications_subscription_links_inv_fk FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- Name: apple_notifications apple_notifications_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_notifications
    ADD CONSTRAINT apple_notifications_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: apple_receipts apple_receipts_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_receipts
    ADD CONSTRAINT apple_receipts_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: apple_receipts apple_receipts_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.apple_receipts
    ADD CONSTRAINT apple_receipts_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: audit_logs_apple_notification_links audit_logs_apple_notification_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs_apple_notification_links
    ADD CONSTRAINT audit_logs_apple_notification_links_fk FOREIGN KEY (audit_log_id) REFERENCES public.audit_logs(id) ON DELETE CASCADE;


--
-- Name: audit_logs_apple_notification_links audit_logs_apple_notification_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs_apple_notification_links
    ADD CONSTRAINT audit_logs_apple_notification_links_inv_fk FOREIGN KEY (apple_notification_id) REFERENCES public.apple_notifications(id) ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: audit_logs audit_logs_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


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
-- Name: feature_i18ns feature_i18ns_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i18ns
    ADD CONSTRAINT feature_i18ns_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: feature_i18ns feature_i18ns_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i18ns
    ADD CONSTRAINT feature_i18ns_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: feature_i_18_ns_feature_links feature_i_18_ns_feature_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_feature_links
    ADD CONSTRAINT feature_i_18_ns_feature_links_fk FOREIGN KEY (feature_i_18_n_id) REFERENCES public.feature_i18ns(id) ON DELETE CASCADE;


--
-- Name: feature_i_18_ns_feature_links feature_i_18_ns_feature_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_feature_links
    ADD CONSTRAINT feature_i_18_ns_feature_links_inv_fk FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- Name: feature_i_18_ns_localizations_links feature_i_18_ns_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_localizations_links
    ADD CONSTRAINT feature_i_18_ns_localizations_links_fk FOREIGN KEY (feature_i_18_n_id) REFERENCES public.feature_i18ns(id) ON DELETE CASCADE;


--
-- Name: feature_i_18_ns_localizations_links feature_i_18_ns_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.feature_i_18_ns_localizations_links
    ADD CONSTRAINT feature_i_18_ns_localizations_links_inv_fk FOREIGN KEY (inv_feature_i_18_n_id) REFERENCES public.feature_i18ns(id) ON DELETE CASCADE;


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
-- Name: usage_events usage_events_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_events
    ADD CONSTRAINT usage_events_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usage_events usage_events_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_events
    ADD CONSTRAINT usage_events_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usage_records usage_records_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records
    ADD CONSTRAINT usage_records_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usage_records_entitlement_links usage_records_entitlement_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records_entitlement_links
    ADD CONSTRAINT usage_records_entitlement_links_fk FOREIGN KEY (usage_record_id) REFERENCES public.usage_records(id) ON DELETE CASCADE;


--
-- Name: usage_records_entitlement_links usage_records_entitlement_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records_entitlement_links
    ADD CONSTRAINT usage_records_entitlement_links_inv_fk FOREIGN KEY (entitlement_id) REFERENCES public.entitlements(id) ON DELETE CASCADE;


--
-- Name: usage_records usage_records_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_records
    ADD CONSTRAINT usage_records_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usage_rules usage_rules_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules
    ADD CONSTRAINT usage_rules_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: usage_rules_entitlement_links usage_rules_entitlement_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules_entitlement_links
    ADD CONSTRAINT usage_rules_entitlement_links_fk FOREIGN KEY (usage_rule_id) REFERENCES public.usage_rules(id) ON DELETE CASCADE;


--
-- Name: usage_rules_entitlement_links usage_rules_entitlement_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules_entitlement_links
    ADD CONSTRAINT usage_rules_entitlement_links_inv_fk FOREIGN KEY (entitlement_id) REFERENCES public.entitlements(id) ON DELETE CASCADE;


--
-- Name: usage_rules usage_rules_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.usage_rules
    ADD CONSTRAINT usage_rules_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


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

