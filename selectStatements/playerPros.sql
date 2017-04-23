SELECT username AS "Pro Players", team_id AS "Team", p_twitter AS "Player Twitter", gg_rank.rank AS "Current Rank"
 FROM gg_player, gg_rank
 WHERE team_id IS NOT NULL AND rank_player = username AND is_current = 1
 ORDER BY team_id;