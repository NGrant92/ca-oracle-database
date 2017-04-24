DECLARE
playerName VARCHAR2(25) := 'Hoodie';
playerHero VARCHAR2(30) := 'Roadhog';

BEGIN
UPDATE gg_player_hero
 SET losses = losses + 1
 WHERE username = playerName AND name = playerHero;
END;