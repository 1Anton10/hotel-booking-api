--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Homebrew)
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
-- Name: bookings; Type: TABLE; Schema: public; Owner: mac
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    room_id integer,
    client_name character varying,
    is_vip boolean,
    start_date date,
    end_date date
);


ALTER TABLE public.bookings OWNER TO mac;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: mac
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_id_seq OWNER TO mac;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mac
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: mac
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    number character varying
);


ALTER TABLE public.rooms OWNER TO mac;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: mac
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO mac;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mac
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: mac
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: mac
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: mac
--

COPY public.bookings (id, room_id, client_name, is_vip, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: mac
--

COPY public.rooms (id, number) FROM stdin;
1	101
2	102
3	103
\.


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mac
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mac
--

SELECT pg_catalog.setval('public.rooms_id_seq', 3, true);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: mac
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: mac
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: ix_bookings_id; Type: INDEX; Schema: public; Owner: mac
--

CREATE INDEX ix_bookings_id ON public.bookings USING btree (id);


--
-- Name: ix_rooms_id; Type: INDEX; Schema: public; Owner: mac
--

CREATE INDEX ix_rooms_id ON public.rooms USING btree (id);


--
-- Name: ix_rooms_number; Type: INDEX; Schema: public; Owner: mac
--

CREATE UNIQUE INDEX ix_rooms_number ON public.rooms USING btree (number);


--
-- Name: bookings bookings_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mac
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- PostgreSQL database dump complete
--

