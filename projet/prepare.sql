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

-- PAYS
PREPARE pays1(text) AS
  SELECT iso,code,nom,hab,pl70,pl65,age_md FROM Pays WHERE iso=$1;

PREPARE pays2(text) AS
  SELECT iso,surface,pv_ex,idh,pib FROM Pays WHERE iso=$1;

PREPARE pays3(text) AS
  SELECT iso,e_vie,l_mains,fumeurs,pr_diab,lits,m_card FROM Pays WHERE iso=$1;

PREPARE esp_vie AS
  SELECT iso, e_vie FROM Pays WHERE e_vie IS NOT NULL ORDER BY e_vie DESC ;

-- nombre d'habitants pour un pays à une date donnée

PREPARE nb_hab (CHAR(3),DATE) AS
  SELECT hab+(
    SELECT sum(deces)+(
      SELECT sum(deces)-(
        SELECT sum(naiss) as naiss FROM Population WHERE iso = $1 and date > $2
      ) as deces FROM Statistiques_covid WHERE iso = $1 and date > $2
    ) as deces FROM Population WHERE iso = $1 and date > $2
  ) as nb_hab FROM pays WHERE iso = $1;

-- execute nb_hab('FRA','2020-05-01');

-- Statistiques covid pour un pays dans une date
PREPARE covid ( CHAR(3), DATE ) AS
  SELECT * FROM Statistiques_covid WHERE date = $2 AND iso = $1;

