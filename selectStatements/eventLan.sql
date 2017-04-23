SELECT event_name AS "Lan Event", event_date AS "Starting Date", '1st: '|| first_prize || '  2nd: ' || second_prize || '  3rd: ' || third_prize AS "Prizes", venue || ', ' || county || ', ' || country AS "Location"
 FROM gg_event
 WHERE event_type = 'Lan';