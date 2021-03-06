CREATE TABLE gg_hero
(
	name VARCHAR2(15) CONSTRAINT hr_nm_pk PRIMARY KEY,
	role VARCHAR2(10) NOT NULL CONSTRAINT chk_rl CHECK(role = 'Tank' OR role = 'Offense' OR role = 'Defence' OR role = 'Support'),
	ability1 VARCHAR2(25) NOT NULL,
	ability2 VARCHAR2(25) NOT NULL,
	ability3 VARCHAR2(25) NOT NULL,
	ability4 VARCHAR2(25),
	ability_passive VARCHAR2(25),
	ability_ult1 VARCHAR2(25) NOT NULL,
	ability_ult2 VARCHAR2(25)
);

CREATE TABLE gg_team
(
	team_name VARCHAR2(25) CONSTRAINT tm_tm_id_pk PRIMARY KEY,
	t_facebook VARCHAR2(60),
	t_twitter	 VARCHAR2(60),
	t_youtube	 VARCHAR2(60),
	t_website	 VARCHAR2(60) CONSTRAINT tm_tm_web_uk UNIQUE
);

CREATE TABLE gg_player
(
	username VARCHAR2(25) CONSTRAINT plr_usnm_pk PRIMARY KEY,
	email 	 VARCHAR2(60) NOT NULL,
	team_id  VARCHAR2(25),
	p_facebook VARCHAR2(60),
	p_twitter	 VARCHAR2(60),
	p_youtube	 VARCHAR2(60),
	p_twitch	 VARCHAR2(60)
);


CREATE TABLE gg_team_history
(
	username  VARCHAR2(25),
	team_name VARCHAR2(25),
	start_date DATE NOT NULL,
	end_date   DATE NOT NULL,

	CONSTRAINT tm_hist_st_end_chk CHECK(end_date > start_date),
	CONSTRAINT tm_hist_tm_nm_usrnm_pk PRIMARY KEY (username, team_name)
);

CREATE TABLE gg_player_hero
(
	username VARCHAR2(25),
	name	 VARCHAR2(15),
	eliminations NUMBER(6,0) NOT NULL,
	deaths 		 NUMBER(6,0) NOT NULL,
	damage		 NUMBER(10,0) NOT NULL,
	healing		 NUMBER(10,0) DEFAULT 0,
	wins		 NUMBER(5,0) DEFAULT 0,
	losses		 NUMBER(5,0) DEFAULT 0,
	damage_blocked NUMBER(10, 0) DEFAULT 0,
	
	CONSTRAINT plr_hr_usnm_nm_pk PRIMARY KEY (username, name)
);

CREATE TABLE gg_event
(
    event_id NUMBER(4,0) CONSTRAINT evnt_id_pk PRIMARY KEY,
    event_name VARCHAR2(50) NOT NULL,
    event_date DATE NOT NULL,
    event_website VARCHAR2(100) NOT NULL,
    event_type      VARCHAR2(6) NOT NULL,
    venue     VARCHAR2(50),
    county   VARCHAR2(50),
    country  VARCHAR2(50),
    server_region VARCHAR2(4) CONSTRAINT evnt_svr_reg_chk CHECK(server_region = 'US' OR server_region = 'EU' OR server_region = 'Asia'),
    first_prize      VARCHAR2(25) NOT NULL,
    second_prize      VARCHAR2(25) NOT NULL,
    third_prize      VARCHAR2(25) NOT NULL,

    CONSTRAINT evnt_typ_chk CHECK(
        (event_type = 'Lan' AND venue IS NOT NULL AND county IS NOT NULL AND country IS NOT NULL AND server_region IS NULL)
        OR
        (event_type = 'Online' AND server_region IS NOT NULL AND venue IS NULL AND county IS NULL AND country IS NULL)
        )
);

CREATE TABLE gg_event_team
(
	event_id NUMBER(4,0),
	team_name VARCHAR2(25),

	CONSTRAINT evnt_tm_pk PRIMARY KEY(event_id, team_name)
);

CREATE TABLE gg_map
(
	name VARCHAR2(30) CONSTRAINT mp_nm_pk PRIMARY KEY,
	location VARCHAR2(30) NOT NULL,
	map_type VARCHAR2(15) NOT NULL,
	objective VARCHAR2(100) NOT NULL,
	team_size NUMBER(2,0) NOT NULL
);

CREATE TABLE gg_event_map
(
	event_id NUMBER(4,0),
	map_name VARCHAR2(30),

	CONSTRAINT evnt_mp_nm_id_pk PRIMARY KEY(event_id, map_name)
);

