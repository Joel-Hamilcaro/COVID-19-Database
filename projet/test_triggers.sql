\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER POPULATION(deces,naiss) met à jour PAYS(hab)                                          |";
\! echo "+-----------------------------------------------------------------------------------------------+";

-- TEST : POPULATION

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Pays(iso,nom,hab) VALUES ('XXX','Pays X',1000);";
\! echo "\n";

INSERT INTO Pays(iso,nom,hab) VALUES ('XXX','Pays X',1000);
SELECT * FROM Pays WHERE iso='XXX';











\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Population(iso,date,deces,naiss) VALUES ('XXX','2020-01-03',5,8);";
\! echo "\n";

INSERT INTO Population(iso,date,deces,naiss) VALUES ('XXX','2020-01-03',5,8);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Population(iso,date,deces,naiss) VALUES ('XXX','2020-01-01',10,2);";
\! echo "\n";

INSERT INTO Population(iso,date,deces,naiss) VALUES ('XXX','2020-01-01',10,2);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Population SET deces = 13, naiss = 7 WHERE date = '2020-01-01' ;";
\! echo "\n";

UPDATE Population SET deces = 13, naiss = 7 WHERE date = '2020-01-01' ;
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Population WHERE iso='XXX' and date = '2020-01-01' ;";
\! echo "\n";

DELETE FROM Population WHERE iso='XXX' and date = '2020-01-01' ;
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';








\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Stats_Covid(deces) met à jour PAYS(hab)                                               |";
\! echo "+-----------------------------------------------------------------------------------------------+";


-- TEST : Statistiques_covid

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,deces) VALUES ('XXX','2020-01-03',90);";
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,deces) VALUES ('XXX','2020-01-03',90);
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,deces) VALUES ('XXX','2020-01-01',7);";
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,deces) VALUES ('XXX','2020-01-01',7);
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Statistiques_covid SET deces = 3 WHERE date = '2020-01-01' and iso = 'XXX' ;";
\! echo "\n";

UPDATE Statistiques_covid SET deces = 3 WHERE date = '2020-01-01' and iso = 'XXX' ;
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Statistiques_covid WHERE date = '2020-01-01' and iso = 'XXX' ;";
\! echo "\n";

DELETE FROM Statistiques_covid WHERE date = '2020-01-01' and iso = 'XXX' ;
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';














\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Stats_Covid(cas) doit être inférieur à PAYS(hab)                                      |";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "\n\n\n\n\n";



-- empecher des insertions si les nombres depasse le nombre d'habitant
SELECT * FROM Pays WHERE iso='XXX';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('XXX','2020-01-02',1000);";
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('XXX','2020-01-02',1000);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('XXX','2020-01-01',1004);";
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('XXX','2020-01-01',1004);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('XXX','2020-01-04',100);";
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('XXX','2020-01-04',100);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Statistiques_covid  SET deces = 1005  WHERE date = '2020-01-02' and iso = 'XXX' ;";
\! echo "\n";

UPDATE Statistiques_covid SET deces = 1005 WHERE date = '2020-01-02' and iso = 'XXX' ;
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Statistiques_covid WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';





















\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Population(deces) doit être inférieur à Pays(hab)                                      |";
\! echo "+-----------------------------------------------------------------------------------------------+";




\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Pays SET hab=700 WHERE iso='XXX';";
\! echo "\n";
-- empecher des insertions si les nombres depasse le nombre d'habitant
UPDATE Pays SET hab=700 WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Population(iso,date,deces) VALUES ('XXX','2020-01-02',1000);";
\! echo "\n";

INSERT INTO Population(iso,date,deces) VALUES ('XXX','2020-01-02',1000);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Population(iso,date,deces) VALUES ('XXX','2020-01-02',700);";
\! echo "\n";

INSERT INTO Population(iso,date,deces) VALUES ('XXX','2020-01-02',700);
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';



\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Population(iso,date,deces) VALUES ('XXX','2020-01-02',700);";
\! echo "\n";

UPDATE Population SET deces=3 WHERE iso='XXX' and date = '2020-01-03';
SELECT * FROM Population WHERE iso='XXX';
SELECT * FROM Pays WHERE iso='XXX';











\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Hopitaux(lits) mets à jour PAYS(lits_‰)                                               |";
\! echo "+-----------------------------------------------------------------------------------------------+";


-- Hopitaux

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Pays SET hab = 2000 WHERE iso = 'XXX' ;";
\! echo "\n";

UPDATE Pays SET hab = 2000 WHERE iso = 'XXX' ;
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Hopitaux(iso,nom,lits) VALUES ('XXX','Hop1',300);";
\! echo "\n";

INSERT INTO Hopitaux(iso,nom,lits) VALUES ('XXX','Hop1',300);
SELECT * FROM Hopitaux WHERE iso='XXX';
SELECT iso,hab,lits as lits_‰ FROM Pays WHERE iso='XXX' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Hopitaux(iso,nom,lits) VALUES ('XXX','Hop2',4000);";
\! echo "\n";

