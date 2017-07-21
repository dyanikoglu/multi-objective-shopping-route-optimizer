--
-- PostgreSQL database cluster dump
--

-- Started on 2017-07-21 10:42:13 +03

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

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-07-21 10:42:13 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 12 (class 2615 OID 26426)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO dyanikoglu;

--
-- TOC entry 11 (class 2615 OID 26427)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO dyanikoglu;

--
-- TOC entry 9 (class 2615 OID 26428)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO dyanikoglu;

--
-- TOC entry 1 (class 3079 OID 12429)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 6 (class 3079 OID 26429)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 5 (class 3079 OID 26440)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 4 (class 3079 OID 27916)
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- TOC entry 2 (class 3079 OID 28071)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 3 (class 3079 OID 28498)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 268 (class 1259 OID 28639)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO dyanikoglu;

--
-- TOC entry 269 (class 1259 OID 28642)
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
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 269
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- TOC entry 270 (class 1259 OID 28644)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO dyanikoglu;

--
-- TOC entry 271 (class 1259 OID 28647)
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
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 271
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- TOC entry 272 (class 1259 OID 28649)
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
-- TOC entry 273 (class 1259 OID 28652)
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
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 273
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- TOC entry 274 (class 1259 OID 28654)
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
-- TOC entry 275 (class 1259 OID 28660)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO dyanikoglu;

--
-- TOC entry 276 (class 1259 OID 28663)
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
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 276
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- TOC entry 277 (class 1259 OID 28665)
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
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 277
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- TOC entry 278 (class 1259 OID 28667)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO dyanikoglu;

--
-- TOC entry 279 (class 1259 OID 28670)
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
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 279
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- TOC entry 326 (class 1259 OID 29346)
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
-- TOC entry 324 (class 1259 OID 29334)
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
-- TOC entry 323 (class 1259 OID 29332)
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
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 323
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE background_task_completedtask_id_seq OWNED BY background_task_completedtask.id;


--
-- TOC entry 325 (class 1259 OID 29344)
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
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 325
-- Name: background_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE background_task_id_seq OWNED BY background_task.id;


--
-- TOC entry 280 (class 1259 OID 28672)
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
-- TOC entry 281 (class 1259 OID 28679)
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
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 281
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- TOC entry 282 (class 1259 OID 28681)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO dyanikoglu;

--
-- TOC entry 283 (class 1259 OID 28684)
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
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 283
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- TOC entry 284 (class 1259 OID 28686)
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
-- TOC entry 285 (class 1259 OID 28692)
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
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 285
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- TOC entry 286 (class 1259 OID 28694)
-- Name: django_session; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO dyanikoglu;

--
-- TOC entry 287 (class 1259 OID 28700)
-- Name: gisModule_baseproduct; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_baseproduct" (
    "productID" integer NOT NULL,
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
-- TOC entry 288 (class 1259 OID 28704)
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
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 288
-- Name: gisModule_baseproduct_productID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_baseproduct_productID_seq" OWNED BY "gisModule_baseproduct"."productID";


--
-- TOC entry 322 (class 1259 OID 29257)
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
-- TOC entry 321 (class 1259 OID 29255)
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
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 321
-- Name: gisModule_blame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_blame_id_seq" OWNED BY "gisModule_blame".id;


--
-- TOC entry 289 (class 1259 OID 28706)
-- Name: gisModule_city; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_city" (
    "cityID" integer NOT NULL,
    "cityName" character varying(64) NOT NULL
);


ALTER TABLE "gisModule_city" OWNER TO dyanikoglu;

--
-- TOC entry 290 (class 1259 OID 28709)
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
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 290
-- Name: gisModule_city_cityID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_city_cityID_seq" OWNED BY "gisModule_city"."cityID";


--
-- TOC entry 291 (class 1259 OID 28711)
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
-- TOC entry 292 (class 1259 OID 28715)
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
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 292
-- Name: gisModule_district_districtID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_district_districtID_seq" OWNED BY "gisModule_district"."districtID";


--
-- TOC entry 328 (class 1259 OID 29396)
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
-- TOC entry 327 (class 1259 OID 29394)
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
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 327
-- Name: gisModule_falsepriceproposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_falsepriceproposal_id_seq" OWNED BY "gisModule_falsepriceproposal".id;


--
-- TOC entry 314 (class 1259 OID 29097)
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
-- TOC entry 313 (class 1259 OID 29095)
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
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 313
-- Name: gisModule_friend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_friend_id_seq" OWNED BY "gisModule_friend".id;


--
-- TOC entry 316 (class 1259 OID 29105)
-- Name: gisModule_group; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_group" (
    id integer NOT NULL,
    name character varying(64),
    date timestamp with time zone NOT NULL
);


ALTER TABLE "gisModule_group" OWNER TO dyanikoglu;

--
-- TOC entry 315 (class 1259 OID 29103)
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
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 315
-- Name: gisModule_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_group_id_seq" OWNED BY "gisModule_group".id;


--
-- TOC entry 318 (class 1259 OID 29113)
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
-- TOC entry 317 (class 1259 OID 29111)
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
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 317
-- Name: gisModule_groupmember_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_groupmember_id_seq" OWNED BY "gisModule_groupmember".id;


--
-- TOC entry 293 (class 1259 OID 28717)
-- Name: gisModule_productgroup; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_productgroup" (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    parent_id integer
);


ALTER TABLE "gisModule_productgroup" OWNER TO dyanikoglu;

--
-- TOC entry 294 (class 1259 OID 28723)
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
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 294
-- Name: gisModule_productgroup_productGroupID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_productgroup_productGroupID_seq" OWNED BY "gisModule_productgroup".id;


--
-- TOC entry 330 (class 1259 OID 29404)
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
-- TOC entry 329 (class 1259 OID 29402)
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
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 329
-- Name: gisModule_proposalsent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_proposalsent_id_seq" OWNED BY "gisModule_proposalsent".id;


--
-- TOC entry 295 (class 1259 OID 28725)
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
-- TOC entry 296 (class 1259 OID 28733)
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
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 296
-- Name: gisModule_retailer_retailerID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_retailer_retailerID_seq" OWNED BY "gisModule_retailer".id;


--
-- TOC entry 297 (class 1259 OID 28735)
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
-- TOC entry 298 (class 1259 OID 28738)
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
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 298
-- Name: gisModule_retailerproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_retailerproduct_id_seq" OWNED BY "gisModule_retailerproduct".id;


--
-- TOC entry 299 (class 1259 OID 28740)
-- Name: gisModule_retailertype; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_retailertype" (
    "retailerTypeID" integer NOT NULL,
    "retailerTypeName" character varying(128) NOT NULL
);


ALTER TABLE "gisModule_retailertype" OWNER TO dyanikoglu;

--
-- TOC entry 300 (class 1259 OID 28743)
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
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 300
-- Name: gisModule_retailertype_retailerTypeID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_retailertype_retailerTypeID_seq" OWNED BY "gisModule_retailertype"."retailerTypeID";


--
-- TOC entry 320 (class 1259 OID 29121)
-- Name: gisModule_role; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_role" (
    id integer NOT NULL,
    name character varying(64)
);


ALTER TABLE "gisModule_role" OWNER TO dyanikoglu;

--
-- TOC entry 319 (class 1259 OID 29119)
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
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 319
-- Name: gisModule_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_role_id_seq" OWNED BY "gisModule_role".id;


--
-- TOC entry 301 (class 1259 OID 28745)
-- Name: gisModule_shoppinglist; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_shoppinglist" (
    id integer NOT NULL,
    created_at timestamp with time zone,
    completed boolean NOT NULL,
    name character varying(64) NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE "gisModule_shoppinglist" OWNER TO dyanikoglu;

--
-- TOC entry 302 (class 1259 OID 28748)
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
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 302
-- Name: gisModule_shoppinglist_listID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_shoppinglist_listID_seq" OWNED BY "gisModule_shoppinglist".id;


--
-- TOC entry 303 (class 1259 OID 28750)
-- Name: gisModule_shoppinglistitem; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_shoppinglistitem" (
    id integer NOT NULL,
    product_id integer,
    quantity integer NOT NULL,
    list_id integer,
    "addedBy_id" integer,
    edited_by_id integer,
    CONSTRAINT "gisModule_shoppinglistitems_quantity_check" CHECK ((quantity >= 0))
);


ALTER TABLE "gisModule_shoppinglistitem" OWNER TO dyanikoglu;

--
-- TOC entry 304 (class 1259 OID 28754)
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
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 304
-- Name: gisModule_shoppinglistitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_shoppinglistitems_id_seq" OWNED BY "gisModule_shoppinglistitem".id;


--
-- TOC entry 311 (class 1259 OID 28783)
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
-- TOC entry 305 (class 1259 OID 28761)
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
    reputation double precision NOT NULL
);


ALTER TABLE "gisModule_user" OWNER TO dyanikoglu;

--
-- TOC entry 306 (class 1259 OID 28767)
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
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 306
-- Name: gisModule_user_userID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_user_userID_seq" OWNED BY "gisModule_user".id;


--
-- TOC entry 307 (class 1259 OID 28769)
-- Name: gisModule_userpreferences; Type: TABLE; Schema: public; Owner: dyanikoglu
--

CREATE TABLE "gisModule_userpreferences" (
    id integer NOT NULL,
    money_factor boolean NOT NULL,
    dist_factor boolean NOT NULL,
    time_factor boolean NOT NULL,
    search_radius integer,
    route_end_point_id integer,
    route_start_point_id integer,
    get_notif_only_for_active_list boolean NOT NULL,
    owner_id integer,
    CONSTRAINT "gisModule_userpreferences_search_radius_check" CHECK ((search_radius >= 0))
);


ALTER TABLE "gisModule_userpreferences" OWNER TO dyanikoglu;

--
-- TOC entry 308 (class 1259 OID 28773)
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
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 308
-- Name: gisModule_userpreferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_userpreferences_id_seq" OWNED BY "gisModule_userpreferences".id;


--
-- TOC entry 309 (class 1259 OID 28775)
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
-- TOC entry 310 (class 1259 OID 28781)
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
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 310
-- Name: gisModule_usersavedaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_usersavedaddress_id_seq" OWNED BY "gisModule_usersavedaddress".id;


--
-- TOC entry 312 (class 1259 OID 28786)
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
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 312
-- Name: gisModule_usershoppinglist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dyanikoglu
--

ALTER SEQUENCE "gisModule_usershoppinglist_id_seq" OWNED BY "gisModule_shoppinglistmember".id;


--
-- TOC entry 4204 (class 2604 OID 28788)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- TOC entry 4205 (class 2604 OID 28789)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 4206 (class 2604 OID 28790)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- TOC entry 4207 (class 2604 OID 28791)
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- TOC entry 4208 (class 2604 OID 28792)
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- TOC entry 4209 (class 2604 OID 28793)
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 4240 (class 2604 OID 29349)
-- Name: background_task id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task ALTER COLUMN id SET DEFAULT nextval('background_task_id_seq'::regclass);


--
-- TOC entry 4238 (class 2604 OID 29337)
-- Name: background_task_completedtask id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task_completedtask ALTER COLUMN id SET DEFAULT nextval('background_task_completedtask_id_seq'::regclass);


--
-- TOC entry 4210 (class 2604 OID 28794)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- TOC entry 4212 (class 2604 OID 28795)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- TOC entry 4213 (class 2604 OID 28796)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- TOC entry 4214 (class 2604 OID 28797)
-- Name: gisModule_baseproduct productID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_baseproduct" ALTER COLUMN "productID" SET DEFAULT nextval('"gisModule_baseproduct_productID_seq"'::regclass);


--
-- TOC entry 4237 (class 2604 OID 29260)
-- Name: gisModule_blame id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame" ALTER COLUMN id SET DEFAULT nextval('"gisModule_blame_id_seq"'::regclass);


--
-- TOC entry 4216 (class 2604 OID 28798)
-- Name: gisModule_city cityID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_city" ALTER COLUMN "cityID" SET DEFAULT nextval('"gisModule_city_cityID_seq"'::regclass);


--
-- TOC entry 4217 (class 2604 OID 28799)
-- Name: gisModule_district districtID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_district" ALTER COLUMN "districtID" SET DEFAULT nextval('"gisModule_district_districtID_seq"'::regclass);


--
-- TOC entry 4242 (class 2604 OID 29399)
-- Name: gisModule_falsepriceproposal id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal" ALTER COLUMN id SET DEFAULT nextval('"gisModule_falsepriceproposal_id_seq"'::regclass);


--
-- TOC entry 4233 (class 2604 OID 29100)
-- Name: gisModule_friend id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend" ALTER COLUMN id SET DEFAULT nextval('"gisModule_friend_id_seq"'::regclass);


--
-- TOC entry 4234 (class 2604 OID 29108)
-- Name: gisModule_group id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_group" ALTER COLUMN id SET DEFAULT nextval('"gisModule_group_id_seq"'::regclass);


--
-- TOC entry 4235 (class 2604 OID 29116)
-- Name: gisModule_groupmember id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember" ALTER COLUMN id SET DEFAULT nextval('"gisModule_groupmember_id_seq"'::regclass);


--
-- TOC entry 4219 (class 2604 OID 28800)
-- Name: gisModule_productgroup id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_productgroup" ALTER COLUMN id SET DEFAULT nextval('"gisModule_productgroup_productGroupID_seq"'::regclass);


--
-- TOC entry 4243 (class 2604 OID 29407)
-- Name: gisModule_proposalsent id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent" ALTER COLUMN id SET DEFAULT nextval('"gisModule_proposalsent_id_seq"'::regclass);


--
-- TOC entry 4220 (class 2604 OID 28801)
-- Name: gisModule_retailer id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailer" ALTER COLUMN id SET DEFAULT nextval('"gisModule_retailer_retailerID_seq"'::regclass);


--
-- TOC entry 4223 (class 2604 OID 28802)
-- Name: gisModule_retailerproduct id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct" ALTER COLUMN id SET DEFAULT nextval('"gisModule_retailerproduct_id_seq"'::regclass);


--
-- TOC entry 4224 (class 2604 OID 28803)
-- Name: gisModule_retailertype retailerTypeID; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailertype" ALTER COLUMN "retailerTypeID" SET DEFAULT nextval('"gisModule_retailertype_retailerTypeID_seq"'::regclass);


--
-- TOC entry 4236 (class 2604 OID 29124)
-- Name: gisModule_role id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_role" ALTER COLUMN id SET DEFAULT nextval('"gisModule_role_id_seq"'::regclass);


--
-- TOC entry 4225 (class 2604 OID 28804)
-- Name: gisModule_shoppinglist id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglist" ALTER COLUMN id SET DEFAULT nextval('"gisModule_shoppinglist_listID_seq"'::regclass);


--
-- TOC entry 4226 (class 2604 OID 28805)
-- Name: gisModule_shoppinglistitem id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem" ALTER COLUMN id SET DEFAULT nextval('"gisModule_shoppinglistitems_id_seq"'::regclass);


--
-- TOC entry 4232 (class 2604 OID 28810)
-- Name: gisModule_shoppinglistmember id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember" ALTER COLUMN id SET DEFAULT nextval('"gisModule_usershoppinglist_id_seq"'::regclass);


--
-- TOC entry 4228 (class 2604 OID 28807)
-- Name: gisModule_user id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user" ALTER COLUMN id SET DEFAULT nextval('"gisModule_user_userID_seq"'::regclass);


--
-- TOC entry 4229 (class 2604 OID 28808)
-- Name: gisModule_userpreferences id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences" ALTER COLUMN id SET DEFAULT nextval('"gisModule_userpreferences_id_seq"'::regclass);


--
-- TOC entry 4231 (class 2604 OID 28809)
-- Name: gisModule_usersavedaddress id; Type: DEFAULT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress" ALTER COLUMN id SET DEFAULT nextval('"gisModule_usersavedaddress_id_seq"'::regclass);


--
-- TOC entry 4562 (class 0 OID 28639)
-- Dependencies: 268
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 269
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- TOC entry 4564 (class 0 OID 28644)
-- Dependencies: 270
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 271
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 4566 (class 0 OID 28649)
-- Dependencies: 272
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
\.


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 273
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_permission_id_seq', 123, true);


--
-- TOC entry 4568 (class 0 OID 28654)
-- Dependencies: 274
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$Tt7QrdY0KPNH$8j5KWJcL4b8Xf/jMMypAnoxeF0XcgiCLAwPGVqTMjNc=	2017-07-21 09:31:32.665307+03	t	dyanikoglu	Doğa Can	Yanıkoğlu	dyanikoglu@outlook.com	t	t	2017-01-26 11:49:05+03
\.


--
-- TOC entry 4569 (class 0 OID 28660)
-- Dependencies: 275
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 276
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 277
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- TOC entry 4572 (class 0 OID 28667)
-- Dependencies: 278
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 279
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 4620 (class 0 OID 29346)
-- Dependencies: 326
-- Data for Name: background_task; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY background_task (id, task_name, task_params, task_hash, verbose_name, priority, run_at, repeat, repeat_until, queue, attempts, failed_at, last_error, locked_by, locked_at, creator_object_id, creator_content_type_id) FROM stdin;
1068	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:22:24.644885+03	30	\N	\N	0	\N		\N	\N	\N	\N
1069	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:22:24.648618+03	30	\N	\N	0	\N		\N	\N	\N	\N
\.