CREATE TABLE gg_rank
(
	rank_player VARCHAR2(25),
	rank NUMBER(4,0) NOT NULL CONSTRAINT rnk_chk CHECK(rank < 5001),
	date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_current NUMBER(1,0) DEFAULT 1 CONSTRAINT rnk_curr_chk CHECK(is_current = 0 OR is_current = 1),

	CONSTRAINT rnk_plr_dt_pk PRIMARY KEY(rank_player, date_time)
);

ALTER TABLE gg_player
ADD CONSTRAINT plr_tm_fk FOREIGN KEY (team_id) REFERENCES gg_team(team_name) ON DELETE SET NULL;

ALTER TABLE gg_team_history
ADD CONSTRAINT tm_hist_usnm_fk FOREIGN KEY (username) REFERENCES gg_player(username) ON DELETE CASCADE;

ALTER TABLE gg_team_history
ADD CONSTRAINT tm_hist_nm_fk FOREIGN KEY (team_name) REFERENCES gg_team(team_name);

ALTER TABLE gg_player_hero
ADD CONSTRAINT plr_hr_usnm_fk FOREIGN KEY (username) REFERENCES gg_player(username) ON DELETE CASCADE;

ALTER TABLE gg_player_hero
ADD CONSTRAINT plr_hr_nm_fk FOREIGN KEY (name) REFERENCES gg_hero(name) ON DELETE CASCADE;

ALTER TABLE gg_event_map
ADD CONSTRAINT evnt_mp_evnt_id_fk FOREIGN KEY (event_id) REFERENCES gg_event(event_id);

ALTER TABLE gg_event_map
ADD CONSTRAINT evnt_mp_mp_nm_fk FOREIGN KEY (map_name) REFERENCES gg_map(name);

ALTER TABLE gg_event_team 
ADD CONSTRAINT evnt_tm_evnt_fk FOREIGN KEY(event_id) REFERENCES gg_event(event_id) ON DELETE CASCADE;

ALTER TABLE gg_event_team
ADD CONSTRAINT evnt_tm_tm_fk FOREIGN KEY(team_name) REFERENCES gg_team(team_name) ON DELETE CASCADE;