INSERT INTO Hopitaux(iso,nom,lits) VALUES ('XXX','Hop2',4000);
SELECT * FROM Hopitaux WHERE iso='XXX';
SELECT iso,hab,lits as lits_‰ FROM Pays WHERE iso='XXX' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Hopitaux SET lits=1000 WHERE iso='XXX' and nom='Hop1';";
\! echo "\n";

UPDATE Hopitaux SET lits=1000 WHERE iso='XXX' and nom='Hop1';
SELECT * FROM Hopitaux WHERE iso='XXX';
SELECT iso,hab,lits as lits_‰ FROM Pays WHERE iso='XXX' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Hopitaux WHERE iso='XXX' and nom='Hop2';";
\! echo "\n";

DELETE FROM Hopitaux WHERE iso='XXX' and nom='Hop2';
SELECT * FROM Hopitaux WHERE iso='XXX';
SELECT iso,hab,lits as lits_‰ FROM Pays WHERE iso='XXX' ;










\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Mesures_distanciations mets à jour esp_vie                                            |";
\! echo "+-----------------------------------------------------------------------------------------------+";


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Pays SET e_vie = 70 WHERE iso = 'XXX' ;";
\! echo "\n";

UPDATE Pays SET e_vie = 70 WHERE iso = 'XXX' ;
SELECT * FROM Pays WHERE iso='XXX';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_lieux_visites(iso,date,dist,achat,parc,transp,travail,resid) VALUES ('XXX','2021-05-01',+3,-7,+10,-5,+13,-16);";
\! echo "\n";

INSERT INTO Statistiques_lieux_visites(iso,date,dist,achat,parc,transp,travail,resid) VALUES ('XXX','2021-05-01',+3,-7,+10,-5,+13,-16);
SELECT * FROM Statistiques_lieux_visites WHERE iso='XXX';
SELECT iso,e_vie FROM Pays WHERE iso='XXX' ;


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_lieux_visites(iso,date,resid) VALUES ('XXX','2021-05-02',+30);";
\! echo "\n";

INSERT INTO Statistiques_lieux_visites(iso,date,resid) VALUES  ('XXX','2021-05-02',+30);
SELECT * FROM Statistiques_lieux_visites WHERE iso='XXX';
SELECT iso,e_vie FROM Pays WHERE iso='XXX' ;


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Statistiques_lieux_visites SET dist = 1000 WHERE iso='XXX' and date='2021-05-02';";
\! echo "\n";


UPDATE Statistiques_lieux_visites SET dist = 10 WHERE iso='XXX' and date='2021-05-02';
SELECT * FROM Statistiques_lieux_visites WHERE iso='XXX';
SELECT iso,e_vie FROM Pays WHERE iso='XXX' ;


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Statistiques_lieux_visites SET dist = -90 WHERE iso='XXX' and date='2021-05-02';";
\! echo "\n";

UPDATE Statistiques_lieux_visites SET dist = 1000 WHERE iso='XXX' and date='2021-05-02';
SELECT * FROM Statistiques_lieux_visites WHERE iso='XXX';
SELECT iso,e_vie FROM Pays WHERE iso='XXX' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Statistiques_lieux_visites WHERE iso='XXX' and date='2021-05-02';"
\! echo "\n";

DELETE FROM Statistiques_lieux_visites WHERE iso='XXX' and date='2021-05-02';
SELECT * FROM Statistiques_lieux_visites WHERE iso='XXX';
SELECT iso,e_vie FROM Pays WHERE iso='XXX' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Statistiques_lieux_visites WHERE iso='XXX' and date='2021-05-01';"
\! echo "\n";

DELETE FROM Statistiques_lieux_visites WHERE iso='XXX' and date='2021-05-01';
SELECT * FROM Statistiques_lieux_visites WHERE iso='XXX';
SELECT iso,e_vie FROM Pays WHERE iso='XXX' ;























\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Mesures_economique mets à jour Pays(pib)                                              |";
\! echo "+-----------------------------------------------------------------------------------------------+";

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Pays SET pib = 700 WHERE iso = 'XXX' ;";
\! echo "\n";

UPDATE Pays SET pib = 700 WHERE iso = 'XXX' ;
SELECT iso,hab,pib FROM Pays WHERE iso='XXX';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Mesures_economiques(iso,date,inv_sante,inv_rel) VALUES ('XXX','2021-05-01',10000,10000);";
\! echo "\n";

INSERT INTO Mesures_economiques(iso,date,inv_sante,inv_rel) VALUES ('XXX','2021-05-01',10000,10000);
SELECT * FROM Mesures_economiques WHERE iso='XXX';
SELECT iso,hab,pib FROM Pays WHERE iso='XXX';



