SELECT gg_event.event_name AS "Event", gg_event_map.map_name AS "Allowed Maps", gg_event.event_date AS "Date"
 FROM gg_event_map, gg_event
 WHERE gg_event_map.event_id = gg_event.event_id;