--
-- TOC entry 4618 (class 0 OID 29334)
-- Dependencies: 324
-- Data for Name: background_task_completedtask; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY background_task_completedtask (id, task_name, task_params, task_hash, verbose_name, priority, run_at, repeat, repeat_until, queue, attempts, failed_at, last_error, locked_by, locked_at, creator_object_id, creator_content_type_id) FROM stdin;
27	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:09:11.545784+03	10	\N	\N	1	\N		17665	2017-07-15 14:09:11.485886+03	\N	\N
28	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:09:13.064863+03	15	\N	\N	1	\N		17665	2017-07-15 14:09:13.042108+03	\N	\N
29	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:09:19.081437+03	10	\N	\N	1	\N		17665	2017-07-15 14:09:19.060995+03	\N	\N
30	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:09:31.05545+03	10	\N	\N	1	\N		17665	2017-07-15 14:09:31.034828+03	\N	\N
31	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:02.080254+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:02.055897+03	\N	\N
32	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:02.909061+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:02.882175+03	\N	\N
33	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:04.297871+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:04.275774+03	\N	\N
34	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:12:04.902966+03	15	\N	\N	1	\N		17920	2017-07-15 14:12:04.881194+03	\N	\N
72	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:51.257441+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:51.236241+03	\N	\N
73	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:52.689302+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:52.663926+03	\N	\N
74	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:58.486967+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:58.423136+03	\N	\N
75	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:59.161097+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:59.124353+03	\N	\N
76	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:24:10.584127+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:10.560865+03	\N	\N
35	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:12:06.106704+03	15	\N	\N	3	\N	Traceback (most recent call last):\n  File "/home/dyanikoglu/anaconda3/lib/python3.6/site-packages/background_task/tasks.py", line 44, in bg_runner\n    func(*args, **kwargs)\n  File "/home/dyanikoglu/PycharmProjects/multi-objective-shopping-route-optimizer/gisModule/tasks.py", line 17, in blame_module_check_proposal\n    handler.check_proposal(proposal)\n  File "/home/dyanikoglu/PycharmProjects/multi-objective-shopping-route-optimizer/BlameModule/event_handler.py", line 43, in check_proposal\n    send_proposals(proposal)  # Send new ones\n  File "/home/dyanikoglu/anaconda3/lib/python3.6/contextlib.py", line 53, in inner\n    return func(*args, **kwds)\n  File "/home/dyanikoglu/PycharmProjects/multi-objective-shopping-route-optimizer/BlameModule/event_handler.py", line 56, in send_proposals\n    tools.propose_to_random_users(proposal, parameters.USER_COUNT_TO_SEND_PROPOSAL - proposal.send_count)\n  File "/home/dyanikoglu/anaconda3/lib/python3.6/contextlib.py", line 53, in inner\n    return func(*args, **kwds)\n  File "/home/dyanikoglu/PycharmProjects/multi-objective-shopping-route-optimizer/BlameModule/tools.py", line 51, in propose_to_random_users\n    users.remove(proposal_sent.user)\nAttributeError: 'QuerySet' object has no attribute 'remove'\n	17920	2017-07-15 14:12:06.086883+03	\N	\N
36	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:06.849547+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:06.824222+03	\N	\N
37	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:08.248416+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:08.223121+03	\N	\N
38	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:12:09.249285+03	15	\N	\N	1	\N		17920	2017-07-15 14:12:09.229677+03	\N	\N
39	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:10.716455+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:10.69543+03	\N	\N
40	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:12:11.813898+03	15	\N	\N	1	\N		17920	2017-07-15 14:12:11.793807+03	\N	\N
41	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:12.994159+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:12.970853+03	\N	\N
42	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:13.987103+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:13.964239+03	\N	\N
43	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:14.999671+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:14.974708+03	\N	\N
44	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:12:16.001511+03	15	\N	\N	1	\N		17920	2017-07-15 14:12:15.982774+03	\N	\N
45	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:12:17.037106+03	15	\N	\N	1	\N		17920	2017-07-15 14:12:17.020238+03	\N	\N
46	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:17.63814+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:17.610836+03	\N	\N
47	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:12:18.481968+03	10	\N	\N	1	\N		17920	2017-07-15 14:12:18.460489+03	\N	\N
48	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:17:44.044706+03	10	\N	\N	1	\N		18156	2017-07-15 14:17:44.018637+03	\N	\N
49	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:17:45.057924+03	15	\N	\N	1	\N		18156	2017-07-15 14:17:45.038742+03	\N	\N
50	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:17:51.362837+03	10	\N	\N	1	\N		18156	2017-07-15 14:17:51.338837+03	\N	\N
51	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:17:57.490947+03	15	\N	\N	1	\N		18156	2017-07-15 14:17:57.471829+03	\N	\N
52	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:18:48.12593+03	10	\N	\N	1	\N		18218	2017-07-15 14:18:48.103158+03	\N	\N
53	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:18:48.72561+03	10	\N	\N	1	\N		18218	2017-07-15 14:18:48.70263+03	\N	\N
54	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:18:55.215411+03	10	\N	\N	1	\N		18218	2017-07-15 14:18:55.195416+03	\N	\N
55	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:18:56.081133+03	10	\N	\N	1	\N		18218	2017-07-15 14:18:56.062236+03	\N	\N
56	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:19:06.762572+03	10	\N	\N	1	\N		18218	2017-07-15 14:19:06.744007+03	\N	\N
57	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:19:08.144565+03	10	\N	\N	1	\N		18218	2017-07-15 14:19:08.122979+03	\N	\N
58	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:19:14.579834+03	10	\N	\N	1	\N		18218	2017-07-15 14:19:14.557405+03	\N	\N
59	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:19:15.722206+03	10	\N	\N	1	\N		18218	2017-07-15 14:19:15.704335+03	\N	\N
60	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:19:26.353049+03	10	\N	\N	1	\N		18218	2017-07-15 14:19:26.328137+03	\N	\N
61	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:19:27.33096+03	10	\N	\N	1	\N		18218	2017-07-15 14:19:27.313+03	\N	\N
62	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:00.356788+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:00.333139+03	\N	\N
63	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:01.15839+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:01.13512+03	\N	\N
64	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:11.748325+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:11.728878+03	\N	\N
65	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:12.549129+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:12.528903+03	\N	\N
66	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:18.389814+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:18.366734+03	\N	\N
67	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:19.858234+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:19.836711+03	\N	\N
68	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:31.29171+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:31.266656+03	\N	\N
69	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:32.718621+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:32.704897+03	\N	\N
70	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:23:38.903697+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:38.879503+03	\N	\N
71	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:23:39.861638+03	10	\N	\N	1	\N		18521	2017-07-15 14:23:39.838896+03	\N	\N
77	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:24:11.286883+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:11.268234+03	\N	\N
78	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:24:17.59853+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:17.577214+03	\N	\N
79	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:24:18.142734+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:18.125483+03	\N	\N
80	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:24:29.347156+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:29.329796+03	\N	\N
81	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:24:30.449551+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:30.431651+03	\N	\N
82	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:24:41.082833+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:41.062619+03	\N	\N
83	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:24:42.131343+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:42.108096+03	\N	\N
84	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:24:48.630591+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:48.60422+03	\N	\N
85	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:24:49.7743+03	10	\N	\N	1	\N		18521	2017-07-15 14:24:49.757651+03	\N	\N
86	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:25:00.972193+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:00.951696+03	\N	\N
87	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:25:02.339575+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:02.326426+03	\N	\N
88	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:25:08.074551+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:08.055406+03	\N	\N
89	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:25:08.911011+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:08.889278+03	\N	\N
90	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:25:20.098476+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:20.078606+03	\N	\N
91	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:25:21.363294+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:21.344824+03	\N	\N
92	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:25:27.170299+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:27.141301+03	\N	\N
93	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:25:28.441724+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:28.420274+03	\N	\N
94	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:25:39.324601+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:39.294275+03	\N	\N
95	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:25:40.497107+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:40.478884+03	\N	\N
96	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:25:51.632903+03	10	\N	\N	1	\N		18521	2017-07-15 14:25:51.613479+03	\N	\N
97	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:26:29.556594+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:29.531623+03	\N	\N
98	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:26:30.28766+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:30.253906+03	\N	\N
99	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:26:36.183045+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:36.154781+03	\N	\N
100	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:26:36.792408+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:36.772914+03	\N	\N
101	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:26:47.488227+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:47.408662+03	\N	\N
102	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:26:48.829631+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:48.76367+03	\N	\N
103	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:26:55.349985+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:55.326934+03	\N	\N
104	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:26:56.814983+03	10	\N	\N	1	\N		18882	2017-07-15 14:26:56.777046+03	\N	\N
105	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:27:07.914215+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:07.884973+03	\N	\N
106	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:27:08.810668+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:08.774641+03	\N	\N
107	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:27:19.602421+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:19.58009+03	\N	\N
108	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:27:20.468752+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:20.436663+03	\N	\N
109	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:27:26.051751+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:26.028611+03	\N	\N
110	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:27:27.567848+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:27.532261+03	\N	\N
111	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:27:38.309549+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:38.287901+03	\N	\N
112	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:27:39.498067+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:39.459496+03	\N	\N
113	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:27:45.54159+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:45.517184+03	\N	\N
114	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:27:46.77074+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:46.74216+03	\N	\N
115	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:27:57.828661+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:57.804241+03	\N	\N
116	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:27:58.858137+03	10	\N	\N	1	\N		18882	2017-07-15 14:27:58.822436+03	\N	\N
117	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:28:04.724011+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:04.704175+03	\N	\N
118	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:28:05.88566+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:05.849986+03	\N	\N
119	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:28:17.01357+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:16.994172+03	\N	\N
120	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:28:17.889483+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:17.855733+03	\N	\N
121	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:28:29.324439+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:29.305111+03	\N	\N
122	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:28:30.623794+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:30.589841+03	\N	\N
123	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:28:36.868154+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:36.849528+03	\N	\N
124	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:28:37.644696+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:37.610605+03	\N	\N
125	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:28:48.917307+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:48.898423+03	\N	\N
126	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:28:49.767858+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:49.734793+03	\N	\N
127	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:28:55.69812+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:55.672988+03	\N	\N
128	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:28:56.722343+03	10	\N	\N	1	\N		18882	2017-07-15 14:28:56.688726+03	\N	\N
129	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:29:07.840034+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:07.820002+03	\N	\N
130	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:29:09.005562+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:08.971915+03	\N	\N
131	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:29:15.383246+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:15.363453+03	\N	\N
132	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:29:16.347617+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:16.312284+03	\N	\N
133	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:29:27.395291+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:27.370743+03	\N	\N
134	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:29:28.938739+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:28.902078+03	\N	\N
135	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:29:34.917445+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:34.896983+03	\N	\N
136	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:29:36.077518+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:36.044645+03	\N	\N
137	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:29:47.241193+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:47.220521+03	\N	\N
138	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:29:48.002728+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:47.968265+03	\N	\N
139	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:29:58.685407+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:58.654517+03	\N	\N
140	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:29:59.526792+03	10	\N	\N	1	\N		18882	2017-07-15 14:29:59.491823+03	\N	\N
141	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:30:05.713622+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:05.691887+03	\N	\N
142	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:30:06.888646+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:06.850013+03	\N	\N
143	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:30:18.448515+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:18.428131+03	\N	\N
144	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:30:19.832108+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:19.805594+03	\N	\N
145	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:30:25.716539+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:25.694982+03	\N	\N
146	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:30:26.323686+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:26.282053+03	\N	\N
147	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:30:37.207377+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:37.188229+03	\N	\N
148	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:30:38.007396+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:37.962241+03	\N	\N
149	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:30:48.704972+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:48.679449+03	\N	\N
150	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:30:49.362515+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:49.329036+03	\N	\N
151	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:30:54.931829+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:54.906939+03	\N	\N
152	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:30:56.266909+03	10	\N	\N	1	\N		18882	2017-07-15 14:30:56.23243+03	\N	\N
153	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:31:07.420855+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:07.400664+03	\N	\N
154	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:31:08.649732+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:08.614246+03	\N	\N
155	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:31:19.520866+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:19.497456+03	\N	\N
156	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:31:21.062066+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:21.026839+03	\N	\N
157	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:31:27.072278+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:27.052956+03	\N	\N
158	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:31:28.24674+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:28.210311+03	\N	\N
159	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:31:39.279663+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:39.259439+03	\N	\N
160	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:31:40.278818+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:40.250235+03	\N	\N
161	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:31:46.262107+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:46.241982+03	\N	\N
162	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:31:47.698401+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:47.672829+03	\N	\N
163	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:31:58.328606+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:58.306647+03	\N	\N
164	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:31:59.049451+03	10	\N	\N	1	\N		18882	2017-07-15 14:31:59.014655+03	\N	\N
165	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:32:04.82189+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:04.798376+03	\N	\N
166	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:32:05.992738+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:05.954744+03	\N	\N
167	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:32:16.987993+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:16.968615+03	\N	\N
168	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:32:18.149168+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:18.110932+03	\N	\N
169	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:32:24.607746+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:24.585897+03	\N	\N
170	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:32:26.08155+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:26.044893+03	\N	\N
171	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:32:37.31521+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:37.294213+03	\N	\N
172	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:32:37.910632+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:37.875414+03	\N	\N
173	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:32:49.391715+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:49.368743+03	\N	\N
174	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:32:50.754386+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:50.727468+03	\N	\N
175	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:32:56.90195+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:56.88291+03	\N	\N
176	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:32:58.021343+03	10	\N	\N	1	\N		18882	2017-07-15 14:32:57.988313+03	\N	\N
177	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:33:09.439987+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:09.422359+03	\N	\N
178	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:33:10.613696+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:10.575923+03	\N	\N
179	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:33:16.334421+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:16.315844+03	\N	\N
180	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:33:17.416808+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:17.383898+03	\N	\N
181	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:33:28.226835+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:28.205632+03	\N	\N
182	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:33:29.546931+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:29.512448+03	\N	\N
183	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:33:35.905454+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:35.885775+03	\N	\N
184	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:33:36.570328+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:36.537961+03	\N	\N
185	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:33:47.820085+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:47.798204+03	\N	\N
186	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:33:49.33379+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:49.302807+03	\N	\N
187	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:33:55.482878+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:55.463478+03	\N	\N
188	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:33:56.242448+03	10	\N	\N	1	\N		18882	2017-07-15 14:33:56.205849+03	\N	\N
189	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:34:07.079561+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:07.060394+03	\N	\N
190	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:34:07.771838+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:07.743551+03	\N	\N
191	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:34:18.728864+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:18.703493+03	\N	\N
192	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:34:20.228123+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:20.198677+03	\N	\N
193	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:34:26.404527+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:26.376482+03	\N	\N
194	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:34:27.485359+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:27.448977+03	\N	\N
195	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:34:38.773786+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:38.747522+03	\N	\N
196	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:34:40.146251+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:40.11257+03	\N	\N
197	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:34:46.387055+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:46.366877+03	\N	\N
198	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:34:46.973669+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:46.938245+03	\N	\N
199	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:34:58.027546+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:58.008272+03	\N	\N
200	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:34:59.487535+03	10	\N	\N	1	\N		18882	2017-07-15 14:34:59.447968+03	\N	\N
201	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:35:05.942062+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:05.922235+03	\N	\N
202	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:35:06.817436+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:06.778429+03	\N	\N
203	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:35:18.254722+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:18.232542+03	\N	\N
204	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:35:19.66538+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:19.631155+03	\N	\N
205	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:35:26.014408+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:25.990219+03	\N	\N
206	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:35:27.424161+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:27.38461+03	\N	\N
207	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:35:38.906679+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:38.887275+03	\N	\N
208	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:35:39.633832+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:39.603566+03	\N	\N
209	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:35:45.508756+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:45.486864+03	\N	\N
210	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:35:47.052126+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:47.017674+03	\N	\N
211	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:35:58.098602+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:58.077371+03	\N	\N
212	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:35:58.844297+03	10	\N	\N	1	\N		18882	2017-07-15 14:35:58.808571+03	\N	\N
213	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:36:04.919143+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:04.899093+03	\N	\N
214	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:36:06.2968+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:06.262537+03	\N	\N
215	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:36:17.527617+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:17.507679+03	\N	\N
216	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:36:18.624535+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:18.588193+03	\N	\N
217	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:36:25.103501+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:25.085958+03	\N	\N
218	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:36:26.566477+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:26.53662+03	\N	\N
219	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:36:37.759964+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:37.738765+03	\N	\N
220	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:36:38.858685+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:38.817747+03	\N	\N
221	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:36:45.254005+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:45.234444+03	\N	\N
222	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:36:46.110728+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:46.078086+03	\N	\N
223	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:36:57.666787+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:57.647538+03	\N	\N
224	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:36:59.142875+03	10	\N	\N	1	\N		18882	2017-07-15 14:36:59.108883+03	\N	\N
225	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:37:04.854885+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:04.806896+03	\N	\N
226	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:37:06.184277+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:06.150253+03	\N	\N
227	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:37:17.033182+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:17.011368+03	\N	\N
228	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:37:17.901301+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:17.870582+03	\N	\N
229	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:37:28.52884+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:28.505725+03	\N	\N
230	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:37:29.407028+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:29.371298+03	\N	\N
231	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:37:35.46784+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:35.445092+03	\N	\N
232	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:37:36.877628+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:36.848223+03	\N	\N
233	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:37:47.867406+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:47.846233+03	\N	\N
234	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:37:48.721612+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:48.68434+03	\N	\N
235	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:37:59.518215+03	10	\N	\N	1	\N		18882	2017-07-15 14:37:59.498683+03	\N	\N
236	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:00.207981+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:00.172595+03	\N	\N
237	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:38:06.592706+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:06.572669+03	\N	\N
238	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:08.049103+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:08.010329+03	\N	\N
239	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:38:18.757832+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:18.730529+03	\N	\N
240	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:19.926907+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:19.890387+03	\N	\N
241	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:38:26.092733+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:26.072183+03	\N	\N
242	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:27.60309+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:27.566501+03	\N	\N
243	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:38:38.518884+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:38.49953+03	\N	\N
244	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:39.347693+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:39.309392+03	\N	\N
245	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:38:44.958263+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:44.930085+03	\N	\N
246	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:45.970768+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:45.936785+03	\N	\N
247	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:38:57.397539+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:57.377071+03	\N	\N
248	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:38:58.25039+03	10	\N	\N	1	\N		18882	2017-07-15 14:38:58.214389+03	\N	\N
249	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:39:08.979136+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:08.956032+03	\N	\N
250	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:39:09.674409+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:09.637166+03	\N	\N
251	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:39:15.617662+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:15.598025+03	\N	\N
252	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:39:16.376325+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:16.341888+03	\N	\N
253	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:39:27.343124+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:27.323639+03	\N	\N
254	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:39:27.975343+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:27.939711+03	\N	\N
255	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:39:39.32644+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:39.304055+03	\N	\N
256	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:39:40.696442+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:40.660441+03	\N	\N
257	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:39:46.969016+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:46.94653+03	\N	\N
258	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:39:47.919872+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:47.885839+03	\N	\N
259	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:39:59.368391+03	10	\N	\N	1	\N		18882	2017-07-15 14:39:59.346661+03	\N	\N
260	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:00.868542+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:00.840127+03	\N	\N
261	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:40:07.181212+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:07.161658+03	\N	\N
262	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:08.349397+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:08.313305+03	\N	\N
263	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:40:14.710044+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:14.688779+03	\N	\N
264	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:15.708768+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:15.67223+03	\N	\N
265	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:40:26.910461+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:26.89275+03	\N	\N
266	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:27.999585+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:27.960949+03	\N	\N
267	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:40:38.58129+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:38.558462+03	\N	\N
268	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:39.278446+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:39.239716+03	\N	\N
269	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:40:45.769716+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:45.750421+03	\N	\N
270	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:46.420291+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:46.383438+03	\N	\N
271	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:40:57.860951+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:57.837881+03	\N	\N
272	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:40:58.903147+03	10	\N	\N	1	\N		18882	2017-07-15 14:40:58.866365+03	\N	\N
273	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:41:05.277792+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:05.256162+03	\N	\N
274	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:41:06.687375+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:06.654406+03	\N	\N
275	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:41:17.928748+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:17.908947+03	\N	\N
276	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:41:18.774069+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:18.736946+03	\N	\N
277	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:41:24.593372+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:24.572595+03	\N	\N
278	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:41:25.731076+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:25.701442+03	\N	\N
279	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:41:36.756299+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:36.735036+03	\N	\N
280	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:41:38.053808+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:38.017349+03	\N	\N
281	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:41:48.989473+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:48.970117+03	\N	\N
282	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:41:50.504241+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:50.470016+03	\N	\N
283	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:41:56.203833+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:56.182591+03	\N	\N
284	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:41:57.246871+03	10	\N	\N	1	\N		18882	2017-07-15 14:41:57.212851+03	\N	\N
285	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:42:08.508996+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:08.490724+03	\N	\N
286	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:42:09.568286+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:09.530732+03	\N	\N
287	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:42:15.530416+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:15.505943+03	\N	\N
288	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:42:16.999914+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:16.963936+03	\N	\N
289	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:42:28.340948+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:28.318256+03	\N	\N
290	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:42:29.107216+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:29.073723+03	\N	\N
291	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:42:35.385845+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:35.363601+03	\N	\N
292	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:42:36.673177+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:36.638851+03	\N	\N
293	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:42:47.888797+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:47.866059+03	\N	\N
294	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:42:49.400444+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:49.372277+03	\N	\N
295	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:42:55.458502+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:55.438938+03	\N	\N
296	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:42:56.140674+03	10	\N	\N	1	\N		18882	2017-07-15 14:42:56.112273+03	\N	\N
297	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:43:06.876974+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:06.857529+03	\N	\N
298	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:43:08.410967+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:08.380317+03	\N	\N
299	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:43:19.217871+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:19.197945+03	\N	\N
300	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:43:20.766708+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:20.730653+03	\N	\N
301	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:43:26.83071+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:26.809965+03	\N	\N
302	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:43:27.389273+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:27.354306+03	\N	\N
303	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:43:38.934322+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:38.914433+03	\N	\N
304	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:43:40.09688+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:40.061519+03	\N	\N
305	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:43:46.601042+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:46.578539+03	\N	\N
306	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:43:47.475842+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:47.446112+03	\N	\N
307	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:43:58.8573+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:58.836255+03	\N	\N
308	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:43:59.666127+03	10	\N	\N	1	\N		18882	2017-07-15 14:43:59.627125+03	\N	\N
309	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:44:05.551874+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:05.52949+03	\N	\N
310	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:44:06.349773+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:06.311793+03	\N	\N
311	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:44:17.494604+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:17.473498+03	\N	\N
312	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:44:18.089066+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:18.049621+03	\N	\N
313	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:44:29.530151+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:29.505901+03	\N	\N
314	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:44:31.024056+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:30.979977+03	\N	\N
315	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:44:37.226568+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:37.207027+03	\N	\N
316	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:44:38.1591+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:38.124179+03	\N	\N
317	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:44:48.849805+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:48.825844+03	\N	\N
318	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:44:49.830147+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:49.791846+03	\N	\N
319	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:44:56.338716+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:56.319052+03	\N	\N
320	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:44:57.802745+03	10	\N	\N	1	\N		18882	2017-07-15 14:44:57.766617+03	\N	\N
321	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:45:08.964156+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:08.943309+03	\N	\N
322	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:45:10.254969+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:10.223405+03	\N	\N
323	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:45:16.584203+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:16.555316+03	\N	\N
324	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:45:18.143517+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:18.101809+03	\N	\N
325	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:45:29.236677+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:29.211976+03	\N	\N
326	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:45:29.824738+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:29.78868+03	\N	\N
327	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:45:35.454236+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:35.43448+03	\N	\N
328	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:45:36.646786+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:36.612895+03	\N	\N
329	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:45:47.654177+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:47.633533+03	\N	\N
330	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:45:48.767219+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:48.730397+03	\N	\N
331	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:45:54.942205+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:54.921077+03	\N	\N
332	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:45:56.270455+03	10	\N	\N	1	\N		18882	2017-07-15 14:45:56.242177+03	\N	\N
333	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:46:07.561512+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:07.541236+03	\N	\N
334	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:46:08.905155+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:08.866795+03	\N	\N
335	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:46:15.138906+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:15.11776+03	\N	\N
336	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:46:15.762591+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:15.733444+03	\N	\N
337	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:46:26.813397+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:26.792619+03	\N	\N
338	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:46:28.299368+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:28.266379+03	\N	\N
339	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:46:39.133402+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:39.11106+03	\N	\N
340	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:46:40.165323+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:40.130122+03	\N	\N
341	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:46:46.648381+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:46.626692+03	\N	\N
342	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:46:47.518123+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:47.480954+03	\N	\N
343	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:46:58.794481+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:58.770567+03	\N	\N
344	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:46:59.813287+03	10	\N	\N	1	\N		18882	2017-07-15 14:46:59.782297+03	\N	\N
345	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:47:05.426681+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:05.401036+03	\N	\N
346	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:47:06.090572+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:06.057936+03	\N	\N
347	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:47:17.534177+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:17.511797+03	\N	\N
348	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:47:18.972028+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:18.93534+03	\N	\N
349	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:47:25.428599+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:25.405342+03	\N	\N
350	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:47:26.168308+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:26.130807+03	\N	\N
351	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:47:37.247516+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:37.228594+03	\N	\N
352	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:47:38.351239+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:38.315499+03	\N	\N
353	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:47:49.377752+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:49.353015+03	\N	\N
354	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:47:50.487427+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:50.451729+03	\N	\N
355	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:47:56.68566+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:56.664815+03	\N	\N
356	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:47:57.819471+03	10	\N	\N	1	\N		18882	2017-07-15 14:47:57.785843+03	\N	\N
357	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:48:08.618928+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:08.596967+03	\N	\N
358	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:48:09.798103+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:09.76937+03	\N	\N
359	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:48:15.95221+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:15.932071+03	\N	\N
360	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:48:17.128002+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:17.09232+03	\N	\N
361	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:48:27.936102+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:27.912959+03	\N	\N
362	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:48:28.658663+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:28.625485+03	\N	\N
363	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:48:39.453463+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:39.432461+03	\N	\N
364	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:48:40.308567+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:40.270484+03	\N	\N
365	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:48:46.510882+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:46.492836+03	\N	\N
366	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:48:47.332631+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:47.292754+03	\N	\N
367	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:48:58.65143+03	10	\N	\N	1	\N		18882	2017-07-15 14:48:58.632194+03	\N	\N
368	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:00.148597+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:00.121742+03	\N	\N
369	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:49:06.258196+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:06.22666+03	\N	\N
370	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:06.828543+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:06.797143+03	\N	\N
371	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:49:18.023843+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:18.002249+03	\N	\N
372	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:19.465144+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:19.428446+03	\N	\N
373	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:49:25.789894+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:25.768258+03	\N	\N
374	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:27.106998+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:27.070172+03	\N	\N
375	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:49:37.876933+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:37.858214+03	\N	\N
376	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:38.66036+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:38.622866+03	\N	\N
377	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:49:49.285478+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:49.263695+03	\N	\N
378	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:50.134676+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:50.096624+03	\N	\N
379	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:49:56.148442+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:56.126377+03	\N	\N
380	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:49:57.011336+03	10	\N	\N	1	\N		18882	2017-07-15 14:49:56.975854+03	\N	\N
381	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:50:07.634969+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:07.613853+03	\N	\N
382	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:50:09.144391+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:09.112979+03	\N	\N
383	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:50:14.812036+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:14.790151+03	\N	\N
384	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:50:16.08868+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:16.05299+03	\N	\N
385	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:50:26.982283+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:26.958166+03	\N	\N
386	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:50:28.411287+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:28.378205+03	\N	\N
387	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:50:39.121121+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:39.100969+03	\N	\N
388	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:50:40.243004+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:40.20635+03	\N	\N
389	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:50:46.716934+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:46.697346+03	\N	\N
390	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:50:47.419553+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:47.389311+03	\N	\N
391	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:50:58.021499+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:58.000142+03	\N	\N
392	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:50:59.290199+03	10	\N	\N	1	\N		18882	2017-07-15 14:50:59.252051+03	\N	\N
393	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:51:05.285494+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:05.264046+03	\N	\N
394	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:51:06.163531+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:06.125333+03	\N	\N
395	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:51:16.822894+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:16.801433+03	\N	\N
396	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:51:17.659323+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:17.623247+03	\N	\N
397	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:51:29.13942+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:29.114516+03	\N	\N
398	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:51:30.126759+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:30.097529+03	\N	\N
399	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:51:36.064039+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:36.041784+03	\N	\N
400	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:51:37.555394+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:37.528229+03	\N	\N
401	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:51:48.742436+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:48.721046+03	\N	\N
402	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:51:49.65128+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:49.614403+03	\N	\N
403	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:51:56.129537+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:56.108481+03	\N	\N
404	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:51:56.762077+03	10	\N	\N	1	\N		18882	2017-07-15 14:51:56.721641+03	\N	\N
405	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:52:07.43525+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:07.411996+03	\N	\N
406	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:52:08.880141+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:08.843427+03	\N	\N
407	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:52:15.321306+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:15.296719+03	\N	\N
408	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:52:16.574621+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:16.539499+03	\N	\N
409	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:52:28.028585+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:28.006669+03	\N	\N
410	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:52:29.176524+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:29.125511+03	\N	\N
411	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:52:35.609991+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:35.584807+03	\N	\N
412	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:52:36.199037+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:36.164833+03	\N	\N
413	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:52:47.428675+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:47.407597+03	\N	\N
414	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:52:48.378208+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:48.339911+03	\N	\N
415	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:52:59.418703+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:59.395267+03	\N	\N
416	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:00.021025+03	10	\N	\N	1	\N		18882	2017-07-15 14:52:59.985088+03	\N	\N
417	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:53:05.607026+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:05.582972+03	\N	\N
418	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:06.385499+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:06.349421+03	\N	\N
419	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:53:17.398887+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:17.379097+03	\N	\N
420	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:18.599705+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:18.569868+03	\N	\N
421	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:53:29.581359+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:29.555898+03	\N	\N
422	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:30.770093+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:30.73528+03	\N	\N
423	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:53:36.766262+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:36.740563+03	\N	\N
424	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:37.376591+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:37.345729+03	\N	\N
425	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:53:48.316142+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:48.290092+03	\N	\N
426	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:49.597733+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:49.558672+03	\N	\N
427	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:53:56.056729+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:56.023886+03	\N	\N
428	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:53:57.046902+03	10	\N	\N	1	\N		18882	2017-07-15 14:53:57.010933+03	\N	\N
429	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:54:08.583784+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:08.56425+03	\N	\N
430	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:54:09.667254+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:09.632886+03	\N	\N
431	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:54:15.992836+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:15.970867+03	\N	\N
432	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:54:17.48467+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:17.449013+03	\N	\N
433	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:54:28.120155+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:28.098053+03	\N	\N
434	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:54:29.620485+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:29.583376+03	\N	\N
435	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:54:36.029703+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:36.006691+03	\N	\N
436	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:54:36.847084+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:36.809431+03	\N	\N
437	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:54:48.272969+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:48.247527+03	\N	\N
438	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:54:49.391864+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:49.359905+03	\N	\N
439	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:54:55.902391+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:55.883044+03	\N	\N
440	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:54:57.182646+03	10	\N	\N	1	\N		18882	2017-07-15 14:54:57.14585+03	\N	\N
441	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:55:08.63137+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:08.610413+03	\N	\N
442	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:55:09.901673+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:09.866762+03	\N	\N
443	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:55:16.16625+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:16.143112+03	\N	\N
444	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:55:16.97887+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:16.948354+03	\N	\N
445	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:55:28.329714+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:28.312048+03	\N	\N
446	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:55:29.181505+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:29.144014+03	\N	\N
447	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:55:35.278548+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:35.260689+03	\N	\N
448	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:55:35.985922+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:35.957922+03	\N	\N
449	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:55:47.136725+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:47.105892+03	\N	\N
450	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:55:48.541657+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:48.50407+03	\N	\N
451	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:55:55.041819+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:55.022863+03	\N	\N
452	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:55:55.931713+03	10	\N	\N	1	\N		18882	2017-07-15 14:55:55.896635+03	\N	\N
453	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:56:06.67649+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:06.657234+03	\N	\N
454	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:56:07.396545+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:07.358959+03	\N	\N
455	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:56:18.9074+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:18.885623+03	\N	\N
456	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:56:20.277213+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:20.241274+03	\N	\N
457	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:56:26.495339+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:26.47479+03	\N	\N
458	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:56:27.128766+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:27.095606+03	\N	\N
459	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:56:38.132214+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:38.110265+03	\N	\N
460	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:56:39.248536+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:39.219585+03	\N	\N
461	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:56:45.409945+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:45.385898+03	\N	\N
462	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:56:46.146336+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:46.115242+03	\N	\N
463	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:56:57.079907+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:57.055032+03	\N	\N
464	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:56:58.321165+03	10	\N	\N	1	\N		18882	2017-07-15 14:56:58.28446+03	\N	\N
465	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:57:04.844064+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:04.821655+03	\N	\N
466	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:57:05.813642+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:05.783336+03	\N	\N
467	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:57:17.15842+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:17.135326+03	\N	\N
468	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:57:18.279444+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:18.239698+03	\N	\N
469	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:57:29.223873+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:29.203685+03	\N	\N
470	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:57:30.5527+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:30.519799+03	\N	\N
471	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:57:36.620001+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:36.600284+03	\N	\N
472	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:57:38.133237+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:38.097406+03	\N	\N
473	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:57:49.251568+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:49.2321+03	\N	\N
474	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:57:50.630075+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:50.595054+03	\N	\N
475	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:57:56.940571+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:56.920247+03	\N	\N
476	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:57:58.065764+03	10	\N	\N	1	\N		18882	2017-07-15 14:57:58.03723+03	\N	\N
477	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:58:09.035075+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:09.016191+03	\N	\N
478	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:58:10.215281+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:10.180226+03	\N	\N
479	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:58:15.981559+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:15.963426+03	\N	\N
480	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:58:17.079087+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:17.043246+03	\N	\N
481	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:58:27.966232+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:27.9434+03	\N	\N
482	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:58:28.664306+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:28.631523+03	\N	\N
483	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:58:34.614374+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:34.594839+03	\N	\N
484	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:58:35.50137+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:35.465653+03	\N	\N
485	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:58:46.745537+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:46.727589+03	\N	\N
486	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:58:47.536316+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:47.500533+03	\N	\N
487	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:58:58.661585+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:58.6418+03	\N	\N
488	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:58:59.327335+03	10	\N	\N	1	\N		18882	2017-07-15 14:58:59.293979+03	\N	\N
489	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:59:05.276725+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:05.251799+03	\N	\N
490	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:59:06.615342+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:06.578903+03	\N	\N
491	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:59:17.662174+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:17.638496+03	\N	\N
492	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:59:18.553067+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:18.515462+03	\N	\N
493	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:59:29.174575+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:29.151982+03	\N	\N
494	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:59:30.375421+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:30.343287+03	\N	\N
495	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:59:36.241606+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:36.217307+03	\N	\N
496	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:59:36.799025+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:36.768397+03	\N	\N
497	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:59:47.999643+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:47.9771+03	\N	\N
498	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:59:48.987388+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:48.951496+03	\N	\N
499	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 14:59:55.00428+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:54.984084+03	\N	\N
500	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 14:59:56.063915+03	10	\N	\N	1	\N		18882	2017-07-15 14:59:56.026959+03	\N	\N
501	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:00:07.212571+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:07.192115+03	\N	\N
502	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:00:08.406064+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:08.366387+03	\N	\N
503	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:00:19.161582+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:19.13893+03	\N	\N
504	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:00:20.430279+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:20.394579+03	\N	\N
505	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:00:26.20424+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:26.181724+03	\N	\N
506	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:00:27.252035+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:27.215779+03	\N	\N
507	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:00:38.056364+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:38.033154+03	\N	\N
508	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:00:38.791594+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:38.745132+03	\N	\N
509	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:00:44.61072+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:44.587743+03	\N	\N
510	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:00:45.528702+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:45.495633+03	\N	\N
511	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:00:56.768854+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:56.744032+03	\N	\N
512	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:00:57.525637+03	10	\N	\N	1	\N		18882	2017-07-15 15:00:57.492488+03	\N	\N
513	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:01:08.114746+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:08.092957+03	\N	\N
514	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:01:09.396175+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:09.361114+03	\N	\N
515	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:01:15.040753+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:15.019001+03	\N	\N
516	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:01:16.122993+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:16.082637+03	\N	\N
517	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:01:27.297798+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:27.277498+03	\N	\N
518	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:01:28.513988+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:28.478483+03	\N	\N
519	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:01:34.867789+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:34.849042+03	\N	\N
520	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:01:35.93162+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:35.89531+03	\N	\N
521	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:01:47.378313+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:47.358961+03	\N	\N
522	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:01:47.935504+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:47.906225+03	\N	\N
523	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:01:59.435148+03	10	\N	\N	1	\N		18882	2017-07-15 15:01:59.410586+03	\N	\N
524	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:00.225621+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:00.185689+03	\N	\N
525	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:02:06.776579+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:06.742771+03	\N	\N
526	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:08.062839+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:08.011876+03	\N	\N
527	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:02:19.391692+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:19.372047+03	\N	\N
528	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:20.40106+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:20.369077+03	\N	\N
529	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:02:26.604982+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:26.583105+03	\N	\N
530	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:27.397142+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:27.350806+03	\N	\N
531	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:02:38.402219+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:38.375052+03	\N	\N
532	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:39.500004+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:39.439616+03	\N	\N
533	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:02:45.527622+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:45.50513+03	\N	\N
534	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:46.208573+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:46.174922+03	\N	\N
535	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:02:57.303622+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:57.283496+03	\N	\N
536	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:02:58.486935+03	10	\N	\N	1	\N		18882	2017-07-15 15:02:58.450048+03	\N	\N
537	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:03:09.398258+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:09.378707+03	\N	\N
538	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:03:10.891782+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:10.863304+03	\N	\N
539	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:03:17.348179+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:17.323007+03	\N	\N
540	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:03:18.004672+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:17.973249+03	\N	\N
541	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:03:28.800201+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:28.776726+03	\N	\N
542	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:03:29.524722+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:29.492006+03	\N	\N
543	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:03:35.894866+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:35.87257+03	\N	\N
544	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:03:37.225384+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:37.186746+03	\N	\N
545	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:03:47.972067+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:47.951662+03	\N	\N
546	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:03:49.240695+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:49.20292+03	\N	\N
547	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:03:55.427094+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:55.401939+03	\N	\N
548	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:03:56.826032+03	10	\N	\N	1	\N		18882	2017-07-15 15:03:56.788345+03	\N	\N
549	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:04:08.133001+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:08.113888+03	\N	\N
550	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:04:08.862568+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:08.833274+03	\N	\N
551	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:04:14.948195+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:14.924994+03	\N	\N
552	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:04:16.293323+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:16.262657+03	\N	\N
553	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:04:27.229087+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:27.209088+03	\N	\N
554	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:04:28.278268+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:28.241266+03	\N	\N
555	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:04:39.403421+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:39.383802+03	\N	\N
556	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:04:40.74644+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:40.710741+03	\N	\N
557	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:04:46.694556+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:46.67107+03	\N	\N
558	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:04:47.948743+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:47.915939+03	\N	\N
559	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:04:58.627448+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:58.607398+03	\N	\N
560	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:04:59.565234+03	10	\N	\N	1	\N		18882	2017-07-15 15:04:59.534023+03	\N	\N
561	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:05:05.767051+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:05.7491+03	\N	\N
562	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:05:06.541893+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:06.512344+03	\N	\N
563	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:05:17.201349+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:17.181234+03	\N	\N
564	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:05:18.551808+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:18.521367+03	\N	\N
565	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:05:24.928738+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:24.907753+03	\N	\N
566	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:05:26.451085+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:26.412049+03	\N	\N
567	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:05:37.540232+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:37.519815+03	\N	\N
568	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:05:38.18241+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:38.146593+03	\N	\N
569	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:05:49.086889+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:49.067499+03	\N	\N
570	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:05:50.404293+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:50.378103+03	\N	\N
571	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:05:56.721742+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:56.700945+03	\N	\N
572	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:05:57.331829+03	10	\N	\N	1	\N		18882	2017-07-15 15:05:57.295513+03	\N	\N
573	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:06:08.598584+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:08.57573+03	\N	\N
574	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:06:09.476228+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:09.438224+03	\N	\N
575	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:06:15.938993+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:15.918638+03	\N	\N
576	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:06:17.008738+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:16.979409+03	\N	\N
577	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:06:28.500461+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:28.481294+03	\N	\N
578	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:06:29.474955+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:29.438529+03	\N	\N
579	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:06:35.647704+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:35.623508+03	\N	\N
580	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:06:36.932123+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:36.893217+03	\N	\N
581	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:06:47.674644+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:47.652751+03	\N	\N
582	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:06:49.097077+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:49.058323+03	\N	\N
583	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:06:54.677746+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:54.656253+03	\N	\N
584	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:06:55.920337+03	10	\N	\N	1	\N		18882	2017-07-15 15:06:55.883888+03	\N	\N
585	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:07:07.386325+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:07.365068+03	\N	\N
586	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:07:08.42535+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:08.397204+03	\N	\N
587	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:07:19.546959+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:19.523676+03	\N	\N
588	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:07:21.115603+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:21.060466+03	\N	\N
589	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:07:27.423369+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:27.403766+03	\N	\N
590	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:07:27.99633+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:27.964494+03	\N	\N
591	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:07:39.096709+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:39.075727+03	\N	\N
592	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:07:40.552965+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:40.482635+03	\N	\N
593	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:07:46.571655+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:46.544375+03	\N	\N
594	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:07:47.217642+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:47.169595+03	\N	\N
595	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:07:58.094278+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:58.067998+03	\N	\N
596	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:07:59.625559+03	10	\N	\N	1	\N		18882	2017-07-15 15:07:59.596083+03	\N	\N
597	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:08:05.37038+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:05.345662+03	\N	\N
598	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:08:06.240843+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:06.19524+03	\N	\N
599	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:08:17.364072+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:17.34089+03	\N	\N
600	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:08:18.428338+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:18.386469+03	\N	\N
601	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:08:29.094897+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:29.067267+03	\N	\N
602	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:08:30.492377+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:30.447752+03	\N	\N
603	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:08:36.130961+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:36.100466+03	\N	\N
604	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:08:36.894372+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:36.853229+03	\N	\N
605	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:08:47.711048+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:47.683951+03	\N	\N
606	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:08:49.158362+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:49.109492+03	\N	\N
607	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:08:54.990163+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:54.892225+03	\N	\N
608	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:08:55.716541+03	10	\N	\N	1	\N		18882	2017-07-15 15:08:55.638818+03	\N	\N
609	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:09:06.516702+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:06.469355+03	\N	\N
610	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:09:07.462621+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:07.413619+03	\N	\N
611	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:09:18.407587+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:18.377034+03	\N	\N
612	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:09:19.784206+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:19.741414+03	\N	\N
613	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:09:25.735724+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:25.716217+03	\N	\N
614	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:09:26.996251+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:26.964618+03	\N	\N
615	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:09:37.710645+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:37.653808+03	\N	\N
616	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:09:38.488594+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:38.44257+03	\N	\N
617	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 15:09:49.112799+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:49.089589+03	\N	\N
618	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 15:09:50.216795+03	10	\N	\N	1	\N		18882	2017-07-15 15:09:50.177234+03	\N	\N
619	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:18.402411+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:18.343561+03	\N	\N
620	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:19.946932+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:19.875021+03	\N	\N
621	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:21.377728+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:21.354482+03	\N	\N
622	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:22.069583+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:22.00168+03	\N	\N
623	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:22.934882+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:22.911912+03	\N	\N
624	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:24.133033+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:24.066189+03	\N	\N
625	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:25.161893+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:25.140222+03	\N	\N
626	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:26.27154+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:26.206649+03	\N	\N
627	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:27.016247+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:26.991464+03	\N	\N
628	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:28.262335+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:28.184551+03	\N	\N
629	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:28.98233+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:28.960159+03	\N	\N
630	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:30.287326+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:30.224026+03	\N	\N
631	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:31.341362+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:31.32026+03	\N	\N
632	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:32.380631+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:32.313784+03	\N	\N
633	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:33.821648+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:33.797784+03	\N	\N
634	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:34.763345+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:34.706108+03	\N	\N
635	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:36.178303+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:36.155912+03	\N	\N
636	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:36.798226+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:36.734213+03	\N	\N
637	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:47.400571+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:47.375459+03	\N	\N
638	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:48.282636+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:48.218209+03	\N	\N
639	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:08:54.615804+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:54.594136+03	\N	\N
640	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:08:55.770922+03	10	\N	\N	1	\N		22295	2017-07-15 16:08:55.698064+03	\N	\N
641	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:09:06.833277+03	10	\N	\N	1	\N		22295	2017-07-15 16:09:06.808603+03	\N	\N
642	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:09:08.397785+03	10	\N	\N	1	\N		22295	2017-07-15 16:09:08.328638+03	\N	\N
643	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:09:14.231444+03	10	\N	\N	1	\N		22295	2017-07-15 16:09:14.211675+03	\N	\N
644	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:09:14.933206+03	10	\N	\N	1	\N		22295	2017-07-15 16:09:14.858981+03	\N	\N
645	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:09:46.244555+03	10	\N	\N	1	\N		22358	2017-07-15 16:09:46.22017+03	\N	\N
646	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:09:47.745224+03	10	\N	\N	1	\N		22358	2017-07-15 16:09:47.698315+03	\N	\N
647	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:09:54.240081+03	10	\N	\N	1	\N		22358	2017-07-15 16:09:54.21242+03	\N	\N
648	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:09:54.820777+03	10	\N	\N	1	\N		22358	2017-07-15 16:09:54.769576+03	\N	\N
649	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:10:06.263533+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:06.242509+03	\N	\N
650	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:10:07.778698+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:07.730284+03	\N	\N
651	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:10:14.221877+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:14.198539+03	\N	\N
652	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:10:15.601395+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:15.552969+03	\N	\N
653	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:10:27.122059+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:27.102027+03	\N	\N
654	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:10:28.057246+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:28.009772+03	\N	\N
655	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:10:34.439801+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:34.41723+03	\N	\N
656	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:10:35.908332+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:35.861876+03	\N	\N
657	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:10:46.754965+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:46.723687+03	\N	\N
658	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:10:47.88823+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:47.83571+03	\N	\N
659	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:10:58.473536+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:58.445062+03	\N	\N
660	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:10:59.057577+03	10	\N	\N	1	\N		22358	2017-07-15 16:10:59.008773+03	\N	\N
661	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:11:05.259899+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:05.237445+03	\N	\N
662	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:11:06.4891+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:06.44046+03	\N	\N
663	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:11:18.060553+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:18.013553+03	\N	\N
664	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:11:18.943706+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:18.899365+03	\N	\N
665	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:11:24.553505+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:24.527461+03	\N	\N
666	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:11:26.045422+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:25.992712+03	\N	\N
667	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:11:36.72336+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:36.699268+03	\N	\N
668	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:11:38.197331+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:38.148707+03	\N	\N
669	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:11:44.674954+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:44.650223+03	\N	\N
670	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:11:45.455793+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:45.4082+03	\N	\N
671	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:11:56.395529+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:56.374386+03	\N	\N
672	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:11:57.310577+03	10	\N	\N	1	\N		22358	2017-07-15 16:11:57.266703+03	\N	\N
673	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:12:08.033009+03	10	\N	\N	1	\N		22358	2017-07-15 16:12:08.005557+03	\N	\N
674	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:12:09.521192+03	10	\N	\N	1	\N		22358	2017-07-15 16:12:09.443442+03	\N	\N
675	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:12:22.753043+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:22.732242+03	\N	\N
676	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:12:23.760121+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:23.707232+03	\N	\N
677	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:12:29.757569+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:29.738894+03	\N	\N
678	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:12:30.873985+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:30.827831+03	\N	\N
679	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:12:41.494132+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:41.472254+03	\N	\N
680	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:12:42.826006+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:42.771763+03	\N	\N
681	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:12:54.269451+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:54.244813+03	\N	\N
682	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:12:55.465758+03	10	\N	\N	1	\N		22543	2017-07-15 16:12:55.413996+03	\N	\N
683	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:13:01.041421+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:01.016929+03	\N	\N
684	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:13:01.804639+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:01.759726+03	\N	\N
685	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:13:12.698756+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:12.676359+03	\N	\N
686	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:13:14.047712+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:13.986679+03	\N	\N
687	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:13:20.205154+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:20.182734+03	\N	\N
688	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:13:20.832656+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:20.784756+03	\N	\N
689	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:13:32.393149+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:32.370589+03	\N	\N
690	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:13:33.605212+03	10	\N	\N	1	\N		22543	2017-07-15 16:13:33.560731+03	\N	\N
691	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:15:04.907518+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:04.884021+03	\N	\N
692	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:15:06.137567+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:06.083974+03	\N	\N
693	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:15:16.984547+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:16.958507+03	\N	\N
694	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:15:18.444086+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:18.392699+03	\N	\N
695	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:15:24.51511+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:24.496065+03	\N	\N
696	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:15:25.672837+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:25.622708+03	\N	\N
697	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:15:36.646274+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:36.608581+03	\N	\N
698	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:15:37.550091+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:37.501121+03	\N	\N
699	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:15:43.296415+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:43.273812+03	\N	\N
700	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:15:43.936827+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:43.891059+03	\N	\N
701	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:15:54.524893+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:54.502076+03	\N	\N
702	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:15:56.00937+03	10	\N	\N	1	\N		22682	2017-07-15 16:15:55.964066+03	\N	\N
703	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:16:47.246967+03	10	\N	\N	1	\N		22742	2017-07-15 16:16:47.224413+03	\N	\N
704	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:16:48.457204+03	10	\N	\N	1	\N		22742	2017-07-15 16:16:48.409348+03	\N	\N
705	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:16:59.533637+03	10	\N	\N	1	\N		22742	2017-07-15 16:16:59.513111+03	\N	\N
706	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:17:01.065129+03	10	\N	\N	1	\N		22742	2017-07-15 16:17:01.009876+03	\N	\N
707	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:17:07.375298+03	10	\N	\N	1	\N		22742	2017-07-15 16:17:07.330554+03	\N	\N
708	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:17:08.829071+03	10	\N	\N	1	\N		22742	2017-07-15 16:17:08.783922+03	\N	\N
709	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:17:19.518467+03	10	\N	\N	1	\N		22742	2017-07-15 16:17:19.498101+03	\N	\N
710	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:17:20.113911+03	10	\N	\N	1	\N		22742	2017-07-15 16:17:20.065481+03	\N	\N
711	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:19:53.334746+03	10	\N	\N	1	\N		22993	2017-07-15 16:19:53.289499+03	\N	\N
712	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:19:54.559786+03	10	\N	\N	1	\N		22993	2017-07-15 16:19:54.536287+03	\N	\N
713	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:20:00.263709+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:00.242074+03	\N	\N
714	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:20:01.250831+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:01.23431+03	\N	\N
715	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:20:12.548663+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:12.522348+03	\N	\N
716	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:20:13.32969+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:13.309558+03	\N	\N
717	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:20:24.453638+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:24.430074+03	\N	\N
718	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:20:25.947805+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:25.931315+03	\N	\N
719	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:20:32.481939+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:32.458273+03	\N	\N
720	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:20:33.541794+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:33.524531+03	\N	\N
721	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:20:39.695921+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:39.676444+03	\N	\N
722	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:20:41.024043+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:41.007958+03	\N	\N
723	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:20:51.826111+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:51.802021+03	\N	\N
724	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:20:53.310053+03	10	\N	\N	1	\N		22993	2017-07-15 16:20:53.292211+03	\N	\N
725	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:21:03.93747+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:03.914148+03	\N	\N
726	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:21:05.464057+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:05.448866+03	\N	\N
727	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:21:11.10834+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:11.081306+03	\N	\N
728	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:21:12.423814+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:12.390057+03	\N	\N
729	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:21:23.269523+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:23.246568+03	\N	\N
730	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:21:24.473667+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:24.455772+03	\N	\N
731	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:21:30.414229+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:30.393453+03	\N	\N
732	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:21:31.750805+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:31.739347+03	\N	\N
733	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:21:43.178161+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:43.151546+03	\N	\N
734	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:21:44.525345+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:44.509668+03	\N	\N
735	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:21:50.138272+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:50.114831+03	\N	\N
736	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:21:51.513825+03	10	\N	\N	1	\N		22993	2017-07-15 16:21:51.492963+03	\N	\N
737	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:22:03.113684+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:03.071762+03	\N	\N
738	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:22:04.263098+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:04.243373+03	\N	\N
739	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:22:10.727567+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:10.709223+03	\N	\N
740	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:22:11.881702+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:11.864415+03	\N	\N
741	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:22:22.76479+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:22.741806+03	\N	\N
742	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:22:23.925085+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:23.909838+03	\N	\N
743	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:22:30.45915+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:30.440091+03	\N	\N
744	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:22:31.687225+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:31.67493+03	\N	\N
745	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-15 16:22:42.552706+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:42.529789+03	\N	\N
746	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-15 16:22:43.352511+03	10	\N	\N	1	\N		22993	2017-07-15 16:22:43.329844+03	\N	\N
747	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:27:09.430766+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:09.378523+03	\N	\N
748	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:27:11.061327+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:10.133397+03	\N	\N
749	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:27:12.579368+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:12.554193+03	\N	\N
750	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:27:13.564071+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:13.535202+03	\N	\N
751	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:27:14.114059+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:14.092397+03	\N	\N
752	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:27:15.2713+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:15.249846+03	\N	\N
753	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:27:16.398468+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:16.375517+03	\N	\N
754	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:27:17.666035+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:17.643623+03	\N	\N
755	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:27:18.335611+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:18.308821+03	\N	\N
756	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:27:19.484468+03	10	\N	\N	1	\N		29269	2017-07-21 09:27:19.463452+03	\N	\N
757	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:29:19.987283+03	10	\N	\N	1	\N		29649	2017-07-21 09:29:19.966062+03	\N	\N
758	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:29:21.013563+03	10	\N	\N	1	\N		29649	2017-07-21 09:29:21.005101+03	\N	\N
759	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:29:26.89238+03	10	\N	\N	1	\N		29649	2017-07-21 09:29:26.870666+03	\N	\N
760	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:29:27.781203+03	10	\N	\N	1	\N		29649	2017-07-21 09:29:27.772428+03	\N	\N
761	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:29:56.796374+03	30	\N	\N	1	\N		29697	2017-07-21 09:29:56.77356+03	\N	\N
762	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:29:58.093583+03	30	\N	\N	1	\N		29697	2017-07-21 09:29:58.084385+03	\N	\N
763	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:30:23.730651+03	30	\N	\N	1	\N		29697	2017-07-21 09:30:23.706485+03	\N	\N
764	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:30:24.883796+03	30	\N	\N	1	\N		29697	2017-07-21 09:30:24.875963+03	\N	\N
765	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:30:56.543935+03	30	\N	\N	1	\N		29697	2017-07-21 09:30:56.517632+03	\N	\N
766	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:30:57.430831+03	30	\N	\N	1	\N		29697	2017-07-21 09:30:57.420124+03	\N	\N
767	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:31:28.613995+03	30	\N	\N	1	\N		29697	2017-07-21 09:31:28.592619+03	\N	\N
768	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:31:29.351336+03	30	\N	\N	1	\N		29697	2017-07-21 09:31:29.345315+03	\N	\N
769	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:31:55.457418+03	30	\N	\N	1	\N		29697	2017-07-21 09:31:55.434322+03	\N	\N
770	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:31:56.103435+03	30	\N	\N	1	\N		29697	2017-07-21 09:31:56.095565+03	\N	\N
771	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:32:26.934908+03	30	\N	\N	1	\N		29697	2017-07-21 09:32:26.916026+03	\N	\N
772	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:32:27.824134+03	30	\N	\N	1	\N		29697	2017-07-21 09:32:27.816084+03	\N	\N
773	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:33:35.5654+03	30	\N	\N	1	\N		29984	2017-07-21 09:33:35.5421+03	\N	\N
774	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:33:36.985841+03	30	\N	\N	1	\N		29984	2017-07-21 09:33:36.975966+03	\N	\N
775	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:33:38.085489+03	30	\N	\N	1	\N		29984	2017-07-21 09:33:38.053534+03	\N	\N
776	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:33:38.997067+03	30	\N	\N	1	\N		29984	2017-07-21 09:33:38.989074+03	\N	\N
777	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:34:10.295281+03	30	\N	\N	1	\N		29984	2017-07-21 09:34:10.269515+03	\N	\N
778	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:34:11.304031+03	30	\N	\N	1	\N		29984	2017-07-21 09:34:11.297023+03	\N	\N
779	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:34:42.225772+03	30	\N	\N	1	\N		29984	2017-07-21 09:34:42.20128+03	\N	\N
780	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:34:42.981675+03	30	\N	\N	1	\N		29984	2017-07-21 09:34:42.97417+03	\N	\N
781	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:35:08.822624+03	30	\N	\N	1	\N		29984	2017-07-21 09:35:08.776158+03	\N	\N
782	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:35:10.699748+03	30	\N	\N	1	\N		29984	2017-07-21 09:35:09.951483+03	\N	\N
783	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:35:42.367919+03	30	\N	\N	1	\N		29984	2017-07-21 09:35:42.345945+03	\N	\N
784	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:35:43.876583+03	30	\N	\N	1	\N		29984	2017-07-21 09:35:43.861079+03	\N	\N
785	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:36:10.124935+03	30	\N	\N	1	\N		29984	2017-07-21 09:36:10.100601+03	\N	\N
786	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:36:10.93837+03	30	\N	\N	1	\N		29984	2017-07-21 09:36:10.922558+03	\N	\N
787	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:36:41.603236+03	30	\N	\N	1	\N		29984	2017-07-21 09:36:41.577575+03	\N	\N
788	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:36:42.448583+03	30	\N	\N	1	\N		29984	2017-07-21 09:36:42.433475+03	\N	\N
789	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:37:08.550834+03	30	\N	\N	1	\N		29984	2017-07-21 09:37:08.529498+03	\N	\N
790	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:37:09.46709+03	30	\N	\N	1	\N		29984	2017-07-21 09:37:09.45168+03	\N	\N
791	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:37:40.304086+03	30	\N	\N	1	\N		29984	2017-07-21 09:37:40.280618+03	\N	\N
792	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:37:41.268656+03	30	\N	\N	1	\N		29984	2017-07-21 09:37:41.249021+03	\N	\N
793	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:38:07.614485+03	30	\N	\N	1	\N		29984	2017-07-21 09:38:07.593283+03	\N	\N
794	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:38:08.833797+03	30	\N	\N	1	\N		29984	2017-07-21 09:38:08.827636+03	\N	\N
795	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:44:40.94662+03	30	\N	\N	1	\N		30571	2017-07-21 09:44:40.919206+03	\N	\N
796	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:44:41.782586+03	30	\N	\N	1	\N		30571	2017-07-21 09:44:41.776397+03	\N	\N
797	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:45:13.417333+03	30	\N	\N	1	\N		30571	2017-07-21 09:45:13.392832+03	\N	\N
798	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:45:14.924082+03	30	\N	\N	1	\N		30571	2017-07-21 09:45:14.915948+03	\N	\N
799	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:45:41.182898+03	30	\N	\N	1	\N		30571	2017-07-21 09:45:41.157925+03	\N	\N
800	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:45:42.070242+03	30	\N	\N	1	\N		30571	2017-07-21 09:45:42.061361+03	\N	\N
801	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:46:13.627781+03	30	\N	\N	1	\N		30571	2017-07-21 09:46:13.606674+03	\N	\N
802	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:46:14.306213+03	30	\N	\N	1	\N		30571	2017-07-21 09:46:14.297909+03	\N	\N
803	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:49:54.443329+03	30	\N	\N	1	\N		30848	2017-07-21 09:49:54.420811+03	\N	\N
804	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:49:55.36237+03	30	\N	\N	1	\N		30848	2017-07-21 09:49:55.354429+03	\N	\N
805	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:50:26.302495+03	30	\N	\N	1	\N		30848	2017-07-21 09:50:26.269043+03	\N	\N
806	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:50:27.441267+03	30	\N	\N	1	\N		30848	2017-07-21 09:50:27.433238+03	\N	\N
807	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:50:53.808113+03	30	\N	\N	1	\N		30848	2017-07-21 09:50:53.75884+03	\N	\N
808	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:50:55.753959+03	30	\N	\N	1	\N		30848	2017-07-21 09:50:54.942756+03	\N	\N
809	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:51:26.940793+03	30	\N	\N	1	\N		30848	2017-07-21 09:51:26.919933+03	\N	\N
810	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:51:27.497316+03	30	\N	\N	1	\N		30848	2017-07-21 09:51:27.483489+03	\N	\N
811	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:51:53.566089+03	30	\N	\N	1	\N		30848	2017-07-21 09:51:53.543785+03	\N	\N
812	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:51:54.245194+03	30	\N	\N	1	\N		30848	2017-07-21 09:51:54.224151+03	\N	\N
813	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:52:25.766054+03	30	\N	\N	1	\N		30848	2017-07-21 09:52:25.745134+03	\N	\N
814	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:52:26.634004+03	30	\N	\N	1	\N		30848	2017-07-21 09:52:26.625396+03	\N	\N
815	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:52:52.498576+03	30	\N	\N	1	\N		30848	2017-07-21 09:52:52.477071+03	\N	\N
816	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:52:53.984115+03	30	\N	\N	1	\N		30848	2017-07-21 09:52:53.977558+03	\N	\N
817	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:53:24.966073+03	30	\N	\N	1	\N		30848	2017-07-21 09:53:24.944499+03	\N	\N
818	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:53:25.54687+03	30	\N	\N	1	\N		30848	2017-07-21 09:53:25.540657+03	\N	\N
819	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:53:56.974724+03	30	\N	\N	1	\N		30848	2017-07-21 09:53:56.947308+03	\N	\N
820	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:53:57.751317+03	30	\N	\N	1	\N		30848	2017-07-21 09:53:57.728445+03	\N	\N
821	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:54:23.591267+03	30	\N	\N	1	\N		30848	2017-07-21 09:54:23.561027+03	\N	\N
822	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:54:24.443716+03	30	\N	\N	1	\N		30848	2017-07-21 09:54:24.43519+03	\N	\N
823	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:54:55.871664+03	30	\N	\N	1	\N		30848	2017-07-21 09:54:55.842314+03	\N	\N
824	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:54:57.384055+03	30	\N	\N	1	\N		30848	2017-07-21 09:54:57.377838+03	\N	\N
825	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:55:23.271118+03	30	\N	\N	1	\N		30848	2017-07-21 09:55:23.245546+03	\N	\N
826	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:55:24.340207+03	30	\N	\N	1	\N		30848	2017-07-21 09:55:24.332812+03	\N	\N
827	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:55:55.207311+03	30	\N	\N	1	\N		30848	2017-07-21 09:55:55.185774+03	\N	\N
828	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:55:55.768144+03	30	\N	\N	1	\N		30848	2017-07-21 09:55:55.760912+03	\N	\N
829	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:56:27.176548+03	30	\N	\N	1	\N		30848	2017-07-21 09:56:27.147379+03	\N	\N
830	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:56:27.702337+03	30	\N	\N	1	\N		30848	2017-07-21 09:56:27.692755+03	\N	\N
831	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:56:54.013963+03	30	\N	\N	1	\N		30848	2017-07-21 09:56:53.993759+03	\N	\N
832	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:56:54.661007+03	30	\N	\N	1	\N		30848	2017-07-21 09:56:54.65414+03	\N	\N
833	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:57:25.340219+03	30	\N	\N	1	\N		30848	2017-07-21 09:57:25.318296+03	\N	\N
834	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:57:26.295636+03	30	\N	\N	1	\N		30848	2017-07-21 09:57:26.287392+03	\N	\N
835	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:57:36.206529+03	30	\N	\N	1	\N		31368	2017-07-21 09:57:36.164941+03	\N	\N
836	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:57:36.945301+03	30	\N	\N	1	\N		31368	2017-07-21 09:57:36.939242+03	\N	\N
837	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:58:03.172234+03	30	\N	\N	1	\N		31368	2017-07-21 09:58:03.14988+03	\N	\N
838	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:58:04.601027+03	30	\N	\N	1	\N		31368	2017-07-21 09:58:04.592377+03	\N	\N
839	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:58:35.658562+03	30	\N	\N	1	\N		31368	2017-07-21 09:58:35.638008+03	\N	\N
840	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:58:37.033687+03	30	\N	\N	1	\N		31368	2017-07-21 09:58:37.027639+03	\N	\N
841	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:59:02.878883+03	30	\N	\N	1	\N		31368	2017-07-21 09:59:02.849234+03	\N	\N
842	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:59:04.347049+03	30	\N	\N	1	\N		31368	2017-07-21 09:59:04.338544+03	\N	\N
843	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 09:59:35.370275+03	30	\N	\N	1	\N		31368	2017-07-21 09:59:35.347448+03	\N	\N
844	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 09:59:36.307641+03	30	\N	\N	1	\N		31368	2017-07-21 09:59:36.297592+03	\N	\N
845	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:00:07.531754+03	30	\N	\N	1	\N		31368	2017-07-21 10:00:07.506811+03	\N	\N
846	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:00:08.63162+03	30	\N	\N	1	\N		31368	2017-07-21 10:00:08.625207+03	\N	\N
847	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:00:34.372366+03	30	\N	\N	1	\N		31368	2017-07-21 10:00:34.344453+03	\N	\N
848	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:00:35.273278+03	30	\N	\N	1	\N		31368	2017-07-21 10:00:35.266419+03	\N	\N
849	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:01:06.797784+03	30	\N	\N	1	\N		31368	2017-07-21 10:01:06.775796+03	\N	\N
850	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:01:07.999222+03	30	\N	\N	1	\N		31368	2017-07-21 10:01:07.993122+03	\N	\N
851	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:01:33.887392+03	30	\N	\N	1	\N		31368	2017-07-21 10:01:33.851198+03	\N	\N
852	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:01:35.186052+03	30	\N	\N	1	\N		31368	2017-07-21 10:01:35.177169+03	\N	\N
853	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:02:05.936198+03	30	\N	\N	1	\N		31368	2017-07-21 10:02:05.905566+03	\N	\N
854	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:02:06.923376+03	30	\N	\N	1	\N		31368	2017-07-21 10:02:06.914985+03	\N	\N
855	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:02:33.222809+03	30	\N	\N	1	\N		31368	2017-07-21 10:02:33.188787+03	\N	\N
856	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:02:33.859228+03	30	\N	\N	1	\N		31368	2017-07-21 10:02:33.854087+03	\N	\N
857	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:03:04.818162+03	30	\N	\N	1	\N		31368	2017-07-21 10:03:04.776678+03	\N	\N
858	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:03:06.161745+03	30	\N	\N	1	\N		31368	2017-07-21 10:03:06.154545+03	\N	\N
859	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:03:36.969988+03	30	\N	\N	1	\N		31368	2017-07-21 10:03:36.946388+03	\N	\N
860	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:03:38.146419+03	30	\N	\N	1	\N		31368	2017-07-21 10:03:38.136153+03	\N	\N
861	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:04:03.939963+03	30	\N	\N	1	\N		31368	2017-07-21 10:04:03.9092+03	\N	\N
862	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:04:05.053466+03	30	\N	\N	1	\N		31368	2017-07-21 10:04:05.046393+03	\N	\N
863	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:04:36.190435+03	30	\N	\N	1	\N		31368	2017-07-21 10:04:36.138294+03	\N	\N
864	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:04:37.681818+03	30	\N	\N	1	\N		31368	2017-07-21 10:04:37.173192+03	\N	\N
865	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:05:03.691965+03	30	\N	\N	1	\N		31368	2017-07-21 10:05:03.664243+03	\N	\N
866	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:05:05.16415+03	30	\N	\N	1	\N		31368	2017-07-21 10:05:05.149548+03	\N	\N
867	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:05:36.159332+03	30	\N	\N	1	\N		31368	2017-07-21 10:05:36.138408+03	\N	\N
868	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:05:38.412631+03	30	\N	\N	1	\N		31368	2017-07-21 10:05:37.539042+03	\N	\N
869	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:06:04.777537+03	30	\N	\N	1	\N		31368	2017-07-21 10:06:04.753686+03	\N	\N
870	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:06:06.216293+03	30	\N	\N	1	\N		31368	2017-07-21 10:06:06.212135+03	\N	\N
871	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:06:37.543409+03	30	\N	\N	1	\N		31368	2017-07-21 10:06:37.522722+03	\N	\N
872	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:06:38.62955+03	30	\N	\N	1	\N		31368	2017-07-21 10:06:38.619042+03	\N	\N
873	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:07:04.536655+03	30	\N	\N	1	\N		31368	2017-07-21 10:07:04.507613+03	\N	\N
874	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:07:05.589495+03	30	\N	\N	1	\N		31368	2017-07-21 10:07:05.580397+03	\N	\N
875	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:07:36.589257+03	30	\N	\N	1	\N		31368	2017-07-21 10:07:36.569529+03	\N	\N
876	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:07:37.50008+03	30	\N	\N	1	\N		31368	2017-07-21 10:07:37.491565+03	\N	\N
877	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:09:14.562426+03	30	\N	\N	1	\N		32216	2017-07-21 10:09:14.538771+03	\N	\N
878	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:09:15.982732+03	30	\N	\N	1	\N		32216	2017-07-21 10:09:15.973742+03	\N	\N
879	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:09:42.239841+03	30	\N	\N	1	\N		32216	2017-07-21 10:09:42.212301+03	\N	\N
880	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:09:43.301927+03	30	\N	\N	1	\N		32216	2017-07-21 10:09:43.295392+03	\N	\N
881	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:10:14.439427+03	30	\N	\N	1	\N		32216	2017-07-21 10:10:14.388141+03	\N	\N
882	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:10:16.944729+03	30	\N	\N	1	\N		32216	2017-07-21 10:10:15.669876+03	\N	\N
883	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:10:42.815876+03	30	\N	\N	1	\N		32216	2017-07-21 10:10:42.794192+03	\N	\N
884	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:10:44.098855+03	30	\N	\N	1	\N		32216	2017-07-21 10:10:44.074137+03	\N	\N
885	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:11:15.281103+03	30	\N	\N	1	\N		32216	2017-07-21 10:11:15.260097+03	\N	\N
886	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:11:16.196473+03	30	\N	\N	1	\N		32216	2017-07-21 10:11:16.1573+03	\N	\N
887	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:11:42.452875+03	30	\N	\N	1	\N		32216	2017-07-21 10:11:42.423698+03	\N	\N
888	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:11:43.205756+03	30	\N	\N	1	\N		32216	2017-07-21 10:11:43.196596+03	\N	\N
889	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:12:14.080577+03	30	\N	\N	1	\N		32216	2017-07-21 10:12:14.058525+03	\N	\N
890	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:12:15.528354+03	30	\N	\N	1	\N		32216	2017-07-21 10:12:15.522289+03	\N	\N
891	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:12:42.050735+03	30	\N	\N	1	\N		32216	2017-07-21 10:12:42.029965+03	\N	\N
892	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:12:43.493944+03	30	\N	\N	1	\N		32216	2017-07-21 10:12:43.485896+03	\N	\N
893	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:13:14.18279+03	30	\N	\N	1	\N		32216	2017-07-21 10:13:14.16162+03	\N	\N
894	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:13:15.652271+03	30	\N	\N	1	\N		32216	2017-07-21 10:13:15.646422+03	\N	\N
895	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:13:41.643132+03	30	\N	\N	1	\N		32216	2017-07-21 10:13:41.619945+03	\N	\N
896	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:13:42.476007+03	30	\N	\N	1	\N		32216	2017-07-21 10:13:42.468207+03	\N	\N
897	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:14:13.50785+03	30	\N	\N	1	\N		32216	2017-07-21 10:14:13.468917+03	\N	\N
898	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:14:14.658417+03	30	\N	\N	1	\N		32216	2017-07-21 10:14:14.649317+03	\N	\N
899	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:14:45.381055+03	30	\N	\N	1	\N		32216	2017-07-21 10:14:45.361016+03	\N	\N
900	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:14:45.98187+03	30	\N	\N	1	\N		32216	2017-07-21 10:14:45.975508+03	\N	\N
901	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:15:11.863647+03	30	\N	\N	1	\N		32216	2017-07-21 10:15:11.805872+03	\N	\N
902	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:15:13.212766+03	30	\N	\N	1	\N		32216	2017-07-21 10:15:13.193115+03	\N	\N
903	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:15:43.883066+03	30	\N	\N	1	\N		32216	2017-07-21 10:15:43.861772+03	\N	\N
904	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:15:44.990876+03	30	\N	\N	1	\N		32216	2017-07-21 10:15:44.983354+03	\N	\N
905	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:16:58.2455+03	30	\N	\N	1	\N		32651	2017-07-21 10:16:58.226019+03	\N	\N
906	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:16:59.400643+03	30	\N	\N	1	\N		32651	2017-07-21 10:16:59.395406+03	\N	\N
907	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:17:00.857486+03	30	\N	\N	1	\N		32651	2017-07-21 10:17:00.829713+03	\N	\N
908	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:17:01.396382+03	30	\N	\N	1	\N		32651	2017-07-21 10:17:01.390658+03	\N	\N
909	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:17:27.698021+03	30	\N	\N	1	\N		32651	2017-07-21 10:17:27.670053+03	\N	\N
910	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:17:28.346867+03	30	\N	\N	1	\N		32651	2017-07-21 10:17:28.339809+03	\N	\N
911	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:17:59.604695+03	30	\N	\N	1	\N		32651	2017-07-21 10:17:59.58199+03	\N	\N
912	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:18:00.955233+03	30	\N	\N	1	\N		32651	2017-07-21 10:18:00.946512+03	\N	\N
913	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:18:27.374521+03	30	\N	\N	1	\N		32651	2017-07-21 10:18:27.350703+03	\N	\N
914	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:18:27.927489+03	30	\N	\N	1	\N		32651	2017-07-21 10:18:27.921858+03	\N	\N
915	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:18:59.550184+03	30	\N	\N	1	\N		32651	2017-07-21 10:18:59.5054+03	\N	\N
916	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:19:01.717261+03	30	\N	\N	1	\N		32651	2017-07-21 10:19:00.065045+03	\N	\N
917	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:19:27.986143+03	30	\N	\N	1	\N		32651	2017-07-21 10:19:27.956494+03	\N	\N
918	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:19:29.324765+03	30	\N	\N	1	\N		32651	2017-07-21 10:19:29.297595+03	\N	\N
919	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:19:55.037581+03	30	\N	\N	1	\N		32651	2017-07-21 10:19:55.016137+03	\N	\N
920	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:19:56.262403+03	30	\N	\N	1	\N		32651	2017-07-21 10:19:56.253128+03	\N	\N
921	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:20:27.674648+03	30	\N	\N	1	\N		32651	2017-07-21 10:20:27.650899+03	\N	\N
922	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:20:28.782156+03	30	\N	\N	1	\N		32651	2017-07-21 10:20:28.771525+03	\N	\N
923	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:20:55.290466+03	30	\N	\N	1	\N		32651	2017-07-21 10:20:55.269672+03	\N	\N
924	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:20:56.78593+03	30	\N	\N	1	\N		32651	2017-07-21 10:20:56.775569+03	\N	\N
925	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:21:28.119103+03	30	\N	\N	1	\N		32651	2017-07-21 10:21:28.087323+03	\N	\N
926	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:21:29.134713+03	30	\N	\N	1	\N		32651	2017-07-21 10:21:29.128557+03	\N	\N
927	gisModule.tasks.blame_module_check_blame_status	[[], {}]	a4454e4d36a59c7aa142f622e19cc299bd3405b9	\N	0	2017-07-21 10:21:54.845435+03	30	\N	\N	1	\N		32651	2017-07-21 10:21:54.825276+03	\N	\N
928	gisModule.tasks.blame_module_check_proposal	[[], {}]	a842445229471e7e5a85ae1ac715c02c2f962556	\N	0	2017-07-21 10:21:55.703535+03	30	\N	\N	1	\N		32651	2017-07-21 10:21:55.698457+03	\N	\N
\.