--VALUES(name, role, ability 1, ability 2, ability 3, ability 4, ability_passive, ability_ult1, ability_ult2)
INSERT ALL
INTO gg_hero VALUES ('Genji', 'Offense', 'Successive Shuriken', 'Fan of Blades', 'Swift Strike', 'Deflect', 'Cyber-Agility', 'Dragonblade', null)
INTO gg_hero VALUES ('McCree', 'Offense', 'Peacekeeper', 'Fan the Hammer', 'Combat Roll', 'Flashbang', null, 'Deadeye', null)
INTO gg_hero VALUES ('Pharah', 'Offense', 'Rocket Launcher', 'Hover Jets', 'Jump Jet', 'Concussive Blast', null, 'Barrage', null)
INTO gg_hero VALUES ('Reaper', 'Offense', 'Hellfire Shotguns', 'Wraith Form', 'Shadow Step', null, 'The Reaping', 'Death Blossom', null)
INTO gg_hero VALUES ('Soldier: 76', 'Offense', 'Heavy Pulse Rifle', 'Helix Rockets', 'Biotic Field', 'Sprint', null, 'Tactical Visor', null)
INTO gg_hero VALUES ('Sombra', 'Offense', 'Machine Pistol', 'Hack', 'Stealth', 'Translocator', 'Opportunist', 'EMP', null)
INTO gg_hero VALUES ('Tracer', 'Offense', 'Pulse Pistols', 'Blink', 'Recall', null, null, 'Pulse Bomb', null)
INTO gg_hero VALUES ('Bastion', 'Defence', 'Recon', 'Self-Repair', 'Reconfigure', null, 'Ironclad', 'Tank', null)
INTO gg_hero VALUES ('Hanzo', 'Defence', 'Storm Bow', 'Sonic Arrow', 'Scatter Arrow', null, 'Wall Climb', 'Dragonstrike', null)
INTO gg_hero VALUES ('Junkrat', 'Defence', 'Frag Launcher', 'Concussion Mine', 'Steel Trap', null, 'Total Mayhem', 'RIP-Tire', null)
INTO gg_hero VALUES ('Mei', 'Defence', 'Frost Stream', 'Icicle Shot', 'Cryo-Freeze', 'Ice Wall', null, 'Blizzard', null)
INTO gg_hero VALUES ('Torbjorn', 'Defence', 'Rivet Shot', 'Rivet Burst', 'Turret', 'Armor Pack', 'Scrap Collector', 'Molten Core', null)
INTO gg_hero VALUES ('Widowmaker', 'Defence', 'Automatic Rifle', 'Sniper Rifle', 'Grappling Hook', 'Venom Mine', null, 'Infra-Sight', null)
INTO gg_hero VALUES ('D.Va', 'Tank', 'Fusion Cannons', 'Defense Matrix', 'Boosters', null, 'Eject', 'Self-Destruct', null)
INTO gg_hero VALUES ('Orisa', 'Tank', 'Fusion Driver', 'Halt!', 'Fortify', 'Protective Barrier', 'Energy', 'Supercharger', null)
INTO gg_hero VALUES ('Reinhardt', 'Tank', 'Rocket Hammer', 'Barrier Shield', 'Charge', 'Fire Strike', null, 'Earthshatter', null)
INTO gg_hero VALUES ('Roadhog', 'Tank', 'Shrapnel Blast', 'Shrapnel Ball', 'Chain Hook', 'Take A Breather', null, 'Whole Hog', null)
INTO gg_hero VALUES ('Winston', 'Tank', 'Tesla Cannon', 'Jump Pack', 'Barrier Projector', null, null, 'Primal Rage', null)
INTO gg_hero VALUES ('Zarya', 'Tank', 'Energy Beam', 'Explosive Charge', 'Particle Barrier', 'Projected Barrier', 'Energy', 'Graviton Surge', null)
INTO gg_hero VALUES ('Ana', 'Support', 'Unscoped', 'Scoped', 'Sleep Dart', 'Biotic Grenade', null, 'Nano Boost', null)
INTO gg_hero VALUES ('Lucio', 'Support', 'Sonic Projectile', 'Soundwave', 'Crossfade', 'Amp It Up', 'Wall Ride', 'Sound Barrier', null)
INTO gg_hero VALUES ('Mercy', 'Support', 'Healing Beam', 'Damage Boost Beam', 'Caduceus Blaster', 'Guardian Angel', 'Angelic Descent', 'Resurrection', null)
INTO gg_hero VALUES ('Symmetra', 'Support', 'Photon Beam', 'Energy Ball', 'Sentry Turret', 'Photon Barrier', null, 'Teleporter', 'Shield Generator')
INTO gg_hero VALUES ('Zenyatta', 'Support', 'Orb of Destruction', 'Orb Volley', 'Orb of Harmony', null, null, 'Transcendence', null)
SELECT * FROM dual;

--(event_id, event_name, date, website, type, venue, county, country, server region, first_prize, second_prize, third_prize)
INSERT ALL
INTO gg_event VALUES(100, 'OGN Apex Season 3', '04/28/2017', 'http://www.gosugamers.net/overwatch/events/673-ogn-overwatch-apex-season-3', 'Lan', 'E-Stadium', 'Seoul', 'Korea', null, '$85,630', '$34,250', '$10,275')
INTO gg_event VALUES(101, 'Overwatch Rumble', '04/18/2017', 'http://rivalcades.com/owrumble.php', 'Online', null, null, null, 'US', '$6,000', '$3,000', '$1,000')
INTO gg_event VALUES(102, 'Overwatch Pacific Championship', '04/08/2017', 'http://www.gosugamers.net/overwatch/events/668-overwatch-pacific-championship', 'Online', null, null, null, 'Asia', '$98,400', '$49,200', '$32,800')
INTO gg_event VALUES(103, 'Overwatch Premier Series', '04/29/2017', 'http://www.gosugamers.net/overwatch/events/655-overwatch-premier-series-2017-spring-season', 'Lan', 'Yun Space (Baoshan)', 'Shanghai','China', null, '$77,00', '$21,000', '$6,000')
SELECT * FROM dual;

--VALUES(team_id, facebook, twitter, youtube, website)
INSERT ALL
INTO gg_team VALUES ('EnVyus', 'https://www.facebook.com/TeamEnVyUs/', 'https://twitter.com/TeamEnVyUs', 'https://www.youtube.com/user/TeamEnVyUs', 'https://gg_teamenvyus.com/pages/overwatch')
INTO gg_team VALUES ('NRG', 'https://www.facebook.com/NRGwin/', 'https://twitter.com/NRGgg', 'https://www.youtube.com/c/nrggg', 'http://www.nrg.gg/overwatch')
INTO gg_team VALUES ('Rogue', 'https://www.facebook.com/goingroguegg/', 'https://twitter.com/goingroguegg', 'https://www.youtube.com/roguegg', null)
INTO gg_team VALUES ('Runaway', null, null, null, null)
SELECT * FROM dual;

