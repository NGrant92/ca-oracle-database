--REFERENCE: http://www.oracle.com/technetwork/issue-archive/2013/13-jan/o13sql-1886636.html
SELECT name AS "Hero", SUM(wins) AS "Wins", SUM(losses) AS "Losses", SUM(eliminations) AS "Elims", SUM(deaths) AS "Deaths", SUM(damage) AS "Damage", SUM(damage_blocked) AS "Damage Blocked", SUM(healing) AS "Healing"
 FROM gg_player_hero
 GROUP BY name
 ORDER BY "Wins" DESC;