--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 323
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('background_task_completedtask_id_seq', 928, true);


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 325
-- Name: background_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('background_task_id_seq', 1069, true);


--
-- TOC entry 4574 (class 0 OID 28672)
-- Dependencies: 280
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
\.


--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 281
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1080, true);


--
-- TOC entry 4576 (class 0 OID 28681)
-- Dependencies: 282
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
\.


--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 283
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('django_content_type_id_seq', 38, true);


--
-- TOC entry 4578 (class 0 OID 28686)
-- Dependencies: 284
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
\.


--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 285
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('django_migrations_id_seq', 119, true);


--
-- TOC entry 4580 (class 0 OID 28694)
-- Dependencies: 286
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
x8e6jw412bj46wti0iwusxzewvst4k2c	ZWU3YzEzZDU2MzFiNGRiOTExYzY2NmFlYTVhZTRhNDZkMGQwNzYyNTp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MTY5ZTY4Yzk5NDVhZmZiZWU4Mzk2N2RhOWQyNzU1ZGFhNGJlNzAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-02-09 11:50:43.379592+03
emvb8bsosbq2b9jwivlkdj09k9d8vqsb	ZTI1ZjYxOTYwYmIyNmI1NzhjMTE5Nzg1NjhmODYxNmM5NTlkNTA3Zjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMjg1Yzk5NzgxYWRiNmM4YTM1NDAzMjY2YTVhOTdjNzBhMWQ5MGMyIn0=	2017-02-18 03:21:49.528261+03
6z126t6gugg7jixmo37z0p9z5jvorw9n	ZTI1ZjYxOTYwYmIyNmI1NzhjMTE5Nzg1NjhmODYxNmM5NTlkNTA3Zjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMjg1Yzk5NzgxYWRiNmM4YTM1NDAzMjY2YTVhOTdjNzBhMWQ5MGMyIn0=	2017-03-14 09:07:11.470064+03
wdqhiyptlx7gxfn047qhn0ewkeav1mcg	NmVmNjJmZGM0MDZlNjliZGI0MTIwYWIxNDdmMTZjMzFlNTZiM2I0MTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMjg1Yzk5NzgxYWRiNmM4YTM1NDAzMjY2YTVhOTdjNzBhMWQ5MGMyIiwidXNlcl9sb2dpbl9zZXNzaW9uIjp7InVzZXJJRCI6MiwidXNlcm5hbWUiOiJ0b3p5ZXIiLCJmaXJzdG5hbWUiOiJUYW5zZWwiLCJsYXN0TmFtZSI6Ilx1MDBkNnp5ZXIifX0=	2017-03-20 14:53:53.10314+03
j3da2chyhoaumjwga71io03ip3osazdx	OWQyNDc4ZTQwZjc5Njc1NWIxMmM4ZWMwNTdjNzhjYzQ3NjY0ZTVlYTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifX0=	2017-03-20 17:22:26.218839+03
1mac3ncwn1cf7pz66cuhkb4iupq4m2sp	ZWQ4NDYwNjhiM2IzNzUwNzFiY2FkM2QyN2U3YWI1YzU3MzI1YTBhNzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjZDMzZmM2MzY2MmRiYjlkZTZlNGUyNzMyYjViNTUwMWRjNmM1MTIxIiwidXNlcl9sb2dpbl9zZXNzaW9uIjp7InVzZXJJRCI6MSwidXNlcm5hbWUiOiJkeWFuaWtvZ2x1IiwiZmlyc3RuYW1lIjoiRG9cdTAxMWZhIENhbiIsImxhc3ROYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9fQ==	2017-03-21 13:51:52.199337+03
y3zkdm61gn1ktpd5yn9mzsg2zqzokyog	NmU0ODU3MWNjNDc2OWQyZWRmZTc4NjI0YmMwYTU4NmZkODI5ZGNjZDp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjIsInVzZXJuYW1lIjoidG96eWVyIiwiZmlyc3RuYW1lIjoiVGFuc2VsIiwibGFzdE5hbWUiOiJcdTAwZDZ6eWVyIn0sIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjZDMzZmM2MzY2MmRiYjlkZTZlNGUyNzMyYjViNTUwMWRjNmM1MTIxIn0=	2017-03-21 16:19:44.393681+03
hxu28meoy99wz3urt486kncja72rwcve	ODYxYjk5ZTNkOTlhNTJjNzcxOThhY2MzMmZhOWI2NDQ3YWYwOGFlNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiYmRjOTg2Mjk2NzQ0ZTUzZjRmMDMyN2QxZmU0OGM4NGE4MWZkNThmZSIsInVzZXJfbG9naW5fc2Vzc2lvbiI6eyJmaXJzdG5hbWUiOiJUYW5zZWwiLCJ1c2VySUQiOjIsImxhc3ROYW1lIjoiXHUwMGQ2enllciIsInVzZXJuYW1lIjoidG96eWVyIn0sIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-04-03 15:51:09.753963+03
h6vs8uux0s5jvytn0j7xxxbhfmyqzg8t	OTNlMTUwMWYyZDFmMmRmZmFjYTAyNjdiNGM3ZGRjNjliMGJjNjU1OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidXNlcl9sb2dpbl9zZXNzaW9uIjp7InVzZXJJRCI6MSwidXNlcm5hbWUiOiJkeWFuaWtvZ2x1IiwibGFzdE5hbWUiOiJZYW5cdTAxMzFrb1x1MDExZmx1IiwiZmlyc3RuYW1lIjoiRG9cdTAxMWZhIENhbiJ9LCJfYXV0aF91c2VyX2hhc2giOiJiZGM5ODYyOTY3NDRlNTNmNGYwMzI3ZDFmZTQ4Yzg0YTgxZmQ1OGZlIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==	2017-04-05 18:28:56.45442+03
3tcnjm7i7avhtwy8zhzdrmjcm7icsw4a	Y2EzNGVhMmU5YjU4Y2MyOTk3ZjQxN2FmZGU1ODBiYjViNDQ5YzllNzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiZGM5ODYyOTY3NDRlNTNmNGYwMzI3ZDFmZTQ4Yzg0YTgxZmQ1OGZlIiwidXNlcl9sb2dpbl9zZXNzaW9uIjp7InVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsInVzZXJJRCI6MSwiZmlyc3RuYW1lIjoiRG9cdTAxMWZhIENhbiIsImxhc3ROYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9fQ==	2017-04-21 15:29:37.577468+03
s5wdg7ivotnyw51dl6rc2jfcxt0veyvl	NmZiNjI0MDRlMTE3ZTk0YzY2MjM0NDI0MzY3NDg0YjMxOWYzYjFjMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkYzk4NjI5Njc0NGU1M2Y0ZjAzMjdkMWZlNDhjODRhODFmZDU4ZmUiLCJfYXV0aF91c2VyX2lkIjoiMSIsInVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjEsImxhc3ROYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSIsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4ifSwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==	2017-04-28 02:02:05.695477+03
qvtxbfnt808454v2q8uye26n8a9zmgs9	YzQ3MjA2Y2ExMGFhODFkZTFjYTcwZjUyMTI4ODVlNGViMzI0MzU4OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwidXNlcl9sb2dpbl9zZXNzaW9uIjp7InVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImxhc3ROYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJ1c2VySUQiOjF9LCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImJkYzk4NjI5Njc0NGU1M2Y0ZjAzMjdkMWZlNDhjODRhODFmZDU4ZmUifQ==	2017-05-12 02:07:52.618092+03
asgel6eej1w9x91j0i3x326ebgmkhi02	MDJjOTAxODM0MDZiN2M5YzQ3ZTNmOGU2MWM5Y2RmMGM5NGVmNTU4NTp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkYzk4NjI5Njc0NGU1M2Y0ZjAzMjdkMWZlNDhjODRhODFmZDU4ZmUiLCJfYXV0aF91c2VyX2lkIjoiMSIsInVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifSwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==	2017-05-18 16:43:44.471024+03
pfkoezrinpne2r6xwl554q30xn3v090i	YjFjM2RlZTVkZGQxMzNhNDBjYTAxMDI1ODhjZWVlMzQ4MTFmMzUwYjp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU3NmI2NTdhZWYxMzc4YWZkZThmYzM2YzM2MWUwNTJkMWNjMTI0YjgifQ==	2017-05-19 08:19:54.020044+03
vhjz5dg4sq4raunwliddoawo8ra1acx7	MGY2MTVhNTliNjVlYTAxZmVlNTdjYmFiZTI1OGI3ZDlhMTgyOGJiMzp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjEyLCJ1c2VybmFtZSI6InRlc3RfYWNjMiIsImZpcnN0bmFtZSI6IlRlc3QiLCJsYXN0TmFtZSI6IkFjY291bnQgMiJ9fQ==	2017-05-28 09:47:58.092505+03
vkjr9tth9avrdo1f7ig6jk50bijagph5	OWQyNDc4ZTQwZjc5Njc1NWIxMmM4ZWMwNTdjNzhjYzQ3NjY0ZTVlYTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifX0=	2017-05-24 14:02:58.808894+03
3i9x2nta5z3svq00p7be1gt9mh3oy4dj	ZjQ1MzI4OTc4OGMxYzgyYmM1ZGEyMjAzZmVhYThlMjdiMTJiOTkyZDp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjExLCJ1c2VybmFtZSI6InRlc3RfYWNjIiwiZmlyc3RuYW1lIjoidGVzdCIsImxhc3ROYW1lIjoiYWNjb3VudCJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTc2YjY1N2FlZjEzNzhhZmRlOGZjMzZjMzYxZTA1MmQxY2MxMjRiOCJ9	2017-05-25 08:43:23.802106+03
p0uz918jwnu9f7rbholjwo9oyib8yhjb	OTJkNjUxNTFkMjc3YmRhOGM3YjlkZDYwYzBiYWZiZDhjZjY0M2I2Yzp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJ1c2VySUQiOjExLCJ1c2VybmFtZSI6InRlc3RfYWNjIiwiZmlyc3RuYW1lIjoidGVzdCIsImxhc3ROYW1lIjoiYWNjb3VudCJ9fQ==	2017-05-25 09:03:03.464994+03
ozg4brg6tl1tzh7b0tvpphn6631ktn54	ZGI3MjBiMDUwMDdlMmJhZmQyNzNjNzQ3N2NhYjc1Nzc5Y2U4ZGFkZTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU3NmI2NTdhZWYxMzc4YWZkZThmYzM2YzM2MWUwNTJkMWNjMTI0YjgifQ==	2017-05-26 09:00:36.462918+03
8ie8oncth7q5pgwc2jyd7kl33ajh0485	ZGI3MjBiMDUwMDdlMmJhZmQyNzNjNzQ3N2NhYjc1Nzc5Y2U4ZGFkZTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU3NmI2NTdhZWYxMzc4YWZkZThmYzM2YzM2MWUwNTJkMWNjMTI0YjgifQ==	2017-05-27 10:42:56.604157+03
zoscz5ylzgtiw77z77ttboptdusapoal	ZGI3MjBiMDUwMDdlMmJhZmQyNzNjNzQ3N2NhYjc1Nzc5Y2U4ZGFkZTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU3NmI2NTdhZWYxMzc4YWZkZThmYzM2YzM2MWUwNTJkMWNjMTI0YjgifQ==	2017-05-27 11:06:59.546527+03
5sw3fonp16ezdaj8naa4371hbms6lcsm	ZGI3MjBiMDUwMDdlMmJhZmQyNzNjNzQ3N2NhYjc1Nzc5Y2U4ZGFkZTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU3NmI2NTdhZWYxMzc4YWZkZThmYzM2YzM2MWUwNTJkMWNjMTI0YjgifQ==	2017-05-27 14:05:56.204061+03
xna3en62tneal14gbtk066z3nf02ndxn	ZWRmYTYxZjVhMjU0MmRiNWJhNjRiMWJiODcwOGEwMDFhMGE3MGYxZTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjEsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0bmFtZSI6IkRvXHUwMTFmYSBDYW4iLCJsYXN0TmFtZSI6Illhblx1MDEzMWtvXHUwMTFmbHUifX0=	2017-05-28 09:48:33.386345+03
837sxh61jp0bfovhgg0yks0o3bhm3jyx	MmE5MTM1ZTY5NTkxODRmYWRjY2Q1MDhmOWY3OGMzOGQ1NDgwYzI2Zjp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJ1c2VySUQiOjExLCJ1c2VybmFtZSI6InRlc3RfYWNjIiwiZmlyc3RuYW1lIjoidGVzdCIsImxhc3ROYW1lIjoiYWNjb3VudCJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTc2YjY1N2FlZjEzNzhhZmRlOGZjMzZjMzYxZTA1MmQxY2MxMjRiOCJ9	2017-05-28 10:23:09.927389+03
y5dl21a3b6yf4jzpozthftcgyum577n2	ODZiZTE5YjY2ZTI5MWM2NTAzYzk5NDJlMzcxYWE3ZTRjYjhlY2YxOTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MTYsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0X25hbWUiOiJEb1x1MDExZmEgQ2FuIiwibGFzdF9uYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9fQ==	2017-05-31 08:21:34.00498+03
cl1ujzcxjiyf951yv8bbq11l1sqqgw1q	ZjUzNzg4NzNlYzQzYzMwNzRmYTdiNGZmNWIzMDE1ZjJlMTcxZmFhYjp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MTksInVzZXJuYW1lIjoidGVzdF8xIiwiZmlyc3RfbmFtZSI6ImFhYSIsImxhc3RfbmFtZSI6ImJiYiJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTc2YjY1N2FlZjEzNzhhZmRlOGZjMzZjMzYxZTA1MmQxY2MxMjRiOCJ9	2017-06-05 15:10:33.269076+03
w28n7t1qq1w7rfgaooug5ygtssncuxzc	Y2U5MDQ3Y2Q1ODIwYjY2MmJlZDUxZWRlNTRhYjUxNmZmODNhM2NmZTp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MjAsInVzZXJuYW1lIjoidGVzdDIiLCJmaXJzdF9uYW1lIjoidGVzdDIiLCJsYXN0X25hbWUiOiJ0ZXN0MiJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTc2YjY1N2FlZjEzNzhhZmRlOGZjMzZjMzYxZTA1MmQxY2MxMjRiOCJ9	2017-06-05 15:10:52.27789+03
l24i6k1wcza1fn9jmbkdlwysigvfmnqd	YWNkNWVkZGE3MjZhNmZiNmJlNDUwMzExYjlkNTE5YTI2NWZlMzg1Mjp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MTYsInVzZXJuYW1lIjoiZHlhbmlrb2dsdSIsImZpcnN0X25hbWUiOiJEb1x1MDExZmEgQ2FuIiwibGFzdF9uYW1lIjoiWWFuXHUwMTMxa29cdTAxMWZsdSJ9LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTc2YjY1N2FlZjEzNzhhZmRlOGZjMzZjMzYxZTA1MmQxY2MxMjRiOCJ9	2017-07-28 14:07:56.895412+03
n2b3pnpelx0ha4y9s9vlr82d504cn3bq	NGEwNzBlNWRhZTc0NWZlMTg5YmQ1YTYxNDIzODllODAzMzBkMGM3Yzp7InVzZXJfbG9naW5fc2Vzc2lvbiI6eyJzdGF0dXMiOiJsb2dnZWRfaW4iLCJpZCI6MTgsInVzZXJuYW1lIjoidGVzdCIsImZpcnN0X25hbWUiOiJUZXN0IiwibGFzdF9uYW1lIjoiQWNjIn0sIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1NzZiNjU3YWVmMTM3OGFmZGU4ZmMzNmMzNjFlMDUyZDFjYzEyNGI4In0=	2017-08-04 09:31:32.669955+03
\.


