--due to gg_rank_history's primary keys set to username and timestamp, this will prevent duplication
CREATE TABLE gg_rank_history
AS(SELECT * FROM gg_rank);

--once the current rank is copied to gg_rank_history then player's current rank is updated
--player's current rank is updated individually due to rank being unique to the player
UPDATE gg_rank
SET rank = 4800
WHERE rank_player = 'Taimou';

UPDATE gg_rank
SET rank = 4150
WHERE rank_player = 'HarryHook';

UPDATE gg_rank
SET rank = 4444
WHERE rank_player = 'cocco';

UPDATE gg_rank
SET rank = 4000
WHERE rank_player = 'chipshajen';

UPDATE gg_rank
SET rank = 4900
WHERE rank_player = 'INTERNETHULK';

UPDATE gg_rank
SET rank = 4675
WHERE rank_player = 'Mickie';

UPDATE gg_rank
SET rank = 4675
WHERE rank_player = 'BloodyMonday';

UPDATE gg_rank
SET rank = 3105
WHERE rank_player = 'tictacz';

UPDATE gg_rank
SET rank = 1999
WHERE rank_player = 'UnhappyMango';

UPDATE gg_rank
SET rank = 2375
WHERE rank_player = 'Nyaves';

UPDATE gg_rank
SET rank = 2499
WHERE rank_player = 'Hoodie';