SELECT gg_player.username, gg_team.team_name, gg_team.t_website, gg_team.t_twitter
 FROM gg_player, gg_team
 WHERE gg_player.team_id = gg_team.team_name
 ORDER BY gg_team.team_name;