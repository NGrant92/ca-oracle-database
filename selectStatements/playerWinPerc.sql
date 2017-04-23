SELECT username AS "Player", name AS "Hero", ROUND((wins/(losses+wins))*100) || '%' AS "Win %"
 FROM gg_player_hero
 ORDER BY "Win %" DESC;