--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE dyanikoglu;
ALTER ROLE dyanikoglu WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md515145d90eadda335e2e4b8c8cba1094b';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;






--
-- Database creation
--

CREATE DATABASE "PathFinderDB" WITH TEMPLATE = template0 OWNER = dyanikoglu;
ALTER DATABASE "PathFinderDB" SET search_path TO "$user", public, tiger, topology;
CREATE DATABASE gisdb WITH TEMPLATE = template0 OWNER = postgres;
ALTER DATABASE gisdb SET search_path TO "$user", public, tiger;
CREATE DATABASE temp_db WITH TEMPLATE = template0 OWNER = dyanikoglu;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect "PathFinderDB"

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO dyanikoglu;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO dyanikoglu;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO dyanikoglu;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO dyanikoglu;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO dyanikoglu;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO dyanikoglu;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO dyanikoglu;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO dyanikoglu;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO dyanikoglu;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO dyanikoglu;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO dyanikoglu;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO dyanikoglu;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO dyanikoglu;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO dyanikoglu;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO dyanikoglu;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: background_task; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE background_task (
    id integer NOT NULL,
    task_name character varying(255) NOT NULL,
    task_params text NOT NULL,
    task_hash character varying(40) NOT NULL,
    verbose_name character varying(255),
    priority integer NOT NULL,
    run_at timestamp with time zone NOT NULL,
    repeat bigint NOT NULL,
    repeat_until timestamp with time zone,
    queue character varying(255),
    attempts integer NOT NULL,
    failed_at timestamp with time zone,
    last_error text NOT NULL,
    locked_by character varying(64),
    locked_at timestamp with time zone,
    creator_object_id integer,
    creator_content_type_id integer,
    CONSTRAINT background_task_creator_object_id_check CHECK ((creator_object_id >= 0))
);


ALTER TABLE background_task OWNER TO dyanikoglu;

--
-- Name: background_task_completedtask; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE background_task_completedtask (
    id integer NOT NULL,
    task_name character varying(255) NOT NULL,
    task_params text NOT NULL,
    task_hash character varying(40) NOT NULL,
    verbose_name character varying(255),
    priority integer NOT NULL,
    run_at timestamp with time zone NOT NULL,
    repeat bigint NOT NULL,
    repeat_until timestamp with time zone,
    queue character varying(255),
    attempts integer NOT NULL,
    failed_at timestamp with time zone,
    last_error text NOT NULL,
    locked_by character varying(64),
    locked_at timestamp with time zone,
    creator_object_id integer,
    creator_content_type_id integer,
    CONSTRAINT background_task_completedtask_creator_object_id_check CHECK ((creator_object_id >= 0))
);


ALTER TABLE background_task_completedtask OWNER TO dyanikoglu;

--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE background_task_completedtask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE background_task_completedtask_id_seq OWNER TO dyanikoglu;

--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE background_task_completedtask_id_seq OWNED BY background_task_completedtask.id;


--
-- Name: background_task_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE background_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE background_task_id_seq OWNER TO dyanikoglu;

--
-- Name: background_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE background_task_id_seq OWNED BY background_task.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO dyanikoglu;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO dyanikoglu;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO dyanikoglu;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO dyanikoglu;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO dyanikoglu;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO dyanikoglu;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO dyanikoglu;

--
-- Name: gisModule_baseproduct; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_baseproduct" (
    id integer NOT NULL,
    brand character varying(64) NOT NULL,
    type character varying(64) NOT NULL,
    amount integer NOT NULL,
    unit character varying(8) NOT NULL,
    group_id integer,
    name character varying(64),
    CONSTRAINT "gisModule_baseproduct_amount_check" CHECK ((amount >= 0))
);


ALTER TABLE "gisModule_baseproduct" OWNER TO dyanikoglu;

--
-- Name: gisModule_baseproduct_productID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_baseproduct_productID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_baseproduct_productID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_baseproduct_productID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_baseproduct_productID_seq" OWNED BY "gisModule_baseproduct".id;


--
-- Name: gisModule_blame; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_blame" (
    id integer NOT NULL,
    created_at timestamp with time zone,
    user_id integer,
    retailer_product_id integer,
    updated_at timestamp with time zone
);


ALTER TABLE "gisModule_blame" OWNER TO dyanikoglu;

--
-- Name: gisModule_blame_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_blame_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_blame_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_blame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_blame_id_seq" OWNED BY "gisModule_blame".id;


--
-- Name: gisModule_city; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_city" (
    "cityID" integer NOT NULL,
    "cityName" character varying(64) NOT NULL
);


ALTER TABLE "gisModule_city" OWNER TO dyanikoglu;

--
-- Name: gisModule_city_cityID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_city_cityID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_city_cityID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_city_cityID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_city_cityID_seq" OWNED BY "gisModule_city"."cityID";


--
-- Name: gisModule_district; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_district" (
    "districtID" integer NOT NULL,
    "cityID" integer NOT NULL,
    "districtName" character varying(64) NOT NULL,
    CONSTRAINT "gisModule_district_cityID_check" CHECK (("cityID" >= 0))
);


ALTER TABLE "gisModule_district" OWNER TO dyanikoglu;

--
-- Name: gisModule_district_districtID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_district_districtID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_district_districtID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_district_districtID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_district_districtID_seq" OWNED BY "gisModule_district"."districtID";


--
-- Name: gisModule_falsepriceproposal; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_falsepriceproposal" (
    id integer NOT NULL,
    status_code integer NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    retailer_id integer,
    retailer_product_id integer,
    answer_count integer NOT NULL,
    send_count integer NOT NULL
);


ALTER TABLE "gisModule_falsepriceproposal" OWNER TO dyanikoglu;

--
-- Name: gisModule_falsepriceproposal_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_falsepriceproposal_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_falsepriceproposal_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_falsepriceproposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_falsepriceproposal_id_seq" OWNED BY "gisModule_falsepriceproposal".id;


--
-- Name: gisModule_friend; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_friend" (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    status boolean NOT NULL,
    user_receiver_id integer,
    user_sender_id integer
);


ALTER TABLE "gisModule_friend" OWNER TO dyanikoglu;

--
-- Name: gisModule_friend_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_friend_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_friend_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_friend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_friend_id_seq" OWNED BY "gisModule_friend".id;


--
-- Name: gisModule_group; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_group" (
    id integer NOT NULL,
    name character varying(64),
    date timestamp with time zone NOT NULL
);


ALTER TABLE "gisModule_group" OWNER TO dyanikoglu;

--
-- Name: gisModule_group_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_group_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_group_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_group_id_seq" OWNED BY "gisModule_group".id;


--
-- Name: gisModule_groupmember; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_groupmember" (
    id integer NOT NULL,
    group_id integer,
    member_id integer,
    role_id integer,
    date timestamp with time zone
);


ALTER TABLE "gisModule_groupmember" OWNER TO dyanikoglu;

--
-- Name: gisModule_groupmember_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_groupmember_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_groupmember_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_groupmember_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_groupmember_id_seq" OWNED BY "gisModule_groupmember".id;


--
-- Name: gisModule_productgroup; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_productgroup" (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    parent_id integer
);


ALTER TABLE "gisModule_productgroup" OWNER TO dyanikoglu;

--
-- Name: gisModule_productgroup_productGroupID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_productgroup_productGroupID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_productgroup_productGroupID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_productgroup_productGroupID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_productgroup_productGroupID_seq" OWNED BY "gisModule_productgroup".id;


--
-- Name: gisModule_proposalsent; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_proposalsent" (
    id integer NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    response boolean,
    false_price_proposal_id integer,
    user_id integer
);


ALTER TABLE "gisModule_proposalsent" OWNER TO dyanikoglu;

--
-- Name: gisModule_proposalsent_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_proposalsent_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_proposalsent_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_proposalsent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_proposalsent_id_seq" OWNED BY "gisModule_proposalsent".id;


--
-- Name: gisModule_retailer; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_retailer" (
    name character varying(256) NOT NULL,
    id integer NOT NULL,
    address character varying(512) NOT NULL,
    "cityID" integer,
    "districtID" integer,
    geolocation geography(Point,4326),
    zip_code character varying(8),
    type_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    reputation double precision NOT NULL,
    CONSTRAINT "gisModule_retailer_cityID_check" CHECK (("cityID" >= 0)),
    CONSTRAINT "gisModule_retailer_districtID_check" CHECK (("districtID" >= 0))
);


ALTER TABLE "gisModule_retailer" OWNER TO dyanikoglu;

--
-- Name: gisModule_retailer_retailerID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_retailer_retailerID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_retailer_retailerID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_retailer_retailerID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_retailer_retailerID_seq" OWNED BY "gisModule_retailer".id;


--
-- Name: gisModule_retailerproduct; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_retailerproduct" (
    id integer NOT NULL,
    "unitPrice" double precision NOT NULL,
    "baseProduct_id" integer,
    retailer_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    blame_point integer NOT NULL,
    proposal_ongoing boolean NOT NULL,
    removed_from_store boolean NOT NULL
);


ALTER TABLE "gisModule_retailerproduct" OWNER TO dyanikoglu;

--
-- Name: gisModule_retailerproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_retailerproduct_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_retailerproduct_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_retailerproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_retailerproduct_id_seq" OWNED BY "gisModule_retailerproduct".id;


--
-- Name: gisModule_retailertype; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_retailertype" (
    "retailerTypeID" integer NOT NULL,
    "retailerTypeName" character varying(128) NOT NULL
);


ALTER TABLE "gisModule_retailertype" OWNER TO dyanikoglu;

--
-- Name: gisModule_retailertype_retailerTypeID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_retailertype_retailerTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_retailertype_retailerTypeID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_retailertype_retailerTypeID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_retailertype_retailerTypeID_seq" OWNED BY "gisModule_retailertype"."retailerTypeID";


--
-- Name: gisModule_role; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_role" (
    id integer NOT NULL,
    name character varying(64)
);


ALTER TABLE "gisModule_role" OWNER TO dyanikoglu;

--
-- Name: gisModule_role_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_role_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_role_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_role_id_seq" OWNED BY "gisModule_role".id;


--
-- Name: gisModule_shoppinglist; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_shoppinglist" (
    id integer NOT NULL,
    created_at timestamp with time zone,
    completed boolean NOT NULL,
    name character varying(64) NOT NULL,
    updated_at timestamp with time zone,
    completed_by_id integer,
    total_distance_cost double precision,
    total_money_cost double precision,
    total_time_cost double precision
);


ALTER TABLE "gisModule_shoppinglist" OWNER TO dyanikoglu;

--
-- Name: gisModule_shoppinglist_listID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_shoppinglist_listID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_shoppinglist_listID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_shoppinglist_listID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_shoppinglist_listID_seq" OWNED BY "gisModule_shoppinglist".id;


--
-- Name: gisModule_shoppinglistitem; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_shoppinglistitem" (
    id integer NOT NULL,
    product_id integer,
    quantity integer NOT NULL,
    list_id integer,
    added_by_id integer,
    edited_by_id integer,
    is_purchased boolean NOT NULL,
    unit_purchase_price double precision,
    purchased_by_id integer,
    purchase_date timestamp with time zone,
    purchased_from_id integer,
    CONSTRAINT "gisModule_shoppinglistitems_quantity_check" CHECK ((quantity >= 0))
);


ALTER TABLE "gisModule_shoppinglistitem" OWNER TO dyanikoglu;

--
-- Name: gisModule_shoppinglistitems_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_shoppinglistitems_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_shoppinglistitems_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_shoppinglistitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_shoppinglistitems_id_seq" OWNED BY "gisModule_shoppinglistitem".id;


--
-- Name: gisModule_shoppinglistmember; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_shoppinglistmember" (
    id integer NOT NULL,
    list_id integer,
    user_id integer,
    role_id integer
);


ALTER TABLE "gisModule_shoppinglistmember" OWNER TO dyanikoglu;

--
-- Name: gisModule_user; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_user" (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(512) NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    active_list_id integer,
    preferences_id integer,
    email character varying(64),
    reputation double precision NOT NULL,
    statistics_id integer
);


ALTER TABLE "gisModule_user" OWNER TO dyanikoglu;

--
-- Name: gisModule_user_userID_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_user_userID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_user_userID_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_user_userID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_user_userID_seq" OWNED BY "gisModule_user".id;


--
-- Name: gisModule_userpreferences; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_userpreferences" (
    id integer NOT NULL,
    money_factor boolean NOT NULL,
    dist_factor boolean NOT NULL,
    time_factor boolean NOT NULL,
    search_radius integer NOT NULL,
    route_end_point_id integer,
    route_start_point_id integer,
    get_notif_only_for_active_list boolean NOT NULL,
    algorithm integer NOT NULL,
    CONSTRAINT "gisModule_userpreferences_search_radius_check" CHECK ((search_radius >= 0))
);


ALTER TABLE "gisModule_userpreferences" OWNER TO dyanikoglu;

--
-- Name: gisModule_userpreferences_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_userpreferences_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_userpreferences_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_userpreferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_userpreferences_id_seq" OWNED BY "gisModule_userpreferences".id;


--
-- Name: gisModule_usersavedaddress; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_usersavedaddress" (
    name character varying(256) NOT NULL,
    id integer NOT NULL,
    address character varying(512) NOT NULL,
    geolocation geography(Point,4326),
    zip_code character varying(8),
    last_edit_time timestamp with time zone NOT NULL,
    city_id integer,
    district_id integer,
    user_id integer
);


ALTER TABLE "gisModule_usersavedaddress" OWNER TO dyanikoglu;

--
-- Name: gisModule_usersavedaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_usersavedaddress_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_usersavedaddress_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_usersavedaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_usersavedaddress_id_seq" OWNED BY "gisModule_usersavedaddress".id;


--
-- Name: gisModule_usershoppinglist_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_usershoppinglist_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_usershoppinglist_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_usershoppinglist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_usershoppinglist_id_seq" OWNED BY "gisModule_shoppinglistmember".id;


--
-- Name: gisModule_userstatistics; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_userstatistics" (
    id integer NOT NULL,
    "moneySpent" double precision NOT NULL,
    "itemsBought" integer NOT NULL,
    "shoppingListsComplete" integer NOT NULL,
    "favoriteCategory" character varying(64),
    "favoriteProduct" character varying(64),
    blame_count integer NOT NULL,
    reputation double precision NOT NULL,
    favorite_retailer character varying(64),
    CONSTRAINT "gisModule_userstatistics_blame_count_check" CHECK ((blame_count >= 0)),
    CONSTRAINT "gisModule_userstatistics_itemsBought_check" CHECK (("itemsBought" >= 0)),
    CONSTRAINT "gisModule_userstatistics_shoppingListsComplete_check" CHECK (("shoppingListsComplete" >= 0))
);


ALTER TABLE "gisModule_userstatistics" OWNER TO dyanikoglu;

--
-- Name: gisModule_userstatistics_id_seq; Type: SEQUENCE; Schema: public; Owner: dyanikoglu
--

CREATE SEQUENCE "gisModule_userstatistics_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "gisModule_userstatistics_id_seq" OWNER TO dyanikoglu;

--
-- Name: gisModule_userstatistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_userstatistics_id_seq" OWNED BY "gisModule_userstatistics".id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: background_task id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task ALTER COLUMN id SET DEFAULT nextval('background_task_id_seq'::regclass);


--
-- Name: background_task_completedtask id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task_completedtask ALTER COLUMN id SET DEFAULT nextval('background_task_completedtask_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: gisModule_baseproduct id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_baseproduct" ALTER COLUMN id SET DEFAULT nextval('"gisModule_baseproduct_productID_seq"'::regclass);


--
-- Name: gisModule_blame id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame" ALTER COLUMN id SET DEFAULT nextval('"gisModule_blame_id_seq"'::regclass);


--
-- Name: gisModule_city cityID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_city" ALTER COLUMN "cityID" SET DEFAULT nextval('"gisModule_city_cityID_seq"'::regclass);


--
-- Name: gisModule_district districtID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_district" ALTER COLUMN "districtID" SET DEFAULT nextval('"gisModule_district_districtID_seq"'::regclass);


--
-- Name: gisModule_falsepriceproposal id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal" ALTER COLUMN id SET DEFAULT nextval('"gisModule_falsepriceproposal_id_seq"'::regclass);


--
-- Name: gisModule_friend id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend" ALTER COLUMN id SET DEFAULT nextval('"gisModule_friend_id_seq"'::regclass);


--
-- Name: gisModule_group id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_group" ALTER COLUMN id SET DEFAULT nextval('"gisModule_group_id_seq"'::regclass);


--
-- Name: gisModule_groupmember id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember" ALTER COLUMN id SET DEFAULT nextval('"gisModule_groupmember_id_seq"'::regclass);


--
-- Name: gisModule_productgroup id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_productgroup" ALTER COLUMN id SET DEFAULT nextval('"gisModule_productgroup_productGroupID_seq"'::regclass);


--
-- Name: gisModule_proposalsent id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent" ALTER COLUMN id SET DEFAULT nextval('"gisModule_proposalsent_id_seq"'::regclass);


--
-- Name: gisModule_retailer id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailer" ALTER COLUMN id SET DEFAULT nextval('"gisModule_retailer_retailerID_seq"'::regclass);


--
-- Name: gisModule_retailerproduct id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct" ALTER COLUMN id SET DEFAULT nextval('"gisModule_retailerproduct_id_seq"'::regclass);


--
-- Name: gisModule_retailertype retailerTypeID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailertype" ALTER COLUMN "retailerTypeID" SET DEFAULT nextval('"gisModule_retailertype_retailerTypeID_seq"'::regclass);


--
-- Name: gisModule_role id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_role" ALTER COLUMN id SET DEFAULT nextval('"gisModule_role_id_seq"'::regclass);


--
-- Name: gisModule_shoppinglist id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglist" ALTER COLUMN id SET DEFAULT nextval('"gisModule_shoppinglist_listID_seq"'::regclass);


--
-- Name: gisModule_shoppinglistitem id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem" ALTER COLUMN id SET DEFAULT nextval('"gisModule_shoppinglistitems_id_seq"'::regclass);


--
-- Name: gisModule_shoppinglistmember id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember" ALTER COLUMN id SET DEFAULT nextval('"gisModule_usershoppinglist_id_seq"'::regclass);


--
-- Name: gisModule_user id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user" ALTER COLUMN id SET DEFAULT nextval('"gisModule_user_userID_seq"'::regclass);


--
-- Name: gisModule_userpreferences id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences" ALTER COLUMN id SET DEFAULT nextval('"gisModule_userpreferences_id_seq"'::regclass);


--
-- Name: gisModule_usersavedaddress id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress" ALTER COLUMN id SET DEFAULT nextval('"gisModule_usersavedaddress_id_seq"'::regclass);


--
-- Name: gisModule_userstatistics id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userstatistics" ALTER COLUMN id SET DEFAULT nextval('"gisModule_userstatistics_id_seq"'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add group	1	add_group
2	Can change group	1	change_group
3	Can delete group	1	delete_group
4	Can add user	2	add_user
5	Can change user	2	change_user
6	Can delete user	2	delete_user
7	Can add permission	3	add_permission
8	Can change permission	3	change_permission
9	Can delete permission	3	delete_permission
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
22	Can add city	8	add_city
23	Can change city	8	change_city
24	Can delete city	8	delete_city
25	Can add district	9	add_district
26	Can change district	9	change_district
27	Can delete district	9	delete_district
28	Can add retailer	10	add_retailer
29	Can change retailer	10	change_retailer
30	Can delete retailer	10	delete_retailer
31	Can add retailer type	11	add_retailertype
32	Can change retailer type	11	change_retailertype
33	Can delete retailer type	11	delete_retailertype
34	Can add base product	12	add_baseproduct
35	Can change base product	12	change_baseproduct
36	Can delete base product	12	delete_baseproduct
37	Can add product group	13	add_productgroup
38	Can change product group	13	change_productgroup
39	Can delete product group	13	delete_productgroup
43	Can add retailer product	15	add_retailerproduct
44	Can change retailer product	15	change_retailerproduct
45	Can delete retailer product	15	delete_retailerproduct
52	Can add user	17	add_user
53	Can change user	17	change_user
54	Can delete user	17	delete_user
55	Can add shopping list	18	add_shoppinglist
56	Can change shopping list	18	change_shoppinglist
57	Can delete shopping list	18	delete_shoppinglist
58	Can add shopping list items	19	add_shoppinglistitems
59	Can change shopping list items	19	change_shoppinglistitems
60	Can delete shopping list items	19	delete_shoppinglistitems
64	Can add shopping list item	19	add_shoppinglistitem
65	Can change shopping list item	19	change_shoppinglistitem
66	Can delete shopping list item	19	delete_shoppinglistitem
82	Can add tree edge	26	add_treeedge
83	Can change tree edge	26	change_treeedge
84	Can delete tree edge	26	delete_treeedge
85	Can add user shopping list	27	add_usershoppinglist
86	Can change user shopping list	27	change_usershoppinglist
87	Can delete user shopping list	27	delete_usershoppinglist
88	Can add user saved address	28	add_usersavedaddress
89	Can change user saved address	28	change_usersavedaddress
90	Can delete user saved address	28	delete_usersavedaddress
91	Can add user preferences	29	add_userpreferences
92	Can change user preferences	29	change_userpreferences
93	Can delete user preferences	29	delete_userpreferences
94	Can add friend	30	add_friend
95	Can change friend	30	change_friend
96	Can delete friend	30	delete_friend
97	Can add group member	31	add_groupmember
98	Can change group member	31	change_groupmember
99	Can delete group member	31	delete_groupmember
100	Can add group	32	add_group
101	Can change group	32	change_group
102	Can delete group	32	delete_group
103	Can add role	33	add_role
104	Can change role	33	change_role
105	Can delete role	33	delete_role
106	Can add shopping list member	27	add_shoppinglistmember
107	Can change shopping list member	27	change_shoppinglistmember
108	Can delete shopping list member	27	delete_shoppinglistmember
109	Can add blame	34	add_blame
110	Can change blame	34	change_blame
111	Can delete blame	34	delete_blame
112	Can add completed task	35	add_completedtask
113	Can change completed task	35	change_completedtask
114	Can delete completed task	35	delete_completedtask
115	Can add task	36	add_task
116	Can change task	36	change_task
117	Can delete task	36	delete_task
118	Can add false price proposal	37	add_falsepriceproposal
119	Can change false price proposal	37	change_falsepriceproposal
120	Can delete false price proposal	37	delete_falsepriceproposal
121	Can add proposal sent	38	add_proposalsent
122	Can change proposal sent	38	change_proposalsent
123	Can delete proposal sent	38	delete_proposalsent
124	Can add user statistics	39	add_userstatistics
125	Can change user statistics	39	change_userstatistics
126	Can delete user statistics	39	delete_userstatistics
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_permission_id_seq', 126, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$YV0KXD0f6Gla$Rag9D6eNIdg4BLZUcT33wt7JezjHqJBG6gaOH2dj300=	2017-09-03 22:38:40.156321+03	t	dyanikoglu	Doğa Can	Yanıkoğlu	dyanikoglu@outlook.com	t	t	2017-01-26 11:49:05+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: background_task; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY background_task (id, task_name, task_params, task_hash, verbose_name, priority, run_at, repeat, repeat_until, queue, attempts, failed_at, last_error, locked_by, locked_at, creator_object_id, creator_content_type_id) FROM stdin;
2952	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-04 13:50:11.000698+03	30	\N	\N	0	\N		\N	\N	\N	\N
2953	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-04 13:50:11.010019+03	30	\N	\N	0	\N		\N	\N	\N	\N
2954	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-04 13:50:11.013395+03	30	\N	\N	0	\N		\N	\N	\N	\N
\.


--
-- Data for Name: background_task_completedtask; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY background_task_completedtask (id, task_name, task_params, task_hash, verbose_name, priority, run_at, repeat, repeat_until, queue, attempts, failed_at, last_error, locked_by, locked_at, creator_object_id, creator_content_type_id) FROM stdin;
2123	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:42:22.318827+03	30	\N	\N	1	\N		5900	2017-09-03 22:42:22.295715+03	\N	\N
2124	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:42:23.030946+03	30	\N	\N	1	\N		5900	2017-09-03 22:42:23.022151+03	\N	\N
2125	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:42:24.252258+03	30	\N	\N	1	\N		5900	2017-09-03 22:42:24.242249+03	\N	\N
2126	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:42:45.309329+03	30	\N	\N	1	\N		5900	2017-09-03 22:42:45.286417+03	\N	\N
2127	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:42:46.03371+03	30	\N	\N	1	\N		5900	2017-09-03 22:42:46.028253+03	\N	\N
2128	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:42:46.696375+03	30	\N	\N	1	\N		5900	2017-09-03 22:42:46.688743+03	\N	\N
2129	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:43:12.805285+03	30	\N	\N	1	\N		5900	2017-09-03 22:43:12.784123+03	\N	\N
2130	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:43:13.821889+03	30	\N	\N	1	\N		5900	2017-09-03 22:43:13.81374+03	\N	\N
2131	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:43:14.946771+03	30	\N	\N	1	\N		5900	2017-09-03 22:43:14.935866+03	\N	\N
2132	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:43:46.103358+03	30	\N	\N	1	\N		5900	2017-09-03 22:43:46.073426+03	\N	\N
2133	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:43:46.963863+03	30	\N	\N	1	\N		5900	2017-09-03 22:43:46.957391+03	\N	\N
2134	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:43:48.434004+03	30	\N	\N	1	\N		5900	2017-09-03 22:43:48.407736+03	\N	\N
2135	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:44:14.775399+03	30	\N	\N	1	\N		5900	2017-09-03 22:44:14.746406+03	\N	\N
2136	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:44:15.484651+03	30	\N	\N	1	\N		5900	2017-09-03 22:44:15.472332+03	\N	\N
2137	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:44:16.668927+03	30	\N	\N	1	\N		5900	2017-09-03 22:44:16.649659+03	\N	\N
2138	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:44:47.569367+03	30	\N	\N	1	\N		5900	2017-09-03 22:44:47.549751+03	\N	\N
2139	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:44:48.753057+03	30	\N	\N	1	\N		5900	2017-09-03 22:44:48.742833+03	\N	\N
2140	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:44:49.692979+03	30	\N	\N	1	\N		5900	2017-09-03 22:44:49.665607+03	\N	\N
2141	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:45:16.319518+03	30	\N	\N	1	\N		5900	2017-09-03 22:45:16.296897+03	\N	\N
2142	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:45:17.002234+03	30	\N	\N	1	\N		5900	2017-09-03 22:45:16.993737+03	\N	\N
2143	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:45:17.772068+03	30	\N	\N	1	\N		5900	2017-09-03 22:45:17.74906+03	\N	\N
2144	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:45:43.938472+03	30	\N	\N	1	\N		5900	2017-09-03 22:45:43.914215+03	\N	\N
2145	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:45:45.03735+03	30	\N	\N	1	\N		5900	2017-09-03 22:45:45.0279+03	\N	\N
2146	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:45:46.016388+03	30	\N	\N	1	\N		5900	2017-09-03 22:45:45.992158+03	\N	\N
2147	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:46:16.907289+03	30	\N	\N	1	\N		5900	2017-09-03 22:46:16.882474+03	\N	\N
2148	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:46:17.479083+03	30	\N	\N	1	\N		5900	2017-09-03 22:46:17.470274+03	\N	\N
2149	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:46:18.441761+03	30	\N	\N	1	\N		5900	2017-09-03 22:46:18.412376+03	\N	\N
2150	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:46:44.771965+03	30	\N	\N	1	\N		5900	2017-09-03 22:46:44.739247+03	\N	\N
2151	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:46:45.939725+03	30	\N	\N	1	\N		5900	2017-09-03 22:46:45.932435+03	\N	\N
2152	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:46:47.044894+03	30	\N	\N	1	\N		5900	2017-09-03 22:46:47.01065+03	\N	\N
2153	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:47:13.421711+03	30	\N	\N	1	\N		5900	2017-09-03 22:47:13.401234+03	\N	\N
2154	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:47:14.852584+03	30	\N	\N	1	\N		5900	2017-09-03 22:47:14.845447+03	\N	\N
2155	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:47:15.393494+03	30	\N	\N	1	\N		5900	2017-09-03 22:47:15.367437+03	\N	\N
2156	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:47:46.995921+03	30	\N	\N	1	\N		5900	2017-09-03 22:47:46.974469+03	\N	\N
2157	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:47:48.245722+03	30	\N	\N	1	\N		5900	2017-09-03 22:47:48.238124+03	\N	\N
2158	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:47:49.048521+03	30	\N	\N	1	\N		5900	2017-09-03 22:47:48.99817+03	\N	\N
2159	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:48:14.801881+03	30	\N	\N	1	\N		5900	2017-09-03 22:48:14.75184+03	\N	\N
2160	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:48:15.425932+03	30	\N	\N	1	\N		5900	2017-09-03 22:48:15.416516+03	\N	\N
2161	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:48:16.062912+03	30	\N	\N	1	\N		5900	2017-09-03 22:48:16.009178+03	\N	\N
2162	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:48:47.57856+03	30	\N	\N	1	\N		5900	2017-09-03 22:48:47.555845+03	\N	\N
2163	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:48:48.240731+03	30	\N	\N	1	\N		5900	2017-09-03 22:48:48.231177+03	\N	\N
2164	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:48:49.042134+03	30	\N	\N	1	\N		5900	2017-09-03 22:48:48.992683+03	\N	\N
2165	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:49:14.784209+03	30	\N	\N	1	\N		5900	2017-09-03 22:49:14.760329+03	\N	\N
2166	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:49:15.675815+03	30	\N	\N	1	\N		5900	2017-09-03 22:49:15.666706+03	\N	\N
2167	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:49:16.652234+03	30	\N	\N	1	\N		5900	2017-09-03 22:49:16.600682+03	\N	\N
2168	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:49:47.437242+03	30	\N	\N	1	\N		5900	2017-09-03 22:49:47.417824+03	\N	\N
2169	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:49:48.822539+03	30	\N	\N	1	\N		5900	2017-09-03 22:49:48.81712+03	\N	\N
2170	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:49:50.135135+03	30	\N	\N	1	\N		5900	2017-09-03 22:49:50.084244+03	\N	\N
2171	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:50:16.754782+03	30	\N	\N	1	\N		5900	2017-09-03 22:50:16.682265+03	\N	\N
2172	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:50:18.007965+03	30	\N	\N	1	\N		5900	2017-09-03 22:50:17.997411+03	\N	\N
2173	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:50:18.65094+03	30	\N	\N	1	\N		5900	2017-09-03 22:50:18.596538+03	\N	\N
2174	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:50:44.993404+03	30	\N	\N	1	\N		5900	2017-09-03 22:50:44.970446+03	\N	\N
2175	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:50:46.261689+03	30	\N	\N	1	\N		5900	2017-09-03 22:50:46.250878+03	\N	\N
2176	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:50:47.663814+03	30	\N	\N	1	\N		5900	2017-09-03 22:50:47.60428+03	\N	\N
2177	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:51:13.630491+03	30	\N	\N	1	\N		5900	2017-09-03 22:51:13.610282+03	\N	\N
2178	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:51:14.42166+03	30	\N	\N	1	\N		5900	2017-09-03 22:51:14.4142+03	\N	\N
2179	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:51:15.663227+03	30	\N	\N	1	\N		5900	2017-09-03 22:51:15.620527+03	\N	\N
2180	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:51:46.458761+03	30	\N	\N	1	\N		5900	2017-09-03 22:51:46.436923+03	\N	\N
2181	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:51:47.624245+03	30	\N	\N	1	\N		5900	2017-09-03 22:51:47.617447+03	\N	\N
2182	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:51:48.517634+03	30	\N	\N	1	\N		5900	2017-09-03 22:51:48.458982+03	\N	\N
2183	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:52:15.043619+03	30	\N	\N	1	\N		5900	2017-09-03 22:52:15.010745+03	\N	\N
2184	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:52:15.895685+03	30	\N	\N	1	\N		5900	2017-09-03 22:52:15.888512+03	\N	\N
2185	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:52:16.731265+03	30	\N	\N	1	\N		5900	2017-09-03 22:52:16.681703+03	\N	\N
2186	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:52:43.291596+03	30	\N	\N	1	\N		5900	2017-09-03 22:52:43.272168+03	\N	\N
2187	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:52:44.60336+03	30	\N	\N	1	\N		5900	2017-09-03 22:52:44.596445+03	\N	\N
2188	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:52:45.373545+03	30	\N	\N	1	\N		5900	2017-09-03 22:52:45.320733+03	\N	\N
2189	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:53:16.338557+03	30	\N	\N	1	\N		5900	2017-09-03 22:53:16.31635+03	\N	\N
2190	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:53:17.641756+03	30	\N	\N	1	\N		5900	2017-09-03 22:53:17.634206+03	\N	\N
2191	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:53:18.417569+03	30	\N	\N	1	\N		5900	2017-09-03 22:53:18.357913+03	\N	\N
2192	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:53:44.78559+03	30	\N	\N	1	\N		5900	2017-09-03 22:53:44.763549+03	\N	\N
2193	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:53:46.041641+03	30	\N	\N	1	\N		5900	2017-09-03 22:53:46.035888+03	\N	\N
2194	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:53:46.653224+03	30	\N	\N	1	\N		5900	2017-09-03 22:53:46.596693+03	\N	\N
2195	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:54:13.092799+03	30	\N	\N	1	\N		5900	2017-09-03 22:54:13.073092+03	\N	\N
2196	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:54:14.564515+03	30	\N	\N	1	\N		5900	2017-09-03 22:54:14.556608+03	\N	\N
2197	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:54:16.106137+03	30	\N	\N	1	\N		5900	2017-09-03 22:54:16.047246+03	\N	\N
2198	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:54:42.74159+03	30	\N	\N	1	\N		5900	2017-09-03 22:54:42.721811+03	\N	\N
2199	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:54:43.855504+03	30	\N	\N	1	\N		5900	2017-09-03 22:54:43.848997+03	\N	\N
2200	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:54:45.270497+03	30	\N	\N	1	\N		5900	2017-09-03 22:54:45.218488+03	\N	\N
2201	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:55:16.630606+03	30	\N	\N	1	\N		5900	2017-09-03 22:55:16.60514+03	\N	\N
2202	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:55:17.340116+03	30	\N	\N	1	\N		5900	2017-09-03 22:55:17.332793+03	\N	\N
2203	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:55:18.749795+03	30	\N	\N	1	\N		5900	2017-09-03 22:55:18.680817+03	\N	\N
2204	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:55:45.373003+03	30	\N	\N	1	\N		5900	2017-09-03 22:55:45.34562+03	\N	\N
2205	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:55:46.478349+03	30	\N	\N	1	\N		5900	2017-09-03 22:55:46.472456+03	\N	\N
2206	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:55:48.038829+03	30	\N	\N	1	\N		5900	2017-09-03 22:55:47.964489+03	\N	\N
2207	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:56:13.978987+03	30	\N	\N	1	\N		5900	2017-09-03 22:56:13.957147+03	\N	\N
2208	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:56:14.897525+03	30	\N	\N	1	\N		5900	2017-09-03 22:56:14.887283+03	\N	\N
2209	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:56:15.965087+03	30	\N	\N	1	\N		5900	2017-09-03 22:56:15.876664+03	\N	\N
2210	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:56:47.302625+03	30	\N	\N	1	\N		5900	2017-09-03 22:56:47.276107+03	\N	\N
2211	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:56:48.516853+03	30	\N	\N	1	\N		5900	2017-09-03 22:56:48.507986+03	\N	\N
2212	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:56:49.758577+03	30	\N	\N	1	\N		5900	2017-09-03 22:56:49.692923+03	\N	\N
2213	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:57:15.425952+03	30	\N	\N	1	\N		5900	2017-09-03 22:57:15.401526+03	\N	\N
2214	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:57:16.41899+03	30	\N	\N	1	\N		5900	2017-09-03 22:57:16.413581+03	\N	\N
2215	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:57:17.08027+03	30	\N	\N	1	\N		5900	2017-09-03 22:57:17.001141+03	\N	\N
2216	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:57:43.674825+03	30	\N	\N	1	\N		5900	2017-09-03 22:57:43.652911+03	\N	\N
2217	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:57:44.557516+03	30	\N	\N	1	\N		5900	2017-09-03 22:57:44.548819+03	\N	\N
2218	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:57:45.771123+03	30	\N	\N	1	\N		5900	2017-09-03 22:57:45.703869+03	\N	\N
2219	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:58:17.15867+03	30	\N	\N	1	\N		5900	2017-09-03 22:58:17.125149+03	\N	\N
2220	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:58:17.718555+03	30	\N	\N	1	\N		5900	2017-09-03 22:58:17.711113+03	\N	\N
2221	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:58:18.904217+03	30	\N	\N	1	\N		5900	2017-09-03 22:58:18.837874+03	\N	\N
2222	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:58:44.536722+03	30	\N	\N	1	\N		5900	2017-09-03 22:58:44.517923+03	\N	\N
2223	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:58:45.923073+03	30	\N	\N	1	\N		5900	2017-09-03 22:58:45.912449+03	\N	\N
2224	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:58:47.417+03	30	\N	\N	1	\N		5900	2017-09-03 22:58:47.354602+03	\N	\N
2225	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:59:13.570134+03	30	\N	\N	1	\N		5900	2017-09-03 22:59:13.545438+03	\N	\N
2226	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:59:14.399269+03	30	\N	\N	1	\N		5900	2017-09-03 22:59:14.391425+03	\N	\N
2227	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:59:15.86543+03	30	\N	\N	1	\N		5900	2017-09-03 22:59:15.79654+03	\N	\N
2228	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 22:59:46.589309+03	30	\N	\N	1	\N		5900	2017-09-03 22:59:46.542636+03	\N	\N
2229	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 22:59:48.540763+03	30	\N	\N	1	\N		5900	2017-09-03 22:59:47.674077+03	\N	\N
2230	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 22:59:49.663321+03	30	\N	\N	1	\N		5900	2017-09-03 22:59:49.613815+03	\N	\N
2231	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:00:15.818583+03	30	\N	\N	1	\N		5900	2017-09-03 23:00:15.797815+03	\N	\N
2232	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:00:16.676+03	30	\N	\N	1	\N		5900	2017-09-03 23:00:16.66142+03	\N	\N
2233	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:00:17.874306+03	30	\N	\N	1	\N		5900	2017-09-03 23:00:17.805671+03	\N	\N
2234	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:00:43.60678+03	30	\N	\N	1	\N		5900	2017-09-03 23:00:43.583457+03	\N	\N
2235	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:00:44.590225+03	30	\N	\N	1	\N		5900	2017-09-03 23:00:44.578116+03	\N	\N
2236	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:00:45.724429+03	30	\N	\N	1	\N		5900	2017-09-03 23:00:45.664795+03	\N	\N
2237	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:01:16.734105+03	30	\N	\N	1	\N		5900	2017-09-03 23:01:16.71097+03	\N	\N
2238	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:01:17.933586+03	30	\N	\N	1	\N		5900	2017-09-03 23:01:17.919144+03	\N	\N
2239	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:01:19.024867+03	30	\N	\N	1	\N		5900	2017-09-03 23:01:18.955587+03	\N	\N
2240	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:01:45.550936+03	30	\N	\N	1	\N		5900	2017-09-03 23:01:45.528529+03	\N	\N
2241	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:01:46.703031+03	30	\N	\N	1	\N		5900	2017-09-03 23:01:46.671354+03	\N	\N
2242	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:01:47.311947+03	30	\N	\N	1	\N		5900	2017-09-03 23:01:47.245964+03	\N	\N
2243	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:02:13.401943+03	30	\N	\N	1	\N		5900	2017-09-03 23:02:13.381515+03	\N	\N
2244	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:02:14.053012+03	30	\N	\N	1	\N		5900	2017-09-03 23:02:14.046219+03	\N	\N
2245	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:02:15.242926+03	30	\N	\N	1	\N		5900	2017-09-03 23:02:15.173759+03	\N	\N
2246	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:02:46.590935+03	30	\N	\N	1	\N		5900	2017-09-03 23:02:46.568296+03	\N	\N
2247	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:02:48.095144+03	30	\N	\N	1	\N		5900	2017-09-03 23:02:48.087229+03	\N	\N
2248	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:02:49.233108+03	30	\N	\N	1	\N		5900	2017-09-03 23:02:49.164934+03	\N	\N
2249	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:03:15.350691+03	30	\N	\N	1	\N		5900	2017-09-03 23:03:15.329749+03	\N	\N
2250	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:03:16.349823+03	30	\N	\N	1	\N		5900	2017-09-03 23:03:16.341073+03	\N	\N
2251	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:03:17.867208+03	30	\N	\N	1	\N		5900	2017-09-03 23:03:17.787594+03	\N	\N
2252	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:03:43.945537+03	30	\N	\N	1	\N		5900	2017-09-03 23:03:43.919098+03	\N	\N
2253	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:03:44.622698+03	30	\N	\N	1	\N		5900	2017-09-03 23:03:44.612443+03	\N	\N
2254	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:03:45.837239+03	30	\N	\N	1	\N		5900	2017-09-03 23:03:45.763309+03	\N	\N
2255	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:04:16.683954+03	30	\N	\N	1	\N		5900	2017-09-03 23:04:16.6516+03	\N	\N
2256	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:04:17.83837+03	30	\N	\N	1	\N		5900	2017-09-03 23:04:17.831503+03	\N	\N
2257	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:04:19.02345+03	30	\N	\N	1	\N		5900	2017-09-03 23:04:18.924014+03	\N	\N
2258	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:04:45.43466+03	30	\N	\N	1	\N		5900	2017-09-03 23:04:45.411794+03	\N	\N
2259	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:04:46.691699+03	30	\N	\N	1	\N		5900	2017-09-03 23:04:46.684157+03	\N	\N
2260	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:04:47.321141+03	30	\N	\N	1	\N		5900	2017-09-03 23:04:47.258622+03	\N	\N
2261	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:05:13.826502+03	30	\N	\N	1	\N		5900	2017-09-03 23:05:13.802886+03	\N	\N
2262	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:05:15.340487+03	30	\N	\N	1	\N		5900	2017-09-03 23:05:15.335286+03	\N	\N
2263	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:05:16.627675+03	30	\N	\N	1	\N		5900	2017-09-03 23:05:16.560975+03	\N	\N
2264	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:05:43.254396+03	30	\N	\N	1	\N		5900	2017-09-03 23:05:43.231503+03	\N	\N
2265	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:05:44.27776+03	30	\N	\N	1	\N		5900	2017-09-03 23:05:44.269371+03	\N	\N
2266	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:05:45.469242+03	30	\N	\N	1	\N		5900	2017-09-03 23:05:45.401267+03	\N	\N
2267	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:06:16.487902+03	30	\N	\N	1	\N		5900	2017-09-03 23:06:16.462583+03	\N	\N
2268	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:06:17.660155+03	30	\N	\N	1	\N		5900	2017-09-03 23:06:17.649441+03	\N	\N
2269	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:06:18.315254+03	30	\N	\N	1	\N		5900	2017-09-03 23:06:18.235319+03	\N	\N
2270	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:06:44.643763+03	30	\N	\N	1	\N		5900	2017-09-03 23:06:44.619142+03	\N	\N
2271	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:06:45.235791+03	30	\N	\N	1	\N		5900	2017-09-03 23:06:45.22644+03	\N	\N
2272	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:06:45.919335+03	30	\N	\N	1	\N		5900	2017-09-03 23:06:45.852247+03	\N	\N
2273	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:07:16.643765+03	30	\N	\N	1	\N		5900	2017-09-03 23:07:16.622004+03	\N	\N
2274	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:07:17.927557+03	30	\N	\N	1	\N		5900	2017-09-03 23:07:17.919902+03	\N	\N
2275	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:07:18.626857+03	30	\N	\N	1	\N		5900	2017-09-03 23:07:18.563783+03	\N	\N
2276	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:07:52.186159+03	30	\N	\N	1	\N		7866	2017-09-03 23:07:52.159125+03	\N	\N
2277	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:07:53.157698+03	30	\N	\N	1	\N		7866	2017-09-03 23:07:53.149039+03	\N	\N
2278	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:07:54.164739+03	30	\N	\N	1	\N		7866	2017-09-03 23:07:54.104534+03	\N	\N
2279	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:08:24.932693+03	30	\N	\N	1	\N		7866	2017-09-03 23:08:24.909818+03	\N	\N
2280	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:08:25.514213+03	30	\N	\N	1	\N		7866	2017-09-03 23:08:25.505141+03	\N	\N
2281	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:08:26.295473+03	30	\N	\N	1	\N		7866	2017-09-03 23:08:26.229316+03	\N	\N
2282	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:08:52.642182+03	30	\N	\N	1	\N		7866	2017-09-03 23:08:52.621655+03	\N	\N
2283	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:08:53.727715+03	30	\N	\N	1	\N		7866	2017-09-03 23:08:53.716434+03	\N	\N
2284	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:08:54.674261+03	30	\N	\N	1	\N		7866	2017-09-03 23:08:54.617338+03	\N	\N
2285	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:09:20.666972+03	30	\N	\N	1	\N		7866	2017-09-03 23:09:20.639842+03	\N	\N
2286	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:09:21.756991+03	30	\N	\N	1	\N		7866	2017-09-03 23:09:21.750485+03	\N	\N
2287	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:09:22.559854+03	30	\N	\N	1	\N		7866	2017-09-03 23:09:22.49086+03	\N	\N
2288	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:09:53.926917+03	30	\N	\N	1	\N		7866	2017-09-03 23:09:53.875666+03	\N	\N
2289	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:10:01.048982+03	30	\N	\N	1	\N		7866	2017-09-03 23:09:55.236582+03	\N	\N
2290	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:10:02.340193+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:02.299344+03	\N	\N
2291	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:10:23.734806+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:23.714549+03	\N	\N
2292	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:10:25.129837+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:25.076646+03	\N	\N
2293	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:10:26.59102+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:26.531785+03	\N	\N
2294	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:10:52.286393+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:52.26177+03	\N	\N
2295	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:10:53.059892+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:53.050992+03	\N	\N
2296	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:10:53.84857+03	30	\N	\N	1	\N		7866	2017-09-03 23:10:53.781818+03	\N	\N
2297	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:11:29.649055+03	30	\N	\N	1	\N		8159	2017-09-03 23:11:29.625548+03	\N	\N
2298	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:11:30.884489+03	30	\N	\N	1	\N		8159	2017-09-03 23:11:30.875525+03	\N	\N
2299	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:11:31.850319+03	30	\N	\N	1	\N		8159	2017-09-03 23:11:31.770299+03	\N	\N
2300	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:11:58.052943+03	30	\N	\N	1	\N		8159	2017-09-03 23:11:58.026289+03	\N	\N
2301	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:11:58.750359+03	30	\N	\N	1	\N		8159	2017-09-03 23:11:58.739551+03	\N	\N
2302	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:11:59.564642+03	30	\N	\N	1	\N		8159	2017-09-03 23:11:59.491535+03	\N	\N
2303	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:12:31.054785+03	30	\N	\N	1	\N		8159	2017-09-03 23:12:31.001719+03	\N	\N
2304	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:12:32.481942+03	30	\N	\N	1	\N		8159	2017-09-03 23:12:31.890601+03	\N	\N
2305	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:12:33.782135+03	30	\N	\N	1	\N		8159	2017-09-03 23:12:33.731195+03	\N	\N
2306	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:13:00.091969+03	30	\N	\N	1	\N		8159	2017-09-03 23:13:00.069717+03	\N	\N
2307	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:13:00.758521+03	30	\N	\N	1	\N		8159	2017-09-03 23:13:00.730947+03	\N	\N
2308	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:13:01.372312+03	30	\N	\N	1	\N		8159	2017-09-03 23:13:01.312427+03	\N	\N
2309	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:13:27.869651+03	30	\N	\N	1	\N		8159	2017-09-03 23:13:27.84434+03	\N	\N
2310	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:13:29.016695+03	30	\N	\N	1	\N		8159	2017-09-03 23:13:29.007983+03	\N	\N
2311	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:13:29.797544+03	30	\N	\N	1	\N		8159	2017-09-03 23:13:29.707554+03	\N	\N
2312	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:14:01.250126+03	30	\N	\N	1	\N		8159	2017-09-03 23:14:01.227393+03	\N	\N
2313	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:14:02.751228+03	30	\N	\N	1	\N		8159	2017-09-03 23:14:02.743599+03	\N	\N
2314	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:14:03.833055+03	30	\N	\N	1	\N		8159	2017-09-03 23:14:03.768872+03	\N	\N
2315	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:14:29.734202+03	30	\N	\N	1	\N		8159	2017-09-03 23:14:29.711055+03	\N	\N
2316	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:14:31.016666+03	30	\N	\N	1	\N		8159	2017-09-03 23:14:31.00814+03	\N	\N
2317	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:14:31.928454+03	30	\N	\N	1	\N		8159	2017-09-03 23:14:31.869512+03	\N	\N
2318	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:15:03.963464+03	30	\N	\N	1	\N		8414	2017-09-03 23:15:03.940352+03	\N	\N
2319	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:15:04.725795+03	30	\N	\N	1	\N		8414	2017-09-03 23:15:04.715502+03	\N	\N
2320	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:15:05.317702+03	30	\N	\N	1	\N		8414	2017-09-03 23:15:05.238002+03	\N	\N
2321	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:15:31.614669+03	30	\N	\N	1	\N		8414	2017-09-03 23:15:31.588133+03	\N	\N
2322	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:15:32.510433+03	30	\N	\N	1	\N		8414	2017-09-03 23:15:32.501011+03	\N	\N
2323	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:15:33.685028+03	30	\N	\N	1	\N		8414	2017-09-03 23:15:33.622909+03	\N	\N
2324	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:16:04.870795+03	30	\N	\N	1	\N		8414	2017-09-03 23:16:04.829418+03	\N	\N
2325	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:16:06.975272+03	30	\N	\N	1	\N		8414	2017-09-03 23:16:05.930702+03	\N	\N
2326	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:16:07.606239+03	30	\N	\N	1	\N		8414	2017-09-03 23:16:07.564354+03	\N	\N
2327	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:16:34.163568+03	30	\N	\N	1	\N		8414	2017-09-03 23:16:34.141244+03	\N	\N
2328	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:16:35.685456+03	30	\N	\N	1	\N		8414	2017-09-03 23:16:35.654062+03	\N	\N
2329	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:16:36.280659+03	30	\N	\N	1	\N		8414	2017-09-03 23:16:36.214199+03	\N	\N
2330	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:17:02.188164+03	30	\N	\N	1	\N		8414	2017-09-03 23:17:02.166393+03	\N	\N
2331	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:17:03.665929+03	30	\N	\N	1	\N		8414	2017-09-03 23:17:03.656018+03	\N	\N
2332	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:17:05.211792+03	30	\N	\N	1	\N		8414	2017-09-03 23:17:05.139828+03	\N	\N
2333	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:18:18.894473+03	30	\N	\N	1	\N		8631	2017-09-03 23:18:18.874497+03	\N	\N
2334	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:18:20.235018+03	30	\N	\N	1	\N		8631	2017-09-03 23:18:20.226657+03	\N	\N
2335	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:18:21.43796+03	30	\N	\N	1	\N		8631	2017-09-03 23:18:21.37306+03	\N	\N
2336	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:18:48.024143+03	30	\N	\N	1	\N		8631	2017-09-03 23:18:48.001379+03	\N	\N
2337	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:18:48.629249+03	30	\N	\N	1	\N		8631	2017-09-03 23:18:48.622898+03	\N	\N
2338	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:18:49.950198+03	30	\N	\N	1	\N		8631	2017-09-03 23:18:49.88363+03	\N	\N
2339	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:19:20.827253+03	30	\N	\N	1	\N		8631	2017-09-03 23:19:20.779439+03	\N	\N
2340	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:19:24.167846+03	30	\N	\N	1	\N		8631	2017-09-03 23:19:22.266951+03	\N	\N
2341	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:19:25.428276+03	30	\N	\N	1	\N		8631	2017-09-03 23:19:25.373983+03	\N	\N
2342	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:19:46.698269+03	30	\N	\N	1	\N		8631	2017-09-03 23:19:46.674209+03	\N	\N
2343	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:19:47.759793+03	30	\N	\N	1	\N		8631	2017-09-03 23:19:47.734787+03	\N	\N
2344	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:19:48.474861+03	30	\N	\N	1	\N		8631	2017-09-03 23:19:48.408767+03	\N	\N
2345	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:20:19.908171+03	30	\N	\N	1	\N		8631	2017-09-03 23:20:19.887692+03	\N	\N
2346	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:20:21.292261+03	30	\N	\N	1	\N		8631	2017-09-03 23:20:21.285064+03	\N	\N
2347	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:20:22.69698+03	30	\N	\N	1	\N		8631	2017-09-03 23:20:22.628733+03	\N	\N
2348	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:20:48.559596+03	30	\N	\N	1	\N		8631	2017-09-03 23:20:48.537366+03	\N	\N
2349	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:20:50.004135+03	30	\N	\N	1	\N		8631	2017-09-03 23:20:49.996373+03	\N	\N
2350	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:20:51.287641+03	30	\N	\N	1	\N		8631	2017-09-03 23:20:51.228803+03	\N	\N
2351	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:21:17.243711+03	30	\N	\N	1	\N		8631	2017-09-03 23:21:17.216948+03	\N	\N
2352	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:21:18.530374+03	30	\N	\N	1	\N		8631	2017-09-03 23:21:18.522226+03	\N	\N
2353	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:21:20.105462+03	30	\N	\N	1	\N		8631	2017-09-03 23:21:20.037245+03	\N	\N
2354	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:21:46.272598+03	30	\N	\N	1	\N		8631	2017-09-03 23:21:46.250981+03	\N	\N
2355	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:21:47.182998+03	30	\N	\N	1	\N		8631	2017-09-03 23:21:47.178231+03	\N	\N
2356	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:21:47.955098+03	30	\N	\N	1	\N		8631	2017-09-03 23:21:47.894316+03	\N	\N
2357	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:22:19.33098+03	30	\N	\N	1	\N		8631	2017-09-03 23:22:19.294747+03	\N	\N
2358	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:22:20.298332+03	30	\N	\N	1	\N		8631	2017-09-03 23:22:20.287357+03	\N	\N
2359	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:22:21.015957+03	30	\N	\N	1	\N		8631	2017-09-03 23:22:20.950154+03	\N	\N
2360	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:22:47.229776+03	30	\N	\N	1	\N		8631	2017-09-03 23:22:47.209235+03	\N	\N
2361	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:22:47.977701+03	30	\N	\N	1	\N		8631	2017-09-03 23:22:47.971596+03	\N	\N
2362	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:22:48.750931+03	30	\N	\N	1	\N		8631	2017-09-03 23:22:48.686328+03	\N	\N
2363	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:23:09.565735+03	30	\N	\N	1	\N		8956	2017-09-03 23:23:09.542204+03	\N	\N
2364	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:23:10.322458+03	30	\N	\N	1	\N		8956	2017-09-03 23:23:10.312653+03	\N	\N
2365	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:23:11.774869+03	30	\N	\N	1	\N		8956	2017-09-03 23:23:11.686373+03	\N	\N
2366	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:23:37.956874+03	30	\N	\N	1	\N		8956	2017-09-03 23:23:37.933179+03	\N	\N
2367	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:23:39.17779+03	30	\N	\N	1	\N		8956	2017-09-03 23:23:39.168364+03	\N	\N
2368	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:23:40.398561+03	30	\N	\N	1	\N		8956	2017-09-03 23:23:40.323252+03	\N	\N
2369	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:24:11.686507+03	30	\N	\N	1	\N		8956	2017-09-03 23:24:11.643323+03	\N	\N
2370	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:24:13.299528+03	30	\N	\N	1	\N		8956	2017-09-03 23:24:12.559537+03	\N	\N
2371	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:24:14.738094+03	30	\N	\N	1	\N		8956	2017-09-03 23:24:14.68409+03	\N	\N
2372	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:24:40.667281+03	30	\N	\N	1	\N		8956	2017-09-03 23:24:40.64728+03	\N	\N
2373	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:24:41.204331+03	30	\N	\N	1	\N		8956	2017-09-03 23:24:41.183218+03	\N	\N
2374	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:24:42.411125+03	30	\N	\N	1	\N		8956	2017-09-03 23:24:42.352699+03	\N	\N
2375	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:25:08.093744+03	30	\N	\N	1	\N		8956	2017-09-03 23:25:08.06893+03	\N	\N
2376	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:25:09.397972+03	30	\N	\N	1	\N		8956	2017-09-03 23:25:09.347566+03	\N	\N
2377	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:25:10.198621+03	30	\N	\N	1	\N		8956	2017-09-03 23:25:10.15779+03	\N	\N
2378	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:25:41.782495+03	30	\N	\N	1	\N		8956	2017-09-03 23:25:41.755847+03	\N	\N
2379	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:25:42.935098+03	30	\N	\N	1	\N		8956	2017-09-03 23:25:42.92901+03	\N	\N
2380	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:25:44.100365+03	30	\N	\N	1	\N		8956	2017-09-03 23:25:44.031137+03	\N	\N
2381	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:26:10.196034+03	30	\N	\N	1	\N		8956	2017-09-03 23:26:10.168863+03	\N	\N
2382	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:26:11.343548+03	30	\N	\N	1	\N		8956	2017-09-03 23:26:11.331956+03	\N	\N
2383	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:26:12.550735+03	30	\N	\N	1	\N		8956	2017-09-03 23:26:12.474249+03	\N	\N
2384	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:26:38.361709+03	30	\N	\N	1	\N		8956	2017-09-03 23:26:38.31804+03	\N	\N
2385	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:26:46.483167+03	30	\N	\N	1	\N		8956	2017-09-03 23:26:39.866738+03	\N	\N
2386	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:26:47.527125+03	30	\N	\N	1	\N		8956	2017-09-03 23:26:47.47452+03	\N	\N
2387	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:27:08.685533+03	30	\N	\N	1	\N		8956	2017-09-03 23:27:08.658032+03	\N	\N
2388	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:27:09.485649+03	30	\N	\N	1	\N		8956	2017-09-03 23:27:09.471002+03	\N	\N
2389	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:27:10.870678+03	30	\N	\N	1	\N		8956	2017-09-03 23:27:10.797509+03	\N	\N
2390	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:27:41.696618+03	30	\N	\N	1	\N		8956	2017-09-03 23:27:41.673588+03	\N	\N
2391	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:27:42.935153+03	30	\N	\N	1	\N		8956	2017-09-03 23:27:42.904405+03	\N	\N
2392	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:27:44.169699+03	30	\N	\N	1	\N		8956	2017-09-03 23:27:44.058227+03	\N	\N
2393	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:28:10.713698+03	30	\N	\N	1	\N		8956	2017-09-03 23:28:10.688506+03	\N	\N
2394	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:28:11.791694+03	30	\N	\N	1	\N		8956	2017-09-03 23:28:11.781012+03	\N	\N
2395	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:28:13.123914+03	30	\N	\N	1	\N		8956	2017-09-03 23:28:13.058509+03	\N	\N
2396	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-09-03 23:28:39.692057+03	30	\N	\N	1	\N		8956	2017-09-03 23:28:39.670584+03	\N	\N
2397	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-09-03 23:28:41.053019+03	30	\N	\N	1	\N		8956	2017-09-03 23:28:41.044363+03	\N	\N
2398	gisModule.tasks.statistic_module_basic_statistics	[[], {}]	cddf56d6e036957b03d6e9b0c8cb85e4c8d67848	\N	0	2017-09-03 23:28:41.953975+03	30	\N	\N	1	\N		8956	2017-09-03 23:28:41.868941+03	\N	\N
\.


--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('background_task_completedtask_id_seq', 2398, true);


--
-- Name: background_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('background_task_id_seq', 2954, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
71	2017-01-27 12:15:33.153066+03	2	Test	1	[{"added": {}}]	10	1
72	2017-01-28 12:17:37.349322+03	2	Test	3		10	1
74	2017-01-28 12:36:28.515689+03	4	Test	1	[{"added": {}}]	10	1
76	2017-01-28 12:39:38.467364+03	5	test2	3		10	1
77	2017-01-28 12:39:38.472429+03	4	Test	3		10	1
78	2017-01-28 12:39:38.475692+03	3	Test Retailer	3		10	1
80	2017-01-28 12:39:50.185194+03	6	Test Retailer	2	[]	10	1
82	2017-01-28 12:41:42.426211+03	7	Test	3		10	1
84	2017-01-28 12:44:01.297849+03	8	Arcadium AVM	1	[{"added": {}}]	10	1
86	2017-01-28 14:05:23.469045+03	10	Atlantis AVM	1	[{"added": {}}]	10	1
88	2017-01-28 14:06:06.00564+03	12	Gordion AVM	1	[{"added": {}}]	10	1
90	2017-01-29 11:58:45.920782+03	13	Panora AVM	1	[{"added": {}}]	10	1
92	2017-01-29 11:59:55.937963+03	15	Cepa AVM	1	[{"added": {}}]	10	1
94	2017-01-29 12:04:34.602661+03	2	Shopping Center	2	[]	11	1
96	2017-01-29 12:08:54.243215+03	1	dyanikoglu	2	[{"changed": {"fields": ["first_name", "last_name", "last_login"]}}]	2	1
98	2017-01-29 15:48:56.027525+03	16	Armada AVM	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
100	2017-01-29 15:49:01.949526+03	16	Armada AVM	2	[{"changed": {"fields": ["retailerName"]}}]	10	1
102	2017-01-29 17:08:59.751492+03	9	Ankamall AVM	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
104	2017-01-30 00:30:26.694452+03	1	Sütaş Süt 1L	1	[{"added": {}}]	15	1
106	2017-01-30 00:31:31.520548+03	2	Panora AVM | Sütaş Süt 1L	1	[{"added": {}}]	15	1
108	2017-01-31 10:48:20.072592+03	3	Atlantis AVM | Sütaş Süt 1L	1	[{"added": {}}]	15	1
110	2017-02-04 00:32:08.710296+03	17	Next Level	3		10	1
112	2017-02-04 01:06:46.385198+03	18	Next Level	3		10	1
114	2017-02-04 03:22:41.186257+03	20	Yunus Market	1	[{"added": {}}]	10	1
116	2017-02-05 12:34:39.684143+03	3	Panora AVM | Sütaş Süt 1L	2	[{"changed": {"fields": ["retailerID"]}}]	15	1
118	2017-02-07 02:32:34.260272+03	21	Yunus Market	1	[{"added": {}}]	10	1
120	2017-02-07 02:33:35.550157+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
122	2017-02-07 02:35:17.135075+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
124	2017-02-07 02:36:35.588701+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
126	2017-02-07 02:46:12.391213+03	21	Yunus Market	3		10	1
128	2017-02-12 22:35:17.12648+03	23	Bizim Bakkal	1	[{"added": {}}]	10	1
130	2017-02-13 00:21:43.353058+03	23	Bizim Bakkal	2	[]	10	1
132	2017-02-13 00:27:19.6438+03	23	Bizim Bakkal	2	[]	10	1
134	2017-02-13 00:28:44.727252+03	23	Bizim Bakkal	2	[]	10	1
136	2017-02-13 00:33:09.002149+03	23	Bizim Bakkal	2	[]	10	1
138	2017-02-13 00:33:44.808974+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
140	2017-02-13 00:34:01.308932+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
142	2017-02-13 00:46:08.187053+03	23	Bizim Bakkal	2	[]	10	1
144	2017-02-13 00:48:13.668517+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
146	2017-02-13 00:48:53.263064+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
148	2017-02-13 00:55:37.279424+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
150	2017-02-13 00:57:57.782844+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
152	2017-02-13 01:39:45.370519+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
153	2017-02-14 01:53:16.393446+03	1	User object	1	[{"added": {}}]	17	1
155	2017-02-14 02:01:17.989405+03	2	ozyert	2	[{"changed": {"fields": ["userName"]}}]	17	1
163	2017-02-14 02:08:10.27763+03	2	dyanikoglu:Test Profile 1's Shopping List	1	[{"added": {}}]	18	1
165	2017-02-14 02:12:57.658086+03	3	tozyer:Test Profile 2's Shopping List	1	[{"added": {}}]	18	1
167	2017-02-14 02:17:28.075458+03	3	ShoppingListItem object	1	[{"added": {}}]	19	1
169	2017-02-14 02:19:58.421376+03	23	Bizim Bakkal	3		10	1
171	2017-02-14 02:31:53.943743+03	24	Bakkal	3		10	1
173	2017-02-14 02:33:02.18336+03	None	Bakkal	1	[{"added": {}}]	10	1
175	2017-02-14 10:39:06.857246+03	25	Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
176	2017-02-19 01:12:30.392902+03	2	Pınar Yoğurt 500G	1	[{"added": {}}]	12	1
178	2017-02-22 00:53:27.402464+03	4	Torku Banada 1Piece	1	[{"added": {}}]	12	1
179	2017-02-22 00:54:01.946104+03	5	Ülker Sütlü Çikolata 1Piece	1	[{"added": {}}]	12	1
180	2017-02-27 11:02:19.67605+03	1	Fruits & Vegetables	1	[{"added": {}}]	13	1
181	2017-02-27 11:02:42.428863+03	2	Meat & Fish	1	[{"added": {}}]	13	1
161	2017-02-14 02:05:12.3826+03	4	tozyer:Test Profile 2	1	[{"added": {}}]	\N	1
1	2017-01-26 12:45:57.866221+03	1	Shop object	1	[{"added": {}}]	\N	1
2	2017-01-26 13:00:58.887692+03	1	Shop object	3		\N	1
3	2017-01-26 13:01:23.575102+03	2	Shop object	1	[{"added": {}}]	\N	1
4	2017-01-26 13:05:05.343341+03	2	Yunus Market Çakırlar	2	[{"changed": {"fields": ["name", "address"]}}]	\N	1
5	2017-01-26 13:05:48.177891+03	2	Yunus Market Çakırlar	3		\N	1
6	2017-01-26 13:06:55.010337+03	3	Test Shop 2	1	[{"added": {}}]	\N	1
7	2017-01-26 13:07:10.440109+03	3	Test Shop 2	3		\N	1
8	2017-01-26 13:09:03.575258+03	4	Test Shop	1	[{"added": {}}]	\N	1
9	2017-01-26 13:09:11.926432+03	4	Test Shop	3		\N	1
10	2017-01-26 13:09:37.740499+03	5	Test Shop	1	[{"added": {}}]	\N	1
11	2017-01-26 13:09:56.207937+03	5	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
12	2017-01-26 13:10:17.320282+03	5	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
13	2017-01-26 13:10:26.242246+03	5	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
14	2017-01-26 13:10:35.520246+03	5	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
15	2017-01-26 13:10:41.666361+03	5	Test Shop	3		\N	1
16	2017-01-26 13:10:50.59279+03	6	Test Shop	1	[{"added": {}}]	\N	1
17	2017-01-26 13:11:11.588828+03	6	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
18	2017-01-26 13:11:23.477063+03	6	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
19	2017-01-26 13:11:33.954228+03	6	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
20	2017-01-26 13:11:40.61326+03	6	Test Shop	2	[{"changed": {"fields": ["address"]}}]	\N	1
21	2017-01-26 13:11:52.209572+03	6	Test Shop	2	[{"changed": {"fields": ["address", "city"]}}]	\N	1
22	2017-01-26 13:11:58.423031+03	6	Test Shop	3		\N	1
23	2017-01-26 13:12:08.527239+03	7	Test	1	[{"added": {}}]	\N	1
24	2017-01-26 13:12:21.501393+03	7	Test	3		\N	1
25	2017-01-26 13:16:39.197226+03	8	d	1	[{"added": {}}]	\N	1
26	2017-01-26 13:19:21.921093+03	9	Yunus	1	[{"added": {}}]	\N	1
27	2017-01-26 14:52:31.856493+03	9	Yunus	3		\N	1
28	2017-01-26 14:52:31.861157+03	8	d	3		\N	1
29	2017-01-26 15:02:20.188777+03	10	Test	1	[{"added": {}}]	\N	1
30	2017-01-26 15:02:29.638089+03	11	test2	1	[{"added": {}}]	\N	1
868	2017-05-13 14:08:50.958918+03	16	tes234	3		32	1
31	2017-01-26 15:34:12.527599+03	12	test3	1	[{"added": {}}]	\N	1
32	2017-01-26 15:34:41.526183+03	13	test4	1	[{"added": {}}]	\N	1
33	2017-01-26 15:36:20.896176+03	14	test5	1	[{"added": {}}]	\N	1
34	2017-01-26 15:37:39.827264+03	15	test7	1	[{"added": {}}]	\N	1
35	2017-01-26 15:38:10.811371+03	16	test8	1	[{"added": {}}]	\N	1
36	2017-01-26 15:39:01.191503+03	17	testt	1	[{"added": {}}]	\N	1
37	2017-01-26 15:39:35.989704+03	18	testtt	1	[{"added": {}}]	\N	1
38	2017-01-26 15:40:30.444568+03	19	test_son	1	[{"added": {}}]	\N	1
39	2017-01-26 15:41:04.994269+03	19	test_son	3		\N	1
40	2017-01-26 15:41:05.003037+03	18	testtt	3		\N	1
41	2017-01-26 15:41:05.007609+03	17	testt	3		\N	1
42	2017-01-26 15:41:05.013266+03	16	test8	3		\N	1
43	2017-01-26 15:41:05.017277+03	15	test7	3		\N	1
44	2017-01-26 15:41:05.021216+03	14	test5	3		\N	1
45	2017-01-26 15:41:05.025377+03	13	test4	3		\N	1
46	2017-01-26 15:41:05.030081+03	12	test3	3		\N	1
47	2017-01-26 15:41:05.034467+03	11	test2	3		\N	1
48	2017-01-26 15:41:05.038986+03	10	Test	3		\N	1
49	2017-01-26 15:41:50.849121+03	20	Yunus	1	[{"added": {}}]	\N	1
50	2017-01-26 15:50:33.756731+03	21	Cakirlar	1	[{"added": {}}]	\N	1
51	2017-01-26 15:50:53.540931+03	21	Cakirlar	3		\N	1
52	2017-01-26 15:51:08.058652+03	22	Turgut	1	[{"added": {}}]	\N	1
53	2017-01-26 15:51:20.627969+03	22	Turgut	3		\N	1
54	2017-01-26 15:52:00.401414+03	23	Arcadium	1	[{"added": {}}]	\N	1
55	2017-01-26 16:34:09.684106+03	24	Ankamall	1	[{"added": {}}]	\N	1
56	2017-01-26 16:39:10.074438+03	24	Ankamall	3		\N	1
57	2017-01-26 16:39:39.640787+03	25	Yunus Market	1	[{"added": {}}]	\N	1
58	2017-01-26 16:41:51.635361+03	25	Yunus Market	3		\N	1
59	2017-01-26 16:41:59.450778+03	26	atlantis	1	[{"added": {}}]	\N	1
60	2017-01-26 16:48:59.636837+03	27	Çakırlar Altunbilekler	1	[{"added": {}}]	\N	1
61	2017-01-26 16:49:34.649078+03	27	Çakırlar Altunbilekler	3		\N	1
62	2017-01-26 16:49:53.74512+03	28	Altunbilekler	1	[{"added": {}}]	\N	1
63	2017-01-26 16:52:06.57554+03	28	Altunbilekler	3		\N	1
64	2017-01-26 16:52:18.419376+03	29	Baypizza	1	[{"added": {}}]	\N	1
65	2017-01-26 16:53:11.874649+03	29	Baypizza	3		\N	1
66	2017-01-26 16:53:20.083419+03	30	Ofis Ostim	1	[{"added": {}}]	\N	1
67	2017-01-27 11:30:21.270968+03	30	Ofis Ostim	3		\N	1
68	2017-01-27 11:30:21.275101+03	26	atlantis	3		\N	1
69	2017-01-27 11:30:21.278322+03	23	Arcadium	3		\N	1
70	2017-01-27 11:30:21.281849+03	20	Yunus	3		\N	1
73	2017-01-28 12:29:21.991613+03	3	Test Retailer	1	[{"added": {}}]	10	1
75	2017-01-28 12:38:27.233339+03	5	test2	1	[{"added": {}}]	10	1
79	2017-01-28 12:39:46.800684+03	6	Test Retailer	1	[{"added": {}}]	10	1
81	2017-01-28 12:41:23.274646+03	7	Test	1	[{"added": {}}]	10	1
83	2017-01-28 12:41:45.499431+03	6	Test Retailer	3		10	1
85	2017-01-28 14:05:03.681414+03	9	Ankamall	1	[{"added": {}}]	10	1
87	2017-01-28 14:05:45.110097+03	11	Kentpark AVM	1	[{"added": {}}]	10	1
89	2017-01-28 14:06:25.127502+03	9	Ankamall AVM	2	[{"changed": {"fields": ["retailerName"]}}]	10	1
91	2017-01-29 11:59:21.581789+03	14	Kızılay AVM	1	[{"added": {}}]	10	1
93	2017-01-29 12:00:31.130513+03	16	Armada AVM	1	[{"added": {}}]	10	1
95	2017-01-29 12:04:38.203358+03	1	Supermarket	2	[]	11	1
97	2017-01-29 15:48:51.768637+03	16	Armada AVM	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
99	2017-01-29 15:48:59.076755+03	16	Armada AVMd	2	[{"changed": {"fields": ["retailerName"]}}]	10	1
101	2017-01-29 17:08:54.721555+03	9	Ankamall AVM	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
103	2017-01-29 17:18:42.980467+03	1	BaseProduct object	1	[{"added": {}}]	12	1
105	2017-01-30 00:30:37.622748+03	1	Sütaş Süt 1L	3		15	1
107	2017-01-30 00:31:38.662886+03	2	Panora AVM | Sütaş Süt 1L	3		15	1
109	2017-01-31 10:49:57.762227+03	17	Next Level	1	[{"added": {}}]	10	1
111	2017-02-04 01:05:29.503926+03	18	Next Level	1	[{"added": {}}]	10	1
113	2017-02-04 01:07:03.101332+03	19	Next Level	1	[{"added": {}}]	10	1
115	2017-02-04 03:22:53.6847+03	20	Yunus Market	3		10	1
117	2017-02-05 12:34:44.632708+03	3	Atlantis AVM | Sütaş Süt 1L	2	[{"changed": {"fields": ["retailerID"]}}]	15	1
119	2017-02-07 02:33:11.878558+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
121	2017-02-07 02:34:35.512354+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
123	2017-02-07 02:35:54.779288+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
125	2017-02-07 02:45:53.859672+03	21	Yunus Market	2	[{"changed": {"fields": ["retailerTypeID"]}}]	10	1
127	2017-02-07 02:46:20.863543+03	22	Yunus Market	1	[{"added": {}}]	10	1
129	2017-02-12 22:35:37.763219+03	22	Yunus Market	2	[]	10	1
131	2017-02-13 00:27:04.762316+03	23	Bizim Bakkal	2	[]	10	1
133	2017-02-13 00:28:36.422434+03	23	Bizim Bakkal	2	[]	10	1
135	2017-02-13 00:29:01.261573+03	23	Bizim Bakkal	2	[]	10	1
137	2017-02-13 00:33:20.00885+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
139	2017-02-13 00:33:53.649373+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
141	2017-02-13 00:46:08.135457+03	23	Bizim Bakkal	2	[]	10	1
143	2017-02-13 00:47:12.779183+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
145	2017-02-13 00:48:19.648313+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
147	2017-02-13 00:55:04.814761+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
149	2017-02-13 00:57:50.166625+03	23	Bizim Bakkal	2	[{"changed": {"fields": ["address"]}}]	10	1
151	2017-02-13 01:39:35.224377+03	23	Bizim Bakkal	2	[]	10	1
154	2017-02-14 02:00:56.12526+03	2	tozyer	1	[{"added": {}}]	17	1
156	2017-02-14 02:01:35.661482+03	2	tozyer	2	[{"changed": {"fields": ["userName"]}}]	17	1
164	2017-02-14 02:12:22.19675+03	2	ShoppingListItem object	1	[{"added": {}}]	19	1
166	2017-02-14 02:13:03.578706+03	4	tozyer:Test Profile 3's Shopping List	1	[{"added": {}}]	18	1
168	2017-02-14 02:17:34.421537+03	4	ShoppingListItem object	1	[{"added": {}}]	19	1
170	2017-02-14 02:20:40.476262+03	24	Bakkal	1	[{"added": {}}]	10	1
172	2017-02-14 02:32:05.191213+03	None	Bakkal	1	[{"added": {}}]	10	1
174	2017-02-14 02:34:51.252496+03	25	Bakkal	1	[{"added": {}}]	10	1
177	2017-02-19 01:12:57.13162+03	3	İçim Beyaz Peynir 250G	1	[{"added": {}}]	12	1
160	2017-02-14 02:05:00.297636+03	3	dyanikoglu:Test Profile 1	1	[{"added": {}}]	\N	1
182	2017-02-27 11:03:00.451129+03	3	Milk & Breakfast	1	[{"added": {}}]	13	1
183	2017-02-27 11:04:41.729544+03	4	Nutrition & Confectionary	1	[{"added": {}}]	13	1
184	2017-02-27 11:05:12.525656+03	5	Beverage	1	[{"added": {}}]	13	1
185	2017-02-27 11:05:50.063831+03	6	Cleaning Products	1	[{"added": {}}]	13	1
186	2017-02-27 11:06:15.260466+03	7	Cosmetic	1	[{"added": {}}]	13	1
187	2017-02-27 11:06:38.960205+03	8	Baby Products & Toys	1	[{"added": {}}]	13	1
188	2017-02-27 11:07:32.396238+03	9	Furnitures & Other House Products	1	[{"added": {}}]	13	1
189	2017-02-27 11:24:35.448841+03	10	Milk	1	[{"added": {}}]	13	1
191	2017-02-27 11:26:12.662217+03	11	Cheese	1	[{"added": {}}]	13	1
192	2017-02-27 11:28:07.601231+03	12	For Breakfast	1	[{"added": {}}]	13	1
202	2017-02-27 12:10:19.94184+03	25	Bakkal	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
203	2017-02-27 12:10:25.30544+03	22	Yunus Market	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
204	2017-02-27 12:10:29.998522+03	19	Next Level	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
205	2017-02-27 12:10:34.556257+03	16	Armada AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
206	2017-02-27 12:10:40.109726+03	15	Cepa AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
207	2017-02-27 12:10:47.831407+03	14	Kızılay AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
208	2017-02-27 12:10:52.656627+03	13	Panora AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
209	2017-02-27 12:10:59.341748+03	12	Gordion AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
210	2017-02-27 12:11:04.329806+03	11	Kentpark AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
211	2017-02-27 12:11:09.144038+03	10	Atlantis AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
212	2017-02-27 12:11:17.92461+03	9	Ankamall AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
213	2017-02-27 12:11:23.44753+03	8	Arcadium AVM	2	[{"changed": {"fields": ["retailerType"]}}]	10	1
214	2017-02-27 12:17:06.698176+03	6	Sütaş Pastorize Süt 1Piece	1	[{"added": {}}]	12	1
215	2017-02-27 12:17:23.038797+03	6	Sütaş Pastorize Süt 1Piece	3		12	1
190	2017-02-27 11:25:41.533846+03	1	Milk & Breakfast -> Milk	1	[{"added": {}}]	\N	1
193	2017-02-27 11:30:14.859614+03	2	Milk & Breakfast -> For Breakfast	1	[{"added": {}}]	\N	1
194	2017-02-27 11:38:53.140624+03	1	Milk & Breakfast -> Milk	2	[]	\N	1
195	2017-02-27 11:39:13.857812+03	2	Milk & Breakfast -> For Breakfast	2	[]	\N	1
196	2017-02-27 11:40:00.961642+03	2	Milk & Breakfast -> For Breakfast	3		\N	1
197	2017-02-27 11:40:00.969436+03	1	Milk & Breakfast -> Milk	3		\N	1
198	2017-02-27 11:40:26.185279+03	3	Milk & Breakfast -> Milk	1	[{"added": {}}]	\N	1
199	2017-02-27 11:42:57.155968+03	4	Fruits & Vegetables -> Meat & Fish	1	[{"added": {}}]	\N	1
200	2017-02-27 11:43:38.158409+03	4	Fruits & Vegetables -> Meat & Fish	3		\N	1
201	2017-02-27 11:43:38.165658+03	3	Milk & Breakfast -> Milk	3		\N	1
216	2017-02-27 13:06:45.699549+03	1	TreeEdge object	1	[{"added": {}}]	26	1
217	2017-02-27 13:06:52.249783+03	1	TreeEdge object	3		26	1
218	2017-02-27 13:09:20.295437+03	2	TreeEdge object	1	[{"added": {}}]	26	1
219	2017-02-27 13:23:01.642674+03	2	TreeEdge object	3		26	1
220	2017-02-27 13:42:51.485945+03	3	TreeEdge object	1	[{"added": {}}]	26	1
221	2017-02-27 13:44:29.370704+03	4	TreeEdge object	1	[{"added": {}}]	26	1
222	2017-02-27 13:47:02.240196+03	4	TreeEdge object	3		26	1
223	2017-02-27 13:47:02.245768+03	3	TreeEdge object	3		26	1
224	2017-02-27 13:47:14.194087+03	5	TreeEdge object	1	[{"added": {}}]	26	1
225	2017-02-27 13:50:01.430273+03	6	TreeEdge object	1	[{"added": {}}]	26	1
226	2017-02-27 13:51:05.531199+03	7	TreeEdge object	1	[{"added": {}}]	26	1
227	2017-02-27 13:51:31.406835+03	8	TreeEdge object	1	[{"added": {}}]	26	1
228	2017-02-27 13:52:17.643569+03	8	TreeEdge object	3		26	1
229	2017-02-27 13:52:17.649378+03	7	TreeEdge object	3		26	1
230	2017-02-27 13:52:17.652424+03	6	TreeEdge object	3		26	1
231	2017-02-27 13:52:17.663355+03	5	TreeEdge object	3		26	1
232	2017-02-27 13:52:25.212099+03	9	TreeEdge object	1	[{"added": {}}]	26	1
233	2017-02-27 13:55:56.996879+03	10	Milk -> Sütaş Süt 1L	1	[{"added": {}}]	26	1
234	2017-02-27 14:46:03.267097+03	10	Milk -> Sütaş Süt 1L	3		26	1
235	2017-02-27 14:46:03.271336+03	9	Milk & Breakfast -> Milk	3		26	1
236	2017-02-27 14:49:59.651987+03	19	Milk & Breakfast -> Milk	1	[{"added": {}}]	26	1
237	2017-02-27 14:50:31.627851+03	20	Milk & Breakfast -> For Breakfast	1	[{"added": {}}]	26	1
238	2017-02-27 14:51:13.539663+03	21	Milk & Breakfast -> Sütaş Süt 1L	1	[{"added": {}}]	26	1
239	2017-02-27 16:06:21.042213+03	22	Milk -> Sütaş Süt 1L	1	[{"added": {}}]	26	1
248	2017-02-28 09:16:42.879242+03	13	test	1	[{"added": {}}]	13	1
240	2017-02-28 09:09:33.666612+03	4	Test Profile 4	1	[{"added": {}}]	\N	1
241	2017-02-28 09:09:59.804656+03	4	Test Profile 4	3		\N	1
242	2017-02-28 09:10:46.077755+03	5	Test Profile 4	1	[{"added": {}}]	\N	1
243	2017-02-28 09:10:52.322028+03	5	Test Profile 4	3		\N	1
245	2017-02-28 09:11:41.75291+03	5	Test Profile 4	3		\N	1
246	2017-02-28 09:11:46.110593+03	5	Test Profile 4	3		\N	1
247	2017-02-28 09:13:35.835531+03	5	Test Profile 4	3		\N	1
252	2017-02-28 09:19:49.872919+03	13	test	3		13	1
253	2017-02-28 09:20:06.362118+03	22	Milk -> Sütaş Süt 1L	3		26	1
254	2017-02-28 09:20:06.367253+03	20	Milk & Breakfast -> For Breakfast	3		26	1
255	2017-02-28 09:20:06.37041+03	19	Milk & Breakfast -> Milk	3		26	1
256	2017-02-28 09:28:20.753887+03	14	Fruits	1	[{"added": {}}]	13	1
257	2017-02-28 09:28:26.546993+03	15	Vegetables	1	[{"added": {}}]	13	1
258	2017-02-28 09:28:37.891989+03	23	Fruits & Vegetables -> Fruits	1	[{"added": {}}]	26	1
259	2017-02-28 09:28:46.402314+03	24	Fruits & Vegetables -> Vegetables	1	[{"added": {}}]	26	1
260	2017-02-28 09:28:53.930001+03	25	Milk & Breakfast -> Milk	1	[{"added": {}}]	26	1
261	2017-02-28 09:29:03.305902+03	26	Milk & Breakfast -> For Breakfast	1	[{"added": {}}]	26	1
262	2017-02-28 09:29:30.805258+03	27	Fruits & Vegetables -> Cheese	1	[{"added": {}}]	26	1
263	2017-02-28 09:29:43.447853+03	27	Fruits & Vegetables -> Cheese	3		26	1
264	2017-02-28 09:35:55.837984+03	28	Milk & Breakfast -> Cheese	1	[{"added": {}}]	26	1
265	2017-02-28 09:36:50.113317+03	16	Yogurt	1	[{"added": {}}]	13	1
266	2017-02-28 09:37:04.149712+03	17	Butter	1	[{"added": {}}]	13	1
267	2017-02-28 09:37:13.211317+03	18	Egg	1	[{"added": {}}]	13	1
268	2017-02-28 09:37:26.393788+03	19	Olive	1	[{"added": {}}]	13	1
269	2017-02-28 09:38:29.408415+03	20	Icecream & Milky Desserts	1	[{"added": {}}]	13	1
270	2017-02-28 09:38:51.702047+03	29	Milk & Breakfast -> Yogurt	1	[{"added": {}}]	26	1
271	2017-02-28 09:39:11.890826+03	30	Milk & Breakfast -> Butter	1	[{"added": {}}]	26	1
272	2017-02-28 09:39:21.329723+03	31	Milk & Breakfast -> Egg	1	[{"added": {}}]	26	1
273	2017-02-28 09:39:34.307799+03	32	Milk & Breakfast -> Icecream & Milky Desserts	1	[{"added": {}}]	26	1
274	2017-02-28 09:39:50.827476+03	33	Milk & Breakfast -> Olive	1	[{"added": {}}]	26	1
275	2017-02-28 09:40:37.927001+03	5	Ülker Sütlü Çikolata 1Piece	3		12	1
276	2017-02-28 09:40:37.930312+03	4	Torku Banada 1Piece	3		12	1
277	2017-02-28 09:40:37.933683+03	3	İçim Beyaz Peynir 250G	3		12	1
278	2017-02-28 09:40:37.937177+03	2	Pınar Yoğurt 500G	3		12	1
279	2017-02-28 09:40:37.94057+03	1	Sütaş Süt 1L	3		12	1
280	2017-02-28 09:41:58.61663+03	7	Apple Green 1KG	1	[{"added": {}}]	12	1
281	2017-02-28 09:42:08.628267+03	8	Apple Red 1KG	1	[{"added": {}}]	12	1
282	2017-02-28 09:43:20.639002+03	9	Cucumber  1KG	1	[{"added": {}}]	12	1
283	2017-02-28 09:43:44.279972+03	10	Tomato  1KG	1	[{"added": {}}]	12	1
284	2017-02-28 09:44:16.593589+03	11	Watermelon  1KG	1	[{"added": {}}]	12	1
285	2017-02-28 09:45:09.436955+03	21	White Cheese	1	[{"added": {}}]	13	1
286	2017-02-28 09:45:13.582614+03	22	Yellow Cheese	1	[{"added": {}}]	13	1
287	2017-02-28 09:45:27.26087+03	34	Cheese -> White Cheese	1	[{"added": {}}]	26	1
288	2017-02-28 09:45:35.122732+03	35	Cheese -> Yellow Cheese	1	[{"added": {}}]	26	1
289	2017-02-28 09:46:24.592477+03	23	Soda	1	[{"added": {}}]	13	1
290	2017-02-28 09:46:35.388243+03	36	Beverage -> Soda	1	[{"added": {}}]	26	1
291	2017-02-28 09:47:11.771895+03	12	Coca-Cola Zero 1L	1	[{"added": {}}]	12	1
292	2017-02-28 09:47:26.710759+03	13	Fanta  1L	1	[{"added": {}}]	12	1
293	2017-02-28 09:47:57.506727+03	14	Fanta  1 Cans	1	[{"added": {}}]	12	1
294	2017-02-28 09:49:20.25976+03	15	Sütaş Pasteurized Milk 1L	1	[{"added": {}}]	12	1
295	2017-02-28 09:49:42.117955+03	16	Pınar Milk 1L	1	[{"added": {}}]	12	1
296	2017-02-28 09:49:48.509055+03	17	Pınar Pasteurized Milk 1L	1	[{"added": {}}]	12	1
297	2017-02-28 09:50:09.872898+03	24	Pasteurized Milk	1	[{"added": {}}]	13	1
298	2017-02-28 09:50:49.898669+03	25	Long-Lasting Milk	1	[{"added": {}}]	13	1
299	2017-02-28 09:50:59.249068+03	37	Milk -> Long-Lasting Milk	1	[{"added": {}}]	26	1
300	2017-02-28 09:51:05.644989+03	38	Milk -> Pasteurized Milk	1	[{"added": {}}]	26	1
301	2017-02-28 09:51:53.530853+03	39	Soda -> Coca-Cola Zero 1L	1	[{"added": {}}]	26	1
302	2017-02-28 09:52:10.62409+03	41	Soda -> Fanta  1L	1	[{"added": {}}]	26	1
303	2017-02-28 09:52:23.993787+03	42	Soda -> Fanta  1 Cans	1	[{"added": {}}]	26	1
304	2017-02-28 09:52:40.634347+03	43	Long-Lasting Milk -> Pınar Milk 1L	1	[{"added": {}}]	26	1
305	2017-02-28 09:52:57.943007+03	44	Pasteurized Milk -> Sütaş Pasteurized Milk 1L	1	[{"added": {}}]	26	1
306	2017-02-28 09:53:11.512546+03	46	Pasteurized Milk -> Pınar Pasteurized Milk 1L	1	[{"added": {}}]	26	1
307	2017-02-28 09:53:30.302949+03	47	Fruits -> Apple Green 1KG	1	[{"added": {}}]	26	1
308	2017-02-28 09:53:37.836412+03	48	Fruits -> Apple Red 1KG	1	[{"added": {}}]	26	1
309	2017-02-28 09:53:46.0213+03	49	Pasteurized Milk -> Watermelon  1KG	1	[{"added": {}}]	26	1
310	2017-02-28 09:54:05.568652+03	49	Pasteurized Milk -> Watermelon  1KG	3		26	1
311	2017-02-28 09:55:00.712955+03	50	Fruits -> Watermelon  1KG	1	[{"added": {}}]	26	1
312	2017-02-28 09:55:10.061178+03	51	Vegetables -> Cucumber  1KG	1	[{"added": {}}]	26	1
313	2017-02-28 09:55:19.707678+03	53	Vegetables -> Tomato  1KG	1	[{"added": {}}]	26	1
314	2017-02-28 10:41:27.596211+03	25	Long-Lasting Milk	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
315	2017-02-28 10:41:30.453108+03	24	Pasteurized Milk	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
316	2017-02-28 10:41:32.709288+03	23	Soda	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
317	2017-02-28 10:41:35.066733+03	22	Yellow Cheese	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
318	2017-02-28 10:41:37.453391+03	21	White Cheese	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
319	2017-02-28 10:41:40.075055+03	15	Vegetables	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
320	2017-02-28 10:41:42.711001+03	14	Fruits	2	[{"changed": {"fields": ["isLeaf"]}}]	13	1
321	2017-03-04 00:06:33.52507+03	1	dyanikoglu	2	[{"changed": {"fields": ["password"]}}]	17	1
322	2017-03-04 02:34:27.322054+03	3	Shopping List	3		18	1
323	2017-03-04 02:34:27.336975+03	2	Shopping List	3		18	1
324	2017-03-04 02:34:31.640539+03	4	Shopping List	3		18	1
325	2017-03-04 02:34:38.74854+03	5	Test List 1	1	[{"added": {}}]	18	1
326	2017-03-04 02:34:44.487548+03	6	Test List 2	1	[{"added": {}}]	18	1
327	2017-03-04 02:39:57.740171+03	1	dyanikoglu:Test List 1	1	[{"added": {}}]	27	1
328	2017-03-04 02:40:03.724438+03	2	dyanikoglu:Test List 2	1	[{"added": {}}]	27	1
329	2017-03-04 02:42:53.690709+03	4	ShoppingListItem object	3		19	1
330	2017-03-04 02:42:53.703248+03	3	ShoppingListItem object	3		19	1
331	2017-03-04 02:42:53.706636+03	2	ShoppingListItem object	3		19	1
332	2017-03-04 02:44:38.23276+03	5	ShoppingListItem object	1	[{"added": {}}]	19	1
333	2017-03-04 02:44:45.269607+03	6	ShoppingListItem object	1	[{"added": {}}]	19	1
334	2017-03-04 02:44:50.955304+03	7	ShoppingListItem object	1	[{"added": {}}]	19	1
335	2017-03-04 02:45:01.071334+03	8	ShoppingListItem object	1	[{"added": {}}]	19	1
336	2017-03-04 03:07:43.828298+03	8	Test List 2:Apple	2	[{"changed": {"fields": ["addedBy"]}}]	19	1
337	2017-03-04 03:07:47.327517+03	7	Test List 1:Tomato	2	[{"changed": {"fields": ["addedBy"]}}]	19	1
338	2017-03-04 03:07:50.100994+03	6	Test List 1:Watermelon	2	[{"changed": {"fields": ["addedBy"]}}]	19	1
339	2017-03-04 03:07:54.224769+03	5	Test List 1:Coca-Cola	2	[{"changed": {"fields": ["addedBy"]}}]	19	1
340	2017-03-04 13:02:19.097655+03	1	dyanikoglu:Test List 1	2	[{"changed": {"fields": ["isActive"]}}]	27	1
341	2017-03-04 14:26:05.309147+03	1	dyanikoglu:Test List 1	2	[{"changed": {"fields": ["isActive"]}}]	27	1
342	2017-03-04 14:29:32.85599+03	1	dyanikoglu:Test List 1	2	[{"changed": {"fields": ["isActive"]}}]	27	1
343	2017-03-04 14:29:36.052584+03	2	dyanikoglu:Test List 2	2	[{"changed": {"fields": ["isActive"]}}]	27	1
344	2017-03-04 16:36:34.459229+03	7	Shopping List 3	1	[{"added": {}}]	18	1
345	2017-03-04 16:36:44.692646+03	3	dyanikoglu:Shopping List 3	1	[{"added": {}}]	27	1
346	2017-03-04 16:36:57.089934+03	9	Shopping List 3:Pınar	1	[{"added": {}}]	19	1
347	2017-03-04 16:37:07.003298+03	10	Shopping List 3:Cucumber	1	[{"added": {}}]	19	1
348	2017-03-04 17:01:31.491281+03	2	tozyer	2	[{"changed": {"fields": ["password"]}}]	17	1
349	2017-03-04 17:02:02.812565+03	4	tozyer:Test List 1	1	[{"added": {}}]	27	1
350	2017-03-04 22:40:29.478857+03	1	dyanikoglu	2	[]	17	1
351	2017-03-06 12:27:04.883419+03	1	dyanikoglu	2	[{"changed": {"fields": ["activeList"]}}]	17	1
352	2017-03-06 12:27:18.737665+03	2	tozyer	2	[{"changed": {"fields": ["activeList"]}}]	17	1
353	2017-03-06 13:01:03.144444+03	1	dyanikoglu	2	[{"changed": {"fields": ["activeList"]}}]	17	1
354	2017-03-06 14:18:20.326448+03	18	Test List 1:Pınar	3		19	1
355	2017-03-06 14:27:09.647404+03	22	Test List 2:Cucumber	3		19	1
356	2017-03-06 14:29:28.93009+03	23	Shopping List 3:Cucumber	3		19	1
357	2017-03-06 14:33:47.042506+03	25	Test List 1:Cucumber	3		19	1
358	2017-03-06 14:35:06.698891+03	26	Test List 2:Watermelon	3		19	1
359	2017-03-06 14:36:18.920574+03	28	Shopping List 3:Watermelon	3		19	1
360	2017-03-06 14:38:15.093807+03	30	Shopping List 3:Watermelon	3		19	1
361	2017-03-06 14:48:24.280875+03	31	Shopping List 3:Cucumber	3		19	1
362	2017-03-06 14:50:27.445796+03	32	Test List 2:Cucumber	3		19	1
363	2017-03-06 14:54:14.268782+03	5	tozyer:Test List 2	1	[{"added": {}}]	27	1
364	2017-03-06 14:54:18.892424+03	6	tozyer:Shopping List 3	1	[{"added": {}}]	27	1
365	2017-03-06 15:02:20.601651+03	57	Test List 2:Apple	3		19	1
366	2017-03-06 15:15:37.058037+03	63	Test List 2:Apple	3		19	1
367	2017-03-06 15:16:20.375455+03	65	Test List 2:Watermelon	3		19	1
368	2017-03-06 15:18:00.348047+03	67	Test List 2:Tomato	3		19	1
369	2017-03-06 15:18:00.352128+03	66	Test List 2:Cucumber	3		19	1
370	2017-03-06 15:27:56.410236+03	70	Test List 2:Tomato	3		19	1
371	2017-03-06 15:27:56.422185+03	69	Test List 2:Watermelon	3		19	1
372	2017-03-06 15:27:56.42573+03	68	Test List 2:Cucumber	3		19	1
373	2017-03-06 15:38:50.367302+03	91	Test List 1:Fanta	3		19	1
374	2017-03-06 15:38:50.373727+03	89	Test List 1:Coca-Cola	3		19	1
375	2017-03-06 15:48:51.414399+03	107	Test List 1:Coca-Cola	3		19	1
376	2017-03-06 15:48:51.420534+03	106	Test List 2:Coca-Cola	3		19	1
377	2017-03-06 15:50:12.290303+03	109	Test List 2:Coca-Cola	3		19	1
378	2017-03-06 16:03:38.869564+03	119	Test List 2:Apple	3		19	1
379	2017-03-06 16:08:42.264417+03	124	Test List 2:Watermelon	3		19	1
380	2017-03-06 16:08:42.270909+03	123	Test List 2:Apple	3		19	1
381	2017-03-06 16:08:42.273918+03	122	Test List 2:Apple	3		19	1
382	2017-03-06 16:19:38.776108+03	136	Test List 2:Pınar	3		19	1
383	2017-03-06 16:19:38.782299+03	135	Test List 2:Tomato	3		19	1
384	2017-03-06 16:19:38.78591+03	134	Test List 2:Watermelon	3		19	1
385	2017-03-06 16:19:38.789028+03	132	Shopping List 3:Fanta	3		19	1
386	2017-03-06 16:22:14.968475+03	140	Test List 2:Coca-Cola	3		19	1
387	2017-03-06 16:24:06.528549+03	149	Test List 2:Tomato	3		19	1
388	2017-03-06 16:24:06.533569+03	148	Test List 2:Cucumber	3		19	1
389	2017-03-06 16:24:06.536838+03	147	Test List 2:Watermelon	3		19	1
390	2017-03-16 14:51:50.648527+03	6	Gordion AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
391	2017-03-16 14:52:39.590904+03	7	Kentpark AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
392	2017-03-17 01:05:16.499852+03	8	Atlantis AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
393	2017-03-17 01:05:43.446604+03	9	Gordion AVM | Fanta  1L	1	[{"added": {}}]	15	1
394	2017-03-17 01:05:52.434387+03	10	Kentpark AVM | Fanta  1L	1	[{"added": {}}]	15	1
395	2017-03-17 01:06:03.069023+03	11	Atlantis AVM | Fanta  1L	1	[{"added": {}}]	15	1
396	2017-03-17 01:06:14.590509+03	12	Gordion AVM | Fanta  1 Cans	1	[{"added": {}}]	15	1
397	2017-03-17 01:06:22.697143+03	13	Kentpark AVM | Fanta  1 Cans	1	[{"added": {}}]	15	1
398	2017-03-17 01:06:29.230727+03	14	Atlantis AVM | Fanta  1 Cans	1	[{"added": {}}]	15	1
399	2017-03-17 01:06:44.997199+03	15	Gordion AVM | Pınar Milk 1L	1	[{"added": {}}]	15	1
400	2017-03-17 01:07:02.792551+03	15	Gordion AVM | Pınar Milk 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
401	2017-03-17 01:07:10.857649+03	16	Kentpark AVM | Pınar Milk 1L	1	[{"added": {}}]	15	1
402	2017-03-17 01:07:18.146457+03	17	Atlantis AVM | Pınar Milk 1L	1	[{"added": {}}]	15	1
403	2017-03-17 01:07:28.059453+03	18	Gordion AVM | Sütaş Pasteurized Milk 1L	1	[{"added": {}}]	15	1
404	2017-03-17 01:07:37.17515+03	19	Kentpark AVM | Sütaş Pasteurized Milk 1L	1	[{"added": {}}]	15	1
405	2017-03-17 01:07:43.204118+03	20	Atlantis AVM | Sütaş Pasteurized Milk 1L	1	[{"added": {}}]	15	1
406	2017-03-17 01:07:55.864402+03	21	Gordion AVM | Apple Green 1KG	1	[{"added": {}}]	15	1
407	2017-03-17 01:08:02.296642+03	22	Kentpark AVM | Apple Green 1KG	1	[{"added": {}}]	15	1
408	2017-03-17 01:08:10.808078+03	23	Atlantis AVM | Apple Green 1KG	1	[{"added": {}}]	15	1
409	2017-03-17 01:08:34.094725+03	24	Gordion AVM | Watermelon  1KG	1	[{"added": {}}]	15	1
410	2017-03-17 01:08:40.416489+03	25	Kentpark AVM | Watermelon  1KG	1	[{"added": {}}]	15	1
411	2017-03-17 01:08:46.647699+03	26	Atlantis AVM | Watermelon  1KG	1	[{"added": {}}]	15	1
412	2017-03-17 01:10:10.690475+03	27	Gordion AVM | Pınar Pasteurized Milk 1L	1	[{"added": {}}]	15	1
413	2017-03-17 01:10:17.821724+03	28	Kentpark AVM | Pınar Pasteurized Milk 1L	1	[{"added": {}}]	15	1
414	2017-03-17 01:10:26.652038+03	29	Atlantis AVM | Pınar Pasteurized Milk 1L	1	[{"added": {}}]	15	1
415	2017-03-20 17:40:10.262405+03	30	Cepa AVM | Fanta  1L	1	[{"added": {}}]	15	1
416	2017-03-20 17:40:20.716145+03	13	Kentpark AVM | Fanta  1 Cans	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
417	2017-03-20 17:52:13.362656+03	10	Kentpark AVM | Fanta  1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
418	2017-03-20 17:52:18.073462+03	9	Gordion AVM | Fanta  1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
419	2017-03-20 18:04:15.638871+03	27	Gordion AVM | Pınar Pasteurized Milk 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
420	2017-03-21 12:56:56.933764+03	31	Arcadium AVM | Cucumber  1KG	1	[{"added": {}}]	15	1
421	2017-03-21 12:57:38.518282+03	31	Arcadium AVM | Cucumber  1KG	3		15	1
422	2017-03-21 12:57:46.19+03	32	Cepa AVM | Cucumber  1KG	1	[{"added": {}}]	15	1
423	2017-03-21 13:06:40.749863+03	32	Cepa AVM | Cucumber  1KG	3		15	1
424	2017-03-21 13:15:57.389312+03	30	Cepa AVM | Fanta  1L	3		15	1
425	2017-03-21 13:15:57.397996+03	29	Atlantis AVM | Pınar Pasteurized Milk 1L	3		15	1
426	2017-03-21 13:15:57.403932+03	28	Kentpark AVM | Pınar Pasteurized Milk 1L	3		15	1
427	2017-03-21 13:15:57.409794+03	27	Gordion AVM | Pınar Pasteurized Milk 1L	3		15	1
428	2017-03-21 13:15:57.415617+03	26	Atlantis AVM | Watermelon  1KG	3		15	1
429	2017-03-21 13:15:57.42143+03	25	Kentpark AVM | Watermelon  1KG	3		15	1
430	2017-03-21 13:15:57.427901+03	24	Gordion AVM | Watermelon  1KG	3		15	1
431	2017-03-21 13:15:57.43441+03	23	Atlantis AVM | Apple Green 1KG	3		15	1
432	2017-03-21 13:15:57.440275+03	22	Kentpark AVM | Apple Green 1KG	3		15	1
433	2017-03-21 13:15:57.446155+03	21	Gordion AVM | Apple Green 1KG	3		15	1
434	2017-03-21 13:15:57.452043+03	20	Atlantis AVM | Sütaş Pasteurized Milk 1L	3		15	1
435	2017-03-21 13:15:57.457944+03	19	Kentpark AVM | Sütaş Pasteurized Milk 1L	3		15	1
436	2017-03-21 13:15:57.464315+03	18	Gordion AVM | Sütaş Pasteurized Milk 1L	3		15	1
437	2017-03-21 13:15:57.469063+03	17	Atlantis AVM | Pınar Milk 1L	3		15	1
438	2017-03-21 13:15:57.474051+03	16	Kentpark AVM | Pınar Milk 1L	3		15	1
439	2017-03-21 13:15:57.479112+03	15	Gordion AVM | Pınar Milk 1L	3		15	1
440	2017-03-21 13:15:57.48479+03	14	Atlantis AVM | Fanta  1 Cans	3		15	1
441	2017-03-21 13:15:57.48944+03	13	Kentpark AVM | Fanta  1 Cans	3		15	1
442	2017-03-21 13:15:57.494396+03	12	Gordion AVM | Fanta  1 Cans	3		15	1
443	2017-03-21 13:15:57.499911+03	11	Atlantis AVM | Fanta  1L	3		15	1
444	2017-03-21 13:15:57.504783+03	10	Kentpark AVM | Fanta  1L	3		15	1
445	2017-03-21 13:15:57.510018+03	9	Gordion AVM | Fanta  1L	3		15	1
446	2017-03-21 13:15:57.515174+03	8	Atlantis AVM | Coca-Cola Zero 1L	3		15	1
447	2017-03-21 13:15:57.520894+03	7	Kentpark AVM | Coca-Cola Zero 1L	3		15	1
448	2017-03-21 13:15:57.526555+03	6	Gordion AVM | Coca-Cola Zero 1L	3		15	1
449	2017-03-21 13:32:57.810168+03	25	Bakkal	3		10	1
450	2017-03-21 13:32:57.81561+03	22	Yunus Market	3		10	1
451	2017-03-21 13:33:16.523329+03	8	Arcadium AVM	3		10	1
452	2017-03-21 13:33:21.922785+03	19	Next Level	3		10	1
157	2017-02-14 02:02:06.984547+03	1	Test Profile 1	1	[{"added": {}}]	\N	1
159	2017-02-14 02:02:16.401105+03	3	Test Profile 3	1	[{"added": {}}]	\N	1
158	2017-02-14 02:02:11.903877+03	2	Test Profile 2	1	[{"added": {}}]	\N	1
162	2017-02-14 02:05:16.478444+03	5	tozyer:Test Profile 3	1	[{"added": {}}]	\N	1
453	2017-03-21 13:59:44.867671+03	1	Home	1	[{"added": {}}]	28	1
454	2017-03-21 14:04:49.397013+03	1	dyanikoglu:Home	3		28	1
455	2017-03-21 14:04:59.943188+03	2	dyanikoglu:Home	1	[{"added": {}}]	28	1
456	2017-03-21 14:14:28.311515+03	33	Atlantis AVM | Watermelon  1KG	1	[{"added": {}}]	15	1
457	2017-03-21 14:14:39.235389+03	34	Kentpark AVM | Watermelon  1KG	1	[{"added": {}}]	15	1
458	2017-03-21 14:14:49.868241+03	35	Armada AVM | Watermelon  1KG	1	[{"added": {}}]	15	1
459	2017-03-21 14:14:58.274229+03	35	Cepa AVM | Watermelon  1KG	2	[{"changed": {"fields": ["retailer"]}}]	15	1
460	2017-03-21 14:15:52.499875+03	36	Atlantis AVM | Pınar Milk 1L	1	[{"added": {}}]	15	1
461	2017-03-21 14:16:04.684557+03	37	Cepa AVM | Pınar Milk 1L	1	[{"added": {}}]	15	1
462	2017-03-21 14:16:15.059145+03	38	Kentpark AVM | Pınar Milk 1L	1	[{"added": {}}]	15	1
463	2017-03-21 14:16:19.810783+03	36	Atlantis AVM | Pınar Milk 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
464	2017-03-21 14:16:39.65936+03	39	Atlantis AVM | Fanta  1L	1	[{"added": {}}]	15	1
465	2017-03-21 14:16:45.674479+03	40	Kentpark AVM | Fanta  1L	1	[{"added": {}}]	15	1
466	2017-03-21 14:16:52.064933+03	41	Cepa AVM | Fanta  1L	1	[{"added": {}}]	15	1
467	2017-03-21 16:21:11.130564+03	34	Kentpark AVM | Watermelon  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
468	2017-03-21 16:22:29.750455+03	34	Kentpark AVM | Watermelon  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
469	2017-03-21 16:22:47.317761+03	35	Cepa AVM | Watermelon  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
470	2017-03-21 16:24:01.900299+03	37	Cepa AVM | Pınar Milk 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
471	2017-03-21 16:25:21.486594+03	38	Kentpark AVM | Pınar Milk 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
472	2017-03-22 16:08:14.88598+03	3	dyanikoglu:Work	1	[{"added": {}}]	28	1
473	2017-04-07 23:06:41.847579+03	35	Cepa AVM | Watermelon  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
474	2017-04-07 23:07:43.31793+03	38	Kentpark AVM | Pınar Milk 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
475	2017-04-14 02:02:31.921753+03	1	dyanikoglu's Preferences	1	[{"added": {}}]	29	1
476	2017-04-14 02:02:38.251413+03	2	tozyer's Preferences	1	[{"added": {}}]	29	1
477	2017-04-14 02:23:35.018055+03	1	dyanikoglu	2	[{"changed": {"fields": ["preferences"]}}]	17	1
478	2017-04-14 02:23:43.765664+03	2	tozyer	2	[{"changed": {"fields": ["preferences"]}}]	17	1
479	2017-04-15 00:29:35.092273+03	1	UserPreferences object	2	[{"changed": {"fields": ["search_radius"]}}]	29	1
480	2017-04-15 00:29:45.516465+03	1	UserPreferences object	2	[{"changed": {"fields": ["market_factor"]}}]	29	1
481	2017-04-15 00:34:22.143717+03	1	UserPreferences object	2	[{"changed": {"fields": ["market_factor", "search_radius"]}}]	29	1
482	2017-04-24 14:27:02.173775+03	41	Cepa AVM | Fanta  1L	3		15	1
483	2017-04-24 14:27:02.183129+03	40	Kentpark AVM | Fanta  1L	3		15	1
484	2017-04-24 14:27:02.194703+03	39	Atlantis AVM | Fanta  1L	3		15	1
485	2017-04-24 14:27:02.199986+03	38	Kentpark AVM | Pınar Milk 1L	3		15	1
486	2017-04-24 14:27:02.204816+03	37	Cepa AVM | Pınar Milk 1L	3		15	1
487	2017-04-24 14:27:02.209933+03	36	Atlantis AVM | Pınar Milk 1L	3		15	1
488	2017-04-24 14:27:02.215197+03	35	Cepa AVM | Watermelon  1KG	3		15	1
489	2017-04-24 14:27:02.220167+03	34	Kentpark AVM | Watermelon  1KG	3		15	1
490	2017-04-24 14:27:02.225281+03	33	Atlantis AVM | Watermelon  1KG	3		15	1
491	2017-04-24 14:27:23.325826+03	42	Gordion AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
492	2017-04-24 14:27:32.424139+03	43	Kentpark AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
493	2017-04-24 14:27:43.895816+03	44	Atlantis AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
494	2017-04-24 14:27:58.971211+03	45	Ankamall AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
495	2017-04-24 14:28:08.044907+03	46	Armada AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
496	2017-04-24 14:28:24.685163+03	47	Cepa AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
497	2017-04-24 14:29:57.083458+03	47	Cepa AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
498	2017-04-24 14:30:09.7494+03	47	Cepa AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
499	2017-04-24 14:30:15.023683+03	46	Armada AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
500	2017-04-24 14:30:21.549005+03	45	Ankamall AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
501	2017-04-24 14:30:27.218285+03	44	Atlantis AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
502	2017-04-24 14:30:33.486855+03	43	Kentpark AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
503	2017-04-24 14:30:38.300567+03	42	Gordion AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
504	2017-04-24 14:30:41.864252+03	43	Kentpark AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
505	2017-04-24 14:30:53.424053+03	48	Kızılay AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
506	2017-04-24 14:31:05.139513+03	49	Panora AVM | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
507	2017-04-24 15:13:58.620693+03	50	Gordion AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
508	2017-04-24 15:14:08.375096+03	51	Kentpark AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
509	2017-04-24 15:14:19.157231+03	52	Atlantis AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
510	2017-04-24 15:14:30.41208+03	53	Ankamall AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
511	2017-04-24 15:14:44.101476+03	54	Ankamall AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
512	2017-04-24 15:14:55.061131+03	55	Armada AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
513	2017-04-24 15:15:05.576686+03	56	Cepa AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
514	2017-04-24 15:15:14.216692+03	57	Kızılay AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
515	2017-04-24 15:15:23.075875+03	58	Panora AVM | Apple Red 1KG	1	[{"added": {}}]	15	1
516	2017-04-24 15:17:51.612676+03	53	Ankamall AVM | Apple Red 1KG	3		15	1
517	2017-04-24 15:19:03.416598+03	59	Gordion AVM | Tomato  1KG	1	[{"added": {}}]	15	1
518	2017-04-24 15:19:11.312709+03	60	Kentpark AVM | Tomato  1KG	1	[{"added": {}}]	15	1
519	2017-04-24 15:22:28.122033+03	61	Atlantis AVM | Tomato  1KG	1	[{"added": {}}]	15	1
520	2017-04-24 15:22:36.759384+03	62	Ankamall AVM | Tomato  1KG	1	[{"added": {}}]	15	1
521	2017-04-24 15:22:46.4158+03	63	Armada AVM | Tomato  1KG	1	[{"added": {}}]	15	1
522	2017-04-24 15:23:00.151971+03	64	Cepa AVM | Tomato  1KG	1	[{"added": {}}]	15	1
523	2017-04-24 15:23:12.086126+03	65	Kızılay AVM | Tomato  1KG	1	[{"added": {}}]	15	1
524	2017-04-24 15:23:22.877039+03	66	Panora AVM | Tomato  1KG	1	[{"added": {}}]	15	1
525	2017-04-24 23:21:11.47392+03	7	Test List 3	2	[{"changed": {"fields": ["listName"]}}]	18	1
526	2017-04-25 00:35:30.569433+03	1	UserPreferences object	2	[{"changed": {"fields": ["route_start_point", "route_end_point"]}}]	29	1
527	2017-04-25 01:17:09.51475+03	None	Test Retailer (Far Away)	1	[{"added": {}}]	10	1
528	2017-04-25 01:18:27.550819+03	None	Test Retailer (Far Away)	1	[{"added": {}}]	10	1
529	2017-04-25 01:18:50.819283+03	None	Test Retailer (Far Away)	1	[{"added": {}}]	10	1
530	2017-04-25 01:19:10.689263+03	26	Nata Vega	1	[{"added": {}}]	10	1
531	2017-04-25 01:19:19.701166+03	26	Nata Vega	3		10	1
532	2017-04-25 01:19:36.738742+03	None	Test Retailer (Far Away)	1	[{"added": {}}]	10	1
533	2017-04-25 01:19:50.269403+03	27	Test Retailer (Far Away)	1	[{"added": {}}]	10	1
534	2017-04-25 01:20:17.868519+03	67	Test Retailer (Far Away) | Tomato  1KG	1	[{"added": {}}]	15	1
535	2017-04-25 01:22:10.782716+03	67	Test Retailer (Far Away) | Tomato  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
536	2017-04-25 02:20:39.92897+03	27	Test Retailer (Far Away)	3		10	1
537	2017-04-26 00:46:09.139423+03	28	Test Retailer (Far Away)	1	[{"added": {}}]	10	1
538	2017-04-26 00:49:26.215195+03	68	Test Retailer (Far Away) | Tomato  1KG	1	[{"added": {}}]	15	1
539	2017-04-26 00:57:48.069013+03	69	Test Retailer (Far Away) | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
540	2017-04-26 00:58:01.888018+03	70	Test Retailer (Far Away) | Apple Red 1KG	1	[{"added": {}}]	15	1
541	2017-04-26 01:03:45.54452+03	70	Test Retailer (Far Away) | Apple Red 1KG	3		15	1
542	2017-04-26 01:03:45.55382+03	69	Test Retailer (Far Away) | Coca-Cola Zero 1L	3		15	1
543	2017-04-26 01:03:45.560041+03	68	Test Retailer (Far Away) | Tomato  1KG	3		15	1
544	2017-04-26 01:03:58.296731+03	49	Panora AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
545	2017-04-26 01:04:03.47548+03	66	Panora AVM | Tomato  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
546	2017-04-26 01:04:09.71276+03	58	Panora AVM | Apple Red 1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
547	2017-04-26 01:08:58.626009+03	66	Panora AVM | Tomato  1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
548	2017-04-26 01:09:04.846788+03	58	Panora AVM | Apple Red 1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
549	2017-04-26 01:09:11.828805+03	49	Panora AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
550	2017-04-26 01:09:21.24233+03	28	Test Retailer (Far Away)	3		10	1
551	2017-04-26 01:09:34.148981+03	29	Nata Vega	1	[{"added": {}}]	10	1
552	2017-04-26 01:09:53.382593+03	71	Nata Vega | Tomato  1KG	1	[{"added": {}}]	15	1
553	2017-04-26 01:10:14.684619+03	72	Nata Vega | Coca-Cola Zero 1L	1	[{"added": {}}]	15	1
554	2017-04-26 01:10:25.840209+03	73	Nata Vega | Apple Red 1KG	1	[{"added": {}}]	15	1
555	2017-04-26 01:11:44.939352+03	58	Panora AVM | Apple Red 1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
556	2017-04-26 01:12:10.271983+03	58	Panora AVM | Apple Red 1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
557	2017-04-26 01:14:29.092811+03	73	Nata Vega | Apple Red 1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
558	2017-04-26 01:14:34.841884+03	72	Nata Vega | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
559	2017-04-26 01:19:18.449125+03	30	Arcadium AVM	1	[{"added": {}}]	10	1
560	2017-04-26 01:19:35.962249+03	73	Arcadium AVM | Apple Red 1KG	2	[{"changed": {"fields": ["retailer"]}}]	15	1
561	2017-04-26 01:19:40.817173+03	72	Arcadium AVM | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["retailer"]}}]	15	1
562	2017-04-26 01:19:45.841195+03	71	Arcadium AVM | Tomato  1KG	2	[{"changed": {"fields": ["retailer"]}}]	15	1
563	2017-04-26 01:57:56.563691+03	73	Nata Vega | Apple Red 1KG	2	[{"changed": {"fields": ["retailer"]}}]	15	1
564	2017-04-26 01:58:01.505854+03	72	Nata Vega | Coca-Cola Zero 1L	2	[{"changed": {"fields": ["retailer"]}}]	15	1
565	2017-04-26 01:58:05.236885+03	71	Nata Vega | Tomato  1KG	2	[{"changed": {"fields": ["retailer"]}}]	15	1
566	2017-04-26 02:00:32.362762+03	73	Nata Vega | Apple Red 1KG	2	[{"changed": {"fields": ["unitPrice"]}}]	15	1
567	2017-05-05 08:26:22.966257+03	73	Nata Vega | Apple Red 1KG	3		15	1
568	2017-05-05 08:26:22.976954+03	72	Nata Vega | Coca-Cola Zero 1L	3		15	1
569	2017-05-05 08:26:22.98968+03	71	Nata Vega | Tomato  1KG	3		15	1
570	2017-05-05 08:26:22.994822+03	66	Panora AVM | Tomato  1KG	3		15	1
571	2017-05-05 08:26:22.999931+03	65	Kızılay AVM | Tomato  1KG	3		15	1
572	2017-05-05 08:26:23.005519+03	64	Cepa AVM | Tomato  1KG	3		15	1
573	2017-05-05 08:26:23.019841+03	63	Armada AVM | Tomato  1KG	3		15	1
574	2017-05-05 08:26:23.025033+03	62	Ankamall AVM | Tomato  1KG	3		15	1
575	2017-05-05 08:26:23.030665+03	61	Atlantis AVM | Tomato  1KG	3		15	1
576	2017-05-05 08:26:23.036818+03	60	Kentpark AVM | Tomato  1KG	3		15	1
577	2017-05-05 08:26:23.04272+03	59	Gordion AVM | Tomato  1KG	3		15	1
578	2017-05-05 08:26:23.048647+03	58	Panora AVM | Apple Red 1KG	3		15	1
579	2017-05-05 08:26:23.062024+03	57	Kızılay AVM | Apple Red 1KG	3		15	1
580	2017-05-05 08:26:23.068024+03	56	Cepa AVM | Apple Red 1KG	3		15	1
581	2017-05-05 08:26:23.075019+03	55	Armada AVM | Apple Red 1KG	3		15	1
582	2017-05-05 08:26:23.081037+03	54	Ankamall AVM | Apple Red 1KG	3		15	1
583	2017-05-05 08:26:23.08748+03	52	Atlantis AVM | Apple Red 1KG	3		15	1
584	2017-05-05 08:26:23.092753+03	51	Kentpark AVM | Apple Red 1KG	3		15	1
585	2017-05-05 08:26:23.097687+03	50	Gordion AVM | Apple Red 1KG	3		15	1
586	2017-05-05 08:26:23.102843+03	49	Panora AVM | Coca-Cola Zero 1L	3		15	1
587	2017-05-05 08:26:23.108781+03	48	Kızılay AVM | Coca-Cola Zero 1L	3		15	1
588	2017-05-05 08:26:23.11407+03	47	Cepa AVM | Coca-Cola Zero 1L	3		15	1
589	2017-05-05 08:26:23.119392+03	46	Armada AVM | Coca-Cola Zero 1L	3		15	1
590	2017-05-05 08:26:23.125233+03	45	Ankamall AVM | Coca-Cola Zero 1L	3		15	1
591	2017-05-05 08:26:23.138395+03	44	Atlantis AVM | Coca-Cola Zero 1L	3		15	1
592	2017-05-05 08:26:23.143856+03	43	Kentpark AVM | Coca-Cola Zero 1L	3		15	1
593	2017-05-05 08:26:23.148758+03	42	Gordion AVM | Coca-Cola Zero 1L	3		15	1
594	2017-05-09 10:39:55.087479+03	25	Long-Lasting Milk	2	[{"changed": {"fields": ["parent"]}}]	13	1
595	2017-05-09 10:40:04.503948+03	10	Milk	2	[{"changed": {"fields": ["parent"]}}]	13	1
596	2017-05-09 10:40:14.430732+03	25	Long-Lasting Milk	3		13	1
597	2017-05-09 10:40:14.43663+03	24	Pasteurized Milk	3		13	1
598	2017-05-09 10:40:14.44024+03	23	Soda	3		13	1
599	2017-05-09 10:40:14.443493+03	22	Yellow Cheese	3		13	1
600	2017-05-09 10:40:14.446807+03	21	White Cheese	3		13	1
601	2017-05-09 10:40:14.44988+03	20	Icecream & Milky Desserts	3		13	1
602	2017-05-09 10:40:14.452804+03	19	Olive	3		13	1
603	2017-05-09 10:40:14.455615+03	18	Egg	3		13	1
604	2017-05-09 10:40:14.458891+03	17	Butter	3		13	1
605	2017-05-09 10:40:14.462341+03	16	Yogurt	3		13	1
606	2017-05-09 10:40:14.465383+03	15	Vegetables	3		13	1
607	2017-05-09 10:40:14.468435+03	14	Fruits	3		13	1
608	2017-05-09 10:40:14.471564+03	12	For Breakfast	3		13	1
609	2017-05-09 10:40:14.481783+03	11	Cheese	3		13	1
610	2017-05-09 10:40:14.484764+03	10	Milk	3		13	1
611	2017-05-09 10:40:14.487626+03	9	Furnitures & Other House Products	3		13	1
612	2017-05-09 10:40:14.490651+03	8	Baby Products & Toys	3		13	1
613	2017-05-09 10:40:14.493875+03	7	Cosmetic	3		13	1
614	2017-05-09 10:40:14.497094+03	6	Cleaning Products	3		13	1
615	2017-05-09 10:40:14.500074+03	5	Beverage	3		13	1
616	2017-05-09 10:40:14.50302+03	4	Nutrition & Confectionary	3		13	1
617	2017-05-09 10:40:14.505917+03	3	Milk & Breakfast	3		13	1
618	2017-05-09 10:40:14.508856+03	2	Meat & Fish	3		13	1
619	2017-05-09 10:40:14.512434+03	1	Fruits & Vegetables	3		13	1
620	2017-05-09 10:40:26.610423+03	183	Panora AVM | Tomato  1KG	3		15	1
621	2017-05-09 10:40:26.619592+03	182	Panora AVM | Cucumber  1KG	3		15	1
622	2017-05-09 10:40:26.633317+03	181	Panora AVM | Watermelon  1KG	3		15	1
623	2017-05-09 10:40:26.639425+03	180	Panora AVM | Apple Red 1KG	3		15	1
624	2017-05-09 10:40:26.645973+03	179	Panora AVM | Apple Green 1KG	3		15	1
625	2017-05-09 10:40:26.651466+03	178	Panora AVM | Pınar Pasteurized Milk 1L	3		15	1
626	2017-05-09 10:40:26.657358+03	177	Panora AVM | Sütaş Pasteurized Milk 1L	3		15	1
627	2017-05-09 10:40:26.663677+03	176	Panora AVM | Pınar Milk 1L	3		15	1
628	2017-05-09 10:40:26.668821+03	175	Panora AVM | Fanta  1 Cans	3		15	1
629	2017-05-09 10:40:26.674945+03	174	Panora AVM | Fanta  1L	3		15	1
630	2017-05-09 10:40:26.681431+03	173	Panora AVM | Coca-Cola Zero 1L	3		15	1
631	2017-05-09 10:40:26.68698+03	172	Kızılay AVM | Tomato  1KG	3		15	1
632	2017-05-09 10:40:26.693113+03	171	Kızılay AVM | Cucumber  1KG	3		15	1
633	2017-05-09 10:40:26.699004+03	170	Kızılay AVM | Watermelon  1KG	3		15	1
634	2017-05-09 10:40:26.704813+03	169	Kızılay AVM | Apple Red 1KG	3		15	1
635	2017-05-09 10:40:26.711196+03	168	Kızılay AVM | Apple Green 1KG	3		15	1
636	2017-05-09 10:40:26.716958+03	167	Kızılay AVM | Pınar Pasteurized Milk 1L	3		15	1
637	2017-05-09 10:40:26.722871+03	166	Kızılay AVM | Sütaş Pasteurized Milk 1L	3		15	1
638	2017-05-09 10:40:26.730083+03	165	Kızılay AVM | Pınar Milk 1L	3		15	1
639	2017-05-09 10:40:26.735669+03	164	Kızılay AVM | Fanta  1 Cans	3		15	1
640	2017-05-09 10:40:26.741993+03	163	Kızılay AVM | Fanta  1L	3		15	1
641	2017-05-09 10:40:26.746897+03	162	Kızılay AVM | Coca-Cola Zero 1L	3		15	1
642	2017-05-09 10:40:26.752117+03	161	Cepa AVM | Tomato  1KG	3		15	1
643	2017-05-09 10:40:26.765713+03	160	Cepa AVM | Cucumber  1KG	3		15	1
644	2017-05-09 10:40:26.770866+03	159	Cepa AVM | Watermelon  1KG	3		15	1
645	2017-05-09 10:40:26.777286+03	158	Cepa AVM | Apple Red 1KG	3		15	1
646	2017-05-09 10:40:26.782609+03	157	Cepa AVM | Apple Green 1KG	3		15	1
647	2017-05-09 10:40:26.788234+03	156	Cepa AVM | Pınar Pasteurized Milk 1L	3		15	1
648	2017-05-09 10:40:26.795298+03	155	Cepa AVM | Sütaş Pasteurized Milk 1L	3		15	1
649	2017-05-09 10:40:26.801538+03	154	Cepa AVM | Pınar Milk 1L	3		15	1
650	2017-05-09 10:40:26.80818+03	153	Cepa AVM | Fanta  1 Cans	3		15	1
651	2017-05-09 10:40:26.814576+03	152	Cepa AVM | Fanta  1L	3		15	1
652	2017-05-09 10:40:26.820263+03	151	Cepa AVM | Coca-Cola Zero 1L	3		15	1
653	2017-05-09 10:40:26.826633+03	150	Armada AVM | Tomato  1KG	3		15	1
654	2017-05-09 10:40:26.834139+03	149	Armada AVM | Cucumber  1KG	3		15	1
655	2017-05-09 10:40:26.83914+03	148	Armada AVM | Watermelon  1KG	3		15	1
656	2017-05-09 10:40:26.845608+03	147	Armada AVM | Apple Red 1KG	3		15	1
657	2017-05-09 10:40:26.850751+03	146	Armada AVM | Apple Green 1KG	3		15	1
658	2017-05-09 10:40:26.85632+03	145	Armada AVM | Pınar Pasteurized Milk 1L	3		15	1
659	2017-05-09 10:40:26.869167+03	144	Armada AVM | Sütaş Pasteurized Milk 1L	3		15	1
660	2017-05-09 10:40:26.876647+03	143	Armada AVM | Pınar Milk 1L	3		15	1
661	2017-05-09 10:40:26.883224+03	142	Armada AVM | Fanta  1 Cans	3		15	1
662	2017-05-09 10:40:26.898643+03	141	Armada AVM | Fanta  1L	3		15	1
663	2017-05-09 10:40:26.905018+03	140	Armada AVM | Coca-Cola Zero 1L	3		15	1
664	2017-05-09 10:40:26.911303+03	139	Arcadium AVM | Tomato  1KG	3		15	1
665	2017-05-09 10:40:26.916215+03	138	Arcadium AVM | Cucumber  1KG	3		15	1
666	2017-05-09 10:40:26.921012+03	137	Arcadium AVM | Watermelon  1KG	3		15	1
667	2017-05-09 10:40:26.926688+03	136	Arcadium AVM | Apple Red 1KG	3		15	1
668	2017-05-09 10:40:26.938631+03	135	Arcadium AVM | Apple Green 1KG	3		15	1
669	2017-05-09 10:40:26.946141+03	134	Arcadium AVM | Pınar Pasteurized Milk 1L	3		15	1
670	2017-05-09 10:40:26.951853+03	133	Arcadium AVM | Sütaş Pasteurized Milk 1L	3		15	1
671	2017-05-09 10:40:26.968903+03	132	Arcadium AVM | Pınar Milk 1L	3		15	1
672	2017-05-09 10:40:26.977372+03	131	Arcadium AVM | Fanta  1 Cans	3		15	1
673	2017-05-09 10:40:26.984072+03	130	Arcadium AVM | Fanta  1L	3		15	1
674	2017-05-09 10:40:26.989859+03	129	Arcadium AVM | Coca-Cola Zero 1L	3		15	1
675	2017-05-09 10:40:26.995865+03	128	Nata Vega | Tomato  1KG	3		15	1
676	2017-05-09 10:40:27.001176+03	127	Nata Vega | Cucumber  1KG	3		15	1
677	2017-05-09 10:40:27.007563+03	126	Nata Vega | Watermelon  1KG	3		15	1
678	2017-05-09 10:40:27.013528+03	125	Nata Vega | Apple Red 1KG	3		15	1
679	2017-05-09 10:40:27.019469+03	124	Nata Vega | Apple Green 1KG	3		15	1
680	2017-05-09 10:40:27.02573+03	123	Nata Vega | Pınar Pasteurized Milk 1L	3		15	1
681	2017-05-09 10:40:27.031861+03	122	Nata Vega | Sütaş Pasteurized Milk 1L	3		15	1
682	2017-05-09 10:40:27.037061+03	121	Nata Vega | Pınar Milk 1L	3		15	1
683	2017-05-09 10:40:27.04272+03	120	Nata Vega | Fanta  1 Cans	3		15	1
684	2017-05-09 10:40:27.048971+03	119	Nata Vega | Fanta  1L	3		15	1
685	2017-05-09 10:40:27.054836+03	118	Nata Vega | Coca-Cola Zero 1L	3		15	1
686	2017-05-09 10:40:27.06116+03	117	Ankamall AVM | Tomato  1KG	3		15	1
687	2017-05-09 10:40:27.066273+03	116	Ankamall AVM | Cucumber  1KG	3		15	1
688	2017-05-09 10:40:27.071943+03	115	Ankamall AVM | Watermelon  1KG	3		15	1
689	2017-05-09 10:40:27.079193+03	114	Ankamall AVM | Apple Red 1KG	3		15	1
690	2017-05-09 10:40:27.084651+03	113	Ankamall AVM | Apple Green 1KG	3		15	1
691	2017-05-09 10:40:27.098399+03	112	Ankamall AVM | Pınar Pasteurized Milk 1L	3		15	1
692	2017-05-09 10:40:27.104844+03	111	Ankamall AVM | Sütaş Pasteurized Milk 1L	3		15	1
693	2017-05-09 10:40:27.110119+03	110	Ankamall AVM | Pınar Milk 1L	3		15	1
694	2017-05-09 10:40:27.115457+03	109	Ankamall AVM | Fanta  1 Cans	3		15	1
695	2017-05-09 10:40:27.121177+03	108	Ankamall AVM | Fanta  1L	3		15	1
696	2017-05-09 10:40:27.126945+03	107	Ankamall AVM | Coca-Cola Zero 1L	3		15	1
697	2017-05-09 10:40:27.132234+03	106	Atlantis AVM | Tomato  1KG	3		15	1
698	2017-05-09 10:40:27.137756+03	105	Atlantis AVM | Cucumber  1KG	3		15	1
699	2017-05-09 10:40:27.145192+03	104	Atlantis AVM | Watermelon  1KG	3		15	1
700	2017-05-09 10:40:27.15012+03	103	Atlantis AVM | Apple Red 1KG	3		15	1
701	2017-05-09 10:40:27.155606+03	102	Atlantis AVM | Apple Green 1KG	3		15	1
702	2017-05-09 10:40:27.161323+03	101	Atlantis AVM | Pınar Pasteurized Milk 1L	3		15	1
703	2017-05-09 10:40:27.165962+03	100	Atlantis AVM | Sütaş Pasteurized Milk 1L	3		15	1
704	2017-05-09 10:40:27.172079+03	99	Atlantis AVM | Pınar Milk 1L	3		15	1
705	2017-05-09 10:40:27.177744+03	98	Atlantis AVM | Fanta  1 Cans	3		15	1
706	2017-05-09 10:40:27.182772+03	97	Atlantis AVM | Fanta  1L	3		15	1
707	2017-05-09 10:40:27.188213+03	96	Atlantis AVM | Coca-Cola Zero 1L	3		15	1
708	2017-05-09 10:40:27.193876+03	95	Kentpark AVM | Tomato  1KG	3		15	1
709	2017-05-09 10:40:27.199572+03	94	Kentpark AVM | Cucumber  1KG	3		15	1
710	2017-05-09 10:40:27.205411+03	93	Kentpark AVM | Watermelon  1KG	3		15	1
711	2017-05-09 10:40:27.211755+03	92	Kentpark AVM | Apple Red 1KG	3		15	1
712	2017-05-09 10:40:27.21739+03	91	Kentpark AVM | Apple Green 1KG	3		15	1
713	2017-05-09 10:40:27.223593+03	90	Kentpark AVM | Pınar Pasteurized Milk 1L	3		15	1
714	2017-05-09 10:40:27.230817+03	89	Kentpark AVM | Sütaş Pasteurized Milk 1L	3		15	1
715	2017-05-09 10:40:27.237982+03	88	Kentpark AVM | Pınar Milk 1L	3		15	1
716	2017-05-09 10:40:27.245055+03	87	Kentpark AVM | Fanta  1 Cans	3		15	1
717	2017-05-09 10:40:27.25081+03	86	Kentpark AVM | Fanta  1L	3		15	1
718	2017-05-09 10:40:27.25646+03	85	Kentpark AVM | Coca-Cola Zero 1L	3		15	1
719	2017-05-09 10:40:27.262118+03	84	Gordion AVM | Tomato  1KG	3		15	1
720	2017-05-09 10:40:32.327877+03	83	Gordion AVM | Cucumber  1KG	3		15	1
721	2017-05-09 10:40:32.335453+03	82	Gordion AVM | Watermelon  1KG	3		15	1
722	2017-05-09 10:40:32.341492+03	81	Gordion AVM | Apple Red 1KG	3		15	1
723	2017-05-09 10:40:32.347311+03	80	Gordion AVM | Apple Green 1KG	3		15	1
724	2017-05-09 10:40:32.352452+03	79	Gordion AVM | Pınar Pasteurized Milk 1L	3		15	1
725	2017-05-09 10:40:32.358745+03	78	Gordion AVM | Sütaş Pasteurized Milk 1L	3		15	1
726	2017-05-09 10:40:32.364477+03	77	Gordion AVM | Pınar Milk 1L	3		15	1
727	2017-05-09 10:40:32.369552+03	76	Gordion AVM | Fanta  1 Cans	3		15	1
728	2017-05-09 10:40:32.375576+03	75	Gordion AVM | Fanta  1L	3		15	1
729	2017-05-09 10:40:32.380734+03	74	Gordion AVM | Coca-Cola Zero 1L	3		15	1
730	2017-05-09 10:40:52.074365+03	2	tozyer	3		17	1
731	2017-05-09 10:49:37.875015+03	26	Test Group	1	[{"added": {}}]	13	1
732	2017-05-09 10:49:47.118368+03	27	Test Child Group	1	[{"added": {}}]	13	1
733	2017-05-09 10:50:10.359023+03	17	Pınar Pasteurized Milk 1L	3		12	1
734	2017-05-09 10:50:10.364458+03	16	Pınar Milk 1L	3		12	1
735	2017-05-09 10:50:10.36778+03	15	Sütaş Pasteurized Milk 1L	3		12	1
736	2017-05-09 10:50:10.371595+03	14	Fanta  1 Cans	3		12	1
737	2017-05-09 10:50:10.375229+03	13	Fanta  1L	3		12	1
738	2017-05-09 10:50:10.379337+03	12	Coca-Cola Zero 1L	3		12	1
739	2017-05-09 10:50:10.383039+03	11	Watermelon  1KG	3		12	1
740	2017-05-09 10:50:10.387656+03	10	Tomato  1KG	3		12	1
741	2017-05-09 10:50:10.39242+03	9	Cucumber  1KG	3		12	1
742	2017-05-09 10:50:10.396137+03	8	Apple Red 1KG	3		12	1
743	2017-05-09 10:50:10.3993+03	7	Apple Green 1KG	3		12	1
744	2017-05-09 10:50:21.509566+03	18	Test Product 1 Units	1	[{"added": {}}]	12	1
745	2017-05-09 11:19:01.70549+03	18	Test Product 1 Units	2	[]	12	1
746	2017-05-09 12:28:23.655081+03	28	Test Child Group 2	1	[{"added": {}}]	13	1
747	2017-05-09 12:28:30.350433+03	29	Test Child Group 3	1	[{"added": {}}]	13	1
748	2017-05-09 12:28:41.916438+03	18	Test Product 1 Units	2	[{"changed": {"fields": ["group"]}}]	12	1
749	2017-05-09 13:11:32.289134+03	18	Test Product 1 Units	2	[{"changed": {"fields": ["group"]}}]	12	1
750	2017-05-09 13:11:44.036426+03	29	Test Child Group 3	3		13	1
751	2017-05-09 13:11:44.041832+03	28	Test Child Group 2	3		13	1
752	2017-05-09 17:31:38.751554+03	30	Child Group 2	1	[{"added": {}}]	13	1
753	2017-05-09 17:31:47.287798+03	31	Child Group 3	1	[{"added": {}}]	13	1
754	2017-05-09 17:33:41.856502+03	18	Test Product 1 Units	2	[{"changed": {"fields": ["group"]}}]	12	1
755	2017-05-09 17:41:33.599474+03	32	Another Root	1	[{"added": {}}]	13	1
756	2017-05-09 17:41:40.420442+03	33	Another Child	1	[{"added": {}}]	13	1
757	2017-05-09 17:44:34.486916+03	34	testtest	1	[{"added": {}}]	13	1
758	2017-05-09 17:45:12.544019+03	35	teshsg	1	[{"added": {}}]	13	1
759	2017-05-09 17:45:18.191231+03	36	ghjfgjg	1	[{"added": {}}]	13	1
760	2017-05-09 17:46:33.705218+03	36	ghjfgjg	3		13	1
761	2017-05-09 17:46:33.708735+03	35	teshsg	3		13	1
762	2017-05-09 17:46:33.71202+03	34	testtest	3		13	1
763	2017-05-09 17:46:33.715019+03	33	Another Child	3		13	1
764	2017-05-09 17:46:33.718119+03	32	Another Root	3		13	1
765	2017-05-09 17:46:33.721172+03	31	Child Group 3	3		13	1
766	2017-05-09 17:46:33.724293+03	30	Child Group 2	3		13	1
767	2017-05-09 17:46:33.727468+03	27	Test Child Group	3		13	1
768	2017-05-09 17:46:33.730447+03	26	Test Group	3		13	1
769	2017-05-09 17:46:43.318612+03	37	Yiyecek & İçecek	1	[{"added": {}}]	13	1
770	2017-05-09 17:46:49.056204+03	38	Yiyecek	1	[{"added": {}}]	13	1
771	2017-05-09 17:46:55.744514+03	39	İçecek	1	[{"added": {}}]	13	1
772	2017-05-09 17:47:04.928817+03	40	Süt	1	[{"added": {}}]	13	1
773	2017-05-09 17:47:12.127652+03	41	Asitli İçecekler	1	[{"added": {}}]	13	1
774	2017-05-09 17:47:18.499303+03	42	Ekmek	1	[{"added": {}}]	13	1
775	2017-05-09 17:47:23.409819+03	43	Sebze	1	[{"added": {}}]	13	1
776	2017-05-09 17:47:50.932302+03	44	Sebze & Meyve	1	[{"added": {}}]	13	1
777	2017-05-09 17:47:56.307067+03	43	Sebze	2	[{"changed": {"fields": ["parent"]}}]	13	1
778	2017-05-09 17:48:03.701223+03	45	Meyve	1	[{"added": {}}]	13	1
779	2017-05-09 17:48:31.612251+03	39	icecek	2	[{"changed": {"fields": ["name"]}}]	13	1
780	2017-05-09 17:48:50.260546+03	37	yiyecek icecek	2	[{"changed": {"fields": ["name"]}}]	13	1
781	2017-05-09 17:49:19.659501+03	41	asitli icecekler	2	[{"changed": {"fields": ["name"]}}]	13	1
782	2017-05-09 17:49:24.170439+03	44	sebze meyve	2	[{"changed": {"fields": ["name"]}}]	13	1
783	2017-05-09 17:49:31.410379+03	38	yiyecek	2	[{"changed": {"fields": ["name"]}}]	13	1
784	2017-05-09 17:49:35.158623+03	42	ekmek	2	[{"changed": {"fields": ["name"]}}]	13	1
785	2017-05-09 17:58:00.215106+03	44	Sebze & Meyve	2	[{"changed": {"fields": ["name"]}}]	13	1
786	2017-05-09 17:58:24.367779+03	42	Ekmek	2	[{"changed": {"fields": ["name"]}}]	13	1
787	2017-05-09 17:58:34.264852+03	39	Icecek	2	[{"changed": {"fields": ["name"]}}]	13	1
788	2017-05-09 17:58:39.259306+03	38	Yiyecek	2	[{"changed": {"fields": ["name"]}}]	13	1
789	2017-05-09 17:58:48.492901+03	37	Yiyecek & Icecek	2	[{"changed": {"fields": ["name"]}}]	13	1
790	2017-05-09 17:58:56.899699+03	41	Asitli Icecekler	2	[{"changed": {"fields": ["name"]}}]	13	1
791	2017-05-09 17:59:46.010968+03	46	Giyim	1	[{"added": {}}]	13	1
792	2017-05-09 18:00:43.883214+03	47	Elektronik	1	[{"added": {}}]	13	1
793	2017-05-10 11:03:45.915441+03	19	Pınar Süt 1L	1	[{"added": {}}]	12	1
794	2017-05-10 11:20:49.58244+03	20	Sütaş Süt 1L	1	[{"added": {}}]	12	1
795	2017-05-10 11:24:26.620354+03	21	Coca-Cola  1L	1	[{"added": {}}]	12	1
796	2017-05-10 11:26:12.755071+03	22	Sek Süt 1L	1	[{"added": {}}]	12	1
797	2017-05-10 11:26:29.128363+03	23	A Süt 1L	1	[{"added": {}}]	12	1
798	2017-05-10 11:26:37.849584+03	24	B Süt 1L	1	[{"added": {}}]	12	1
799	2017-05-10 11:26:46.601488+03	25	C Süt 1000ML	1	[{"added": {}}]	12	1
800	2017-05-10 13:02:29.062854+03	6	test_acc	3		17	1
801	2017-05-10 13:04:32.567746+03	7	test_acc	3		17	1
802	2017-05-10 13:06:48.546867+03	5	tozyer	3		17	1
803	2017-05-10 13:08:56.997951+03	8	test_acc	3		17	1
804	2017-05-10 13:09:48.988504+03	9	test_acc's Preferences	3		29	1
805	2017-05-10 13:11:10.526246+03	10	test_acc	3		17	1
806	2017-05-10 15:05:00.02409+03	47	Electronic	2	[{"changed": {"fields": ["name"]}}]	13	1
807	2017-05-10 15:05:14.066994+03	46	Clothing	2	[{"changed": {"fields": ["name"]}}]	13	1
808	2017-05-10 15:05:18.633479+03	45	Fruits	2	[{"changed": {"fields": ["name"]}}]	13	1
809	2017-05-10 15:05:30.94196+03	44	Vegetables & Fruits	2	[{"changed": {"fields": ["name"]}}]	13	1
810	2017-05-10 15:05:37.025059+03	43	Vegetables	2	[{"changed": {"fields": ["name"]}}]	13	1
811	2017-05-10 15:05:41.026466+03	42	Bread	2	[{"changed": {"fields": ["name"]}}]	13	1
812	2017-05-10 15:05:50.585897+03	41	Soda	2	[{"changed": {"fields": ["name"]}}]	13	1
813	2017-05-10 15:05:55.087545+03	40	Milk	2	[{"changed": {"fields": ["name"]}}]	13	1
814	2017-05-10 15:06:00.473527+03	39	Beverages	2	[{"changed": {"fields": ["name"]}}]	13	1
815	2017-05-10 15:06:12.643138+03	38	Food	2	[{"changed": {"fields": ["name"]}}]	13	1
816	2017-05-10 15:06:19.097637+03	37	Food & Beverages	2	[{"changed": {"fields": ["name"]}}]	13	1
817	2017-05-10 15:34:26.556456+03	7	test_acc:Test List 1	1	[{"added": {}}]	27	1
818	2017-05-10 15:34:34.894904+03	11	test_acc	2	[{"changed": {"fields": ["activeList"]}}]	17	1
819	2017-05-10 15:37:57.128742+03	312	Test List 1:Coca-Cola	3		19	1
820	2017-05-10 15:37:57.134315+03	311	Test List 1:A	3		19	1
821	2017-05-10 15:37:57.145383+03	310	Test List 1:B	3		19	1
822	2017-05-10 15:37:57.148569+03	309	Test List 1:C	3		19	1
823	2017-05-10 15:37:57.151967+03	308	Test List 1:Sek	3		19	1
824	2017-05-10 15:37:57.155436+03	307	Test List 1:Sütaş	3		19	1
825	2017-05-10 15:37:57.158769+03	306	Test List 1:Pınar	3		19	1
826	2017-05-11 17:01:13.727446+03	19	Pınar Süt 1L	2	[]	12	1
827	2017-05-11 17:01:16.735003+03	20	Sütaş Süt 1L	2	[]	12	1
828	2017-05-11 17:01:18.578789+03	21	Coca-Cola  1L	2	[]	12	1
829	2017-05-11 17:01:20.236962+03	21	Coca-Cola  1L	2	[]	12	1
830	2017-05-11 17:01:21.954324+03	22	Sek Süt 1L	2	[]	12	1
831	2017-05-11 17:01:27.875024+03	23	A Süt 1L	2	[]	12	1
832	2017-05-11 17:01:30.022599+03	24	B Süt 1L	2	[]	12	1
833	2017-05-11 17:01:31.817372+03	25	C Süt 1000ML	2	[]	12	1
834	2017-05-12 21:37:12.995037+03	1	Admin	1	[{"added": {}}]	33	1
835	2017-05-12 21:37:21.292893+03	2	User	1	[{"added": {}}]	33	1
836	2017-05-12 21:37:56.574987+03	1	dyanikoglu	2	[{"changed": {"fields": ["email"]}}]	17	1
837	2017-05-12 22:25:49.57136+03	11	dyanikoglu - test_acc	3		30	1
838	2017-05-12 22:25:49.577109+03	10	dyanikoglu - test_acc	3		30	1
839	2017-05-12 22:25:49.580193+03	9	dyanikoglu - test_acc	3		30	1
840	2017-05-12 22:25:49.583174+03	8	dyanikoglu - test_acc	3		30	1
841	2017-05-12 22:25:49.586404+03	7	dyanikoglu - test_acc	3		30	1
842	2017-05-12 22:25:49.589633+03	6	dyanikoglu - test_acc	3		30	1
843	2017-05-12 22:25:49.593132+03	5	dyanikoglu - test_acc	3		30	1
844	2017-05-12 22:25:49.596886+03	4	dyanikoglu - test_acc	3		30	1
845	2017-05-12 22:25:49.600174+03	3	dyanikoglu - test_acc	3		30	1
846	2017-05-12 22:25:49.603354+03	2	dyanikoglu - test_acc	3		30	1
847	2017-05-12 23:45:24.288693+03	13	test_acc - dyanikoglu	1	[{"added": {}}]	30	1
848	2017-05-13 00:16:10.144274+03	13	test_acc - dyanikoglu	2	[{"changed": {"fields": ["status"]}}]	30	1
849	2017-05-13 12:34:26.750608+03	1	test	3		32	1
850	2017-05-13 12:58:12.098378+03	2	test	3		32	1
851	2017-05-13 13:44:34.807291+03	2	Member	2	[{"changed": {"fields": ["name"]}}]	33	1
852	2017-05-13 14:06:03.240373+03	18	tes234 - dyanikoglu	3		31	1
853	2017-05-13 14:06:03.245057+03	17	tes234 - dyanikoglu	3		31	1
854	2017-05-13 14:06:09.089253+03	13	test	3		32	1
855	2017-05-13 14:06:09.093412+03	12	tes234	3		32	1
856	2017-05-13 14:06:09.097273+03	11	tes234	3		32	1
857	2017-05-13 14:06:09.10752+03	10	tes23	3		32	1
858	2017-05-13 14:06:09.111168+03	9	tes2	3		32	1
859	2017-05-13 14:06:09.114921+03	8	test1	3		32	1
860	2017-05-13 14:06:09.118492+03	7	test1	3		32	1
861	2017-05-13 14:06:09.122575+03	6	test2	3		32	1
862	2017-05-13 14:06:09.126179+03	5	test2	3		32	1
863	2017-05-13 14:06:09.129965+03	4	test2	3		32	1
864	2017-05-13 14:06:09.13363+03	3	test	3		32	1
865	2017-05-13 14:08:45.860237+03	23	tes234 - dyanikoglu	3		31	1
866	2017-05-13 14:08:45.873218+03	22	tes234 - dyanikoglu	3		31	1
867	2017-05-13 14:08:45.883838+03	21	tes234 - test_acc	3		31	1
869	2017-05-13 14:08:50.971427+03	15	test	3		32	1
870	2017-05-13 14:08:50.974442+03	14	test	3		32	1
871	2017-05-13 14:20:05.441178+03	19	testtttt	3		32	1
872	2017-05-13 14:20:05.445309+03	18	testtt	3		32	1
873	2017-05-13 14:20:05.448603+03	17	tes234	3		32	1
874	2017-05-13 23:24:05.084509+03	23	lolololololol	3		32	1
875	2017-05-13 23:24:05.090791+03	22	lolololololol	3		32	1
876	2017-05-13 23:24:05.094332+03	21	a_group	3		32	1
877	2017-05-13 23:24:05.097676+03	20	test_group	3		32	1
878	2017-05-14 10:24:38.977405+03	7	test_acc:Test List 1	2	[{"changed": {"fields": ["role"]}}]	27	1
879	2017-05-15 00:20:47.368988+03	9	testtt	3		18	1
880	2017-05-15 00:20:47.374282+03	8	Just A Test List	3		18	1
881	2017-05-15 00:20:47.377329+03	7	Test List 3	3		18	1
882	2017-05-15 00:20:47.381024+03	6	Test List 2	3		18	1
883	2017-05-15 00:20:47.384274+03	5	Test List 1	3		18	1
884	2017-05-15 00:22:24.776336+03	10	abcd	3		18	1
885	2017-05-15 09:34:33.706132+03	108	testt	3		32	1
886	2017-05-15 09:34:33.713342+03	107	testt	3		32	1
887	2017-05-15 09:34:33.716791+03	106	testt	3		32	1
888	2017-05-15 09:34:33.72012+03	105	abcd	3		32	1
889	2017-05-15 09:34:33.723758+03	104	abcd	3		32	1
890	2017-05-15 09:34:33.727589+03	103	abcd	3		32	1
891	2017-05-15 09:34:33.731922+03	102	abcd	3		32	1
892	2017-05-15 09:34:33.735538+03	101	abcd	3		32	1
893	2017-05-15 09:34:33.739479+03	100	abcd	3		32	1
894	2017-05-15 09:34:33.743172+03	99	abcd	3		32	1
895	2017-05-15 09:34:33.746559+03	98	gdf	3		32	1
896	2017-05-15 09:34:33.750061+03	97	gdf	3		32	1
897	2017-05-15 09:34:33.753915+03	96	gdf	3		32	1
898	2017-05-15 09:34:33.758705+03	95	gdf	3		32	1
899	2017-05-15 09:34:33.762109+03	94	gdf	3		32	1
900	2017-05-15 09:34:33.765588+03	93	gdf	3		32	1
901	2017-05-15 09:34:33.768877+03	92	gdf	3		32	1
902	2017-05-15 09:34:33.77292+03	91	gdf	3		32	1
903	2017-05-15 09:34:33.776538+03	90	gdf	3		32	1
904	2017-05-15 09:34:33.780154+03	89	gdf	3		32	1
905	2017-05-15 09:34:33.783906+03	88	gdf	3		32	1
906	2017-05-15 09:34:33.788282+03	87	gdf	3		32	1
907	2017-05-15 09:34:33.792625+03	86	gdf	3		32	1
908	2017-05-15 09:34:33.796222+03	85	gdf	3		32	1
909	2017-05-15 09:34:33.799911+03	84	gdf	3		32	1
910	2017-05-15 09:34:33.803849+03	83	gdf	3		32	1
911	2017-05-15 09:34:33.808149+03	82	gdf	3		32	1
912	2017-05-15 09:34:33.811933+03	81	gdf	3		32	1
913	2017-05-15 09:34:33.815719+03	80	gdf	3		32	1
914	2017-05-15 09:34:33.820058+03	79	gdf	3		32	1
915	2017-05-15 09:34:33.824112+03	78	gdf	3		32	1
916	2017-05-15 09:34:33.827508+03	77	gdf	3		32	1
917	2017-05-15 09:34:33.83091+03	76	gdf	3		32	1
918	2017-05-15 09:34:33.83391+03	75	gdf	3		32	1
919	2017-05-15 09:34:33.836849+03	74	gdf	3		32	1
920	2017-05-15 09:34:33.843899+03	73	gdf	3		32	1
921	2017-05-15 09:34:33.848028+03	72	gdf	3		32	1
922	2017-05-15 09:34:33.851712+03	71	gdf	3		32	1
923	2017-05-15 09:34:33.854654+03	70	gdf	3		32	1
924	2017-05-15 09:34:33.857795+03	69	gdf	3		32	1
925	2017-05-15 09:34:33.860854+03	68	gdf	3		32	1
926	2017-05-15 09:34:33.864036+03	67	gdf	3		32	1
927	2017-05-15 09:34:33.867018+03	66	gdf	3		32	1
928	2017-05-15 09:34:33.877265+03	65	gdf	3		32	1
929	2017-05-15 09:34:33.881282+03	64	gdf	3		32	1
930	2017-05-15 09:34:33.885175+03	63	gdf	3		32	1
931	2017-05-15 09:34:33.889479+03	62	gdf	3		32	1
932	2017-05-15 09:34:33.893738+03	61	gdf	3		32	1
933	2017-05-15 09:34:33.897908+03	60	gdf	3		32	1
934	2017-05-15 09:34:33.90136+03	59	gdf	3		32	1
935	2017-05-15 09:34:33.905387+03	58	gdf	3		32	1
936	2017-05-15 09:34:33.910876+03	57	gdf	3		32	1
937	2017-05-15 09:34:33.914286+03	56	gdf	3		32	1
938	2017-05-15 09:34:33.917492+03	55	gdf	3		32	1
939	2017-05-15 09:34:33.920987+03	54	gdf	3		32	1
940	2017-05-15 09:34:33.924682+03	53	gdf	3		32	1
941	2017-05-15 09:34:33.927994+03	52	gdf	3		32	1
942	2017-05-15 09:34:33.931138+03	51	gdf	3		32	1
943	2017-05-15 09:34:33.934264+03	50	gdf	3		32	1
944	2017-05-15 09:34:33.937846+03	49	gdf	3		32	1
945	2017-05-15 09:34:33.95198+03	48	gdf	3		32	1
946	2017-05-15 09:34:33.956328+03	47	gdf	3		32	1
947	2017-05-15 09:34:33.968361+03	46	gdf	3		32	1
948	2017-05-15 09:34:33.973801+03	45	gdf	3		32	1
949	2017-05-15 09:34:33.977851+03	44	gdf	3		32	1
950	2017-05-15 09:34:33.982005+03	43	gdf	3		32	1
951	2017-05-15 09:34:33.985718+03	42	gdf	3		32	1
952	2017-05-15 09:34:33.996273+03	41	gdf	3		32	1
953	2017-05-15 09:34:34.000408+03	40	gdf	3		32	1
954	2017-05-15 09:34:34.004734+03	39	gdf	3		32	1
955	2017-05-15 09:34:34.008985+03	38	gdf	3		32	1
956	2017-05-15 09:34:34.013321+03	37	gdf	3		32	1
957	2017-05-15 09:34:34.016992+03	36	gdf	3		32	1
958	2017-05-15 09:34:34.02054+03	35	gdf	3		32	1
959	2017-05-15 09:34:34.024561+03	34	gdf	3		32	1
960	2017-05-15 09:34:34.028243+03	33	saf	3		32	1
961	2017-05-15 09:34:34.032239+03	32	a	3		32	1
962	2017-05-15 09:34:34.035982+03	31	avc	3		32	1
963	2017-05-15 09:34:34.039904+03	30	das	3		32	1
964	2017-05-15 09:34:34.043612+03	29	asdasdsa	3		32	1
965	2017-05-15 09:34:34.047278+03	28	Aaa	3		32	1
966	2017-05-15 09:34:34.050941+03	27	Aaa	3		32	1
967	2017-05-15 09:34:34.054265+03	26	Aaa	3		32	1
968	2017-05-15 09:34:34.057633+03	25	testing	3		32	1
969	2017-05-15 09:34:34.06117+03	24	adada	3		32	1
970	2017-05-15 09:43:49.668522+03	14	h	3		18	1
971	2017-05-15 09:43:49.672828+03	13	gfgff	3		18	1
972	2017-05-15 09:43:49.676082+03	12	test	3		18	1
973	2017-05-15 09:43:49.679312+03	11	abcd	3		18	1
974	2017-05-15 10:03:40.161303+03	13	dyanikoglu	2	[{"changed": {"fields": ["active_list"]}}]	17	1
975	2017-05-15 10:03:46.800089+03	12	test_acc2	2	[{"changed": {"fields": ["active_list"]}}]	17	1
976	2017-05-16 12:34:35.409964+03	5	test_acc2:test_address	3		28	1
977	2017-05-16 12:34:35.416159+03	4	test_acc2:test_address	3		28	1
978	2017-05-16 12:36:29.482709+03	7	test_acc2:test_address	3		28	1
979	2017-05-16 12:36:29.487858+03	6	test_acc2:test_address	3		28	1
980	2017-05-16 12:39:25.070291+03	8	test_acc2:test_address	3		28	1
981	2017-05-16 15:46:55.117876+03	15	dyanikoglu's Preferences	2	[{"changed": {"fields": ["route_start_point", "route_end_point"]}}]	29	1
982	2017-05-16 15:50:57.618971+03	15	dyanikoglu	2	[{"changed": {"fields": ["active_list"]}}]	17	1
983	2017-05-16 18:07:31.280028+03	16	dyanikoglu	2	[{"changed": {"fields": ["active_list"]}}]	17	1
984	2017-05-16 18:10:06.535769+03	24	Another Test List	3		18	1
985	2017-05-16 18:10:06.54958+03	23	Just A Test List 3	3		18	1
986	2017-05-16 18:10:06.554279+03	20	Test_Cart_5	3		18	1
987	2017-05-16 18:10:06.557662+03	19	Test_Cart_4	3		18	1
988	2017-05-16 18:10:06.560929+03	18	Test_Cart_3	3		18	1
989	2017-05-16 18:10:06.564629+03	17	Test_Cart_2	3		18	1
990	2017-05-16 18:10:06.568554+03	16	Test_Cart_1	3		18	1
991	2017-05-16 18:10:06.571655+03	15	notif_test	3		18	1
992	2017-07-14 14:22:13.73036+03	1	Blame object	1	[{"added": {}}]	34	1
993	2017-07-14 14:22:19.847737+03	1	Blame object	3		34	1
994	2017-07-14 14:24:12.143589+03	3	Gordion AVM | Pınar Süt 1L	1	[{"added": {}}]	34	1
995	2017-07-14 16:28:23.837435+03	16	dyanikoglu	2	[{"changed": {"fields": ["reputation"]}}]	17	1
996	2017-07-15 13:25:51.789236+03	1	FalsePriceProposal object	1	[{"added": {}}]	37	1
997	2017-07-15 13:26:04.292178+03	1	ProposalSent object	1	[{"added": {}}]	38	1
998	2017-07-15 13:26:34.854306+03	2	ProposalSent object	1	[{"added": {}}]	38	1
999	2017-07-15 14:05:54.781512+03	6	dyanikoglu -> Arcadium AVM | Sütaş Süt 1L	3		34	1
1000	2017-07-15 14:05:54.788552+03	5	dyanikoglu -> Gordion AVM | Coca-Cola  1L	3		34	1
1001	2017-07-15 14:05:54.795771+03	4	dyanikoglu -> Gordion AVM | Pınar Süt 1L	3		34	1
1002	2017-07-15 14:05:54.80202+03	3	test_1 -> Gordion AVM | Pınar Süt 1L	3		34	1
1003	2017-07-15 14:06:01.17701+03	1	FalsePriceProposal object	3		37	1
1004	2017-07-15 14:06:17.799768+03	253	Panora AVM | C Süt 1000ML	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
1005	2017-07-15 14:06:59.095863+03	7	dyanikoglu -> Panora AVM | C Süt 1000ML	1	[{"added": {}}]	34	1
1006	2017-07-15 14:07:06.101514+03	8	test -> Panora AVM | C Süt 1000ML	1	[{"added": {}}]	34	1
1007	2017-07-15 16:11:03.308709+03	16	ProposalSent object	2	[{"changed": {"fields": ["response"]}}]	38	1
1008	2017-07-15 16:11:04.358535+03	15	ProposalSent object	2	[{"changed": {"fields": ["response"]}}]	38	1
1009	2017-07-15 16:11:34.588447+03	7	FalsePriceProposal object	2	[{"changed": {"fields": ["answer_count"]}}]	37	1
1010	2017-07-15 16:11:35.968293+03	16	ProposalSent object	2	[]	38	1
1011	2017-07-15 16:18:22.990258+03	8	FalsePriceProposal object	3		37	1
1012	2017-07-15 16:18:22.995842+03	7	FalsePriceProposal object	3		37	1
1013	2017-07-15 16:18:23.000107+03	6	FalsePriceProposal object	3		37	1
1014	2017-07-15 16:18:23.003114+03	5	FalsePriceProposal object	3		37	1
1015	2017-07-15 16:18:23.014883+03	4	FalsePriceProposal object	3		37	1
1016	2017-07-15 16:18:23.018811+03	3	FalsePriceProposal object	3		37	1
1017	2017-07-15 16:18:23.022681+03	2	FalsePriceProposal object	3		37	1
1018	2017-07-15 16:18:28.569349+03	13	dyanikoglu -> Kentpark AVM | Sütaş Süt 1L	3		34	1
1019	2017-07-15 16:18:28.580606+03	12	dyanikoglu -> Gordion AVM | Sütaş Süt 1L	3		34	1
1020	2017-07-15 16:18:28.587062+03	11	dyanikoglu -> Kentpark AVM | Pınar Süt 1L	3		34	1
1021	2017-07-15 16:18:28.593306+03	10	dyanikoglu -> Gordion AVM | B Süt 1L	3		34	1
1022	2017-07-15 16:18:28.600447+03	9	dyanikoglu -> Cepa AVM | B Süt 1L	3		34	1
1023	2017-07-15 16:18:28.607377+03	8	test -> Panora AVM | C Süt 1000ML	3		34	1
1024	2017-07-15 16:18:28.613788+03	7	dyanikoglu -> Panora AVM | C Süt 1000ML	3		34	1
1025	2017-07-15 16:18:52.780395+03	9	FalsePriceProposal object	1	[{"added": {}}]	37	1
1026	2017-07-15 16:19:11.903494+03	9	FalsePriceProposal object	3		37	1
1027	2017-07-15 16:19:19.246103+03	14	dyanikoglu -> Gordion AVM | Sek Süt 1L	1	[{"added": {}}]	34	1
1028	2017-07-15 16:19:24.352432+03	15	test -> Gordion AVM | Sek Süt 1L	1	[{"added": {}}]	34	1
1029	2017-07-15 16:19:40.664211+03	187	Gordion AVM | Sek Süt 1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
1030	2017-07-15 16:21:30.595762+03	20	ProposalSent object	2	[{"changed": {"fields": ["response"]}}]	38	1
1031	2017-07-15 16:21:31.757206+03	19	ProposalSent object	2	[{"changed": {"fields": ["response"]}}]	38	1
1032	2017-07-15 16:21:34.487906+03	10	FalsePriceProposal object	2	[{"changed": {"fields": ["answer_count"]}}]	37	1
1033	2017-07-15 16:23:24.804632+03	11	FalsePriceProposal object	3		37	1
1034	2017-07-15 16:23:24.809704+03	10	FalsePriceProposal object	3		37	1
1035	2017-07-15 16:23:30.189973+03	15	test -> Gordion AVM | Sek Süt 1L	3		34	1
1036	2017-07-15 16:23:30.198868+03	14	dyanikoglu -> Gordion AVM | Sek Süt 1L	3		34	1
1037	2017-07-17 01:08:09.815636+03	12	FalsePriceProposal object	1	[{"added": {}}]	37	1
1038	2017-07-17 01:08:20.818239+03	23	ProposalSent object	1	[{"added": {}}]	38	1
1039	2017-07-21 08:48:40.678818+03	12	FalsePriceProposal object	2	[{"changed": {"fields": ["answer_count"]}}]	37	1
1040	2017-07-21 09:20:19.392313+03	16	dyanikoglu	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1041	2017-07-21 09:20:29.162451+03	20	test2	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1042	2017-07-21 09:20:43.389459+03	18	test	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1043	2017-07-21 09:22:49.989644+03	26	Test Product 1L	1	[{"added": {}}]	12	1
1044	2017-07-21 09:23:22.879793+03	31	Test Retailer	1	[{"added": {}}]	10	1
1045	2017-07-21 09:23:42.951425+03	254	Test Retailer | Pınar Süt 1L	1	[{"added": {}}]	15	1
1046	2017-07-21 09:23:53.225912+03	255	Test Retailer | Test Product 1L	1	[{"added": {}}]	15	1
1047	2017-07-21 09:24:02.674527+03	256	Atlantis AVM | Test Product 1L	1	[{"added": {}}]	15	1
1048	2017-07-21 09:24:12.273363+03	257	Arcadium AVM | Test Product 1L	1	[{"added": {}}]	15	1
1049	2017-07-21 09:24:21.683087+03	258	Panora AVM | Test Product 1L	1	[{"added": {}}]	15	1
1050	2017-07-21 09:24:59.243441+03	17	dyanikoglu -> Armada AVM | Coca-Cola  1L	3		34	1
1051	2017-07-21 09:24:59.259622+03	16	dyanikoglu -> Kentpark AVM | Coca-Cola  1L	3		34	1
1052	2017-07-21 09:25:03.020318+03	12	FalsePriceProposal object	3		37	1
1053	2017-07-21 09:27:56.01645+03	14	FalsePriceProposal object	3		37	1
1054	2017-07-21 09:27:56.021795+03	13	FalsePriceProposal object	3		37	1
1055	2017-07-21 09:28:29.08446+03	193	Kentpark AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1056	2017-07-21 09:28:57.69683+03	228	Armada AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1057	2017-07-21 09:33:11.710534+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
1058	2017-07-21 09:33:23.530948+03	18	test -> Test Retailer | Test Product 1L	3		34	1
1059	2017-07-21 09:44:14.278891+03	15	FalsePriceProposal object	3		37	1
1060	2017-07-21 09:44:18.638762+03	20	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
1061	2017-07-21 09:44:18.646879+03	19	test -> Test Retailer | Test Product 1L	3		34	1
1062	2017-07-21 09:44:28.140659+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
1063	2017-07-21 09:45:03.922238+03	16	dyanikoglu	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1064	2017-07-21 09:45:06.525207+03	18	test	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1065	2017-07-21 09:53:50.089193+03	16	FalsePriceProposal object	2	[{"changed": {"fields": ["status_code"]}}]	37	1
1066	2017-07-21 09:57:41.082626+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1067	2017-07-21 09:57:52.04883+03	16	FalsePriceProposal object	3		37	1
1068	2017-07-21 09:57:57.488102+03	22	test -> Test Retailer | Test Product 1L	3		34	1
1069	2017-07-21 09:57:57.497588+03	21	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
1070	2017-07-21 10:03:41.198608+03	16	dyanikoglu	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1071	2017-07-21 10:03:47.055913+03	18	test	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1072	2017-07-21 10:04:12.578182+03	23	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
1073	2017-07-21 10:04:21.188211+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
1074	2017-07-21 10:08:19.875181+03	17	FalsePriceProposal object	3		37	1
1075	2017-07-21 10:08:24.910692+03	25	test -> Test Retailer | Test Product 1L	3		34	1
1076	2017-07-21 10:08:24.920214+03	24	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
1077	2017-07-21 10:08:37.207856+03	18	test	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1078	2017-07-21 10:08:39.45678+03	16	dyanikoglu	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1079	2017-07-21 10:08:51.761294+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
1080	2017-07-21 10:09:00.508513+03	31	Test Retailer	2	[]	10	1
1081	2017-07-21 10:47:51.209644+03	1	dyanikoglu	2	[{"changed": {"fields": ["password"]}}]	2	1
1082	2017-07-22 17:12:21.736735+03	16	dyanikoglu's Preferences	2	[{"changed": {"fields": ["algorithm"]}}]	29	1
1083	2017-07-22 17:16:35.564469+03	16	dyanikoglu's Preferences	2	[{"changed": {"fields": ["algorithm"]}}]	29	1
1084	2017-07-22 17:19:24.95766+03	16	dyanikoglu's Preferences	2	[{"changed": {"fields": ["algorithm"]}}]	29	1
1085	2017-07-22 17:21:27.381065+03	16	dyanikoglu's Preferences	2	[{"changed": {"fields": ["algorithm"]}}]	29	1
1086	2017-07-22 17:21:32.576431+03	16	dyanikoglu's Preferences	2	[{"changed": {"fields": ["algorithm"]}}]	29	1
1087	2017-07-24 12:29:27.472061+03	42	My First Shopping List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1088	2017-07-24 12:29:30.567681+03	39	My First Shopping List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1089	2017-07-24 12:29:56.690031+03	41	Another Test List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1090	2017-07-24 12:31:34.461298+03	41	Another Test List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1091	2017-07-24 12:31:49.32135+03	41	Another Test List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1092	2017-07-24 12:32:26.496483+03	41	Another Test List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1093	2017-07-24 12:32:38.069429+03	41	Another Test List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1094	2017-07-24 12:32:45.111453+03	40	Just A Test List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1095	2017-07-24 12:35:05.11052+03	468	ShoppingListItem object	3		19	1
1096	2017-07-24 12:35:05.124106+03	467	ShoppingListItem object	3		19	1
1097	2017-07-24 12:35:05.12796+03	466	ShoppingListItem object	3		19	1
1098	2017-07-24 12:35:05.13232+03	465	ShoppingListItem object	3		19	1
1099	2017-07-24 12:35:05.135798+03	463	ShoppingListItem object	3		19	1
1100	2017-07-24 12:35:05.139067+03	462	ShoppingListItem object	3		19	1
1101	2017-07-24 12:35:05.142249+03	461	ShoppingListItem object	3		19	1
1102	2017-07-24 12:35:05.146046+03	452	ShoppingListItem object	3		19	1
1103	2017-07-24 12:35:05.149529+03	451	ShoppingListItem object	3		19	1
1104	2017-07-24 12:35:05.152474+03	450	ShoppingListItem object	3		19	1
1105	2017-07-24 12:35:05.155408+03	449	ShoppingListItem object	3		19	1
1106	2017-07-24 12:35:05.158311+03	448	ShoppingListItem object	3		19	1
1107	2017-07-24 12:35:05.161414+03	447	ShoppingListItem object	3		19	1
1108	2017-07-24 12:35:05.165096+03	446	ShoppingListItem object	3		19	1
1109	2017-07-24 12:35:05.168158+03	445	ShoppingListItem object	3		19	1
1110	2017-07-24 12:35:05.171327+03	444	ShoppingListItem object	3		19	1
1111	2017-07-24 12:35:05.174692+03	443	ShoppingListItem object	3		19	1
1112	2017-07-24 12:35:05.178167+03	442	ShoppingListItem object	3		19	1
1113	2017-07-24 12:35:05.181397+03	441	ShoppingListItem object	3		19	1
1114	2017-07-24 12:35:44.641883+03	16	dyanikoglu	2	[{"changed": {"fields": ["active_list"]}}]	17	1
1115	2017-07-24 12:35:55.746127+03	20	test2	3		17	1
1116	2017-07-24 12:35:55.749506+03	19	test_1	3		17	1
1117	2017-07-24 12:35:55.752716+03	17	test_acc	3		17	1
1118	2017-07-24 12:36:00.44818+03	18	test	2	[{"changed": {"fields": ["active_list"]}}]	17	1
1119	2017-07-24 12:36:12.332477+03	44	My First Shopping List	3		18	1
1120	2017-07-24 12:36:12.337787+03	43	abc	3		18	1
1121	2017-07-24 12:36:12.341472+03	42	My First Shopping List	3		18	1
1122	2017-07-24 12:36:12.345327+03	41	Another Test List	3		18	1
1123	2017-07-24 12:36:12.348904+03	40	Just A Test List	3		18	1
1124	2017-07-24 12:36:12.35218+03	39	My First Shopping List	3		18	1
1125	2017-07-24 14:20:46.08762+03	1	UserStatistics object	1	[{"added": {}}]	39	1
1126	2017-07-24 16:28:30.831296+03	1	UserStatistics object	2	[{"changed": {"fields": ["itemsBought"]}}]	39	1
1127	2017-07-24 16:33:21.248927+03	46	My First Shopping List	3		18	1
1128	2017-07-24 16:33:21.25392+03	45	My First Shopping List	3		18	1
1129	2017-07-24 16:33:25.370065+03	47	My First Shopping List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1130	2017-07-24 16:40:47.9668+03	50	Another Another List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1131	2017-07-24 16:40:50.567926+03	49	Another List	2	[{"changed": {"fields": ["completed"]}}]	18	1
1132	2017-07-24 17:02:15.313182+03	16	dyanikoglu	2	[{"changed": {"fields": ["statistics"]}}]	17	1
1133	2017-07-24 17:02:36.081914+03	2	UserStatistics object	1	[{"added": {}}]	39	1
1134	2017-07-24 17:02:48.506769+03	2	UserStatistics object	2	[]	39	1
1135	2017-07-24 17:02:49.982871+03	18	test	2	[{"changed": {"fields": ["statistics"]}}]	17	1
1136	2017-07-25 19:18:36.224427+03	30	dyanikoglu -> Kızılay AVM | Coca-Cola  1L	3		34	1
1137	2017-07-25 19:18:36.235045+03	29	test -> Atlantis AVM | Test Product 1L	3		34	1
1138	2017-07-25 19:18:36.241842+03	28	dyanikoglu -> Atlantis AVM | Test Product 1L	3		34	1
1139	2017-07-25 19:18:36.248989+03	27	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
1140	2017-07-25 19:18:36.255017+03	26	test -> Test Retailer | Test Product 1L	3		34	1
1141	2017-07-25 19:18:43.859422+03	19	FalsePriceProposal object	3		37	1
1142	2017-07-25 19:18:43.865399+03	18	FalsePriceProposal object	3		37	1
1143	2017-07-25 20:51:19.589325+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
1144	2017-07-25 20:51:25.921088+03	253	Panora AVM | C Süt 1000ML	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1145	2017-07-25 20:51:42.862008+03	242	Kızılay AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
1146	2017-07-25 20:51:51.587538+03	238	Cepa AVM | B Süt 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1147	2017-07-25 20:52:23.364687+03	185	Gordion AVM | Sütaş Süt 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1148	2017-07-25 20:52:29.893569+03	187	Gordion AVM | Sek Süt 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
1149	2017-07-25 20:52:35.074245+03	189	Gordion AVM | B Süt 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1150	2017-07-25 20:52:40.989416+03	191	Kentpark AVM | Pınar Süt 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
1151	2017-07-25 20:52:46.11645+03	192	Kentpark AVM | Sütaş Süt 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
1152	2017-07-25 20:53:25.171334+03	16	dyanikoglu	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1153	2017-07-25 20:53:34.797437+03	18	test	2	[{"changed": {"fields": ["reputation"]}}]	17	1
1154	2017-07-25 20:53:45.427446+03	115	aile	3		32	1
1155	2017-07-25 21:30:10.843466+03	2	UserStatistics object	2	[{"changed": {"fields": ["blame_count"]}}]	39	1
1156	2017-07-25 21:30:17.798076+03	1	UserStatistics object	2	[{"changed": {"fields": ["blame_count", "itemsBought", "shoppingListsComplete", "favoriteCategory", "favoriteProduct"]}}]	39	1
1157	2017-07-25 21:32:21.742892+03	981	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:03:20.889160+00:00	3		35	1
1158	2017-07-25 21:32:21.749177+03	980	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:03:15.187238+00:00	3		35	1
1159	2017-07-25 21:32:21.752698+03	979	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:03:09.032411+00:00	3		35	1
1160	2017-07-25 21:32:21.75623+03	978	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:03:07.547276+00:00	3		35	1
1161	2017-07-25 21:32:21.759439+03	977	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:03:01.439649+00:00	3		35	1
1162	2017-07-25 21:32:21.763465+03	976	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:03:00.091727+00:00	3		35	1
1163	2017-07-25 21:32:21.775871+03	975	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:02:59.077680+00:00	3		35	1
1164	2017-07-25 21:32:21.780921+03	974	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:02:58.500680+00:00	3		35	1
1165	2017-07-25 21:32:21.784567+03	973	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:02:57.408216+00:00	3		35	1
1166	2017-07-25 21:32:21.795646+03	972	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:02:56.265979+00:00	3		35	1
1167	2017-07-25 21:32:21.799427+03	971	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 14:02:54.979704+00:00	3		35	1
1168	2017-07-25 21:32:21.803199+03	970	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:29.309113+00:00	3		35	1
1169	2017-07-25 21:32:21.806644+03	969	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:28.082297+00:00	3		35	1
1170	2017-07-25 21:32:21.810006+03	968	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:26.941649+00:00	3		35	1
1171	2017-07-25 21:32:21.813475+03	967	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:26.287869+00:00	3		35	1
1172	2017-07-25 21:32:21.817092+03	966	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:25.394921+00:00	3		35	1
1173	2017-07-25 21:32:21.82044+03	965	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:24.101923+00:00	3		35	1
1174	2017-07-25 21:32:21.82401+03	964	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:23.196247+00:00	3		35	1
1175	2017-07-25 21:32:21.827369+03	963	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:22.226798+00:00	3		35	1
1176	2017-07-25 21:32:21.830625+03	962	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:21.377447+00:00	3		35	1
1177	2017-07-25 21:32:21.833533+03	961	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:20.505867+00:00	3		35	1
1178	2017-07-25 21:32:21.83648+03	960	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:19.579192+00:00	3		35	1
1179	2017-07-25 21:32:21.839342+03	959	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:18.445491+00:00	3		35	1
1180	2017-07-25 21:32:21.84232+03	958	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:17.464097+00:00	3		35	1
1181	2017-07-25 21:32:21.85452+03	957	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:16.114950+00:00	3		35	1
1182	2017-07-25 21:32:21.86569+03	956	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:15.227625+00:00	3		35	1
1183	2017-07-25 21:32:21.86992+03	955	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:14.175072+00:00	3		35	1
1184	2017-07-25 21:32:21.874014+03	954	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:48:13.590857+00:00	3		35	1
1185	2017-07-25 21:32:21.878303+03	953	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:42.376489+00:00	3		35	1
1186	2017-07-25 21:32:21.882406+03	952	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:35.997814+00:00	3		35	1
1187	2017-07-25 21:32:21.88592+03	951	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:30.100263+00:00	3		35	1
1188	2017-07-25 21:32:21.889445+03	950	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:28.636925+00:00	3		35	1
1189	2017-07-25 21:32:21.895292+03	949	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:19.692343+00:00	3		35	1
1190	2017-07-25 21:32:21.898773+03	948	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:18.457673+00:00	3		35	1
1191	2017-07-25 21:32:21.901828+03	947	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:12.287407+00:00	3		35	1
1192	2017-07-25 21:32:21.904802+03	946	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:45:06.010980+00:00	3		35	1
1193	2017-07-25 21:32:21.907906+03	945	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:44:35.789207+00:00	3		35	1
1194	2017-07-25 21:32:21.911501+03	944	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:44:09.868704+00:00	3		35	1
1195	2017-07-25 21:32:21.915258+03	943	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:43:35.951235+00:00	3		35	1
1196	2017-07-25 21:32:21.918454+03	942	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:43:05.265147+00:00	3		35	1
1197	2017-07-25 21:32:21.921397+03	941	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:42:38.911963+00:00	3		35	1
1198	2017-07-25 21:32:21.926065+03	940	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:42:06.093271+00:00	3		35	1
1199	2017-07-25 21:32:21.930493+03	939	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:41:45.352758+00:00	3		35	1
1200	2017-07-25 21:32:21.933898+03	938	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:41:43.863618+00:00	3		35	1
1201	2017-07-25 21:32:21.937274+03	937	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:24:01.015897+00:00	3		35	1
1202	2017-07-25 21:32:21.941094+03	936	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:23:35.358212+00:00	3		35	1
1203	2017-07-25 21:32:21.945291+03	935	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 13:23:03.847537+00:00	3		35	1
1204	2017-07-25 21:32:21.956201+03	934	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 11:18:04.565183+00:00	3		35	1
1205	2017-07-25 21:32:21.959835+03	933	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 11:17:58.455445+00:00	3		35	1
1206	2017-07-25 21:32:21.964392+03	932	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 11:17:47.588923+00:00	3		35	1
1207	2017-07-25 21:32:21.968327+03	931	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 11:17:46.395455+00:00	3		35	1
1208	2017-07-25 21:32:21.971676+03	930	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 11:17:45.622807+00:00	3		35	1
1209	2017-07-25 21:32:21.974767+03	929	gisModule.tasks.statistic_module_basic_statistics - 2017-07-24 11:17:44.421701+00:00	3		35	1
1210	2017-07-25 21:32:21.977811+03	928	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:21:55.703535+00:00	3		35	1
1211	2017-07-25 21:32:21.989896+03	927	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:21:54.845435+00:00	3		35	1
1212	2017-07-25 21:32:21.994678+03	926	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:21:29.134713+00:00	3		35	1
1213	2017-07-25 21:32:21.99833+03	925	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:21:28.119103+00:00	3		35	1
1214	2017-07-25 21:32:22.001969+03	924	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:20:56.785930+00:00	3		35	1
1215	2017-07-25 21:32:22.005297+03	923	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:20:55.290466+00:00	3		35	1
1216	2017-07-25 21:32:22.009389+03	922	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:20:28.782156+00:00	3		35	1
1217	2017-07-25 21:32:22.014543+03	921	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:20:27.674648+00:00	3		35	1
1218	2017-07-25 21:32:22.018189+03	920	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:19:56.262403+00:00	3		35	1
1219	2017-07-25 21:32:22.021202+03	919	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:19:55.037581+00:00	3		35	1
1220	2017-07-25 21:32:22.024334+03	918	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:19:29.324765+00:00	3		35	1
1221	2017-07-25 21:32:22.027797+03	917	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:19:27.986143+00:00	3		35	1
1222	2017-07-25 21:32:22.032181+03	916	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:19:01.717261+00:00	3		35	1
1223	2017-07-25 21:32:22.035599+03	915	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:18:59.550184+00:00	3		35	1
1224	2017-07-25 21:32:22.039858+03	914	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:18:27.927489+00:00	3		35	1
1225	2017-07-25 21:32:22.044587+03	913	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:18:27.374521+00:00	3		35	1
1226	2017-07-25 21:32:22.048012+03	912	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:18:00.955233+00:00	3		35	1
1227	2017-07-25 21:32:22.051196+03	911	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:17:59.604695+00:00	3		35	1
1228	2017-07-25 21:32:22.054368+03	910	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:17:28.346867+00:00	3		35	1
1229	2017-07-25 21:32:22.05751+03	909	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:17:27.698021+00:00	3		35	1
1230	2017-07-25 21:32:22.060599+03	908	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:17:01.396382+00:00	3		35	1
1231	2017-07-25 21:32:22.065924+03	907	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:17:00.857486+00:00	3		35	1
1232	2017-07-25 21:32:22.070074+03	906	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:16:59.400643+00:00	3		35	1
1233	2017-07-25 21:32:22.07346+03	905	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:16:58.245500+00:00	3		35	1
1234	2017-07-25 21:32:22.077238+03	904	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:15:44.990876+00:00	3		35	1
1235	2017-07-25 21:32:22.081258+03	903	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:15:43.883066+00:00	3		35	1
1236	2017-07-25 21:32:22.084416+03	902	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:15:13.212766+00:00	3		35	1
1237	2017-07-25 21:32:22.087573+03	901	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:15:11.863647+00:00	3		35	1
1238	2017-07-25 21:32:22.090795+03	900	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:14:45.981870+00:00	3		35	1
1239	2017-07-25 21:32:22.094891+03	899	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:14:45.381055+00:00	3		35	1
1240	2017-07-25 21:32:22.098205+03	898	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:14:14.658417+00:00	3		35	1
1241	2017-07-25 21:32:22.101831+03	897	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:14:13.507850+00:00	3		35	1
1242	2017-07-25 21:32:22.104961+03	896	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:13:42.476007+00:00	3		35	1
1243	2017-07-25 21:32:22.109937+03	895	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:13:41.643132+00:00	3		35	1
1244	2017-07-25 21:32:22.113094+03	894	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:13:15.652271+00:00	3		35	1
1245	2017-07-25 21:32:22.116212+03	893	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:13:14.182790+00:00	3		35	1
1246	2017-07-25 21:32:22.119445+03	892	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:12:43.493944+00:00	3		35	1
1247	2017-07-25 21:32:22.122608+03	891	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:12:42.050735+00:00	3		35	1
1248	2017-07-25 21:32:22.12664+03	890	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:12:15.528354+00:00	3		35	1
1249	2017-07-25 21:32:22.131325+03	889	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:12:14.080577+00:00	3		35	1
1250	2017-07-25 21:32:22.134836+03	888	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:11:43.205756+00:00	3		35	1
1251	2017-07-25 21:32:22.137986+03	887	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:11:42.452875+00:00	3		35	1
1252	2017-07-25 21:32:22.141397+03	886	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:11:16.196473+00:00	3		35	1
1253	2017-07-25 21:32:22.153382+03	885	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:11:15.281103+00:00	3		35	1
1254	2017-07-25 21:32:22.156975+03	884	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:10:44.098855+00:00	3		35	1
1255	2017-07-25 21:32:22.160897+03	883	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:10:42.815876+00:00	3		35	1
1256	2017-07-25 21:32:22.164541+03	882	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:10:16.944729+00:00	3		35	1
1257	2017-07-25 21:32:28.282485+03	881	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:10:14.439427+00:00	3		35	1
1258	2017-07-25 21:32:28.288363+03	880	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:09:43.301927+00:00	3		35	1
1259	2017-07-25 21:32:28.292405+03	879	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:09:42.239841+00:00	3		35	1
1260	2017-07-25 21:32:28.29643+03	878	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:09:15.982732+00:00	3		35	1
1261	2017-07-25 21:32:28.299949+03	877	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:09:14.562426+00:00	3		35	1
1262	2017-07-25 21:32:28.303539+03	876	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:07:37.500080+00:00	3		35	1
1263	2017-07-25 21:32:28.307417+03	875	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:07:36.589257+00:00	3		35	1
1264	2017-07-25 21:32:28.310906+03	874	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:07:05.589495+00:00	3		35	1
1265	2017-07-25 21:32:28.314142+03	873	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:07:04.536655+00:00	3		35	1
1266	2017-07-25 21:32:28.317112+03	872	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:06:38.629550+00:00	3		35	1
1267	2017-07-25 21:32:28.320155+03	871	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:06:37.543409+00:00	3		35	1
1268	2017-07-25 21:32:28.323049+03	870	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:06:06.216293+00:00	3		35	1
1269	2017-07-25 21:32:28.326125+03	869	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:06:04.777537+00:00	3		35	1
1270	2017-07-25 21:32:28.337494+03	868	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:05:38.412631+00:00	3		35	1
1271	2017-07-25 21:32:28.342+03	867	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:05:36.159332+00:00	3		35	1
1272	2017-07-25 21:32:28.34616+03	866	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:05:05.164150+00:00	3		35	1
1273	2017-07-25 21:32:28.349586+03	865	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:05:03.691965+00:00	3		35	1
1274	2017-07-25 21:32:28.352844+03	864	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:04:37.681818+00:00	3		35	1
1275	2017-07-25 21:32:28.356213+03	863	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:04:36.190435+00:00	3		35	1
1276	2017-07-25 21:32:28.360644+03	862	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:04:05.053466+00:00	3		35	1
1277	2017-07-25 21:32:28.364218+03	861	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:04:03.939963+00:00	3		35	1
1278	2017-07-25 21:32:28.368448+03	860	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:03:38.146419+00:00	3		35	1
1279	2017-07-25 21:32:28.372226+03	859	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:03:36.969988+00:00	3		35	1
1280	2017-07-25 21:32:28.37642+03	858	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:03:06.161745+00:00	3		35	1
1281	2017-07-25 21:32:28.380892+03	857	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:03:04.818162+00:00	3		35	1
1282	2017-07-25 21:32:28.385442+03	856	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:02:33.859228+00:00	3		35	1
1283	2017-07-25 21:32:28.3889+03	855	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:02:33.222809+00:00	3		35	1
1284	2017-07-25 21:32:28.392153+03	854	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:02:06.923376+00:00	3		35	1
1285	2017-07-25 21:32:28.395411+03	853	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:02:05.936198+00:00	3		35	1
1286	2017-07-25 21:32:28.399371+03	852	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:01:35.186052+00:00	3		35	1
1287	2017-07-25 21:32:28.402728+03	851	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:01:33.887392+00:00	3		35	1
1288	2017-07-25 21:32:28.414028+03	850	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:01:07.999222+00:00	3		35	1
1289	2017-07-25 21:32:28.417339+03	849	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:01:06.797784+00:00	3		35	1
1290	2017-07-25 21:32:28.420542+03	848	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:00:35.273278+00:00	3		35	1
1291	2017-07-25 21:32:28.423583+03	847	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:00:34.372366+00:00	3		35	1
1292	2017-07-25 21:32:28.427198+03	846	gisModule.tasks.blame_module_check_proposal - 2017-07-21 07:00:08.631620+00:00	3		35	1
1293	2017-07-25 21:32:28.430717+03	845	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 07:00:07.531754+00:00	3		35	1
1294	2017-07-25 21:32:28.433788+03	844	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:59:36.307641+00:00	3		35	1
1295	2017-07-25 21:32:28.437044+03	843	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:59:35.370275+00:00	3		35	1
1296	2017-07-25 21:32:28.440446+03	842	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:59:04.347049+00:00	3		35	1
1297	2017-07-25 21:32:28.451049+03	841	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:59:02.878883+00:00	3		35	1
1298	2017-07-25 21:32:28.454762+03	840	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:58:37.033687+00:00	3		35	1
1299	2017-07-25 21:32:28.458364+03	839	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:58:35.658562+00:00	3		35	1
1300	2017-07-25 21:32:28.462879+03	838	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:58:04.601027+00:00	3		35	1
1301	2017-07-25 21:32:28.466259+03	837	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:58:03.172234+00:00	3		35	1
1302	2017-07-25 21:32:28.469674+03	836	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:57:36.945301+00:00	3		35	1
1303	2017-07-25 21:32:28.473246+03	835	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:57:36.206529+00:00	3		35	1
1304	2017-07-25 21:32:28.477036+03	834	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:57:26.295636+00:00	3		35	1
1305	2017-07-25 21:32:28.48034+03	833	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:57:25.340219+00:00	3		35	1
1306	2017-07-25 21:32:28.48344+03	832	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:56:54.661007+00:00	3		35	1
1307	2017-07-25 21:32:28.486621+03	831	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:56:54.013963+00:00	3		35	1
1308	2017-07-25 21:32:28.490441+03	830	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:56:27.702337+00:00	3		35	1
2324	2017-07-26 11:42:19.785012+03	31	Test Retailer	3		10	1
1309	2017-07-25 21:32:28.493912+03	829	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:56:27.176548+00:00	3		35	1
1310	2017-07-25 21:32:28.498061+03	828	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:55:55.768144+00:00	3		35	1
1311	2017-07-25 21:32:28.501368+03	827	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:55:55.207311+00:00	3		35	1
1312	2017-07-25 21:32:28.504613+03	826	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:55:24.340207+00:00	3		35	1
1313	2017-07-25 21:32:28.50818+03	825	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:55:23.271118+00:00	3		35	1
1314	2017-07-25 21:32:28.511428+03	824	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:54:57.384055+00:00	3		35	1
1315	2017-07-25 21:32:28.514652+03	823	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:54:55.871664+00:00	3		35	1
1316	2017-07-25 21:32:28.517658+03	822	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:54:24.443716+00:00	3		35	1
1317	2017-07-25 21:32:28.520965+03	821	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:54:23.591267+00:00	3		35	1
1318	2017-07-25 21:32:28.524149+03	820	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:53:57.751317+00:00	3		35	1
1319	2017-07-25 21:32:28.527245+03	819	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:53:56.974724+00:00	3		35	1
1320	2017-07-25 21:32:28.531203+03	818	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:53:25.546870+00:00	3		35	1
1321	2017-07-25 21:32:28.534496+03	817	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:53:24.966073+00:00	3		35	1
1322	2017-07-25 21:32:28.537649+03	816	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:52:53.984115+00:00	3		35	1
1323	2017-07-25 21:32:28.540845+03	815	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:52:52.498576+00:00	3		35	1
1324	2017-07-25 21:32:28.544136+03	814	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:52:26.634004+00:00	3		35	1
1325	2017-07-25 21:32:28.547287+03	813	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:52:25.766054+00:00	3		35	1
1326	2017-07-25 21:32:28.550777+03	812	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:51:54.245194+00:00	3		35	1
1327	2017-07-25 21:32:28.554162+03	811	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:51:53.566089+00:00	3		35	1
1328	2017-07-25 21:32:28.557434+03	810	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:51:27.497316+00:00	3		35	1
1329	2017-07-25 21:32:28.568552+03	809	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:51:26.940793+00:00	3		35	1
1330	2017-07-25 21:32:28.57228+03	808	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:50:55.753959+00:00	3		35	1
1331	2017-07-25 21:32:28.575468+03	807	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:50:53.808113+00:00	3		35	1
1332	2017-07-25 21:32:28.578854+03	806	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:50:27.441267+00:00	3		35	1
1333	2017-07-25 21:32:28.5822+03	805	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:50:26.302495+00:00	3		35	1
1334	2017-07-25 21:32:28.585451+03	804	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:49:55.362370+00:00	3		35	1
1335	2017-07-25 21:32:28.588928+03	803	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:49:54.443329+00:00	3		35	1
1336	2017-07-25 21:32:28.59404+03	802	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:46:14.306213+00:00	3		35	1
1337	2017-07-25 21:32:28.597617+03	801	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:46:13.627781+00:00	3		35	1
1338	2017-07-25 21:32:28.600789+03	800	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:45:42.070242+00:00	3		35	1
1339	2017-07-25 21:32:28.603854+03	799	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:45:41.182898+00:00	3		35	1
1340	2017-07-25 21:32:28.607292+03	798	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:45:14.924082+00:00	3		35	1
1341	2017-07-25 21:32:28.610257+03	797	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:45:13.417333+00:00	3		35	1
1342	2017-07-25 21:32:28.613857+03	796	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:44:41.782586+00:00	3		35	1
1343	2017-07-25 21:32:28.61713+03	795	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:44:40.946620+00:00	3		35	1
1344	2017-07-25 21:32:28.620369+03	794	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:38:08.833797+00:00	3		35	1
1345	2017-07-25 21:32:28.62381+03	793	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:38:07.614485+00:00	3		35	1
1346	2017-07-25 21:32:28.627729+03	792	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:37:41.268656+00:00	3		35	1
1347	2017-07-25 21:32:28.631555+03	791	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:37:40.304086+00:00	3		35	1
1348	2017-07-25 21:32:28.635008+03	790	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:37:09.467090+00:00	3		35	1
1349	2017-07-25 21:32:28.638011+03	789	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:37:08.550834+00:00	3		35	1
1350	2017-07-25 21:32:28.641413+03	788	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:36:42.448583+00:00	3		35	1
1351	2017-07-25 21:32:28.645104+03	787	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:36:41.603236+00:00	3		35	1
1352	2017-07-25 21:32:28.648577+03	786	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:36:10.938370+00:00	3		35	1
1353	2017-07-25 21:32:28.651822+03	785	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:36:10.124935+00:00	3		35	1
1354	2017-07-25 21:32:28.662976+03	784	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:35:43.876583+00:00	3		35	1
1355	2017-07-25 21:32:28.667037+03	783	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:35:42.367919+00:00	3		35	1
1356	2017-07-25 21:32:28.670036+03	782	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:35:10.699748+00:00	3		35	1
1357	2017-07-25 21:32:34.604573+03	781	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:35:08.822624+00:00	3		35	1
1358	2017-07-25 21:32:34.618805+03	780	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:34:42.981675+00:00	3		35	1
1359	2017-07-25 21:32:34.622424+03	779	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:34:42.225772+00:00	3		35	1
1360	2017-07-25 21:32:34.625696+03	778	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:34:11.304031+00:00	3		35	1
1361	2017-07-25 21:32:34.628902+03	777	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:34:10.295281+00:00	3		35	1
1362	2017-07-25 21:32:34.632127+03	776	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:33:38.997067+00:00	3		35	1
1363	2017-07-25 21:32:34.635229+03	775	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:33:38.085489+00:00	3		35	1
1364	2017-07-25 21:32:34.638423+03	774	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:33:36.985841+00:00	3		35	1
2325	2017-07-26 11:52:06.300289+03	514	ShoppingListItem object	3		19	1
1365	2017-07-25 21:32:34.641346+03	773	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:33:35.565400+00:00	3		35	1
1366	2017-07-25 21:32:34.644336+03	772	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:32:27.824134+00:00	3		35	1
1367	2017-07-25 21:32:34.648106+03	771	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:32:26.934908+00:00	3		35	1
1368	2017-07-25 21:32:34.650992+03	770	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:31:56.103435+00:00	3		35	1
1369	2017-07-25 21:32:34.654294+03	769	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:31:55.457418+00:00	3		35	1
1370	2017-07-25 21:32:34.657815+03	768	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:31:29.351336+00:00	3		35	1
1371	2017-07-25 21:32:34.661045+03	767	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:31:28.613995+00:00	3		35	1
1372	2017-07-25 21:32:34.664313+03	766	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:30:57.430831+00:00	3		35	1
1373	2017-07-25 21:32:34.667263+03	765	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:30:56.543935+00:00	3		35	1
1374	2017-07-25 21:32:34.670226+03	764	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:30:24.883796+00:00	3		35	1
1375	2017-07-25 21:32:34.673111+03	763	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:30:23.730651+00:00	3		35	1
1376	2017-07-25 21:32:34.676287+03	762	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:29:58.093583+00:00	3		35	1
1377	2017-07-25 21:32:34.679278+03	761	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:29:56.796374+00:00	3		35	1
1378	2017-07-25 21:32:34.682411+03	760	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:29:27.781203+00:00	3		35	1
1379	2017-07-25 21:32:34.686594+03	759	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:29:26.892380+00:00	3		35	1
1380	2017-07-25 21:32:34.697205+03	758	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:29:21.013563+00:00	3		35	1
1381	2017-07-25 21:32:34.701206+03	757	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:29:19.987283+00:00	3		35	1
1382	2017-07-25 21:32:34.713397+03	756	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:27:19.484468+00:00	3		35	1
1383	2017-07-25 21:32:34.717259+03	755	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:27:18.335611+00:00	3		35	1
1384	2017-07-25 21:32:34.720463+03	754	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:27:17.666035+00:00	3		35	1
1385	2017-07-25 21:32:34.72421+03	753	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:27:16.398468+00:00	3		35	1
1386	2017-07-25 21:32:34.729411+03	752	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:27:15.271300+00:00	3		35	1
1387	2017-07-25 21:32:34.733608+03	751	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:27:14.114059+00:00	3		35	1
1388	2017-07-25 21:32:34.736631+03	750	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:27:13.564071+00:00	3		35	1
1389	2017-07-25 21:32:34.739553+03	749	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:27:12.579368+00:00	3		35	1
1390	2017-07-25 21:32:34.743045+03	748	gisModule.tasks.blame_module_check_proposal - 2017-07-21 06:27:11.061327+00:00	3		35	1
1391	2017-07-25 21:32:34.747096+03	747	gisModule.tasks.blame_module_check_blame_status - 2017-07-21 06:27:09.430766+00:00	3		35	1
1392	2017-07-25 21:32:34.75048+03	746	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:22:43.352511+00:00	3		35	1
1393	2017-07-25 21:32:34.753483+03	745	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:22:42.552706+00:00	3		35	1
1394	2017-07-25 21:32:34.756701+03	744	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:22:31.687225+00:00	3		35	1
1395	2017-07-25 21:32:34.760419+03	743	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:22:30.459150+00:00	3		35	1
1396	2017-07-25 21:32:34.764053+03	742	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:22:23.925085+00:00	3		35	1
1397	2017-07-25 21:32:34.775211+03	741	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:22:22.764790+00:00	3		35	1
1398	2017-07-25 21:32:34.779376+03	740	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:22:11.881702+00:00	3		35	1
1399	2017-07-25 21:32:34.782849+03	739	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:22:10.727567+00:00	3		35	1
1400	2017-07-25 21:32:34.786028+03	738	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:22:04.263098+00:00	3		35	1
1401	2017-07-25 21:32:34.789159+03	737	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:22:03.113684+00:00	3		35	1
1402	2017-07-25 21:32:34.79248+03	736	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:21:51.513825+00:00	3		35	1
1403	2017-07-25 21:32:34.796996+03	735	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:21:50.138272+00:00	3		35	1
1404	2017-07-25 21:32:34.800073+03	734	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:21:44.525345+00:00	3		35	1
1405	2017-07-25 21:32:34.803267+03	733	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:21:43.178161+00:00	3		35	1
1406	2017-07-25 21:32:34.806461+03	732	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:21:31.750805+00:00	3		35	1
1407	2017-07-25 21:32:34.810653+03	731	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:21:30.414229+00:00	3		35	1
1408	2017-07-25 21:32:34.815437+03	730	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:21:24.473667+00:00	3		35	1
1409	2017-07-25 21:32:34.818714+03	729	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:21:23.269523+00:00	3		35	1
1410	2017-07-25 21:32:34.821688+03	728	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:21:12.423814+00:00	3		35	1
1411	2017-07-25 21:32:34.82456+03	727	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:21:11.108340+00:00	3		35	1
1412	2017-07-25 21:32:34.82976+03	726	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:21:05.464057+00:00	3		35	1
1413	2017-07-25 21:32:34.833092+03	725	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:21:03.937470+00:00	3		35	1
1414	2017-07-25 21:32:34.836274+03	724	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:20:53.310053+00:00	3		35	1
1415	2017-07-25 21:32:34.839518+03	723	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:20:51.826111+00:00	3		35	1
1416	2017-07-25 21:32:34.84341+03	722	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:20:41.024043+00:00	3		35	1
1417	2017-07-25 21:32:34.8484+03	721	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:20:39.695921+00:00	3		35	1
1418	2017-07-25 21:32:34.851701+03	720	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:20:33.541794+00:00	3		35	1
1419	2017-07-25 21:32:34.854707+03	719	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:20:32.481939+00:00	3		35	1
1420	2017-07-25 21:32:34.858226+03	718	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:20:25.947805+00:00	3		35	1
2326	2017-07-26 11:52:06.313249+03	513	ShoppingListItem object	3		19	1
1421	2017-07-25 21:32:34.862101+03	717	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:20:24.453638+00:00	3		35	1
1422	2017-07-25 21:32:34.865263+03	716	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:20:13.329690+00:00	3		35	1
1423	2017-07-25 21:32:34.868525+03	715	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:20:12.548663+00:00	3		35	1
1424	2017-07-25 21:32:34.871764+03	714	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:20:01.250831+00:00	3		35	1
1425	2017-07-25 21:32:34.875065+03	713	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:20:00.263709+00:00	3		35	1
1426	2017-07-25 21:32:34.878595+03	712	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:19:54.559786+00:00	3		35	1
1427	2017-07-25 21:32:34.888155+03	711	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:19:53.334746+00:00	3		35	1
1428	2017-07-25 21:32:34.891896+03	710	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:17:20.113911+00:00	3		35	1
1429	2017-07-25 21:32:34.895187+03	709	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:17:19.518467+00:00	3		35	1
1430	2017-07-25 21:32:34.899159+03	708	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:17:08.829071+00:00	3		35	1
1431	2017-07-25 21:32:34.902427+03	707	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:17:07.375298+00:00	3		35	1
1432	2017-07-25 21:32:34.90579+03	706	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:17:01.065129+00:00	3		35	1
1433	2017-07-25 21:32:34.909513+03	705	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:16:59.533637+00:00	3		35	1
1434	2017-07-25 21:32:34.913189+03	704	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:16:48.457204+00:00	3		35	1
1435	2017-07-25 21:32:34.916529+03	703	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:16:47.246967+00:00	3		35	1
1436	2017-07-25 21:32:34.919773+03	702	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:15:56.009370+00:00	3		35	1
1437	2017-07-25 21:32:34.923139+03	701	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:15:54.524893+00:00	3		35	1
1438	2017-07-25 21:32:34.926608+03	700	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:15:43.936827+00:00	3		35	1
1439	2017-07-25 21:32:34.930392+03	699	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:15:43.296415+00:00	3		35	1
1440	2017-07-25 21:32:34.933647+03	698	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:15:37.550091+00:00	3		35	1
1441	2017-07-25 21:32:34.936738+03	697	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:15:36.646274+00:00	3		35	1
1442	2017-07-25 21:32:34.939803+03	696	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:15:25.672837+00:00	3		35	1
1443	2017-07-25 21:32:34.943756+03	695	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:15:24.515110+00:00	3		35	1
1444	2017-07-25 21:32:34.947375+03	694	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:15:18.444086+00:00	3		35	1
1445	2017-07-25 21:32:34.950296+03	693	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:15:16.984547+00:00	3		35	1
1446	2017-07-25 21:32:34.959252+03	692	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:15:06.137567+00:00	3		35	1
1447	2017-07-25 21:32:34.963053+03	691	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:15:04.907518+00:00	3		35	1
1448	2017-07-25 21:32:34.96659+03	690	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:13:33.605212+00:00	3		35	1
1449	2017-07-25 21:32:34.97+03	689	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:13:32.393149+00:00	3		35	1
1450	2017-07-25 21:32:34.973415+03	688	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:13:20.832656+00:00	3		35	1
1451	2017-07-25 21:32:34.977355+03	687	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:13:20.205154+00:00	3		35	1
1452	2017-07-25 21:32:34.980847+03	686	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:13:14.047712+00:00	3		35	1
1453	2017-07-25 21:32:34.984081+03	685	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:13:12.698756+00:00	3		35	1
1454	2017-07-25 21:32:34.987294+03	684	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:13:01.804639+00:00	3		35	1
1455	2017-07-25 21:32:34.990751+03	683	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:13:01.041421+00:00	3		35	1
1456	2017-07-25 21:32:34.994346+03	682	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:12:55.465758+00:00	3		35	1
1457	2017-07-25 21:32:43.792375+03	681	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:12:54.269451+00:00	3		35	1
1458	2017-07-25 21:32:43.798065+03	680	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:12:42.826006+00:00	3		35	1
1459	2017-07-25 21:32:43.802266+03	679	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:12:41.494132+00:00	3		35	1
1460	2017-07-25 21:32:43.807271+03	678	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:12:30.873985+00:00	3		35	1
1461	2017-07-25 21:32:43.816697+03	677	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:12:29.757569+00:00	3		35	1
1462	2017-07-25 21:32:43.820394+03	676	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:12:23.760121+00:00	3		35	1
1463	2017-07-25 21:32:43.824302+03	675	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:12:22.753043+00:00	3		35	1
1464	2017-07-25 21:32:43.827729+03	674	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:12:09.521192+00:00	3		35	1
1465	2017-07-25 21:32:43.832037+03	673	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:12:08.033009+00:00	3		35	1
1466	2017-07-25 21:32:43.837071+03	672	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:11:57.310577+00:00	3		35	1
1467	2017-07-25 21:32:43.841896+03	671	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:11:56.395529+00:00	3		35	1
1468	2017-07-25 21:32:43.845867+03	670	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:11:45.455793+00:00	3		35	1
1469	2017-07-25 21:32:43.849254+03	669	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:11:44.674954+00:00	3		35	1
1470	2017-07-25 21:32:43.859573+03	668	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:11:38.197331+00:00	3		35	1
1471	2017-07-25 21:32:43.865207+03	667	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:11:36.723360+00:00	3		35	1
1472	2017-07-25 21:32:43.869744+03	666	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:11:26.045422+00:00	3		35	1
1473	2017-07-25 21:32:43.882121+03	665	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:11:24.553505+00:00	3		35	1
1474	2017-07-25 21:32:43.887392+03	664	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:11:18.943706+00:00	3		35	1
1475	2017-07-25 21:32:43.893543+03	663	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:11:18.060553+00:00	3		35	1
1476	2017-07-25 21:32:43.900007+03	662	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:11:06.489100+00:00	3		35	1
2327	2017-07-26 11:52:06.317779+03	512	ShoppingListItem object	3		19	1
1477	2017-07-25 21:32:43.903605+03	661	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:11:05.259899+00:00	3		35	1
1478	2017-07-25 21:32:43.908373+03	660	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:10:59.057577+00:00	3		35	1
1479	2017-07-25 21:32:43.913256+03	659	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:10:58.473536+00:00	3		35	1
1480	2017-07-25 21:32:43.917273+03	658	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:10:47.888230+00:00	3		35	1
1481	2017-07-25 21:32:43.920293+03	657	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:10:46.754965+00:00	3		35	1
1482	2017-07-25 21:32:43.923593+03	656	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:10:35.908332+00:00	3		35	1
1483	2017-07-25 21:32:43.927023+03	655	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:10:34.439801+00:00	3		35	1
1484	2017-07-25 21:32:43.931681+03	654	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:10:28.057246+00:00	3		35	1
1485	2017-07-25 21:32:43.93497+03	653	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:10:27.122059+00:00	3		35	1
1486	2017-07-25 21:32:43.940969+03	652	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:10:15.601395+00:00	3		35	1
1487	2017-07-25 21:32:43.946483+03	651	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:10:14.221877+00:00	3		35	1
1488	2017-07-25 21:32:43.950407+03	650	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:10:07.778698+00:00	3		35	1
1489	2017-07-25 21:32:43.95351+03	649	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:10:06.263533+00:00	3		35	1
1490	2017-07-25 21:32:43.95856+03	648	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:09:54.820777+00:00	3		35	1
1491	2017-07-25 21:32:43.961651+03	647	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:09:54.240081+00:00	3		35	1
1492	2017-07-25 21:32:43.974271+03	646	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:09:47.745224+00:00	3		35	1
1493	2017-07-25 21:32:43.978255+03	645	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:09:46.244555+00:00	3		35	1
1494	2017-07-25 21:32:43.982206+03	644	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:09:14.933206+00:00	3		35	1
1495	2017-07-25 21:32:43.99262+03	643	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:09:14.231444+00:00	3		35	1
1496	2017-07-25 21:32:43.997025+03	642	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:09:08.397785+00:00	3		35	1
1497	2017-07-25 21:32:44.001088+03	641	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:09:06.833277+00:00	3		35	1
1498	2017-07-25 21:32:44.004237+03	640	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:55.770922+00:00	3		35	1
1499	2017-07-25 21:32:44.009024+03	639	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:54.615804+00:00	3		35	1
1500	2017-07-25 21:32:44.012577+03	638	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:48.282636+00:00	3		35	1
1501	2017-07-25 21:32:44.016685+03	637	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:47.400571+00:00	3		35	1
1502	2017-07-25 21:32:44.020778+03	636	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:36.798226+00:00	3		35	1
1503	2017-07-25 21:32:44.023953+03	635	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:36.178303+00:00	3		35	1
1504	2017-07-25 21:32:44.027327+03	634	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:34.763345+00:00	3		35	1
1505	2017-07-25 21:32:44.030788+03	633	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:33.821648+00:00	3		35	1
1506	2017-07-25 21:32:44.034728+03	632	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:32.380631+00:00	3		35	1
1507	2017-07-25 21:32:44.037898+03	631	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:31.341362+00:00	3		35	1
1508	2017-07-25 21:32:44.041296+03	630	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:30.287326+00:00	3		35	1
1509	2017-07-25 21:32:44.045565+03	629	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:28.982330+00:00	3		35	1
1510	2017-07-25 21:32:44.0499+03	628	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:28.262335+00:00	3		35	1
1511	2017-07-25 21:32:44.053152+03	627	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:27.016247+00:00	3		35	1
1512	2017-07-25 21:32:44.056137+03	626	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:26.271540+00:00	3		35	1
1513	2017-07-25 21:32:44.060057+03	625	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:25.161893+00:00	3		35	1
1514	2017-07-25 21:32:44.066792+03	624	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:24.133033+00:00	3		35	1
1515	2017-07-25 21:32:44.070427+03	623	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:22.934882+00:00	3		35	1
1516	2017-07-25 21:32:44.073625+03	622	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:22.069583+00:00	3		35	1
1517	2017-07-25 21:32:44.076946+03	621	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:21.377728+00:00	3		35	1
1518	2017-07-25 21:32:44.081618+03	620	gisModule.tasks.blame_module_check_proposal - 2017-07-15 13:08:19.946932+00:00	3		35	1
1519	2017-07-25 21:32:44.084933+03	619	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 13:08:18.402411+00:00	3		35	1
1520	2017-07-25 21:32:44.088163+03	618	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:09:50.216795+00:00	3		35	1
1521	2017-07-25 21:32:44.091599+03	617	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:09:49.112799+00:00	3		35	1
1522	2017-07-25 21:32:44.09514+03	616	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:09:38.488594+00:00	3		35	1
1523	2017-07-25 21:32:44.099953+03	615	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:09:37.710645+00:00	3		35	1
1524	2017-07-25 21:32:44.103554+03	614	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:09:26.996251+00:00	3		35	1
1525	2017-07-25 21:32:44.106955+03	613	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:09:25.735724+00:00	3		35	1
1526	2017-07-25 21:32:44.110828+03	612	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:09:19.784206+00:00	3		35	1
1527	2017-07-25 21:32:44.114024+03	611	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:09:18.407587+00:00	3		35	1
1528	2017-07-25 21:32:44.11703+03	610	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:09:07.462621+00:00	3		35	1
1529	2017-07-25 21:32:44.12011+03	609	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:09:06.516702+00:00	3		35	1
1530	2017-07-25 21:32:44.123114+03	608	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:08:55.716541+00:00	3		35	1
1531	2017-07-25 21:32:44.126257+03	607	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:08:54.990163+00:00	3		35	1
1532	2017-07-25 21:32:44.130538+03	606	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:08:49.158362+00:00	3		35	1
2328	2017-07-26 11:52:06.329579+03	511	ShoppingListItem object	3		19	1
1533	2017-07-25 21:32:44.133656+03	605	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:08:47.711048+00:00	3		35	1
1534	2017-07-25 21:32:44.136643+03	604	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:08:36.894372+00:00	3		35	1
1535	2017-07-25 21:32:44.140059+03	603	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:08:36.130961+00:00	3		35	1
1536	2017-07-25 21:32:44.144473+03	602	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:08:30.492377+00:00	3		35	1
1537	2017-07-25 21:32:44.147948+03	601	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:08:29.094897+00:00	3		35	1
1538	2017-07-25 21:32:44.151287+03	600	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:08:18.428338+00:00	3		35	1
1539	2017-07-25 21:32:44.155045+03	599	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:08:17.364072+00:00	3		35	1
1540	2017-07-25 21:32:44.15907+03	598	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:08:06.240843+00:00	3		35	1
1541	2017-07-25 21:32:44.163921+03	597	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:08:05.370380+00:00	3		35	1
1542	2017-07-25 21:32:44.167309+03	596	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:07:59.625559+00:00	3		35	1
1543	2017-07-25 21:32:44.180069+03	595	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:07:58.094278+00:00	3		35	1
1544	2017-07-25 21:32:44.184505+03	594	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:07:47.217642+00:00	3		35	1
1545	2017-07-25 21:32:44.187657+03	593	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:07:46.571655+00:00	3		35	1
1546	2017-07-25 21:32:44.191047+03	592	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:07:40.552965+00:00	3		35	1
1547	2017-07-25 21:32:44.194944+03	591	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:07:39.096709+00:00	3		35	1
1548	2017-07-25 21:32:44.199137+03	590	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:07:27.996330+00:00	3		35	1
1549	2017-07-25 21:32:44.203577+03	589	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:07:27.423369+00:00	3		35	1
1550	2017-07-25 21:32:44.207011+03	588	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:07:21.115603+00:00	3		35	1
1551	2017-07-25 21:32:44.210974+03	587	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:07:19.546959+00:00	3		35	1
1552	2017-07-25 21:32:44.214591+03	586	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:07:08.425350+00:00	3		35	1
1553	2017-07-25 21:32:44.218384+03	585	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:07:07.386325+00:00	3		35	1
1554	2017-07-25 21:32:44.221712+03	584	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:06:55.920337+00:00	3		35	1
1555	2017-07-25 21:32:44.224771+03	583	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:06:54.677746+00:00	3		35	1
1556	2017-07-25 21:32:44.228575+03	582	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:06:49.097077+00:00	3		35	1
1557	2017-07-25 21:32:44.233911+03	581	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:06:47.674644+00:00	3		35	1
1558	2017-07-25 21:32:44.237185+03	580	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:06:36.932123+00:00	3		35	1
1559	2017-07-25 21:32:44.240328+03	579	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:06:35.647704+00:00	3		35	1
1560	2017-07-25 21:32:44.244141+03	578	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:06:29.474955+00:00	3		35	1
1561	2017-07-25 21:32:44.25551+03	577	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:06:28.500461+00:00	3		35	1
1562	2017-07-25 21:32:44.25917+03	576	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:06:17.008738+00:00	3		35	1
1563	2017-07-25 21:32:44.262903+03	575	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:06:15.938993+00:00	3		35	1
1564	2017-07-25 21:32:44.266518+03	574	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:06:09.476228+00:00	3		35	1
1565	2017-07-25 21:32:44.269817+03	573	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:06:08.598584+00:00	3		35	1
1566	2017-07-25 21:32:44.272998+03	572	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:05:57.331829+00:00	3		35	1
1567	2017-07-25 21:32:44.284748+03	571	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:05:56.721742+00:00	3		35	1
1568	2017-07-25 21:32:44.288875+03	570	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:05:50.404293+00:00	3		35	1
1569	2017-07-25 21:32:44.292812+03	569	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:05:49.086889+00:00	3		35	1
1570	2017-07-25 21:32:44.296206+03	568	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:05:38.182410+00:00	3		35	1
1571	2017-07-25 21:32:44.299807+03	567	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:05:37.540232+00:00	3		35	1
1572	2017-07-25 21:32:44.303249+03	566	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:05:26.451085+00:00	3		35	1
1573	2017-07-25 21:32:44.306521+03	565	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:05:24.928738+00:00	3		35	1
1574	2017-07-25 21:32:44.309679+03	564	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:05:18.551808+00:00	3		35	1
1575	2017-07-25 21:32:44.312988+03	563	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:05:17.201349+00:00	3		35	1
1576	2017-07-25 21:32:44.316051+03	562	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:05:06.541893+00:00	3		35	1
1577	2017-07-25 21:32:44.319267+03	561	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:05:05.767051+00:00	3		35	1
1578	2017-07-25 21:32:44.323127+03	560	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:04:59.565234+00:00	3		35	1
1579	2017-07-25 21:32:44.326671+03	559	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:04:58.627448+00:00	3		35	1
1580	2017-07-25 21:32:44.330313+03	558	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:04:47.948743+00:00	3		35	1
1581	2017-07-25 21:32:44.340658+03	557	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:04:46.694556+00:00	3		35	1
1582	2017-07-25 21:32:44.344318+03	556	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:04:40.746440+00:00	3		35	1
1583	2017-07-25 21:32:44.347818+03	555	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:04:39.403421+00:00	3		35	1
1584	2017-07-25 21:32:44.351369+03	554	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:04:28.278268+00:00	3		35	1
1585	2017-07-25 21:32:44.355267+03	553	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:04:27.229087+00:00	3		35	1
1586	2017-07-25 21:32:44.358971+03	552	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:04:16.293323+00:00	3		35	1
1587	2017-07-25 21:32:44.362193+03	551	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:04:14.948195+00:00	3		35	1
1588	2017-07-25 21:32:44.36575+03	550	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:04:08.862568+00:00	3		35	1
2329	2017-07-26 11:52:06.333567+03	510	ShoppingListItem object	3		19	1
1589	2017-07-25 21:32:44.369134+03	549	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:04:08.133001+00:00	3		35	1
1590	2017-07-25 21:32:44.372507+03	548	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:03:56.826032+00:00	3		35	1
1591	2017-07-25 21:32:44.377849+03	547	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:03:55.427094+00:00	3		35	1
1592	2017-07-25 21:32:44.38277+03	546	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:03:49.240695+00:00	3		35	1
1593	2017-07-25 21:32:44.386117+03	545	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:03:47.972067+00:00	3		35	1
1594	2017-07-25 21:32:44.39005+03	544	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:03:37.225384+00:00	3		35	1
1595	2017-07-25 21:32:44.394614+03	543	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:03:35.894866+00:00	3		35	1
1596	2017-07-25 21:32:44.399047+03	542	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:03:29.524722+00:00	3		35	1
1597	2017-07-25 21:32:44.403443+03	541	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:03:28.800201+00:00	3		35	1
1598	2017-07-25 21:32:44.407128+03	540	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:03:18.004672+00:00	3		35	1
1599	2017-07-25 21:32:44.411865+03	539	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:03:17.348179+00:00	3		35	1
1600	2017-07-25 21:32:44.416642+03	538	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:03:10.891782+00:00	3		35	1
1601	2017-07-25 21:32:44.421869+03	537	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:03:09.398258+00:00	3		35	1
1602	2017-07-25 21:32:44.425014+03	536	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:58.486935+00:00	3		35	1
1603	2017-07-25 21:32:44.429669+03	535	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:02:57.303622+00:00	3		35	1
1604	2017-07-25 21:32:44.434008+03	534	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:46.208573+00:00	3		35	1
1605	2017-07-25 21:32:44.437004+03	533	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:02:45.527622+00:00	3		35	1
1606	2017-07-25 21:32:44.441161+03	532	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:39.500004+00:00	3		35	1
1607	2017-07-25 21:32:44.445546+03	531	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:02:38.402219+00:00	3		35	1
1608	2017-07-25 21:32:44.449164+03	530	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:27.397142+00:00	3		35	1
1609	2017-07-25 21:32:44.453154+03	529	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:02:26.604982+00:00	3		35	1
1610	2017-07-25 21:32:44.460217+03	528	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:20.401060+00:00	3		35	1
1611	2017-07-25 21:32:44.463955+03	527	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:02:19.391692+00:00	3		35	1
1612	2017-07-25 21:32:44.467671+03	526	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:08.062839+00:00	3		35	1
1613	2017-07-25 21:32:44.471874+03	525	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:02:06.776579+00:00	3		35	1
1614	2017-07-25 21:32:44.475643+03	524	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:02:00.225621+00:00	3		35	1
1615	2017-07-25 21:32:44.48003+03	523	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:01:59.435148+00:00	3		35	1
1616	2017-07-25 21:32:44.484369+03	522	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:01:47.935504+00:00	3		35	1
1617	2017-07-25 21:32:44.488574+03	521	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:01:47.378313+00:00	3		35	1
1618	2017-07-25 21:32:44.493858+03	520	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:01:35.931620+00:00	3		35	1
1619	2017-07-25 21:32:44.502383+03	519	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:01:34.867789+00:00	3		35	1
1620	2017-07-25 21:32:44.514519+03	518	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:01:28.513988+00:00	3		35	1
1621	2017-07-25 21:32:44.518498+03	517	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:01:27.297798+00:00	3		35	1
1622	2017-07-25 21:32:44.521462+03	516	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:01:16.122993+00:00	3		35	1
1623	2017-07-25 21:32:44.525754+03	515	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:01:15.040753+00:00	3		35	1
1624	2017-07-25 21:32:44.532329+03	514	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:01:09.396175+00:00	3		35	1
1625	2017-07-25 21:32:44.537042+03	513	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:01:08.114746+00:00	3		35	1
1626	2017-07-25 21:32:44.540904+03	512	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:00:57.525637+00:00	3		35	1
1627	2017-07-25 21:32:44.546975+03	511	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:00:56.768854+00:00	3		35	1
1628	2017-07-25 21:32:44.550478+03	510	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:00:45.528702+00:00	3		35	1
1629	2017-07-25 21:32:44.553997+03	509	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:00:44.610720+00:00	3		35	1
1630	2017-07-25 21:32:44.557728+03	508	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:00:38.791594+00:00	3		35	1
1631	2017-07-25 21:32:44.562945+03	507	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:00:38.056364+00:00	3		35	1
1632	2017-07-25 21:32:44.566478+03	506	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:00:27.252035+00:00	3		35	1
1633	2017-07-25 21:32:44.578138+03	505	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:00:26.204240+00:00	3		35	1
1634	2017-07-25 21:32:44.582421+03	504	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:00:20.430279+00:00	3		35	1
1635	2017-07-25 21:32:44.586628+03	503	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:00:19.161582+00:00	3		35	1
1636	2017-07-25 21:32:44.59061+03	502	gisModule.tasks.blame_module_check_proposal - 2017-07-15 12:00:08.406064+00:00	3		35	1
1637	2017-07-25 21:32:44.594523+03	501	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 12:00:07.212571+00:00	3		35	1
1638	2017-07-25 21:32:44.598952+03	500	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:59:56.063915+00:00	3		35	1
1639	2017-07-25 21:32:44.603398+03	499	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:59:55.004280+00:00	3		35	1
1640	2017-07-25 21:32:44.606562+03	498	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:59:48.987388+00:00	3		35	1
1641	2017-07-25 21:32:44.611678+03	497	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:59:47.999643+00:00	3		35	1
1642	2017-07-25 21:32:44.615454+03	496	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:59:36.799025+00:00	3		35	1
1643	2017-07-25 21:32:44.618488+03	495	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:59:36.241606+00:00	3		35	1
1644	2017-07-25 21:32:44.621379+03	494	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:59:30.375421+00:00	3		35	1
2330	2017-07-26 11:52:06.33749+03	509	ShoppingListItem object	3		19	1
1645	2017-07-25 21:32:44.625366+03	493	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:59:29.174575+00:00	3		35	1
1646	2017-07-25 21:32:44.629176+03	492	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:59:18.553067+00:00	3		35	1
1647	2017-07-25 21:32:44.633777+03	491	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:59:17.662174+00:00	3		35	1
1648	2017-07-25 21:32:44.63677+03	490	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:59:06.615342+00:00	3		35	1
1649	2017-07-25 21:32:44.639815+03	489	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:59:05.276725+00:00	3		35	1
1650	2017-07-25 21:32:44.646779+03	488	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:58:59.327335+00:00	3		35	1
1651	2017-07-25 21:32:44.651799+03	487	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:58:58.661585+00:00	3		35	1
1652	2017-07-25 21:32:44.65662+03	486	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:58:47.536316+00:00	3		35	1
1653	2017-07-25 21:32:44.659877+03	485	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:58:46.745537+00:00	3		35	1
1654	2017-07-25 21:32:44.663856+03	484	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:58:35.501370+00:00	3		35	1
1655	2017-07-25 21:32:44.668077+03	483	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:58:34.614374+00:00	3		35	1
1656	2017-07-25 21:32:44.68072+03	482	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:58:28.664306+00:00	3		35	1
1657	2017-07-25 21:32:44.685337+03	481	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:58:27.966232+00:00	3		35	1
1658	2017-07-25 21:32:44.690476+03	480	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:58:17.079087+00:00	3		35	1
1659	2017-07-25 21:32:44.694767+03	479	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:58:15.981559+00:00	3		35	1
1660	2017-07-25 21:32:44.701441+03	478	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:58:10.215281+00:00	3		35	1
1661	2017-07-25 21:32:44.717022+03	477	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:58:09.035075+00:00	3		35	1
1662	2017-07-25 21:32:44.722757+03	476	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:57:58.065764+00:00	3		35	1
1663	2017-07-25 21:32:44.72908+03	475	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:57:56.940571+00:00	3		35	1
1664	2017-07-25 21:32:44.7332+03	474	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:57:50.630075+00:00	3		35	1
1665	2017-07-25 21:32:44.736511+03	473	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:57:49.251568+00:00	3		35	1
1666	2017-07-25 21:32:44.739523+03	472	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:57:38.133237+00:00	3		35	1
1667	2017-07-25 21:32:44.742562+03	471	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:57:36.620001+00:00	3		35	1
1668	2017-07-25 21:32:44.746051+03	470	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:57:30.552700+00:00	3		35	1
1669	2017-07-25 21:32:44.74908+03	469	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:57:29.223873+00:00	3		35	1
1670	2017-07-25 21:32:44.752477+03	468	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:57:18.279444+00:00	3		35	1
1671	2017-07-25 21:32:44.757601+03	467	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:57:17.158420+00:00	3		35	1
1672	2017-07-25 21:32:44.762164+03	466	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:57:05.813642+00:00	3		35	1
1673	2017-07-25 21:32:44.767457+03	465	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:57:04.844064+00:00	3		35	1
1674	2017-07-25 21:32:44.770534+03	464	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:56:58.321165+00:00	3		35	1
1675	2017-07-25 21:32:44.773451+03	463	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:56:57.079907+00:00	3		35	1
1676	2017-07-25 21:32:44.778145+03	462	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:56:46.146336+00:00	3		35	1
1677	2017-07-25 21:32:44.782923+03	461	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:56:45.409945+00:00	3		35	1
1678	2017-07-25 21:32:44.787149+03	460	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:56:39.248536+00:00	3		35	1
1679	2017-07-25 21:32:44.793041+03	459	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:56:38.132214+00:00	3		35	1
1680	2017-07-25 21:32:44.796632+03	458	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:56:27.128766+00:00	3		35	1
1681	2017-07-25 21:32:44.800127+03	457	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:56:26.495339+00:00	3		35	1
1682	2017-07-25 21:32:44.805318+03	456	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:56:20.277213+00:00	3		35	1
1683	2017-07-25 21:32:44.808506+03	455	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:56:18.907400+00:00	3		35	1
1684	2017-07-25 21:32:44.812282+03	454	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:56:07.396545+00:00	3		35	1
1685	2017-07-25 21:32:44.815667+03	453	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:56:06.676490+00:00	3		35	1
1686	2017-07-25 21:32:44.820101+03	452	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:55:55.931713+00:00	3		35	1
1687	2017-07-25 21:32:44.823442+03	451	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:55:55.041819+00:00	3		35	1
1688	2017-07-25 21:32:44.830564+03	450	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:55:48.541657+00:00	3		35	1
1689	2017-07-25 21:32:44.834337+03	449	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:55:47.136725+00:00	3		35	1
1690	2017-07-25 21:32:44.837744+03	448	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:55:35.985922+00:00	3		35	1
1691	2017-07-25 21:32:44.840714+03	447	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:55:35.278548+00:00	3		35	1
1692	2017-07-25 21:32:44.843853+03	446	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:55:29.181505+00:00	3		35	1
1693	2017-07-25 21:32:44.84766+03	445	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:55:28.329714+00:00	3		35	1
1694	2017-07-25 21:32:44.860573+03	444	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:55:16.978870+00:00	3		35	1
1695	2017-07-25 21:32:44.864452+03	443	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:55:16.166250+00:00	3		35	1
1696	2017-07-25 21:32:44.867767+03	442	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:55:09.901673+00:00	3		35	1
1697	2017-07-25 21:32:44.870659+03	441	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:55:08.631370+00:00	3		35	1
1698	2017-07-25 21:32:44.873494+03	440	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:54:57.182646+00:00	3		35	1
1699	2017-07-25 21:32:44.876628+03	439	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:54:55.902391+00:00	3		35	1
1700	2017-07-25 21:32:44.880213+03	438	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:54:49.391864+00:00	3		35	1
2331	2017-07-26 11:52:06.341845+03	508	ShoppingListItem object	3		19	1
1701	2017-07-25 21:32:44.883186+03	437	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:54:48.272969+00:00	3		35	1
1702	2017-07-25 21:32:44.886238+03	436	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:54:36.847084+00:00	3		35	1
1703	2017-07-25 21:32:44.889326+03	435	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:54:36.029703+00:00	3		35	1
1704	2017-07-25 21:32:44.892577+03	434	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:54:29.620485+00:00	3		35	1
1705	2017-07-25 21:32:44.896019+03	433	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:54:28.120155+00:00	3		35	1
1706	2017-07-25 21:32:44.899795+03	432	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:54:17.484670+00:00	3		35	1
1707	2017-07-25 21:32:44.903537+03	431	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:54:15.992836+00:00	3		35	1
1708	2017-07-25 21:32:44.907625+03	430	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:54:09.667254+00:00	3		35	1
1709	2017-07-25 21:32:44.911817+03	429	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:54:08.583784+00:00	3		35	1
1710	2017-07-25 21:32:44.915371+03	428	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:57.046902+00:00	3		35	1
1711	2017-07-25 21:32:44.918549+03	427	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:53:56.056729+00:00	3		35	1
1712	2017-07-25 21:32:44.921684+03	426	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:49.597733+00:00	3		35	1
1713	2017-07-25 21:32:44.924766+03	425	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:53:48.316142+00:00	3		35	1
1714	2017-07-25 21:32:44.928251+03	424	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:37.376591+00:00	3		35	1
1715	2017-07-25 21:32:44.931443+03	423	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:53:36.766262+00:00	3		35	1
1716	2017-07-25 21:32:44.934733+03	422	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:30.770093+00:00	3		35	1
1717	2017-07-25 21:32:44.93815+03	421	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:53:29.581359+00:00	3		35	1
1718	2017-07-25 21:32:44.941285+03	420	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:18.599705+00:00	3		35	1
1719	2017-07-25 21:32:44.945191+03	419	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:53:17.398887+00:00	3		35	1
1720	2017-07-25 21:32:44.949167+03	418	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:06.385499+00:00	3		35	1
1721	2017-07-25 21:32:44.952398+03	417	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:53:05.607026+00:00	3		35	1
1722	2017-07-25 21:32:44.955491+03	416	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:53:00.021025+00:00	3		35	1
1723	2017-07-25 21:32:44.958512+03	415	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:52:59.418703+00:00	3		35	1
1724	2017-07-25 21:32:44.961638+03	414	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:52:48.378208+00:00	3		35	1
1725	2017-07-25 21:32:44.964668+03	413	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:52:47.428675+00:00	3		35	1
1726	2017-07-25 21:32:44.968101+03	412	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:52:36.199037+00:00	3		35	1
1727	2017-07-25 21:32:44.97134+03	411	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:52:35.609991+00:00	3		35	1
1728	2017-07-25 21:32:44.974507+03	410	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:52:29.176524+00:00	3		35	1
1729	2017-07-25 21:32:44.978343+03	409	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:52:28.028585+00:00	3		35	1
1730	2017-07-25 21:32:44.981796+03	408	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:52:16.574621+00:00	3		35	1
1731	2017-07-25 21:32:44.985005+03	407	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:52:15.321306+00:00	3		35	1
1732	2017-07-25 21:32:44.988098+03	406	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:52:08.880141+00:00	3		35	1
1733	2017-07-25 21:32:44.991231+03	405	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:52:07.435250+00:00	3		35	1
1734	2017-07-25 21:32:44.994525+03	404	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:51:56.762077+00:00	3		35	1
1735	2017-07-25 21:32:44.997593+03	403	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:51:56.129537+00:00	3		35	1
1736	2017-07-25 21:32:45.001492+03	402	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:51:49.651280+00:00	3		35	1
1737	2017-07-25 21:32:45.004453+03	401	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:51:48.742436+00:00	3		35	1
1738	2017-07-25 21:32:45.007405+03	400	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:51:37.555394+00:00	3		35	1
1739	2017-07-25 21:32:45.010768+03	399	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:51:36.064039+00:00	3		35	1
1740	2017-07-25 21:32:45.014077+03	398	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:51:30.126759+00:00	3		35	1
1741	2017-07-25 21:32:45.017412+03	397	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:51:29.139420+00:00	3		35	1
1742	2017-07-25 21:32:45.020545+03	396	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:51:17.659323+00:00	3		35	1
1743	2017-07-25 21:32:45.02379+03	395	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:51:16.822894+00:00	3		35	1
1744	2017-07-25 21:32:45.026951+03	394	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:51:06.163531+00:00	3		35	1
1745	2017-07-25 21:32:45.030577+03	393	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:51:05.285494+00:00	3		35	1
1746	2017-07-25 21:32:45.033869+03	392	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:50:59.290199+00:00	3		35	1
1747	2017-07-25 21:32:45.037181+03	391	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:50:58.021499+00:00	3		35	1
1748	2017-07-25 21:32:45.040411+03	390	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:50:47.419553+00:00	3		35	1
1749	2017-07-25 21:32:45.04509+03	389	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:50:46.716934+00:00	3		35	1
1750	2017-07-25 21:32:45.049587+03	388	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:50:40.243004+00:00	3		35	1
1751	2017-07-25 21:32:45.053293+03	387	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:50:39.121121+00:00	3		35	1
1752	2017-07-25 21:32:45.056874+03	386	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:50:28.411287+00:00	3		35	1
1753	2017-07-25 21:32:45.061417+03	385	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:50:26.982283+00:00	3		35	1
1754	2017-07-25 21:32:45.06548+03	384	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:50:16.088680+00:00	3		35	1
1755	2017-07-25 21:32:45.080568+03	383	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:50:14.812036+00:00	3		35	1
1756	2017-07-25 21:32:45.086228+03	382	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:50:09.144391+00:00	3		35	1
2332	2017-07-26 11:59:26.329982+03	28	FalsePriceProposal object	3		37	1
1757	2017-07-25 21:32:45.090492+03	381	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:50:07.634969+00:00	3		35	1
1758	2017-07-25 21:32:45.094697+03	380	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:57.011336+00:00	3		35	1
1759	2017-07-25 21:32:45.098489+03	379	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:49:56.148442+00:00	3		35	1
1760	2017-07-25 21:32:45.101632+03	378	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:50.134676+00:00	3		35	1
1761	2017-07-25 21:32:45.104867+03	377	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:49:49.285478+00:00	3		35	1
1762	2017-07-25 21:32:45.110529+03	376	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:38.660360+00:00	3		35	1
1763	2017-07-25 21:32:45.117151+03	375	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:49:37.876933+00:00	3		35	1
1764	2017-07-25 21:32:45.123166+03	374	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:27.106998+00:00	3		35	1
1765	2017-07-25 21:32:45.126222+03	373	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:49:25.789894+00:00	3		35	1
1766	2017-07-25 21:32:45.130183+03	372	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:19.465144+00:00	3		35	1
1767	2017-07-25 21:32:45.142117+03	371	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:49:18.023843+00:00	3		35	1
1768	2017-07-25 21:32:45.146037+03	370	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:06.828543+00:00	3		35	1
1769	2017-07-25 21:32:45.149018+03	369	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:49:06.258196+00:00	3		35	1
1770	2017-07-25 21:32:45.152677+03	368	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:49:00.148597+00:00	3		35	1
1771	2017-07-25 21:32:45.158589+03	367	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:48:58.651430+00:00	3		35	1
1772	2017-07-25 21:32:45.162135+03	366	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:48:47.332631+00:00	3		35	1
1773	2017-07-25 21:32:45.174613+03	365	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:48:46.510882+00:00	3		35	1
1774	2017-07-25 21:32:45.178163+03	364	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:48:40.308567+00:00	3		35	1
1775	2017-07-25 21:32:45.181828+03	363	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:48:39.453463+00:00	3		35	1
1776	2017-07-25 21:32:45.186353+03	362	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:48:28.658663+00:00	3		35	1
1777	2017-07-25 21:32:45.189839+03	361	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:48:27.936102+00:00	3		35	1
1778	2017-07-25 21:32:45.194518+03	360	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:48:17.128002+00:00	3		35	1
1779	2017-07-25 21:32:45.198633+03	359	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:48:15.952210+00:00	3		35	1
1780	2017-07-25 21:32:45.202749+03	358	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:48:09.798103+00:00	3		35	1
1781	2017-07-25 21:32:45.20607+03	357	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:48:08.618928+00:00	3		35	1
1782	2017-07-25 21:32:45.209122+03	356	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:47:57.819471+00:00	3		35	1
1783	2017-07-25 21:32:45.215819+03	355	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:47:56.685660+00:00	3		35	1
1784	2017-07-25 21:32:45.21918+03	354	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:47:50.487427+00:00	3		35	1
1785	2017-07-25 21:32:45.222431+03	353	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:47:49.377752+00:00	3		35	1
1786	2017-07-25 21:32:45.226097+03	352	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:47:38.351239+00:00	3		35	1
1787	2017-07-25 21:32:45.230036+03	351	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:47:37.247516+00:00	3		35	1
1788	2017-07-25 21:32:45.23431+03	350	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:47:26.168308+00:00	3		35	1
1789	2017-07-25 21:32:45.241571+03	349	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:47:25.428599+00:00	3		35	1
1790	2017-07-25 21:32:45.244657+03	348	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:47:18.972028+00:00	3		35	1
1791	2017-07-25 21:32:45.249608+03	347	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:47:17.534177+00:00	3		35	1
1792	2017-07-25 21:32:45.252807+03	346	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:47:06.090572+00:00	3		35	1
1793	2017-07-25 21:32:45.255945+03	345	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:47:05.426681+00:00	3		35	1
1794	2017-07-25 21:32:45.260272+03	344	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:46:59.813287+00:00	3		35	1
1795	2017-07-25 21:32:45.264463+03	343	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:46:58.794481+00:00	3		35	1
1796	2017-07-25 21:32:45.268522+03	342	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:46:47.518123+00:00	3		35	1
1797	2017-07-25 21:32:45.272355+03	341	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:46:46.648381+00:00	3		35	1
1798	2017-07-25 21:32:45.276421+03	340	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:46:40.165323+00:00	3		35	1
1799	2017-07-25 21:32:45.279952+03	339	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:46:39.133402+00:00	3		35	1
1800	2017-07-25 21:32:45.290967+03	338	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:46:28.299368+00:00	3		35	1
1801	2017-07-25 21:32:45.296366+03	337	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:46:26.813397+00:00	3		35	1
1802	2017-07-25 21:32:45.301648+03	336	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:46:15.762591+00:00	3		35	1
1803	2017-07-25 21:32:45.306669+03	335	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:46:15.138906+00:00	3		35	1
1804	2017-07-25 21:32:45.310201+03	334	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:46:08.905155+00:00	3		35	1
1805	2017-07-25 21:32:45.315514+03	333	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:46:07.561512+00:00	3		35	1
1806	2017-07-25 21:32:45.321671+03	332	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:45:56.270455+00:00	3		35	1
1807	2017-07-25 21:32:45.32666+03	331	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:45:54.942205+00:00	3		35	1
1808	2017-07-25 21:32:45.329953+03	330	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:45:48.767219+00:00	3		35	1
1809	2017-07-25 21:32:45.334131+03	329	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:45:47.654177+00:00	3		35	1
1810	2017-07-25 21:32:45.337663+03	328	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:45:36.646786+00:00	3		35	1
1811	2017-07-25 21:32:45.342982+03	327	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:45:35.454236+00:00	3		35	1
1812	2017-07-25 21:32:45.347143+03	326	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:45:29.824738+00:00	3		35	1
2333	2017-07-26 11:59:26.334725+03	27	FalsePriceProposal object	3		37	1
1813	2017-07-25 21:32:45.352155+03	325	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:45:29.236677+00:00	3		35	1
1814	2017-07-25 21:32:45.355882+03	324	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:45:18.143517+00:00	3		35	1
1815	2017-07-25 21:32:45.359524+03	323	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:45:16.584203+00:00	3		35	1
1816	2017-07-25 21:32:45.367127+03	322	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:45:10.254969+00:00	3		35	1
1817	2017-07-25 21:32:45.372637+03	321	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:45:08.964156+00:00	3		35	1
1818	2017-07-25 21:32:45.379847+03	320	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:44:57.802745+00:00	3		35	1
1819	2017-07-25 21:32:45.383761+03	319	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:44:56.338716+00:00	3		35	1
1820	2017-07-25 21:32:45.38668+03	318	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:44:49.830147+00:00	3		35	1
1821	2017-07-25 21:32:45.38993+03	317	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:44:48.849805+00:00	3		35	1
1822	2017-07-25 21:32:45.396004+03	316	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:44:38.159100+00:00	3		35	1
1823	2017-07-25 21:32:45.400299+03	315	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:44:37.226568+00:00	3		35	1
1824	2017-07-25 21:32:45.406641+03	314	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:44:31.024056+00:00	3		35	1
1825	2017-07-25 21:32:45.411643+03	313	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:44:29.530151+00:00	3		35	1
1826	2017-07-25 21:32:45.415804+03	312	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:44:18.089066+00:00	3		35	1
1827	2017-07-25 21:32:45.419525+03	311	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:44:17.494604+00:00	3		35	1
1828	2017-07-25 21:32:45.423712+03	310	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:44:06.349773+00:00	3		35	1
1829	2017-07-25 21:32:45.428399+03	309	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:44:05.551874+00:00	3		35	1
1830	2017-07-25 21:32:45.432323+03	308	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:43:59.666127+00:00	3		35	1
1831	2017-07-25 21:32:45.435507+03	307	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:43:58.857300+00:00	3		35	1
1832	2017-07-25 21:32:45.43868+03	306	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:43:47.475842+00:00	3		35	1
1833	2017-07-25 21:32:45.443694+03	305	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:43:46.601042+00:00	3		35	1
1834	2017-07-25 21:32:45.458301+03	304	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:43:40.096880+00:00	3		35	1
1835	2017-07-25 21:32:45.465374+03	303	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:43:38.934322+00:00	3		35	1
1836	2017-07-25 21:32:45.468733+03	302	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:43:27.389273+00:00	3		35	1
1837	2017-07-25 21:32:45.471829+03	301	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:43:26.830710+00:00	3		35	1
1838	2017-07-25 21:32:45.475703+03	300	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:43:20.766708+00:00	3		35	1
1839	2017-07-25 21:32:45.478614+03	299	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:43:19.217871+00:00	3		35	1
1840	2017-07-25 21:32:45.481353+03	298	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:43:08.410967+00:00	3		35	1
1841	2017-07-25 21:32:45.48445+03	297	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:43:06.876974+00:00	3		35	1
1842	2017-07-25 21:32:45.487539+03	296	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:42:56.140674+00:00	3		35	1
1843	2017-07-25 21:32:45.492727+03	295	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:42:55.458502+00:00	3		35	1
1844	2017-07-25 21:32:45.496743+03	294	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:42:49.400444+00:00	3		35	1
1845	2017-07-25 21:32:45.500367+03	293	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:42:47.888797+00:00	3		35	1
1846	2017-07-25 21:32:45.505044+03	292	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:42:36.673177+00:00	3		35	1
1847	2017-07-25 21:32:45.516841+03	291	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:42:35.385845+00:00	3		35	1
1848	2017-07-25 21:32:45.521444+03	290	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:42:29.107216+00:00	3		35	1
1849	2017-07-25 21:32:45.52548+03	289	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:42:28.340948+00:00	3		35	1
1850	2017-07-25 21:32:45.529559+03	288	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:42:16.999914+00:00	3		35	1
1851	2017-07-25 21:32:45.532912+03	287	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:42:15.530416+00:00	3		35	1
1852	2017-07-25 21:32:45.536016+03	286	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:42:09.568286+00:00	3		35	1
1853	2017-07-25 21:32:45.539549+03	285	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:42:08.508996+00:00	3		35	1
1854	2017-07-25 21:32:45.5426+03	284	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:41:57.246871+00:00	3		35	1
1855	2017-07-25 21:32:45.545877+03	283	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:41:56.203833+00:00	3		35	1
1856	2017-07-25 21:32:45.557773+03	282	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:41:50.504241+00:00	3		35	1
1857	2017-07-25 21:32:45.561539+03	281	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:41:48.989473+00:00	3		35	1
1858	2017-07-25 21:32:45.56677+03	280	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:41:38.053808+00:00	3		35	1
1859	2017-07-25 21:32:45.572448+03	279	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:41:36.756299+00:00	3		35	1
1860	2017-07-25 21:32:45.575806+03	278	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:41:25.731076+00:00	3		35	1
1861	2017-07-25 21:32:45.579306+03	277	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:41:24.593372+00:00	3		35	1
1862	2017-07-25 21:32:45.583536+03	276	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:41:18.774069+00:00	3		35	1
1863	2017-07-25 21:32:45.58695+03	275	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:41:17.928748+00:00	3		35	1
1864	2017-07-25 21:32:45.591172+03	274	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:41:06.687375+00:00	3		35	1
1865	2017-07-25 21:32:45.595139+03	273	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:41:05.277792+00:00	3		35	1
1866	2017-07-25 21:32:45.599004+03	272	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:58.903147+00:00	3		35	1
1867	2017-07-25 21:32:45.60222+03	271	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:40:57.860951+00:00	3		35	1
1868	2017-07-25 21:32:45.60541+03	270	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:46.420291+00:00	3		35	1
2334	2017-07-26 11:59:26.33822+03	26	FalsePriceProposal object	3		37	1
1869	2017-07-25 21:32:45.608485+03	269	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:40:45.769716+00:00	3		35	1
1870	2017-07-25 21:32:45.611927+03	268	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:39.278446+00:00	3		35	1
1871	2017-07-25 21:32:45.615234+03	267	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:40:38.581290+00:00	3		35	1
1872	2017-07-25 21:32:45.618554+03	266	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:27.999585+00:00	3		35	1
1873	2017-07-25 21:32:45.621778+03	265	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:40:26.910461+00:00	3		35	1
1874	2017-07-25 21:32:45.625217+03	264	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:15.708768+00:00	3		35	1
1875	2017-07-25 21:32:45.628769+03	263	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:40:14.710044+00:00	3		35	1
1876	2017-07-25 21:32:45.632768+03	262	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:08.349397+00:00	3		35	1
1877	2017-07-25 21:32:45.63623+03	261	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:40:07.181212+00:00	3		35	1
1878	2017-07-25 21:32:45.639306+03	260	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:40:00.868542+00:00	3		35	1
1879	2017-07-25 21:32:45.642821+03	259	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:39:59.368391+00:00	3		35	1
1880	2017-07-25 21:32:45.64584+03	258	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:39:47.919872+00:00	3		35	1
1881	2017-07-25 21:32:45.649306+03	257	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:39:46.969016+00:00	3		35	1
1882	2017-07-25 21:32:45.659503+03	256	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:39:40.696442+00:00	3		35	1
1883	2017-07-25 21:32:45.663332+03	255	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:39:39.326440+00:00	3		35	1
1884	2017-07-25 21:32:45.666788+03	254	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:39:27.975343+00:00	3		35	1
1885	2017-07-25 21:32:45.670047+03	253	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:39:27.343124+00:00	3		35	1
1886	2017-07-25 21:32:45.674394+03	252	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:39:16.376325+00:00	3		35	1
1887	2017-07-25 21:32:45.678763+03	251	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:39:15.617662+00:00	3		35	1
1888	2017-07-25 21:32:45.682797+03	250	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:39:09.674409+00:00	3		35	1
1889	2017-07-25 21:32:45.686309+03	249	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:39:08.979136+00:00	3		35	1
1890	2017-07-25 21:32:45.689564+03	248	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:58.250390+00:00	3		35	1
1891	2017-07-25 21:32:45.692969+03	247	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:38:57.397539+00:00	3		35	1
1892	2017-07-25 21:32:45.696046+03	246	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:45.970768+00:00	3		35	1
1893	2017-07-25 21:32:45.69899+03	245	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:38:44.958263+00:00	3		35	1
1894	2017-07-25 21:32:45.702073+03	244	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:39.347693+00:00	3		35	1
1895	2017-07-25 21:32:45.705454+03	243	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:38:38.518884+00:00	3		35	1
1896	2017-07-25 21:32:45.709051+03	242	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:27.603090+00:00	3		35	1
1897	2017-07-25 21:32:45.712341+03	241	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:38:26.092733+00:00	3		35	1
1898	2017-07-25 21:32:45.715339+03	240	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:19.926907+00:00	3		35	1
1899	2017-07-25 21:32:45.718293+03	239	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:38:18.757832+00:00	3		35	1
1900	2017-07-25 21:32:45.721177+03	238	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:08.049103+00:00	3		35	1
1901	2017-07-25 21:32:45.724183+03	237	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:38:06.592706+00:00	3		35	1
1902	2017-07-25 21:32:45.72794+03	236	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:38:00.207981+00:00	3		35	1
1903	2017-07-25 21:32:45.73162+03	235	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:37:59.518215+00:00	3		35	1
1904	2017-07-25 21:32:45.743395+03	234	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:37:48.721612+00:00	3		35	1
1905	2017-07-25 21:32:45.751421+03	233	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:37:47.867406+00:00	3		35	1
1906	2017-07-25 21:32:45.755081+03	232	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:37:36.877628+00:00	3		35	1
1907	2017-07-25 21:32:45.758497+03	231	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:37:35.467840+00:00	3		35	1
1908	2017-07-25 21:32:45.761686+03	230	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:37:29.407028+00:00	3		35	1
1909	2017-07-25 21:32:45.765571+03	229	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:37:28.528840+00:00	3		35	1
1910	2017-07-25 21:32:45.769518+03	228	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:37:17.901301+00:00	3		35	1
1911	2017-07-25 21:32:45.773242+03	227	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:37:17.033182+00:00	3		35	1
1912	2017-07-25 21:32:45.776715+03	226	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:37:06.184277+00:00	3		35	1
1913	2017-07-25 21:32:45.781868+03	225	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:37:04.854885+00:00	3		35	1
1914	2017-07-25 21:32:45.794384+03	224	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:36:59.142875+00:00	3		35	1
1915	2017-07-25 21:32:45.797519+03	223	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:36:57.666787+00:00	3		35	1
1916	2017-07-25 21:32:45.802271+03	222	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:36:46.110728+00:00	3		35	1
1917	2017-07-25 21:32:45.805664+03	221	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:36:45.254005+00:00	3		35	1
1918	2017-07-25 21:32:45.809714+03	220	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:36:38.858685+00:00	3		35	1
1919	2017-07-25 21:32:45.816579+03	219	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:36:37.759964+00:00	3		35	1
1920	2017-07-25 21:32:45.820294+03	218	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:36:26.566477+00:00	3		35	1
1921	2017-07-25 21:32:45.823336+03	217	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:36:25.103501+00:00	3		35	1
1922	2017-07-25 21:32:45.835402+03	216	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:36:18.624535+00:00	3		35	1
1923	2017-07-25 21:32:45.839106+03	215	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:36:17.527617+00:00	3		35	1
1924	2017-07-25 21:32:45.842451+03	214	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:36:06.296800+00:00	3		35	1
2335	2017-07-26 11:59:32.47323+03	49	test -> Arcadium AVM | Coca-Cola  1L	3		34	1
1925	2017-07-25 21:32:45.847269+03	213	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:36:04.919143+00:00	3		35	1
1926	2017-07-25 21:32:45.852173+03	212	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:35:58.844297+00:00	3		35	1
1927	2017-07-25 21:32:45.856565+03	211	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:35:58.098602+00:00	3		35	1
1928	2017-07-25 21:32:45.861166+03	210	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:35:47.052126+00:00	3		35	1
1929	2017-07-25 21:32:45.864172+03	209	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:35:45.508756+00:00	3		35	1
1930	2017-07-25 21:32:45.867402+03	208	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:35:39.633832+00:00	3		35	1
1931	2017-07-25 21:32:45.871079+03	207	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:35:38.906679+00:00	3		35	1
1932	2017-07-25 21:32:45.882571+03	206	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:35:27.424161+00:00	3		35	1
1933	2017-07-25 21:32:45.88962+03	205	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:35:26.014408+00:00	3		35	1
1934	2017-07-25 21:32:45.893987+03	204	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:35:19.665380+00:00	3		35	1
1935	2017-07-25 21:32:45.897186+03	203	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:35:18.254722+00:00	3		35	1
1936	2017-07-25 21:32:45.901341+03	202	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:35:06.817436+00:00	3		35	1
1937	2017-07-25 21:32:45.90478+03	201	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:35:05.942062+00:00	3		35	1
1938	2017-07-25 21:32:45.907776+03	200	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:34:59.487535+00:00	3		35	1
1939	2017-07-25 21:32:45.911155+03	199	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:34:58.027546+00:00	3		35	1
1940	2017-07-25 21:32:45.91628+03	198	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:34:46.973669+00:00	3		35	1
1941	2017-07-25 21:32:45.919431+03	197	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:34:46.387055+00:00	3		35	1
1942	2017-07-25 21:32:45.922944+03	196	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:34:40.146251+00:00	3		35	1
1943	2017-07-25 21:32:45.92598+03	195	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:34:38.773786+00:00	3		35	1
1944	2017-07-25 21:32:45.932265+03	194	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:34:27.485359+00:00	3		35	1
1945	2017-07-25 21:32:45.935708+03	193	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:34:26.404527+00:00	3		35	1
1946	2017-07-25 21:32:45.939685+03	192	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:34:20.228123+00:00	3		35	1
1947	2017-07-25 21:32:45.943448+03	191	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:34:18.728864+00:00	3		35	1
1948	2017-07-25 21:32:45.947031+03	190	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:34:07.771838+00:00	3		35	1
1949	2017-07-25 21:32:45.950685+03	189	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:34:07.079561+00:00	3		35	1
1950	2017-07-25 21:32:45.954071+03	188	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:33:56.242448+00:00	3		35	1
1951	2017-07-25 21:32:45.956882+03	187	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:33:55.482878+00:00	3		35	1
1952	2017-07-25 21:32:45.960162+03	186	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:33:49.333790+00:00	3		35	1
1953	2017-07-25 21:32:45.966141+03	185	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:33:47.820085+00:00	3		35	1
1954	2017-07-25 21:32:45.969435+03	184	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:33:36.570328+00:00	3		35	1
1955	2017-07-25 21:32:45.972619+03	183	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:33:35.905454+00:00	3		35	1
1956	2017-07-25 21:32:45.979584+03	182	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:33:29.546931+00:00	3		35	1
1957	2017-07-25 21:32:45.982821+03	181	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:33:28.226835+00:00	3		35	1
1958	2017-07-25 21:32:45.990127+03	180	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:33:17.416808+00:00	3		35	1
1959	2017-07-25 21:32:45.996733+03	179	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:33:16.334421+00:00	3		35	1
1960	2017-07-25 21:32:46.000149+03	178	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:33:10.613696+00:00	3		35	1
1961	2017-07-25 21:32:46.003625+03	177	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:33:09.439987+00:00	3		35	1
1962	2017-07-25 21:32:46.015467+03	176	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:32:58.021343+00:00	3		35	1
1963	2017-07-25 21:32:46.019618+03	175	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:32:56.901950+00:00	3		35	1
1964	2017-07-25 21:32:46.022487+03	174	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:32:50.754386+00:00	3		35	1
1965	2017-07-25 21:32:46.026179+03	173	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:32:49.391715+00:00	3		35	1
1966	2017-07-25 21:32:46.031117+03	172	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:32:37.910632+00:00	3		35	1
1967	2017-07-25 21:32:46.038759+03	171	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:32:37.315210+00:00	3		35	1
1968	2017-07-25 21:32:46.043513+03	170	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:32:26.081550+00:00	3		35	1
1969	2017-07-25 21:32:46.047186+03	169	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:32:24.607746+00:00	3		35	1
1970	2017-07-25 21:32:46.050699+03	168	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:32:18.149168+00:00	3		35	1
1971	2017-07-25 21:32:46.053631+03	167	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:32:16.987993+00:00	3		35	1
1972	2017-07-25 21:32:46.057232+03	166	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:32:05.992738+00:00	3		35	1
1973	2017-07-25 21:32:46.060396+03	165	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:32:04.821890+00:00	3		35	1
1974	2017-07-25 21:32:46.064195+03	164	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:31:59.049451+00:00	3		35	1
1975	2017-07-25 21:32:46.067276+03	163	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:31:58.328606+00:00	3		35	1
1976	2017-07-25 21:32:46.071179+03	162	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:31:47.698401+00:00	3		35	1
1977	2017-07-25 21:32:46.075003+03	161	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:31:46.262107+00:00	3		35	1
1978	2017-07-25 21:32:46.079259+03	160	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:31:40.278818+00:00	3		35	1
1979	2017-07-25 21:32:46.082558+03	159	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:31:39.279663+00:00	3		35	1
1980	2017-07-25 21:32:46.085866+03	158	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:31:28.246740+00:00	3		35	1
2337	2017-07-26 11:59:32.489451+03	47	dyanikoglu -> Armada AVM | Coca-Cola  1L	3		34	1
1981	2017-07-25 21:32:46.08911+03	157	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:31:27.072278+00:00	3		35	1
1982	2017-07-25 21:32:46.092767+03	156	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:31:21.062066+00:00	3		35	1
1983	2017-07-25 21:32:46.095769+03	155	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:31:19.520866+00:00	3		35	1
1984	2017-07-25 21:32:46.098994+03	154	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:31:08.649732+00:00	3		35	1
1985	2017-07-25 21:32:46.102666+03	153	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:31:07.420855+00:00	3		35	1
1986	2017-07-25 21:32:46.113898+03	152	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:30:56.266909+00:00	3		35	1
1987	2017-07-25 21:32:46.119936+03	151	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:30:54.931829+00:00	3		35	1
1988	2017-07-25 21:32:46.126382+03	150	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:30:49.362515+00:00	3		35	1
1989	2017-07-25 21:32:46.129393+03	149	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:30:48.704972+00:00	3		35	1
1990	2017-07-25 21:32:46.133313+03	148	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:30:38.007396+00:00	3		35	1
1991	2017-07-25 21:32:46.13665+03	147	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:30:37.207377+00:00	3		35	1
1992	2017-07-25 21:32:46.139825+03	146	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:30:26.323686+00:00	3		35	1
1993	2017-07-25 21:32:46.143022+03	145	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:30:25.716539+00:00	3		35	1
1994	2017-07-25 21:32:46.146632+03	144	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:30:19.832108+00:00	3		35	1
1995	2017-07-25 21:32:46.149693+03	143	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:30:18.448515+00:00	3		35	1
1996	2017-07-25 21:32:46.152724+03	142	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:30:06.888646+00:00	3		35	1
1997	2017-07-25 21:32:46.155753+03	141	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:30:05.713622+00:00	3		35	1
1998	2017-07-25 21:32:46.158914+03	140	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:29:59.526792+00:00	3		35	1
1999	2017-07-25 21:32:46.162616+03	139	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:29:58.685407+00:00	3		35	1
2000	2017-07-25 21:32:46.166698+03	138	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:29:48.002728+00:00	3		35	1
2001	2017-07-25 21:32:46.169984+03	137	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:29:47.241193+00:00	3		35	1
2002	2017-07-25 21:32:46.173726+03	136	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:29:36.077518+00:00	3		35	1
2003	2017-07-25 21:32:46.177394+03	135	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:29:34.917445+00:00	3		35	1
2004	2017-07-25 21:32:46.181744+03	134	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:29:28.938739+00:00	3		35	1
2005	2017-07-25 21:32:46.185597+03	133	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:29:27.395291+00:00	3		35	1
2006	2017-07-25 21:32:46.188763+03	132	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:29:16.347617+00:00	3		35	1
2007	2017-07-25 21:32:46.192673+03	131	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:29:15.383246+00:00	3		35	1
2008	2017-07-25 21:32:46.199644+03	130	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:29:09.005562+00:00	3		35	1
2009	2017-07-25 21:32:46.204501+03	129	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:29:07.840034+00:00	3		35	1
2010	2017-07-25 21:32:46.207542+03	128	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:28:56.722343+00:00	3		35	1
2011	2017-07-25 21:32:46.220906+03	127	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:28:55.698120+00:00	3		35	1
2012	2017-07-25 21:32:46.227493+03	126	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:28:49.767858+00:00	3		35	1
2013	2017-07-25 21:32:46.234668+03	125	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:28:48.917307+00:00	3		35	1
2014	2017-07-25 21:32:46.239123+03	124	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:28:37.644696+00:00	3		35	1
2015	2017-07-25 21:32:46.250756+03	123	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:28:36.868154+00:00	3		35	1
2016	2017-07-25 21:32:46.254492+03	122	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:28:30.623794+00:00	3		35	1
2017	2017-07-25 21:32:46.257609+03	121	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:28:29.324439+00:00	3		35	1
2018	2017-07-25 21:32:46.262041+03	120	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:28:17.889483+00:00	3		35	1
2019	2017-07-25 21:32:46.266205+03	119	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:28:17.013570+00:00	3		35	1
2020	2017-07-25 21:32:46.269568+03	118	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:28:05.885660+00:00	3		35	1
2021	2017-07-25 21:32:46.272844+03	117	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:28:04.724011+00:00	3		35	1
2022	2017-07-25 21:32:46.276214+03	116	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:27:58.858137+00:00	3		35	1
2023	2017-07-25 21:32:46.280012+03	115	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:27:57.828661+00:00	3		35	1
2024	2017-07-25 21:32:46.283914+03	114	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:27:46.770740+00:00	3		35	1
2025	2017-07-25 21:32:46.286859+03	113	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:27:45.541590+00:00	3		35	1
2026	2017-07-25 21:32:46.289778+03	112	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:27:39.498067+00:00	3		35	1
2027	2017-07-25 21:32:46.301661+03	111	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:27:38.309549+00:00	3		35	1
2028	2017-07-25 21:32:46.304755+03	110	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:27:27.567848+00:00	3		35	1
2029	2017-07-25 21:32:46.30789+03	109	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:27:26.051751+00:00	3		35	1
2030	2017-07-25 21:32:46.312647+03	108	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:27:20.468752+00:00	3		35	1
2031	2017-07-25 21:32:46.316178+03	107	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:27:19.602421+00:00	3		35	1
2032	2017-07-25 21:32:46.322457+03	106	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:27:08.810668+00:00	3		35	1
2033	2017-07-25 21:32:46.326284+03	105	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:27:07.914215+00:00	3		35	1
2034	2017-07-25 21:32:46.330023+03	104	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:26:56.814983+00:00	3		35	1
2035	2017-07-25 21:32:46.333755+03	103	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:26:55.349985+00:00	3		35	1
2036	2017-07-25 21:32:46.340127+03	102	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:26:48.829631+00:00	3		35	1
2338	2017-07-26 11:59:32.495837+03	46	test -> Armada AVM | Coca-Cola  1L	3		34	1
2037	2017-07-25 21:32:46.347164+03	101	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:26:47.488227+00:00	3		35	1
2038	2017-07-25 21:32:46.351992+03	100	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:26:36.792408+00:00	3		35	1
2039	2017-07-25 21:32:46.355262+03	99	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:26:36.183045+00:00	3		35	1
2040	2017-07-25 21:32:46.359047+03	98	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:26:30.287660+00:00	3		35	1
2041	2017-07-25 21:32:46.365565+03	97	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:26:29.556594+00:00	3		35	1
2042	2017-07-25 21:32:46.368662+03	96	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:25:51.632903+00:00	3		35	1
2043	2017-07-25 21:32:46.373757+03	95	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:25:40.497107+00:00	3		35	1
2044	2017-07-25 21:32:46.377065+03	94	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:25:39.324601+00:00	3		35	1
2045	2017-07-25 21:32:46.380557+03	93	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:25:28.441724+00:00	3		35	1
2046	2017-07-25 21:32:46.38364+03	92	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:25:27.170299+00:00	3		35	1
2047	2017-07-25 21:32:46.389027+03	91	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:25:21.363294+00:00	3		35	1
2048	2017-07-25 21:32:46.392422+03	90	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:25:20.098476+00:00	3		35	1
2049	2017-07-25 21:32:46.397309+03	89	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:25:08.911011+00:00	3		35	1
2050	2017-07-25 21:32:46.401091+03	88	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:25:08.074551+00:00	3		35	1
2051	2017-07-25 21:32:46.405011+03	87	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:25:02.339575+00:00	3		35	1
2052	2017-07-25 21:32:46.409247+03	86	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:25:00.972193+00:00	3		35	1
2053	2017-07-25 21:32:46.421293+03	85	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:24:49.774300+00:00	3		35	1
2054	2017-07-25 21:32:46.42496+03	84	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:24:48.630591+00:00	3		35	1
2055	2017-07-25 21:32:46.428755+03	83	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:24:42.131343+00:00	3		35	1
2056	2017-07-25 21:32:46.431626+03	82	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:24:41.082833+00:00	3		35	1
2057	2017-07-25 21:32:46.434943+03	81	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:24:30.449551+00:00	3		35	1
2058	2017-07-25 21:32:46.439017+03	80	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:24:29.347156+00:00	3		35	1
2059	2017-07-25 21:32:46.442193+03	79	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:24:18.142734+00:00	3		35	1
2060	2017-07-25 21:32:46.445896+03	78	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:24:17.598530+00:00	3		35	1
2061	2017-07-25 21:32:46.456136+03	77	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:24:11.286883+00:00	3		35	1
2062	2017-07-25 21:32:46.459591+03	76	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:24:10.584127+00:00	3		35	1
2063	2017-07-25 21:32:46.462701+03	75	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:59.161097+00:00	3		35	1
2064	2017-07-25 21:32:46.466505+03	74	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:58.486967+00:00	3		35	1
2065	2017-07-25 21:32:46.469941+03	73	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:52.689302+00:00	3		35	1
2066	2017-07-25 21:32:46.473351+03	72	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:51.257441+00:00	3		35	1
2067	2017-07-25 21:32:46.477048+03	71	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:39.861638+00:00	3		35	1
2068	2017-07-25 21:32:46.480331+03	70	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:38.903697+00:00	3		35	1
2069	2017-07-25 21:32:46.48371+03	69	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:32.718621+00:00	3		35	1
2070	2017-07-25 21:32:46.489117+03	68	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:31.291710+00:00	3		35	1
2071	2017-07-25 21:32:46.494853+03	67	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:19.858234+00:00	3		35	1
2072	2017-07-25 21:32:46.499514+03	66	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:18.389814+00:00	3		35	1
2073	2017-07-25 21:32:46.502565+03	65	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:12.549129+00:00	3		35	1
2074	2017-07-25 21:32:46.509101+03	64	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:11.748325+00:00	3		35	1
2075	2017-07-25 21:32:46.512339+03	63	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:23:01.158390+00:00	3		35	1
2076	2017-07-25 21:32:46.516685+03	62	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:23:00.356788+00:00	3		35	1
2077	2017-07-25 21:32:46.521744+03	61	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:19:27.330960+00:00	3		35	1
2078	2017-07-25 21:32:46.53439+03	60	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:19:26.353049+00:00	3		35	1
2079	2017-07-25 21:32:46.537725+03	59	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:19:15.722206+00:00	3		35	1
2080	2017-07-25 21:32:46.543816+03	58	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:19:14.579834+00:00	3		35	1
2081	2017-07-25 21:32:46.549414+03	57	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:19:08.144565+00:00	3		35	1
2082	2017-07-25 21:32:46.553142+03	56	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:19:06.762572+00:00	3		35	1
2083	2017-07-25 21:32:46.557472+03	55	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:18:56.081133+00:00	3		35	1
2084	2017-07-25 21:32:46.561001+03	54	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:18:55.215411+00:00	3		35	1
2085	2017-07-25 21:32:46.566479+03	53	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:18:48.725610+00:00	3		35	1
2086	2017-07-25 21:32:46.570319+03	52	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:18:48.125930+00:00	3		35	1
2087	2017-07-25 21:32:46.579959+03	51	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:17:57.490947+00:00	3		35	1
2088	2017-07-25 21:32:46.583236+03	50	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:17:51.362837+00:00	3		35	1
2089	2017-07-25 21:32:46.587689+03	49	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:17:45.057924+00:00	3		35	1
2090	2017-07-25 21:32:46.594841+03	48	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:17:44.044706+00:00	3		35	1
2091	2017-07-25 21:32:46.599595+03	47	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:18.481968+00:00	3		35	1
2092	2017-07-25 21:32:46.603996+03	46	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:17.638140+00:00	3		35	1
3365	2017-09-03 22:39:53.960879+03	52	child2	3		13	1
2093	2017-07-25 21:32:46.607105+03	45	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:12:17.037106+00:00	3		35	1
2094	2017-07-25 21:32:46.610991+03	44	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:12:16.001511+00:00	3		35	1
2095	2017-07-25 21:32:46.614258+03	43	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:14.999671+00:00	3		35	1
2096	2017-07-25 21:32:46.617487+03	42	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:13.987103+00:00	3		35	1
2097	2017-07-25 21:32:46.623544+03	41	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:12.994159+00:00	3		35	1
2098	2017-07-25 21:32:46.627554+03	40	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:12:11.813898+00:00	3		35	1
2099	2017-07-25 21:32:46.630992+03	39	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:10.716455+00:00	3		35	1
2100	2017-07-25 21:32:46.634043+03	38	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:12:09.249285+00:00	3		35	1
2101	2017-07-25 21:32:46.637159+03	37	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:08.248416+00:00	3		35	1
2102	2017-07-25 21:32:46.647479+03	36	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:06.849547+00:00	3		35	1
2103	2017-07-25 21:32:46.653968+03	35	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:12:06.106704+00:00	3		35	1
2104	2017-07-25 21:32:46.659599+03	34	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:12:04.902966+00:00	3		35	1
2105	2017-07-25 21:32:46.663417+03	33	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:04.297871+00:00	3		35	1
2106	2017-07-25 21:32:46.667111+03	32	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:02.909061+00:00	3		35	1
2107	2017-07-25 21:32:46.671397+03	31	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:12:02.080254+00:00	3		35	1
2108	2017-07-25 21:32:46.675104+03	30	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:09:31.055450+00:00	3		35	1
2109	2017-07-25 21:32:46.67974+03	29	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:09:19.081437+00:00	3		35	1
2110	2017-07-25 21:32:46.683637+03	28	gisModule.tasks.blame_module_check_proposal - 2017-07-15 11:09:13.064863+00:00	3		35	1
2111	2017-07-25 21:32:46.688336+03	27	gisModule.tasks.blame_module_check_blame_status - 2017-07-15 11:09:11.545784+00:00	3		35	1
2112	2017-07-25 21:58:53.86779+03	2	UserStatistics object	2	[{"changed": {"fields": ["reputation"]}}]	39	1
2113	2017-07-25 21:58:57.798267+03	1	UserStatistics object	2	[{"changed": {"fields": ["reputation"]}}]	39	1
2114	2017-07-25 22:22:42.235936+03	1151	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:10:49.597603+00:00	3		35	1
2115	2017-07-25 22:22:42.242043+03	1150	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:10:48.182260+00:00	3		35	1
2116	2017-07-25 22:22:42.245734+03	1149	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:10:21.980882+00:00	3		35	1
2117	2017-07-25 22:22:42.249927+03	1148	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:10:20.667759+00:00	3		35	1
2118	2017-07-25 22:22:42.25346+03	1147	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:09:49.707708+00:00	3		35	1
2119	2017-07-25 22:22:42.256974+03	1146	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:09:48.333586+00:00	3		35	1
2120	2017-07-25 22:22:42.260585+03	1145	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:09:21.112782+00:00	3		35	1
2121	2017-07-25 22:22:42.264468+03	1144	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:09:19.904424+00:00	3		35	1
2122	2017-07-25 22:22:42.268209+03	1143	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:08:53.172357+00:00	3		35	1
2123	2017-07-25 22:22:42.271957+03	1142	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:08:51.315650+00:00	3		35	1
2124	2017-07-25 22:22:42.276214+03	1141	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:06:43.009277+00:00	3		35	1
2125	2017-07-25 22:22:42.280946+03	1140	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:06:40.443214+00:00	3		35	1
2126	2017-07-25 22:22:42.284913+03	1139	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:06:16.481540+00:00	3		35	1
2127	2017-07-25 22:22:42.288302+03	1138	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:06:15.835250+00:00	3		35	1
2128	2017-07-25 22:22:42.291625+03	1137	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:06:14.443609+00:00	3		35	1
2129	2017-07-25 22:22:42.295333+03	1136	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:06:13.336563+00:00	3		35	1
2130	2017-07-25 22:22:42.299431+03	1135	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:06:12.541013+00:00	3		35	1
2131	2017-07-25 22:22:42.303244+03	1134	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:06:11.492653+00:00	3		35	1
2132	2017-07-25 22:22:42.306838+03	1133	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:04:36.057851+00:00	3		35	1
2133	2017-07-25 22:22:42.311284+03	1132	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:04:35.055673+00:00	3		35	1
2134	2017-07-25 22:22:42.315377+03	1131	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:04:04.337090+00:00	3		35	1
2135	2017-07-25 22:22:42.318661+03	1130	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:04:03.406746+00:00	3		35	1
2136	2017-07-25 22:22:42.321754+03	1129	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:03:36.866627+00:00	3		35	1
2137	2017-07-25 22:22:42.324758+03	1128	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:03:35.423331+00:00	3		35	1
2138	2017-07-25 22:22:42.328202+03	1127	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:03:03.346414+00:00	3		35	1
2139	2017-07-25 22:22:42.331331+03	1126	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:03:01.938591+00:00	3		35	1
2140	2017-07-25 22:22:42.335264+03	1125	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:02:35.317433+00:00	3		35	1
2141	2017-07-25 22:22:42.339001+03	1124	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:02:34.755884+00:00	3		35	1
2142	2017-07-25 22:22:42.343672+03	1123	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:02:02.719365+00:00	3		35	1
2143	2017-07-25 22:22:42.349537+03	1122	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:02:01.215557+00:00	3		35	1
2144	2017-07-25 22:22:42.352964+03	1121	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:01:34.681234+00:00	3		35	1
2145	2017-07-25 22:22:42.356292+03	1120	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:01:33.260650+00:00	3		35	1
2146	2017-07-25 22:22:42.359453+03	1119	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:01:06.641792+00:00	3		35	1
2147	2017-07-25 22:22:42.362885+03	1118	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:01:05.797809+00:00	3		35	1
2336	2017-07-26 11:59:32.48201+03	48	dyanikoglu -> Arcadium AVM | Coca-Cola  1L	3		34	1
2148	2017-07-25 22:22:42.366346+03	1117	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:01:04.989446+00:00	3		35	1
2149	2017-07-25 22:22:42.370344+03	1116	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:00:33.707523+00:00	3		35	1
2150	2017-07-25 22:22:42.373647+03	1115	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:00:32.181716+00:00	3		35	1
2151	2017-07-25 22:22:42.376891+03	1114	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:00:30.887547+00:00	3		35	1
2152	2017-07-25 22:22:42.388067+03	1113	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:00:04.334220+00:00	3		35	1
2153	2017-07-25 22:22:42.391731+03	1112	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:00:03.042163+00:00	3		35	1
2154	2017-07-25 22:22:42.39592+03	1111	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:00:02.331126+00:00	3		35	1
2155	2017-07-25 22:22:42.400925+03	1110	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:59:36.022067+00:00	3		35	1
2156	2017-07-25 22:22:42.404029+03	1109	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:59:34.822909+00:00	3		35	1
2157	2017-07-25 22:22:42.407203+03	1108	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:59:33.908217+00:00	3		35	1
2158	2017-07-25 22:22:42.41112+03	1107	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:59:02.777329+00:00	3		35	1
2159	2017-07-25 22:22:42.414598+03	1106	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:59:01.305800+00:00	3		35	1
2160	2017-07-25 22:22:42.417663+03	1105	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:59:00.721882+00:00	3		35	1
2161	2017-07-25 22:22:42.420606+03	1104	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:58:34.614302+00:00	3		35	1
2162	2017-07-25 22:22:42.432342+03	1103	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:58:33.726448+00:00	3		35	1
2163	2017-07-25 22:22:42.435708+03	1102	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:58:32.347289+00:00	3		35	1
2164	2017-07-25 22:22:42.439121+03	1101	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:58:06.298385+00:00	3		35	1
2165	2017-07-25 22:22:42.442844+03	1100	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:58:04.785064+00:00	3		35	1
2166	2017-07-25 22:22:42.447451+03	1099	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:58:03.745204+00:00	3		35	1
2167	2017-07-25 22:22:42.459337+03	1098	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:57:32.407107+00:00	3		35	1
2168	2017-07-25 22:22:42.463015+03	1097	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:57:31.527213+00:00	3		35	1
2169	2017-07-25 22:22:42.46749+03	1096	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:57:30.355448+00:00	3		35	1
2170	2017-07-25 22:22:42.471162+03	1095	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:57:04.667048+00:00	3		35	1
2171	2017-07-25 22:22:42.474434+03	1094	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:57:03.292311+00:00	3		35	1
2172	2017-07-25 22:22:42.478214+03	1093	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:57:02.686720+00:00	3		35	1
2173	2017-07-25 22:22:42.491306+03	1092	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:56:36.520751+00:00	3		35	1
2174	2017-07-25 22:22:42.495506+03	1091	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:56:35.720059+00:00	3		35	1
2175	2017-07-25 22:22:42.499824+03	1090	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:56:34.823037+00:00	3		35	1
2176	2017-07-25 22:22:42.503684+03	1089	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:56:03.399176+00:00	3		35	1
2177	2017-07-25 22:22:42.506871+03	1088	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:56:02.106779+00:00	3		35	1
2178	2017-07-25 22:22:42.510167+03	1087	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:56:01.245047+00:00	3		35	1
2179	2017-07-25 22:22:42.514151+03	1086	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:55:34.679773+00:00	3		35	1
2180	2017-07-25 22:22:42.517426+03	1085	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:55:33.390823+00:00	3		35	1
2181	2017-07-25 22:22:42.52052+03	1084	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:55:32.674453+00:00	3		35	1
2182	2017-07-25 22:22:42.523518+03	1083	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:55:06.854940+00:00	3		35	1
2183	2017-07-25 22:22:42.52658+03	1082	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:55:05.631320+00:00	3		35	1
2184	2017-07-25 22:22:42.530352+03	1081	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:55:04.306958+00:00	3		35	1
2185	2017-07-25 22:22:42.534929+03	1080	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:54:32.716053+00:00	3		35	1
2186	2017-07-25 22:22:42.538574+03	1079	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:54:31.254923+00:00	3		35	1
2187	2017-07-25 22:22:42.541738+03	1078	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:54:30.414521+00:00	3		35	1
2188	2017-07-25 22:22:42.545262+03	1077	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:54:04.299706+00:00	3		35	1
2189	2017-07-25 22:22:42.549859+03	1076	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:54:03.020039+00:00	3		35	1
2190	2017-07-25 22:22:42.553064+03	1075	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:54:01.555991+00:00	3		35	1
2191	2017-07-25 22:22:42.563638+03	1074	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:53:35.738884+00:00	3		35	1
2192	2017-07-25 22:22:42.567386+03	1073	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:53:35.104064+00:00	3		35	1
2193	2017-07-25 22:22:42.570571+03	1072	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:53:33.968271+00:00	3		35	1
2194	2017-07-25 22:22:42.573588+03	1071	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:53:02.932436+00:00	3		35	1
2195	2017-07-25 22:22:42.576939+03	1070	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:53:01.682487+00:00	3		35	1
2196	2017-07-25 22:22:42.580616+03	1069	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:53:00.901275+00:00	3		35	1
2197	2017-07-25 22:22:42.584097+03	1068	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:52:34.437208+00:00	3		35	1
2198	2017-07-25 22:22:42.596244+03	1067	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:52:33.518144+00:00	3		35	1
2199	2017-07-25 22:22:42.59941+03	1066	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:52:32.174414+00:00	3		35	1
2200	2017-07-25 22:22:42.602388+03	1065	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:52:05.870784+00:00	3		35	1
2201	2017-07-25 22:22:42.605379+03	1064	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:52:04.500153+00:00	3		35	1
2202	2017-07-25 22:22:42.613958+03	1063	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:52:03.143069+00:00	3		35	1
2203	2017-07-25 22:22:42.617753+03	1062	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:46:44.127784+00:00	3		35	1
2204	2017-07-25 22:22:42.621872+03	1061	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:46:42.945253+00:00	3		35	1
2205	2017-07-25 22:22:42.632921+03	1060	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:46:41.486021+00:00	3		35	1
2206	2017-07-25 22:22:42.636308+03	1059	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:46:14.994851+00:00	3		35	1
2207	2017-07-25 22:22:42.639388+03	1058	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:46:13.925523+00:00	3		35	1
2208	2017-07-25 22:22:42.642722+03	1057	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:46:13.052636+00:00	3		35	1
2209	2017-07-25 22:22:42.646749+03	1056	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:45:42.202551+00:00	3		35	1
2210	2017-07-25 22:22:42.650014+03	1055	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:45:41.160207+00:00	3		35	1
2211	2017-07-25 22:22:42.653223+03	1054	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:45:39.763763+00:00	3		35	1
2212	2017-07-25 22:22:42.656535+03	1053	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:45:14.123638+00:00	3		35	1
2213	2017-07-25 22:22:42.66013+03	1052	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:45:12.748139+00:00	3		35	1
2214	2017-07-25 22:22:42.664247+03	1051	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:45:11.920910+00:00	3		35	1
2215	2017-07-25 22:22:42.667939+03	1050	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:44:45.700719+00:00	3		35	1
2216	2017-07-25 22:22:42.671331+03	1049	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:44:44.519063+00:00	3		35	1
2217	2017-07-25 22:22:42.675299+03	1048	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:44:43.214612+00:00	3		35	1
2218	2017-07-25 22:22:42.679081+03	1047	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:44:11.728851+00:00	3		35	1
2219	2017-07-25 22:22:42.68212+03	1046	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:44:10.828099+00:00	3		35	1
2220	2017-07-25 22:22:42.693068+03	1045	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:44:09.835151+00:00	3		35	1
2221	2017-07-25 22:22:42.696779+03	1044	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:43:43.735145+00:00	3		35	1
2222	2017-07-25 22:22:42.700261+03	1043	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:43:42.302115+00:00	3		35	1
2223	2017-07-25 22:22:42.704043+03	1042	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:43:41.765797+00:00	3		35	1
2224	2017-07-25 22:22:42.708611+03	1041	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:43:15.311088+00:00	3		35	1
2225	2017-07-25 22:22:42.712644+03	1040	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:43:14.183496+00:00	3		35	1
2226	2017-07-25 22:22:42.716489+03	1039	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:43:13.101505+00:00	3		35	1
2227	2017-07-25 22:22:42.719663+03	1038	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:42:41.807344+00:00	3		35	1
2228	2017-07-25 22:22:42.722846+03	1037	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:42:40.433300+00:00	3		35	1
2229	2017-07-25 22:22:42.72599+03	1036	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:42:39.176106+00:00	3		35	1
2230	2017-07-25 22:22:42.729103+03	1035	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:42:12.751728+00:00	3		35	1
2231	2017-07-25 22:22:42.732265+03	1034	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:42:11.784186+00:00	3		35	1
2232	2017-07-25 22:22:42.735832+03	1033	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:42:11.191915+00:00	3		35	1
2233	2017-07-25 22:22:42.739329+03	1032	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:41:45.050506+00:00	3		35	1
2234	2017-07-25 22:22:42.743121+03	1031	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:41:43.574553+00:00	3		35	1
2235	2017-07-25 22:22:42.747622+03	1030	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:41:42.887333+00:00	3		35	1
2236	2017-07-25 22:22:42.75214+03	1029	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:41:11.671819+00:00	3		35	1
2237	2017-07-25 22:22:42.755649+03	1028	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:41:11.109257+00:00	3		35	1
2238	2017-07-25 22:22:42.75934+03	1027	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:41:10.385464+00:00	3		35	1
2239	2017-07-25 22:22:42.763046+03	1026	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:40:39.708147+00:00	3		35	1
2240	2017-07-25 22:22:42.768011+03	1025	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:40:39.134582+00:00	3		35	1
2241	2017-07-25 22:22:42.771262+03	1024	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:40:38.362097+00:00	3		35	1
2242	2017-07-25 22:22:42.774256+03	1023	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:40:11.893453+00:00	3		35	1
2243	2017-07-25 22:22:42.77812+03	1022	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:40:11.258689+00:00	3		35	1
2244	2017-07-25 22:22:42.781873+03	1021	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:40:10.517526+00:00	3		35	1
2245	2017-07-25 22:22:42.785096+03	1020	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:39:44.614968+00:00	3		35	1
2246	2017-07-25 22:22:42.788384+03	1019	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:39:44.018076+00:00	3		35	1
2247	2017-07-25 22:22:42.791937+03	1018	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:39:42.732882+00:00	3		35	1
2248	2017-07-25 22:22:42.795575+03	1017	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:39:11.786146+00:00	3		35	1
2249	2017-07-25 22:22:42.799593+03	1016	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:39:11.042997+00:00	3		35	1
2250	2017-07-25 22:22:42.802661+03	1015	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:39:10.315726+00:00	3		35	1
2251	2017-07-25 22:22:42.805663+03	1014	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:38:43.680570+00:00	3		35	1
2252	2017-07-25 22:22:42.809095+03	1013	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:38:43.131903+00:00	3		35	1
2253	2017-07-25 22:22:42.812498+03	1012	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:38:41.932762+00:00	3		35	1
2254	2017-07-25 22:22:42.815864+03	1011	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:38:11.005895+00:00	3		35	1
2255	2017-07-25 22:22:42.818921+03	1010	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:38:09.739526+00:00	3		35	1
2256	2017-07-25 22:22:42.821888+03	1009	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:38:08.248928+00:00	3		35	1
2257	2017-07-25 22:22:42.824927+03	1008	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:37:41.741329+00:00	3		35	1
2258	2017-07-25 22:22:42.828389+03	1007	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:37:40.355671+00:00	3		35	1
2259	2017-07-25 22:22:42.831592+03	1006	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:37:39.126336+00:00	3		35	1
2260	2017-07-25 22:22:42.83483+03	1005	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:37:12.848585+00:00	3		35	1
2261	2017-07-25 22:22:42.846148+03	1004	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:37:11.322042+00:00	3		35	1
2262	2017-07-25 22:22:42.850909+03	1003	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:37:10.759539+00:00	3		35	1
2263	2017-07-25 22:22:42.855036+03	1002	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:36:44.738524+00:00	3		35	1
2264	2017-07-25 22:22:42.867066+03	1001	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:36:43.702298+00:00	3		35	1
2265	2017-07-25 22:22:42.870483+03	1000	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:36:42.723793+00:00	3		35	1
2266	2017-07-25 22:22:42.873673+03	999	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:36:11.295492+00:00	3		35	1
2267	2017-07-25 22:22:42.87747+03	998	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:36:09.955363+00:00	3		35	1
2268	2017-07-25 22:22:42.88127+03	997	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:36:08.938600+00:00	3		35	1
2269	2017-07-25 22:22:42.884522+03	996	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:35:43.231797+00:00	3		35	1
2270	2017-07-25 22:22:42.887374+03	995	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:35:42.340302+00:00	3		35	1
2271	2017-07-25 22:22:42.890345+03	994	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:35:41.746985+00:00	3		35	1
2272	2017-07-25 22:22:42.893569+03	993	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:35:15.300176+00:00	3		35	1
2273	2017-07-25 22:22:42.897226+03	992	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:35:14.227497+00:00	3		35	1
2274	2017-07-25 22:22:42.900457+03	991	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:35:12.962790+00:00	3		35	1
2275	2017-07-25 22:22:42.903482+03	990	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:34:42.288498+00:00	3		35	1
2276	2017-07-25 22:22:42.906519+03	989	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:34:41.185486+00:00	3		35	1
2277	2017-07-25 22:22:42.909595+03	988	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:34:39.982781+00:00	3		35	1
2278	2017-07-25 22:22:42.913759+03	987	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:34:13.414514+00:00	3		35	1
2279	2017-07-25 22:22:42.917323+03	986	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:34:12.712808+00:00	3		35	1
2280	2017-07-25 22:22:42.920551+03	985	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:34:12.126276+00:00	3		35	1
2281	2017-07-25 22:22:42.923873+03	984	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 18:33:50.710909+00:00	3		35	1
2282	2017-07-25 22:22:42.927694+03	983	gisModule.tasks.blame_module_check_proposal - 2017-07-25 18:33:49.360949+00:00	3		35	1
2283	2017-07-25 22:22:42.931416+03	982	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 18:33:48.691302+00:00	3		35	1
2284	2017-07-25 22:22:52.463216+03	20	FalsePriceProposal object	3		37	1
2285	2017-07-25 22:23:00.363028+03	32	test -> Test Retailer | Test Product 1L	3		34	1
2286	2017-07-25 22:23:00.371727+03	31	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2287	2017-07-25 22:23:10.374728+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
2288	2017-07-25 22:25:07.571066+03	1413	gisModule.tasks.statistic_module_basic_statistics	3		36	1
2289	2017-07-25 22:25:07.577185+03	1412	gisModule.tasks.blame_module_check_proposal	3		36	1
2290	2017-07-25 22:25:07.581033+03	1411	gisModule.tasks.blame_module_check_blame_status	3		36	1
2291	2017-07-25 23:03:32.878998+03	34	test -> Test Retailer | Test Product 1L	3		34	1
2292	2017-07-25 23:03:32.88755+03	33	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2293	2017-07-25 23:03:37.221975+03	21	FalsePriceProposal object	3		37	1
2294	2017-07-25 23:03:48.638441+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
2295	2017-07-25 23:08:23.528381+03	35	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2296	2017-07-25 23:08:37.691763+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
2297	2017-07-25 23:10:50.632224+03	36	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2298	2017-07-25 23:17:46.83675+03	22	FalsePriceProposal object	3		37	1
2299	2017-07-25 23:18:11.85182+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
2300	2017-07-25 23:18:41.253124+03	31	Test Retailer	2	[{"changed": {"fields": ["reputation"]}}]	10	1
2301	2017-07-25 23:21:54.208673+03	37	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2302	2017-07-25 23:25:59.258873+03	23	FalsePriceProposal object	3		37	1
2303	2017-07-25 23:26:05.799948+03	39	test -> Test Retailer | Test Product 1L	3		34	1
2304	2017-07-25 23:26:05.808272+03	38	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2305	2017-07-25 23:26:15.73853+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing"]}}]	15	1
2306	2017-07-25 23:31:59.07039+03	41	test -> Test Retailer | Test Product 1L	3		34	1
2307	2017-07-25 23:31:59.08876+03	40	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2308	2017-07-25 23:32:06.655651+03	24	FalsePriceProposal object	3		37	1
2309	2017-07-25 23:32:23.93178+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
2310	2017-07-25 23:32:33.387899+03	31	Test Retailer	2	[{"changed": {"fields": ["reputation"]}}]	10	1
2311	2017-07-26 00:30:52.424728+03	25	FalsePriceProposal object	3		37	1
2312	2017-07-26 00:31:05.205196+03	255	Test Retailer | Test Product 1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
2313	2017-07-26 00:31:21.706226+03	2	UserStatistics object	2	[{"changed": {"fields": ["blame_count", "reputation", "shoppingListsComplete"]}}]	39	1
2314	2017-07-26 00:31:35.476472+03	1	UserStatistics object	2	[{"changed": {"fields": ["blame_count", "reputation", "itemsBought", "shoppingListsComplete", "favoriteCategory", "favoriteProduct"]}}]	39	1
2315	2017-07-26 00:31:47.667316+03	43	test -> Test Retailer | Test Product 1L	3		34	1
2316	2017-07-26 00:31:47.675672+03	42	dyanikoglu -> Test Retailer | Test Product 1L	3		34	1
2317	2017-07-26 00:32:04.213429+03	31	Test Retailer	2	[{"changed": {"fields": ["reputation"]}}]	10	1
2318	2017-07-26 00:32:33.682814+03	117	Just A Test Group	3		32	1
2319	2017-07-26 00:32:42.622766+03	75	dyanikoglu - test	3		30	1
2320	2017-07-26 11:30:42.312626+03	48	Test Root Group	1	[{"added": {}}]	13	1
2321	2017-07-26 11:31:00.831186+03	49	Test Child Group	1	[{"added": {}}]	13	1
2322	2017-07-26 11:31:20.919857+03	49	Test Child Group	3		13	1
2323	2017-07-26 11:31:20.925478+03	48	Test Root Group	3		13	1
2339	2017-07-26 11:59:32.502608+03	45	test -> Atlantis AVM | Coca-Cola  1L	3		34	1
2340	2017-07-26 11:59:32.508642+03	44	dyanikoglu -> Atlantis AVM | Coca-Cola  1L	3		34	1
2341	2017-07-26 12:00:24.500726+03	258	Panora AVM | Test Product 1L	3		15	1
2342	2017-07-26 12:00:24.507827+03	257	Arcadium AVM | Test Product 1L	3		15	1
2343	2017-07-26 12:00:24.513474+03	256	Atlantis AVM | Test Product 1L	3		15	1
2344	2017-07-26 12:00:51.512796+03	2	UserStatistics object	2	[{"changed": {"fields": ["blame_count", "shoppingListsComplete"]}}]	39	1
2345	2017-07-26 12:01:00.703338+03	1	UserStatistics object	2	[{"changed": {"fields": ["blame_count", "itemsBought", "shoppingListsComplete", "favoriteCategory", "favoriteProduct"]}}]	39	1
2346	2017-07-26 12:08:15.16651+03	44	dyanikoglu:test	3		28	1
2347	2017-07-26 12:08:25.022921+03	26	Test Product 1L	3		12	1
2348	2017-07-26 12:08:36.634393+03	76	dyanikoglu - test	3		30	1
2349	2017-07-26 12:08:43.446085+03	162	Test Group - dyanikoglu	3		31	1
2350	2017-07-26 12:08:43.451508+03	161	Test Group - test	3		31	1
2351	2017-07-26 12:08:49.195081+03	118	Test Group	3		32	1
2352	2017-07-26 12:09:21.01657+03	516	ShoppingListItem object	3		19	1
2353	2017-07-26 12:09:21.022424+03	515	ShoppingListItem object	3		19	1
2354	2017-07-26 12:09:27.129714+03	74	test:My First Shopping List	3		27	1
2355	2017-07-26 12:09:27.133385+03	73	dyanikoglu:My First Shopping List	3		27	1
2356	2017-07-26 12:09:27.136809+03	72	test:Test List	3		27	1
2357	2017-07-26 12:09:27.140291+03	71	dyanikoglu:Test List	3		27	1
2358	2017-07-26 12:09:32.95851+03	60	My First Shopping List	3		18	1
2359	2017-07-26 12:09:32.964352+03	59	My First Shopping List	3		18	1
2360	2017-07-26 12:09:32.968349+03	58	Test List	3		18	1
2361	2017-07-26 12:16:22.866888+03	21	dyanikoglu	3		17	1
2362	2017-07-26 12:16:33.721024+03	3	UserStatistics object	3		39	1
2363	2017-07-26 12:16:33.732994+03	2	UserStatistics object	3		39	1
2364	2017-07-26 12:16:33.736683+03	1	UserStatistics object	3		39	1
2365	2017-07-26 12:16:47.55719+03	21	UserPreferences object	3		29	1
2366	2017-07-26 12:16:47.562988+03	18	UserPreferences object	3		29	1
2367	2017-07-26 12:16:47.566087+03	16	UserPreferences object	3		29	1
2368	2017-07-26 15:03:48.819013+03	4	UserStatistics object	2	[{"changed": {"fields": ["itemsBought", "shoppingListsComplete", "favoriteCategory", "favoriteProduct"]}}]	39	1
2369	2017-07-26 17:37:19.084887+03	119	test	1	[{"added": {}}]	32	1
2370	2017-07-26 17:37:41.581888+03	50	test	1	[{"added": {}}]	13	1
2371	2017-07-26 17:37:48.876832+03	51	child	1	[{"added": {}}]	13	1
2372	2017-07-26 17:38:03.820673+03	52	child2	1	[{"added": {}}]	13	1
2373	2017-07-29 18:01:31.543769+03	532	ShoppingListItem object	2	[{"changed": {"fields": ["unit_purchase_price"]}}]	19	1
2374	2017-07-29 18:01:40.118608+03	535	ShoppingListItem object	2	[{"changed": {"fields": ["unit_purchase_price"]}}]	19	1
2375	2017-09-02 00:20:09.952008+03	535	ShoppingListItem object	3		19	1
2376	2017-09-02 00:20:09.957186+03	534	ShoppingListItem object	3		19	1
2377	2017-09-02 00:20:09.960368+03	533	ShoppingListItem object	3		19	1
2378	2017-09-02 00:20:09.963726+03	532	ShoppingListItem object	3		19	1
2379	2017-09-02 00:20:09.966924+03	531	ShoppingListItem object	3		19	1
2380	2017-09-02 00:20:09.970584+03	530	ShoppingListItem object	3		19	1
2381	2017-09-02 00:20:09.974095+03	529	ShoppingListItem object	3		19	1
2382	2017-09-02 00:20:09.977374+03	528	ShoppingListItem object	3		19	1
2383	2017-09-02 00:20:09.980895+03	521	ShoppingListItem object	3		19	1
2384	2017-09-02 00:20:09.984731+03	520	ShoppingListItem object	3		19	1
2385	2017-09-02 00:20:09.988409+03	519	ShoppingListItem object	3		19	1
2386	2017-09-02 00:20:09.992263+03	518	ShoppingListItem object	3		19	1
2387	2017-09-02 00:20:37.437609+03	66	My First Shopping List	3		18	1
2388	2017-09-03 22:38:49.918924+03	2654	gisModule.tasks.statistic_module_basic_statistics	3		36	1
2389	2017-09-03 22:38:49.933543+03	2653	gisModule.tasks.blame_module_check_proposal	3		36	1
2390	2017-09-03 22:38:49.937134+03	2652	gisModule.tasks.blame_module_check_blame_status	3		36	1
2391	2017-09-03 22:39:07.848104+03	2122	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:18.191226+00:00	3		35	1
2392	2017-09-03 22:39:07.85371+03	2121	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:44:17.449964+00:00	3		35	1
2393	2017-09-03 22:39:07.857377+03	2120	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:44:16.638613+00:00	3		35	1
2394	2017-09-03 22:39:07.860556+03	2119	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:15.408752+00:00	3		35	1
2395	2017-09-03 22:39:07.86357+03	2118	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:44:14.628195+00:00	3		35	1
2396	2017-09-03 22:39:07.866707+03	2117	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:44:13.297454+00:00	3		35	1
2397	2017-09-03 22:39:07.870021+03	2116	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:12.225286+00:00	3		35	1
2398	2017-09-03 22:39:07.874064+03	2115	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:44:11.448551+00:00	3		35	1
2399	2017-09-03 22:39:07.878063+03	2114	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:44:10.286299+00:00	3		35	1
2400	2017-09-03 22:39:07.881707+03	2113	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:09.102209+00:00	3		35	1
2401	2017-09-03 22:39:07.88542+03	2112	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:44:07.963380+00:00	3		35	1
2402	2017-09-03 22:39:07.8892+03	2111	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:44:06.617898+00:00	3		35	1
2403	2017-09-03 22:39:07.893116+03	2110	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:05.968909+00:00	3		35	1
2404	2017-09-03 22:39:07.896354+03	2109	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:44:05.048904+00:00	3		35	1
2405	2017-09-03 22:39:07.906622+03	2108	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:44:03.975525+00:00	3		35	1
2406	2017-09-03 22:39:07.910404+03	2107	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:02.794368+00:00	3		35	1
2407	2017-09-03 22:39:07.914191+03	2106	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:44:02.027487+00:00	3		35	1
2408	2017-09-03 22:39:07.918409+03	2105	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:44:01.416155+00:00	3		35	1
2409	2017-09-03 22:39:07.922542+03	2104	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:44:00.505293+00:00	3		35	1
2410	2017-09-03 22:39:07.933647+03	2103	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:43:59.480062+00:00	3		35	1
2411	2017-09-03 22:39:07.937504+03	2102	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:43:58.395616+00:00	3		35	1
2412	2017-09-03 22:39:07.94156+03	2101	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:43:57.073451+00:00	3		35	1
3366	2017-09-03 22:39:53.964739+03	51	child	3		13	1
2413	2017-09-03 22:39:07.945731+03	2100	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:43:56.408812+00:00	3		35	1
2414	2017-09-03 22:39:07.949305+03	2099	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:43:55.124692+00:00	3		35	1
2415	2017-09-03 22:39:07.952959+03	2098	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:43:53.700851+00:00	3		35	1
2416	2017-09-03 22:39:07.956851+03	2097	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:43:52.990370+00:00	3		35	1
2417	2017-09-03 22:39:07.960792+03	2096	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:35:25.729788+00:00	3		35	1
2418	2017-09-03 22:39:07.964123+03	2095	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:35:24.276631+00:00	3		35	1
2419	2017-09-03 22:39:07.967446+03	2094	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:35:22.763076+00:00	3		35	1
2420	2017-09-03 22:39:07.97075+03	2093	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:56.568326+00:00	3		35	1
2421	2017-09-03 22:39:07.974246+03	2092	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:55.292910+00:00	3		35	1
2422	2017-09-03 22:39:07.977472+03	2091	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:54.758043+00:00	3		35	1
2423	2017-09-03 22:39:07.980606+03	2090	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:23.884744+00:00	3		35	1
2424	2017-09-03 22:39:07.98354+03	2089	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:22.962204+00:00	3		35	1
2425	2017-09-03 22:39:07.986587+03	2088	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:22.056831+00:00	3		35	1
2426	2017-09-03 22:39:07.99049+03	2087	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:21.089332+00:00	3		35	1
2427	2017-09-03 22:39:07.994664+03	2086	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:19.929862+00:00	3		35	1
2428	2017-09-03 22:39:07.99849+03	2085	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:18.768689+00:00	3		35	1
2429	2017-09-03 22:39:08.002362+03	2084	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:17.612433+00:00	3		35	1
2430	2017-09-03 22:39:08.007144+03	2083	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:16.517555+00:00	3		35	1
2431	2017-09-03 22:39:08.01107+03	2082	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:15.220054+00:00	3		35	1
2432	2017-09-03 22:39:08.01447+03	2081	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:14.046353+00:00	3		35	1
2433	2017-09-03 22:39:08.017913+03	2080	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:13.228498+00:00	3		35	1
2434	2017-09-03 22:39:08.021527+03	2079	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:12.342178+00:00	3		35	1
2435	2017-09-03 22:39:08.025262+03	2078	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:11.498045+00:00	3		35	1
2436	2017-09-03 22:39:08.035881+03	2077	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:09.969067+00:00	3		35	1
2437	2017-09-03 22:39:08.039967+03	2076	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:09.113313+00:00	3		35	1
2438	2017-09-03 22:39:08.044558+03	2075	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:08.399924+00:00	3		35	1
2439	2017-09-03 22:39:08.047798+03	2074	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:06.950121+00:00	3		35	1
2440	2017-09-03 22:39:08.0509+03	2073	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:34:06.146916+00:00	3		35	1
2441	2017-09-03 22:39:08.054314+03	2072	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:34:04.696590+00:00	3		35	1
2442	2017-09-03 22:39:08.057828+03	2071	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:34:03.542283+00:00	3		35	1
2443	2017-09-03 22:39:08.061458+03	2070	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:32:42.397744+00:00	3		35	1
2444	2017-09-03 22:39:08.064937+03	2069	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:32:41.208596+00:00	3		35	1
2445	2017-09-03 22:39:08.068473+03	2068	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:32:39.812070+00:00	3		35	1
2446	2017-09-03 22:39:08.071753+03	2067	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:32:39.196290+00:00	3		35	1
2447	2017-09-03 22:39:08.07562+03	2066	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 21:32:38.231050+00:00	3		35	1
2448	2017-09-03 22:39:08.079435+03	2065	gisModule.tasks.blame_module_check_proposal - 2017-09-02 21:32:37.573535+00:00	3		35	1
2449	2017-09-03 22:39:08.083201+03	2064	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 21:32:36.774401+00:00	3		35	1
2450	2017-09-03 22:39:08.087028+03	2063	gisModule.tasks.statistic_module_basic_statistics - 2017-09-02 12:27:41.273163+00:00	3		35	1
2451	2017-09-03 22:39:08.090736+03	2062	gisModule.tasks.blame_module_check_proposal - 2017-09-02 12:27:40.168455+00:00	3		35	1
2452	2017-09-03 22:39:08.094626+03	2061	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 12:27:38.769379+00:00	3		35	1
2453	2017-09-03 22:39:08.098897+03	2060	gisModule.tasks.blame_module_check_proposal - 2017-09-02 12:27:15.220914+00:00	3		35	1
2454	2017-09-03 22:39:08.102251+03	2059	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 12:27:14.169242+00:00	3		35	1
2455	2017-09-03 22:39:08.105776+03	2058	gisModule.tasks.blame_module_check_proposal - 2017-09-02 12:27:11.711474+00:00	3		35	1
2456	2017-09-03 22:39:08.109981+03	2057	gisModule.tasks.blame_module_check_blame_status - 2017-09-02 12:27:10.375359+00:00	3		35	1
2457	2017-09-03 22:39:08.121703+03	2056	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:50:48.740489+00:00	3		35	1
2458	2017-09-03 22:39:08.125508+03	2055	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:50:48.050352+00:00	3		35	1
2459	2017-09-03 22:39:08.129554+03	2054	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:50:47.049255+00:00	3		35	1
2460	2017-09-03 22:39:08.132812+03	2053	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:50:15.709974+00:00	3		35	1
2461	2017-09-03 22:39:08.136063+03	2052	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:50:14.913333+00:00	3		35	1
2462	2017-09-03 22:39:08.140118+03	2051	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:50:13.643476+00:00	3		35	1
2463	2017-09-03 22:39:08.143997+03	2050	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:49:47.119994+00:00	3		35	1
2464	2017-09-03 22:39:08.147404+03	2049	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:49:46.537232+00:00	3		35	1
2465	2017-09-03 22:39:08.150579+03	2048	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:49:45.613765+00:00	3		35	1
2466	2017-09-03 22:39:08.153913+03	2047	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:49:14.583109+00:00	3		35	1
2467	2017-09-03 22:39:08.157207+03	2046	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:49:13.589506+00:00	3		35	1
2468	2017-09-03 22:39:08.160279+03	2045	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:49:12.485772+00:00	3		35	1
2469	2017-09-03 22:39:08.163293+03	2044	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:48:46.405407+00:00	3		35	1
2470	2017-09-03 22:39:08.166438+03	2043	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:48:45.668884+00:00	3		35	1
2471	2017-09-03 22:39:08.169588+03	2042	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:48:45.067556+00:00	3		35	1
2472	2017-09-03 22:39:08.173538+03	2041	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:48:19.186226+00:00	3		35	1
2473	2017-09-03 22:39:08.178029+03	2040	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:48:17.953460+00:00	3		35	1
2474	2017-09-03 22:39:08.181671+03	2039	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:48:16.821597+00:00	3		35	1
2475	2017-09-03 22:39:08.184814+03	2038	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:47:46.133188+00:00	3		35	1
2476	2017-09-03 22:39:08.188019+03	2037	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:47:45.011651+00:00	3		35	1
2477	2017-09-03 22:39:08.191141+03	2036	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:47:44.309061+00:00	3		35	1
2478	2017-09-03 22:39:08.195048+03	2035	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:47:18.113062+00:00	3		35	1
2479	2017-09-03 22:39:08.198697+03	2034	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:47:17.222981+00:00	3		35	1
2480	2017-09-03 22:39:08.202434+03	2033	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:47:16.664920+00:00	3		35	1
2481	2017-09-03 22:39:08.205947+03	2032	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:46:45.103239+00:00	3		35	1
2482	2017-09-03 22:39:08.209376+03	2031	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:46:44.207238+00:00	3		35	1
2483	2017-09-03 22:39:08.212473+03	2030	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:46:43.314116+00:00	3		35	1
2484	2017-09-03 22:39:08.215428+03	2029	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:46:17.336987+00:00	3		35	1
2485	2017-09-03 22:39:08.218646+03	2028	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:46:15.782948+00:00	3		35	1
2486	2017-09-03 22:39:08.221707+03	2027	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:46:14.885190+00:00	3		35	1
2487	2017-09-03 22:39:08.224868+03	2026	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:45:48.595547+00:00	3		35	1
2488	2017-09-03 22:39:08.228325+03	2025	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:45:47.605386+00:00	3		35	1
2489	2017-09-03 22:39:08.231242+03	2024	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:45:46.449529+00:00	3		35	1
2490	2017-09-03 22:39:08.234481+03	2023	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:45:15.003997+00:00	3		35	1
2491	2017-09-03 22:39:08.237501+03	2022	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:45:13.967281+00:00	3		35	1
2492	2017-09-03 22:39:08.240872+03	2021	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:45:13.256444+00:00	3		35	1
2493	2017-09-03 22:39:08.24394+03	2020	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:44:46.879311+00:00	3		35	1
2494	2017-09-03 22:39:08.24696+03	2019	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:44:46.225942+00:00	3		35	1
2495	2017-09-03 22:39:08.25022+03	2018	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:44:44.859614+00:00	3		35	1
2496	2017-09-03 22:39:08.253414+03	2017	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:44:14.074864+00:00	3		35	1
2497	2017-09-03 22:39:08.256712+03	2016	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:44:13.397638+00:00	3		35	1
2498	2017-09-03 22:39:08.260446+03	2015	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:44:12.714531+00:00	3		35	1
2499	2017-09-03 22:39:08.263959+03	2014	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:43:46.121379+00:00	3		35	1
2500	2017-09-03 22:39:08.267866+03	2013	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:43:45.086815+00:00	3		35	1
2501	2017-09-03 22:39:08.271603+03	2012	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:43:43.889947+00:00	3		35	1
2502	2017-09-03 22:39:08.275449+03	2011	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:43:17.843838+00:00	3		35	1
2503	2017-09-03 22:39:08.279034+03	2010	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:43:17.076121+00:00	3		35	1
2504	2017-09-03 22:39:08.282359+03	2009	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:43:15.611738+00:00	3		35	1
2505	2017-09-03 22:39:08.2853+03	2008	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:42:49.511462+00:00	3		35	1
2506	2017-09-03 22:39:08.288327+03	2007	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:42:48.040230+00:00	3		35	1
2507	2017-09-03 22:39:08.29152+03	2006	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:42:46.692592+00:00	3		35	1
2508	2017-09-03 22:39:08.295288+03	2005	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:42:15.094584+00:00	3		35	1
2509	2017-09-03 22:39:08.29836+03	2004	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:42:14.366709+00:00	3		35	1
2510	2017-09-03 22:39:08.30133+03	2003	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:42:13.549770+00:00	3		35	1
2511	2017-09-03 22:39:08.310778+03	2002	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:41:47.370186+00:00	3		35	1
2512	2017-09-03 22:39:08.31413+03	2001	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:41:46.672075+00:00	3		35	1
2513	2017-09-03 22:39:08.317497+03	2000	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:41:45.357475+00:00	3		35	1
2514	2017-09-03 22:39:08.321558+03	1999	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:41:14.543831+00:00	3		35	1
2515	2017-09-03 22:39:08.325552+03	1998	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:41:13.709125+00:00	3		35	1
2516	2017-09-03 22:39:08.329798+03	1997	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:41:13.130433+00:00	3		35	1
2517	2017-09-03 22:39:08.333047+03	1996	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:40:47.162171+00:00	3		35	1
2518	2017-09-03 22:39:08.336095+03	1995	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:40:45.805361+00:00	3		35	1
2519	2017-09-03 22:39:08.339283+03	1994	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:40:45.087296+00:00	3		35	1
2520	2017-09-03 22:39:08.343161+03	1993	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:40:18.900153+00:00	3		35	1
2521	2017-09-03 22:39:08.346176+03	1992	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:40:17.735092+00:00	3		35	1
2522	2017-09-03 22:39:08.349224+03	1991	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:40:16.257443+00:00	3		35	1
2523	2017-09-03 22:39:08.352402+03	1990	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:39:45.485698+00:00	3		35	1
2524	2017-09-03 22:39:08.355502+03	1989	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:39:44.370500+00:00	3		35	1
2525	2017-09-03 22:39:08.359073+03	1988	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:39:43.181915+00:00	3		35	1
2526	2017-09-03 22:39:08.362576+03	1987	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:39:17.390648+00:00	3		35	1
2527	2017-09-03 22:39:08.36972+03	1986	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:39:16.314818+00:00	3		35	1
2528	2017-09-03 22:39:08.375669+03	1985	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:39:14.816344+00:00	3		35	1
2529	2017-09-03 22:39:08.3789+03	1984	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:38:48.698322+00:00	3		35	1
2530	2017-09-03 22:39:08.381889+03	1983	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:38:47.650685+00:00	3		35	1
2531	2017-09-03 22:39:08.384924+03	1982	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:38:46.671128+00:00	3		35	1
2532	2017-09-03 22:39:08.388155+03	1981	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:38:15.803259+00:00	3		35	1
2533	2017-09-03 22:39:08.391981+03	1980	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:38:15.031322+00:00	3		35	1
2534	2017-09-03 22:39:08.395526+03	1979	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:38:13.808222+00:00	3		35	1
2535	2017-09-03 22:39:08.398953+03	1978	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:37:48.015000+00:00	3		35	1
2536	2017-09-03 22:39:08.402321+03	1977	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:37:46.613261+00:00	3		35	1
2537	2017-09-03 22:39:08.406402+03	1976	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:37:45.400955+00:00	3		35	1
2538	2017-09-03 22:39:08.40993+03	1975	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:37:14.727881+00:00	3		35	1
2539	2017-09-03 22:39:08.413108+03	1974	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:37:13.977367+00:00	3		35	1
2540	2017-09-03 22:39:08.416205+03	1973	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:37:12.670964+00:00	3		35	1
2541	2017-09-03 22:39:08.419339+03	1972	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:36:46.929560+00:00	3		35	1
2542	2017-09-03 22:39:08.422437+03	1971	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:36:46.064546+00:00	3		35	1
2543	2017-09-03 22:39:08.425471+03	1970	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:36:44.948538+00:00	3		35	1
2544	2017-09-03 22:39:08.428403+03	1969	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:36:18.866521+00:00	3		35	1
2545	2017-09-03 22:39:08.431288+03	1968	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:36:18.246173+00:00	3		35	1
2546	2017-09-03 22:39:08.434032+03	1967	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:36:16.823928+00:00	3		35	1
2547	2017-09-03 22:39:08.43686+03	1966	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:35:45.401440+00:00	3		35	1
2548	2017-09-03 22:39:08.440192+03	1965	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:35:44.191225+00:00	3		35	1
2549	2017-09-03 22:39:08.443396+03	1964	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:35:42.857195+00:00	3		35	1
2550	2017-09-03 22:39:08.44657+03	1963	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:35:16.521259+00:00	3		35	1
2551	2017-09-03 22:39:08.449989+03	1962	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:35:15.005363+00:00	3		35	1
2552	2017-09-03 22:39:08.454589+03	1961	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:35:13.548462+00:00	3		35	1
2553	2017-09-03 22:39:08.45848+03	1960	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:34:47.208296+00:00	3		35	1
2554	2017-09-03 22:39:08.462954+03	1959	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:34:46.641700+00:00	3		35	1
2555	2017-09-03 22:39:08.466374+03	1958	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:34:46.098118+00:00	3		35	1
2556	2017-09-03 22:39:08.469469+03	1957	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:34:14.627941+00:00	3		35	1
2557	2017-09-03 22:39:08.473342+03	1956	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:34:13.695753+00:00	3		35	1
2558	2017-09-03 22:39:08.477256+03	1955	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:34:12.876086+00:00	3		35	1
2559	2017-09-03 22:39:08.480559+03	1954	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:33:46.354959+00:00	3		35	1
2560	2017-09-03 22:39:08.483789+03	1953	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:33:45.216355+00:00	3		35	1
2561	2017-09-03 22:39:08.486952+03	1952	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:33:44.059086+00:00	3		35	1
2562	2017-09-03 22:39:08.490196+03	1951	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:33:17.626504+00:00	3		35	1
2563	2017-09-03 22:39:08.493316+03	1950	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:33:16.745152+00:00	3		35	1
2564	2017-09-03 22:39:08.496383+03	1949	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:33:15.534741+00:00	3		35	1
2565	2017-09-03 22:39:08.500796+03	1948	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:32:44.626052+00:00	3		35	1
2566	2017-09-03 22:39:08.505331+03	1947	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:32:43.471086+00:00	3		35	1
2567	2017-09-03 22:39:08.509131+03	1946	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:32:42.504796+00:00	3		35	1
2568	2017-09-03 22:39:08.512289+03	1945	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:32:15.874345+00:00	3		35	1
2569	2017-09-03 22:39:08.515442+03	1944	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:32:14.804033+00:00	3		35	1
2570	2017-09-03 22:39:08.518576+03	1943	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:32:14.172693+00:00	3		35	1
2571	2017-09-03 22:39:08.522031+03	1942	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:31:48.026400+00:00	3		35	1
2572	2017-09-03 22:39:08.525472+03	1941	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:31:47.050080+00:00	3		35	1
2573	2017-09-03 22:39:08.528689+03	1940	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:31:45.887753+00:00	3		35	1
2574	2017-09-03 22:39:08.531692+03	1939	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:31:14.548062+00:00	3		35	1
2575	2017-09-03 22:39:08.534966+03	1938	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:31:13.378449+00:00	3		35	1
2576	2017-09-03 22:39:08.538506+03	1937	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:31:12.363425+00:00	3		35	1
2577	2017-09-03 22:39:08.54228+03	1936	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:30:46.689427+00:00	3		35	1
2578	2017-09-03 22:39:08.545873+03	1935	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:30:45.923455+00:00	3		35	1
2579	2017-09-03 22:39:08.549066+03	1934	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:30:44.727485+00:00	3		35	1
2580	2017-09-03 22:39:08.55221+03	1933	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:30:14.050488+00:00	3		35	1
2581	2017-09-03 22:39:08.556061+03	1932	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:30:12.863088+00:00	3		35	1
2582	2017-09-03 22:39:08.559379+03	1931	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:30:12.186187+00:00	3		35	1
2583	2017-09-03 22:39:08.562283+03	1930	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:29:46.390052+00:00	3		35	1
2584	2017-09-03 22:39:08.565095+03	1929	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:29:45.820726+00:00	3		35	1
2585	2017-09-03 22:39:08.568108+03	1928	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:29:44.695812+00:00	3		35	1
2586	2017-09-03 22:39:08.571353+03	1927	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:29:18.282555+00:00	3		35	1
2587	2017-09-03 22:39:08.584759+03	1926	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:29:17.120046+00:00	3		35	1
2588	2017-09-03 22:39:08.588434+03	1925	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:29:16.582538+00:00	3		35	1
2589	2017-09-03 22:39:08.592557+03	1924	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:28:45.025330+00:00	3		35	1
2590	2017-09-03 22:39:08.59591+03	1923	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:28:44.463407+00:00	3		35	1
2591	2017-09-03 22:39:08.599223+03	1922	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:28:43.414122+00:00	3		35	1
2592	2017-09-03 22:39:08.603229+03	1921	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:28:17.106926+00:00	3		35	1
2593	2017-09-03 22:39:08.608148+03	1920	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:28:16.278134+00:00	3		35	1
2594	2017-09-03 22:39:08.612164+03	1919	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:28:15.485629+00:00	3		35	1
2595	2017-09-03 22:39:08.616054+03	1918	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:27:43.924082+00:00	3		35	1
2596	2017-09-03 22:39:08.620017+03	1917	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:27:43.201238+00:00	3		35	1
2597	2017-09-03 22:39:08.626416+03	1916	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:27:42.088870+00:00	3		35	1
2598	2017-09-03 22:39:08.630239+03	1915	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:27:15.467963+00:00	3		35	1
2599	2017-09-03 22:39:08.633266+03	1914	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:27:14.545875+00:00	3		35	1
2600	2017-09-03 22:39:08.636191+03	1913	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:27:13.020544+00:00	3		35	1
2601	2017-09-03 22:39:08.646981+03	1912	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:26:46.805852+00:00	3		35	1
2602	2017-09-03 22:39:08.650184+03	1911	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:26:45.939350+00:00	3		35	1
2603	2017-09-03 22:39:08.653163+03	1910	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:26:45.079118+00:00	3		35	1
2604	2017-09-03 22:39:08.657255+03	1909	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:26:18.923818+00:00	3		35	1
2605	2017-09-03 22:39:08.662444+03	1908	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:26:17.783021+00:00	3		35	1
2606	2017-09-03 22:39:08.66581+03	1907	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:26:16.614405+00:00	3		35	1
2607	2017-09-03 22:39:08.668918+03	1906	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:25:45.602474+00:00	3		35	1
2608	2017-09-03 22:39:08.67223+03	1905	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:25:44.633034+00:00	3		35	1
2609	2017-09-03 22:39:08.676746+03	1904	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:25:43.689032+00:00	3		35	1
2610	2017-09-03 22:39:08.679923+03	1903	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:25:17.707009+00:00	3		35	1
2611	2017-09-03 22:39:08.682794+03	1902	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:25:16.767773+00:00	3		35	1
2612	2017-09-03 22:39:08.686339+03	1901	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:25:15.354887+00:00	3		35	1
2613	2017-09-03 22:39:08.690193+03	1900	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:24:44.526163+00:00	3		35	1
2614	2017-09-03 22:39:08.694591+03	1899	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:24:43.926008+00:00	3		35	1
2615	2017-09-03 22:39:08.697694+03	1898	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:24:42.452864+00:00	3		35	1
2616	2017-09-03 22:39:08.700956+03	1897	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:24:15.996493+00:00	3		35	1
2617	2017-09-03 22:39:08.704426+03	1896	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:24:14.443494+00:00	3		35	1
2618	2017-09-03 22:39:08.709119+03	1895	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:24:12.938135+00:00	3		35	1
2619	2017-09-03 22:39:08.722007+03	1894	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:23:47.226377+00:00	3		35	1
2620	2017-09-03 22:39:08.726019+03	1893	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:23:46.428721+00:00	3		35	1
2621	2017-09-03 22:39:08.730441+03	1892	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:23:45.014037+00:00	3		35	1
2622	2017-09-03 22:39:08.733637+03	1891	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:23:14.363821+00:00	3		35	1
2623	2017-09-03 22:39:08.736759+03	1890	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:23:13.660213+00:00	3		35	1
2624	2017-09-03 22:39:08.741025+03	1889	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:23:12.642527+00:00	3		35	1
2625	2017-09-03 22:39:08.744807+03	1888	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:22:46.621910+00:00	3		35	1
2626	2017-09-03 22:39:08.747944+03	1887	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:22:45.733112+00:00	3		35	1
2627	2017-09-03 22:39:08.751127+03	1886	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:22:44.255178+00:00	3		35	1
2628	2017-09-03 22:39:08.754546+03	1885	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:22:17.943510+00:00	3		35	1
2629	2017-09-03 22:39:08.758696+03	1884	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:22:17.330370+00:00	3		35	1
2630	2017-09-03 22:39:08.763384+03	1883	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:22:16.066381+00:00	3		35	1
2631	2017-09-03 22:39:08.766584+03	1882	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:21:45.205343+00:00	3		35	1
2632	2017-09-03 22:39:08.778348+03	1881	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:21:44.526762+00:00	3		35	1
2633	2017-09-03 22:39:08.781884+03	1880	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:21:43.092124+00:00	3		35	1
2634	2017-09-03 22:39:08.785142+03	1879	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:21:16.698372+00:00	3		35	1
2635	2017-09-03 22:39:08.788609+03	1878	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:21:15.611212+00:00	3		35	1
2636	2017-09-03 22:39:08.792326+03	1877	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:21:14.465858+00:00	3		35	1
2637	2017-09-03 22:39:08.795702+03	1876	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:20:47.952701+00:00	3		35	1
2638	2017-09-03 22:39:08.798932+03	1875	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:20:47.011353+00:00	3		35	1
2639	2017-09-03 22:39:08.802759+03	1874	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:20:43.308184+00:00	3		35	1
2640	2017-09-03 22:39:08.806887+03	1873	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:20:16.961451+00:00	3		35	1
2641	2017-09-03 22:39:08.810741+03	1872	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:20:15.778127+00:00	3		35	1
2642	2017-09-03 22:39:08.813702+03	1871	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:20:14.902856+00:00	3		35	1
2643	2017-09-03 22:39:08.816903+03	1870	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:19:48.391725+00:00	3		35	1
2644	2017-09-03 22:39:08.819834+03	1869	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:19:47.073466+00:00	3		35	1
2645	2017-09-03 22:39:08.824237+03	1868	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:19:46.072044+00:00	3		35	1
2646	2017-09-03 22:39:08.827946+03	1867	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:19:14.820923+00:00	3		35	1
2647	2017-09-03 22:39:08.8309+03	1866	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:19:13.781194+00:00	3		35	1
2648	2017-09-03 22:39:08.834278+03	1865	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:19:13.226970+00:00	3		35	1
2649	2017-09-03 22:39:08.839722+03	1864	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:18:46.733489+00:00	3		35	1
2650	2017-09-03 22:39:08.851995+03	1863	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:18:45.251366+00:00	3		35	1
2651	2017-09-03 22:39:08.855614+03	1862	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:18:44.660499+00:00	3		35	1
2652	2017-09-03 22:39:08.859126+03	1861	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:18:18.667746+00:00	3		35	1
2653	2017-09-03 22:39:08.863305+03	1860	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:18:17.743468+00:00	3		35	1
2654	2017-09-03 22:39:08.874779+03	1859	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:18:16.887594+00:00	3		35	1
2655	2017-09-03 22:39:08.878614+03	1858	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:17:45.329338+00:00	3		35	1
2656	2017-09-03 22:39:08.889354+03	1857	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:17:43.772941+00:00	3		35	1
2657	2017-09-03 22:39:08.893942+03	1856	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:17:42.688329+00:00	3		35	1
2658	2017-09-03 22:39:08.904844+03	1855	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:17:16.090116+00:00	3		35	1
2659	2017-09-03 22:39:08.909294+03	1854	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:17:14.561858+00:00	3		35	1
2660	2017-09-03 22:39:08.913672+03	1853	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:17:13.964718+00:00	3		35	1
2661	2017-09-03 22:39:08.917164+03	1852	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:16:47.397914+00:00	3		35	1
2662	2017-09-03 22:39:08.921076+03	1851	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:16:46.523486+00:00	3		35	1
2663	2017-09-03 22:39:08.924258+03	1850	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:16:45.623811+00:00	3		35	1
2664	2017-09-03 22:39:08.927378+03	1849	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:16:14.834241+00:00	3		35	1
2665	2017-09-03 22:39:08.930368+03	1848	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:16:14.055548+00:00	3		35	1
2666	2017-09-03 22:39:08.941448+03	1847	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:16:13.506566+00:00	3		35	1
2667	2017-09-03 22:39:08.945968+03	1846	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:15:47.694314+00:00	3		35	1
2668	2017-09-03 22:39:08.949712+03	1845	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:15:46.619297+00:00	3		35	1
2669	2017-09-03 22:39:08.954438+03	1844	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:15:45.371904+00:00	3		35	1
2670	2017-09-03 22:39:08.958107+03	1843	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:15:14.130736+00:00	3		35	1
2671	2017-09-03 22:39:08.970129+03	1842	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:15:12.967088+00:00	3		35	1
2672	2017-09-03 22:39:08.973167+03	1841	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:15:12.124310+00:00	3		35	1
2673	2017-09-03 22:39:08.976817+03	1840	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:14:45.586785+00:00	3		35	1
2674	2017-09-03 22:39:08.980594+03	1839	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:14:44.045138+00:00	3		35	1
2675	2017-09-03 22:39:08.984903+03	1838	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:14:42.758051+00:00	3		35	1
2676	2017-09-03 22:39:08.995717+03	1837	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:14:16.418373+00:00	3		35	1
2677	2017-09-03 22:39:08.999522+03	1836	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:14:14.941549+00:00	3		35	1
2678	2017-09-03 22:39:09.003113+03	1835	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:14:13.758379+00:00	3		35	1
2679	2017-09-03 22:39:09.006911+03	1834	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:13:42.105963+00:00	3		35	1
2680	2017-09-03 22:39:09.010497+03	1833	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:13:40.694519+00:00	3		35	1
2681	2017-09-03 22:39:09.01407+03	1832	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:13:39.886049+00:00	3		35	1
2682	2017-09-03 22:39:09.017652+03	1831	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:13:13.392611+00:00	3		35	1
2683	2017-09-03 22:39:09.021323+03	1830	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:13:12.747278+00:00	3		35	1
2684	2017-09-03 22:39:09.025671+03	1829	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:13:11.510611+00:00	3		35	1
2685	2017-09-03 22:39:09.033392+03	1828	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:12:45.394520+00:00	3		35	1
2686	2017-09-03 22:39:09.03645+03	1827	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:12:44.306469+00:00	3		35	1
2687	2017-09-03 22:39:09.039914+03	1826	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:12:43.729408+00:00	3		35	1
2688	2017-09-03 22:39:09.043477+03	1825	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:12:12.964709+00:00	3		35	1
2689	2017-09-03 22:39:09.046718+03	1824	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:12:12.387638+00:00	3		35	1
2690	2017-09-03 22:39:09.049659+03	1823	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:12:11.849299+00:00	3		35	1
2691	2017-09-03 22:39:09.052695+03	1822	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:11:45.997839+00:00	3		35	1
2692	2017-09-03 22:39:09.056198+03	1821	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:11:44.595660+00:00	3		35	1
2693	2017-09-03 22:39:09.059564+03	1820	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:11:43.652405+00:00	3		35	1
2694	2017-09-03 22:39:09.062368+03	1819	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:11:12.464420+00:00	3		35	1
2695	2017-09-03 22:39:09.065262+03	1818	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:11:11.793625+00:00	3		35	1
2696	2017-09-03 22:39:09.068217+03	1817	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:11:11.055329+00:00	3		35	1
2697	2017-09-03 22:39:09.07114+03	1816	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:10:44.988982+00:00	3		35	1
2698	2017-09-03 22:39:09.074193+03	1815	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:10:43.925150+00:00	3		35	1
2699	2017-09-03 22:39:09.077486+03	1814	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:10:42.897600+00:00	3		35	1
2700	2017-09-03 22:39:09.080531+03	1813	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:10:16.427640+00:00	3		35	1
2701	2017-09-03 22:39:09.083471+03	1812	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:10:15.156192+00:00	3		35	1
2702	2017-09-03 22:39:09.086411+03	1811	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:10:14.375208+00:00	3		35	1
2703	2017-09-03 22:39:09.089674+03	1810	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:09:43.208321+00:00	3		35	1
2704	2017-09-03 22:39:09.09276+03	1809	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:09:42.568285+00:00	3		35	1
2705	2017-09-03 22:39:09.0957+03	1808	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:09:41.696414+00:00	3		35	1
2706	2017-09-03 22:39:09.098584+03	1807	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:09:15.765246+00:00	3		35	1
2707	2017-09-03 22:39:09.101434+03	1806	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:09:15.011052+00:00	3		35	1
2708	2017-09-03 22:39:09.104389+03	1805	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:09:13.929208+00:00	3		35	1
2709	2017-09-03 22:39:09.107666+03	1804	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:08:42.958187+00:00	3		35	1
2710	2017-09-03 22:39:09.110957+03	1803	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:08:41.873855+00:00	3		35	1
2711	2017-09-03 22:39:09.113916+03	1802	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:08:41.165349+00:00	3		35	1
2712	2017-09-03 22:39:09.116858+03	1801	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:08:14.869575+00:00	3		35	1
2713	2017-09-03 22:39:09.119828+03	1800	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:08:13.967792+00:00	3		35	1
2714	2017-09-03 22:39:09.123607+03	1799	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:08:13.319141+00:00	3		35	1
2715	2017-09-03 22:39:09.127519+03	1798	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:07:42.106221+00:00	3		35	1
2716	2017-09-03 22:39:09.130673+03	1797	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:07:41.564264+00:00	3		35	1
2717	2017-09-03 22:39:09.134167+03	1796	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:07:40.983029+00:00	3		35	1
2718	2017-09-03 22:39:09.145032+03	1795	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:07:14.616813+00:00	3		35	1
2719	2017-09-03 22:39:09.148591+03	1794	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:07:13.820957+00:00	3		35	1
2720	2017-09-03 22:39:09.151731+03	1793	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:07:12.694867+00:00	3		35	1
2721	2017-09-03 22:39:09.154951+03	1792	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:07:01.154604+00:00	3		35	1
2722	2017-09-03 22:39:09.158131+03	1791	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:06:59.950911+00:00	3		35	1
2723	2017-09-03 22:39:09.161013+03	1790	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:06:59.035868+00:00	3		35	1
2724	2017-09-03 22:39:09.164214+03	1789	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:06:33.207825+00:00	3		35	1
2725	2017-09-03 22:39:09.167638+03	1788	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:06:31.735537+00:00	3		35	1
2726	2017-09-03 22:39:09.171427+03	1787	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:06:30.661344+00:00	3		35	1
2727	2017-09-03 22:39:09.175553+03	1786	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:05:59.824431+00:00	3		35	1
2728	2017-09-03 22:39:09.179214+03	1785	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:05:58.880572+00:00	3		35	1
2729	2017-09-03 22:39:09.183197+03	1784	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:05:57.862804+00:00	3		35	1
2730	2017-09-03 22:39:09.186963+03	1783	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:05:56.943794+00:00	3		35	1
2731	2017-09-03 22:39:09.190747+03	1782	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:05:55.822064+00:00	3		35	1
2732	2017-09-03 22:39:09.194659+03	1781	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:05:54.966885+00:00	3		35	1
2733	2017-09-03 22:39:09.198112+03	1780	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:05:54.248229+00:00	3		35	1
2734	2017-09-03 22:39:09.201068+03	1779	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:05:52.719118+00:00	3		35	1
2735	2017-09-03 22:39:09.204284+03	1778	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:05:52.091419+00:00	3		35	1
2736	2017-09-03 22:39:09.207423+03	1777	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:05:50.881607+00:00	3		35	1
2737	2017-09-03 22:39:09.211033+03	1776	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:05:50.024177+00:00	3		35	1
2738	2017-09-03 22:39:09.21421+03	1775	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:05:49.199906+00:00	3		35	1
2739	2017-09-03 22:39:09.217306+03	1774	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 14:05:47.754845+00:00	3		35	1
2740	2017-09-03 22:39:09.220453+03	1773	gisModule.tasks.blame_module_check_proposal - 2017-07-26 14:05:46.966136+00:00	3		35	1
2741	2017-09-03 22:39:09.223699+03	1772	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 14:05:46.226442+00:00	3		35	1
2742	2017-09-03 22:39:09.227685+03	1771	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:03:23.159770+00:00	3		35	1
2743	2017-09-03 22:39:09.231274+03	1770	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:03:22.605860+00:00	3		35	1
2744	2017-09-03 22:39:09.2348+03	1769	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:03:21.108696+00:00	3		35	1
2745	2017-09-03 22:39:09.245451+03	1768	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:02:54.696209+00:00	3		35	1
2746	2017-09-03 22:39:09.248716+03	1767	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:02:54.103926+00:00	3		35	1
2747	2017-09-03 22:39:09.251791+03	1766	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:02:53.415025+00:00	3		35	1
2748	2017-09-03 22:39:09.254902+03	1765	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:02:27.412185+00:00	3		35	1
2749	2017-09-03 22:39:09.25882+03	1764	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:02:25.924444+00:00	3		35	1
2750	2017-09-03 22:39:09.269414+03	1763	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:02:25.174191+00:00	3		35	1
2751	2017-09-03 22:39:09.273819+03	1762	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:02:19.326292+00:00	3		35	1
2752	2017-09-03 22:39:09.278369+03	1761	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:02:18.169819+00:00	3		35	1
2753	2017-09-03 22:39:09.282094+03	1760	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:02:16.727466+00:00	3		35	1
2754	2017-09-03 22:39:09.28523+03	1759	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:02:16.167159+00:00	3		35	1
2755	2017-09-03 22:39:09.288771+03	1758	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:02:15.356091+00:00	3		35	1
2756	2017-09-03 22:39:09.291993+03	1757	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:02:14.506797+00:00	3		35	1
2757	2017-09-03 22:39:09.295172+03	1756	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:02:13.460487+00:00	3		35	1
2758	2017-09-03 22:39:09.298627+03	1755	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:02:11.941333+00:00	3		35	1
2759	2017-09-03 22:39:09.302283+03	1754	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:02:11.344803+00:00	3		35	1
2760	2017-09-03 22:39:09.306262+03	1753	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 12:02:10.213641+00:00	3		35	1
2761	2017-09-03 22:39:09.309814+03	1752	gisModule.tasks.blame_module_check_proposal - 2017-07-26 12:02:09.199729+00:00	3		35	1
2762	2017-09-03 22:39:09.313151+03	1751	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 12:02:08.331668+00:00	3		35	1
2763	2017-09-03 22:39:09.316774+03	1750	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:59:05.446990+00:00	3		35	1
2764	2017-09-03 22:39:09.320355+03	1749	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:59:04.022564+00:00	3		35	1
2765	2017-09-03 22:39:09.324121+03	1748	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:59:03.354449+00:00	3		35	1
2766	2017-09-03 22:39:09.327327+03	1747	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:58:32.509736+00:00	3		35	1
2767	2017-09-03 22:39:09.330498+03	1746	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:58:31.834383+00:00	3		35	1
2768	2017-09-03 22:39:09.333425+03	1745	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:58:30.998812+00:00	3		35	1
2769	2017-09-03 22:39:09.336275+03	1744	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:58:04.426381+00:00	3		35	1
2770	2017-09-03 22:39:09.339769+03	1743	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:58:02.993060+00:00	3		35	1
2771	2017-09-03 22:39:09.343214+03	1742	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:58:02.386172+00:00	3		35	1
2772	2017-09-03 22:39:09.346341+03	1741	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:57:36.552974+00:00	3		35	1
2773	2017-09-03 22:39:09.349921+03	1740	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:57:35.989847+00:00	3		35	1
2774	2017-09-03 22:39:09.353004+03	1739	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:57:34.117960+00:00	3		35	1
2775	2017-09-03 22:39:09.356632+03	1738	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:57:02.613614+00:00	3		35	1
2776	2017-09-03 22:39:09.360338+03	1737	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:57:01.222927+00:00	3		35	1
2777	2017-09-03 22:39:09.363425+03	1736	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:57:00.160539+00:00	3		35	1
2778	2017-09-03 22:39:09.366646+03	1735	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:56:34.065375+00:00	3		35	1
2779	2017-09-03 22:39:09.370109+03	1734	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:56:32.886008+00:00	3		35	1
2780	2017-09-03 22:39:09.373683+03	1733	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:56:32.090060+00:00	3		35	1
2781	2017-09-03 22:39:09.377685+03	1732	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:56:05.727423+00:00	3		35	1
2782	2017-09-03 22:39:09.381641+03	1731	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:56:04.710207+00:00	3		35	1
2783	2017-09-03 22:39:09.385174+03	1730	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:56:03.198940+00:00	3		35	1
2784	2017-09-03 22:39:09.388758+03	1729	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:55:31.922982+00:00	3		35	1
2785	2017-09-03 22:39:09.393287+03	1728	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:55:30.542305+00:00	3		35	1
2786	2017-09-03 22:39:09.397249+03	1727	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:55:29.824885+00:00	3		35	1
2787	2017-09-03 22:39:09.400747+03	1726	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:55:03.723308+00:00	3		35	1
2788	2017-09-03 22:39:09.404082+03	1725	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:55:03.117843+00:00	3		35	1
2789	2017-09-03 22:39:09.407155+03	1724	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:55:02.132422+00:00	3		35	1
2790	2017-09-03 22:39:09.410885+03	1723	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:54:35.761541+00:00	3		35	1
2791	2017-09-03 22:39:09.414116+03	1722	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:54:34.534513+00:00	3		35	1
2792	2017-09-03 22:39:09.417057+03	1721	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:54:32.528213+00:00	3		35	1
2793	2017-09-03 22:39:09.420635+03	1720	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:54:01.824811+00:00	3		35	1
2794	2017-09-03 22:39:09.423676+03	1719	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:54:01.083356+00:00	3		35	1
2795	2017-09-03 22:39:09.427255+03	1718	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:54:00.422823+00:00	3		35	1
2796	2017-09-03 22:39:09.430388+03	1717	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:53:34.724898+00:00	3		35	1
2797	2017-09-03 22:39:09.433506+03	1716	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:53:33.241678+00:00	3		35	1
2798	2017-09-03 22:39:09.436655+03	1715	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:53:32.611710+00:00	3		35	1
2799	2017-09-03 22:39:09.440431+03	1714	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:52:57.439938+00:00	3		35	1
2800	2017-09-03 22:39:09.443646+03	1713	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:52:56.738689+00:00	3		35	1
2801	2017-09-03 22:39:09.454508+03	1712	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:52:25.319543+00:00	3		35	1
2802	2017-09-03 22:39:09.458171+03	1711	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:52:24.310359+00:00	3		35	1
2803	2017-09-03 22:39:09.461213+03	1710	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:51:57.705829+00:00	3		35	1
2804	2017-09-03 22:39:09.464186+03	1709	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:51:56.394980+00:00	3		35	1
2805	2017-09-03 22:39:09.474308+03	1708	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:51:28.833568+00:00	3		35	1
2806	2017-09-03 22:39:09.47745+03	1707	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:51:28.235183+00:00	3		35	1
2807	2017-09-03 22:39:09.480599+03	1706	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:50:57.208395+00:00	3		35	1
2808	2017-09-03 22:39:09.483483+03	1705	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:50:56.254906+00:00	3		35	1
2809	2017-09-03 22:39:09.486553+03	1704	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:50:25.092793+00:00	3		35	1
2810	2017-09-03 22:39:09.490036+03	1703	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:50:23.968376+00:00	3		35	1
2811	2017-09-03 22:39:09.493516+03	1702	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:49:56.618220+00:00	3		35	1
2812	2017-09-03 22:39:09.496648+03	1701	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:49:55.696550+00:00	3		35	1
2813	2017-09-03 22:39:09.499694+03	1700	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:49:27.554538+00:00	3		35	1
2814	2017-09-03 22:39:09.502754+03	1699	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:49:26.871687+00:00	3		35	1
2815	2017-09-03 22:39:09.506191+03	1698	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:49:07.978737+00:00	3		35	1
2816	2017-09-03 22:39:09.509308+03	1697	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:49:07.172458+00:00	3		35	1
2817	2017-09-03 22:39:09.512134+03	1696	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:48:36.395962+00:00	3		35	1
2818	2017-09-03 22:39:09.515029+03	1695	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:48:35.063097+00:00	3		35	1
2819	2017-09-03 22:39:09.517995+03	1694	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:48:09.286963+00:00	3		35	1
2820	2017-09-03 22:39:09.521091+03	1693	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:48:08.003784+00:00	3		35	1
2821	2017-09-03 22:39:09.52439+03	1692	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:47:40.337484+00:00	3		35	1
2822	2017-09-03 22:39:09.527439+03	1691	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:47:39.122151+00:00	3		35	1
2823	2017-09-03 22:39:09.530544+03	1690	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:47:06.426240+00:00	3		35	1
2824	2017-09-03 22:39:09.534165+03	1689	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:47:05.401683+00:00	3		35	1
2825	2017-09-03 22:39:09.537476+03	1688	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:46:52.382526+00:00	3		35	1
2826	2017-09-03 22:39:09.540489+03	1687	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:46:51.672710+00:00	3		35	1
2827	2017-09-03 22:39:09.543897+03	1686	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:46:35.720516+00:00	3		35	1
2828	2017-09-03 22:39:09.54699+03	1685	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:46:34.789094+00:00	3		35	1
2829	2017-09-03 22:39:09.550024+03	1684	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:46:03.601494+00:00	3		35	1
2830	2017-09-03 22:39:09.552884+03	1683	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:46:02.660020+00:00	3		35	1
2831	2017-09-03 22:39:09.555843+03	1682	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:45:36.704638+00:00	3		35	1
2832	2017-09-03 22:39:09.558722+03	1681	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:45:35.458353+00:00	3		35	1
2833	2017-09-03 22:39:09.561894+03	1680	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:45:04.311924+00:00	3		35	1
2834	2017-09-03 22:39:09.565088+03	1679	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:45:03.495570+00:00	3		35	1
2835	2017-09-03 22:39:09.568366+03	1678	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:44:32.566859+00:00	3		35	1
2836	2017-09-03 22:39:09.571519+03	1677	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:44:31.861484+00:00	3		35	1
2837	2017-09-03 22:39:09.574827+03	1676	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:44:06.062227+00:00	3		35	1
2838	2017-09-03 22:39:09.578261+03	1675	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:44:04.759921+00:00	3		35	1
2839	2017-09-03 22:39:09.581044+03	1674	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:43:33.405876+00:00	3		35	1
2840	2017-09-03 22:39:09.584007+03	1673	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:43:31.973040+00:00	3		35	1
2841	2017-09-03 22:39:09.586934+03	1672	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:43:06.237705+00:00	3		35	1
2842	2017-09-03 22:39:09.590082+03	1671	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:43:05.279074+00:00	3		35	1
2843	2017-09-03 22:39:09.593075+03	1670	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:42:33.472086+00:00	3		35	1
2844	2017-09-03 22:39:09.595993+03	1669	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:42:32.617758+00:00	3		35	1
2845	2017-09-03 22:39:09.598964+03	1668	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:42:06.790988+00:00	3		35	1
2846	2017-09-03 22:39:09.601822+03	1667	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:42:05.549560+00:00	3		35	1
2847	2017-09-03 22:39:09.604673+03	1666	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:41:34.039383+00:00	3		35	1
2848	2017-09-03 22:39:09.608083+03	1665	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:41:33.481022+00:00	3		35	1
2849	2017-09-03 22:39:09.611278+03	1664	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:41:06.303369+00:00	3		35	1
2850	2017-09-03 22:39:09.614331+03	1663	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:41:05.432883+00:00	3		35	1
2851	2017-09-03 22:39:09.617399+03	1662	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:40:36.776762+00:00	3		35	1
2852	2017-09-03 22:39:09.620734+03	1661	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:40:36.063752+00:00	3		35	1
2853	2017-09-03 22:39:09.624064+03	1660	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:40:15.166429+00:00	3		35	1
2854	2017-09-03 22:39:09.627639+03	1659	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:40:14.200392+00:00	3		35	1
2855	2017-09-03 22:39:09.63075+03	1658	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:39:42.699495+00:00	3		35	1
2856	2017-09-03 22:39:09.633791+03	1657	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:39:41.521080+00:00	3		35	1
2857	2017-09-03 22:39:09.637282+03	1656	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:39:15.466251+00:00	3		35	1
2858	2017-09-03 22:39:09.640322+03	1655	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:39:14.823760+00:00	3		35	1
2859	2017-09-03 22:39:09.643987+03	1654	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:38:43.854373+00:00	3		35	1
2860	2017-09-03 22:39:09.647269+03	1653	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:38:42.692664+00:00	3		35	1
3367	2017-09-03 22:39:53.968112+03	50	test	3		13	1
2861	2017-09-03 22:39:09.650476+03	1652	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:38:16.237553+00:00	3		35	1
2862	2017-09-03 22:39:09.654053+03	1651	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:38:15.024882+00:00	3		35	1
2863	2017-09-03 22:39:09.657493+03	1650	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:37:43.749530+00:00	3		35	1
2864	2017-09-03 22:39:09.660631+03	1649	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:37:42.539142+00:00	3		35	1
2865	2017-09-03 22:39:09.663498+03	1648	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:37:16.032360+00:00	3		35	1
2866	2017-09-03 22:39:09.66643+03	1647	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:37:15.029492+00:00	3		35	1
2867	2017-09-03 22:39:09.669653+03	1646	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:36:43.582859+00:00	3		35	1
2868	2017-09-03 22:39:09.673544+03	1645	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:36:42.734698+00:00	3		35	1
2869	2017-09-03 22:39:09.677476+03	1644	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:36:16.326078+00:00	3		35	1
2870	2017-09-03 22:39:09.68108+03	1643	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:36:15.571434+00:00	3		35	1
2871	2017-09-03 22:39:09.684341+03	1642	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:35:43.140572+00:00	3		35	1
2872	2017-09-03 22:39:09.687537+03	1641	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:35:42.041289+00:00	3		35	1
2873	2017-09-03 22:39:09.691202+03	1640	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:35:15.655724+00:00	3		35	1
2874	2017-09-03 22:39:09.694454+03	1639	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:35:14.881187+00:00	3		35	1
2875	2017-09-03 22:39:09.697583+03	1638	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:34:43.483008+00:00	3		35	1
2876	2017-09-03 22:39:09.700708+03	1637	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:34:42.369096+00:00	3		35	1
2877	2017-09-03 22:39:09.703993+03	1636	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:34:14.395554+00:00	3		35	1
2878	2017-09-03 22:39:09.707331+03	1635	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:34:13.475902+00:00	3		35	1
2879	2017-09-03 22:39:09.710706+03	1634	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:33:45.478957+00:00	3		35	1
2880	2017-09-03 22:39:09.713794+03	1633	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:33:44.673483+00:00	3		35	1
2881	2017-09-03 22:39:09.717434+03	1632	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:33:13.507283+00:00	3		35	1
2882	2017-09-03 22:39:09.720804+03	1631	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:33:12.957099+00:00	3		35	1
2883	2017-09-03 22:39:09.72417+03	1630	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:33:11.479753+00:00	3		35	1
2884	2017-09-03 22:39:09.727111+03	1629	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:32:45.700983+00:00	3		35	1
2885	2017-09-03 22:39:09.730125+03	1628	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:32:44.570084+00:00	3		35	1
2886	2017-09-03 22:39:09.733192+03	1627	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:32:43.411485+00:00	3		35	1
2887	2017-09-03 22:39:09.736261+03	1626	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:32:17.308904+00:00	3		35	1
2888	2017-09-03 22:39:09.739297+03	1625	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:32:16.616341+00:00	3		35	1
2889	2017-09-03 22:39:09.742114+03	1624	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:32:15.402374+00:00	3		35	1
2890	2017-09-03 22:39:09.744889+03	1623	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:31:44.405012+00:00	3		35	1
2891	2017-09-03 22:39:09.747813+03	1622	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:31:42.904347+00:00	3		35	1
2892	2017-09-03 22:39:09.750906+03	1621	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:31:42.233693+00:00	3		35	1
2893	2017-09-03 22:39:09.753958+03	1620	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:31:16.541057+00:00	3		35	1
2894	2017-09-03 22:39:09.757576+03	1619	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:31:15.767354+00:00	3		35	1
2895	2017-09-03 22:39:09.760773+03	1618	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:31:14.435081+00:00	3		35	1
2896	2017-09-03 22:39:09.763797+03	1617	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:30:48.641485+00:00	3		35	1
2897	2017-09-03 22:39:09.766831+03	1616	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:30:47.420351+00:00	3		35	1
2898	2017-09-03 22:39:09.7703+03	1615	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:30:46.049895+00:00	3		35	1
2899	2017-09-03 22:39:09.773728+03	1614	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:30:14.520534+00:00	3		35	1
2900	2017-09-03 22:39:09.784745+03	1613	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:30:13.400021+00:00	3		35	1
2901	2017-09-03 22:39:09.789147+03	1612	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:30:12.341998+00:00	3		35	1
2902	2017-09-03 22:39:09.793636+03	1611	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:29:46.246984+00:00	3		35	1
2903	2017-09-03 22:39:09.797727+03	1610	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:29:45.531765+00:00	3		35	1
2904	2017-09-03 22:39:09.801324+03	1609	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:29:44.295826+00:00	3		35	1
2905	2017-09-03 22:39:09.804585+03	1608	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:29:17.845019+00:00	3		35	1
2906	2017-09-03 22:39:09.808315+03	1607	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:29:17.034057+00:00	3		35	1
2907	2017-09-03 22:39:09.811325+03	1606	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:29:16.105883+00:00	3		35	1
2908	2017-09-03 22:39:09.814277+03	1605	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:28:45.417379+00:00	3		35	1
2909	2017-09-03 22:39:09.817315+03	1604	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:28:44.384252+00:00	3		35	1
2910	2017-09-03 22:39:09.820801+03	1603	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:28:43.560603+00:00	3		35	1
2911	2017-09-03 22:39:09.824218+03	1602	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:28:16.941683+00:00	3		35	1
2912	2017-09-03 22:39:09.827645+03	1601	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:28:15.825773+00:00	3		35	1
2913	2017-09-03 22:39:09.83088+03	1600	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:28:14.845853+00:00	3		35	1
2914	2017-09-03 22:39:09.833975+03	1599	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:27:43.389713+00:00	3		35	1
2915	2017-09-03 22:39:09.837056+03	1598	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:27:42.198660+00:00	3		35	1
2916	2017-09-03 22:39:09.840726+03	1597	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:27:41.639092+00:00	3		35	1
2917	2017-09-03 22:39:09.844103+03	1596	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:27:15.526577+00:00	3		35	1
2918	2017-09-03 22:39:09.847161+03	1595	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:27:14.062292+00:00	3		35	1
2919	2017-09-03 22:39:09.850171+03	1594	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:27:13.471611+00:00	3		35	1
2920	2017-09-03 22:39:09.853661+03	1593	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:26:47.486785+00:00	3		35	1
2921	2017-09-03 22:39:09.856989+03	1592	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:26:46.099192+00:00	3		35	1
2922	2017-09-03 22:39:09.860567+03	1591	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:26:44.925399+00:00	3		35	1
2923	2017-09-03 22:39:09.864055+03	1590	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:26:18.705519+00:00	3		35	1
2924	2017-09-03 22:39:09.86713+03	1589	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:26:17.382071+00:00	3		35	1
2925	2017-09-03 22:39:09.871086+03	1588	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:26:16.267621+00:00	3		35	1
2926	2017-09-03 22:39:09.874377+03	1587	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:25:45.027962+00:00	3		35	1
2927	2017-09-03 22:39:09.877776+03	1586	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:25:44.299796+00:00	3		35	1
2928	2017-09-03 22:39:09.880689+03	1585	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:25:43.248918+00:00	3		35	1
2929	2017-09-03 22:39:09.883663+03	1584	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:25:16.930293+00:00	3		35	1
2930	2017-09-03 22:39:09.886654+03	1583	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:25:15.585316+00:00	3		35	1
2931	2017-09-03 22:39:09.889734+03	1582	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:25:14.244171+00:00	3		35	1
2932	2017-09-03 22:39:09.893021+03	1581	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:24:48.463556+00:00	3		35	1
2933	2017-09-03 22:39:09.896022+03	1580	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:24:47.426724+00:00	3		35	1
2934	2017-09-03 22:39:09.899227+03	1579	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:24:46.199580+00:00	3		35	1
2935	2017-09-03 22:39:09.9031+03	1578	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:24:15.317847+00:00	3		35	1
2936	2017-09-03 22:39:09.907049+03	1577	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:24:13.901703+00:00	3		35	1
2937	2017-09-03 22:39:09.911095+03	1576	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:24:13.091217+00:00	3		35	1
2938	2017-09-03 22:39:09.914635+03	1575	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:23:47.165060+00:00	3		35	1
2939	2017-09-03 22:39:09.918114+03	1574	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:23:46.524025+00:00	3		35	1
2940	2017-09-03 22:39:09.92147+03	1573	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:23:45.002700+00:00	3		35	1
2941	2017-09-03 22:39:09.92513+03	1572	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:23:13.636081+00:00	3		35	1
2942	2017-09-03 22:39:09.928916+03	1571	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:23:12.735212+00:00	3		35	1
2943	2017-09-03 22:39:09.933281+03	1570	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:23:12.132022+00:00	3		35	1
2944	2017-09-03 22:39:09.937266+03	1569	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:22:46.242871+00:00	3		35	1
2945	2017-09-03 22:39:09.940837+03	1568	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:22:45.633045+00:00	3		35	1
2946	2017-09-03 22:39:09.944819+03	1567	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:22:44.936624+00:00	3		35	1
2947	2017-09-03 22:39:09.9481+03	1566	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:22:14.021454+00:00	3		35	1
2948	2017-09-03 22:39:09.959701+03	1565	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:22:12.604137+00:00	3		35	1
2949	2017-09-03 22:39:09.962716+03	1564	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:22:11.630481+00:00	3		35	1
2950	2017-09-03 22:39:09.965684+03	1563	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:21:45.437667+00:00	3		35	1
2951	2017-09-03 22:39:09.968592+03	1562	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:21:44.409913+00:00	3		35	1
2952	2017-09-03 22:39:09.971723+03	1561	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:21:43.797722+00:00	3		35	1
2953	2017-09-03 22:39:09.975183+03	1560	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:21:17.326791+00:00	3		35	1
2954	2017-09-03 22:39:09.978102+03	1559	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:21:16.726300+00:00	3		35	1
2955	2017-09-03 22:39:09.981083+03	1558	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:21:16.187575+00:00	3		35	1
2956	2017-09-03 22:39:09.984125+03	1557	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:20:45.424750+00:00	3		35	1
2957	2017-09-03 22:39:09.987448+03	1556	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:20:44.404779+00:00	3		35	1
2958	2017-09-03 22:39:09.991049+03	1555	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:20:43.018666+00:00	3		35	1
2959	2017-09-03 22:39:09.995037+03	1554	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:20:16.587869+00:00	3		35	1
2960	2017-09-03 22:39:09.997987+03	1553	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:20:15.395870+00:00	3		35	1
2961	2017-09-03 22:39:10.000859+03	1552	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:20:14.350451+00:00	3		35	1
2962	2017-09-03 22:39:10.011074+03	1551	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:19:48.014664+00:00	3		35	1
2963	2017-09-03 22:39:10.014316+03	1550	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:19:46.990948+00:00	3		35	1
2964	2017-09-03 22:39:10.017542+03	1549	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:19:46.175944+00:00	3		35	1
2965	2017-09-03 22:39:10.020745+03	1548	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:19:14.858453+00:00	3		35	1
2966	2017-09-03 22:39:10.024074+03	1547	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:19:13.644348+00:00	3		35	1
2967	2017-09-03 22:39:10.027182+03	1546	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:19:12.198999+00:00	3		35	1
2968	2017-09-03 22:39:10.030203+03	1545	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:18:45.627631+00:00	3		35	1
2969	2017-09-03 22:39:10.033251+03	1544	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:18:44.437076+00:00	3		35	1
2970	2017-09-03 22:39:10.036334+03	1543	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:18:43.695477+00:00	3		35	1
2971	2017-09-03 22:39:10.040124+03	1542	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:18:17.594884+00:00	3		35	1
2972	2017-09-03 22:39:10.043662+03	1541	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:18:16.083405+00:00	3		35	1
2973	2017-09-03 22:39:10.047012+03	1540	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:18:15.195089+00:00	3		35	1
2974	2017-09-03 22:39:10.058935+03	1539	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:17:44.425725+00:00	3		35	1
2975	2017-09-03 22:39:10.06236+03	1538	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:17:42.902507+00:00	3		35	1
2976	2017-09-03 22:39:10.065501+03	1537	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:17:41.729375+00:00	3		35	1
2977	2017-09-03 22:39:10.076812+03	1536	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:17:15.133565+00:00	3		35	1
2978	2017-09-03 22:39:10.080724+03	1535	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:17:14.255058+00:00	3		35	1
2979	2017-09-03 22:39:10.084986+03	1534	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:17:13.699515+00:00	3		35	1
2980	2017-09-03 22:39:10.088105+03	1533	gisModule.tasks.statistic_module_basic_statistics - 2017-07-26 08:17:02.656971+00:00	3		35	1
2981	2017-09-03 22:39:10.091472+03	1532	gisModule.tasks.blame_module_check_proposal - 2017-07-26 08:17:01.877921+00:00	3		35	1
2982	2017-09-03 22:39:10.094809+03	1531	gisModule.tasks.blame_module_check_blame_status - 2017-07-26 08:17:01.323707+00:00	3		35	1
2983	2017-09-03 22:39:10.097829+03	1530	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:37:46.397437+00:00	3		35	1
2984	2017-09-03 22:39:10.100985+03	1529	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:37:45.547353+00:00	3		35	1
2985	2017-09-03 22:39:10.104138+03	1528	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:37:44.401426+00:00	3		35	1
2986	2017-09-03 22:39:10.10756+03	1527	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:37:13.530422+00:00	3		35	1
2987	2017-09-03 22:39:10.111088+03	1526	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:37:12.821963+00:00	3		35	1
2988	2017-09-03 22:39:10.114464+03	1525	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:37:12.067443+00:00	3		35	1
2989	2017-09-03 22:39:10.117705+03	1524	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:36:46.097252+00:00	3		35	1
2990	2017-09-03 22:39:10.121011+03	1523	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:36:45.427191+00:00	3		35	1
2991	2017-09-03 22:39:10.124878+03	1522	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:36:44.476220+00:00	3		35	1
2992	2017-09-03 22:39:10.128085+03	1521	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:36:17.959894+00:00	3		35	1
2993	2017-09-03 22:39:10.131064+03	1520	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:36:16.739880+00:00	3		35	1
2994	2017-09-03 22:39:10.134015+03	1519	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:36:15.715282+00:00	3		35	1
2995	2017-09-03 22:39:10.14555+03	1518	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:35:44.990701+00:00	3		35	1
2996	2017-09-03 22:39:10.148784+03	1517	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:35:44.028270+00:00	3		35	1
2997	2017-09-03 22:39:10.15174+03	1516	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:35:41.946756+00:00	3		35	1
2998	2017-09-03 22:39:10.154891+03	1515	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:35:15.982420+00:00	3		35	1
2999	2017-09-03 22:39:10.158394+03	1514	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:35:15.185886+00:00	3		35	1
3000	2017-09-03 22:39:10.161618+03	1513	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:35:14.315521+00:00	3		35	1
3001	2017-09-03 22:39:10.164832+03	1512	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:34:47.765153+00:00	3		35	1
3002	2017-09-03 22:39:10.168255+03	1511	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:34:46.858711+00:00	3		35	1
3003	2017-09-03 22:39:10.172062+03	1510	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:34:45.818512+00:00	3		35	1
3004	2017-09-03 22:39:10.175797+03	1509	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:34:19.285264+00:00	3		35	1
3005	2017-09-03 22:39:10.179141+03	1508	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:34:17.972421+00:00	3		35	1
3006	2017-09-03 22:39:10.182486+03	1507	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:34:16.576392+00:00	3		35	1
3007	2017-09-03 22:39:10.192084+03	1506	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:33:45.872964+00:00	3		35	1
3008	2017-09-03 22:39:10.195553+03	1505	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:33:44.650001+00:00	3		35	1
3009	2017-09-03 22:39:10.199107+03	1504	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:33:44.030733+00:00	3		35	1
3010	2017-09-03 22:39:10.202535+03	1503	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:33:17.452509+00:00	3		35	1
3011	2017-09-03 22:39:10.206439+03	1502	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:33:16.497959+00:00	3		35	1
3012	2017-09-03 22:39:10.209479+03	1501	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:33:15.642364+00:00	3		35	1
3013	2017-09-03 22:39:10.221206+03	1500	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:33:01.256474+00:00	3		35	1
3014	2017-09-03 22:39:10.224692+03	1499	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:33:00.538316+00:00	3		35	1
3015	2017-09-03 22:39:10.228234+03	1498	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:32:59.797763+00:00	3		35	1
3016	2017-09-03 22:39:10.231944+03	1497	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:32:59.049897+00:00	3		35	1
3017	2017-09-03 22:39:10.243594+03	1496	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:32:58.378333+00:00	3		35	1
3018	2017-09-03 22:39:10.247412+03	1495	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:32:57.537614+00:00	3		35	1
3019	2017-09-03 22:39:10.250821+03	1494	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:31:28.566504+00:00	3		35	1
3020	2017-09-03 22:39:10.254034+03	1493	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:31:27.856199+00:00	3		35	1
3021	2017-09-03 22:39:10.25711+03	1492	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:31:26.482445+00:00	3		35	1
3022	2017-09-03 22:39:10.260107+03	1491	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:30:59.853478+00:00	3		35	1
3023	2017-09-03 22:39:10.263102+03	1490	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:30:58.672869+00:00	3		35	1
3024	2017-09-03 22:39:10.266146+03	1489	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:30:57.373673+00:00	3		35	1
3025	2017-09-03 22:39:10.269117+03	1488	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:30:26.302012+00:00	3		35	1
3026	2017-09-03 22:39:10.280275+03	1487	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:30:25.410835+00:00	3		35	1
3027	2017-09-03 22:39:10.292338+03	1486	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:30:24.492310+00:00	3		35	1
3028	2017-09-03 22:39:10.296599+03	1485	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:29:58.371574+00:00	3		35	1
3029	2017-09-03 22:39:10.300924+03	1484	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:29:57.380944+00:00	3		35	1
3030	2017-09-03 22:39:10.305+03	1483	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:29:56.765268+00:00	3		35	1
3031	2017-09-03 22:39:10.318326+03	1482	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:29:30.924769+00:00	3		35	1
3032	2017-09-03 22:39:10.323015+03	1481	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:29:29.921204+00:00	3		35	1
3033	2017-09-03 22:39:10.327908+03	1480	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:29:28.936715+00:00	3		35	1
3034	2017-09-03 22:39:10.331548+03	1479	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:28:57.716035+00:00	3		35	1
3035	2017-09-03 22:39:10.335155+03	1478	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:28:57.032386+00:00	3		35	1
3036	2017-09-03 22:39:10.339052+03	1477	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:28:55.599447+00:00	3		35	1
3037	2017-09-03 22:39:10.343636+03	1476	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:28:34.088715+00:00	3		35	1
3038	2017-09-03 22:39:10.347793+03	1475	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:28:32.759291+00:00	3		35	1
3039	2017-09-03 22:39:10.351135+03	1474	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:28:25.821527+00:00	3		35	1
3040	2017-09-03 22:39:10.354489+03	1473	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:27:59.163440+00:00	3		35	1
3041	2017-09-03 22:39:10.358097+03	1472	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:27:57.876603+00:00	3		35	1
3042	2017-09-03 22:39:10.362197+03	1471	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:27:56.901021+00:00	3		35	1
3043	2017-09-03 22:39:10.365257+03	1470	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:27:30.900393+00:00	3		35	1
3044	2017-09-03 22:39:10.368247+03	1469	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:27:29.379232+00:00	3		35	1
3045	2017-09-03 22:39:10.371341+03	1468	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:27:28.056532+00:00	3		35	1
3046	2017-09-03 22:39:10.374927+03	1467	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:26:57.245609+00:00	3		35	1
3047	2017-09-03 22:39:10.378615+03	1466	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:26:56.473968+00:00	3		35	1
3048	2017-09-03 22:39:10.381972+03	1465	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:26:55.142263+00:00	3		35	1
3049	2017-09-03 22:39:10.385758+03	1464	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:26:28.808462+00:00	3		35	1
3050	2017-09-03 22:39:10.390084+03	1463	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:26:27.290323+00:00	3		35	1
3051	2017-09-03 22:39:10.394129+03	1462	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:26:26.430865+00:00	3		35	1
3052	2017-09-03 22:39:10.404943+03	1461	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:25:59.944898+00:00	3		35	1
3053	2017-09-03 22:39:10.409402+03	1460	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:25:58.986614+00:00	3		35	1
3054	2017-09-03 22:39:10.413654+03	1459	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:25:57.777056+00:00	3		35	1
3055	2017-09-03 22:39:10.417595+03	1458	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:25:26.945002+00:00	3		35	1
3056	2017-09-03 22:39:10.421671+03	1457	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:25:26.233889+00:00	3		35	1
3057	2017-09-03 22:39:10.433191+03	1456	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:25:25.308418+00:00	3		35	1
3058	2017-09-03 22:39:10.4374+03	1455	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:24:59.481008+00:00	3		35	1
3059	2017-09-03 22:39:10.44222+03	1454	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:24:58.313132+00:00	3		35	1
3060	2017-09-03 22:39:10.446592+03	1453	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:24:57.396178+00:00	3		35	1
3061	2017-09-03 22:39:10.450847+03	1452	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:24:31.351853+00:00	3		35	1
3062	2017-09-03 22:39:10.455009+03	1451	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:24:30.587401+00:00	3		35	1
3063	2017-09-03 22:39:10.45829+03	1450	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:24:29.170060+00:00	3		35	1
3064	2017-09-03 22:39:10.461576+03	1449	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:23:58.186484+00:00	3		35	1
3065	2017-09-03 22:39:10.464549+03	1448	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:23:56.772915+00:00	3		35	1
3066	2017-09-03 22:39:10.46749+03	1447	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:23:56.094791+00:00	3		35	1
3067	2017-09-03 22:39:10.470443+03	1446	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:23:30.186572+00:00	3		35	1
3068	2017-09-03 22:39:10.473468+03	1445	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:23:28.728228+00:00	3		35	1
3069	2017-09-03 22:39:10.476604+03	1444	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:23:26.637926+00:00	3		35	1
3070	2017-09-03 22:39:10.47942+03	1443	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:23:00.760221+00:00	3		35	1
3071	2017-09-03 22:39:10.482939+03	1442	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:22:59.261695+00:00	3		35	1
3072	2017-09-03 22:39:10.486119+03	1441	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:22:58.012036+00:00	3		35	1
3073	2017-09-03 22:39:10.489798+03	1440	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:22:26.346491+00:00	3		35	1
3074	2017-09-03 22:39:10.493377+03	1439	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:22:25.141890+00:00	3		35	1
3075	2017-09-03 22:39:10.496695+03	1438	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:22:24.356290+00:00	3		35	1
3076	2017-09-03 22:39:10.499763+03	1437	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:21:58.018879+00:00	3		35	1
3077	2017-09-03 22:39:10.502964+03	1436	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:21:57.091712+00:00	3		35	1
3078	2017-09-03 22:39:10.50653+03	1435	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:21:56.463255+00:00	3		35	1
3079	2017-09-03 22:39:10.51029+03	1434	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:21:29.859210+00:00	3		35	1
3080	2017-09-03 22:39:10.51521+03	1433	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:21:28.845893+00:00	3		35	1
3081	2017-09-03 22:39:10.518959+03	1432	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:21:27.701558+00:00	3		35	1
3082	2017-09-03 22:39:10.522656+03	1431	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:20:56.195311+00:00	3		35	1
3083	2017-09-03 22:39:10.52584+03	1430	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:20:55.144641+00:00	3		35	1
3084	2017-09-03 22:39:10.528749+03	1429	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:20:54.598871+00:00	3		35	1
3085	2017-09-03 22:39:10.533634+03	1428	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:20:28.303604+00:00	3		35	1
3086	2017-09-03 22:39:10.539162+03	1427	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:20:27.263851+00:00	3		35	1
3087	2017-09-03 22:39:10.542323+03	1426	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:20:26.256200+00:00	3		35	1
3088	2017-09-03 22:39:10.545229+03	1425	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:20:20.590612+00:00	3		35	1
3089	2017-09-03 22:39:10.548083+03	1424	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:20:19.337881+00:00	3		35	1
3090	2017-09-03 22:39:10.550997+03	1423	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:20:17.950072+00:00	3		35	1
3091	2017-09-03 22:39:10.554066+03	1422	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:19:34.635684+00:00	3		35	1
3092	2017-09-03 22:39:10.557724+03	1421	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:19:33.240786+00:00	3		35	1
3093	2017-09-03 22:39:10.56089+03	1420	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:19:32.369876+00:00	3		35	1
3094	2017-09-03 22:39:10.563892+03	1419	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:15:09.666530+00:00	3		35	1
3095	2017-09-03 22:39:10.56699+03	1418	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:15:08.795744+00:00	3		35	1
3096	2017-09-03 22:39:10.570461+03	1417	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:14:37.475402+00:00	3		35	1
3097	2017-09-03 22:39:10.573897+03	1416	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:14:36.434460+00:00	3		35	1
3098	2017-09-03 22:39:10.577385+03	1415	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:14:09.725458+00:00	3		35	1
3099	2017-09-03 22:39:10.580779+03	1414	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:14:08.848936+00:00	3		35	1
3100	2017-09-03 22:39:10.583921+03	1413	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:13:37.967451+00:00	3		35	1
3101	2017-09-03 22:39:10.587136+03	1412	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:13:36.697143+00:00	3		35	1
3102	2017-09-03 22:39:10.590363+03	1411	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:13:06.032327+00:00	3		35	1
3103	2017-09-03 22:39:10.593773+03	1410	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:13:05.015766+00:00	3		35	1
3104	2017-09-03 22:39:10.597122+03	1409	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:12:38.004589+00:00	3		35	1
3105	2017-09-03 22:39:10.600283+03	1408	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:12:37.090696+00:00	3		35	1
3106	2017-09-03 22:39:10.603706+03	1407	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:12:09.068219+00:00	3		35	1
3107	2017-09-03 22:39:10.607122+03	1406	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:12:07.059341+00:00	3		35	1
3108	2017-09-03 22:39:10.610544+03	1405	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:11:41.397123+00:00	3		35	1
3109	2017-09-03 22:39:10.613967+03	1404	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:11:39.868478+00:00	3		35	1
3110	2017-09-03 22:39:10.617251+03	1403	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:11:39.199811+00:00	3		35	1
3111	2017-09-03 22:39:10.620588+03	1402	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:11:07.879137+00:00	3		35	1
3112	2017-09-03 22:39:10.624264+03	1401	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:11:06.475431+00:00	3		35	1
3113	2017-09-03 22:39:10.628413+03	1400	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:11:04.946454+00:00	3		35	1
3114	2017-09-03 22:39:10.632109+03	1399	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:10:38.375291+00:00	3		35	1
3115	2017-09-03 22:39:10.635743+03	1398	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:10:36.847819+00:00	3		35	1
3116	2017-09-03 22:39:10.639697+03	1397	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:10:35.636664+00:00	3		35	1
3117	2017-09-03 22:39:10.644145+03	1396	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:10:09.101271+00:00	3		35	1
3118	2017-09-03 22:39:10.647683+03	1395	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:10:07.726924+00:00	3		35	1
3119	2017-09-03 22:39:10.650875+03	1394	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:10:06.715450+00:00	3		35	1
3120	2017-09-03 22:39:10.65421+03	1393	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:09:35.870517+00:00	3		35	1
3121	2017-09-03 22:39:10.657332+03	1392	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:09:35.244724+00:00	3		35	1
3122	2017-09-03 22:39:10.660701+03	1391	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:09:34.692502+00:00	3		35	1
3123	2017-09-03 22:39:10.663792+03	1390	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:09:08.188729+00:00	3		35	1
3124	2017-09-03 22:39:10.66726+03	1389	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:09:07.214912+00:00	3		35	1
3125	2017-09-03 22:39:10.670427+03	1388	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:09:05.911172+00:00	3		35	1
3126	2017-09-03 22:39:10.673382+03	1387	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:08:40.076430+00:00	3		35	1
3127	2017-09-03 22:39:10.677064+03	1386	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:08:39.019024+00:00	3		35	1
3128	2017-09-03 22:39:10.680404+03	1385	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:08:37.825823+00:00	3		35	1
3129	2017-09-03 22:39:10.683866+03	1384	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:08:11.374304+00:00	3		35	1
3130	2017-09-03 22:39:10.686931+03	1383	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:08:10.129501+00:00	3		35	1
3131	2017-09-03 22:39:10.690132+03	1382	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:08:08.762684+00:00	3		35	1
3132	2017-09-03 22:39:10.693096+03	1381	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:07:37.502457+00:00	3		35	1
3133	2017-09-03 22:39:10.696257+03	1380	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:07:36.176039+00:00	3		35	1
3134	2017-09-03 22:39:10.699211+03	1379	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:07:35.434851+00:00	3		35	1
3135	2017-09-03 22:39:10.702179+03	1378	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:07:09.390381+00:00	3		35	1
3136	2017-09-03 22:39:10.70518+03	1377	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:07:08.244541+00:00	3		35	1
3137	2017-09-03 22:39:10.70856+03	1376	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:07:07.710145+00:00	3		35	1
3138	2017-09-03 22:39:10.711613+03	1375	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:06:41.170143+00:00	3		35	1
3139	2017-09-03 22:39:10.714608+03	1374	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:06:40.406480+00:00	3		35	1
3368	2017-09-03 22:40:16.485902+03	551	ShoppingListItem object	3		19	1
3140	2017-09-03 22:39:10.717623+03	1373	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:06:38.994803+00:00	3		35	1
3141	2017-09-03 22:39:10.720885+03	1372	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:06:08.097035+00:00	3		35	1
3142	2017-09-03 22:39:10.724769+03	1371	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:06:07.354120+00:00	3		35	1
3143	2017-09-03 22:39:10.729174+03	1370	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:06:06.168237+00:00	3		35	1
3144	2017-09-03 22:39:10.732352+03	1369	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:05:39.876066+00:00	3		35	1
3145	2017-09-03 22:39:10.735378+03	1368	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:05:38.929105+00:00	3		35	1
3146	2017-09-03 22:39:10.739216+03	1367	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:05:38.132468+00:00	3		35	1
3147	2017-09-03 22:39:10.742999+03	1366	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:05:12.025909+00:00	3		35	1
3148	2017-09-03 22:39:10.747296+03	1365	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:05:10.517779+00:00	3		35	1
3149	2017-09-03 22:39:10.751048+03	1364	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:05:09.277459+00:00	3		35	1
3150	2017-09-03 22:39:10.75512+03	1363	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:04:38.003212+00:00	3		35	1
3151	2017-09-03 22:39:10.759651+03	1362	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:04:36.805320+00:00	3		35	1
3152	2017-09-03 22:39:10.763154+03	1361	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:04:35.859399+00:00	3		35	1
3153	2017-09-03 22:39:10.773919+03	1360	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:04:09.940803+00:00	3		35	1
3154	2017-09-03 22:39:10.77898+03	1359	gisModule.tasks.blame_module_check_proposal - 2017-07-25 20:04:09.394686+00:00	3		35	1
3155	2017-09-03 22:39:10.783301+03	1358	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:04:08.433267+00:00	3		35	1
3156	2017-09-03 22:39:10.787715+03	1357	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 20:00:09.928586+00:00	3		35	1
3157	2017-09-03 22:39:10.791019+03	1356	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 20:00:09.126739+00:00	3		35	1
3158	2017-09-03 22:39:10.793997+03	1355	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:59:38.005954+00:00	3		35	1
3159	2017-09-03 22:39:10.797068+03	1354	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:59:36.621975+00:00	3		35	1
3160	2017-09-03 22:39:10.800115+03	1353	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:59:09.405905+00:00	3		35	1
3161	2017-09-03 22:39:10.811311+03	1352	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:59:08.822671+00:00	3		35	1
3162	2017-09-03 22:39:10.815255+03	1351	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:58:41.876886+00:00	3		35	1
3163	2017-09-03 22:39:10.819483+03	1350	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:58:40.084957+00:00	3		35	1
3164	2017-09-03 22:39:10.824227+03	1349	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:58:09.396998+00:00	3		35	1
3165	2017-09-03 22:39:10.828337+03	1348	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:58:08.585505+00:00	3		35	1
3166	2017-09-03 22:39:10.831722+03	1347	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:58:07.384018+00:00	3		35	1
3167	2017-09-03 22:39:10.83528+03	1346	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:57:41.225476+00:00	3		35	1
3168	2017-09-03 22:39:10.83852+03	1345	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:57:40.546593+00:00	3		35	1
3169	2017-09-03 22:39:10.841656+03	1344	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:57:39.430489+00:00	3		35	1
3170	2017-09-03 22:39:10.844889+03	1343	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:57:08.732099+00:00	3		35	1
3171	2017-09-03 22:39:10.84858+03	1342	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:57:07.622070+00:00	3		35	1
3172	2017-09-03 22:39:10.851972+03	1341	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:57:06.215861+00:00	3		35	1
3173	2017-09-03 22:39:10.855689+03	1340	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:56:40.118270+00:00	3		35	1
3174	2017-09-03 22:39:10.859503+03	1339	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:56:38.879239+00:00	3		35	1
3175	2017-09-03 22:39:10.86275+03	1338	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:56:38.072743+00:00	3		35	1
3176	2017-09-03 22:39:10.866048+03	1337	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:56:11.502692+00:00	3		35	1
3177	2017-09-03 22:39:10.86944+03	1336	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:56:10.612672+00:00	3		35	1
3178	2017-09-03 22:39:10.872964+03	1335	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:56:09.542003+00:00	3		35	1
3179	2017-09-03 22:39:10.876225+03	1334	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:55:38.443731+00:00	3		35	1
3180	2017-09-03 22:39:10.879837+03	1333	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:55:37.479074+00:00	3		35	1
3181	2017-09-03 22:39:10.883367+03	1332	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:55:36.218420+00:00	3		35	1
3182	2017-09-03 22:39:10.887274+03	1331	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:55:09.859126+00:00	3		35	1
3183	2017-09-03 22:39:10.891271+03	1330	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:55:09.112643+00:00	3		35	1
3184	2017-09-03 22:39:10.895139+03	1329	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:55:08.547125+00:00	3		35	1
3185	2017-09-03 22:39:10.899152+03	1328	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:54:42.424396+00:00	3		35	1
3186	2017-09-03 22:39:10.902885+03	1327	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:54:40.937412+00:00	3		35	1
3187	2017-09-03 22:39:10.906748+03	1326	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:54:39.441988+00:00	3		35	1
3188	2017-09-03 22:39:10.911096+03	1325	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:54:07.794774+00:00	3		35	1
3189	2017-09-03 22:39:10.914393+03	1324	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:54:06.345006+00:00	3		35	1
3190	2017-09-03 22:39:10.91758+03	1323	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:54:05.505734+00:00	3		35	1
3191	2017-09-03 22:39:10.920939+03	1322	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:53:39.689833+00:00	3		35	1
3192	2017-09-03 22:39:10.924406+03	1321	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:53:39.036436+00:00	3		35	1
3193	2017-09-03 22:39:10.927366+03	1320	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:53:38.085084+00:00	3		35	1
3194	2017-09-03 22:39:10.930472+03	1319	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:53:06.823806+00:00	3		35	1
3195	2017-09-03 22:39:10.933525+03	1318	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:53:06.212450+00:00	3		35	1
3196	2017-09-03 22:39:10.936698+03	1317	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:53:05.276856+00:00	3		35	1
3197	2017-09-03 22:39:10.940246+03	1316	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:52:39.634518+00:00	3		35	1
3198	2017-09-03 22:39:10.943535+03	1315	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:52:38.953148+00:00	3		35	1
3199	2017-09-03 22:39:10.946507+03	1314	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:52:38.038321+00:00	3		35	1
3200	2017-09-03 22:39:10.949453+03	1313	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:52:07.268506+00:00	3		35	1
3201	2017-09-03 22:39:10.952448+03	1312	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:52:06.474992+00:00	3		35	1
3202	2017-09-03 22:39:10.956452+03	1311	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:52:05.381453+00:00	3		35	1
3203	2017-09-03 22:39:10.960543+03	1310	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:51:39.276494+00:00	3		35	1
3204	2017-09-03 22:39:10.963986+03	1309	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:51:37.784355+00:00	3		35	1
3205	2017-09-03 22:39:10.966912+03	1308	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:51:36.823622+00:00	3		35	1
3206	2017-09-03 22:39:10.970475+03	1307	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:51:10.620388+00:00	3		35	1
3207	2017-09-03 22:39:10.973648+03	1306	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:51:09.092591+00:00	3		35	1
3208	2017-09-03 22:39:10.983591+03	1305	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:51:08.038620+00:00	3		35	1
3209	2017-09-03 22:39:10.986834+03	1304	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:50:41.387674+00:00	3		35	1
3210	2017-09-03 22:39:10.99101+03	1303	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:50:40.690404+00:00	3		35	1
3211	2017-09-03 22:39:10.99463+03	1302	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:50:39.248978+00:00	3		35	1
3212	2017-09-03 22:39:10.997946+03	1301	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:50:08.516713+00:00	3		35	1
3213	2017-09-03 22:39:11.001634+03	1300	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:50:07.392348+00:00	3		35	1
3214	2017-09-03 22:39:11.00531+03	1299	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:50:06.636173+00:00	3		35	1
3215	2017-09-03 22:39:11.009462+03	1298	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:49:40.594605+00:00	3		35	1
3216	2017-09-03 22:39:11.012498+03	1297	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:49:39.991585+00:00	3		35	1
3217	2017-09-03 22:39:11.015392+03	1296	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:49:38.905179+00:00	3		35	1
3218	2017-09-03 22:39:11.01833+03	1295	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:49:07.333577+00:00	3		35	1
3219	2017-09-03 22:39:11.021357+03	1294	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:49:06.336555+00:00	3		35	1
3220	2017-09-03 22:39:11.024697+03	1293	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:49:05.597195+00:00	3		35	1
3221	2017-09-03 22:39:11.028027+03	1292	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:48:39.603152+00:00	3		35	1
3222	2017-09-03 22:39:11.031467+03	1291	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:48:38.884345+00:00	3		35	1
3223	2017-09-03 22:39:11.034648+03	1290	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:48:37.900360+00:00	3		35	1
3224	2017-09-03 22:39:11.037909+03	1289	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:48:12.166133+00:00	3		35	1
3225	2017-09-03 22:39:11.041524+03	1288	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:48:10.704227+00:00	3		35	1
3226	2017-09-03 22:39:11.045231+03	1287	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:48:10.089692+00:00	3		35	1
3227	2017-09-03 22:39:11.048683+03	1286	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:47:39.085778+00:00	3		35	1
3228	2017-09-03 22:39:11.052124+03	1285	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:47:37.765485+00:00	3		35	1
3229	2017-09-03 22:39:11.055764+03	1284	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:47:37.105038+00:00	3		35	1
3230	2017-09-03 22:39:11.059228+03	1283	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:47:11.064552+00:00	3		35	1
3231	2017-09-03 22:39:11.06256+03	1282	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:47:09.525668+00:00	3		35	1
3232	2017-09-03 22:39:11.065665+03	1281	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:47:08.769519+00:00	3		35	1
3233	2017-09-03 22:39:11.068711+03	1280	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:46:37.670782+00:00	3		35	1
3234	2017-09-03 22:39:11.071917+03	1279	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:46:36.530886+00:00	3		35	1
3235	2017-09-03 22:39:11.0753+03	1278	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:46:35.485611+00:00	3		35	1
3236	2017-09-03 22:39:11.078289+03	1277	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:46:09.070922+00:00	3		35	1
3237	2017-09-03 22:39:11.081367+03	1276	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:46:08.005692+00:00	3		35	1
3238	2017-09-03 22:39:11.084577+03	1275	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:46:06.878706+00:00	3		35	1
3239	2017-09-03 22:39:11.088202+03	1274	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:45:40.472941+00:00	3		35	1
3240	2017-09-03 22:39:11.09478+03	1273	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:45:38.981988+00:00	3		35	1
3241	2017-09-03 22:39:11.098021+03	1272	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:45:37.564461+00:00	3		35	1
3242	2017-09-03 22:39:11.101074+03	1271	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:45:11.229151+00:00	3		35	1
3243	2017-09-03 22:39:11.104186+03	1270	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:45:10.684159+00:00	3		35	1
3244	2017-09-03 22:39:11.107467+03	1269	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:45:09.887067+00:00	3		35	1
3245	2017-09-03 22:39:11.111241+03	1268	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:44:39.038424+00:00	3		35	1
3246	2017-09-03 22:39:11.114464+03	1267	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:44:38.350855+00:00	3		35	1
3247	2017-09-03 22:39:11.117627+03	1266	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:44:37.704290+00:00	3		35	1
3248	2017-09-03 22:39:11.120878+03	1265	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:44:11.874037+00:00	3		35	1
3249	2017-09-03 22:39:11.124369+03	1264	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:44:10.644394+00:00	3		35	1
3250	2017-09-03 22:39:11.127563+03	1263	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:44:09.507048+00:00	3		35	1
3251	2017-09-03 22:39:11.130697+03	1262	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:43:38.577350+00:00	3		35	1
3252	2017-09-03 22:39:11.133996+03	1261	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:43:37.908361+00:00	3		35	1
3253	2017-09-03 22:39:11.144236+03	1260	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:43:36.457979+00:00	3		35	1
3254	2017-09-03 22:39:11.14788+03	1259	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:43:10.719106+00:00	3		35	1
3255	2017-09-03 22:39:11.151469+03	1258	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:43:09.227311+00:00	3		35	1
3256	2017-09-03 22:39:11.156148+03	1257	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:43:07.837007+00:00	3		35	1
3257	2017-09-03 22:39:11.159873+03	1256	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:42:41.565640+00:00	3		35	1
3258	2017-09-03 22:39:11.16272+03	1255	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:42:40.392988+00:00	3		35	1
3259	2017-09-03 22:39:11.166572+03	1254	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:42:39.252843+00:00	3		35	1
3260	2017-09-03 22:39:11.169925+03	1253	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:42:08.142786+00:00	3		35	1
3261	2017-09-03 22:39:11.173104+03	1252	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:42:07.055357+00:00	3		35	1
3262	2017-09-03 22:39:11.176202+03	1251	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:42:06.104144+00:00	3		35	1
3263	2017-09-03 22:39:11.179189+03	1250	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:41:40.010661+00:00	3		35	1
3264	2017-09-03 22:39:11.182158+03	1249	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:41:38.762787+00:00	3		35	1
3265	2017-09-03 22:39:11.185312+03	1248	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:41:37.999749+00:00	3		35	1
3266	2017-09-03 22:39:11.188478+03	1247	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:41:06.631121+00:00	3		35	1
3267	2017-09-03 22:39:11.192567+03	1246	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:41:06.091849+00:00	3		35	1
3268	2017-09-03 22:39:11.196207+03	1245	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:41:05.446958+00:00	3		35	1
3269	2017-09-03 22:39:11.199202+03	1244	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:40:39.138419+00:00	3		35	1
3270	2017-09-03 22:39:11.202287+03	1243	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:40:38.047259+00:00	3		35	1
3271	2017-09-03 22:39:11.20594+03	1242	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:40:36.722975+00:00	3		35	1
3272	2017-09-03 22:39:11.209373+03	1241	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:40:10.223827+00:00	3		35	1
3273	2017-09-03 22:39:11.213322+03	1240	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:40:09.555198+00:00	3		35	1
3274	2017-09-03 22:39:11.224379+03	1239	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:40:08.370172+00:00	3		35	1
3275	2017-09-03 22:39:11.228336+03	1238	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:39:37.354610+00:00	3		35	1
3276	2017-09-03 22:39:11.231683+03	1237	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:39:36.196180+00:00	3		35	1
3277	2017-09-03 22:39:11.234764+03	1236	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:39:35.528844+00:00	3		35	1
3278	2017-09-03 22:39:11.237693+03	1235	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:39:09.376966+00:00	3		35	1
3279	2017-09-03 22:39:11.241072+03	1234	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:39:08.768682+00:00	3		35	1
3280	2017-09-03 22:39:11.244392+03	1233	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:39:08.097755+00:00	3		35	1
3281	2017-09-03 22:39:11.247586+03	1232	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:38:42.007647+00:00	3		35	1
3282	2017-09-03 22:39:11.250988+03	1231	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:38:40.516988+00:00	3		35	1
3283	2017-09-03 22:39:11.254483+03	1230	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:38:39.733096+00:00	3		35	1
3284	2017-09-03 22:39:11.257997+03	1229	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:38:08.946330+00:00	3		35	1
3285	2017-09-03 22:39:11.26818+03	1228	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:38:08.267445+00:00	3		35	1
3286	2017-09-03 22:39:11.271466+03	1227	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:38:06.770312+00:00	3		35	1
3287	2017-09-03 22:39:11.275636+03	1226	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:37:40.551880+00:00	3		35	1
3288	2017-09-03 22:39:11.279198+03	1225	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:37:39.499910+00:00	3		35	1
3289	2017-09-03 22:39:11.282608+03	1224	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:37:38.777592+00:00	3		35	1
3290	2017-09-03 22:39:11.285838+03	1223	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:37:07.965804+00:00	3		35	1
3291	2017-09-03 22:39:11.289584+03	1222	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:37:07.339381+00:00	3		35	1
3292	2017-09-03 22:39:11.293107+03	1221	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:37:05.861222+00:00	3		35	1
3293	2017-09-03 22:39:11.296166+03	1220	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:36:40.112365+00:00	3		35	1
3294	2017-09-03 22:39:11.299103+03	1219	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:36:38.715171+00:00	3		35	1
3295	2017-09-03 22:39:11.302143+03	1218	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:36:37.227576+00:00	3		35	1
3296	2017-09-03 22:39:11.305411+03	1217	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:36:11.252713+00:00	3		35	1
3297	2017-09-03 22:39:11.308504+03	1216	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:36:09.993004+00:00	3		35	1
3298	2017-09-03 22:39:11.311506+03	1215	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:36:08.638817+00:00	3		35	1
3299	2017-09-03 22:39:11.314645+03	1214	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:35:37.961036+00:00	3		35	1
3300	2017-09-03 22:39:11.317962+03	1213	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:35:36.681816+00:00	3		35	1
3301	2017-09-03 22:39:11.322207+03	1212	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:35:35.851541+00:00	3		35	1
3302	2017-09-03 22:39:11.326207+03	1211	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:35:09.688635+00:00	3		35	1
3303	2017-09-03 22:39:11.329432+03	1210	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:35:08.666614+00:00	3		35	1
3304	2017-09-03 22:39:11.332603+03	1209	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:35:07.395744+00:00	3		35	1
3305	2017-09-03 22:39:11.343918+03	1208	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:34:40.763909+00:00	3		35	1
3306	2017-09-03 22:39:11.347253+03	1207	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:34:39.329328+00:00	3		35	1
3307	2017-09-03 22:39:11.350483+03	1206	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:34:38.202141+00:00	3		35	1
3308	2017-09-03 22:39:11.353583+03	1205	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:34:12.479045+00:00	3		35	1
3309	2017-09-03 22:39:11.356792+03	1204	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:34:11.175222+00:00	3		35	1
3310	2017-09-03 22:39:11.35995+03	1203	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:34:09.654180+00:00	3		35	1
3311	2017-09-03 22:39:11.363058+03	1202	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:33:38.555872+00:00	3		35	1
3312	2017-09-03 22:39:11.36645+03	1201	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:33:37.699379+00:00	3		35	1
3313	2017-09-03 22:39:11.370138+03	1200	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:33:36.438025+00:00	3		35	1
3314	2017-09-03 22:39:11.374092+03	1199	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:33:09.911441+00:00	3		35	1
3315	2017-09-03 22:39:11.377672+03	1198	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:33:08.873122+00:00	3		35	1
3316	2017-09-03 22:39:11.38111+03	1197	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:33:07.731348+00:00	3		35	1
3317	2017-09-03 22:39:11.384105+03	1196	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:32:41.333753+00:00	3		35	1
3318	2017-09-03 22:39:11.394228+03	1195	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:32:40.575645+00:00	3		35	1
3319	2017-09-03 22:39:11.398737+03	1194	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:32:39.272320+00:00	3		35	1
3320	2017-09-03 22:39:11.40258+03	1193	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:32:12.660978+00:00	3		35	1
3321	2017-09-03 22:39:11.406179+03	1192	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:32:11.133640+00:00	3		35	1
3322	2017-09-03 22:39:11.409803+03	1191	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:32:10.006085+00:00	3		35	1
3323	2017-09-03 22:39:11.412886+03	1190	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:31:38.836154+00:00	3		35	1
3324	2017-09-03 22:39:11.415797+03	1189	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:31:38.047059+00:00	3		35	1
3325	2017-09-03 22:39:11.41886+03	1188	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:31:36.619560+00:00	3		35	1
3326	2017-09-03 22:39:11.422059+03	1187	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:31:10.956058+00:00	3		35	1
3327	2017-09-03 22:39:11.425308+03	1186	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:31:09.583583+00:00	3		35	1
3328	2017-09-03 22:39:11.428464+03	1185	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:31:08.566008+00:00	3		35	1
3329	2017-09-03 22:39:11.431694+03	1184	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:30:42.465715+00:00	3		35	1
3330	2017-09-03 22:39:11.434872+03	1183	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:30:41.597582+00:00	3		35	1
3331	2017-09-03 22:39:11.438129+03	1182	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:30:40.138072+00:00	3		35	1
3332	2017-09-03 22:39:11.441728+03	1181	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:30:08.906042+00:00	3		35	1
3333	2017-09-03 22:39:11.445032+03	1180	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:30:07.807853+00:00	3		35	1
3334	2017-09-03 22:39:11.448135+03	1179	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:30:06.818577+00:00	3		35	1
3335	2017-09-03 22:39:11.45127+03	1178	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:29:40.364737+00:00	3		35	1
3336	2017-09-03 22:39:11.454371+03	1177	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:29:39.790684+00:00	3		35	1
3337	2017-09-03 22:39:11.458346+03	1176	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:29:39.152824+00:00	3		35	1
3338	2017-09-03 22:39:11.462148+03	1175	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:29:12.838152+00:00	3		35	1
3339	2017-09-03 22:39:11.465544+03	1174	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:29:11.336595+00:00	3		35	1
3340	2017-09-03 22:39:11.477563+03	1173	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:29:09.805838+00:00	3		35	1
3341	2017-09-03 22:39:11.481721+03	1172	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:28:38.986222+00:00	3		35	1
3342	2017-09-03 22:39:11.485363+03	1171	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:28:38.094210+00:00	3		35	1
3343	2017-09-03 22:39:11.488984+03	1170	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:28:37.300393+00:00	3		35	1
3344	2017-09-03 22:39:11.492009+03	1169	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:28:10.893757+00:00	3		35	1
3345	2017-09-03 22:39:11.494848+03	1168	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:28:09.705373+00:00	3		35	1
3346	2017-09-03 22:39:11.497661+03	1167	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:28:08.713064+00:00	3		35	1
3347	2017-09-03 22:39:11.500619+03	1166	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:27:37.825153+00:00	3		35	1
3348	2017-09-03 22:39:11.50367+03	1165	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:27:36.420420+00:00	3		35	1
3349	2017-09-03 22:39:11.506952+03	1164	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:27:35.518813+00:00	3		35	1
3350	2017-09-03 22:39:11.510463+03	1163	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:27:09.359193+00:00	3		35	1
3351	2017-09-03 22:39:11.513581+03	1162	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:27:08.779190+00:00	3		35	1
3352	2017-09-03 22:39:11.516798+03	1161	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:27:08.242292+00:00	3		35	1
3353	2017-09-03 22:39:11.520378+03	1160	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:26:37.089625+00:00	3		35	1
3354	2017-09-03 22:39:11.523598+03	1159	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:26:36.239288+00:00	3		35	1
3355	2017-09-03 22:39:11.526946+03	1158	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:26:35.371147+00:00	3		35	1
3356	2017-09-03 22:39:11.52997+03	1157	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:26:08.919287+00:00	3		35	1
3357	2017-09-03 22:39:11.532963+03	1156	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:26:07.833639+00:00	3		35	1
3358	2017-09-03 22:39:11.543238+03	1155	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:26:06.363394+00:00	3		35	1
3359	2017-09-03 22:39:11.5554+03	1154	gisModule.tasks.statistic_module_basic_statistics - 2017-07-25 19:25:40.290972+00:00	3		35	1
3360	2017-09-03 22:39:11.55976+03	1153	gisModule.tasks.blame_module_check_proposal - 2017-07-25 19:25:39.348254+00:00	3		35	1
3361	2017-09-03 22:39:11.563693+03	1152	gisModule.tasks.blame_module_check_blame_status - 2017-07-25 19:25:38.035565+00:00	3		35	1
3362	2017-09-03 22:39:20.686824+03	50	dyanikoglu -> Kızılay AVM | Coca-Cola  1L	3		34	1
3363	2017-09-03 22:39:31.116103+03	29	FalsePriceProposal object	3		37	1
3364	2017-09-03 22:39:42.863524+03	119	test	3		32	1
3369	2017-09-03 22:40:16.491854+03	550	ShoppingListItem object	3		19	1
3370	2017-09-03 22:40:16.495835+03	549	ShoppingListItem object	3		19	1
3371	2017-09-03 22:40:16.499228+03	548	ShoppingListItem object	3		19	1
3372	2017-09-03 22:40:16.502397+03	547	ShoppingListItem object	3		19	1
3373	2017-09-03 22:40:16.505676+03	546	ShoppingListItem object	3		19	1
3374	2017-09-03 22:40:16.509081+03	545	ShoppingListItem object	3		19	1
3375	2017-09-03 22:40:16.512541+03	544	ShoppingListItem object	3		19	1
3376	2017-09-03 22:40:16.51607+03	543	ShoppingListItem object	3		19	1
3377	2017-09-03 22:40:16.519068+03	542	ShoppingListItem object	3		19	1
3378	2017-09-03 22:40:38.381591+03	76	My First Shopping List	3		18	1
3379	2017-09-03 22:40:38.385293+03	75	Test	3		18	1
3380	2017-09-03 22:40:38.388487+03	73	My First Shopping List	3		18	1
3381	2017-09-03 22:40:38.392233+03	72	My First Shopping List	3		18	1
3382	2017-09-03 22:41:02.991968+03	22	dyanikoglu	3		17	1
3383	2017-09-03 22:41:10.570782+03	77	My First Shopping List	3		18	1
3384	2017-09-03 22:41:20.18549+03	23	UserPreferences object	3		29	1
3385	2017-09-03 22:41:31.085419+03	5	UserStatistics object	3		39	1
3386	2017-09-03 22:41:31.088732+03	4	UserStatistics object	3		39	1
3387	2017-09-03 22:58:16.986536+03	242	Kızılay AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point", "proposal_ongoing", "removed_from_store"]}}]	15	1
3388	2017-09-03 23:09:27.579249+03	207	Ankamall AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
3389	2017-09-03 23:12:24.564046+03	221	Arcadium AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
3390	2017-09-03 23:15:38.442164+03	200	Atlantis AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
3391	2017-09-03 23:19:04.675668+03	235	Cepa AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
3392	2017-09-03 23:23:48.577555+03	228	Armada AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
3393	2017-09-03 23:26:16.789277+03	249	Panora AVM | Coca-Cola  1L	2	[{"changed": {"fields": ["blame_point"]}}]	15	1
3394	2017-09-04 13:50:23.861617+03	25	test_2	3		17	1
3395	2017-09-04 13:50:23.867519+03	24	test_1	3		17	1
3396	2017-09-04 13:50:30.09338+03	36	FalsePriceProposal object	3		37	1
3397	2017-09-04 13:50:30.097782+03	35	FalsePriceProposal object	3		37	1
3398	2017-09-04 13:50:30.102048+03	34	FalsePriceProposal object	3		37	1
3399	2017-09-04 13:50:30.10587+03	33	FalsePriceProposal object	3		37	1
3400	2017-09-04 13:50:30.109254+03	32	FalsePriceProposal object	3		37	1
3401	2017-09-04 13:50:30.112502+03	31	FalsePriceProposal object	3		37	1
3402	2017-09-04 13:50:30.115607+03	30	FalsePriceProposal object	3		37	1
3403	2017-09-04 13:50:46.485733+03	81	My First Shopping List	3		18	1
3404	2017-09-04 13:50:46.48893+03	80	My First Shopping List	3		18	1
3405	2017-09-04 13:50:54.131915+03	25	UserPreferences object	3		29	1
3406	2017-09-04 13:51:01.631224+03	7	UserStatistics object	3		39	1
3407	2017-09-04 13:51:01.636929+03	6	UserStatistics object	3		39	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 3407, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	group
2	auth	user
3	auth	permission
4	contenttypes	contenttype
5	sessions	session
6	admin	logentry
8	gisModule	city
9	gisModule	district
10	gisModule	retailer
11	gisModule	retailertype
12	gisModule	baseproduct
13	gisModule	productgroup
15	gisModule	retailerproduct
17	gisModule	user
18	gisModule	shoppinglist
19	gisModule	shoppinglistitem
26	gisModule	treeedge
28	gisModule	usersavedaddress
29	gisModule	userpreferences
30	gisModule	friend
31	gisModule	groupmember
32	gisModule	group
33	gisModule	role
27	gisModule	shoppinglistmember
34	gisModule	blame
35	background_task	completedtask
36	background_task	task
37	gisModule	falsepriceproposal
38	gisModule	proposalsent
39	gisModule	userstatistics
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('django_content_type_id_seq', 39, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-01-26 02:35:09.361331+03
2	contenttypes	0002_remove_content_type_name	2017-01-26 02:35:09.373235+03
3	auth	0001_initial	2017-01-26 02:35:09.556818+03
4	auth	0002_alter_permission_name_max_length	2017-01-26 02:35:09.572034+03
5	auth	0003_alter_user_email_max_length	2017-01-26 02:35:09.593163+03
6	auth	0004_alter_user_username_opts	2017-01-26 02:35:09.61246+03
7	auth	0005_alter_user_last_login_null	2017-01-26 02:35:09.640449+03
8	auth	0006_require_contenttypes_0002	2017-01-26 02:35:09.644339+03
9	auth	0007_alter_validators_add_error_messages	2017-01-26 02:35:09.65676+03
10	auth	0008_alter_user_username_max_length	2017-01-26 02:35:09.676499+03
11	sessions	0001_initial	2017-01-26 02:35:09.709042+03
12	admin	0001_initial	2017-01-26 02:54:41.557131+03
13	admin	0002_logentry_remove_auto_add	2017-01-26 02:54:41.579942+03
14	gisModule	0001_initial	2017-01-26 12:44:54.052236+03
15	gisModule	0002_remove_shop_city	2017-01-26 14:53:16.448285+03
16	gisModule	0003_city_district	2017-01-27 11:25:59.351697+03
17	gisModule	0004_auto_20170127_0843	2017-01-27 11:43:30.13064+03
18	gisModule	0005_auto_20170127_0902	2017-01-27 12:02:36.487252+03
19	gisModule	0006_auto_20170127_0914	2017-01-27 12:14:27.624446+03
20	gisModule	0007_baseproduct_productgroup_producttree_retailerproduct	2017-01-29 16:30:42.950474+03
21	gisModule	0008_auto_20170129_1331	2017-01-29 16:31:48.453452+03
22	gisModule	0009_auto_20170129_1357	2017-01-29 16:57:32.823945+03
23	gisModule	0010_auto_20170129_1358	2017-01-29 16:58:07.080954+03
24	gisModule	0011_auto_20170129_1407	2017-01-29 17:07:37.514744+03
25	gisModule	0012_auto_20170129_1407	2017-01-29 17:07:37.524321+03
26	gisModule	0013_auto_20170129_1420	2017-01-29 17:20:35.128531+03
27	gisModule	0014_auto_20170203_2149	2017-02-04 00:49:27.587021+03
28	PathFinder	0001_initial	2017-02-04 01:15:06.398184+03
29	gisModule	0002_auto_20170204_0018	2017-02-04 03:18:33.116611+03
30	gisModule	0003_retailer_lastedited	2017-02-04 03:21:08.470814+03
31	gisModule	0004_auto_20170204_0021	2017-02-04 03:21:08.486306+03
32	gisModule	0005_remove_retailer_lastedited	2017-02-04 03:23:09.995236+03
33	gisModule	0006_auto_20170206_2326	2017-02-07 02:26:14.670542+03
34	gisModule	0007_auto_20170206_2328	2017-02-07 02:28:42.364681+03
35	gisModule	0008_auto_20170206_2328	2017-02-07 02:28:42.383378+03
36	gisModule	0009_auto_20170206_2342	2017-02-07 02:42:32.814415+03
37	gisModule	0010_auto_20170206_2345	2017-02-07 02:45:21.237702+03
38	gisModule	0011_auto_20170212_2334	2017-02-13 02:35:02.478719+03
39	gisModule	0011_auto_20170212_2350	2017-02-13 02:50:40.955692+03
40	gisModule	0012_auto_20170212_2353	2017-02-13 02:53:30.756946+03
41	gisModule	0013_auto_20170213_2310	2017-02-14 02:10:57.592499+03
42	gisModule	0014_auto_20170227_0739	2017-02-27 10:40:01.133674+03
43	gisModule	0015_auto_20170227_0753	2017-02-27 10:53:16.124024+03
44	gisModule	0016_auto_20170227_0758	2017-02-27 10:58:19.287891+03
45	gisModule	0017_auto_20170227_0802	2017-02-27 11:02:14.242499+03
46	gisModule	0018_auto_20170227_0809	2017-02-27 11:09:42.777013+03
47	gisModule	0019_auto_20170227_0821	2017-02-27 11:22:01.998477+03
48	gisModule	0020_auto_20170227_0822	2017-02-27 11:22:26.519425+03
49	gisModule	0021_auto_20170227_0903	2017-02-27 12:03:34.196697+03
50	gisModule	0022_auto_20170227_0909	2017-02-27 12:09:19.574483+03
51	gisModule	0023_auto_20170227_0913	2017-02-27 12:13:53.147492+03
52	gisModule	0024_auto_20170227_0916	2017-02-27 12:16:32.410899+03
53	gisModule	0025_auto_20170227_0918	2017-02-27 12:18:39.721952+03
54	gisModule	0026_auto_20170227_0919	2017-02-27 12:19:05.837852+03
55	gisModule	0027_auto_20170227_0923	2017-02-27 12:23:10.852698+03
56	gisModule	0028_auto_20170227_0927	2017-02-27 12:27:19.176394+03
57	gisModule	0029_remove_treeconnection_childproductnode	2017-02-27 12:34:18.035971+03
58	gisModule	0030_auto_20170227_0938	2017-02-27 12:38:18.837294+03
59	gisModule	0031_treeedge_parent	2017-02-27 12:39:25.573632+03
60	gisModule	0032_auto_20170227_0940	2017-02-27 12:40:04.850292+03
61	gisModule	0033_auto_20170227_0949	2017-02-27 12:49:17.303834+03
62	gisModule	0034_auto_20170227_0956	2017-02-27 12:56:29.310726+03
63	gisModule	0035_auto_20170227_0957	2017-02-27 12:57:15.858419+03
64	gisModule	0036_treeedge_isgroupedge	2017-02-27 12:58:42.426435+03
65	gisModule	0037_auto_20170227_1022	2017-02-27 13:22:47.752786+03
66	gisModule	0038_auto_20170227_1028	2017-02-27 13:28:17.081419+03
67	gisModule	0039_auto_20170227_1033	2017-02-27 13:33:34.564468+03
68	gisModule	0040_auto_20170227_1040	2017-02-27 13:40:37.449214+03
69	gisModule	0041_auto_20170227_1042	2017-02-27 13:42:46.458304+03
70	gisModule	0042_auto_20170227_1145	2017-02-27 14:45:18.815928+03
71	gisModule	0043_remove_productgroup_isleaf	2017-02-28 09:20:58.297298+03
72	gisModule	0044_auto_20170228_0643	2017-02-28 09:43:05.435657+03
73	gisModule	0045_auto_20170228_0740	2017-02-28 10:40:20.479949+03
74	gisModule	0046_auto_20170303_2106	2017-03-04 00:06:21.392606+03
75	gisModule	0047_auto_20170303_2332	2017-03-04 02:32:26.143695+03
76	gisModule	0048_auto_20170303_2339	2017-03-04 02:39:43.938654+03
77	gisModule	0049_auto_20170303_2344	2017-03-04 02:44:28.783349+03
78	gisModule	0050_auto_20170303_2346	2017-03-04 02:46:04.817433+03
79	gisModule	0051_shoppinglistitem_addedby	2017-03-04 03:07:31.290705+03
80	gisModule	0052_usershoppinglist_isactive	2017-03-04 13:01:48.184614+03
81	gisModule	0053_auto_20170306_0920	2017-03-06 12:20:31.663819+03
82	gisModule	0054_auto_20170306_0946	2017-03-06 12:46:53.575522+03
83	gisModule	0055_usersavedaddress	2017-03-21 13:58:08.372867+03
84	gisModule	0056_userpreferences	2017-04-14 01:32:33.433225+03
85	gisModule	0057_userpreferences_search_radius	2017-04-14 02:11:52.100406+03
86	gisModule	0058_auto_20170413_2320	2017-04-14 02:20:29.854359+03
87	gisModule	0059_auto_20170424_1129	2017-04-24 14:29:45.549674+03
88	gisModule	0060_auto_20170424_2135	2017-04-25 00:35:08.272535+03
89	gisModule	0061_remove_userpreferences_market_factor	2017-05-03 15:26:24.247546+03
90	gisModule	0062_auto_20170509_0738	2017-05-09 10:38:59.636835+03
91	gisModule	0063_auto_20170509_0748	2017-05-09 10:48:30.864479+03
92	gisModule	0064_auto_20170509_0749	2017-05-09 10:49:21.990495+03
93	gisModule	0065_user_email	2017-05-10 11:55:39.995491+03
94	gisModule	0066_auto_20170510_0901	2017-05-10 12:01:59.194987+03
95	gisModule	0067_userpreferences_owner	2017-05-10 13:04:02.428773+03
96	gisModule	0068_auto_20170510_1232	2017-05-10 15:32:48.607297+03
97	gisModule	0069_baseproduct_name	2017-05-11 17:00:45.675063+03
98	gisModule	0070_auto_20170512_1835	2017-05-12 21:35:44.65732+03
99	gisModule	0071_auto_20170512_1901	2017-05-12 22:02:00.840103+03
100	gisModule	0072_groupmember_date	2017-05-13 12:57:58.884122+03
101	gisModule	0073_auto_20170514_0723	2017-05-14 10:23:55.217769+03
102	gisModule	0074_auto_20170515_0534	2017-05-15 08:34:14.678357+03
103	gisModule	0075_auto_20170515_0708	2017-05-15 10:08:33.680182+03
104	gisModule	0076_userpreferences_get_notif_only_for_active_list	2017-05-15 17:51:28.422351+03
105	gisModule	0077_remove_userpreferences_owner	2017-05-16 15:32:36.708054+03
106	gisModule	0078_userpreferences_owner	2017-05-16 15:33:31.000602+03
107	gisModule	0079_auto_20170518_0618	2017-05-18 09:18:31.935075+03
108	gisModule	0080_blame	2017-07-14 14:05:19.862389+03
109	gisModule	0081_auto_20170714_1120	2017-07-14 14:20:41.96882+03
110	gisModule	0082_auto_20170714_1132	2017-07-14 14:32:41.257645+03
111	gisModule	0083_auto_20170714_1225	2017-07-14 15:25:20.023995+03
112	gisModule	0084_auto_20170714_1239	2017-07-14 15:39:22.028501+03
113	background_task	0001_initial	2017-07-15 10:40:24.017457+03
114	gisModule	0085_auto_20170715_0850	2017-07-15 11:50:28.095305+03
115	gisModule	0086_retailerproduct_proposalongoing	2017-07-15 12:49:32.179473+03
116	gisModule	0087_auto_20170715_0949	2017-07-15 12:49:59.647461+03
117	gisModule	0088_auto_20170715_1050	2017-07-15 13:50:26.648743+03
118	gisModule	0089_auto_20170715_1302	2017-07-15 16:03:03.212906+03
119	gisModule	0090_auto_20170715_1302	2017-07-15 16:03:03.244218+03
120	gisModule	0091_userpreferences_algorithm	2017-07-22 17:11:30.815398+03
121	gisModule	0092_auto_20170722_1416	2017-07-22 17:16:26.065283+03
122	gisModule	0093_auto_20170722_1421	2017-07-22 17:21:07.468669+03
123	gisModule	0094_userstatistics	2017-07-24 12:55:31.042112+03
124	gisModule	0095_auto_20170724_1119	2017-07-24 14:19:55.88942+03
125	gisModule	0096_auto_20170724_1328	2017-07-24 16:28:14.437264+03
126	gisModule	0097_auto_20170724_1353	2017-07-24 16:53:32.82608+03
127	gisModule	0098_auto_20170724_1355	2017-07-24 16:55:31.648186+03
128	gisModule	0099_auto_20170726_0903	2017-07-26 12:03:27.341669+03
129	gisModule	0100_auto_20170726_0904	2017-07-26 12:04:52.929959+03
130	gisModule	0101_auto_20170726_1158	2017-07-26 14:58:33.610088+03
131	gisModule	0102_auto_20170726_1532	2017-07-26 18:32:15.377453+03
132	gisModule	0103_auto_20170727_1956	2017-07-27 22:56:35.338602+03
133	gisModule	0104_shoppinglistitem_purchase_date	2017-07-27 22:58:38.069285+03
134	gisModule	0105_auto_20170727_2002	2017-07-27 23:02:12.290736+03
135	gisModule	0106_auto_20170727_2017	2017-07-27 23:17:12.614566+03
136	gisModule	0107_shoppinglistitem_purchased_from	2017-09-02 00:16:15.05688+03
137	gisModule	0108_userstatistics_favorite_retailer	2017-09-02 15:23:53.025632+03
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('django_migrations_id_seq', 137, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
smgt52y21xrgltcvxizra7urb21ophxk	YTUxMTdjOWI0N2U1ZTBmZDFmZmUxODdkNmFiZTM1MDZkMjY0NmVhYjp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MjIsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0X25hbWUiOiJEb1x1MDExZmEgQ2FuIiwibGFzdF9uYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDUyNjdlN2Y4NTRmMjVkNmIxZGI3YjcwY2E3OTI0OTczNGMxOWM3YiJ9	2017-08-09 17:06:12.767895+03
8kb583v6vtenemz89ws4zjxs1gasy1rk	YTUxMTdjOWI0N2U1ZTBmZDFmZmUxODdkNmFiZTM1MDZkMjY0NmVhYjp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MjIsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0X25hbWUiOiJEb1x1MDExZmEgQ2FuIiwibGFzdF9uYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDUyNjdlN2Y4NTRmMjVkNmIxZGI3YjcwY2E3OTI0OTczNGMxOWM3YiJ9	2017-08-12 18:02:34.976117+03
xzutypgcz5ee6z2p862g870bb29pvj4w	ZDMwMjg0NzdhMzQyODVkNWRmNzBkMTRiMTg1YThhOTExM2Q4ODg3YTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MjUsInVzZXJuYW1lIjoidGVzdF8yIiwiZmlyc3RfbmFtZSI6IlNlY29uZCIsImxhc3RfbmFtZSI6IlRlc3QifSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjA1MjY3ZTdmODU0ZjI1ZDZiMWRiN2I3MGNhNzkyNDk3MzRjMTljN2IifQ==	2017-09-17 22:43:35.442442+03
i5apd06jq39vr7gbrfrt0wxfbai4dtlx	MDJjZmU0NGRhOTkzMzE1ZTA2NjE0MzI0OWM0ZWQ3MmNmN2E2ZjAyZDp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MjIsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0X25hbWUiOiJEb1x1MDExZmEgQ2FuIiwibGFzdF9uYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9fQ==	2017-09-02 23:33:06.404829+03
2dph0qz5wnvidnsimr39fqiwtqlgywss	MmRlNGUzMzFlZWQzYWE3YmFmY2U3MmRkMjQwZmQ1MzA4ODQ5ZjMxODp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MjQsInVzZXJuYW1lIjoidGVzdF8xIiwiZmlyc3RfbmFtZSI6IkZpcnN0IiwibGFzdF9uYW1lIjoiVGVzdCJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDUyNjdlN2Y4NTRmMjVkNmIxZGI3YjcwY2E3OTI0OTczNGMxOWM3YiJ9	2017-09-17 22:43:16.990499+03
\.


--
-- Data for Name: gisModule_baseproduct; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_baseproduct" (id, brand, type, amount, unit, group_id, name) FROM stdin;
19	Pınar	Süt	1	L	40	Pınar Süt 1L
20	Sütaş	Süt	1	L	40	Sütaş Süt 1L
21	Coca-Cola		1	L	41	Coca-Cola  1L
22	Sek	Süt	1	L	40	Sek Süt 1L
23	A	Süt	1	L	40	A Süt 1L
24	B	Süt	1	L	40	B Süt 1L
25	C	Süt	1000	ML	40	C Süt 1000ML
\.


--
-- Name: gisModule_baseproduct_productID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_baseproduct_productID_seq"', 26, true);


--
-- Data for Name: gisModule_blame; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_blame" (id, created_at, user_id, retailer_product_id, updated_at) FROM stdin;
\.


--
-- Name: gisModule_blame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_blame_id_seq"', 65, true);


--
-- Data for Name: gisModule_city; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_city" ("cityID", "cityName") FROM stdin;
1	Adana
2	Adıyaman
3	Afyonkarahisar
4	Ağrı
5	Amasya
6	Ankara
7	Antalya
8	Artvin
9	Aydın
10	Balıkesir
11	Bilecik
12	Bingöl
13	Bitlis
14	Bolu
15	Burdur
16	Bursa
17	Çanakkale
18	Çankırı
19	Çorum
20	Denizli
21	Diyarbakır
22	Edirne
23	Elazığ
24	Erzincan
25	Erzurum
26	Eskişehir
27	Gaziantep
28	Giresun
29	Gümüşhane
30	Hakkari
31	Hatay
32	Isparta
33	Mersin
34	İstanbul
35	İzmir
36	Kars
37	Kastamonu
38	Kayseri
39	Kırklareli
40	Kırşehir
41	Kocaeli
42	Konya
43	Kütahya
44	Malatya
45	Manisa
46	Kahramanmaraş
47	Mardin
48	Muğla
49	Muş
50	Nevşehir
51	Niğde
52	Ordu
53	Rize
54	Sakarya
55	Samsun
56	Siirt
57	Sinop
58	Sivas
59	Tekirdağ
60	Tokat
61	Trabzon
62	Tunceli
63	Şanlıurfa
64	Uşak
65	Van
66	Yozgat
67	Zonguldak
68	Aksaray
69	Bayburt
70	Karaman
71	Kırıkkale
72	Batman
73	Şırnak
74	Bartın
75	Ardahan
76	Iğdır
77	Yalova
78	Karabük
79	Kilis
80	Osmaniye
81	Düzce
\.


--
-- Name: gisModule_city_cityID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_city_cityID_seq"', 1, false);


--
-- Data for Name: gisModule_district; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_district" ("districtID", "cityID", "districtName") FROM stdin;
1	1	Seyhan
2	1	Ceyhan
3	1	Feke
4	1	Karaisalı
5	1	Karataş
6	1	Kozan
7	1	Pozantı
8	1	Saimbeyli
9	1	Tufanbeyli
10	1	Yumurtalık
11	1	Yüreğir
12	1	Aladağ
13	1	İmamoğlu
14	1	Sarıçam
15	1	Çukurova
16	2	Adıyaman Merkez
17	2	Besni
18	2	Çelikhan
19	2	Gerger
20	2	Gölbaşı / Adıyaman
21	2	Kahta
22	2	Samsat
23	2	Sincik
24	2	Tut
25	3	Afyonkarahisar Merkez
26	3	Bolvadin
27	3	Çay
28	3	Dazkırı
29	3	Dinar
30	3	Emirdağ
31	3	İhsaniye
32	3	Sandıklı
33	3	Sinanpaşa
34	3	Sultandağı
35	3	Şuhut
36	3	Başmakçı
37	3	Bayat / Afyonkarahisar
38	3	İscehisar
39	3	Çobanlar
40	3	Evciler
41	3	Hocalar
42	3	Kızılören
43	4	Ağrı Merkez
44	4	Diyadin
45	4	Doğubayazıt
46	4	Eleşkirt
47	4	Hamur
48	4	Patnos
49	4	Taşlıçay
50	4	Tutak
51	5	Amasya Merkez
52	5	Göynücek
53	5	Gümüşhacıköy
54	5	Merzifon
55	5	Suluova
56	5	Taşova
57	5	Hamamözü
58	6	Altındağ
59	6	Ayaş
60	6	Bala
61	6	Beypazarı
62	6	Çamlıdere
63	6	Çankaya
64	6	Çubuk
65	6	Elmadağ
66	6	Güdül
67	6	Haymana
68	6	Kalecik
69	6	Kızılcahamam
70	6	Nallıhan
71	6	Polatlı
72	6	Şereflikoçhisar
73	6	Yenimahalle
74	6	Gölbaşı / Ankara
75	6	Keçiören
76	6	Mamak
77	6	Sincan
78	6	Kazan
79	6	Akyurt
80	6	Etimesgut
81	6	Evren
82	6	Pursaklar
83	7	Akseki
84	7	Alanya
85	7	Elmalı
86	7	Finike
87	7	Gazipaşa
88	7	Gündoğmuş
89	7	Kaş
90	7	Korkuteli
91	7	Kumluca
92	7	Manavgat
93	7	Serik
94	7	Demre
95	7	İbradı
96	7	Kemer / Antalya
97	7	Aksu / Antalya
98	7	Döşemealtı
99	7	Kepez
100	7	Konyaaltı
101	7	Muratpaşa
102	8	Ardanuç
103	8	Arhavi
104	8	Artvin Merkez
105	8	Borçka
106	8	Hopa
107	8	Şavşat
108	8	Yusufeli
109	8	Murgul
110	9	Bozdoğan
111	9	Çine
112	9	Germencik
113	9	Karacasu
114	9	Koçarlı
115	9	Kuşadası
116	9	Kuyucak
117	9	Nazilli
118	9	Söke
119	9	Sultanhisar
120	9	Yenipazar / Aydın
121	9	Buharkent
122	9	İncirliova
123	9	Karpuzlu
124	9	Köşk
125	9	Didim
126	9	Efeler
127	10	Ayvalık
128	10	Balya
129	10	Bandırma
130	10	Bigadiç
131	10	Burhaniye
132	10	Dursunbey
133	10	Edremit / Balıkesir
134	10	Erdek
135	10	Gönen / Balıkesir
136	10	Havran
137	10	İvrindi
138	10	Kepsut
139	10	Manyas
140	10	Savaştepe
141	10	Sındırgı
142	10	Susurluk
143	10	Marmara
144	10	Gömeç
145	10	Altıeylül
146	10	Karesi
147	11	Bilecik Merkez
148	11	Bozüyük
149	11	Gölpazarı
150	11	Osmaneli
151	11	Pazaryeri
152	11	Söğüt
153	11	Yenipazar / Bilecik
154	11	İnhisar
155	12	Bingöl Merkez
156	12	Genç
157	12	Karlıova
158	12	Kiğı
159	12	Solhan
160	12	Adaklı
161	12	Yayladere
162	12	Yedisu
163	13	Adilcevaz
164	13	Ahlat
165	13	Bitlis Merkez
166	13	Hizan
167	13	Mutki
168	13	Tatvan
169	13	Güroymak
170	14	Bolu Merkez
171	14	Gerede
172	14	Göynük
173	14	Kıbrıscık
174	14	Mengen
175	14	Mudurnu
176	14	Seben
177	14	Dörtdivan
178	14	Yeniçağa
179	15	Ağlasun
180	15	Bucak
181	15	Burdur Merkez
182	15	Gölhisar
183	15	Tefenni
184	15	Yeşilova
185	15	Karamanlı
186	15	Kemer / Burdur
187	15	Altınyayla / Burdur
188	15	Çavdır
189	15	Çeltikçi
190	16	Gemlik
191	16	İnegöl
192	16	İznik
193	16	Karacabey
194	16	Keles
195	16	Mudanya
196	16	Mustafakemalpaşa
197	16	Orhaneli
198	16	Orhangazi
199	16	Yenişehir / Bursa
200	16	Büyükorhan
201	16	Harmancık
202	16	Nilüfer
203	16	Osmangazi
204	16	Yıldırım
205	16	Gürsu
206	16	Kestel
207	17	Ayvacık / Çanakkale
208	17	Bayramiç
209	17	Biga
210	17	Bozcaada
211	17	Çan
212	17	Çanakkale Merkez
213	17	Eceabat
214	17	Ezine
215	17	Gelibolu
216	17	Gökçeada
217	17	Lapseki
218	17	Yenice / Çanakkale
219	18	Çankırı Merkez
220	18	Çerkeş
221	18	Eldivan
222	18	Ilgaz
223	18	Kurşunlu
224	18	Orta
225	18	Şabanözü
226	18	Yapraklı
227	18	Atkaracalar
228	18	Kızılırmak
229	18	Bayramören
230	18	Korgun
231	19	Alaca
232	19	Bayat / Çorum
233	19	Çorum Merkez
234	19	İskilip
235	19	Kargı
236	19	Mecitözü
237	19	Ortaköy / Çorum
238	19	Osmancık
239	19	Sungurlu
240	19	Boğazkale
241	19	Uğurludağ
242	19	Dodurga
243	19	Laçin
244	19	Oğuzlar
245	20	Acıpayam
246	20	Buldan
247	20	Çal
248	20	Çameli
249	20	Çardak
250	20	Çivril
251	20	Güney
252	20	Kale / Denizli
253	20	Sarayköy
254	20	Tavas
255	20	Babadağ
256	20	Bekilli
257	20	Honaz
258	20	Serinhisar
259	20	Pamukkale
260	20	Baklan
261	20	Beyağaç
262	20	Bozkurt / Denizli
263	20	Merkezefendi
264	21	Bismil
265	21	Çermik
266	21	Çınar
267	21	Çüngüş
268	21	Dicle
269	21	Ergani
270	21	Hani
271	21	Hazro
272	21	Kulp
273	21	Lice
274	21	Silvan
275	21	Eğil
276	21	Kocaköy
277	21	Bağlar
278	21	Kayapınar
279	21	Sur
280	21	Yenişehir / Diyarbakır
281	22	Edirne Merkez
282	22	Enez
283	22	Havsa
284	22	İpsala
285	22	Keşan
286	22	Lalapaşa
287	22	Meriç
288	22	Uzunköprü
289	22	Süloğlu
290	23	Ağın
291	23	Baskil
292	23	Elazığ Merkez
293	23	Karakoçan
294	23	Keban
295	23	Maden
296	23	Palu
297	23	Sivrice
298	23	Arıcak
299	23	Kovancılar
300	23	Alacakaya
301	24	Çayırlı
302	24	Erzincan Merkez
303	24	İliç
304	24	Kemah
305	24	Kemaliye
306	24	Refahiye
307	24	Tercan
308	24	Üzümlü
309	24	Otlukbeli
310	25	Aşkale
311	25	Çat
312	25	Hınıs
313	25	Horasan
314	25	İspir
315	25	Karayazı
316	25	Narman
317	25	Oltu
318	25	Olur
319	25	Pasinler
320	25	Şenkaya
321	25	Tekman
322	25	Tortum
323	25	Karaçoban
324	25	Uzundere
325	25	Pazaryolu
326	25	Aziziye
327	25	Köprüköy
328	25	Palandöken
329	25	Yakutiye
330	26	Çifteler
331	26	Mahmudiye
332	26	Mihalıççık
333	26	Sarıcakaya
334	26	Seyitgazi
335	26	Sivrihisar
336	26	Alpu
337	26	Beylikova
338	26	İnönü
339	26	Günyüzü
340	26	Han
341	26	Mihalgazi
342	26	Odunpazarı
343	26	Tepebaşı
344	27	Araban
345	27	İslahiye
346	27	Nizip
347	27	Oğuzeli
348	27	Yavuzeli
349	27	Şahinbey
350	27	Şehitkamil
351	27	Karkamış
352	27	Nurdağı
353	28	Alucra
354	28	Bulancak
355	28	Dereli
356	28	Espiye
357	28	Eynesil
358	28	Giresun Merkez
359	28	Görele
360	28	Keşap
361	28	Şebinkarahisar
362	28	Tirebolu
363	28	Piraziz
364	28	Yağlıdere
365	28	Çamoluk
366	28	Çanakçı
367	28	Doğankent
368	28	Güce
369	29	Gümüşhane Merkez
370	29	Kelkit
371	29	Şiran
372	29	Torul
373	29	Köse
374	29	Kürtün
375	30	Çukurca
376	30	Hakkari Merkez
377	30	Şemdinli
378	30	Yüksekova
379	31	Altınözü
380	31	Dörtyol
381	31	Hassa
382	31	İskenderun
383	31	Kırıkhan
384	31	Reyhanlı
385	31	Samandağ
386	31	Yayladağı
387	31	Erzin
388	31	Belen
389	31	Kumlu
390	31	Antakya
391	31	Arsuz
392	31	Defne
393	31	Payas
394	32	Atabey
395	32	Eğirdir
396	32	Gelendost
397	32	Isparta Merkez
398	32	Keçiborlu
399	32	Senirkent
400	32	Sütçüler
401	32	Şarkikaraağaç
402	32	Uluborlu
403	32	Yalvaç
404	32	Aksu / Isparta
405	32	Gönen / Isparta
406	32	Yenişarbademli
407	33	Anamur
408	33	Erdemli
409	33	Gülnar
410	33	Mut
411	33	Silifke
412	33	Tarsus
413	33	Aydıncık / Mersin
414	33	Bozyazı
415	33	Çamlıyayla
416	33	Akdeniz
417	33	Mezitli
418	33	Toroslar
419	33	Yenişehir / Mersin
420	34	Adalar
421	34	Bakırköy
422	34	Beşiktaş
423	34	Beykoz
424	34	Beyoğlu
425	34	Çatalca
426	34	Eyüp
427	34	Fatih
428	34	Gaziosmanpaşa
429	34	Kadıköy
430	34	Kartal
431	34	Sarıyer
432	34	Silivri
433	34	Şile
434	34	Şişli
435	34	Üsküdar
436	34	Zeytinburnu
437	34	Büyükçekmece
438	34	Kağıthane
439	34	Küçükçekmece
440	34	Pendik
441	34	Ümraniye
442	34	Bayrampaşa
443	34	Avcılar
444	34	Bağcılar
445	34	Bahçelievler
446	34	Güngören
447	34	Maltepe
448	34	Sultanbeyli
449	34	Tuzla
450	34	Esenler
451	34	Arnavutköy
452	34	Ataşehir
453	34	Başakşehir
454	34	Beylikdüzü
455	34	Çekmeköy
456	34	Esenyurt
457	34	Sancaktepe
458	34	Sultangazi
459	35	Aliağa
460	35	Bayındır
461	35	Bergama
462	35	Bornova
463	35	Çeşme
464	35	Dikili
465	35	Foça
466	35	Karaburun
467	35	Karşıyaka
468	35	Kemalpaşa
469	35	Kınık
470	35	Kiraz
471	35	Menemen
472	35	Ödemiş
473	35	Seferihisar
474	35	Selçuk
475	35	Tire
476	35	Torbalı
477	35	Urla
478	35	Beydağ
479	35	Buca
480	35	Konak
481	35	Menderes
482	35	Balçova
483	35	Çiğli
484	35	Gaziemir
485	35	Narlıdere
486	35	Güzelbahçe
487	35	Bayraklı
488	35	Karabağlar
489	36	Arpaçay
490	36	Digor
491	36	Kağızman
492	36	Kars Merkez
493	36	Sarıkamış
494	36	Selim
495	36	Susuz
496	36	Akyaka
497	37	Abana
498	37	Araç
499	37	Azdavay
500	37	Bozkurt / Kastamonu
501	37	Cide
502	37	Çatalzeytin
503	37	Daday
504	37	Devrekani
505	37	İnebolu
506	37	Kastamonu Merkez
507	37	Küre
508	37	Taşköprü
509	37	Tosya
510	37	İhsangazi
511	37	Pınarbaşı / Kastamonu
512	37	Şenpazar
513	37	Ağlı
514	37	Doğanyurt
515	37	Hanönü
516	37	Seydiler
517	38	Bünyan
518	38	Develi
519	38	Felahiye
520	38	İncesu
521	38	Pınarbaşı / Kayseri
522	38	Sarıoğlan
523	38	Sarız
524	38	Tomarza
525	38	Yahyalı
526	38	Yeşilhisar
527	38	Akkışla
528	38	Talas
529	38	Kocasinan
530	38	Melikgazi
531	38	Hacılar
532	38	Özvatan
533	39	Babaeski
534	39	Demirköy
535	39	Kırklareli Merkez
536	39	Kofçaz
537	39	Lüleburgaz
538	39	Pehlivanköy
539	39	Pınarhisar
540	39	Vize
541	40	Çiçekdağı
542	40	Kaman
543	40	Kırşehir Merkez
544	40	Mucur
545	40	Akpınar
546	40	Akçakent
547	40	Boztepe
548	41	Gebze
549	41	Gölcük
550	41	Kandıra
551	41	Karamürsel
552	41	Körfez
553	41	Derince
554	41	Başiskele
555	41	Çayırova
556	41	Darıca
557	41	Dilovası
558	41	İzmit
559	41	Kartepe
560	42	Akşehir
561	42	Beyşehir
562	42	Bozkır
563	42	Cihanbeyli
564	42	Çumra
565	42	Doğanhisar
566	42	Ereğli / Konya
567	42	Hadim
568	42	Ilgın
569	42	Kadınhanı
570	42	Karapınar
571	42	Kulu
572	42	Sarayönü
573	42	Seydişehir
574	42	Yunak
575	42	Akören
576	42	Altınekin
577	42	Derebucak
578	42	Hüyük
579	42	Karatay
580	42	Meram
581	42	Selçuklu
582	42	Taşkent
583	42	Ahırlı
584	42	Çeltik
585	42	Derbent
586	42	Emirgazi
587	42	Güneysınır
588	42	Halkapınar
589	42	Tuzlukçu
590	42	Yalıhüyük
591	43	Altıntaş
592	43	Domaniç
593	43	Emet
594	43	Gediz
595	43	Kütahya Merkez
596	43	Simav
597	43	Tavşanlı
598	43	Aslanapa
599	43	Dumlupınar
600	43	Hisarcık
601	43	Şaphane
602	43	Çavdarhisar
603	43	Pazarlar
604	44	Akçadağ
605	44	Arapgir
606	44	Arguvan
607	44	Darende
608	44	Doğanşehir
609	44	Hekimhan
610	44	Pütürge
611	44	Yeşilyurt / Malatya
612	44	Battalgazi
613	44	Doğanyol
614	44	Kale / Malatya
615	44	Kuluncak
616	44	Yazıhan
617	45	Akhisar
618	45	Alaşehir
619	45	Demirci
620	45	Gördes
621	45	Kırkağaç
622	45	Kula
623	45	Salihli
624	45	Sarıgöl
625	45	Saruhanlı
626	45	Selendi
627	45	Soma
628	45	Turgutlu
629	45	Ahmetli
630	45	Gölmarmara
631	45	Köprübaşı / Manisa
632	45	Şehzadeler
633	45	Yunusemre
634	46	Afşin
635	46	Andırın
636	46	Elbistan
637	46	Göksun
638	46	Pazarcık
639	46	Türkoğlu
640	46	Çağlayancerit
641	46	Ekinözü
642	46	Nurhak
643	46	Dulkadiroğlu
644	46	Onikişubat
645	47	Derik
646	47	Kızıltepe
647	47	Mazıdağı
648	47	Midyat
649	47	Nusaybin
650	47	Ömerli
651	47	Savur
652	47	Dargeçit
653	47	Yeşilli
654	47	Artuklu
655	48	Bodrum
656	48	Datça
657	48	Fethiye
658	48	Köyceğiz
659	48	Marmaris
660	48	Milas
661	48	Ula
662	48	Yatağan
663	48	Dalaman
664	48	Ortaca
665	48	Kavaklıdere
666	48	Menteşe
667	48	Seydikemer
668	49	Bulanık
669	49	Malazgirt
670	49	Muş Merkez
671	49	Varto
672	49	Hasköy
673	49	Korkut
674	50	Avanos
675	50	Derinkuyu
676	50	Gülşehir
677	50	Hacıbektaş
678	50	Kozaklı
679	50	Nevşehir Merkez
680	50	Ürgüp
681	50	Acıgöl
682	51	Bor
683	51	Çamardı
684	51	Niğde Merkez
685	51	Ulukışla
686	51	Altunhisar
687	51	Çiftlik
688	52	Akkuş
689	52	Aybastı
690	52	Fatsa
691	52	Gölköy
692	52	Korgan
693	52	Kumru
694	52	Mesudiye
695	52	Perşembe
696	52	Ulubey / Ordu
697	52	Ünye
698	52	Gülyalı
699	52	Gürgentepe
700	52	Çamaş
701	52	Çatalpınar
702	52	Çaybaşı
703	52	İkizce
704	52	Kabadüz
705	52	Kabataş
706	52	Altınordu
707	53	Ardeşen
708	53	Çamlıhemşin
709	53	Çayeli
710	53	Fındıklı
711	53	İkizdere
712	53	Kalkandere
713	53	Pazar / Rize
714	53	Rize Merkez
715	53	Güneysu
716	53	Derepazarı
717	53	Hemşin
718	53	İyidere
719	54	Akyazı
720	54	Geyve
721	54	Hendek
722	54	Karasu
723	54	Kaynarca
724	54	Sapanca
725	54	Kocaali
726	54	Pamukova
727	54	Taraklı
728	54	Ferizli
729	54	Karapürçek
730	54	Söğütlü
731	54	Adapazarı
732	54	Arifiye
733	54	Erenler
734	54	Serdivan
735	55	Alaçam
736	55	Bafra
737	55	Çarşamba
738	55	Havza
739	55	Kavak
740	55	Ladik
741	55	Terme
742	55	Vezirköprü
743	55	Asarcık
744	55	19 Mayıs
745	55	Salıpazarı
746	55	Tekkeköy
747	55	Ayvacık / Samsun
748	55	Yakakent
749	55	Atakum
750	55	Canik
751	55	İlkadım
752	56	Baykan
753	56	Eruh
754	56	Kurtalan
755	56	Pervari
756	56	Siirt Merkez
757	56	Şirvan
758	56	Tillo
759	57	Ayancık
760	57	Boyabat
761	57	Durağan
762	57	Erfelek
763	57	Gerze
764	57	Sinop Merkez
765	57	Türkeli
766	57	Dikmen
767	57	Saraydüzü
768	58	Divriği
769	58	Gemerek
770	58	Gürün
771	58	Hafik
772	58	İmranlı
773	58	Kangal
774	58	Koyulhisar
775	58	Sivas Merkez
776	58	Suşehri
777	58	Şarkışla
778	58	Yıldızeli
779	58	Zara
780	58	Akıncılar
781	58	Altınyayla / Sivas
782	58	Doğanşar
783	58	Gölova
784	58	Ulaş
785	59	Çerkezköy
786	59	Çorlu
787	59	Hayrabolu
788	59	Malkara
789	59	Muratlı
790	59	Saray / Tekirdağ
791	59	Şarköy
792	59	Marmaraereğlisi
793	59	Ergene
794	59	Süleymanpaşa
795	60	Almus
796	60	Artova
797	60	Erbaa
798	60	Niksar
799	60	Reşadiye
800	60	Tokat Merkez
801	60	Turhal
802	60	Zile
803	60	Pazar / Tokat
804	60	Yeşilyurt / Tokat
805	60	Başçiftlik
806	60	Sulusaray
807	61	Akçaabat
808	61	Araklı
809	61	Arsin
810	61	Çaykara
811	61	Maçka
812	61	Of
813	61	Sürmene
814	61	Tonya
815	61	Vakfıkebir
816	61	Yomra
817	61	Beşikdüzü
818	61	Şalpazarı
819	61	Çarşıbaşı
820	61	Dernekpazarı
821	61	Düzköy
822	61	Hayrat
823	61	Köprübaşı / Trabzon
824	61	Ortahisar
825	62	Çemişgezek
826	62	Hozat
827	62	Mazgirt
828	62	Nazımiye
829	62	Ovacık / Tunceli
830	62	Pertek
831	62	Pülümür
832	62	Tunceli Merkez
833	63	Akçakale
834	63	Birecik
835	63	Bozova
836	63	Ceylanpınar
837	63	Halfeti
838	63	Hilvan
839	63	Siverek
840	63	Suruç
841	63	Viranşehir
842	63	Harran
843	63	Eyyübiye
844	63	Haliliye
845	63	Karaköprü
846	64	Banaz
847	64	Eşme
848	64	Karahallı
849	64	Sivaslı
850	64	Ulubey / Uşak
851	64	Uşak Merkez
852	65	Başkale
853	65	Çatak
854	65	Erciş
855	65	Gevaş
856	65	Gürpınar
857	65	Muradiye
858	65	Özalp
859	65	Bahçesaray
860	65	Çaldıran
861	65	Edremit / Van
862	65	Saray / Van
863	65	İpekyolu
864	65	Tuşba
865	66	Akdağmadeni
866	66	Boğazlıyan
867	66	Çayıralan
868	66	Çekerek
869	66	Sarıkaya
870	66	Sorgun
871	66	Şefaatli
872	66	Yerköy
873	66	Yozgat Merkez
874	66	Aydıncık / Yozgat
875	66	Çandır
876	66	Kadışehri
877	66	Saraykent
878	66	Yenifakılı
879	67	Çaycuma
880	67	Devrek
881	67	Ereğli / Zonguldak
882	67	Zonguldak Merkez
883	67	Alaplı
884	67	Gökçebey
885	68	Aksaray Merkez
886	68	Ortaköy / Aksaray
887	68	Ağaçören
888	68	Güzelyurt
889	68	Sarıyahşi
890	68	Eskil
891	68	Gülağaç
892	69	Bayburt Merkez
893	69	Aydıntepe
894	69	Demirözü
895	70	Ermenek
896	70	Karaman Merkez
897	70	Ayrancı
898	70	Kazımkarabekir
899	70	Başyayla
900	70	Sarıveliler
901	71	Delice
902	71	Keskin
903	71	Kırıkkale Merkez
904	71	Sulakyurt
905	71	Bahşili
906	71	Balışeyh
907	71	Çelebi
908	71	Karakeçili
909	71	Yahşihan
910	72	Batman Merkez
911	72	Beşiri
912	72	Gercüş
913	72	Kozluk
914	72	Sason
915	72	Hasankeyf
916	73	Beytüşşebap
917	73	Cizre
918	73	İdil
919	73	Silopi
920	73	Şırnak Merkez
921	73	Uludere
922	73	Güçlükonak
923	74	Bartın Merkez
924	74	Kurucaşile
925	74	Ulus
926	74	Amasra
927	75	Ardahan Merkez
928	75	Çıldır
929	75	Göle
930	75	Hanak
931	75	Posof
932	75	Damal
933	76	Aralık
934	76	Iğdır Merkez
935	76	Tuzluca
936	76	Karakoyunlu
937	77	Yalova Merkez
938	77	Altınova
939	77	Armutlu
940	77	Çınarcık
941	77	Çiftlikköy
942	77	Termal
943	78	Eflani
944	78	Eskipazar
945	78	Karabük Merkez
946	78	Ovacık / Karabük
947	78	Safranbolu
948	78	Yenice / Karabük
949	79	Kilis Merkez
950	79	Elbeyli
951	79	Musabeyli
952	79	Polateli
953	80	Bahçe
954	80	Kadirli
955	80	Osmaniye Merkez
956	80	Düziçi
957	80	Hasanbeyli
958	80	Sumbas
959	80	Toprakkale
960	81	Akçakoca
961	81	Düzce Merkez
962	81	Yığılca
963	81	Cumayeri
964	81	Gölyaka
965	81	Çilimli
966	81	Gümüşova
967	81	Kaynaşlı
\.


--
-- Name: gisModule_district_districtID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_district_districtID_seq"', 1, false);


--
-- Data for Name: gisModule_falsepriceproposal; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_falsepriceproposal" (id, status_code, created_at, updated_at, retailer_id, retailer_product_id, answer_count, send_count) FROM stdin;
\.


--
-- Name: gisModule_falsepriceproposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_falsepriceproposal_id_seq"', 36, true);


--
-- Data for Name: gisModule_friend; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_friend" (id, date, status, user_receiver_id, user_sender_id) FROM stdin;
\.


--
-- Name: gisModule_friend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_friend_id_seq"', 77, true);


--
-- Data for Name: gisModule_group; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_group" (id, name, date) FROM stdin;
\.


--
-- Name: gisModule_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_group_id_seq"', 119, true);


--
-- Data for Name: gisModule_groupmember; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_groupmember" (id, group_id, member_id, role_id, date) FROM stdin;
\.


--
-- Name: gisModule_groupmember_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_groupmember_id_seq"', 162, true);


--
-- Data for Name: gisModule_productgroup; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_productgroup" (id, name, parent_id) FROM stdin;
46	Clothing	\N
45	Fruits	44
44	Vegetables & Fruits	38
43	Vegetables	44
42	Bread	38
41	Soda	39
40	Milk	39
39	Beverages	37
38	Food	37
37	Food & Beverages	\N
47	Electronic	\N
\.


--
-- Name: gisModule_productgroup_productGroupID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_productgroup_productGroupID_seq"', 52, true);


--
-- Data for Name: gisModule_proposalsent; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_proposalsent" (id, created_at, updated_at, response, false_price_proposal_id, user_id) FROM stdin;
\.


--
-- Name: gisModule_proposalsent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_proposalsent_id_seq"', 65, true);


--
-- Data for Name: gisModule_retailer; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_retailer" (name, id, address, "cityID", "districtID", geolocation, zip_code, type_id, created_at, updated_at, reputation) FROM stdin;
Ankamall AVM	9	Ankamall, Akköprü, Konya Devlet Yolu Mevlana Bulvarı No:2, 06330 Yenimahalle/Ankara, Turkey	6	73	0101000020E61000004EED0C535B6A40408E01D9EBDDF94340	06330	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Atlantis AVM	10	Kardelen Mahallesi, Başkent Blv. 224 H, 06370 Yenimahalle/Ankara, Turkey	6	73	0101000020E61000002733DE567A5B4040F6CFD38041FC4340	06370	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Kentpark AVM	11	Mustafa Kemal Mahallesi, Eskişehir Yolu 7. Km No:164, 06800 Çankaya/Ankara, Turkey	6	63	0101000020E61000009F7D9BB45F634040F53D343D72F44340	06800	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Gordion AVM	12	Koru Mahallesi, Ankaralılar Cd. No:2, 06810 Çankaya/Ankara, Turkey	6	63	0101000020E610000012B00C60805840405EE7F05A53F34340	06810	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Panora AVM	13	No:182, Oran Mahallesi, Kudüs Cd., 06450 Çankaya/Ankara, Turkey	6	63	0101000020E6100000639CBF09856A404052D32EA699EC4340	06450	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Cepa AVM	15	Mustafa Kemal Mahallesi, CEPA AVM, 06510 Çankaya/Ankara, Turkey	6	63	0101000020E610000034DAAA24B2634040444C89247AF44340	06510	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Nata Vega	29	Akşemsettin Mahallesi, Nata Vega Outlet, 06480 Mamak/Ankara, Turkey	6	76	0101000020E61000001D21037976774040F148BC3C9DF14340	06480	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Arcadium AVM	30	Çayyolu Mahallesi, 2432. Cd (8. Cd.) No:192, 06810 Yenimahalle/Ankara, Turkey	6	73	0101000020E61000004983DBDAC2574040CFF9298E03F14340	06810	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Kızılay AVM	14	Kızılay Mahallesi, Gazi Mustafa Kemal Blv., 06420 Çankaya/Ankara, Turkey	6	63	0101000020E61000008E7340B73C6D4040E810DD58F5F54340	06420	2	2017-05-18 09:18:31.678298+03	2017-07-26 17:25:16.762114+03	500
Armada AVM	16	No:, Eskişehir Yolu (Dumlupınar Blv.) No:6, 06520, Turkey	\N	\N	0101000020E6100000AE9D2809896740401013C3C4D5F44340	06520	2	2017-05-18 09:18:31.678298+03	2017-09-03 23:25:09.394078+03	500
\.


--
-- Name: gisModule_retailer_retailerID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_retailer_retailerID_seq"', 31, true);


--
-- Data for Name: gisModule_retailerproduct; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_retailerproduct" (id, "unitPrice", "baseProduct_id", retailer_id, created_at, updated_at, blame_point, proposal_ongoing, removed_from_store) FROM stdin;
188	7	23	12	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
190	12	25	12	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
194	20	22	11	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
195	1	23	11	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
196	13	24	11	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
197	16	25	11	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
198	25	19	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
199	5	20	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
201	18	22	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
202	14	23	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
203	25	24	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
204	9	25	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
205	22	19	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
206	23	20	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
208	18	22	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
209	20	23	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
210	6	24	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
211	15	25	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
212	21	19	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
213	12	20	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
214	16	21	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
215	3	22	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
216	18	23	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
217	21	24	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
218	19	25	29	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
219	6	19	30	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
222	25	22	30	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
223	1	23	30	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
224	2	24	30	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
225	15	25	30	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
226	14	19	16	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
227	15	20	16	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
229	23	22	16	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
230	12	23	16	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
231	14	24	16	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
232	24	25	16	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
233	13	19	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
234	10	20	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
236	25	22	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
237	1	23	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
239	4	25	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
240	13	19	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
241	12	20	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
243	4	22	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
244	14	23	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
245	10	24	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
246	7	25	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
247	7	19	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
248	4	20	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
250	13	22	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
251	21	23	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
252	8	24	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
184	5	19	12	2017-05-18 09:18:31.806294+03	2017-07-14 16:29:50.212055+03	0	f	f
186	23	21	12	2017-05-18 09:18:31.806294+03	2017-07-14 16:51:50.995355+03	0	f	f
220	2	20	30	2017-05-18 09:18:31.806294+03	2017-07-14 16:53:44.304363+03	0	f	f
189	1	24	12	2017-05-18 09:18:31.806294+03	2017-07-25 20:52:35.069241+03	0	f	f
193	19	21	11	2017-05-18 09:18:31.806294+03	2017-07-21 09:28:29.081137+03	0	f	f
249	7	21	13	2017-05-18 09:18:31.806294+03	2017-09-03 23:27:42.931729+03	0	f	f
200	21	21	10	2017-05-18 09:18:31.806294+03	2017-09-03 23:16:35.681271+03	0	f	f
191	12	19	11	2017-05-18 09:18:31.806294+03	2017-07-25 20:52:40.985595+03	0	f	f
192	20	20	11	2017-05-18 09:18:31.806294+03	2017-07-25 20:52:46.112836+03	0	f	f
228	8	21	16	2017-05-18 09:18:31.806294+03	2017-09-03 23:25:09.396043+03	0	f	f
242	6	21	14	2017-05-18 09:18:31.806294+03	2017-09-03 23:01:46.699411+03	0	f	f
253	12	25	13	2017-05-18 09:18:31.806294+03	2017-07-25 20:51:25.917803+03	0	f	f
235	23	21	15	2017-05-18 09:18:31.806294+03	2017-09-03 23:19:47.756999+03	0	f	f
238	8	24	15	2017-05-18 09:18:31.806294+03	2017-07-25 20:51:51.584624+03	0	f	f
185	20	20	12	2017-05-18 09:18:31.806294+03	2017-07-25 20:52:23.36169+03	0	f	f
187	19	22	12	2017-05-18 09:18:31.806294+03	2017-07-25 20:52:29.890655+03	0	f	f
207	20	21	9	2017-05-18 09:18:31.806294+03	2017-09-03 23:10:25.124617+03	0	f	f
221	17	21	30	2017-05-18 09:18:31.806294+03	2017-09-03 23:13:00.754859+03	0	f	f
\.


--
-- Name: gisModule_retailerproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_retailerproduct_id_seq"', 258, true);


--
-- Data for Name: gisModule_retailertype; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_retailertype" ("retailerTypeID", "retailerTypeName") FROM stdin;
2	Shopping Center
1	Supermarket
\.


--
-- Name: gisModule_retailertype_retailerTypeID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_retailertype_retailerTypeID_seq"', 1, false);


--
-- Data for Name: gisModule_role; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_role" (id, name) FROM stdin;
1	Admin
2	Member
\.


--
-- Name: gisModule_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_role_id_seq"', 2, true);


--
-- Data for Name: gisModule_shoppinglist; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_shoppinglist" (id, created_at, completed, name, updated_at, completed_by_id, total_distance_cost, total_money_cost, total_time_cost) FROM stdin;
\.


--
-- Name: gisModule_shoppinglist_listID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_shoppinglist_listID_seq"', 81, true);


--
-- Data for Name: gisModule_shoppinglistitem; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_shoppinglistitem" (id, product_id, quantity, list_id, added_by_id, edited_by_id, is_purchased, unit_purchase_price, purchased_by_id, purchase_date, purchased_from_id) FROM stdin;
\.


--
-- Name: gisModule_shoppinglistitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_shoppinglistitems_id_seq"', 557, true);


--
-- Data for Name: gisModule_shoppinglistmember; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_shoppinglistmember" (id, list_id, user_id, role_id) FROM stdin;
\.


--
-- Data for Name: gisModule_user; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_user" (id, username, password, first_name, last_name, active_list_id, preferences_id, email, reputation, statistics_id) FROM stdin;
\.


--
-- Name: gisModule_user_userID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_user_userID_seq"', 25, true);


--
-- Data for Name: gisModule_userpreferences; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_userpreferences" (id, money_factor, dist_factor, time_factor, search_radius, route_end_point_id, route_start_point_id, get_notif_only_for_active_list, algorithm) FROM stdin;
\.


--
-- Name: gisModule_userpreferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_userpreferences_id_seq"', 25, true);


--
-- Data for Name: gisModule_usersavedaddress; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_usersavedaddress" (name, id, address, geolocation, zip_code, last_edit_time, city_id, district_id, user_id) FROM stdin;
\.


--
-- Name: gisModule_usersavedaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_usersavedaddress_id_seq"', 50, true);


--
-- Name: gisModule_usershoppinglist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_usershoppinglist_id_seq"', 95, true);


--
-- Data for Name: gisModule_userstatistics; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_userstatistics" (id, "moneySpent", "itemsBought", "shoppingListsComplete", "favoriteCategory", "favoriteProduct", blame_count, reputation, favorite_retailer) FROM stdin;
\.


--
-- Name: gisModule_userstatistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_userstatistics_id_seq"', 7, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


SET search_path = tiger, pg_catalog;

--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_rules (id, rule, is_custom) FROM stdin;
\.


SET search_path = topology, pg_catalog;

--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: background_task_completedtask background_task_completedtask_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task_completedtask
    ADD CONSTRAINT background_task_completedtask_pkey PRIMARY KEY (id);


--
-- Name: background_task background_task_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task
    ADD CONSTRAINT background_task_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: gisModule_baseproduct gisModule_baseproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_baseproduct"
    ADD CONSTRAINT "gisModule_baseproduct_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_blame gisModule_blame_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame"
    ADD CONSTRAINT "gisModule_blame_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_city gisModule_city_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_city"
    ADD CONSTRAINT "gisModule_city_pkey" PRIMARY KEY ("cityID");


--
-- Name: gisModule_district gisModule_district_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_district"
    ADD CONSTRAINT "gisModule_district_pkey" PRIMARY KEY ("districtID");


--
-- Name: gisModule_falsepriceproposal gisModule_falsepriceproposal_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal"
    ADD CONSTRAINT "gisModule_falsepriceproposal_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_friend gisModule_friend_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend"
    ADD CONSTRAINT "gisModule_friend_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_group gisModule_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_group"
    ADD CONSTRAINT "gisModule_group_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_groupmember gisModule_groupmember_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmember_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_productgroup gisModule_productgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_productgroup"
    ADD CONSTRAINT "gisModule_productgroup_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_proposalsent gisModule_proposalsent_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent"
    ADD CONSTRAINT "gisModule_proposalsent_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_retailer gisModule_retailer_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailer"
    ADD CONSTRAINT "gisModule_retailer_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_retailerproduct gisModule_retailerproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct"
    ADD CONSTRAINT "gisModule_retailerproduct_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_retailertype gisModule_retailertype_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailertype"
    ADD CONSTRAINT "gisModule_retailertype_pkey" PRIMARY KEY ("retailerTypeID");


--
-- Name: gisModule_role gisModule_role_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_role"
    ADD CONSTRAINT "gisModule_role_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_shoppinglist gisModule_shoppinglist_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglist"
    ADD CONSTRAINT "gisModule_shoppinglist_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_shoppinglistitem gisModule_shoppinglistitems_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppinglistitems_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_user gisModule_user_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModule_user_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_userpreferences gisModule_userpreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "gisModule_userpreferences_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_usersavedaddress gisModule_usersavedaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_usersavedaddress_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_shoppinglistmember gisModule_usershoppinglist_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppinglist_pkey" PRIMARY KEY (id);


--
-- Name: gisModule_userstatistics gisModule_userstatistics_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userstatistics"
    ADD CONSTRAINT "gisModule_userstatistics_pkey" PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: background_task_attempts_a9ade23d; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_attempts_a9ade23d ON background_task USING btree (attempts);


--
-- Name: background_task_completedtask_attempts_772a6783; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_attempts_772a6783 ON background_task_completedtask USING btree (attempts);


--
-- Name: background_task_completedtask_creator_content_type_id_21d6a741; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_creator_content_type_id_21d6a741 ON background_task_completedtask USING btree (creator_content_type_id);


--
-- Name: background_task_completedtask_failed_at_3de56618; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_failed_at_3de56618 ON background_task_completedtask USING btree (failed_at);


--
-- Name: background_task_completedtask_locked_at_29c62708; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_locked_at_29c62708 ON background_task_completedtask USING btree (locked_at);


--
-- Name: background_task_completedtask_locked_by_edc8a213; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213 ON background_task_completedtask USING btree (locked_by);


--
-- Name: background_task_completedtask_locked_by_edc8a213_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213_like ON background_task_completedtask USING btree (locked_by varchar_pattern_ops);


--
-- Name: background_task_completedtask_priority_9080692e; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_priority_9080692e ON background_task_completedtask USING btree (priority);


--
-- Name: background_task_completedtask_queue_61fb0415; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_queue_61fb0415 ON background_task_completedtask USING btree (queue);


--
-- Name: background_task_completedtask_queue_61fb0415_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_queue_61fb0415_like ON background_task_completedtask USING btree (queue varchar_pattern_ops);


--
-- Name: background_task_completedtask_run_at_77c80f34; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_run_at_77c80f34 ON background_task_completedtask USING btree (run_at);


--
-- Name: background_task_completedtask_task_hash_91187576; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_hash_91187576 ON background_task_completedtask USING btree (task_hash);


--
-- Name: background_task_completedtask_task_hash_91187576_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_hash_91187576_like ON background_task_completedtask USING btree (task_hash varchar_pattern_ops);


--
-- Name: background_task_completedtask_task_name_388dabc2; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_name_388dabc2 ON background_task_completedtask USING btree (task_name);


--
-- Name: background_task_completedtask_task_name_388dabc2_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_name_388dabc2_like ON background_task_completedtask USING btree (task_name varchar_pattern_ops);


--
-- Name: background_task_creator_content_type_id_61cc9af3; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_creator_content_type_id_61cc9af3 ON background_task USING btree (creator_content_type_id);


--
-- Name: background_task_failed_at_b81bba14; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_failed_at_b81bba14 ON background_task USING btree (failed_at);


--
-- Name: background_task_locked_at_0fb0f225; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_locked_at_0fb0f225 ON background_task USING btree (locked_at);


--
-- Name: background_task_locked_by_db7779e3; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_locked_by_db7779e3 ON background_task USING btree (locked_by);


--
-- Name: background_task_locked_by_db7779e3_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_locked_by_db7779e3_like ON background_task USING btree (locked_by varchar_pattern_ops);


--
-- Name: background_task_priority_88bdbce9; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_priority_88bdbce9 ON background_task USING btree (priority);


--
-- Name: background_task_queue_1d5f3a40; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_queue_1d5f3a40 ON background_task USING btree (queue);


--
-- Name: background_task_queue_1d5f3a40_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_queue_1d5f3a40_like ON background_task USING btree (queue varchar_pattern_ops);


--
-- Name: background_task_run_at_7baca3aa; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_run_at_7baca3aa ON background_task USING btree (run_at);


--
-- Name: background_task_task_hash_d8f233bd; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_hash_d8f233bd ON background_task USING btree (task_hash);


--
-- Name: background_task_task_hash_d8f233bd_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_hash_d8f233bd_like ON background_task USING btree (task_hash varchar_pattern_ops);


--
-- Name: background_task_task_name_4562d56a; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_name_4562d56a ON background_task USING btree (task_name);


--
-- Name: background_task_task_name_4562d56a_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_name_4562d56a_like ON background_task USING btree (task_name varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: gisModule_baseproduct_group_id_34e261a7; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_baseproduct_group_id_34e261a7" ON "gisModule_baseproduct" USING btree (group_id);


--
-- Name: gisModule_blame_retailer_product_id_4f9417eb; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_blame_retailer_product_id_4f9417eb" ON "gisModule_blame" USING btree (retailer_product_id);


--
-- Name: gisModule_blame_user_id_0e32af77; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_blame_user_id_0e32af77" ON "gisModule_blame" USING btree (user_id);


--
-- Name: gisModule_falsepriceproposal_retailer_id_9efb6d70; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_falsepriceproposal_retailer_id_9efb6d70" ON "gisModule_falsepriceproposal" USING btree (retailer_id);


--
-- Name: gisModule_falsepriceproposal_retailer_product_id_c575feec; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_falsepriceproposal_retailer_product_id_c575feec" ON "gisModule_falsepriceproposal" USING btree (retailer_product_id);


--
-- Name: gisModule_friend_user_receiver_id_0dfa7f87; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_friend_user_receiver_id_0dfa7f87" ON "gisModule_friend" USING btree (user_receiver_id);


--
-- Name: gisModule_friend_user_sender_id_446949ef; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_friend_user_sender_id_446949ef" ON "gisModule_friend" USING btree (user_sender_id);


--
-- Name: gisModule_groupmember_group_id_a23c8021; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_groupmember_group_id_a23c8021" ON "gisModule_groupmember" USING btree (group_id);


--
-- Name: gisModule_groupmember_member_id_35fb15d9; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_groupmember_member_id_35fb15d9" ON "gisModule_groupmember" USING btree (member_id);


--
-- Name: gisModule_groupmember_role_id_b77dd803; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_groupmember_role_id_b77dd803" ON "gisModule_groupmember" USING btree (role_id);


--
-- Name: gisModule_productgroup_parent_id_18a9ee55; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_productgroup_parent_id_18a9ee55" ON "gisModule_productgroup" USING btree (parent_id);


--
-- Name: gisModule_proposalsent_false_price_proposal_id_32dbe274; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_proposalsent_false_price_proposal_id_32dbe274" ON "gisModule_proposalsent" USING btree (false_price_proposal_id);


--
-- Name: gisModule_proposalsent_user_id_678622bf; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_proposalsent_user_id_678622bf" ON "gisModule_proposalsent" USING btree (user_id);


--
-- Name: gisModule_retailer_165eadd0; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailer_165eadd0" ON "gisModule_retailer" USING btree (type_id);


--
-- Name: gisModule_retailer_geoLocation_id; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailer_geoLocation_id" ON "gisModule_retailer" USING gist (geolocation);


--
-- Name: gisModule_retailerproduct_d3f2996a; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailerproduct_d3f2996a" ON "gisModule_retailerproduct" USING btree ("baseProduct_id");


--
-- Name: gisModule_retailerproduct_da9bf8d8; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailerproduct_da9bf8d8" ON "gisModule_retailerproduct" USING btree (retailer_id);


--
-- Name: gisModule_shoppinglist_completed_by_id_5ad67889; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglist_completed_by_id_5ad67889" ON "gisModule_shoppinglist" USING btree (completed_by_id);


--
-- Name: gisModule_shoppinglistitem_addedBy_id_adc4d554; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_addedBy_id_adc4d554" ON "gisModule_shoppinglistitem" USING btree (added_by_id);


--
-- Name: gisModule_shoppinglistitem_edited_by_id_40fabd33; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_edited_by_id_40fabd33" ON "gisModule_shoppinglistitem" USING btree (edited_by_id);


--
-- Name: gisModule_shoppinglistitem_list_id_5c453dbd; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_list_id_5c453dbd" ON "gisModule_shoppinglistitem" USING btree (list_id);


--
-- Name: gisModule_shoppinglistitem_productID_id_653c920a; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_productID_id_653c920a" ON "gisModule_shoppinglistitem" USING btree (product_id);


--
-- Name: gisModule_shoppinglistitem_purchased_by_id_169ce658; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_purchased_by_id_169ce658" ON "gisModule_shoppinglistitem" USING btree (purchased_by_id);


--
-- Name: gisModule_shoppinglistitem_purchased_from_id_228476f6; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_purchased_from_id_228476f6" ON "gisModule_shoppinglistitem" USING btree (purchased_from_id);


--
-- Name: gisModule_user_activeList_id_295659b1; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_user_activeList_id_295659b1" ON "gisModule_user" USING btree (active_list_id);


--
-- Name: gisModule_user_e7a82d8e; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_user_e7a82d8e" ON "gisModule_user" USING btree (preferences_id);


--
-- Name: gisModule_user_statistics_id_66f3485f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_user_statistics_id_66f3485f" ON "gisModule_user" USING btree (statistics_id);


--
-- Name: gisModule_userpreferences_625a3d6f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_userpreferences_625a3d6f" ON "gisModule_userpreferences" USING btree (route_end_point_id);


--
-- Name: gisModule_userpreferences_6b4166f7; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_userpreferences_6b4166f7" ON "gisModule_userpreferences" USING btree (route_start_point_id);


--
-- Name: gisModule_usersavedaddress_a34a99d3; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_a34a99d3" ON "gisModule_usersavedaddress" USING btree (district_id);


--
-- Name: gisModule_usersavedaddress_c7141997; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_c7141997" ON "gisModule_usersavedaddress" USING btree (city_id);


--
-- Name: gisModule_usersavedaddress_geoLocation_id; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_geoLocation_id" ON "gisModule_usersavedaddress" USING gist (geolocation);


--
-- Name: gisModule_usersavedaddress_user_id_fffb5670; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_user_id_fffb5670" ON "gisModule_usersavedaddress" USING btree (user_id);


--
-- Name: gisModule_usershoppinglist_role_id_151e7ed5; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usershoppinglist_role_id_151e7ed5" ON "gisModule_shoppinglistmember" USING btree (role_id);


--
-- Name: gisModule_usershoppinglist_shoppingList_id_dc541570; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usershoppinglist_shoppingList_id_dc541570" ON "gisModule_shoppinglistmember" USING btree (list_id);


--
-- Name: gisModule_usershoppinglist_user_id_ddc92d37; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usershoppinglist_user_id_ddc92d37" ON "gisModule_shoppinglistmember" USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: background_task_completedtask background_task_comp_creator_content_type_21d6a741_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task_completedtask
    ADD CONSTRAINT background_task_comp_creator_content_type_21d6a741_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: background_task background_task_creator_content_type_61cc9af3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task
    ADD CONSTRAINT background_task_creator_content_type_61cc9af3_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_userpreferences gi_route_end_point_id_82643daa_fk_gisModule_usersavedaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "gi_route_end_point_id_82643daa_fk_gisModule_usersavedaddress_id" FOREIGN KEY (route_end_point_id) REFERENCES "gisModule_usersavedaddress"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_retailerproduct gisM_baseProduct_id_8c637d4a_fk_gisModule_baseproduct_productID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct"
    ADD CONSTRAINT "gisM_baseProduct_id_8c637d4a_fk_gisModule_baseproduct_productID" FOREIGN KEY ("baseProduct_id") REFERENCES "gisModule_baseproduct"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_user gisModu_preferences_id_b607083d_fk_gisModule_userpreferences_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModu_preferences_id_b607083d_fk_gisModule_userpreferences_id" FOREIGN KEY (preferences_id) REFERENCES "gisModule_userpreferences"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_baseproduct gisModule_baseproduc_group_id_34e261a7_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_baseproduct"
    ADD CONSTRAINT "gisModule_baseproduc_group_id_34e261a7_fk_gisModule" FOREIGN KEY (group_id) REFERENCES "gisModule_productgroup"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_blame gisModule_blame_retailer_product_id_4f9417eb_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame"
    ADD CONSTRAINT "gisModule_blame_retailer_product_id_4f9417eb_fk_gisModule" FOREIGN KEY (retailer_product_id) REFERENCES "gisModule_retailerproduct"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_blame gisModule_blame_user_id_0e32af77_fk_gisModule_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame"
    ADD CONSTRAINT "gisModule_blame_user_id_0e32af77_fk_gisModule_user_id" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_usersavedaddress gisModule_district_id_e1e5f4da_fk_gisModule_district_districtID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_district_id_e1e5f4da_fk_gisModule_district_districtID" FOREIGN KEY (district_id) REFERENCES "gisModule_district"("districtID") DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_falsepriceproposal gisModule_falseprice_retailer_id_9efb6d70_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal"
    ADD CONSTRAINT "gisModule_falseprice_retailer_id_9efb6d70_fk_gisModule" FOREIGN KEY (retailer_id) REFERENCES "gisModule_retailer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_falsepriceproposal gisModule_falseprice_retailer_product_id_c575feec_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal"
    ADD CONSTRAINT "gisModule_falseprice_retailer_product_id_c575feec_fk_gisModule" FOREIGN KEY (retailer_product_id) REFERENCES "gisModule_retailerproduct"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_friend gisModule_friend_user_receiver_id_0dfa7f87_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend"
    ADD CONSTRAINT "gisModule_friend_user_receiver_id_0dfa7f87_fk_gisModule" FOREIGN KEY (user_receiver_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_friend gisModule_friend_user_sender_id_446949ef_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend"
    ADD CONSTRAINT "gisModule_friend_user_sender_id_446949ef_fk_gisModule" FOREIGN KEY (user_sender_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_groupmember gisModule_groupmembe_member_id_35fb15d9_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmembe_member_id_35fb15d9_fk_gisModule" FOREIGN KEY (member_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_groupmember gisModule_groupmember_group_id_a23c8021_fk_gisModule_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmember_group_id_a23c8021_fk_gisModule_group_id" FOREIGN KEY (group_id) REFERENCES "gisModule_group"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_groupmember gisModule_groupmember_role_id_b77dd803_fk_gisModule_role_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmember_role_id_b77dd803_fk_gisModule_role_id" FOREIGN KEY (role_id) REFERENCES "gisModule_role"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_productgroup gisModule_productgro_parent_id_18a9ee55_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_productgroup"
    ADD CONSTRAINT "gisModule_productgro_parent_id_18a9ee55_fk_gisModule" FOREIGN KEY (parent_id) REFERENCES "gisModule_productgroup"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_proposalsent gisModule_proposalse_false_price_proposal_32dbe274_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent"
    ADD CONSTRAINT "gisModule_proposalse_false_price_proposal_32dbe274_fk_gisModule" FOREIGN KEY (false_price_proposal_id) REFERENCES "gisModule_falsepriceproposal"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_proposalsent gisModule_proposalsent_user_id_678622bf_fk_gisModule_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent"
    ADD CONSTRAINT "gisModule_proposalsent_user_id_678622bf_fk_gisModule_user_id" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_retailerproduct gisModule_retailer_id_2bd4aec7_fk_gisModule_retailer_retailerID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct"
    ADD CONSTRAINT "gisModule_retailer_id_2bd4aec7_fk_gisModule_retailer_retailerID" FOREIGN KEY (retailer_id) REFERENCES "gisModule_retailer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_retailer gisModule_retailer_type_id_525ded2f_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailer"
    ADD CONSTRAINT "gisModule_retailer_type_id_525ded2f_fk_gisModule" FOREIGN KEY (type_id) REFERENCES "gisModule_retailertype"("retailerTypeID") DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_added_by_id_0f7923ec_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_added_by_id_0f7923ec_fk_gisModule" FOREIGN KEY (added_by_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglist gisModule_shoppingli_completed_by_id_5ad67889_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglist"
    ADD CONSTRAINT "gisModule_shoppingli_completed_by_id_5ad67889_fk_gisModule" FOREIGN KEY (completed_by_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_edited_by_id_40fabd33_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_edited_by_id_40fabd33_fk_gisModule" FOREIGN KEY (edited_by_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_list_id_5c453dbd_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_list_id_5c453dbd_fk_gisModule" FOREIGN KEY (list_id) REFERENCES "gisModule_shoppinglist"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_product_id_aaf576f5_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_product_id_aaf576f5_fk_gisModule" FOREIGN KEY (product_id) REFERENCES "gisModule_baseproduct"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_purchased_by_id_169ce658_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_purchased_by_id_169ce658_fk_gisModule" FOREIGN KEY (purchased_by_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_purchased_from_id_228476f6_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_purchased_from_id_228476f6_fk_gisModule" FOREIGN KEY (purchased_from_id) REFERENCES "gisModule_retailer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_user gisModule_user_active_list_id_0d34e0fd_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModule_user_active_list_id_0d34e0fd_fk_gisModule" FOREIGN KEY (active_list_id) REFERENCES "gisModule_shoppinglist"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_user gisModule_user_statistics_id_66f3485f_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModule_user_statistics_id_66f3485f_fk_gisModule" FOREIGN KEY (statistics_id) REFERENCES "gisModule_userstatistics"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_usersavedaddress gisModule_usersaveda_user_id_fffb5670_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_usersaveda_user_id_fffb5670_fk_gisModule" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_usersavedaddress gisModule_usersavedad_city_id_75469ff6_fk_gisModule_city_cityID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_usersavedad_city_id_75469ff6_fk_gisModule_city_cityID" FOREIGN KEY (city_id) REFERENCES "gisModule_city"("cityID") DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistmember gisModule_usershoppi_list_id_5590f197_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppi_list_id_5590f197_fk_gisModule" FOREIGN KEY (list_id) REFERENCES "gisModule_shoppinglist"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistmember gisModule_usershoppi_role_id_151e7ed5_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppi_role_id_151e7ed5_fk_gisModule" FOREIGN KEY (role_id) REFERENCES "gisModule_role"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_shoppinglistmember gisModule_usershoppi_user_id_ddc92d37_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppi_user_id_ddc92d37_fk_gisModule" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gisModule_userpreferences route_start_point_id_d14e5950_fk_gisModule_usersavedaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "route_start_point_id_d14e5950_fk_gisModule_usersavedaddress_id" FOREIGN KEY (route_start_point_id) REFERENCES "gisModule_usersavedaddress"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\connect gisdb

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO dyanikoglu;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO dyanikoglu;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO dyanikoglu;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


SET search_path = tiger, pg_catalog;

--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_rules (id, rule, is_custom) FROM stdin;
\.


SET search_path = topology, pg_catalog;

--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- PostgreSQL database dump complete
--

\connect temp_db

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

