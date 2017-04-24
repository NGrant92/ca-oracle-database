--gg_player_hero

SELECT username AS "Player", name AS "Hero", eliminations, deaths
 FROM gg_player_hero
 WHERE eliminations > deaths;

--gg_rank_hist
SELECT rank_player AS "Player", rank
 FROM gg_rank_hist
 WHERE rank_player = 'Hoodie'
 ORDER BY date_time DESC;

--gg_hero_stats

SELECT eliminations, SUM(CASE WHEN name = 'Genji' THEN eliminations ELSE 0 END) AS 'Hero'
 FROM gg_player_hero
 GROUP BY eliminations;

SELECT name AS "Hero", SUM(eliminations) AS "Elims", SUM(wins) AS "Wins", SUM(losses) AS "Losses", ROUND(((SUM(wins))/((SUM(losses))+(SUM(wins))*100) || '%' AS "Win %"
 FROM gg_player_hero
 WHERE name = 'Genji';

, SUM(wins) AS "Wins", SUM(losses) AS "Losses"

heroName VARCHAR2(30) := 'Genji'; 
DECLARE
elims NUMBER(8,0) := SUM(eliminations)

SELECT name AS "Hero", SUM(wins) AS "Wins", SUM(losses) AS "Losses", SUM(eliminations) AS "Elims", SUM(deaths) AS "Deaths"
 FROM gg_player_hero
 GROUP BY name
 ORDER BY "Wins" DESC;
