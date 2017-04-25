 SELECT event_name AS "Event", event_date AS "Starting Date", event_type AS "Event Type", '1st: '|| first_prize || ' 2nd: ' || second_prize || ' 3rd: ' || third_prize AS "Prizes", event_website AS "Website"
  FROM gg_event
  ORDER BY event_date;