SELECT gg_team.team_name || ' is attending ' || gg_event.event_name AS "Competing Pro Teams", gg_event.event_date AS "Date" 
 FROM gg_team, gg_event
 WHERE gg_team.event_id = gg_event.event_id
 ORDER BY gg_event.event_date;