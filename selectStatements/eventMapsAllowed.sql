SELECT gg_event.event_name AS "Event", gg_event_map.map_name AS "Allowed Maps", gg_event.event_date AS "Date"
 FROM gg_event_map, gg_event;