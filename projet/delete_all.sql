\i delete_indexes.sql ;

DEALLOCATE pays1;
DEALLOCATE pays2;
DEALLOCATE pays3;
DEALLOCATE esp_vie;
DEALLOCATE nb_hab;
DEALLOCATE covid;
DEALLOCATE dc_depasser;
DEALLOCATE depasser;
DEALLOCATE dist_depasser;
DEALLOCATE resid_depasser;
DEALLOCATE dist_depasser_all;
DEALLOCATE resid_depasser_all;
DEALLOCATE dconf;
DEALLOCATE fconf;
DEALLOCATE masque;
DEALLOCATE sans_masque;
DEALLOCATE respecte;
DEALLOCATE tt_respecte;
DEALLOCATE rd_respecte;
DEALLOCATE tr_respecte;
DEALLOCATE evolution_cas;
DEALLOCATE evolution_deces;
DEALLOCATE evolution_hosp;
DEALLOCATE evolution_rea;
DEALLOCATE nb_total;
DEALLOCATE dc_total;
DEALLOCATE hosp_total;
DEALLOCATE rea_total;
DEALLOCATE cum_stats;
DEALLOCATE cum_stats_pays;
DEALLOCATE jamais_masque;
DEALLOCATE jamais_conf;
DEALLOCATE jamais_ferme_ecole;
DEALLOCATE top_strict;
DEALLOCATE top_cas;
DEALLOCATE top_deces;
DEALLOCATE mesure_max_strict;
DEALLOCATE conf_max;
DEALLOCATE masque_max;
DEALLOCATE cum_stats_limit;

DROP TRIGGER IF EXISTS Mesures_distanciations_notification_trigger on Mesures_distanciations;
DROP FUNCTION IF EXISTS Mesures_distanciations_notification() ;

DROP TRIGGER IF EXISTS lieux_visites_notification_trigger on Statistiques_lieux_visites;
DROP FUNCTION IF EXISTS lieux_visites_notification() ;


DROP TRIGGER IF EXISTS covid_notification_trigger on Statistiques_covid;
DROP FUNCTION IF EXISTS covid_notification() ;

DROP TRIGGER IF EXISTS AAA_Mesures_economiques_Pays_trigger on Mesures_economiques;
DROP FUNCTION IF EXISTS pib_update() ;

DROP TRIGGER IF EXISTS AAA_Statistiques_lieux_visites_Pays_trigger on Statistiques_lieux_visites;
DROP FUNCTION IF EXISTS e_vie_update() ;

DROP TRIGGER IF EXISTS AAA_Hopitaux_Pays_trigger on Hopitaux;
DROP FUNCTION IF EXISTS lits_update() ;

DROP TRIGGER IF EXISTS AAA_deces_hab_trigger on Population;
DROP FUNCTION IF EXISTS deces_constraint() ;

DROP TRIGGER IF EXISTS AAA_cas_hab_trigger on Statistiques_covid;
DROP FUNCTION IF EXISTS cas_constraint() ;

DROP TRIGGER IF EXISTS AAB_Covid_Pays_trigger on Statistiques_covid;
DROP FUNCTION IF EXISTS hab_deces_covid_update() ;

DROP TRIGGER IF EXISTS AAB_Population_Pays_trigger on Population;
DROP FUNCTION IF EXISTS hab_population_update() ;

DROP TABLE IF EXISTS Hopitaux CASCADE ;
DROP TABLE IF EXISTS Mesures_economiques CASCADE;
DROP TABLE IF EXISTS Mesures_sanitaires CASCADE;
DROP TABLE IF EXISTS Mesures_distanciations CASCADE;
DROP TABLE IF EXISTS Statistiques_lieux_visites CASCADE;
DROP TABLE IF EXISTS Statistiques_covid CASCADE;
DROP TABLE IF EXISTS Population CASCADE;
DROP TABLE IF EXISTS Pays CASCADE;
DROP TABLE IF EXISTS Continent CASCADE ;
