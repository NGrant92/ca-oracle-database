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
	t_website	 VARCHAR2(60) CONSTRAINT tm_tm_web_uk UNIQUE,
	event_id	 NUMBER(4,0)
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
	hero_stats_id NUMBER(3,0) NOT NULL,
	damage_blocked NUMBER(10, 0) DEFAULT 0,
	
	CONSTRAINT plr_hr_usnm_nm_pk PRIMARY KEY (username, name)
);

CREATE TABLE gg_hero_stats
(
	stats_id NUMBER(3,0) CONSTRAINT hr_stat_id_pk PRIMARY KEY,
	name	 VARCHAR2(15)
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
--AUTO_INCREMENT

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
	rank_player VARCHAR2(25) NOT NULL rnk_plr_pk PRIMARY KEY,
	rank NUMBER(4,0) NOT NULL,
	date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT rnk_chk CHECK(rank < 5001)
);

--is_current NUMBER(1,0) NOT NULL CONSTRAINT rnk_curr_chk CHECK(is_current = 0 OR is_current = 1)

CREATE TABLE gg_rank_history
(
	rank_player VARCHAR2(25),
	rank NUMBER(4,0) NOT NULL,
	date_time TIMESTAMP,

	CONSTRAINT rnk_plr_dt_pk PRIMARY KEY(rank_player, date_time)
	CONSTRAINT rnk_his_rnk_chk CHECK(rank < 5001)
);