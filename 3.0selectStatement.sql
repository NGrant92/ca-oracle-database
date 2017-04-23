--gg_player_hero

SELECT username AS "Player", name AS "Hero", eliminations, deaths
 FROM gg_player_hero
 WHERE eliminations > deaths;

--gg_rank_hist
SELECT rank_player AS "Player", rank
 FROM gg_rank_hist
 WHERE rank_player = 'Hoodie'
 ORDER BY date_time DESC;
