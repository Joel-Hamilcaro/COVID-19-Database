--
CREATE INDEX i_masque ON Mesures_sanitaires USING BTREE (masque);
--
CREATE INDEX i_conf ON Mesures_distanciations USING BTREE (conf);
CREATE INDEX i_teletra ON Mesures_distanciations USING BTREE (teletra);
--
CREATE INDEX i_resid ON Statistiques_lieux_visites USING BTREE (resid);
CREATE INDEX i_trav ON Statistiques_lieux_visites USING BTREE (travail);
CREATE INDEX i_dist ON Statistiques_lieux_visites USING BTREE (dist);
--
CREATE INDEX i_cas ON Statistiques_covid USING BTREE (cas);
CREATE INDEX i_deces ON Statistiques_covid USING BTREE (deces);