--
-- TOC entry 4581 (class 0 OID 28700)
-- Dependencies: 287
-- Data for Name: gisModule_baseproduct; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_baseproduct" ("productID", brand, type, amount, unit, group_id, name) FROM stdin;
19	Pınar	Süt	1	L	40	Pınar Süt 1L
20	Sütaş	Süt	1	L	40	Sütaş Süt 1L
21	Coca-Cola		1	L	41	Coca-Cola  1L
22	Sek	Süt	1	L	40	Sek Süt 1L
23	A	Süt	1	L	40	A Süt 1L
24	B	Süt	1	L	40	B Süt 1L
25	C	Süt	1000	ML	40	C Süt 1000ML
26	Test	Product	1	L	41	Test Product 1L
\.


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 288
-- Name: gisModule_baseproduct_productID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_baseproduct_productID_seq"', 26, true);


--
-- TOC entry 4616 (class 0 OID 29257)
-- Dependencies: 322
-- Data for Name: gisModule_blame; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_blame" (id, created_at, user_id, retailer_product_id, updated_at) FROM stdin;
26	2017-07-21 10:09:50.357533+03	18	255	2017-07-21 10:09:50.357556+03
27	2017-07-21 10:09:55.933219+03	16	255	2017-07-21 10:09:55.933237+03
28	2017-07-21 10:18:15.570199+03	16	256	2017-07-21 10:18:15.570216+03
29	2017-07-21 10:18:37.508147+03	18	256	2017-07-21 10:18:37.508168+03
\.


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 321
-- Name: gisModule_blame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_blame_id_seq"', 29, true);


