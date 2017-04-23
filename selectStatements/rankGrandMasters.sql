SELECT rank_player AS "GrandMaster Players", rank AS "Rank"
 FROM gg_rank
 WHERE rank >= 4000 AND is_current = 1
 ORDER BY rank DESC;