--VALUES(event_id, team_name)
INSERT ALL
INTO gg_event_team VALUES(100, 'EnVyus')
INTO gg_event_team VALUES(100, 'NRG')
INTO gg_event_team VALUES(100, 'Rogue')
INTO gg_event_team VALUES(100, 'Runaway')

INTO gg_event_team VALUES(101, 'EnVyus')
INTO gg_event_team VALUES(101, 'NRG')
INTO gg_event_team VALUES(101, 'Rogue')
INTO gg_event_team VALUES(101, 'Runaway')

INTO gg_event_team VALUES(102, 'EnVyus')
INTO gg_event_team VALUES(102, 'NRG')
INTO gg_event_team VALUES(102, 'Rogue')
INTO gg_event_team VALUES(102, 'Runaway')

INTO gg_event_team VALUES(103, 'EnVyus')
INTO gg_event_team VALUES(103, 'NRG')
INTO gg_event_team VALUES(103, 'Rogue')
INTO gg_event_team VALUES(103, 'Runaway')
SELECT * FROM dual;

--VALUES(username, email, team_id, facebook, twitter, youtube, twitch)
INSERT ALL
INTO gg_player VALUES ('Taimou', 'taimouow@gmail.com', 'EnVyus', 'https://www.facebook.com/OFFICIALtaimou/', 'https://twitter.com/EnVy_Taimou', 'https://www.youtube.com/user/Taimouu', 'https://www.twitch.tv/taimoutv')
INTO gg_player VALUES ('HarryHook', 'harryhookow@gmail.com', 'EnVyus', null, 'https://twitter.com/envy_harryhook', null, 'https://www.twitch.tv/harryhook')
INTO gg_player VALUES ('cocco', 'coccoow@gmail.com', 'EnVyus', null, 'https://twitter.com/EnVy_Taimou', null, 'https://www.twitch.tv/cocco')
INTO gg_player VALUES ('chipshajen', 'chipsow@gmail.com', 'EnVyus', null, 'https://twitter.com/EnVy_chips', null, 'https://www.twitch.tv/chipshajen')
INTO gg_player VALUES ('INTERNETHULK', 'hulkow@gmail.com', 'EnVyus', null, 'https://twitter.com/EnVy_HULK', null, 'https://www.twitch.tv/internethulk')
INTO gg_player VALUES ('Mickie', 'mickie-ppow@gmail.com', 'EnVyus', 'https://www.facebook.com/MickiePP/', 'https://twitter.com/Mickie_PP', 'https://www.youtube.com/mickiepp', 'https://www.twitch.tv/MickiePP')
INTO gg_player VALUES ('aKm', 'akm95@gmail.com', 'Rogue', null, 'https://twitter.com/Rogue_aKm', null, null)
INTO gg_player VALUES ('SoOn', 'so0n-ow@gmail.com', 'Rogue', null, 'https://twitter.com/Rogue_SoOn', null, 'https://www.twitcwh.tv/soonsm')
INTO gg_player VALUES ('winz', 'i-winz@gmail.com', 'Rogue', null, 'https://twitter.com/Rogue_winz', null, 'https://www.twitcwh.tv/winz_TV')
INTO gg_player VALUES ('NiCO', 'nico-ow@gmail.com', 'Rogue', null, 'https://twitter.com/Rogue_NiCOgdh', null, null)
INTO gg_player VALUES ('uNKOE', 'unkoe@gmail.com', 'Rogue', null, 'https://twitter.com/Rogue_uNKOE', null, 'https://www.twitch.tv/unkoeee')
INTO gg_player VALUES ('KnOxXx', 'knoxxx@gmail.com', 'Rogue', null, 'https://twitter.com/Rogue_KnOxXx', null, 'https://www.twitch.tv/knoxxx69')
INTO gg_player VALUES ('iddqd', 'iddqdow@gmail.com', 'NRG', null, 'https://twitter.com/iddqdOW', null, 'https://www.twitch.tv/iddqdOW')
INTO gg_player VALUES ('dummy', 'dummyow@gmail.com', 'NRG', 'https://www.facebook.com/Tim-Olson-492164497651805', 'https://twitter.com/dummyolson', 'https://www.youtube.com/channel/UCPe63pqEA2Ij39Xna7ZJc8A', 'https://www.twitch.tv/dummyolson')
INTO gg_player VALUES ('numlocked', 'numlockedow@gmail.com', 'NRG', 'https://www.facebook.com/num1ocked', 'https://twitter.com/numlocked', 'https://www.youtube.com/num1ocked', 'https://www.twitch.tv/numlocked')
INTO gg_player VALUES ('Harbleu', 'harbleuow@gmail.com', 'NRG', null, 'https://twitter.com/harbleuOW', 'https://www.youtube.com/user/Harbleu', 'https://www.twitch.tv/harbleu')
INTO gg_player VALUES ('Ajax', 'ajax1ow@gmail.com', 'NRG', null, 'https://twitter.com/Ajax1OW', null, 'https://www.twitch.tv/ajax1TV')
INTO gg_player VALUES ('Seagull', 'aseagullbusiness@gmail.com', 'NRG', null, 'https://twitter.com/a_seagull', 'https://www.youtube.com/channel/UCaFnEJ5tWlK0TO5PWHqr8Hw', 'https://www.twitch.tv/a_seagull')
INTO gg_player VALUES ('Hoodie', 'hoodiez@gmail.com', 'Runaway', 'https://twitter.com/NiallGrnt', null, null, null)
INTO gg_player VALUES ('Nyaves', 'nyaves93@gmail.com', 'Runaway', null, null, 'https://www.youtube.com/user/z00ney', null)
INTO gg_player VALUES ('UnhappyMango', 'mango-93@gmail.com', 'Runaway', null, null, null, null)
INTO gg_player VALUES ('tictacz', 'tictacz@gmail.com', 'Runaway', null, null, null, null)
INTO gg_player VALUES ('BloodyMonday', 'mr-monday@gmail.com', 'Runaway', null, null, null, null)
INTO gg_player VALUES ('Frozen', 'frozen@gmail.com', 'Runaway', null, null, null, null)
INTO gg_player VALUES ('Mendokusaii', 'mendojo-ow@gmail.com', null, null, 'https://twitter.com/mendokusaii', 'https://www.youtube.com/channel/UCg9bCZl8859x6QrSfGbdOnw', 'https://www.twitch.tv/mendokusaii')
INTO gg_player VALUES ('Kephrii', 'kephkeph@gmail.com', null, null, 'https://twitter.com/Kephrii', 'https://www.youtube.com/user/Kephri1', 'https://www.twitch.tv/kephrii')
SELECT * FROM dual;

