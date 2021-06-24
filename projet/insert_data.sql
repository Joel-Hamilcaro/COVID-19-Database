\COPY Continent (code,nom) FROM 'data/continent.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Pays (iso,nom,code,hab,surface,age_md,pl65,pl70,pib,pv_ex,pr_diab,fumeurs,l_mains,lits,e_vie,idh,m_card) FROM 'data/pays.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Population (iso,date,deces,naiss) FROM 'data/population.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Statistiques_covid (date,iso,cas,deces,r0,rea,hosp,tests,vacc) FROM 'data/stat_covid.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Statistiques_lieux_visites (iso,date,dist,achat,parc,transp,travail,resid) FROM 'data/stat_lieux.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Mesures_distanciations (iso,date,ecole,teletra,evt_pub,rassem,traffic,conf,dpl_reg,dpl_int) FROM 'data/distanciation.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Mesures_sanitaires(iso,date,info,pol_test,trace,masque,pol_vacc,pro_ages) FROM 'data/sanitaire.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Mesures_economiques(iso,date,aides_mng,alle_mng,inv_rel,aides_int,inv_sante,inv_vacc) FROM 'data/eco.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;
\COPY Hopitaux (nom,iso,lits) FROM 'data/hopitaux.csv' WITH (FORMAT csv, NULL '', DELIMITER ';', HEADER 1) ;

\! echo "\n"
\! echo "Table Continent \n"
\! echo "-----------------\n"

SELECT * FROM Continent;

\! echo "\n"
\! echo "Table Pays \n"
\! echo "-----------------\n"

SELECT iso,nom,code,hab,surface,age_md,pl65,pl70,pib FROM Pays ORDER BY RANDOM() LIMIT 5;
SELECT pv_ex,pr_diab,fumeurs,l_mains,lits,e_vie,idh,m_card FROM Pays ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Population \n"
\! echo "-----------------\n"

SELECT * FROM Population   ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Statistiques_covid \n"
\! echo "-----------------\n"

SELECT * FROM Statistiques_covid   ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Statistiques_lieux_visites \n"
\! echo "-----------------\n"

SELECT * FROM Statistiques_lieux_visites   ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Mesures_distanciations \n"
\! echo "-----------------\n"

SELECT * FROM Mesures_distanciations   ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Mesures_sanitaires \n"
\! echo "-----------------\n"

SELECT * FROM Mesures_sanitaires   ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Mesures_economiques \n"
\! echo "-----------------\n"

SELECT * FROM Mesures_economiques   ORDER BY RANDOM() LIMIT 5;

\! echo "\n"
\! echo "Table Hopitaux \n"
\! echo "-----------------\n"

SELECT * FROM Hopitaux   ORDER BY RANDOM() LIMIT 5;

--\i delete_all.sql