-- execute covid ('FRA',2020-05-14');

-- les dates où le nombre de cas passe certain nombre pour un pays.
PREPARE depasser (CHAR(3),INT) AS
  SELECT date,cas FROM Statistiques_covid WHERE iso = $1 AND cas >= $2;

-- execute depasser ('FRA', 100000);

PREPARE dc_depasser (CHAR(3),INT) AS
  SELECT date,deces FROM Statistiques_covid WHERE iso = $1 AND deces >= $2;


-- les dates où la frequentation de lieux visité dépasse un certain nombre pour un pays.
PREPARE dist_depasser (CHAR(3),INT) AS
  SELECT date,dist FROM Statistiques_lieux_visites WHERE iso = $1 AND dist >= $2;

PREPARE resid_depasser (CHAR(3),INT) AS
  SELECT date,resid FROM Statistiques_lieux_visites WHERE iso = $1 AND resid >= $2;

-- la meme pour tous les pays
PREPARE dist_depasser_all (INT) AS
    SELECT iso,date,dist FROM Statistiques_lieux_visites WHERE dist >= $1;

PREPARE resid_depasser_all (INT) AS
    SELECT iso,date,resid FROM Statistiques_lieux_visites WHERE resid >= $1;

-- execute depasser ('FRA', 1000);

-- les dates de debut de mesures distanciations pour un pays (ex. debut de confinement, couvre-feu)
PREPARE dconf (CHAR(3),INT) AS
  SELECT date as debut,conf FROM Mesures_distanciations WHERE iso = $1 and conf = $2 AND
  (date-1) NOT IN (SELECT date FROM Mesures_distanciations WHERE iso = $1 and conf = $2);
--execute dconf ('FRA', 1);
--execute dconf ('FRA', 3);

PREPARE fconf (CHAR(3),INT) AS
  SELECT date as fin,conf FROM Mesures_distanciations WHERE iso = $1 and conf = $2 AND
  (date+1) NOT IN (SELECT date FROM Mesures_distanciations WHERE iso = $1 and conf = $2) AND
  (date+1) IN (SELECT date FROM Mesures_distanciations WHERE iso = $1);

--execute fconf ('FRA', 1);
--execute fconf ('FRA', 3);

-- afficher, pour chaque pays, l’évolution épidémique avant et après
-- la mise en place du port du masque.
PREPARE sans_masque (CHAR(3)) AS
SELECT iso,date,cas,deces,rea,hosp,r0  FROM Statistiques_covid  WHERE iso =$1
AND date IN (SELECT date FROM Mesures_sanitaires WHERE iso=$1 AND (masque=0 OR masque IS NULL) ) ORDER BY date;

PREPARE masque (CHAR(3)) AS
  SELECT iso,date,cas,deces,rea,hosp,r0 FROM Statistiques_covid  WHERE iso =$1
  AND date IN (SELECT date FROM Mesures_sanitaires WHERE iso=$1 AND masque=4 ) ORDER BY date;

-- execute sans_masque('USA')
-- execute masque ('USA');

-- observer, pour chaque pays, si la population respecte les mesures de confinement.

PREPARE respecte AS
SELECT DISTINCT slv.iso FROM Statistiques_lieux_visites as slv , Mesures_distanciations as md
WHERE
slv.travail>0 AND md.teletra>0
AND (slv.resid<0 AND slv.dist >0) AND md.conf>0
AND slv.transp>0 AND md.traffic>0
AND slv.date=md.date AND slv.iso= md.iso
ORDER BY iso;

-- execute respecte

PREPARE tt_respecte AS
SELECT DISTINCT slv.iso,ROUND(CAST(AVG(slv.travail) as numeric),2)as frequentation_lieux_travail,ROUND(CAST(AVG(md.teletra) as numeric),2) as teletravail
FROM Statistiques_lieux_visites as slv , Mesures_distanciations as md
WHERE
slv.travail>0 AND md.teletra>0
AND slv.date=md.date AND slv.iso= md.iso
GROUP BY slv.iso
ORDER BY iso;

PREPARE rd_respecte AS
SELECT DISTINCT slv.iso,ROUND(CAST(AVG(slv.resid) as numeric),2) as frequentation_residences,ROUND(CAST(AVG(slv.dist) as numeric),2) as frequentation_distractions,ROUND(CAST(AVG(md.conf) as numeric),2) as confinement
FROM Statistiques_lieux_visites as slv , Mesures_distanciations as md
WHERE
slv.resid<0 AND slv.dist>0 and md.conf>0
AND slv.date=md.date AND slv.iso= md.iso
GROUP BY slv.iso
ORDER BY iso;

PREPARE tr_respecte AS
SELECT DISTINCT slv.iso,ROUND(CAST(AVG(slv.transp) as numeric),2) as frequentation_transports,ROUND(CAST(AVG(md.traffic) as numeric),2) as reduction_traffic
FROM Statistiques_lieux_visites as slv , Mesures_distanciations as md
WHERE
slv.transp>0 AND md.traffic>0 and md.conf>0
AND slv.date=md.date AND slv.iso= md.iso
GROUP BY slv.iso
ORDER BY iso;

-- difference du nombre de cas,deces,hosp,rea entre deux jours

PREPARE evolution_cas(CHAR(3),DATE,DATE) AS
SELECT iso,
 (  (
   SELECT cas FROM Statistiques_covid WHERE iso=$1 and date=$2
 ) - cas ) as difference_cas FROM Statistiques_covid WHERE iso=$1 and date=$3;


 PREPARE evolution_deces(CHAR(3),DATE,DATE) AS
 SELECT iso,
  (  (
    SELECT deces FROM Statistiques_covid WHERE iso=$1 and date=$2
  ) - deces ) as difference_deces FROM Statistiques_covid WHERE iso=$1 and date=$3;


  PREPARE evolution_hosp(CHAR(3),DATE,DATE) AS
  SELECT iso,
   (  (
     SELECT hosp FROM Statistiques_covid WHERE iso=$1 and date=$2
   ) - hosp ) as difference_hosp FROM Statistiques_covid WHERE iso=$1 and date=$3;


   PREPARE evolution_rea(CHAR(3),DATE,DATE) AS
   SELECT iso,
    (  (
      SELECT rea FROM Statistiques_covid WHERE iso=$1 and date=$2
    ) - rea ) as difference_hosp FROM Statistiques_covid WHERE iso=$1 and date=$3;


  -- nb cas total entre deux dates

PREPARE nb_total(CHAR(3),DATE,DATE) AS
  SELECT iso, SUM(cas) as nb_cas_total FROM Statistiques_covid WHERE iso=$1 AND
  date>=$2 and date<=$3 GROUP BY iso;

  -- nb deces total entre deux dates

PREPARE dc_total(CHAR(3),DATE,DATE) AS
  SELECT iso, SUM(deces) as deces_total FROM Statistiques_covid WHERE iso=$1 AND
  date>=$2 and date<=$3 GROUP BY iso;

  -- nb hosp total entre deux dates

  PREPARE hosp_total(CHAR(3),DATE,DATE) AS
    SELECT iso, SUM(hosp) as hosp_total FROM Statistiques_covid WHERE iso=$1 AND
    date>=$2 and date<=$3 GROUP BY iso;



-- nb rea total entre deux dates

PREPARE rea_total(CHAR(3),DATE,DATE) AS
  SELECT iso, SUM(rea) as rea_total FROM Statistiques_covid WHERE iso=$1 AND
  date>=$2 and date<=$3 GROUP BY iso;

-- nb cas cumulées

PREPARE cum_stats AS
  SELECT iso, date, sum(cas) OVER (ORDER BY iso,date) as cum_cas,
  sum(deces) OVER (ORDER BY iso,date) as cum_deces,
  sum(rea) OVER (ORDER BY iso,date) as cum_rea,
  sum(hosp) OVER (ORDER BY iso,date) as cum_hosp,
  sum(tests) OVER (ORDER BY iso,date) as cum_tests,
  sum(vacc) OVER (ORDER BY iso,date) as cum_vacc
  FROM Statistiques_covid;

PREPARE cum_stats_pays(CHAR(3)) AS
  SELECT iso, date, cas, sum(cas) OVER (ORDER BY iso,date) as cum_cas,
  sum(deces) OVER (ORDER BY iso,date) as cum_deces,
  sum(rea) OVER (ORDER BY iso,date) as cum_rea,
  sum(hosp) OVER (ORDER BY iso,date) as cum_hosp,
  sum(tests) OVER (ORDER BY iso,date) as cum_tests,
  sum(vacc) OVER (ORDER BY iso,date) as cum_vacc
  FROM Statistiques_covid
  WHERE iso=$1;

PREPARE cum_stats_limit(CHAR(3),INT) AS
  SELECT iso, date, cas, sum(cas) OVER (ORDER BY iso,date) as cum_cas,
  sum(deces) OVER (ORDER BY iso,date) as cum_deces,
  sum(rea) OVER (ORDER BY iso,date) as cum_rea,
  sum(hosp) OVER (ORDER BY iso,date) as cum_hosp,
  sum(tests) OVER (ORDER BY iso,date) as cum_tests,
  sum(vacc) OVER (ORDER BY iso,date) as cum_vacc
  FROM Statistiques_covid
  WHERE iso=$1 LIMIT $2;

-- négation (pays qui n'ont jamais ferme les ecoles, jamais masques... ect)

PREPARE jamais_masque AS
  SELECT DISTINCT nom FROM Mesures_sanitaires NATURAL JOIN Pays WHERE iso NOT IN
    ( SELECT DISTINCT iso FROM Mesures_sanitaires WHERE masque >= 1);

PREPARE jamais_conf AS
  SELECT DISTINCT nom FROM Mesures_distanciations NATURAL JOIN Pays WHERE iso NOT IN
    ( SELECT DISTINCT iso FROM Mesures_distanciations WHERE conf >= 1);

PREPARE jamais_ferme_ecole AS
  SELECT DISTINCT nom FROM Mesures_distanciations NATURAL JOIN Pays WHERE iso NOT IN
    ( SELECT DISTINCT iso FROM Mesures_distanciations WHERE ecole >= 1);

-- top pays les plus stricts

PREPARE top_strict(INT) AS
  WITH tmp as
  (SELECT md.iso, AVG( (conf+ecole+traffic+teletra+rassem+evt_pub+dpl_reg+dpl_int+info+pol_test+trace+masque+pol_vacc+pro_ages)/14.0 ) AS coeff_strict
  FROM Mesures_distanciations as md
  JOIN Mesures_sanitaires as ms ON md.iso=ms.iso
  GROUP BY (md.iso) )
  SELECT DISTINCT count(*) OVER (ORDER BY coeff_strict DESC) as top,nom,coeff_strict
  FROM tmp NATURAL JOIN Pays
  WHERE coeff_strict IS NOT NULL
  ORDER BY coeff_strict DESC
  LIMIT $1
;

-- top pays le plus de cas (ratio)

PREPARE top_cas(INT,DATE,DATE) AS
  WITH tmp2 AS (
      WITH tmp AS (
        SELECT * FROM Statistiques_covid WHERE date >=$2 and date <=$3
      )
      SELECT tmp.iso, SUM( ( (cas+(0.0))/(
       (SELECT hab+(
         SELECT sum(deces)+(
           SELECT sum(deces)-(
             SELECT sum(naiss) as naiss FROM Population WHERE iso = tmp.iso and date > $3
           ) as deces FROM Statistiques_covid WHERE iso = tmp.iso and date >$3
         ) as deces FROM Population WHERE iso = tmp.iso and date > $3
       ) FROM pays WHERE iso = tmp.iso)
        +0.0)) ) AS ratio_cas
      FROM tmp NATURAL JOIN Pays
      GROUP BY tmp.iso )
  SELECT DISTINCT count(*) OVER (ORDER BY ratio_cas DESC) as top,nom,ratio_cas
  FROM tmp2 NATURAL JOIN Pays
  WHERE ratio_cas IS NOT NULL
  ORDER BY ratio_cas DESC
  LIMIT $1
  ;
  -- EXECUTE top_cas(180,'2020-01-01','2021-01-01') ;

-- top pays le plus de deces (ratio)

PREPARE top_deces(INT,DATE,DATE) AS
  WITH tmp2 AS (
      WITH tmp AS (
        SELECT * FROM Statistiques_covid WHERE date >=$2 and date <=$3
      )
      SELECT tmp.iso, SUM( ( (tmp.deces+(0.0))/(
       (SELECT hab+(
         SELECT sum(deces)+(
           SELECT sum(deces)-(
             SELECT sum(naiss) as naiss FROM Population WHERE iso = tmp.iso and date > $3
           ) as deces FROM Statistiques_covid WHERE iso = tmp.iso and date >$3
         ) as deces FROM Population WHERE iso = tmp.iso and date > $3
       ) FROM pays WHERE iso = tmp.iso)
        +0.0)) ) AS ratio_deces
      FROM tmp NATURAL JOIN Pays
      GROUP BY tmp.iso )
  SELECT DISTINCT count(*) OVER (ORDER BY ratio_deces DESC) as top,nom,ratio_deces
  FROM tmp2 NATURAL JOIN Pays
  WHERE ratio_deces IS NOT NULL
  ORDER BY ratio_deces DESC
  LIMIT $1;


-- Pays qui ont pris une des mesures les plus strictes

PREPARE mesure_max_strict AS
  SELECT DISTINCT md.iso
  FROM Mesures_distanciations as md JOIN Mesures_sanitaires as ms ON md.iso=ms.iso AND md.date = ms.date
  WHERE (
    conf = 3 OR ecole = 3 or traffic = 2 OR teletra = 3 OR rassem = 4
    or evt_pub = 2 or dpl_reg = 2 or dpl_int = 4 or trace = 2 or masque = 4
    or pol_vacc = 5
  )
  GROUP BY md.iso;

PREPARE conf_max AS
  SELECT DISTINCT nom
  FROM Mesures_distanciations NATURAL JOIN Pays
  WHERE (
    conf = 3
  ) ORDER BY nom;

PREPARE masque_max AS
  SELECT DISTINCT nom
  FROM Mesures_sanitaires NATURAL JOIN Pays
  WHERE (
    masque = 3
  ) ORDER BY nom;