--
-- TOC entry 4583 (class 0 OID 28706)
-- Dependencies: 289
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
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 290
-- Name: gisModule_city_cityID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_city_cityID_seq"', 1, false);


--
-- TOC entry 4585 (class 0 OID 28711)
-- Dependencies: 291
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
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 292
-- Name: gisModule_district_districtID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_district_districtID_seq"', 1, false);


--
-- TOC entry 4622 (class 0 OID 29396)
-- Dependencies: 328
-- Data for Name: gisModule_falsepriceproposal; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_falsepriceproposal" (id, status_code, created_at, updated_at, retailer_id, retailer_product_id, answer_count, send_count) FROM stdin;
18	3	2017-07-21 10:10:14.435634+03	2017-07-21 10:11:16.191236+03	31	255	2	2
19	3	2017-07-21 10:18:59.54487+03	2017-07-21 10:19:29.322849+03	10	256	2	2
\.


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 327
-- Name: gisModule_falsepriceproposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_falsepriceproposal_id_seq"', 19, true);


--
-- TOC entry 4608 (class 0 OID 29097)
-- Dependencies: 314
-- Data for Name: gisModule_friend; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_friend" (id, date, status, user_receiver_id, user_sender_id) FROM stdin;
69	2017-05-22 14:36:01.93343+03	t	16	18
72	2017-05-22 15:12:50.974843+03	t	20	19
73	2017-07-16 22:55:00.384672+03	f	20	16
\.


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 313
-- Name: gisModule_friend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_friend_id_seq"', 73, true);


