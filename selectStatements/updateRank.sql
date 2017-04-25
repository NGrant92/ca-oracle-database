--a method to streamline the update rank process
--if their current rank is equal to the updating rank then
--nothing will happen, this prevents duplication
--REFERENCE: https://community.oracle.com/thread/321710
DECLARE 
rankUpdate NUMBER(4,0) := 4901;
player VARCHAR2(25) := 'Taimou';

cnt NUMBER(1,0);

BEGIN
SELECT COUNT(*)
	INTO cnt
	FROM gg_rank
	WHERE rank_player = player AND is_current = 1 AND rank != rankUpdate;

	IF(cnt = 1) THEN
		UPDATE gg_rank
		SET is_current = 0
		WHERE gg_rank.rank_player = player AND gg_rank.is_current = 1;

		INSERT INTO gg_rank(rank_player, rank) VALUES (player, rankUpdate);
	ELSE
		NULL;
	END IF;
END;
