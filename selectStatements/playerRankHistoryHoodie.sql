--REFERENCE FOR TIMESTAMP EDIT: https://community.oracle.com/thread/2292704
SELECT rank_player AS "Player", rank AS "Rank", TO_CHAR (date_time, 'HH24:MI:SS dd-mm-yyyy') AS "Timestamp"
FROM gg_rank
WHERE rank_player = 'Hoodie'
ORDER BY date_time DESC;