--VALUES(username, team_id, start_date, end_date)
INSERT ALL
INTO gg_team_history VALUES ('Harbleu', 'Rogue', '01/06/2016', '09/21/2016')
INTO gg_team_history VALUES ('Harbleu', 'EnVyus', '02/20/2016', '05/28/2016')
INTO gg_team_history VALUES ('iddqd', 'EnVyus', '04/04/2016', '11/16/2016')
INTO gg_team_history VALUES ('SoOn', 'NRG', '07/01/2016', '01/14/2017')
INTO gg_team_history VALUES ('INTERNETHULK', 'Rogue', '06/22/016', '02/02/2017')
INTO gg_team_history VALUES ('Seagull', 'Rogue', '03/20/2016', '07/15/2016')
INTO gg_team_history VALUES ('NiCO', 'EnVyus', '05/22/2016', '12/20/2016')
INTO gg_team_history VALUES ('HarryHook', 'NRG', '04/11/2016', '01/02/2017')
INTO gg_team_history VALUES ('HarryHook', 'Rogue', '02/22/2016', '03/02/2016')
SELECT * FROM dual;

--VALUES = (username, hero_name, eliminations, deaths, damage, healing, wins, losses, damage_blocked)
INSERT ALL 
INTO gg_player_hero VALUES ('Mendokusaii', 'McCree', 3100, 2200, 1200045, 0, 371, 200, 0)
INTO gg_player_hero VALUES ('Frozen', 'Bastion', 2700, 1800, 620045, 0, 300, 200, 0)
INTO gg_player_hero VALUES ('Kephrii', 'Widowmaker', 3120, 2100, 1520045, 0, 350, 150, 0)
INTO gg_player_hero VALUES ('Taimou', 'McCree', 2800, 950, 1000000, 0, 360, 230, 0)
INTO gg_player_hero VALUES ('HarryHook', 'Soldier: 76', 3000, 980, 102000, 5000, 400, 230, 0)
INTO gg_player_hero VALUES ('cocco', 'Winston', 2000, 1100, 90000, 0, 300, 200, 40000)
INTO gg_player_hero VALUES ('chipshajen', 'Ana', 1200, 800, 42000, 102000, 500, 200, 0)
INTO gg_player_hero VALUES ('INTERNETHULK', 'Lucio', 800, 700, 4000, 202000, 450, 100, 0)
INTO gg_player_hero VALUES ('Mickie', 'Widowmaker', 2500, 800, 200000, 0, 600, 400, 0)
INTO gg_player_hero VALUES ('aKm', 'Soldier: 76', 2650, 750, 950000, 3000, 360, 150, 0)
INTO gg_player_hero VALUES ('SoOn', 'Tracer', 2901, 600, 1001000, 0, 375, 300, 0)
INTO gg_player_hero VALUES ('winz', 'Bastion', 2200, 820, 80000, 0, 310, 150, 0)
INTO gg_player_hero VALUES ('NiCO', 'Sombra', 2025, 500, 50000, 42000, 325, 200, 0)
INTO gg_player_hero VALUES ('uNKOE', 'Ana', 1400, 1000, 8000, 108400, 275, 100, 0)
INTO gg_player_hero VALUES ('KnOxXx', 'Zarya', 2206, 950, 50000, 0, 340, 275, 86040)
INTO gg_player_hero VALUES ('iddqd', 'Tracer', 2855, 1000, 1000000, 0, 450, 220, 0)
INTO gg_player_hero VALUES ('dummy', 'Ana', 1105, 800, 8000, 100000, 450, 300, 0)
INTO gg_player_hero VALUES ('numlocked', 'Reinhardt', 1500, 1100, 8000, 0, 400, 300, 1640800)
INTO gg_player_hero VALUES ('Harbleu', 'Roadhog', 2950, 1200, 1008000, 0, 360, 222, 4500)
INTO gg_player_hero VALUES ('Ajax', 'Lucio', 900, 700, 8000, 202000, 450, 340, 0)
INTO gg_player_hero VALUES ('Seagull', 'Genji', 3050, 950, 1020000, 0, 500, 230, 0)
INTO gg_player_hero VALUES ('Hoodie', 'Roadhog', 1500, 1400, 8000, 0, 360, 330, 2310)
INTO gg_player_hero VALUES ('Nyaves', 'Zenyatta', 1000, 900, 4000, 500000, 440, 420, 0)
INTO gg_player_hero VALUES ('UnhappyMango', 'Symmetra', 750, 800, 1200, 0, 360, 360, 9400)
INTO gg_player_hero VALUES ('tictacz', 'Reaper', 1300, 1100, 9000, 0, 140, 75, 0)
INTO gg_player_hero VALUES ('BloodyMonday', 'Torbjorn', 600, 750, 9500, 0, 300, 400, 0)