--
-- TOC entry 4610 (class 0 OID 29105)
-- Dependencies: 316
-- Data for Name: gisModule_group; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_group" (id, name, date) FROM stdin;
113	Another Group?	2017-05-18 12:00:37.97283+03
114	Just A Test Group	2017-05-22 14:36:18.629319+03
115	aile	2017-05-22 15:14:03.163363+03
\.


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 315
-- Name: gisModule_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_group_id_seq"', 116, true);


--
-- TOC entry 4612 (class 0 OID 29113)
-- Dependencies: 318
-- Data for Name: gisModule_groupmember; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_groupmember" (id, group_id, member_id, role_id, date) FROM stdin;
152	113	16	1	2017-05-18 12:00:37.984551+03
153	114	18	1	2017-05-22 14:36:18.644626+03
154	114	16	2	2017-05-22 14:36:22.992699+03
155	115	20	1	2017-05-22 15:14:03.173391+03
156	115	19	2	2017-05-22 15:14:07.945795+03
\.


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 317
-- Name: gisModule_groupmember_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_groupmember_id_seq"', 158, true);


--
-- TOC entry 4587 (class 0 OID 28717)
-- Dependencies: 293
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
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 294
-- Name: gisModule_productgroup_productGroupID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_productgroup_productGroupID_seq"', 47, true);


--
-- TOC entry 4624 (class 0 OID 29404)
-- Dependencies: 330
-- Data for Name: gisModule_proposalsent; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_proposalsent" (id, created_at, updated_at, response, false_price_proposal_id, user_id) FROM stdin;
35	2017-07-21 10:10:16.852221+03	2017-07-21 10:10:25.683747+03	t	18	16
34	2017-07-21 10:10:15.681715+03	2017-07-21 10:10:31.878843+03	t	18	18
37	2017-07-21 10:19:01.624652+03	2017-07-21 10:19:11.787127+03	f	19	18
36	2017-07-21 10:19:00.077735+03	2017-07-21 10:19:22.876012+03	t	19	16
\.


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 329
-- Name: gisModule_proposalsent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_proposalsent_id_seq"', 37, true);


--
-- TOC entry 4589 (class 0 OID 28725)
-- Dependencies: 295
-- Data for Name: gisModule_retailer; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_retailer" (name, id, address, "cityID", "districtID", geolocation, zip_code, type_id, created_at, updated_at, reputation) FROM stdin;
Ankamall AVM	9	Ankamall, Akköprü, Konya Devlet Yolu Mevlana Bulvarı No:2, 06330 Yenimahalle/Ankara, Turkey	6	73	0101000020E61000004EED0C535B6A40408E01D9EBDDF94340	06330	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Atlantis AVM	10	Kardelen Mahallesi, Başkent Blv. 224 H, 06370 Yenimahalle/Ankara, Turkey	6	73	0101000020E61000002733DE567A5B4040F6CFD38041FC4340	06370	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Kentpark AVM	11	Mustafa Kemal Mahallesi, Eskişehir Yolu 7. Km No:164, 06800 Çankaya/Ankara, Turkey	6	63	0101000020E61000009F7D9BB45F634040F53D343D72F44340	06800	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Gordion AVM	12	Koru Mahallesi, Ankaralılar Cd. No:2, 06810 Çankaya/Ankara, Turkey	6	63	0101000020E610000012B00C60805840405EE7F05A53F34340	06810	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Panora AVM	13	No:182, Oran Mahallesi, Kudüs Cd., 06450 Çankaya/Ankara, Turkey	6	63	0101000020E6100000639CBF09856A404052D32EA699EC4340	06450	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Kızılay AVM	14	Kızılay Mahallesi, Gazi Mustafa Kemal Blv., 06420 Çankaya/Ankara, Turkey	6	63	0101000020E61000008E7340B73C6D4040E810DD58F5F54340	06420	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Cepa AVM	15	Mustafa Kemal Mahallesi, CEPA AVM, 06510 Çankaya/Ankara, Turkey	6	63	0101000020E610000034DAAA24B2634040444C89247AF44340	06510	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Armada AVM	16	No:, Eskişehir Yolu (Dumlupınar Blv.) No:6, 06520, Turkey	\N	\N	0101000020E6100000AE9D2809896740401013C3C4D5F44340	06520	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Nata Vega	29	Akşemsettin Mahallesi, Nata Vega Outlet, 06480 Mamak/Ankara, Turkey	6	76	0101000020E61000001D21037976774040F148BC3C9DF14340	06480	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Arcadium AVM	30	Çayyolu Mahallesi, 2432. Cd (8. Cd.) No:192, 06810 Yenimahalle/Ankara, Turkey	6	73	0101000020E61000004983DBDAC2574040CFF9298E03F14340	06810	2	2017-05-18 09:18:31.678298+03	2017-05-18 09:18:31.74768+03	500
Test Retailer	31	Cumhuriyet Mh. Inkılap Sk. No:4 Kızılay, Çankaya Mahallesi, 06420 Ankara, Turkey	6	\N	0101000020E6100000037AE1CE856D4040729A05DA1DF64340	06420	2	2017-07-21 09:23:22.858614+03	2017-07-21 10:11:16.193045+03	450
\.


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 296
-- Name: gisModule_retailer_retailerID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_retailer_retailerID_seq"', 31, true);


--
-- TOC entry 4591 (class 0 OID 28735)
-- Dependencies: 297
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
200	21	21	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
201	18	22	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
202	14	23	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
203	25	24	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
204	9	25	10	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
205	22	19	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
206	23	20	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
207	20	21	9	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
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
221	17	21	30	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
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
235	23	21	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
236	25	22	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
237	1	23	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
239	4	25	15	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
240	13	19	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
241	12	20	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
242	6	21	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
243	4	22	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
244	14	23	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
245	10	24	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
246	7	25	14	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
247	7	19	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
248	4	20	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
249	7	21	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
250	13	22	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
251	21	23	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
252	8	24	13	2017-05-18 09:18:31.806294+03	2017-05-18 09:18:31.882811+03	0	f	f
184	5	19	12	2017-05-18 09:18:31.806294+03	2017-07-14 16:29:50.212055+03	0	f	f
186	23	21	12	2017-05-18 09:18:31.806294+03	2017-07-14 16:51:50.995355+03	0	f	f
220	2	20	30	2017-05-18 09:18:31.806294+03	2017-07-14 16:53:44.304363+03	0	f	f
253	12	25	13	2017-05-18 09:18:31.806294+03	2017-07-15 14:09:11.542144+03	150	t	f
238	8	24	15	2017-05-18 09:18:31.806294+03	2017-07-15 14:26:47.473497+03	999	t	f
189	1	24	12	2017-05-18 09:18:31.806294+03	2017-07-15 14:26:47.482873+03	999	t	f
191	12	19	11	2017-05-18 09:18:31.806294+03	2017-07-15 16:08:18.391114+03	999	t	f
185	20	20	12	2017-05-18 09:18:31.806294+03	2017-07-15 16:08:18.395445+03	999	t	f
193	19	21	11	2017-05-18 09:18:31.806294+03	2017-07-21 09:28:29.081137+03	0	f	f
228	8	21	16	2017-05-18 09:18:31.806294+03	2017-07-21 09:28:57.693961+03	0	f	f
192	20	20	11	2017-05-18 09:18:31.806294+03	2017-07-15 16:17:07.37237+03	999	t	t
255	10	26	31	2017-07-21 09:23:53.222187+03	2017-07-21 10:11:16.194501+03	100	t	t
187	19	22	12	2017-05-18 09:18:31.806294+03	2017-07-15 16:22:03.111697+03	200	t	t
256	32	26	10	2017-07-21 09:24:02.670919+03	2017-07-21 10:19:29.321679+03	0	f	f
254	5	19	31	2017-07-21 09:23:42.946771+03	2017-07-21 09:23:42.946796+03	0	f	f
257	55	26	30	2017-07-21 09:24:12.269384+03	2017-07-21 09:24:12.269412+03	0	f	f
258	66	26	13	2017-07-21 09:24:21.679042+03	2017-07-21 09:24:21.679084+03	0	f	f
\.


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 298
-- Name: gisModule_retailerproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_retailerproduct_id_seq"', 258, true);


