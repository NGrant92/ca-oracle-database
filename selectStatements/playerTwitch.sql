SELECT username AS "Twitch Streams", p_twitch AS "Twitch Link", gg_rank.rank AS "Rank"
 FROM gg_player, gg_rank
 WHERE p_twitch IS NOT NULL;