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
-- Name: postgraphql_watch; Type: SCHEMA; Schema: -; Owner: tonialiberti
--

CREATE SCHEMA postgraphql_watch;


-- ALTER SCHEMA postgraphql_watch OWNER TO tonialiberti;

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
-- Name: notify_watchers(); Type: FUNCTION; Schema: postgraphql_watch; Owner: tonialiberti
--

CREATE FUNCTION notify_watchers() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$ begin perform pg_notify( 'postgraphql_watch', (select array_to_json(array_agg(x)) from (select schema_name as schema, command_tag as command from pg_event_trigger_ddl_commands()) as x)::text ); end; $$;


-- ALTER FUNCTION postgraphql_watch.notify_watchers() OWNER TO tonialiberti;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: tonialiberti
--

CREATE TABLE channels (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


-- ALTER TABLE channels OWNER TO tonialiberti;

--
-- Name: chats_id_seq; Type: SEQUENCE; Schema: public; Owner: tonialiberti
--

CREATE SEQUENCE chats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER TABLE chats_id_seq OWNER TO tonialiberti;

--
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tonialiberti
--

ALTER SEQUENCE chats_id_seq OWNED BY channels.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: tonialiberti
--

CREATE TABLE messages (
    id integer NOT NULL,
    chat_id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    username text DEFAULT '""'::text NOT NULL
);


-- ALTER TABLE messages OWNER TO tonialiberti;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: tonialiberti
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER TABLE message_id_seq OWNER TO tonialiberti;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tonialiberti
--

ALTER SEQUENCE message_id_seq OWNED BY messages.id;


--
-- Name: world_news_articles; Type: TABLE; Schema: public; Owner: tonialiberti
--

CREATE TABLE world_news_articles (
    id integer NOT NULL,
    headline text NOT NULL,
    category text NOT NULL,
    body text NOT NULL,
    published_at timestamp with time zone DEFAULT now() NOT NULL
);


-- ALTER TABLE world_news_articles OWNER TO tonialiberti;

--
-- Name: untitled_table_id_seq; Type: SEQUENCE; Schema: public; Owner: tonialiberti
--

CREATE SEQUENCE untitled_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


-- ALTER TABLE untitled_table_id_seq OWNER TO tonialiberti;

--
-- Name: untitled_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tonialiberti
--

ALTER SEQUENCE untitled_table_id_seq OWNED BY world_news_articles.id;


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY channels ALTER COLUMN id SET DEFAULT nextval('chats_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Name: world_news_articles id; Type: DEFAULT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY world_news_articles ALTER COLUMN id SET DEFAULT nextval('untitled_table_id_seq'::regclass);


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: tonialiberti
--

COPY channels (id, name, created_at) FROM stdin;
1	hello	2017-08-26 13:06:52.990099-04
2	goodbye	2017-08-26 13:06:52.990099-04
3	family	2017-08-26 16:55:42.145838-04
4	pool party	2017-08-26 17:22:37.100713-04
5	bingo	2017-08-26 17:22:53.852212-04
6	comedy show	2017-08-26 17:23:10.41967-04
7	excursions	2017-08-26 17:25:03.829473-04
8	port talks	2017-08-26 17:25:16.592926-04
9	cooking demonstrations	2017-08-26 17:25:30.182751-04
10	karaoke	2017-08-26 17:26:10.41134-04
\.


--
-- Name: chats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tonialiberti
--

SELECT pg_catalog.setval('chats_id_seq', 10, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tonialiberti
--

SELECT pg_catalog.setval('message_id_seq', 36, true);


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: tonialiberti
--

COPY messages (id, chat_id, message, created_at, username) FROM stdin;
1	1	Let's meet for dinner soon!	2017-08-26 13:20:55.158301-04	Mom
3	1	Ok Mom, I'll head to the room right after my basketball game	2017-08-26 13:22:13.622669-04	Tommy
4	1	Are we going to Manfredi's or the restaurant?	2017-08-26 13:24:26.373208-04	Dad
9	1	Let's go to Manfredi's. I heard they have a great pasta primavera. 	2017-08-26 17:29:51.804408-04	Mom
10	2	We need to be packed and on deck with our luggage in two hours. Is everyone ready?	2017-08-26 17:29:51.804408-04	Dad
11	2	Do we need to bring the roller bags with us or just leave them outside the room? I have my carry on.	2017-08-26 17:31:46.204386-04	Tommy
12	2	Can someone please help with my luggage? I packed a few two many souvenirs and may need an extra hand.	2017-08-26 17:31:46.204386-04	Mom
13	3	I'm having the time of my life. Thanks so much Mom and Dad for bringing me!	2017-08-26 17:35:37.674782-04	Tommy
14	3	We are so glad that you are spending Labor Day with us. We know you had lots of other fun activities you could have done with your friends. 	2017-08-26 17:35:37.674782-04	Mom
15	3	We are so proud that you graduated The Iron Yard and wanted to spend some extra time with you before you are a busy developer in Tampa Bay at SourceToad. 	2017-08-26 17:35:37.674782-04	Dad
16	4	Hey Jordan! It was awesome meeting you at port. Want to head to the pool party later this afternoon? I heard there's a good Jimmy Buffet cover band, and I would love a margarita. 	2017-08-26 17:38:54.891064-04	Tommy
17	4	Hey Tommy, same to you! Absolutley, but I heard JImmy's favorite drink is a coconut and water. 	2017-08-26 17:38:54.891064-04	Jordan
18	4	Perfect - I just got one at the last beach we were at when we were docked ;) See you at 2pm poolside!	2017-08-26 17:38:54.891064-04	Tommy
19	5	Hello there neighbor! My husband Jay and I are going to head to bingo tomorrow before dinner. Would you and your hubby like to join?	2017-08-26 17:40:50.41099-04	Tina
20	5	That's lovely! I heard the giveaway is a roundtip cruise for two out of the Tampa port. I've always wanted to visit there and try their plantains.... yum!	2017-08-26 17:44:25.14537-04	Alex
21	5	Oh wow - we are actually from Tampa and heard about these amazing cruises from Startup Week. Hope you win so you can visit the Green Lemon and try some!	2017-08-26 17:44:25.14537-04	Tina
22	6	Who wants to go to the comedy show tonight? I heard the As Per Usual group is perforoming. They are based out of Tampa  Bay and are hilarious!	2017-08-26 17:54:42.704773-04	Jay
23	6	We would love to go! What time do you want to go and would you like to dinner before? I heard the Mexican place is pretty good. 	2017-08-26 17:58:35.714661-04	Doug
24	6	Yes! Their avocado and buffalo cauliflower tacos are delish as wella s their margaritas. I can't wait to see As Per Usual! We saw them in downtown St Pete a few weeks ago and we laughed the whole time!	2017-08-26 17:58:35.714661-04	Tina
25	7	That was the best excursion I've ever done! WOW. Janet, can you please send the pics you took.	2017-08-26 18:03:38.57194-04	Tommy
26	7	Yes, I'm still in awe about those breathtaking views at the Alps. I'll load them after I'm done with breakfast. Did you try their passionfruit mimosa and the diner on the ship. It's delish!	2017-08-26 18:03:38.57194-04	Janet
27	7	Oh yes. The blood orange one is delish as well. Do you want to do that swimming excursion scheduled for Tuesday.	2017-08-26 18:03:38.57194-04	Tommy
28	8	Tommy, you were suppose to be here at 8:30am for the port talk. Are you ok?	2017-08-26 18:05:56.404534-04	Mom
29	8	I saw him hanging out with some friends late last night after their excursion. He was doing karaoke and looked like they were having fun! Maybe he slept in?	2017-08-26 18:05:56.404534-04	Dad
30	8	Hey mom, sorry I'm late! Dad's right and I overslept. Be down in 20. 	2017-08-26 18:05:56.404534-04	Tommy
31	9	Hello Viking Voyagers! La Francais ooking demonstrations start in 30 minutes at the Le Diner. Looking forward to having you.	2017-08-26 18:10:03.14549-04	Chef Pierre
32	9	Is it too late to reserve two spots for my daughter and me?	2017-08-26 18:10:03.14549-04	Sophie
33	9	Absolutely! We have a spot right up front for you. See you soon and au revoir	2017-08-26 18:10:03.14549-04	Chef Pierre
34	10	Oh my goodness Ruby, that rendition of My Heart Will Go On was epic	2017-08-26 18:13:30.580653-04	Levi
35	10	You think?! I thought Jo took the cake with her performance of Rose	2017-08-26 18:13:30.580653-04	Ruby
36	10	Let's go again tonight. That was way too much.	2017-08-26 18:13:30.580653-04	Jo
\.


--
-- Name: untitled_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tonialiberti
--

SELECT pg_catalog.setval('untitled_table_id_seq', 11, true);


--
-- Data for Name: world_news_articles; Type: TABLE DATA; Schema: public; Owner: tonialiberti
--

COPY world_news_articles (id, headline, category, body, published_at) FROM stdin;
1	Patriots lose Julian Edelman (torn ACL) for season	sports	New England's worst fears have been realized. Julian Edelman is done for the season.\n\nAn MRI on Saturday revealed that Edelman indeed suffered an ACL tear in his right knee during Friday's preseason win over the Lions, NFL Network Insider Ian Rapoport reported. The Patriots' Super Bowl hero will miss the entire 2017 campaign.\n\nThe MMQB's Albert Breer first reported the news.\n\nEdelman went down on a non-contact play as he was scampering through the secondary on his third catch of the opening drive, and then limped off the field. He was later carted to the locker room and did not return.\n\nThe 32-year-old receiver has been Brady's most reliable target for years. Edelman has earned more than nine targets per game over the last four seasons and has averaged more than 11 yards per catch the past five years. He is coming off a career-high 1,106-yard 2016 season. Edelman signed a two-year, $11 million contract with $7 million guaranteed before this offseason.\n\nAs far as injuries to New England's offense go, this one hurts, but doesn't derail the train as much as a sidelined Rob Gronkowski or -- heavens forbid -- Tom Brady would. The plug-and-play nature of the Patriots' attack should facilitate an easy transition in the slot from Edelman to Danny Amendola or one of New England's 63 pass-catching running backs.\n\nChris Hogan, new acquisition Brandin Cooks and the Patriots' tight ends should be the greatest beneficiaries of Edelman's absence. Hogan and Cooks are suddenly New England's go-to receivers and will be expected to replace, in tandem, Edelman's nearly 100 receptions from last season. Gronkowski and former Colts tight end Dwayne Allen should see increased targets on third-down conversions.\n\nEdelman's absence will change how New England attacks the season and opposing defenses, but as long as No. 12 is under center, dreams of Super Bowl glory should not and will not be abandoned.	2017-08-26 13:29:08.576758-04
2	Final Fantasy 15 will have Steam Workshop support and will run on older PCs	technology	Final Fantasy 15 is bringing its brotrip to PC, so we paid Hajime Tabata, the game director, a visit at Gamescom, finding out a bit more about modding, optimisation, and how the port is going to get PC players interested in the venerable series. \n\nEven though several Final Fantasy games have been given PC ports, it’s still very much seen as a console series. Tabata and the dev team, then, had to figure out how to get players to associate it with PC as well. \n\n“I think the very first step towards that, we've exceeded,” Tabata says. “With our technical partnership and joint-development with NVidia—I think we managed to convince them that we are serious about the PC market. The fact that they worked together with us and helped us do that announcement is a big sign of that.” \n\nWhile the core of the game remains the same, PC players will be able to use a mouse and keyboard, which Tabata says works very well with the new first-person perspective. Perhaps the biggest difference, however, is the inclusion of mods. \n\n“Traditionally Final Fantasy has a bit of an image that everyone has the exact same experience and shares that experience with everyone that plays the game. With Final Fantasy 15, we went in a slightly different direction. Right from the start, the way the whole game is structured and created gives each individual player their own individual and unique FF15 journey. I certainly think the modding community is going to resonate with that and the idea that you can change it any way they want is exciting.”\n\n\nHe also confirmed that the Steam version—it’s launching on Origin too—would have Steam Workshop support, making it easier to share and add mods. \n\nThe system requirements are still being figured out as optimisation work continues, but Tabata confirmed that it won’t be locked to 30fps, though 60fps will be hard to achieve at max settings. “Supporting it will be possible, but considering the spec you'd need to get that level—with native 4K, HDR, and a good 60fps—the machine we've got here couldn't do that at the moment. That's a GTX 1080 Ti, and even with that 60 frames is not possible.”\n\nIt also sounds like SLI might cause some problems. “So, multiple cards, there's the loading of the previous frame and you have that little bit of delay. It doesn't allow for that proper 60 frames. In order to get that really smooth 60 frames, you need a higher capacity base in order to do that. All the physics simulations as well need to be refreshed in every frame—if you have two cards running in tandem there's that little bit of delay between the sending of data between the two cards and that's what makes it impossible.”\n\nOn a more positive note, a broad range of machines should be able to run the game. PCs that have similar specs to current gen consoles won’t have any problems, so if your PC is a few years old, you shouldn’t need to splash out on an upgrade just to enjoy Final Fantasy 15. Unless you want to run it in 4K, that is. \n\nThis also opens the door for future Final Fantasy releases on PC, that aren’t an afterthought. “If my team were going to be in charge of the next Final Fantasy game, we probably would set up the basis of development on that high-level PC architecture—I think that's something that we'd do,” Tabata says. “But looking into the future, you have to consider cloud-based games—the answer might be different depending on how far down the line we're talking about.”\n\nUltimately, Tabata and his team hope PC players will see that they’re taking this very seriously. “I think this is for us a great opportunity in getting the game out to the PC market that the latest Final Fantasy game is serious about the PC market and its players. We're taking on that challenge with everything we've got and it'd just be great to get some kind of feedback on that, players' reactions and understand what people are expecting towards our game.” \n\nFinal Fantasy 15 is due out on Steam and Origin next year, complete with all the console DLC and updates. A multiplayer expansion is also in the works, and will hopefully be available for the PC launch.	2017-08-26 13:30:11.581423-04
3	More than 180000 iPhone apps won't be compatible with iOS 11	technology	When iOS 11 arrives in a matter of weeks, a long-predicted change will arrive with it: Apple will no longer support 32-bit apps. \n\nThe change has been rumored for awhile now, ever since Apple introduced a 64-bit processor with the iPhone 5S in 2013 and started giving gentle warnings that developers should update their apps.\n\nBut as far back as January of this year, users started getting a message warning them that the 32-bit apps on their phone wouldn't work at all when iOS 11 became available. By June, Gizmodo noticed that some 32-bit apps had already disappeared from the App Store, but were still available to download if you had the direct link. \n\nThe iPhone 5s has been around for nearly three years, and most well-known apps are compatible with 64-bit processors. So what does this change actually mean?\n\nWell, it turns out that Apple may stop supporting nearly 200,000 apps come September. \n\nAccording to Oliver Yeh, cofounder of app intelligence firm Sensor Tower, there are 187,000 32-bit apps still on the App Store, which equates to about 8% all iPhone apps (Sensor Tower estimated in March that there are approximately 2.4 million apps on the App Store). \n\n32-bit apps Business Insider\n\nWhile it's impossible to make a complete list of all the apps that will no longer be supported, both Sensor Tower and Business Insider have anecdotally noticed a handful of apps that appear to be 32-bit:\n\nYouTube Capture, a video recording app that got 200,000 downloads last month, according to Sensor Tower\niSpadez, a card game app\nNeo Nectaris, a military strategy game\nInfinity Blade, a role-playing fighting game\nIf you're noticing a pattern among the 32-bit apps, you're on to something: Sensor Tower found that of the remaining 32-bit apps on the App Store, most of them were games — 38,619 to be specific. Education, entertainment, and lifestyle apps followed. \n\nBut if some of your favorite apps are only 32-bit compatible, they won't immediately disappear when iOS 11 becomes available. According to Sensor Tower, the apps will probably stay in the App Store for awhile and continue working on phones that haven't updated to the new OS. Eventually, though, Apple will probably delete the apps from the App Store altogether. \n\nLuckily, there's an easy way to check if you have any 32-bit apps on your phone: Go into your settings, open "General," tap on "About," then click on "Applications." That should show you which of your apps are 32-bit — if you don't have any 32-bit apps, nothing will happen when you click. \n\nApple did not immediately respond to a request for comment about the coming changes. 	2017-08-26 13:30:48.147488-04
4	Lack of REM sleep linked to higher dementia risk	health	People who experience less rapid eye movement (REM) sleep and take longer to reach the REM sleep stage may have a greater risk of developing dementia, new research suggests.\n\n“By clarifying the role of sleep in the onset of dementia, the hope is to eventually identify possible ways to intervene…”\nResearchers have long known that people with dementia often experience disturbed sleep, but it has been unclear if sleep disruption is a consequence of the disease or if it is associated with the risk of dementia.\n\n“We set out to discover which stages of sleep may be linked to dementia, and while we did not find a link with deep sleep, we did with REM sleep,” says Matthew P. Pase, a fellow in the department of neurology at the Boston University School of Medicine (MED), an Framingham Heart Study investigator, and the coauthor of the study in Neurology.\n\nThe team looked at 321 people over the age of 60—their average age was 67—whose sleep cycles were measured during an overnight sleep study between 1995 and 1998. Researchers followed the participants for an average of 12 years. During that period, 32 people were diagnosed with some form of dementia; of those, 24 were found to have Alzheimer’s disease.\n\nThose who developed dementia spent an average of 17 percent of their sleep time in REM sleep; that figure was 20 percent for those who did not develop dementia.\n\nAfter adjusting for age and sex, researchers found that for every percent that REM sleep was reduced, there was a nine percent increase in the risk for all forms of dementia and an eight percent increase in the risk of dementia due to Alzheimer’s disease.\n\nJust 1 night of bad sleep boosts amyloid beta in brain\n\nThe researchers came up with similar results after adjusting for other factors that could affect dementia risk or sleep, such as heart disease, depression symptoms, and medication use. They did not find an association between other stages of sleep and an increased risk for dementia.\n\n“Different stages of sleep may differentially affect key features of Alzheimer’s disease,” says Pase. “Our findings implicate REM sleep mechanisms as predictors of dementia. The next step will be to determine which mechanisms of REM sleep lead to the greater risk of dementia. By clarifying the role of sleep in the onset of dementia, the hope is to eventually identify possible ways to intervene so that dementia can be delayed or even prevented.”\n\nThe researchers note that the limitations of the study include its small sample size and, because all the participants were of Caucasian descent, it is unclear how the results would apply to other ethnic groups.\n\nEarlier in 2017, Pase and Seshadri were coauthors of a study that found that older adults who began getting more than nine hours of sleep a night—but had not slept that much in the past—had double the risk of developing all forms of dementia, including Alzheimer’s, a decade later than those who slept nine hours or less.\n\nIs too much sleep an early sign of dementia?\n\nThe National Heart, Lung, and Blood Institute, the National Institute on Aging, and the National Institute of Neurological Disorders and Stroke supported the newer study.\n\nPase presented his team’s findings in July 2017 at the Alzheimer’s Association International Conference in London.	2017-08-26 17:06:11.867823-04
5	It rains solid diamonds on Uranus and Neptune	science	Consider this your daily reminder that the solar system is even more awesomely bonkers than you realized: On Uranus and Neptune, scientists forecast rain storms of solid diamonds.\n\nThe gems form in the hydrocarbon-rich oceans of slush that swath the gas giants' solid cores. Scientists have long speculated that the extreme pressures in this region might split those molecules into atoms of hydrogen and carbon, the latter of which then crystallize to form diamonds. These diamonds were thought to sink like rain through the ocean until they hit the solid core.\n\nBut no one could prove that this would really work — until now. In a study published this week in the journal Nature Astrophysics, researchers say they were able to produce this "diamond rain" using fancy plastic and high-powered lasers.\n\n“Previously, researchers could only assume that the diamonds had formed,” lead author Dominik Kraus, a physicist at the Helmholtz Dresden-Rossendorf research center in Germany, told the magazine Cosmos. “When I saw the results of this latest experiment, it was one of the best moments of my scientific career.”\n\n\nScientists have tried to do this before — who wouldn't want to make it rain precious stones? — but they ran into problems mimicking the incredible pressures near the gas planet's cores. Neptune and Uranus are 17 and 15 times the mass of Earth, respectively, and their oceans are crushed by pressures millions of times more intense than the air pressure at Earth's sea level.\n\n Play Video 2:10\nDear Science: Where do old spacecraft go when they die?\n \n0:00\n\nSpace agencies have two options for satellites, rovers and probes whose missions have come to the end. The Post's Sarah Kaplan tells you more. (Monica Akhtar, Sarah Kaplan/The Washington Post)\nTo match this absurd intensity, Kraus and his colleagues used two types of laser — one optical, one X-ray — to produce shock waves. These waves were then driven through a block of polystyrene — a type of plastic composed of hydrogen and carbon, just like Uranus and Neptune's oceans.\n\n“The first smaller, slower wave is overtaken by another stronger second wave,” Kraus explained in a news release. The combination of the two waves squeezed the plastic to 150 gigapascals of pressure — more than exists at the bottom of Earth's mantle — and heated it to more than 8,500 degrees. At that moment, the diamonds began to form.\n\nThe process lasted only a fraction of a second, and the diamonds were no bigger than a nanometer in length. But Kraus and his colleagues believe that the diamonds that develop on Uranus and Neptune are probably bigger and longer-lasting.\n\nSpeaking of Science newsletter\nThe latest and greatest in science news.\nSign up\n\n“In the planet you have years, millions of years, and a long range of conditions where this actually can happen,” co-author Dirk Gericke, of the University of Warwick, told the Guardian.\n\nThe results will be useful not just for understanding the outer gas giants but for improving the process of making diamonds. Most lab-grown stones are produced via a blasting process, but Kraus and Gericke suggest that using lasers may make production cleaner and easier to control. Those stones can then be used for semiconductors, drill bits and solar panels, not to mention instruments that mimic the conditions inside the very gas planets that inspired this research.	2017-08-26 17:07:20.014718-04
6	12 unanswered questions before the Game of Thrones season 7 finale	entertainment	Spoilers ahead for all of Game of Thrones.\n\nThe Game of Thrones season 7 finale airs this Sunday, and it’s sure to be full of bloodshed and gore, possibly with a dash of incestuous romance. With an ice zombie dragon that bears resemblance to a certain Yu-Gi-Oh! card in play, and relationships that fans have been rooting for finally blossoming, we’re heading into the finale with plenty of loose threads and questions to answer. Here are the top 12 things we hope to see addressed in the epic season finale.\n\n1) Will Bran finally do something useful?\n\nAlthough we’ve seen relatively little of Bran in season 7, it’s becoming more apparent that he will play a key role in the war against the army of the dead, and in revealing crucial pieces of information to characters. His ability to project himself backwards and forward through time into other people’s bodies has allowed him to learn about the creation of the White Walkers, Jon’s parentage, and discover his own hand in Hodor’s origin story. (RIP, we miss you, Hodor.) In a conversation with Sansa in episode 3, he claimed that he can never be a Lord of Winterfell, and said, “I need to learn to see better. When the long night comes again, I need to be ready.” Is he brushing up on his Three-Eyed Raven skills so he can warg into the Night King or the zombie dragon Viserion, ending the war before the long night comes again?\n\nBRAN COULD BE THE NIGHT KING\nThere is also the popular theory that Bran is the Night King, and has been stuck in his body for thousands of years after being marked in a vision. The Three-Eyed Raven and Jojen did warn Bran that if he stayed in one place too long, he could get stuck. Is that why The Night King let Jon go at Hardhome — because it was actually Bran, seeing a member of his family after a millennia? Is all of this just a confusing time loop that finally closes with Jon killing the Night King, who is actually Bran thousands of years ago? It could explain why Bran said “I need to talk to Jon.” Maybe he’s trying to tell Jon to kill the Night King (aka himself) to end the war, ultimately sacrificing himself in the process. Frankly, this seems like a more key piece of information than Jon’s true lineage.\n\n\nCredit: HBO\nAside from the war, Bran could also prove himself useful in the feud between Arya and Sansa (if they’re not already one step ahead of him, but we’ll get to that later). We saw the way Bran blurted out “chaos is a ladder” to Littlefinger, exposing Lord Baelish as the manipulator he is. Bran also creepily recounted Sansa’s wedding night to her and apologized for everything she had to go through in Winterfell. He terrified her, but in the process gave a strong impression of being truly all-knowing. That could come in handy if he decides to clue Sansa and Arya in on Littlefinger’s true intentions. A simple one-liner could bring the two sisters together in alliance to murder Littlefinger — because seriously, how is that guy still alive?\n\n\n2) Can Daenerys give birth again?\n\n\nHBO\nIn season 7’s penultimate episode, Daenerys informs Jon that dragons are the only children she’ll ever have. She likely believes this because back in season 1, she was pregnant with the son of Khal Drogo, but that baby was stillborn with lizard-like wings. At the time, it was said that the child’s life had been traded as part of a blood ritual intended to save Drogo’s life.\n\nIn the books, Dany was specifically told that her womb was cursed — but the show very specifically omitted that particular detail. Is that because Dany’s prospects for children aren’t as bleak as she thinks, particularly if her feelings about Jon Snow continue to evolve?\n\n3) Will Arya and Sansa Stark make peace, or war?\n\n\nHBO\nThanks to Littlefinger’s manipulations, Arya Stark is on poor terms with her sister Sansa. Or is she? We know that Arya’s training at the House of Black and White in Braavos helped her become a master spy. She followed Littlefinger upon returning to Winterfell, but was she just trying to determine if he was purposefully driving a wedge between her and her sister?\n\nONE OF THE MOST AWKWARD AND AGGRESSIVE INTERACTIONS\nSpeaking of Sansa, in episode 6, Littlefinger suggested she use Brienne of Tarth as a weapon to protect herself against Arya. This could have been the moment that Sansa realized that Lord Baelish was up to something. We know that she is already well aware of his manipulative ways, even warning Bran that, “He wouldn’t give you anything unless he thought he was getting something back.“ She ultimately went against Littlefinger’s advice, sending Brienne off to represent the North at a meeting requested by Cersei.\n\nBut he had already planted doubts, and Sansa went snooping through Arya’s things, landing upon her bag of faces in the process. It lead to the most awkward and aggressive interaction we’ve seen between the sisters, with Arya explaining that thanks to her time in Braavos, “I can become someone else, speak in their voice, live in their skin. I could even become you.” She then approached Sansa with a dagger, but flipped it around at the last minute, handing it over. Some have seen this as a direct threat, while others have interpreted it as Arya signaling to Sansa that she can be of help, without directly mentioning Littlefinger. Why? Because Arya knows he has eyes and ears everywhere.\n\nIt would be really stupid if the two sisters actually killed each other. They are Starks, after all. The better theory is that Arya will kill Littlefinger, and add his face to her collection so she can actually help Sansa. By pretending to be Littlefinger, she can still keep the support of the Vale, while eliminating his threat entirely. Because after all, “the lone wolf dies, but the pack survives,” as Sansa said ominously in a season 7 teaser.\n\n4) What will happen to the Greyjoys?\n\n\nHBO\nNo matter how you put it, there’s pretty much no happy ending for Theon. Some people have more sympathy for him due to his tortured Reek past, while others have just been waiting for him to die ever since he betrayed Robb Stark in season 2. He didn’t help his cause in the second episode of this season, when he let his sister Yara be captured by their uncle, Euron. Yara was last seen in chains when Euron arrived in King’s Landing to hand over the Sand Snakes as a gift to Cersei.\n\nThere’s a quick shot of what looks like Theon dropping to his knees on the shore in the episode 7 finale preview, but it appears to be more of an emotional collapse rather than a physical one. Could Yara be dead? Tortured? Will Theon save her from Euron’s grip, and kill him to metaphorically reclaim his own manhood? Given what Theon’s been through, a part of us really does want to see him catch a break at some point.\n\n5) Will we finally get Cleganebowl?\n\n\nHBO\nThis is probably one of the most anticipated showdowns in Game of Thrones history. We’ve been patiently waiting for seven seasons to see the two sworn brotherly enemies come head-to-head. In the episode 7 preview, we see Gregor Clegane, also known as The Mountain, by Cersei’s side. As for the Hound, we last saw him dumping a wight into a boat. We assume he’s headed to Kings Landing with Jon and crew to bring the body to Cersei. Given those two pieces of information, it’s practically a lock that the two will be in King’s Landing at the same time.\n\nThere’s also a shot of The Hound pulling a sword in the Season 7 trailer that has yet to appear in the series. It will clearly happen in the final episode, and could be another indication that Cleganebowl is coming. Because why wouldn’t the Hound kill the Mountain on sight?\n\nOf course, it could also just be the Hound killing the wight, or getting into some other, unrelated skirmish. But we’re certainly hoping it’s an epic battle between the two brothers.\n\n\n6) Will someone reveal the truth about Jon’s parentage?\n\nEarlier this season Samwell Tarly tried to convince the Citadel’s group of Archmaesters that Bran’s warning about an army of the dead was very real. After having his concerns dismissed, Sam returned home for a reading session. At this point, we witnessed probably one of the most important scenes in Game of Thrones history. Gilly stumbled across the word “annulment” in one of High Septum Maynard’s diaries and asked Sam to define it. He frustratingly explained that it meant the termination of a marriage.\n\nHE WAS TIRED OF DEALING WITH SHIT\nShe then continued to say, “Maynard says here that he issued an annulment for a Prince Rhaegar” — which she adorably pronounced as “Raggar” — “and remarried him to someone else at the same time in a secret ceremony in Dorne.” Sam then cut her off to mansplain about his issues with the Citadel. He finally declared, “I’m tired of reading about the achievements of better men,” and ditched Old Town with his family, Archmaester Maynard’s diary presumably in hand.\n\n\nHBO\nWe also know that Bran’s flashback in season 6 practically confirmed Jon Snow is the son of Lyanna Star and Rhaegar Targaryen, Daenarys’s older brother. With Bran knowing who Jon’s parents were, and Sam carrying evidence that proves they were secretly married, the question isn’t if Jon will find out the truth. It’s a matter of when, and who will tell him.\n\n7) What do Melisandre and Varys have planned?\n\n\nHBO\nIn season 7, episode 3, Melisandre expressed guilt to Varys over her past crimes, like burning Shireen Baratheon at the stake. Then she disappeared, saying she shouldn’t show her face in Westeros anymore. But she also told Varys that eventually she would need to return to Westeros to die — just as he would.\n\nBoth characters are invested in who eventually becomes the ruler of Westeros, whether it’s Cersei, Daenerys, or someone else entirely. Both The Red Woman and the Spider have been long-game strategists with endless machinations in play. Are their hopes as straightforward as, just get Jon Snow or Dany on the throne? Varys hasn’t promised Dany complete loyalty, either — if she strays from justice, he will act in retaliation. Knowing these two schemers, there will probably be caveats and side plots involved, no matter what they’re up to.\n\n8) Will all the parts of Cersei’s prophecy come true?\n\n\nHBO\nGeorge R.R. Martin may not have finished the books yet, but he left enough hints for the showrunners to work from in the form of prophecies and visions. One of these prophecies was delivered to Cersei Lannister by Maggy the Frog in season 5. Maggy stated that a younger, more beautiful queen would usurp Cersei, and that all three of her children would be buried in golden shrouds. We have already seen much of the prophecy come to pass, including the deaths of all three of her children. But now Cersei says she’s pregnant. Does that mean she will die before the child is born, or is it a clue that she’s lying about her pregnancy?\n\nEven worse, the prophecy in the books states that Cersei will die at the hands of the Valonqar — “little brother” in High Valyrian. Assuming the showrunners respect this detail from the books, this could infer that either Tyrion or Jaime will eventually kill Cersei.\n\n9) Do our favorite almost-couples finally get together?\n\n\nHBO\nAside from the incestuous passion-fest between Jaime and Cersei, we haven’t really seen any romances come to fruition in quite some time. At this stage, the two biggest question mark romances are between aunt-nephew duo Jon Snow and Daenerys Targeryen, and the large-and-in-charge warriors Tormund and Brienne. Let’s start with Jon and Dany.\n\n\nThis is probably the most tension-filled and anticipated romance in Game of Thrones. For one, they’re both ridiculously good-looking. Plot-wise, it’s almost inevitable that the pair become an item after their intense hand-holding session on Dany’s boat. Jon even declared his allegiance to Dany after she blushed at his use of her nickname, instead offering, “How about my queen?” Was this Jon’s subliminal way of offering himself to her as a strategic marriage-partner? And let’s not forget Jorah’s “blessing,” where he officially handed over Longclaw to Jon, saying “I forfeited the right to claim this sword. It’s yours. May it serve you well, and your children after you.” Was the reference to children a hint at Jon having kids with Dany? It may be a stretch, but we know how Game of Thrones love to foreshadow with unsuspecting one-liners.\n\nMoving on to our favorite budding one-sided romance: Tormund and Brienne. The small moments between these two are pure joy. Allow us to refresh your memory:\n\n\nBrienne has basically grimaced with disgust every time she’s encountered Tormund, but he’s persisted nonetheless. His fascination is driven by a love of her giant mutant child-bearing abilities, and bad-ass, “I could probably kill you in one-on-one combat” vibes. It’s adorable. We know from the episode 7 preview that Brienne will end up at King’s Landing on a possible suicide mission inside Cersei’s dragonpit, and Tormund isn’t pictured in the preview shot of Jon and his squad arriving for their meeting with the Queen. But that doesn’t necessarily mean he’s not there, or that he and Brienne won’t be united in some way during the final episode. Either way, can we please have this?\n\n10) Will Arya ever reunite with Gendry?\n\n\nHBO\nArya and Gendry have a bond that dates back to season 2, when Arya was still on the run from King’s Landing, but neither character has seen each other since. In the time that has passed, Arya has developed into a highly skilled magical assassin, and Gendry went into hiding in Flea Bottom and learned his way around a hammer. Although Gendry disappeared off the show for several seasons, he finally rejoined the gang in season 7, and Arya — who’s currently in Winterfell — would be glad to see him if their paths ever crossed again.\n\n11) Will Arya Stark cross the rest of the names off her kill list?\n\n\nHBO\nAlthough we haven’t heard Arya mutter her kill list to herself in a long time, she has mentioned it in passing to Sansa this season. So, who’s still alive on Arya’s list, and will she ever get to killing them? Cersei Lannister is the prime target, followed by the Mountain, the Red Woman, Beric Dondarrion, and Ilyn Payne, who executed Arya’s father. Given Arya’s current location up north, it’s more likely that she can reach Beric by the season finale, rather than the others. Then again, the characters this season have shown their powers of teleportation already, so perhaps Arya has a trip down south planned soon.\n\n12) Is Cersei going to go full Mad Queen?\n\n\nHBO\nLove her or hate her, Cersei is a master villain. After she brought all of her enemies together in one place last season and blew them up, we knew she was truly capable of anything. It’s hard not to see the parallels in the season finale preview, where she has invited her now-enemies into the dragonpit for what could be High Sept explosion part two. After all, if you know a little dragonpit history, you know that King Aerys, aka the Mad King, stored caches of wildfire all over King’s Landing, in case his enemies ever attacked him. Will Jaime catch wind of this plan and kill her — and will that be how Maggy the Frog’s prophecy gets fulfilled?\n\nBonus unanswered questions:\n\n\nHBO\nWill Ed Sheeran reprise his cameo? He didn’t get to do much, besides sing a song from the books and meet with Arya, and what little screentime he did get was not well-received. For the real-life Ed Sheeran’s sake, we hope that he’s gone.\nIs Tyene Sand dead, and what will happen to Ellaria Sand? We last saw them in the dungeons where Cersei planted a poisonous kiss on Tyene’s lips in retribution for Myrcella Baratheon’s murder. Cersei promised to let Ellaria rot in the cell forever, but since this is Game of Thrones, nothing’s for certain until there’s a dead body on the screen.	2017-08-26 17:09:19.406141-04
7	Is a 200-300 mile range enough for Tesla to break into electric trucking?	business	On Thursday, Reuters reported that Tesla is building electric semis with ranges of 200-300 miles. Tesla has said it will make all details about the semis public at an announcement in September.\n\nFURTHER READING\nIs Elon Musk serious about the Tesla Semi?\nArs reached out to the company to confirm the report, and a spokesperson responded with a statement saying: “Tesla’s policy is to always decline to comment on speculation, whether true or untrue, as doing so would be silly.”\nSo if the report is true, would a truck with a range of 200-300 miles be enough to win entry into the freight trucking market? Possibly. A 2013 report from the National Renewable Energy Laboratory in Colorado notes that “trucks dominate the market today for freight shipments under 500 miles, which account for almost 80 percent of all domestic freight tonnage.” Freight that needs to travel 500 miles or more tends to be transported by rail, waterways, or pipeline, at least if you’re counting by tonnage (the Bureau of Transportation Statistics counts oil and gas pipeline deliveries as freight).\n\nWhile long-haul trucking beyond 500 miles is obviously cost-effective for some deliveries (especially to areas that aren’t on a rail line or waterway), there seems to be a robust market for truck hauls under 500 miles that Tesla could break into.\n\nKen Harper, the Marketing Director for freight exchange service DAT, is bullish on Tesla’s ability to make a semi that is competitive with diesel for some situations. The key is that all truckers are currently not allowed to work more than a certain number of hours out of 24 anyway—including time when they’re waiting at a dock to unload or waiting for the truck to charge. With a 200-300 mile range, “You could take a load up from point A to point B, load up again, and you still have time left on your hours of service.”\n\n“The big question is going to be the financial trade off,” Harper said. “Aside from drivers, the biggest cost is fuel and maintenance, and if you lower the cost of fuel and maintenance, [you can] compare it to a regular diesel.”\n\nLast August, when Tesla announced that it was thinking about building a semi, Ars senior auto editor Jonathan Gitlin talked to some electric trucking experts about the viability of this plan. Ryan Popple, the CEO of zero-emissions bus manufacturer Proterra, said at the time that he suspected Tesla’s semi could be an internal project that would run Gigafactory batteries to the Tesla manufacturing facility. Interestingly, the Sparks, Nevada Gigafactory and the Fremont, California Tesla assembly plant are 239 miles apart from each other. (The battery-laden trucks would also have the advantage of losing several thousand feet in elevation on their trip out to the Fremont plant, while they would be able to drive up that elevation on the return trip empty.)\n\nELD regulations\n\nAnother factor could play a part in whether Tesla’s truck could compete with diesel counterparts: on December 18, the Federal Motor Carrier Safety Administration will begin requiring 3.5 million commercial truckers to install electronic logging devices on their trucks, replacing the pen-and-paper hour-logging system that some truckers currently use. Most large corporate fleets already use these ELDs, but smaller fleets and independent contracting truckers will have to invest in the devices. The result is that smaller fleets might see a higher cost for freight hauls longer than 450 miles. According to a blog post from DAT, the impact of the EDLs “will be felt disproportionately on longer, one-day hauls of over 450 miles and also on short-haul operations that push the current 14-hour limits today.”\n\n“Any time ELD requirements cause trips to spill over into a second day, it means rescheduled appointments, missed reloads, and a host of operational issues,” DAT wrote. If traditional trucks are suffering from the same kinds of problems that electric trucks might face (that is, limits on range due to either regulation of drivers’ hours or battery chemistry), then the proposition of going electric becomes more reasonable.\n\nOf course, what we don’t know is how big the semis will be and how big their corresponding batteries will be. Harper also says that a sticking point will be charging—semis can’t just charge in a grocery store parking lot using the passenger car charger that’s there today. New charging points will have to be installed in many places.\n\nBut there’s time to figure that out. Tesla is “a couple years out” from actually having these semis in a mass-market setting. “They need to manufacture these vehicles,” Harper said. “Then they’ll have testers, private fleets, early adopters.”	2017-08-26 17:10:36.439867-04
8	Moab Music Festival marks 25 years of music among the rocks	music	Moab Music Festival marks 25 years of music among the rocks	2017-08-26 17:13:06.962327-04
9	Evanston Township High School adopts a kinder, gentler dress code where leggings are OK	us	Welcome to a Tale of Two Dress Codes, a modern tale that unfolds during the Leggings Revolution.\n\nIt’s nonfiction.\n\nADVERTISING\n\nIn South Carolina, high school Principal Heather Taylor is accused of telling high school girls not to wear leggings if they’re larger than a size 2.\n\n“I’ve told you this before, I’m going to tell you this now,” Taylor allegedly told students at a dress code assembly this week. “Unless you are a size zero or 2 and you wear something like that, even though you’re not fat, you look fat.”\n\nPaid Post WHAT'S THIS?\n \nrenu® Advanced Formula\n\nA Message from Bausch and Lomb\n\nCare for your contacts with new and improved renu® Advanced Formula, the latest in lens care science. Click to learn more.\n\nSee More\nWorst of times.\n\nSomeone audio recorded the assembly and shared that bit with a local NBC affiliate. Parents and students are justifiably outraged.\n\nMeanwhile, over in the best of times ...\n\nEvanston Township High School has released an updated dress code for the school year that starts Monday, and it explicitly prohibits decisions and language that shame students.\n\nIt begins: “Staff shall enforce the dress code consistently and in a manner that does not reinforce or increase marginalization or oppression of any group based on race, sex, gender identity, gender expression, sexual orientation, ethnicity, religion, cultural observance, household income or body type/size.”\n\nUnder the new code, students may wear hats, hoodies, tank tops and spaghetti straps — all items barred under the old dress code.\n\nStudents may not wear clothing containing violent language or images, images or language that depict drug or alcohol use, or clothing that includes hate speech, profanity, pornography or hostility toward marginalized groups.\n\nLeggings are fine.\n\n“Fitted pants, including opaque leggings, yoga pants and skinny jeans” are specifically green-lighted.\n\n“It speaks volumes about how much they respect their students,” Evanston community activist Christine Wolf told me. “It really shows a commitment to listening to kids and what they need and being open to as many different voices as possible.”\n\nWolf, mom to an Evanston Township graduate and an incoming freshman, penned an op-ed in 2014 that was critical of nearby Haven Middle School’s inconsistent policy on leggings.\n\nWolf’s op-ed quotes a letter from parents of a Haven middle schooler who was told her leggings were distracting the boys.\n\n“This kind of message lands itself squarely on a continuum that blames girls and women for assault by men,” the parents wrote. “It also sends the message to boys that their behaviors are excusable, or understandable given what the girls are wearing. And if the sight of a girl's leg is too much for boys at Haven to handle, then your school has a much bigger problem to deal with.”\n\nIn the new Evanston Township dress code?\n\n“Students should not be shamed or required to display their bodies in front of others (students, parents or staff) in school,” the policy reads. “Shaming includes, but is not limited to … accusing students of ‘distracting’ other students with their clothing.”\n\nFor years, the school’s students have approached administrators with concerns that students of color get called out for dress code violations more frequently than white students and students whose bodies are more developed are cited for wearing clothing that other students get away with.\n\n“These are 14- to 18-year-old kids,” Wolf said. “Their bodies are changing every single day. They’re trying to live their lives and get an education.”\n\nStudents surveyed classmates last year about what they’d like to see in a new dress code, led protests against the old policies and worked closely with administrators, led by Principal Marcus Campbell, to craft a better set-up.\n\nAs recent graduate Marjie Erickson wrote on Facebook this week about the new dress code:\n\n“This is a revolutionary act of reclaiming our bodies as ours instead of a ‘distraction’ or something to be ashamed of. This is our protection against being penalized for someone else's perception of our bodies, and what is appropriate and respectable. … The new dress code is inclusive, progressive, and the standard every school should be held to.”\n\nI couldn’t agree more. And I can think of a school in South Carolina that should be the first on board.	2017-08-26 17:15:08.724656-04
11	Here's Why The Big 3 Cruise Lines Are Seeing Strong Profits And Rising Stock Prices	cruiselines	The Big Three cruise line operators Carnival CCL -0.01%, Royal Caribbean Cruises RCL -0.08% and Norwegian Cruise Line, all based in Miami, are riding a consumer trend to buy experiences rather than things.\n\n"People have bought all the stuff that they need, and they're now looking towards gaining more experiences," Royal Caribbean Chairman and CEO Richard Fain said on an August 1 call with analysts. "Instead of buying TVs and cars, they seem to be buying memories as never before."\n\nDavid Beckel, vice president and senior equity analyst for investment research firm Sanford C. Bernstein, like Fain, sees a cultural shift at work.\n\n"Royal Caribbean and Norwegian on their recent earnings calls both cited a secular shift I have been trying to hone in on. People are shifting more to experiences," Beckel said in an interview. "Cruise lines being a pure play on experience, they are uniquely situated to benefit from that trend."\n\n\nADVERTISING\n\n\n\nCarnival is the largest cruise ship operator in the world with annual sales north of $15 billion. The company earlier reported outstanding second quarter results as it grows its fleet of ships.\n\nPassengers on the maiden voyage of Carnival's newest cruise ship, the AIDAperla, in June got a lot more than the usual fancy restaurants, casinos, pools and the like.\n\nThere is an on-board brewery, waterslides, a miniature golf course, a McDonald&#039;s MCD +0.26% and a "lazy river" experience where passengers can leisurely float down an indoor river on an inner tube. All three cruise lines are introducing bigger, more feature-filled ships to attract experience seekers.	2017-08-26 17:22:02.246395-04
\.


--
-- Name: channels chats_pkey; Type: CONSTRAINT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: messages message_pkey; Type: CONSTRAINT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: world_news_articles untitled_table_pkey; Type: CONSTRAINT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY world_news_articles
    ADD CONSTRAINT untitled_table_pkey PRIMARY KEY (id);


--
-- Name: messages message_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tonialiberti
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES channels(id);


--
-- Name: postgraphql_watch; Type: EVENT TRIGGER; Schema: -; Owner: tonialiberti
--

CREATE EVENT TRIGGER postgraphql_watch ON ddl_command_end
         WHEN TAG IN ('ALTER DOMAIN', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER SCHEMA', 'ALTER TABLE', 'ALTER TYPE', 'ALTER VIEW', 'COMMENT', 'CREATE DOMAIN', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE SCHEMA', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE VIEW', 'DROP DOMAIN', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP SCHEMA', 'DROP TABLE', 'DROP VIEW', 'GRANT', 'REVOKE', 'SELECT INTO')
   EXECUTE PROCEDURE postgraphql_watch.notify_watchers();


-- ALTER EVENT TRIGGER postgraphql_watch OWNER TO tonialiberti;

--
-- PostgreSQL database dump complete
--
