--gg_hero
SELECT *
 FROM gg_player_hero
 WHERE role = 'Tank';

SELECT name AS "Hero", ability_ult1 AS "Ultimate 1", ability_ult2 AS "Ultimate 2"
 FROM gg_player_hero
 WHERE ability_ult2 IS NOT NULL;

SELECT name AS "Hero", ability_passive AS "Passive Ability"
 FROM gg_player_hero
 WHERE ability_passive IS NOT NULL;


--gg_player_hero
SELECT username AS "Player", name AS "Hero", ROUND((wins/(losses+wins))*100) || '%' AS "Win %"
 FROM gg_player_hero
 ORDER BY wins/(losses+wins))*100 DESC;

SELECT username AS "Player", name AS "Hero", eliminations, deaths
 FROM gg_player_hero
 WHERE eliminations > deaths;

SELECT username AS "Player", name AS "Hero", eliminations AS "Elims", deaths, wins, losses
 FROM gg_player_hero
 ORDER BY wins DESC;


--gg_player
SELECT username AS "Player", team_id AS "Team"
 FROM gg_player
 WHERE team_id = 'NRG';

SELECT username AS "Player", team_id AS "Team"
 FROM gg_player
 WHERE team_id IS NOT NULL;

SELECT username || ' ' || p_twitter AS "Team EnVyus Twitter Profiles", gg_team
 FROM gg_player
 WHERE team_id = 'EnVyus'
 CROSS JOIN gg_team;

SELECT username || ' ' || p_twitch AS "Pro Twitch Streamers"
 FROM gg_player
 WHERE team_id IS NOT NULL AND p_twitch IS NOT NULL;


--gg_rank
SELECT rank_player AS "Player", rank
 FROM gg_rank
 ORDER BY rank DESC;

SELECT rank_player AS "GrandMaster Players", rank
 FROM gg_rank
 WHERE rank >= 4000;
 ORDER BY rank DESC;


--gg_rank_hist
SELECT rank_player AS "Player", rank
 FROM gg_rank_hist
 WHERE rank_player = 'Hoodie'
 ORDER BY date_time DESC;


--gg_team
SELECT team_name AS "Team", gg_player.username, t_website AS "Website"
 FROM gg_team, gg_player
 WHERE t_website IS NOT NULL AND gg_player.team_id = gg_team.team_name
 ORDER BY team_name DESC;


--gg_map
SELECT name AS "Map", location AS "Location", map_type AS "Type", obejctive AS "Objective"
 FROM gg_map
 WHERE map_type = "Escort"


--gg_event
SELECT event_name AS "Lan Event", event_date AS "Starting Date" ,venue || ', ' || county || ', ' || country AS "Location"
 FROM gg_event
 WHERE event_type = 'Lan';

SELECT event_name AS "Online Event", server_region AS "Server", event_date AS "Starting Date" , '1st: '|| first_prize || ' 2nd: ' || second_prize || ' 3rd: ' || third_prize AS "Prizes"
 FROM gg_event
 WHERE event_type = 'Online';

--gg_event_map
SELECT map_name AS "Map", event_name
 FROM gg_event_map;

--player + team
SELECT gg_player.username, gg_team.team_name, gg_team.t_website, gg_team.t_twitter
 FROM gg_player
 CROSS JOIN gg_team
 WHERE gg_player.team_id = gg_team.team_name
 ORDER BY gg_team.team_name;