--
-- TOC entry 4593 (class 0 OID 28740)
-- Dependencies: 299
-- Data for Name: gisModule_retailertype; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_retailertype" ("retailerTypeID", "retailerTypeName") FROM stdin;
2	Shopping Center
1	Supermarket
\.


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 300
-- Name: gisModule_retailertype_retailerTypeID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_retailertype_retailerTypeID_seq"', 1, false);


--
-- TOC entry 4614 (class 0 OID 29121)
-- Dependencies: 320
-- Data for Name: gisModule_role; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_role" (id, name) FROM stdin;
1	Admin
2	Member
\.


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 319
-- Name: gisModule_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_role_id_seq"', 2, true);


--
-- TOC entry 4595 (class 0 OID 28745)
-- Dependencies: 301
-- Data for Name: gisModule_shoppinglist; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_shoppinglist" (id, created_at, completed, name, updated_at) FROM stdin;
39	2017-05-17 09:34:27.860489+03	f	My First Shopping List	2017-05-17 09:34:27.860524+03
40	2017-05-18 11:56:19.290948+03	f	Just A Test List	2017-05-18 11:56:19.290973+03
41	2017-05-18 11:56:24.661607+03	f	Another Test List	2017-05-18 11:56:24.661635+03
42	2017-05-20 23:03:22.345035+03	f	My First Shopping List	2017-05-20 23:03:22.345073+03
43	2017-05-22 15:17:28.553159+03	f	abc	2017-05-22 15:17:28.553191+03
\.


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 302
-- Name: gisModule_shoppinglist_listID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_shoppinglist_listID_seq"', 43, true);


--
-- TOC entry 4597 (class 0 OID 28750)
-- Dependencies: 303
-- Data for Name: gisModule_shoppinglistitem; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_shoppinglistitem" (id, product_id, quantity, list_id, "addedBy_id", edited_by_id) FROM stdin;
441	19	1	42	17	17
443	22	4	42	17	17
444	25	1	42	17	17
442	20	10	42	17	17
445	19	1	\N	20	20
446	20	1	\N	20	20
464	23	1	39	16	16
462	24	1	39	16	16
450	23	1	43	20	20
451	24	1	43	20	20
452	25	1	43	20	20
461	21	10	39	16	16
463	25	4	39	16	18
465	26	2	39	18	16
449	22	2	43	20	20
448	20	24	43	20	20
447	19	3	43	20	20
\.


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 304
-- Name: gisModule_shoppinglistitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_shoppinglistitems_id_seq"', 465, true);


--
-- TOC entry 4605 (class 0 OID 28783)
-- Dependencies: 311
-- Data for Name: gisModule_shoppinglistmember; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_shoppinglistmember" (id, list_id, user_id, role_id) FROM stdin;
48	39	16	1
49	40	16	1
50	41	16	1
51	42	17	1
52	39	18	2
53	43	19	1
54	43	20	2
\.


--
-- TOC entry 4599 (class 0 OID 28761)
-- Dependencies: 305
-- Data for Name: gisModule_user; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_user" (id, username, password, first_name, last_name, active_list_id, preferences_id, email, reputation) FROM stdin;
19	test_1	$pbkdf2-sha256$12000$lbJ2rrU2BsAYA8D4X0tp7Z1zDiEEIORcq3WudQ6hFEI$Da2gVrWtSlBETFufoQEHjPCc.82HyvYCBm9/W27wbPg	aaa	bbb	43	19	test1@test1.com	0
17	test_acc	$pbkdf2-sha256$12000$wvg/h1BKydlbS6lV6t3buxcCYGxNSWmtNcZ4DyEEAKA$3/usctjjIywSFnRJNUj5sLRtZI4cnCSi/6k530sZ7dU	Test	Acc	42	17	test@test.com	0
20	test2	$pbkdf2-sha256$12000$f0.JkfL.v9ca4/z/HyMEQCjlHON8771XqnUOQegdY.w$1r.eRkwNbh6knivbBbch2ybKhVh5QWDXu1xRQGVZfBA	test2	test2	43	20	test2@test2.com	200
18	test	$pbkdf2-sha256$12000$Qqg1JkQohfB.z5lTKsXY.9/bm3OO8R7DeK/13juH8B4$LC1em/d4wfOR7gL3qsKl6V/MrfdbGOwhC02GFyNtf6c	Test	Acc	39	18	test2@test.com	210
16	dyanikoglu	$pbkdf2-sha256$12000$Rsi5VwqhtJZSytmbU0pJ6d1ba03JmTNmjBGi9D5nTOk$ulJtktZ8kKbW96mYszzs48baMAoydf1HJeammjwNB5o	Doğa Can	Yanıkoğlu	39	16	dyanikoglu@outlook.com	195
\.


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 306
-- Name: gisModule_user_userID_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_user_userID_seq"', 20, true);


--
-- TOC entry 4601 (class 0 OID 28769)
-- Dependencies: 307
-- Data for Name: gisModule_userpreferences; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_userpreferences" (id, money_factor, dist_factor, time_factor, search_radius, route_end_point_id, route_start_point_id, get_notif_only_for_active_list, owner_id) FROM stdin;
17	t	t	t	100	35	35	t	17
18	t	t	t	100	\N	\N	t	18
19	t	t	t	100	37	37	t	19
20	t	t	t	100	39	39	t	20
16	t	t	t	100	34	33	t	16
\.


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 308
-- Name: gisModule_userpreferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_userpreferences_id_seq"', 20, true);


--
-- TOC entry 4603 (class 0 OID 28775)
-- Dependencies: 309
-- Data for Name: gisModule_usersavedaddress; Type: TABLE DATA; Schema: public; Owner: dyanikoglu
--

COPY "gisModule_usersavedaddress" (name, id, address, geolocation, zip_code, last_edit_time, city_id, district_id, user_id) FROM stdin;
Home	33	Turgut Özal, 2209. Sk., 06370 Yenimahalle/Ankara, Turkey	0101000020E6100000F36B35351A59404066D421DC09FF4340	\N	2017-05-17 11:40:54.316711+03	6	73	16
School	34	Söğütözü Mahallesi, Söğütözü Cd. No:43, 06560 Çankaya/Ankara, Turkey	0101000020E6100000336486D73F664040677EEB79EDF54340	06560	2017-05-18 12:00:13.221888+03	6	63	16
School	35	Söğütözü Mahallesi, Söğütözü Cd. No:43, 06560 Çankaya/Ankara, Turkey	0101000020E6100000336486D73F664040677EEB79EDF54340	06560	2017-05-20 23:04:09.028442+03	6	63	17
School	37	Söğütözü Mahallesi, Söğütözü Cd. No:43, 06560 Çankaya/Ankara, Turkey	0101000020E6100000336486D73F664040677EEB79EDF54340	06560	2017-05-22 15:19:47.827317+03	6	63	19
Kızılay	38	1, Çankaya Mahallesi, Necati Bey Cad. 28/7, 06420 Çankaya/Ankara, Turkey	0101000020E6100000698187B36C6D404061C66F65E4F54340	06420	2017-05-22 15:20:18.885276+03	6	63	19
School	39	Söğütözü Mahallesi, Söğütözü Cd. No:43, 06560 Çankaya/Ankara, Turkey	0101000020E6100000336486D73F664040677EEB79EDF54340	06560	2017-05-27 19:16:18.364046+03	6	63	20
\.


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 310
-- Name: gisModule_usersavedaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_usersavedaddress_id_seq"', 40, true);


--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 312
-- Name: gisModule_usershoppinglist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dyanikoglu
--

SELECT pg_catalog.setval('"gisModule_usershoppinglist_id_seq"', 54, true);


--
-- TOC entry 4138 (class 0 OID 26740)
-- Dependencies: 194
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


SET search_path = tiger, pg_catalog;

--
-- TOC entry 4132 (class 0 OID 28077)
-- Dependencies: 213
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- TOC entry 4133 (class 0 OID 28431)
-- Dependencies: 257
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4134 (class 0 OID 28443)
-- Dependencies: 259
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4135 (class 0 OID 28455)
-- Dependencies: 261
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_rules (id, rule, is_custom) FROM stdin;
\.


SET search_path = topology, pg_catalog;

--
-- TOC entry 4136 (class 0 OID 28501)
-- Dependencies: 263
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- TOC entry 4137 (class 0 OID 28514)
-- Dependencies: 264
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 4246 (class 2606 OID 28812)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 4252 (class 2606 OID 28814)
-- Name: auth_group_permissions auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 4254 (class 2606 OID 28816)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4248 (class 2606 OID 28818)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 4257 (class 2606 OID 28820)
-- Name: auth_permission auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 4259 (class 2606 OID 28822)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4268 (class 2606 OID 28824)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4270 (class 2606 OID 28826)
-- Name: auth_user_groups auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 4261 (class 2606 OID 28828)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4274 (class 2606 OID 28830)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4276 (class 2606 OID 28832)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 4264 (class 2606 OID 28834)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 4363 (class 2606 OID 29343)
-- Name: background_task_completedtask background_task_completedtask_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task_completedtask
    ADD CONSTRAINT background_task_completedtask_pkey PRIMARY KEY (id);


--
-- TOC entry 4379 (class 2606 OID 29355)
-- Name: background_task background_task_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task
    ADD CONSTRAINT background_task_pkey PRIMARY KEY (id);


--
-- TOC entry 4280 (class 2606 OID 28836)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4282 (class 2606 OID 28838)
-- Name: django_content_type django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 4284 (class 2606 OID 28840)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4286 (class 2606 OID 28842)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4289 (class 2606 OID 28844)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 4293 (class 2606 OID 28846)
-- Name: gisModule_baseproduct gisModule_baseproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_baseproduct"
    ADD CONSTRAINT "gisModule_baseproduct_pkey" PRIMARY KEY ("productID");


--
-- TOC entry 4353 (class 2606 OID 29262)
-- Name: gisModule_blame gisModule_blame_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame"
    ADD CONSTRAINT "gisModule_blame_pkey" PRIMARY KEY (id);


--
-- TOC entry 4295 (class 2606 OID 28848)
-- Name: gisModule_city gisModule_city_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_city"
    ADD CONSTRAINT "gisModule_city_pkey" PRIMARY KEY ("cityID");


--
-- TOC entry 4297 (class 2606 OID 28850)
-- Name: gisModule_district gisModule_district_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_district"
    ADD CONSTRAINT "gisModule_district_pkey" PRIMARY KEY ("districtID");


--
-- TOC entry 4389 (class 2606 OID 29401)
-- Name: gisModule_falsepriceproposal gisModule_falsepriceproposal_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal"
    ADD CONSTRAINT "gisModule_falsepriceproposal_pkey" PRIMARY KEY (id);


--
-- TOC entry 4340 (class 2606 OID 29102)
-- Name: gisModule_friend gisModule_friend_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend"
    ADD CONSTRAINT "gisModule_friend_pkey" PRIMARY KEY (id);


--
-- TOC entry 4344 (class 2606 OID 29110)
-- Name: gisModule_group gisModule_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_group"
    ADD CONSTRAINT "gisModule_group_pkey" PRIMARY KEY (id);


--
-- TOC entry 4348 (class 2606 OID 29118)
-- Name: gisModule_groupmember gisModule_groupmember_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmember_pkey" PRIMARY KEY (id);


--
-- TOC entry 4300 (class 2606 OID 28852)
-- Name: gisModule_productgroup gisModule_productgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_productgroup"
    ADD CONSTRAINT "gisModule_productgroup_pkey" PRIMARY KEY (id);


--
-- TOC entry 4394 (class 2606 OID 29409)
-- Name: gisModule_proposalsent gisModule_proposalsent_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent"
    ADD CONSTRAINT "gisModule_proposalsent_pkey" PRIMARY KEY (id);


--
-- TOC entry 4304 (class 2606 OID 28854)
-- Name: gisModule_retailer gisModule_retailer_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailer"
    ADD CONSTRAINT "gisModule_retailer_pkey" PRIMARY KEY (id);


--
-- TOC entry 4308 (class 2606 OID 28856)
-- Name: gisModule_retailerproduct gisModule_retailerproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct"
    ADD CONSTRAINT "gisModule_retailerproduct_pkey" PRIMARY KEY (id);


--
-- TOC entry 4310 (class 2606 OID 28858)
-- Name: gisModule_retailertype gisModule_retailertype_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailertype"
    ADD CONSTRAINT "gisModule_retailertype_pkey" PRIMARY KEY ("retailerTypeID");


--
-- TOC entry 4351 (class 2606 OID 29126)
-- Name: gisModule_role gisModule_role_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_role"
    ADD CONSTRAINT "gisModule_role_pkey" PRIMARY KEY (id);


--
-- TOC entry 4312 (class 2606 OID 28860)
-- Name: gisModule_shoppinglist gisModule_shoppinglist_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglist"
    ADD CONSTRAINT "gisModule_shoppinglist_pkey" PRIMARY KEY (id);


--
-- TOC entry 4318 (class 2606 OID 28862)
-- Name: gisModule_shoppinglistitem gisModule_shoppinglistitems_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppinglistitems_pkey" PRIMARY KEY (id);


--
-- TOC entry 4322 (class 2606 OID 28866)
-- Name: gisModule_user gisModule_user_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModule_user_pkey" PRIMARY KEY (id);


--
-- TOC entry 4327 (class 2606 OID 28868)
-- Name: gisModule_userpreferences gisModule_userpreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "gisModule_userpreferences_pkey" PRIMARY KEY (id);


--
-- TOC entry 4333 (class 2606 OID 28870)
-- Name: gisModule_usersavedaddress gisModule_usersavedaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_usersavedaddress_pkey" PRIMARY KEY (id);


--
-- TOC entry 4335 (class 2606 OID 28872)
-- Name: gisModule_shoppinglistmember gisModule_usershoppinglist_pkey; Type: CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppinglist_pkey" PRIMARY KEY (id);


--
-- TOC entry 4244 (class 1259 OID 28873)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 4249 (class 1259 OID 28874)
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- TOC entry 4250 (class 1259 OID 28875)
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- TOC entry 4255 (class 1259 OID 28876)
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- TOC entry 4265 (class 1259 OID 28877)
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- TOC entry 4266 (class 1259 OID 28878)
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- TOC entry 4271 (class 1259 OID 28879)
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 4272 (class 1259 OID 28880)
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 4262 (class 1259 OID 28881)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 4372 (class 1259 OID 29388)
-- Name: background_task_attempts_a9ade23d; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_attempts_a9ade23d ON background_task USING btree (attempts);


--
-- TOC entry 4356 (class 1259 OID 29369)
-- Name: background_task_completedtask_attempts_772a6783; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_attempts_772a6783 ON background_task_completedtask USING btree (attempts);


--
-- TOC entry 4357 (class 1259 OID 29374)
-- Name: background_task_completedtask_creator_content_type_id_21d6a741; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_creator_content_type_id_21d6a741 ON background_task_completedtask USING btree (creator_content_type_id);


--
-- TOC entry 4358 (class 1259 OID 29370)
-- Name: background_task_completedtask_failed_at_3de56618; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_failed_at_3de56618 ON background_task_completedtask USING btree (failed_at);


--
-- TOC entry 4359 (class 1259 OID 29373)
-- Name: background_task_completedtask_locked_at_29c62708; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_locked_at_29c62708 ON background_task_completedtask USING btree (locked_at);


--
-- TOC entry 4360 (class 1259 OID 29371)
-- Name: background_task_completedtask_locked_by_edc8a213; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213 ON background_task_completedtask USING btree (locked_by);


--
-- TOC entry 4361 (class 1259 OID 29372)
-- Name: background_task_completedtask_locked_by_edc8a213_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213_like ON background_task_completedtask USING btree (locked_by varchar_pattern_ops);


--
-- TOC entry 4364 (class 1259 OID 29365)
-- Name: background_task_completedtask_priority_9080692e; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_priority_9080692e ON background_task_completedtask USING btree (priority);


--
-- TOC entry 4365 (class 1259 OID 29367)
-- Name: background_task_completedtask_queue_61fb0415; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_queue_61fb0415 ON background_task_completedtask USING btree (queue);


--
-- TOC entry 4366 (class 1259 OID 29368)
-- Name: background_task_completedtask_queue_61fb0415_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_queue_61fb0415_like ON background_task_completedtask USING btree (queue varchar_pattern_ops);


--
-- TOC entry 4367 (class 1259 OID 29366)
-- Name: background_task_completedtask_run_at_77c80f34; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_run_at_77c80f34 ON background_task_completedtask USING btree (run_at);


--
-- TOC entry 4368 (class 1259 OID 29363)
-- Name: background_task_completedtask_task_hash_91187576; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_hash_91187576 ON background_task_completedtask USING btree (task_hash);


--
-- TOC entry 4369 (class 1259 OID 29364)
-- Name: background_task_completedtask_task_hash_91187576_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_hash_91187576_like ON background_task_completedtask USING btree (task_hash varchar_pattern_ops);


--
-- TOC entry 4370 (class 1259 OID 29361)
-- Name: background_task_completedtask_task_name_388dabc2; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_name_388dabc2 ON background_task_completedtask USING btree (task_name);


--
-- TOC entry 4371 (class 1259 OID 29362)
-- Name: background_task_completedtask_task_name_388dabc2_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_completedtask_task_name_388dabc2_like ON background_task_completedtask USING btree (task_name varchar_pattern_ops);


--
-- TOC entry 4373 (class 1259 OID 29393)
-- Name: background_task_creator_content_type_id_61cc9af3; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_creator_content_type_id_61cc9af3 ON background_task USING btree (creator_content_type_id);


--
-- TOC entry 4374 (class 1259 OID 29389)
-- Name: background_task_failed_at_b81bba14; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_failed_at_b81bba14 ON background_task USING btree (failed_at);


--
-- TOC entry 4375 (class 1259 OID 29392)
-- Name: background_task_locked_at_0fb0f225; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_locked_at_0fb0f225 ON background_task USING btree (locked_at);


--
-- TOC entry 4376 (class 1259 OID 29390)
-- Name: background_task_locked_by_db7779e3; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_locked_by_db7779e3 ON background_task USING btree (locked_by);


--
-- TOC entry 4377 (class 1259 OID 29391)
-- Name: background_task_locked_by_db7779e3_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_locked_by_db7779e3_like ON background_task USING btree (locked_by varchar_pattern_ops);


--
-- TOC entry 4380 (class 1259 OID 29384)
-- Name: background_task_priority_88bdbce9; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_priority_88bdbce9 ON background_task USING btree (priority);


--
-- TOC entry 4381 (class 1259 OID 29386)
-- Name: background_task_queue_1d5f3a40; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_queue_1d5f3a40 ON background_task USING btree (queue);


--
-- TOC entry 4382 (class 1259 OID 29387)
-- Name: background_task_queue_1d5f3a40_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_queue_1d5f3a40_like ON background_task USING btree (queue varchar_pattern_ops);


--
-- TOC entry 4383 (class 1259 OID 29385)
-- Name: background_task_run_at_7baca3aa; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_run_at_7baca3aa ON background_task USING btree (run_at);


--
-- TOC entry 4384 (class 1259 OID 29382)
-- Name: background_task_task_hash_d8f233bd; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_hash_d8f233bd ON background_task USING btree (task_hash);


--
-- TOC entry 4385 (class 1259 OID 29383)
-- Name: background_task_task_hash_d8f233bd_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_hash_d8f233bd_like ON background_task USING btree (task_hash varchar_pattern_ops);


--
-- TOC entry 4386 (class 1259 OID 29380)
-- Name: background_task_task_name_4562d56a; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_name_4562d56a ON background_task USING btree (task_name);


--
-- TOC entry 4387 (class 1259 OID 29381)
-- Name: background_task_task_name_4562d56a_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX background_task_task_name_4562d56a_like ON background_task USING btree (task_name varchar_pattern_ops);


--
-- TOC entry 4277 (class 1259 OID 28882)
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- TOC entry 4278 (class 1259 OID 28883)
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- TOC entry 4287 (class 1259 OID 28884)
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- TOC entry 4290 (class 1259 OID 28885)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 4291 (class 1259 OID 29061)
-- Name: gisModule_baseproduct_group_id_34e261a7; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_baseproduct_group_id_34e261a7" ON "gisModule_baseproduct" USING btree (group_id);


