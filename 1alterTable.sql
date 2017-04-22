ALTER TABLE gg_player
ADD CONSTRAINT plr_tm_fk FOREIGN KEY (team_id) REFERENCES gg_team(team_name) ON DELETE SET NULL;

ALTER TABLE gg_player_hero
ADD CONSTRAINT plr_hr_hr_stat_fk FOREIGN KEY (hero_stats_id) REFERENCES gg_hero_stats(stats_id);

ALTER TABLE gg_team
ADD CONSTRAINT tm_evnt_id_fk FOREIGN KEY (event_id) REFERENCES gg_event(event_id);

ALTER TABLE gg_team_history
ADD CONSTRAINT tm_hist_usnm_fk FOREIGN KEY (username) REFERENCES gg_player(username) ON DELETE CASCADE;

ALTER TABLE gg_team_history
ADD CONSTRAINT tm_hist_nm_fk FOREIGN KEY (team_name) REFERENCES gg_team(team_name);

ALTER TABLE gg_player_hero
ADD CONSTRAINT plr_hr_usnm_fk FOREIGN KEY (username) REFERENCES gg_player(username) ON DELETE CASCADE;

ALTER TABLE gg_player_hero
ADD CONSTRAINT plr_hr_nm_fk FOREIGN KEY (name) REFERENCES gg_hero(name) ON DELETE CASCADE;

ALTER TABLE gg_hero_stats
ADD CONSTRAINT hr_stat_nm_fk FOREIGN KEY (name) REFERENCES gg_hero(name) ON DELETE CASCADE;

ALTER TABLE gg_event_map
ADD CONSTRAINT evnt_mp_evnt_id_fk FOREIGN KEY (event_id) REFERENCES gg_event(event_id);

ALTER TABLE gg_event_map
ADD CONSTRAINT evnt_mp_mp_nm_fk FOREIGN KEY (map_name) REFERENCES gg_map(name);

ALTER TABLE gg_rank
ADD CONSTRAINT rnk_plr_nm_fk FOREIGN KEY (rank_player) REFERENCES gg_player(username) ON DELETE CASCADE;

ALTER TABLE gg_rank_history
ADD CONSTRAINT rnk_his_plr_nm_fk FOREIGN KEY (rank_player) REFERENCES gg_player(username) ON DELETE CASCADE;