INTO gg_player_hero VALUES ('Mendokusaii', 'Genji', 2900, 2000, 990045, 0, 320, 175, 0)
INTO gg_player_hero VALUES ('Frozen', 'Mei', 2200, 2000, 400045, 0, 320, 175, 0)
INTO gg_player_hero VALUES ('Kephrii', 'Sombra', 2250, 1100, 420045, 41600, 315, 115, 0)
INTO gg_player_hero VALUES ('Taimou', 'Widowmaker', 2850, 1100, 1005000, 0, 360, 180, 0)
INTO gg_player_hero VALUES ('HarryHook', 'Pharah', 2546, 500, 800000, 0, 400, 230, 0)
INTO gg_player_hero VALUES ('cocco', 'Zarya', 2400, 950, 750000, 0, 300, 215, 42300)
INTO gg_player_hero VALUES ('chipshajen', 'Symmetra', 2200, 450, 40000, 0, 250, 230, 8320)
INTO gg_player_hero VALUES ('INTERNETHULK','D.Va', 1400, 1100, 9500, 0, 150, 100, 120500)
INTO gg_player_hero VALUES ('Mickie', 'D.Va', 1500, 901, 10000, 0, 365, 225, 204310)
INTO gg_player_hero VALUES ('aKm', 'Reaper', 2800, 950, 1000500, 0, 420, 300, 0)
INTO gg_player_hero VALUES ('SoOn', 'Sombra', 2050, 400, 12000, 5000, 150, 75, 0)
INTO gg_player_hero VALUES ('winz', 'Mei',  1800, 1200, 11000, 0, 323, 300, 0)
INTO gg_player_hero VALUES ('NiCO', 'Bastion', 2800, 1400, 1000652, 0, 375, 250, 0)
INTO gg_player_hero VALUES ('uNKOE', 'Pharah', 2701, 1200, 900000, 0, 400, 230, 0)
INTO gg_player_hero VALUES ('KnOxXx', 'Soldier: 76', 3100, 800, 1040752, 6250, 315, 260, 0)
INTO gg_player_hero VALUES ('iddqd', 'McCree', 3200, 1000, 1282000, 0, 525, 150, 0)
INTO gg_player_hero VALUES ('dummy', 'Orisa', 750, 700, 5000, 0, 362, 275, 64000)
INTO gg_player_hero VALUES ('numlocked', 'Winston', 1200, 1000, 7000, 0, 300, 100, 24000)
INTO gg_player_hero VALUES ('Harbleu', 'Pharah', 1400, 950, 7500, 0, 220, 100, 0)
INTO gg_player_hero VALUES ('Ajax', 'Zenyatta', 600, 200, 1100, 46000, 323, 290, 0)
INTO gg_player_hero VALUES ('Seagull', 'Hanzo', 3000, 1300, 1010632, 0, 350, 200, 0)
INTO gg_player_hero VALUES ('Hoodie', 'Reinhardt', 1500, 1600, 8000, 0, 200, 230, 1130230)
INTO gg_player_hero VALUES ('Nyaves', 'Mercy', 400, 950, 2000, 10450, 200, 88, 0)
INTO gg_player_hero VALUES ('UnhappyMango', 'Mercy', 200, 400, 0, 10000, 300, 301, 0)
INTO gg_player_hero VALUES ('tictacz', 'Genji', 2800, 2700, 1004200, 0, 320, 60, 0)
INTO gg_player_hero VALUES ('BloodyMonday', 'Junkrat', 1300, 1400, 7200, 0, 200, 230, 0)
SELECT * FROM dual;

