SELECT gg_player_hero.username AS "Player", gg_player_hero.name AS "Hero", gg_hero.role AS "Hero Role", gg_player_hero.eliminations AS "Elims", gg_player_hero.deaths AS "Deaths", gg_player_hero.wins AS "Wins", gg_player_hero.losses AS "Losses", ROUND((gg_player_hero.wins/(gg_player_hero.losses+gg_player_hero.wins))*100) || '%' AS "Win %"
 FROM gg_player_hero, gg_hero
 WHERE username = 'Hoodie' AND gg_player_hero.name = gg_hero.name
 ORDER BY wins DESC;