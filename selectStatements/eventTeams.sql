SELECT gg_event_team.team_name || ' is attending ' || gg_event.event_name AS "Competing Pro Teams", gg_event.event_date AS "Date" 
 FROM gg_event_team, gg_event
 WHERE gg_event_team.event_id = gg_event.event_id
 ORDER BY gg_event.event_date;