--VALUES(map_name, country, map_type, objective, team_size)
INSERT ALL
INTO gg_map VALUES('Hanamura', 'Japan', 'Capture Point', 'Capture more points on the map than the enemy team.', 6)
INTO gg_map VALUES('Temple of Anubis', 'Egypt', 'Capture Point', 'Capture more points on the map than the enemy team.', 6)
INTO gg_map VALUES('Volskya Industries', 'Russia', 'Capture Point', 'Capture more points on the map than the enemy team.', 6)
INTO gg_map VALUES('Dorado', 'Mexico', 'Escort', 'To deliver a payload further than the enemy team.', 6)
INTO gg_map VALUES('Route 66', 'USA', 'Escort', 'To deliver a payload further than the enemy team.', 6)
INTO gg_map VALUES('Watchpoint: Gibraltar', 'Gibraltar', 'Escort', 'To deliver a payload further than the enemy team.', 6)
INTO gg_map VALUES('Eichenwalde', 'Germany', 'Hybrid', 'To capture a point and also deliver a payload further than the enemy team', 6)
INTO gg_map VALUES('Hollywood', 'USA', 'Hybrid', 'To capture a point and also deliver a payload further than the enemy team', 6)
INTO gg_map VALUES('Kings Row', 'England', 'Hybrid', 'To capture a point and also deliver a payload further than the enemy team', 6)
INTO gg_map VALUES('Numbani', 'Africa', 'Hybrid', 'To capture a point and also deliver a payload further than the enemy team', 6)
INTO gg_map VALUES('Ilios', 'Greece', 'Control Point', 'To maintain control of multiple points while fending off the enemy team. Best of 3 or 5 wins', 6)
INTO gg_map VALUES('Lijang Tower', 'China', 'Control Point', 'To maintain control of multiple points while fending off the enemy team. Best of 3 or 5 wins', 6)
INTO gg_map VALUES('Nepal', 'Nepal', 'Control Point', 'To maintain control of multiple points while fending off the enemy team. Best of 3 or 5 wins', 6)
INTO gg_map VALUES('Oasis', 'Iraq', 'Control Point', 'To maintain control of multiple points while fending off the enemy team. Best of 3 or 5 wins', 6)
SELECT * FROM dual;

--VALUES(event_id, map_name)
INSERT ALL
INTO gg_event_map VALUES(100, 'Hanamura')
INTO gg_event_map VALUES(100, 'Dorado')
INTO gg_event_map VALUES(100, 'Hollywood')
INTO gg_event_map VALUES(100, 'Eichenwalde')
INTO gg_event_map VALUES(100, 'Ilios')

INTO gg_event_map VALUES(101, 'Hanamura')
INTO gg_event_map VALUES(101, 'Route 66')
INTO gg_event_map VALUES(101, 'Kings Row')
INTO gg_event_map VALUES(101, 'Numbani')
INTO gg_event_map VALUES(101, 'Lijang Tower')

INTO gg_event_map VALUES(102, 'Volskya Industries')
INTO gg_event_map VALUES(102, 'Watchpoint: Gibraltar')
INTO gg_event_map VALUES(102, 'Eichenwalde')
INTO gg_event_map VALUES(102, 'Hollywood')
INTO gg_event_map VALUES(102, 'Oasis')