\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Mesures_economiques(iso,date,inv_sante,inv_vacc) VALUES ('XXX','2020-05-01',2000,200000);";
\! echo "\n";

INSERT INTO Mesures_economiques(iso,date,inv_sante,inv_vacc) VALUES ('XXX','2020-05-01',2000,200000);
SELECT * FROM Mesures_economiques WHERE iso='XXX';
SELECT iso,hab,pib FROM Pays WHERE iso='XXX';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Mesures_economiques SET aides_int = 10000 WHERE iso='XXX' and date='2021-05-01';";
\! echo "\n";

UPDATE Mesures_economiques SET aides_int = 10000 WHERE iso='XXX' and date='2021-05-01';
SELECT * FROM Mesures_economiques WHERE iso='XXX';
SELECT iso,hab,pib FROM Pays WHERE iso='XXX' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Mesures_economiques WHERE iso='XXX' and date='2020-05-01';";
\! echo "\n";

DELETE FROM Mesures_economiques WHERE iso='XXX' and date='2020-05-01';
SELECT * FROM Mesures_economiques WHERE iso='XXX';
SELECT iso,hab,pib FROM Pays WHERE iso='XXX' ;


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Mesures_economiques WHERE iso='XXX' and date='2021-05-01';";
\! echo "\n";

DELETE FROM Mesures_economiques WHERE iso='XXX' and date='2021-05-01';
SELECT * FROM Mesures_economiques WHERE iso='XXX';
SELECT iso,hab,pib FROM Pays WHERE iso='XXX' ;



















\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "+-----------------------------------------------------------------------------------------------+";
\! echo "| TRIGGER Notifications                                                                         |";
\! echo "+-----------------------------------------------------------------------------------------------+";

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Continent(code ,nom) VALUES ('A','contiA');";
\! echo "\n";
\! echo "INSERT INTO Pays (code  ,iso  ,nom ,hab    ,pl70,pl65,age_md,surface,pv_ex,idh,pib,e_vie,l_mains,fumeurs,pr_diab,lits,m_card) VALUES ('A'   ,'aaa','aa',9999999,65.0,70.0,50.5  ,9999   ,40   ,0.5,999,60   ,30     ,50     ,40     ,999 ,200);";
\! echo "\n";
\! echo "INSERT INTO Statistiques_covid (date      ,iso  ,cas  ,deces,r0 ,rea ,hosp ,tests ,vacc) VALUES ('1999-01-08','aaa',11111,1111 ,2  ,111 ,1111 ,11111 ,1111);";
\! echo "\n";




INSERT INTO Continent(code ,nom) VALUES ('A','contiA');
INSERT INTO Pays (code  ,iso  ,nom ,hab    ,pl70,pl65,age_md,surface,pv_ex,idh,pib,e_vie,l_mains,fumeurs,pr_diab,lits,m_card)
          VALUES ('A'   ,'aaa','aa',9999999,65.0,70.0,50.5  ,9999   ,40   ,0.5,999,60   ,30     ,50     ,40     ,999 ,200);
INSERT INTO Statistiques_covid (date      ,iso  ,cas  ,deces,r0 ,rea ,hosp ,tests ,vacc)
                        VALUES ('1999-01-08','aaa',11111,1111 ,2  ,111 ,1111 ,11111 ,1111);
SELECT * FROM   Statistiques_covid WHERE iso='aaa';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE from Statistiques_covid WHERE date ='1999-01-08';";
\! echo "\n";
\! echo "DELETE FROM Mesures_distanciations WHERE date ='1999-01-08';";
\! echo "\n";
\! echo "INSERT INTO Mesures_distanciations (date,iso,conf,ecole,traffic,teletra,rassem,evt_pub,dpl_reg,dpl_int) VALUES('1999-01-08','aaa',3,3,2,3,4,2,2,4);";
\! echo "\n";
DELETE from Statistiques_covid WHERE date ='1999-01-08';

----
DELETE FROM Mesures_distanciations WHERE date ='1999-01-08';
INSERT INTO Mesures_distanciations (  date     ,iso  ,conf,ecole,traffic,teletra,rassem,evt_pub,dpl_reg,dpl_int)
                            VALUES('1999-01-08','aaa',3   ,3    ,2      ,3      ,4     ,2      ,2      ,4      );
SELECT * FROM Mesures_distanciations WHERE iso='aaa';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_lieux_visites(date,iso,dist,achat,parc,transp,travail,resid) VALUES('1999-01-08','aaa',1,1,1,1,1,-1);";
\! echo "\n";

INSERT INTO Statistiques_lieux_visites(date        ,iso  ,dist,achat,parc,transp,travail,resid)
                                VALUES('1999-01-08','aaa',1   ,1    ,1   ,1     ,1      ,-1   );
SELECT * FROM Statistiques_lieux_visites WHERE iso='aaa';
