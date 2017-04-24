SELECT name AS "Hero", SUM(wins) AS "Wins", SUM(losses) AS "Losses", SUM(eliminations) AS "Elims", SUM(deaths) AS "Deaths"
 FROM gg_player_hero
 GROUP BY name
 ORDER BY "Wins" DESC;