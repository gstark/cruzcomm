--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgraphql_watch; Type: SCHEMA; Schema: -; Owner: gstark
--

CREATE SCHEMA postgraphql_watch;


-- ALTER SCHEMA postgraphql_watch OWNER TO gstark;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = postgraphql_watch, pg_catalog;

--
-- Name: notify_watchers(); Type: FUNCTION; Schema: postgraphql_watch; Owner: gstark
--

CREATE FUNCTION notify_watchers() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$ begin perform pg_notify( 'postgraphql_watch', (select array_to_json(array_agg(x)) from (select schema_name as schema, command_tag as command from pg_event_trigger_ddl_commands()) as x)::text ); end; $$;


-- ALTER FUNCTION postgraphql_watch.notify_watchers() OWNER TO gstark;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: gstark
--

CREATE TABLE channels (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


-- ALTER TABLE channels OWNER TO gstark;

--
-- Name: chats_id_seq; Type: SEQUENCE; Schema: public; Owner: gstark
--

CREATE SEQUENCE chats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER TABLE chats_id_seq OWNER TO gstark;

--
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gstark
--

ALTER SEQUENCE chats_id_seq OWNED BY channels.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: gstark
--

CREATE TABLE messages (
    id integer NOT NULL,
    chat_id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    username text DEFAULT '""'::text NOT NULL
);


-- ALTER TABLE messages OWNER TO gstark;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: gstark
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER TABLE message_id_seq OWNER TO gstark;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gstark
--

ALTER SEQUENCE message_id_seq OWNED BY messages.id;


--
-- Name: world_news_articles; Type: TABLE; Schema: public; Owner: gstark
--

CREATE TABLE world_news_articles (
    id integer NOT NULL,
    headline text NOT NULL,
    category text NOT NULL,
    body text NOT NULL,
    published_at timestamp with time zone DEFAULT now() NOT NULL
);


-- ALTER TABLE world_news_articles OWNER TO gstark;

--
-- Name: untitled_table_id_seq; Type: SEQUENCE; Schema: public; Owner: gstark
--

CREATE SEQUENCE untitled_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER TABLE untitled_table_id_seq OWNER TO gstark;

--
-- Name: untitled_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gstark
--

ALTER SEQUENCE untitled_table_id_seq OWNED BY world_news_articles.id;


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY channels ALTER COLUMN id SET DEFAULT nextval('chats_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Name: world_news_articles id; Type: DEFAULT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY world_news_articles ALTER COLUMN id SET DEFAULT nextval('untitled_table_id_seq'::regclass);


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: gstark
--

COPY channels (id, name, created_at) FROM stdin;
1	hello	2017-08-26 13:06:52.990099-04
2	goodbye	2017-08-26 13:06:52.990099-04
\.


--
-- Name: chats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gstark
--

SELECT pg_catalog.setval('chats_id_seq', 2, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gstark
--

SELECT pg_catalog.setval('message_id_seq', 4, true);


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: gstark
--

COPY messages (id, chat_id, message, created_at, username) FROM stdin;
1	1	Let's meet for dinner soon!	2017-08-26 13:20:55.158301-04	Mom
3	1	Ok Mom, I'll head to the room right after my basketball game	2017-08-26 13:22:13.622669-04	Tommy
4	1	Are we going to Manfredi's or the restaurant?	2017-08-26 13:24:26.373208-04	Dad
\.


--
-- Name: untitled_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gstark
--

SELECT pg_catalog.setval('untitled_table_id_seq', 3, true);


--
-- Data for Name: world_news_articles; Type: TABLE DATA; Schema: public; Owner: gstark
--

COPY world_news_articles (id, headline, category, body, published_at) FROM stdin;
1	Patriots lose Julian Edelman (torn ACL) for season	sports	New England's worst fears have been realized. Julian Edelman is done for the season.\n\nAn MRI on Saturday revealed that Edelman indeed suffered an ACL tear in his right knee during Friday's preseason win over the Lions, NFL Network Insider Ian Rapoport reported. The Patriots' Super Bowl hero will miss the entire 2017 campaign.\n\nThe MMQB's Albert Breer first reported the news.\n\nEdelman went down on a non-contact play as he was scampering through the secondary on his third catch of the opening drive, and then limped off the field. He was later carted to the locker room and did not return.\n\nThe 32-year-old receiver has been Brady's most reliable target for years. Edelman has earned more than nine targets per game over the last four seasons and has averaged more than 11 yards per catch the past five years. He is coming off a career-high 1,106-yard 2016 season. Edelman signed a two-year, $11 million contract with $7 million guaranteed before this offseason.\n\nAs far as injuries to New England's offense go, this one hurts, but doesn't derail the train as much as a sidelined Rob Gronkowski or -- heavens forbid -- Tom Brady would. The plug-and-play nature of the Patriots' attack should facilitate an easy transition in the slot from Edelman to Danny Amendola or one of New England's 63 pass-catching running backs.\n\nChris Hogan, new acquisition Brandin Cooks and the Patriots' tight ends should be the greatest beneficiaries of Edelman's absence. Hogan and Cooks are suddenly New England's go-to receivers and will be expected to replace, in tandem, Edelman's nearly 100 receptions from last season. Gronkowski and former Colts tight end Dwayne Allen should see increased targets on third-down conversions.\n\nEdelman's absence will change how New England attacks the season and opposing defenses, but as long as No. 12 is under center, dreams of Super Bowl glory should not and will not be abandoned.	2017-08-26 13:29:08.576758-04
2	Final Fantasy 15 will have Steam Workshop support and will run on older PCs	technology	Final Fantasy 15 is bringing its brotrip to PC, so we paid Hajime Tabata, the game director, a visit at Gamescom, finding out a bit more about modding, optimisation, and how the port is going to get PC players interested in the venerable series. \n\nEven though several Final Fantasy games have been given PC ports, it’s still very much seen as a console series. Tabata and the dev team, then, had to figure out how to get players to associate it with PC as well. \n\n“I think the very first step towards that, we've exceeded,” Tabata says. “With our technical partnership and joint-development with NVidia—I think we managed to convince them that we are serious about the PC market. The fact that they worked together with us and helped us do that announcement is a big sign of that.” \n\nWhile the core of the game remains the same, PC players will be able to use a mouse and keyboard, which Tabata says works very well with the new first-person perspective. Perhaps the biggest difference, however, is the inclusion of mods. \n\n“Traditionally Final Fantasy has a bit of an image that everyone has the exact same experience and shares that experience with everyone that plays the game. With Final Fantasy 15, we went in a slightly different direction. Right from the start, the way the whole game is structured and created gives each individual player their own individual and unique FF15 journey. I certainly think the modding community is going to resonate with that and the idea that you can change it any way they want is exciting.”\n\n\nHe also confirmed that the Steam version—it’s launching on Origin too—would have Steam Workshop support, making it easier to share and add mods. \n\nThe system requirements are still being figured out as optimisation work continues, but Tabata confirmed that it won’t be locked to 30fps, though 60fps will be hard to achieve at max settings. “Supporting it will be possible, but considering the spec you'd need to get that level—with native 4K, HDR, and a good 60fps—the machine we've got here couldn't do that at the moment. That's a GTX 1080 Ti, and even with that 60 frames is not possible.”\n\nIt also sounds like SLI might cause some problems. “So, multiple cards, there's the loading of the previous frame and you have that little bit of delay. It doesn't allow for that proper 60 frames. In order to get that really smooth 60 frames, you need a higher capacity base in order to do that. All the physics simulations as well need to be refreshed in every frame—if you have two cards running in tandem there's that little bit of delay between the sending of data between the two cards and that's what makes it impossible.”\n\nOn a more positive note, a broad range of machines should be able to run the game. PCs that have similar specs to current gen consoles won’t have any problems, so if your PC is a few years old, you shouldn’t need to splash out on an upgrade just to enjoy Final Fantasy 15. Unless you want to run it in 4K, that is. \n\nThis also opens the door for future Final Fantasy releases on PC, that aren’t an afterthought. “If my team were going to be in charge of the next Final Fantasy game, we probably would set up the basis of development on that high-level PC architecture—I think that's something that we'd do,” Tabata says. “But looking into the future, you have to consider cloud-based games—the answer might be different depending on how far down the line we're talking about.”\n\nUltimately, Tabata and his team hope PC players will see that they’re taking this very seriously. “I think this is for us a great opportunity in getting the game out to the PC market that the latest Final Fantasy game is serious about the PC market and its players. We're taking on that challenge with everything we've got and it'd just be great to get some kind of feedback on that, players' reactions and understand what people are expecting towards our game.” \n\nFinal Fantasy 15 is due out on Steam and Origin next year, complete with all the console DLC and updates. A multiplayer expansion is also in the works, and will hopefully be available for the PC launch.	2017-08-26 13:30:11.581423-04
3	More than 180000 iPhone apps won't be compatible with iOS 11	technology	When iOS 11 arrives in a matter of weeks, a long-predicted change will arrive with it: Apple will no longer support 32-bit apps. \n\nThe change has been rumored for awhile now, ever since Apple introduced a 64-bit processor with the iPhone 5S in 2013 and started giving gentle warnings that developers should update their apps.\n\nBut as far back as January of this year, users started getting a message warning them that the 32-bit apps on their phone wouldn't work at all when iOS 11 became available. By June, Gizmodo noticed that some 32-bit apps had already disappeared from the App Store, but were still available to download if you had the direct link. \n\nThe iPhone 5s has been around for nearly three years, and most well-known apps are compatible with 64-bit processors. So what does this change actually mean?\n\nWell, it turns out that Apple may stop supporting nearly 200,000 apps come September. \n\nAccording to Oliver Yeh, cofounder of app intelligence firm Sensor Tower, there are 187,000 32-bit apps still on the App Store, which equates to about 8% all iPhone apps (Sensor Tower estimated in March that there are approximately 2.4 million apps on the App Store). \n\n32-bit apps Business Insider\n\nWhile it's impossible to make a complete list of all the apps that will no longer be supported, both Sensor Tower and Business Insider have anecdotally noticed a handful of apps that appear to be 32-bit:\n\nYouTube Capture, a video recording app that got 200,000 downloads last month, according to Sensor Tower\niSpadez, a card game app\nNeo Nectaris, a military strategy game\nInfinity Blade, a role-playing fighting game\nIf you're noticing a pattern among the 32-bit apps, you're on to something: Sensor Tower found that of the remaining 32-bit apps on the App Store, most of them were games — 38,619 to be specific. Education, entertainment, and lifestyle apps followed. \n\nBut if some of your favorite apps are only 32-bit compatible, they won't immediately disappear when iOS 11 becomes available. According to Sensor Tower, the apps will probably stay in the App Store for awhile and continue working on phones that haven't updated to the new OS. Eventually, though, Apple will probably delete the apps from the App Store altogether. \n\nLuckily, there's an easy way to check if you have any 32-bit apps on your phone: Go into your settings, open "General," tap on "About," then click on "Applications." That should show you which of your apps are 32-bit — if you don't have any 32-bit apps, nothing will happen when you click. \n\nApple did not immediately respond to a request for comment about the coming changes. 	2017-08-26 13:30:48.147488-04
\.


--
-- Name: channels chats_pkey; Type: CONSTRAINT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: messages message_pkey; Type: CONSTRAINT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: world_news_articles untitled_table_pkey; Type: CONSTRAINT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY world_news_articles
    ADD CONSTRAINT untitled_table_pkey PRIMARY KEY (id);


--
-- Name: messages message_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gstark
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES channels(id);


--
-- Name: postgraphql_watch; Type: EVENT TRIGGER; Schema: -; Owner: gstark
--

CREATE EVENT TRIGGER postgraphql_watch ON ddl_command_end
         WHEN TAG IN ('ALTER DOMAIN', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER SCHEMA', 'ALTER TABLE', 'ALTER TYPE', 'ALTER VIEW', 'COMMENT', 'CREATE DOMAIN', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE SCHEMA', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE VIEW', 'DROP DOMAIN', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP SCHEMA', 'DROP TABLE', 'DROP VIEW', 'GRANT', 'REVOKE', 'SELECT INTO')
   EXECUTE PROCEDURE postgraphql_watch.notify_watchers();


--
-- PostgreSQL database dump complete
--

-- create table people (
--   id               serial primary key,
--   nickname         text not null check (char_length(nickname) < 80),
--   created_at       timestamp default now()
-- );
--
-- create table people_accounts (
--   person_id        integer primary key references people(id) on delete cascade,
--   email            text not null unique check (email ~* '^.+@.+\..+$'),
--   password_hash    text not null
-- );
--
-- create extension if not exists "pgcrypto";
--
-- create function register_person(
--   nickname text,
--   email text,
--   password text
-- ) returns forum_example.person as $$
-- declare
--   person forum_example.person;
-- begin
--   insert into person (nickname) values
--     (nickname)
--     returning * into person;
--
--   insert into .erson_account (person_id, email, password_hash) values
--     (person.id, email, crypt(password, gen_salt('bf')));
--
--   return person;
-- end;
-- $$ language plpgsql strict security definer;
--
-- comment on function register_person(text, text, text, text) is 'Registers a single user and creates an account in our forum.';
--
-- create role cruzcomm_anonymous;
-- grant cruzcomm_anonymous to cruzzcomm;