INTO gg_event_map VALUES(103, 'Temple of Anubis')
INTO gg_event_map VALUES(103, 'Route 66')
INTO gg_event_map VALUES(103, 'Eichenwalde')
INTO gg_event_map VALUES(103, 'Numbani')
INTO gg_event_map VALUES(103, 'Lijang Tower')
SELECT * FROM dual;

--VALUES(rank_id, player_name, rank, timestamp(defaulted))
--initial creation of a player's current rank, updateRank in selectStatements folder
INSERT ALL
INTO gg_rank(rank_player, rank) VALUES ('Taimou', 4844)
INTO gg_rank(rank_player, rank) VALUES ('HarryHook', 4200)
INTO gg_rank(rank_player, rank) VALUES ('cocco', 4625)
INTO gg_rank(rank_player, rank) VALUES ('chipshajen', 4150)
INTO gg_rank(rank_player, rank) VALUES ('INTERNETHULK', 4845)
INTO gg_rank(rank_player, rank) VALUES ('Mickie', 4653)
INTO gg_rank(rank_player, rank) VALUES ('aKm', 3801)
INTO gg_rank(rank_player, rank) VALUES ('SoOn', 4260)
INTO gg_rank(rank_player, rank) VALUES ('winz', 3526)
INTO gg_rank(rank_player, rank) VALUES ('NiCO', 4444)
INTO gg_rank(rank_player, rank) VALUES ('uNKOE', 3240)
INTO gg_rank(rank_player, rank) VALUES ('KnOxXx', 3540)
INTO gg_rank(rank_player, rank) VALUES ('iddqd', 4756)
INTO gg_rank(rank_player, rank) VALUES ('dummy', 4103)
INTO gg_rank(rank_player, rank) VALUES ('numlocked', 4301)
INTO gg_rank(rank_player, rank) VALUES ('Harbleu', 4605)
INTO gg_rank(rank_player, rank) VALUES ('Ajax', 4102)
INTO gg_rank(rank_player, rank) VALUES ('Seagull', 4545)
INTO gg_rank(rank_player, rank) VALUES ('BloodyMonday', 2760)
INTO gg_rank(rank_player, rank) VALUES ('tictacz', 3050)
INTO gg_rank(rank_player, rank) VALUES ('UnhappyMango', 1800)
INTO gg_rank(rank_player, rank) VALUES ('Nyaves', 2345)
INTO gg_rank(rank_player, rank) VALUES ('Hoodie', 2432)
SELECT * FROM dual;

--historical data
--CURRENT_TIMESTAMP + interval '2' second is used only for the initial population due to timestamp being a part of the primary key
INSERT ALL
INTO gg_rank VALUES ('Taimou', 4899, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('HarryHook', 4333, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('cocco', 4680, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('chipshajen', 4200, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('INTERNETHULK', 4454, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('Mickie', 4601, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('aKm', 3500, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('SoOn', 4100, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('winz', 3468, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('NiCO', 4400, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('uNKOE', 3420, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('KnOxXx', 3700, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('iddqd', 4799, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('dummy', 4115, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('numlocked', 4250, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('Harbleu', 4888, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('Ajax', 4010, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('Seagull', 4444, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('BloodyMonday', 2501, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('tictacz', 3100, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('UnhappyMango', 1700, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('Nyaves', 2370, CURRENT_TIMESTAMP + interval '2' second, 0)
INTO gg_rank VALUES ('Hoodie', 2400, CURRENT_TIMESTAMP + interval '2' second, 0)
SELECT * FROM dual;

--historical data
INSERT ALL
INTO gg_rank VALUES ('Taimou', 4222, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('HarryHook', 4140, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('cocco', 4888, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('chipshajen', 4220, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('INTERNETHULK', 4640, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('Mickie', 4500, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('aKm', 3575, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('SoOn', 4243, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('winz', 3499, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('NiCO', 4491, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('uNKOE', 3466, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('KnOxXx', 3740, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('iddqd', 4800, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('dummy', 4125, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('numlocked', 4315, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('Harbleu', 4899, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('Ajax', 4011, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('Seagull', 4445, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('BloodyMonday', 2225, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('tictacz', 3115, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('UnhappyMango', 1750, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('Nyaves', 2323, CURRENT_TIMESTAMP + interval '3' second, 0)
INTO gg_rank VALUES ('Hoodie', 2305, CURRENT_TIMESTAMP + interval '3' second, 0)
SELECT * FROM dual;


