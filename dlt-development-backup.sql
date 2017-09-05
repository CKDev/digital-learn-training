--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO brinkman;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE attachments (
    id bigint NOT NULL,
    course_id integer,
    title character varying,
    doc_type character varying,
    file_description character varying,
    document_file_name character varying,
    document_content_type character varying,
    document_file_size integer,
    document_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE attachments OWNER TO brinkman;

--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attachments_id_seq OWNER TO brinkman;

--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE categories (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    tag character varying
);


ALTER TABLE categories OWNER TO brinkman;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO brinkman;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: course_material_files; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE course_material_files (
    id bigint NOT NULL,
    course_material_id integer,
    file_file_name character varying,
    file_content_type character varying,
    file_file_size integer,
    file_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE course_material_files OWNER TO brinkman;

--
-- Name: course_material_files_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE course_material_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE course_material_files_id_seq OWNER TO brinkman;

--
-- Name: course_material_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE course_material_files_id_seq OWNED BY course_material_files.id;


--
-- Name: course_material_media; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE course_material_media (
    id bigint NOT NULL,
    course_material_id integer,
    media_file_name character varying,
    media_content_type character varying,
    media_file_size integer,
    media_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE course_material_media OWNER TO brinkman;

--
-- Name: course_material_media_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE course_material_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE course_material_media_id_seq OWNER TO brinkman;

--
-- Name: course_material_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE course_material_media_id_seq OWNED BY course_material_media.id;


--
-- Name: course_material_videos; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE course_material_videos (
    id bigint NOT NULL,
    course_material_id integer,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE course_material_videos OWNER TO brinkman;

--
-- Name: course_material_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE course_material_videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE course_material_videos_id_seq OWNER TO brinkman;

--
-- Name: course_material_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE course_material_videos_id_seq OWNED BY course_material_videos.id;


--
-- Name: course_materials; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE course_materials (
    id bigint NOT NULL,
    title character varying(90),
    summary character varying(74),
    description text,
    contributor character varying(156),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sub_category_id integer,
    category_id integer,
    pub_status character varying DEFAULT 'D'::character varying
);


ALTER TABLE course_materials OWNER TO brinkman;

--
-- Name: course_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE course_materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE course_materials_id_seq OWNER TO brinkman;

--
-- Name: course_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE course_materials_id_seq OWNED BY course_materials.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE courses (
    id bigint NOT NULL,
    title character varying(90),
    seo_page_title character varying(90),
    meta_desc character varying(156),
    summary character varying(156),
    description text,
    notes text,
    contributor character varying,
    pub_status character varying(2) DEFAULT 'D'::character varying,
    slug character varying,
    course_order integer,
    pub_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE courses OWNER TO brinkman;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE courses_id_seq OWNER TO brinkman;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id bigint NOT NULL,
    slug character varying NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(50),
    scope character varying,
    created_at timestamp without time zone
);


ALTER TABLE friendly_id_slugs OWNER TO brinkman;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE friendly_id_slugs_id_seq OWNER TO brinkman;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE lessons (
    id bigint NOT NULL,
    lesson_order integer,
    parent_lesson_id integer,
    title character varying(90),
    duration integer,
    course_id integer,
    slug character varying,
    summary character varying(156),
    story_line character varying(156),
    seo_page_title character varying(90),
    meta_desc character varying(156),
    is_assessment boolean DEFAULT false NOT NULL,
    pub_status character varying(2) DEFAULT 'D'::character varying,
    story_line_file_name character varying,
    story_line_content_type character varying,
    story_line_file_size integer,
    story_line_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE lessons OWNER TO brinkman;

--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lessons_id_seq OWNER TO brinkman;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE lessons_id_seq OWNED BY lessons.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE pages (
    id bigint NOT NULL,
    title character varying(90),
    body text,
    pub_status character varying DEFAULT 0 NOT NULL,
    pub_at timestamp without time zone,
    slug character varying,
    author character varying(20),
    seo_title character varying(90),
    meta_desc character varying(156),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE pages OWNER TO brinkman;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pages_id_seq OWNER TO brinkman;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO brinkman;

--
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE sub_categories (
    id bigint NOT NULL,
    title character varying,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE sub_categories OWNER TO brinkman;

--
-- Name: sub_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE sub_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sub_categories_id_seq OWNER TO brinkman;

--
-- Name: sub_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE sub_categories_id_seq OWNED BY sub_categories.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    admin boolean DEFAULT false
);


ALTER TABLE users OWNER TO brinkman;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: brinkman
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO brinkman;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brinkman
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY course_material_files ALTER COLUMN id SET DEFAULT nextval('course_material_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY course_material_media ALTER COLUMN id SET DEFAULT nextval('course_material_media_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY course_material_videos ALTER COLUMN id SET DEFAULT nextval('course_material_videos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY course_materials ALTER COLUMN id SET DEFAULT nextval('course_materials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY lessons ALTER COLUMN id SET DEFAULT nextval('lessons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY sub_categories ALTER COLUMN id SET DEFAULT nextval('sub_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: brinkman
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-08-02 00:00:24.767107	2017-08-02 00:00:24.767107
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY attachments (id, course_id, title, doc_type, file_description, document_file_name, document_content_type, document_file_size, document_updated_at, created_at, updated_at) FROM stdin;
1	1	\N	supplemental		test_download.pdf	application/pdf	8706	2017-08-02 16:19:41.268438	2017-08-02 16:19:41.284672	2017-08-02 16:19:41.284672
2	1	\N	post-course		test_download_2.pdf	application/pdf	8706	2017-08-02 16:19:41.270071	2017-08-02 16:19:41.292351	2017-08-02 16:19:41.292351
3	2	\N	post-course		FINAL_Edited_Ed's_Letter.docx	application/vnd.openxmlformats-officedocument.wordprocessingml.document	158244	2017-08-29 15:35:09.602152	2017-08-29 15:35:09.672186	2017-08-29 15:35:09.672186
4	2	\N	post-course		Harvest_Calendar(1).docx	application/vnd.openxmlformats-officedocument.wordprocessingml.document	213686	2017-08-29 15:36:50.121973	2017-08-29 15:36:53.814645	2017-08-29 15:36:53.814645
5	2	\N	post-course		DigitalLearn_Story2_Template.story	application/octet-stream	3465541	2017-08-29 15:58:16.663883	2017-08-29 15:58:16.729599	2017-08-29 15:58:16.729599
\.


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('attachments_id_seq', 5, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY categories (id, title, created_at, updated_at, description, tag) FROM stdin;
13	Computer Basics	2017-08-18 19:31:37.266016	2017-08-18 19:31:37.266016	\N	Hardware
14	Tablet Basics	2017-08-18 19:31:37.373653	2017-08-18 19:31:37.373653	\N	Hardware
17	Social Media	2017-08-18 19:31:37.576006	2017-08-18 19:31:37.576006	\N	Software & Applications
18	More Websites & Apps	2017-08-18 19:31:37.578244	2017-08-18 19:31:37.578244	\N	Software & Applications
19	Resume Series	2017-08-18 19:31:37.580274	2017-08-18 19:31:37.580274	\N	Job & Career
20	LinkedIn	2017-08-18 19:31:38.332654	2017-08-18 19:31:38.332654	\N	Job & Career
15	Microsoft Tools	2017-08-18 19:31:37.424114	2017-08-21 15:37:00.155172	A really long description about how this course is the best course in the world for Microsoft Technologies, and ...	Software & Applications
16	Google Tools	2017-08-18 19:31:37.573299	2017-08-21 19:44:57.056896	Some googly description	Software & Applications
22	Other	2017-08-24 21:15:05.095487	2017-08-24 21:15:05.095487	\N	Other
23	Something New	2017-08-24 22:15:51.26649	2017-08-24 22:15:51.26649	Something New	Software & Applications
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('categories_id_seq', 23, true);


--
-- Data for Name: course_material_files; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY course_material_files (id, course_material_id, file_file_name, file_content_type, file_file_size, file_updated_at, created_at, updated_at) FROM stdin;
1	1	test_download.pdf	application/pdf	8706	2017-08-15 20:08:07.406859	2017-08-15 20:08:07.468646	2017-08-15 20:08:07.468646
2	1	Alex's_Updated_Course_completion_certificate_(1).pdf	application/pdf	21148	2017-08-22 20:35:59.551011	2017-08-22 20:35:59.666873	2017-08-22 20:35:59.666873
3	1	Alex's_Updated_Course_completion_certificate_(2).pdf	application/pdf	21138	2017-08-22 20:35:59.552664	2017-08-22 20:35:59.673205	2017-08-22 20:35:59.673205
4	1	Alex's_Updated_Course_completion_certificate_(3).pdf	application/pdf	21138	2017-08-22 20:35:59.553731	2017-08-22 20:35:59.677308	2017-08-22 20:35:59.677308
5	1	Alex's_Updated_Course_completion_certificate_(4).pdf	application/pdf	21138	2017-08-22 20:35:59.55486	2017-08-22 20:35:59.680661	2017-08-22 20:35:59.680661
6	4	Participant_Survey_-_English.docx	application/vnd.openxmlformats-officedocument.wordprocessingml.document	94695	2017-08-24 19:50:01.607032	2017-08-24 19:50:01.703068	2017-08-24 19:50:01.703068
7	4	Standard_Presentation_Template_(Editable).pptx	application/vnd.openxmlformats-officedocument.presentationml.presentation	151997	2017-08-24 19:50:01.610346	2017-08-24 19:50:01.710336	2017-08-24 19:50:01.710336
8	4	Template_-_Handout_and_Activity_Sheet_(Editable).docx	application/vnd.openxmlformats-officedocument.wordprocessingml.document	242891	2017-08-24 19:50:01.612396	2017-08-24 19:50:01.718493	2017-08-24 19:50:01.718493
9	4	Template_-_Design_Document_(Editable).docx	application/vnd.openxmlformats-officedocument.wordprocessingml.document	80866	2017-08-24 19:50:01.613671	2017-08-24 19:50:01.724655	2017-08-24 19:50:01.724655
\.


--
-- Name: course_material_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('course_material_files_id_seq', 9, true);


--
-- Data for Name: course_material_media; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY course_material_media (id, course_material_id, media_file_name, media_content_type, media_file_size, media_updated_at, created_at, updated_at) FROM stdin;
9	1	COVER_for_website(1).jpg	image/jpeg	950948	2017-08-29 18:45:41.67179	2017-08-29 18:45:42.757074	2017-08-29 18:45:42.757074
\.


--
-- Name: course_material_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('course_material_media_id_seq', 9, true);


--
-- Data for Name: course_material_videos; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY course_material_videos (id, course_material_id, url, created_at, updated_at) FROM stdin;
\.


--
-- Name: course_material_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('course_material_videos_id_seq', 1, false);


--
-- Data for Name: course_materials; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY course_materials (id, title, summary, description, contributor, created_at, updated_at, sub_category_id, category_id, pub_status) FROM stdin;
2	Course 2		<p><s><em>Description</em></s></p>\r\n	Alejandro	2017-08-15 19:10:14.306565	2017-08-24 15:44:50.138434	15	15	D
3	Course 3		<p>The description</p>\r\n	Alex	2017-08-24 16:23:16.193812	2017-08-24 17:30:57.589017	15	15	A
4	Course Templates		<p>Each class contains a minimum of three supporting documents, which generally include a Design Document (Instructor&#39;s Guide), an Activity Sheet, and a Handout.&nbsp; PowerPoint presentations, practice files and additional documents may also accompany classes when applicable. With these items, and a bit of preparation and practice, you will be ready to teach any of our classes in no time!</p>\r\n	Alejandro!!!	2017-08-24 19:49:27.398555	2017-08-24 21:55:16.306789	\N	22	P
1	Course 1	Summary!!!!	<p><s>Description...</s></p>\r\n	Alejandro	2017-08-14 21:49:23.005952	2017-08-29 18:45:15.96209	15	15	P
\.


--
-- Name: course_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('course_materials_id_seq', 4, true);


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY courses (id, title, seo_page_title, meta_desc, summary, description, notes, contributor, pub_status, slug, course_order, pub_date, created_at, updated_at) FROM stdin;
1	Alex's Updated Course with a super really long title to the point of being madness. Oh my!			A crazy long title about how things are going in this wild world of technology, where everything is new and different on a daily baisis! Oh my what will we?	<p>A crazy long title about how things are going in this wild world of technology, where everything is new and different on a daily baisis! Oh my what will we?</p>\r\n\r\n<ul>\r\n\t<li>This</li>\r\n\t<li>And&nbsp;</li>\r\n\t<li>That</li>\r\n\t<li>And&nbsp;</li>\r\n\t<li>THis and up</li>\r\n\t<li>&nbsp;</li>\r\n</ul>\r\n	<ul>\r\n\t<li>Wow</li>\r\n\t<li>And</li>\r\n</ul>\r\n\r\n<p><strong>Really wow!</strong></p>\r\n	Alejandro the Coder and other things.	P	alex-s-updated-course-with-a-super-really-long-title-to-the-point-of-being-madness-oh-my	1	2017-08-24 18:16:32.057587	2017-08-02 00:45:58.662246	2017-08-24 18:16:32.057721
2	Second Training			A really good course	<p>Something here</p>\r\n		Alejandro	P	second-training	2	2017-09-05 16:23:47.867582	2017-08-03 17:58:17.281024	2017-09-05 16:23:47.867801
\.


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('courses_id_seq', 2, true);


--
-- Data for Name: friendly_id_slugs; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY friendly_id_slugs (id, slug, sluggable_id, sluggable_type, scope, created_at) FROM stdin;
\.


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('friendly_id_slugs_id_seq', 1, false);


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY lessons (id, lesson_order, parent_lesson_id, title, duration, course_id, slug, summary, story_line, seo_page_title, meta_desc, is_assessment, pub_status, story_line_file_name, story_line_content_type, story_line_file_size, story_line_updated_at, created_at, updated_at) FROM stdin;
3	2	\N	Second Lesson	134	1	second-lesson	Summary	\N	Second lesson thing	second lesson meta	f	P	RAILS2_BasicSearch1sized.zip	application/zip	4220649	2017-08-02 22:37:03.151832	2017-08-02 18:06:14.864787	2017-08-03 19:01:42.029237
2	3	\N	Second Lesson What about a really really long title	134	1	second-lesson-what-about-a-really-really-long-title	Second Lesson Summary	\N	Second lesson thing	second lesson meta	f	P	RAILS2_BasicSearch1sized.zip	application/zip	4220649	2017-08-02 18:03:14.818382	2017-08-02 18:03:14.842589	2017-08-03 19:01:42.059072
1	1	\N	First Lesson	1154	1	first-lesson	Summary - There can only be one story line per lesson, if you want to upload a new on, you need to delete the current one first. Summary There can only be!	\N	page title	meta description	f	P	BasicSearch1.zip	application/zip	4314601	2017-08-04 18:13:56.716645	2017-08-02 16:14:31.833454	2017-08-04 18:39:05.935069
4	4	\N	Fourth Lesson	1	1	fourth-lesson	something	\N	SEO Page Title	Meta Description	t	P	RAILS2_BasicSearch1sized.zip	application/zip	4220649	2017-08-02 19:41:46.021706	2017-08-02 19:28:05.741431	2017-08-04 18:39:05.936782
5	1	\N	Lesson 1	80	2	lesson-1	Summary	\N			f	P	RAILS2_BasicSearch1sized.zip	application/zip	4220649	2017-09-05 16:24:20.561493	2017-09-05 16:24:20.677297	2017-09-05 16:24:20.677297
\.


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('lessons_id_seq', 5, true);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY pages (id, title, body, pub_status, pub_at, slug, author, seo_title, meta_desc, created_at, updated_at) FROM stdin;
1	About	<p>About ...</p>\r\n	P	\N	about	Admin			2017-08-02 00:00:30.968547	2017-08-24 18:07:47.679916
2	Bibliography	<p>Bibliography ...</p>\r\n	P	\N	bibliography	Admin			2017-08-02 00:00:30.978953	2017-08-24 18:09:07.319302
3	Privacy Policy | Terms	<p>Privacy Policy | Terms ...</p>\r\n	P	\N	privacy-policy-terms	Admin			2017-08-02 00:00:30.988697	2017-08-24 18:09:12.105041
\.


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('pages_id_seq', 3, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY schema_migrations (version) FROM stdin;
20160712172410
20170728230929
20170728233945
20170801223046
20170801223056
20170801223114
20170802004400
20170802223857
20170814205805
20170815161419
20170816194608
20170816194633
20170816195818
20170817165440
20170818192745
20170821182048
20170823220818
20170824040750
20170824041901
20170824155508
20170824175657
20170824185708
20170829180504
\.


--
-- Data for Name: sub_categories; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY sub_categories (id, title, category_id, created_at, updated_at) FROM stdin;
13	Microsoft Office 2013	15	2017-08-18 19:31:37.476131	2017-08-18 19:31:37.476131
14	Microsoft Office 2010	15	2017-08-18 19:31:37.522851	2017-08-18 19:31:37.522851
15	Microsoft Office 2017	15	2017-08-21 17:59:47.800583	2017-08-21 17:59:47.800583
16	Google Analytics	16	2017-08-21 19:44:57.058677	2017-08-21 19:44:57.058677
\.


--
-- Name: sub_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('sub_categories_id_seq', 16, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: brinkman
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, created_at, updated_at, admin) FROM stdin;
2	alex+admin@commercekitchen.com	$2a$11$13AqEI3i6yTAAf1uEB0uYe7W.C2WuDr.2d.HVNE8fahKEnr2jbjIa	\N	\N	\N	0	\N	\N	\N	\N	YQ-uAyxJXNUKkqj2-VtZ	2017-08-25 20:11:39.067503	2017-08-25 20:08:15.720851	\N	0	\N	\N	2017-08-25 20:08:15.720706	2017-08-25 20:11:39.068161	f
1	alex@commercekitchen.com	$2a$11$2SQwAaox1NdcpwIeq16pouQJbFnDGuA.Qnt9CnGanc0TD6jZg14OW	\N	\N	\N	15	2017-09-05 16:23:37.863812	2017-08-29 18:28:38.328229	127.0.0.1	127.0.0.1	\N	2017-08-02 00:00:30.687157	\N	\N	0	\N	\N	2017-08-02 00:00:30.855863	2017-09-05 16:23:37.864822	t
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brinkman
--

SELECT pg_catalog.setval('users_id_seq', 2, true);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: course_material_files_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY course_material_files
    ADD CONSTRAINT course_material_files_pkey PRIMARY KEY (id);


--
-- Name: course_material_media_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY course_material_media
    ADD CONSTRAINT course_material_media_pkey PRIMARY KEY (id);


--
-- Name: course_material_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY course_material_videos
    ADD CONSTRAINT course_material_videos_pkey PRIMARY KEY (id);


--
-- Name: course_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY course_materials
    ADD CONSTRAINT course_materials_pkey PRIMARY KEY (id);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: brinkman; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_pages_on_pub_status; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE INDEX index_pages_on_pub_status ON pages USING btree (pub_status);


--
-- Name: index_pages_on_title; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE UNIQUE INDEX index_pages_on_title ON pages USING btree (title);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: brinkman; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON users USING btree (unlock_token);


--
-- Name: public; Type: ACL; Schema: -; Owner: brinkman
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM brinkman;
GRANT ALL ON SCHEMA public TO brinkman;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

