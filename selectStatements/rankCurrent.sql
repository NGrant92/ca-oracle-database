SELECT rank_player AS "Player", rank AS "Rank"
 FROM gg_rank
 WHERE is_current = 1
 ORDER BY rank DESC;