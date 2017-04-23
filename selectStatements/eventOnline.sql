SELECT event_name AS "Online Event", server_region AS "Server", event_date AS "Starting Date" , '1st: '|| first_prize || '  2nd: ' || second_prize || '  3rd: ' || third_prize AS "Prizes"
 FROM gg_event
 WHERE event_type = 'Online';
