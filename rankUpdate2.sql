DECLARE 
rankUpdate NUMBER(4,0) := 4901;
player VARCHAR2(25) := 'Taimou';

BEGIN
	IF(gg_rank.rank_player = player AND gg_rank.is_current = 1) THEN
		UPDATE gg_rank
		SET is_current = 0
		WHERE rank_player = player AND is_current = 1;

		INSERT INTO gg_rank(rank_player, rank) VALUES (player, rankUpdate);
	END IF;
END;

	UPDATE gg_rank
	SET is_current = 0
	WHERE rank_player = player AND is_current = 1 AND rank != rankUpdate;
	AND gg_rank.rank != rankUpdate