--
-- TOC entry 4354 (class 1259 OID 29275)
-- Name: gisModule_blame_retailer_product_id_4f9417eb; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_blame_retailer_product_id_4f9417eb" ON "gisModule_blame" USING btree (retailer_product_id);


--
-- TOC entry 4355 (class 1259 OID 29274)
-- Name: gisModule_blame_user_id_0e32af77; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_blame_user_id_0e32af77" ON "gisModule_blame" USING btree (user_id);


--
-- TOC entry 4390 (class 1259 OID 29428)
-- Name: gisModule_falsepriceproposal_retailer_id_9efb6d70; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_falsepriceproposal_retailer_id_9efb6d70" ON "gisModule_falsepriceproposal" USING btree (retailer_id);


--
-- TOC entry 4391 (class 1259 OID 29429)
-- Name: gisModule_falsepriceproposal_retailer_product_id_c575feec; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_falsepriceproposal_retailer_product_id_c575feec" ON "gisModule_falsepriceproposal" USING btree (retailer_product_id);


--
-- TOC entry 4341 (class 1259 OID 29162)
-- Name: gisModule_friend_user_receiver_id_0dfa7f87; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_friend_user_receiver_id_0dfa7f87" ON "gisModule_friend" USING btree (user_receiver_id);


--
-- TOC entry 4342 (class 1259 OID 29168)
-- Name: gisModule_friend_user_sender_id_446949ef; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_friend_user_sender_id_446949ef" ON "gisModule_friend" USING btree (user_sender_id);


--
-- TOC entry 4345 (class 1259 OID 29149)
-- Name: gisModule_groupmember_group_id_a23c8021; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_groupmember_group_id_a23c8021" ON "gisModule_groupmember" USING btree (group_id);


--
-- TOC entry 4346 (class 1259 OID 29150)
-- Name: gisModule_groupmember_member_id_35fb15d9; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_groupmember_member_id_35fb15d9" ON "gisModule_groupmember" USING btree (member_id);


--
-- TOC entry 4349 (class 1259 OID 29151)
-- Name: gisModule_groupmember_role_id_b77dd803; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_groupmember_role_id_b77dd803" ON "gisModule_groupmember" USING btree (role_id);


--
-- TOC entry 4298 (class 1259 OID 29054)
-- Name: gisModule_productgroup_parent_id_18a9ee55; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_productgroup_parent_id_18a9ee55" ON "gisModule_productgroup" USING btree (parent_id);


--
-- TOC entry 4392 (class 1259 OID 29440)
-- Name: gisModule_proposalsent_false_price_proposal_id_32dbe274; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_proposalsent_false_price_proposal_id_32dbe274" ON "gisModule_proposalsent" USING btree (false_price_proposal_id);


--
-- TOC entry 4395 (class 1259 OID 29441)
-- Name: gisModule_proposalsent_user_id_678622bf; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_proposalsent_user_id_678622bf" ON "gisModule_proposalsent" USING btree (user_id);


--
-- TOC entry 4301 (class 1259 OID 28886)
-- Name: gisModule_retailer_165eadd0; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailer_165eadd0" ON "gisModule_retailer" USING btree (type_id);


--
-- TOC entry 4302 (class 1259 OID 28887)
-- Name: gisModule_retailer_geoLocation_id; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailer_geoLocation_id" ON "gisModule_retailer" USING gist (geolocation);


--
-- TOC entry 4305 (class 1259 OID 28888)
-- Name: gisModule_retailerproduct_d3f2996a; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailerproduct_d3f2996a" ON "gisModule_retailerproduct" USING btree ("baseProduct_id");


--
-- TOC entry 4306 (class 1259 OID 28889)
-- Name: gisModule_retailerproduct_da9bf8d8; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_retailerproduct_da9bf8d8" ON "gisModule_retailerproduct" USING btree (retailer_id);


--
-- TOC entry 4313 (class 1259 OID 28890)
-- Name: gisModule_shoppinglistitem_addedBy_id_adc4d554; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_addedBy_id_adc4d554" ON "gisModule_shoppinglistitem" USING btree ("addedBy_id");


--
-- TOC entry 4314 (class 1259 OID 29089)
-- Name: gisModule_shoppinglistitem_edited_by_id_40fabd33; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_edited_by_id_40fabd33" ON "gisModule_shoppinglistitem" USING btree (edited_by_id);


--
-- TOC entry 4315 (class 1259 OID 28891)
-- Name: gisModule_shoppinglistitem_list_id_5c453dbd; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_list_id_5c453dbd" ON "gisModule_shoppinglistitem" USING btree (list_id);


--
-- TOC entry 4316 (class 1259 OID 28892)
-- Name: gisModule_shoppinglistitem_productID_id_653c920a; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_shoppinglistitem_productID_id_653c920a" ON "gisModule_shoppinglistitem" USING btree (product_id);


--
-- TOC entry 4319 (class 1259 OID 28896)
-- Name: gisModule_user_activeList_id_295659b1; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_user_activeList_id_295659b1" ON "gisModule_user" USING btree (active_list_id);


--
-- TOC entry 4320 (class 1259 OID 28897)
-- Name: gisModule_user_e7a82d8e; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_user_e7a82d8e" ON "gisModule_user" USING btree (preferences_id);


--
-- TOC entry 4323 (class 1259 OID 28898)
-- Name: gisModule_userpreferences_625a3d6f; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_userpreferences_625a3d6f" ON "gisModule_userpreferences" USING btree (route_end_point_id);


--
-- TOC entry 4324 (class 1259 OID 28899)
-- Name: gisModule_userpreferences_6b4166f7; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_userpreferences_6b4166f7" ON "gisModule_userpreferences" USING btree (route_start_point_id);


--
-- TOC entry 4325 (class 1259 OID 29208)
-- Name: gisModule_userpreferences_owner_id_068b30e8; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_userpreferences_owner_id_068b30e8" ON "gisModule_userpreferences" USING btree (owner_id);


--
-- TOC entry 4328 (class 1259 OID 28900)
-- Name: gisModule_usersavedaddress_a34a99d3; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_a34a99d3" ON "gisModule_usersavedaddress" USING btree (district_id);


--
-- TOC entry 4329 (class 1259 OID 28901)
-- Name: gisModule_usersavedaddress_c7141997; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_c7141997" ON "gisModule_usersavedaddress" USING btree (city_id);


--
-- TOC entry 4330 (class 1259 OID 28902)
-- Name: gisModule_usersavedaddress_e8701ad4; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_e8701ad4" ON "gisModule_usersavedaddress" USING btree (user_id);


--
-- TOC entry 4331 (class 1259 OID 28903)
-- Name: gisModule_usersavedaddress_geoLocation_id; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usersavedaddress_geoLocation_id" ON "gisModule_usersavedaddress" USING gist (geolocation);


--
-- TOC entry 4336 (class 1259 OID 29189)
-- Name: gisModule_usershoppinglist_role_id_151e7ed5; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usershoppinglist_role_id_151e7ed5" ON "gisModule_shoppinglistmember" USING btree (role_id);


--
-- TOC entry 4337 (class 1259 OID 28904)
-- Name: gisModule_usershoppinglist_shoppingList_id_dc541570; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usershoppinglist_shoppingList_id_dc541570" ON "gisModule_shoppinglistmember" USING btree (list_id);


--
-- TOC entry 4338 (class 1259 OID 28905)
-- Name: gisModule_usershoppinglist_user_id_ddc92d37; Type: INDEX; Schema: public; Owner: dyanikoglu
--

CREATE INDEX "gisModule_usershoppinglist_user_id_ddc92d37" ON "gisModule_shoppinglistmember" USING btree (user_id);


--
-- TOC entry 4397 (class 2606 OID 28916)
-- Name: auth_group_permissions auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4396 (class 2606 OID 28921)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4398 (class 2606 OID 28926)
-- Name: auth_permission auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4400 (class 2606 OID 28931)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4399 (class 2606 OID 28936)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4402 (class 2606 OID 28941)
-- Name: auth_user_user_permissions auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4401 (class 2606 OID 28946)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4432 (class 2606 OID 29356)
-- Name: background_task_completedtask background_task_comp_creator_content_type_21d6a741_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task_completedtask
    ADD CONSTRAINT background_task_comp_creator_content_type_21d6a741_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4433 (class 2606 OID 29375)
-- Name: background_task background_task_creator_content_type_61cc9af3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY background_task
    ADD CONSTRAINT background_task_creator_content_type_61cc9af3_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4404 (class 2606 OID 28951)
-- Name: django_admin_log django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4403 (class 2606 OID 28956)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4418 (class 2606 OID 28961)
-- Name: gisModule_userpreferences gi_route_end_point_id_82643daa_fk_gisModule_usersavedaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "gi_route_end_point_id_82643daa_fk_gisModule_usersavedaddress_id" FOREIGN KEY (route_end_point_id) REFERENCES "gisModule_usersavedaddress"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4409 (class 2606 OID 28966)
-- Name: gisModule_retailerproduct gisM_baseProduct_id_8c637d4a_fk_gisModule_baseproduct_productID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct"
    ADD CONSTRAINT "gisM_baseProduct_id_8c637d4a_fk_gisModule_baseproduct_productID" FOREIGN KEY ("baseProduct_id") REFERENCES "gisModule_baseproduct"("productID") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4415 (class 2606 OID 28971)
-- Name: gisModule_user gisModu_preferences_id_b607083d_fk_gisModule_userpreferences_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModu_preferences_id_b607083d_fk_gisModule_userpreferences_id" FOREIGN KEY (preferences_id) REFERENCES "gisModule_userpreferences"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4405 (class 2606 OID 29062)
-- Name: gisModule_baseproduct gisModule_baseproduc_group_id_34e261a7_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_baseproduct"
    ADD CONSTRAINT "gisModule_baseproduc_group_id_34e261a7_fk_gisModule" FOREIGN KEY (group_id) REFERENCES "gisModule_productgroup"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4430 (class 2606 OID 29276)
-- Name: gisModule_blame gisModule_blame_retailer_product_id_4f9417eb_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame"
    ADD CONSTRAINT "gisModule_blame_retailer_product_id_4f9417eb_fk_gisModule" FOREIGN KEY (retailer_product_id) REFERENCES "gisModule_retailerproduct"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4431 (class 2606 OID 29268)
-- Name: gisModule_blame gisModule_blame_user_id_0e32af77_fk_gisModule_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_blame"
    ADD CONSTRAINT "gisModule_blame_user_id_0e32af77_fk_gisModule_user_id" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4421 (class 2606 OID 28976)
-- Name: gisModule_usersavedaddress gisModule_district_id_e1e5f4da_fk_gisModule_district_districtID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_district_id_e1e5f4da_fk_gisModule_district_districtID" FOREIGN KEY (district_id) REFERENCES "gisModule_district"("districtID") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4435 (class 2606 OID 29418)
-- Name: gisModule_falsepriceproposal gisModule_falseprice_retailer_id_9efb6d70_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal"
    ADD CONSTRAINT "gisModule_falseprice_retailer_id_9efb6d70_fk_gisModule" FOREIGN KEY (retailer_id) REFERENCES "gisModule_retailer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4434 (class 2606 OID 29423)
-- Name: gisModule_falsepriceproposal gisModule_falseprice_retailer_product_id_c575feec_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_falsepriceproposal"
    ADD CONSTRAINT "gisModule_falseprice_retailer_product_id_c575feec_fk_gisModule" FOREIGN KEY (retailer_product_id) REFERENCES "gisModule_retailerproduct"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4426 (class 2606 OID 29163)
-- Name: gisModule_friend gisModule_friend_user_receiver_id_0dfa7f87_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend"
    ADD CONSTRAINT "gisModule_friend_user_receiver_id_0dfa7f87_fk_gisModule" FOREIGN KEY (user_receiver_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4425 (class 2606 OID 29169)
-- Name: gisModule_friend gisModule_friend_user_sender_id_446949ef_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_friend"
    ADD CONSTRAINT "gisModule_friend_user_sender_id_446949ef_fk_gisModule" FOREIGN KEY (user_sender_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4428 (class 2606 OID 29144)
-- Name: gisModule_groupmember gisModule_groupmembe_member_id_35fb15d9_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmembe_member_id_35fb15d9_fk_gisModule" FOREIGN KEY (member_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4429 (class 2606 OID 29139)
-- Name: gisModule_groupmember gisModule_groupmember_group_id_a23c8021_fk_gisModule_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmember_group_id_a23c8021_fk_gisModule_group_id" FOREIGN KEY (group_id) REFERENCES "gisModule_group"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4427 (class 2606 OID 29152)
-- Name: gisModule_groupmember gisModule_groupmember_role_id_b77dd803_fk_gisModule_role_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_groupmember"
    ADD CONSTRAINT "gisModule_groupmember_role_id_b77dd803_fk_gisModule_role_id" FOREIGN KEY (role_id) REFERENCES "gisModule_role"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4406 (class 2606 OID 29067)
-- Name: gisModule_productgroup gisModule_productgro_parent_id_18a9ee55_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_productgroup"
    ADD CONSTRAINT "gisModule_productgro_parent_id_18a9ee55_fk_gisModule" FOREIGN KEY (parent_id) REFERENCES "gisModule_productgroup"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4437 (class 2606 OID 29430)
-- Name: gisModule_proposalsent gisModule_proposalse_false_price_proposal_32dbe274_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent"
    ADD CONSTRAINT "gisModule_proposalse_false_price_proposal_32dbe274_fk_gisModule" FOREIGN KEY (false_price_proposal_id) REFERENCES "gisModule_falsepriceproposal"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4436 (class 2606 OID 29435)
-- Name: gisModule_proposalsent gisModule_proposalsent_user_id_678622bf_fk_gisModule_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_proposalsent"
    ADD CONSTRAINT "gisModule_proposalsent_user_id_678622bf_fk_gisModule_user_id" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4408 (class 2606 OID 28981)
-- Name: gisModule_retailerproduct gisModule_retailer_id_2bd4aec7_fk_gisModule_retailer_retailerID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailerproduct"
    ADD CONSTRAINT "gisModule_retailer_id_2bd4aec7_fk_gisModule_retailer_retailerID" FOREIGN KEY (retailer_id) REFERENCES "gisModule_retailer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4407 (class 2606 OID 29214)
-- Name: gisModule_retailer gisModule_retailer_type_id_525ded2f_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_retailer"
    ADD CONSTRAINT "gisModule_retailer_type_id_525ded2f_fk_gisModule" FOREIGN KEY (type_id) REFERENCES "gisModule_retailertype"("retailerTypeID") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4411 (class 2606 OID 29084)
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_addedBy_id_adc4d554_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_addedBy_id_adc4d554_fk_gisModule" FOREIGN KEY ("addedBy_id") REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4410 (class 2606 OID 29090)
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_edited_by_id_40fabd33_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_edited_by_id_40fabd33_fk_gisModule" FOREIGN KEY (edited_by_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4413 (class 2606 OID 28991)
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_list_id_5c453dbd_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_list_id_5c453dbd_fk_gisModule" FOREIGN KEY (list_id) REFERENCES "gisModule_shoppinglist"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4412 (class 2606 OID 28996)
-- Name: gisModule_shoppinglistitem gisModule_shoppingli_product_id_aaf576f5_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistitem"
    ADD CONSTRAINT "gisModule_shoppingli_product_id_aaf576f5_fk_gisModule" FOREIGN KEY (product_id) REFERENCES "gisModule_baseproduct"("productID") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4414 (class 2606 OID 29195)
-- Name: gisModule_user gisModule_user_active_list_id_0d34e0fd_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_user"
    ADD CONSTRAINT "gisModule_user_active_list_id_0d34e0fd_fk_gisModule" FOREIGN KEY (active_list_id) REFERENCES "gisModule_shoppinglist"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4416 (class 2606 OID 29209)
-- Name: gisModule_userpreferences gisModule_userprefer_owner_id_068b30e8_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "gisModule_userprefer_owner_id_068b30e8_fk_gisModule" FOREIGN KEY (owner_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4420 (class 2606 OID 29006)
-- Name: gisModule_usersavedaddress gisModule_usersavedad_city_id_75469ff6_fk_gisModule_city_cityID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_usersavedad_city_id_75469ff6_fk_gisModule_city_cityID" FOREIGN KEY (city_id) REFERENCES "gisModule_city"("cityID") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4419 (class 2606 OID 29011)
-- Name: gisModule_usersavedaddress gisModule_usersavedad_user_id_fffb5670_fk_gisModule_user_userID; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_usersavedaddress"
    ADD CONSTRAINT "gisModule_usersavedad_user_id_fffb5670_fk_gisModule_user_userID" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4423 (class 2606 OID 29184)
-- Name: gisModule_shoppinglistmember gisModule_usershoppi_list_id_5590f197_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppi_list_id_5590f197_fk_gisModule" FOREIGN KEY (list_id) REFERENCES "gisModule_shoppinglist"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4422 (class 2606 OID 29190)
-- Name: gisModule_shoppinglistmember gisModule_usershoppi_role_id_151e7ed5_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppi_role_id_151e7ed5_fk_gisModule" FOREIGN KEY (role_id) REFERENCES "gisModule_role"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4424 (class 2606 OID 29021)
-- Name: gisModule_shoppinglistmember gisModule_usershoppi_user_id_ddc92d37_fk_gisModule; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_shoppinglistmember"
    ADD CONSTRAINT "gisModule_usershoppi_user_id_ddc92d37_fk_gisModule" FOREIGN KEY (user_id) REFERENCES "gisModule_user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4417 (class 2606 OID 29036)
-- Name: gisModule_userpreferences route_start_point_id_d14e5950_fk_gisModule_usersavedaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: dyanikoglu
--

ALTER TABLE ONLY "gisModule_userpreferences"
    ADD CONSTRAINT "route_start_point_id_d14e5950_fk_gisModule_usersavedaddress_id" FOREIGN KEY (route_start_point_id) REFERENCES "gisModule_usersavedaddress"(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2017-07-21 10:42:14 +03

--
-- PostgreSQL database dump complete
--

\connect gisdb

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-07-21 10:42:14 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 14 (class 2615 OID 21297)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO dyanikoglu;

--
-- TOC entry 9 (class 2615 OID 21298)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO dyanikoglu;

--
-- TOC entry 11 (class 2615 OID 21299)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: dyanikoglu
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO dyanikoglu;

--
-- TOC entry 1 (class 3079 OID 12429)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 6 (class 3079 OID 21300)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 5 (class 3079 OID 21311)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 4 (class 3079 OID 22784)
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- TOC entry 2 (class 3079 OID 22939)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 3 (class 3079 OID 23366)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

--
-- TOC entry 3938 (class 0 OID 21608)
-- Dependencies: 194
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


SET search_path = tiger, pg_catalog;

--
-- TOC entry 3932 (class 0 OID 22945)
-- Dependencies: 213
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- TOC entry 3933 (class 0 OID 23299)
-- Dependencies: 257
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 3934 (class 0 OID 23311)
-- Dependencies: 259
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 3935 (class 0 OID 23323)
-- Dependencies: 261
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY pagc_rules (id, rule, is_custom) FROM stdin;
\.


SET search_path = topology, pg_catalog;

--
-- TOC entry 3936 (class 0 OID 23369)
-- Dependencies: 263
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- TOC entry 3937 (class 0 OID 23382)
-- Dependencies: 264
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


-- Completed on 2017-07-21 10:42:15 +03

--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-07-21 10:42:15 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2158 (class 1262 OID 12443)
-- Dependencies: 2157
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 2 (class 3079 OID 12429)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 23507)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


-- Completed on 2017-07-21 10:42:15 +03

--
-- PostgreSQL database dump complete
--

\connect temp_db

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-07-21 10:42:15 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12429)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


-- Completed on 2017-07-21 10:42:15 +03

--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-07-21 10:42:15 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2157 (class 1262 OID 1)
-- Dependencies: 2156
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- TOC entry 1 (class 3079 OID 12429)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


-- Completed on 2017-07-21 10:42:15 +03

--
-- PostgreSQL database dump complete
--

-- Completed on 2017-07-21 10:42:15 +03

--
-- PostgreSQL database cluster dump complete
--

