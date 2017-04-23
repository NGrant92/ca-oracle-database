SELECT name AS "Hero", ability_passive AS "Passive Ability"
 FROM gg_hero
 WHERE ability_passive IS NOT NULL;