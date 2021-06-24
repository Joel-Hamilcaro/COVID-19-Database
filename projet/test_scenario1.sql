\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "TEST ---------------------------------------------";

DELETE FROM Statistiques_covid WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Statistiques_lieux_visites WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Mesures_distanciations WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Mesures_economiques WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Population WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Hopitaux WHERE iso= 'FRA' and nom = 'Hopital Magique' ;

\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo " SELECT * FROM Pays WHERE iso='FRA';";
\! echo "\n";
SELECT * FROM Pays WHERE iso='FRA';
\! echo "______________________________________________________________________________________________________________________________";
\! echo " INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-11',10039,5540);\n INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-12',3002321,8989);\n INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-13',5988493,8392);\n INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-14',8900321,278);\n INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-15',1039940,6789);";
\! echo "\n";

\! echo "______________________________________________________________________________________________________________________________";
\! echo " SELECT * FROM Population WHERE iso='FRA' and date>='2021-05-09';\n SELECT * FROM Pays WHERE iso='FRA';";
\! echo "\n";

INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-11',10039,5540);
INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-12',3002321,8989);
INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-13',5988493,8392);
INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-14',8900321,278);
INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-15',1039940,6789);
SELECT * FROM Population WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Population SET deces = 0, naiss = 20000000 WHERE iso= 'FRA' and date = '2020-01-01' ;";
\! echo "\n";

UPDATE Population SET deces = 0, naiss = 20000000 WHERE iso= 'FRA' and date = '2021-05-15' ;
SELECT * FROM Population WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-16',90039940,6789);"
\! echo "\n";

INSERT INTO Population(iso,date,deces,naiss) VALUES ('FRA','2021-05-16',90039940,6789);
SELECT * FROM Population WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Population WHERE iso= 'FRA' and date>= '2021-05-11' ;"
\! echo "\n";

DELETE FROM Population WHERE iso= 'FRA' and date>= '2021-05-11' ;
SELECT * FROM Population WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';






\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,deces) VALUES ('FRA','2021-05-11',8000000);"
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,deces) VALUES ('FRA','2021-05-11',8000000);
SELECT * FROM Statistiques_covid WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';

\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('FRA','2021-05-12',70000000);"
\! echo "\n";

INSERT INTO Statistiques_covid(iso,date,cas) VALUES ('FRA','2021-05-12',70000000);
SELECT * FROM Statistiques_covid WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Statistiques_covid SET deces = 999, r0 = 2 WHERE iso= 'FRA' and date = '2021-05-11' ;";
\! echo "\n";

UPDATE Statistiques_covid SET deces = 999, r0 = 2 WHERE iso= 'FRA' and date = '2021-05-11' ;
SELECT * FROM Statistiques_covid WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "DELETE FROM Statistiques_covid WHERE iso= 'FRA' and date>= '2021-05-11' ;";
\! echo "\n";

DELETE FROM Statistiques_covid WHERE iso= 'FRA' and date>= '2021-05-11' ;
SELECT * FROM Statistiques_covid WHERE iso='FRA' and date>='2021-05-09';
SELECT * FROM Pays WHERE iso='FRA';


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Hopitaux(iso,nom,lits) VALUES ('FRA','Hopital Magique',60000000);";
\! echo "\n";

INSERT INTO Hopitaux(iso,nom,lits) VALUES ('FRA','Hopital Magique',70000000);
SELECT * FROM Hopitaux WHERE iso='FRA' and nom = 'Hopital Magique';
SELECT iso,hab,lits as lits_‰ FROM Pays WHERE iso='FRA' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "UPDATE Hopitaux SET nom='Hopital magique' , lits=1000 WHERE iso='FRA' and nom='Hopital Magique';";
\! echo "\n";

UPDATE Hopitaux SET lits=1000 WHERE iso='FRA' and nom='Hopital Magique';
SELECT * FROM Hopitaux WHERE iso='FRA' and nom = 'Hopital Magique';
SELECT iso,hab,lits as lits_‰, e_vie FROM Pays WHERE iso='FRA' ;





\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Statistiques_lieux_visites(iso,date,dist,achat,parc,transp,travail,resid) VALUES ('FRA','2021-05-11',+100,+100,+100,+100,+100,-100);";
\! echo "\n";

INSERT INTO Statistiques_lieux_visites(iso,date,dist,achat,parc,transp,travail,resid) VALUES ('FRA','2021-05-11',+100,+100,+100,+100,+100,-100);
SELECT * FROM Statistiques_lieux_visites WHERE iso='FRA' and date>= '2021-05-11' ;
SELECT iso,e_vie FROM Pays WHERE iso='FRA' ;

\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Mesures_distanciations(iso,date,teletra,conf) VALUES ('FRA','2021-05-11',3,3);";
\! echo "\n";

INSERT INTO Mesures_distanciations(iso,date,teletra,conf) VALUES ('FRA','2021-05-11',3,3);
SELECT * FROM Mesures_distanciations WHERE iso='FRA' and date>= '2021-05-11' ;
SELECT iso,pib FROM Pays WHERE iso='FRA' ;


\! echo "\n\n\n\n\n";
\! echo "______________________________________________________________________________________________________________________________";
\! echo "INSERT INTO Mesures_economiques(iso,date,inv_sante,inv_rel) VALUES ('FRA','2021-05-11',1000000,1000000);";
\! echo "\n";

INSERT INTO Mesures_economiques(iso,date,inv_sante,inv_rel) VALUES ('FRA','2021-05-11',1000000,1000000);
SELECT * FROM Mesures_economiques WHERE iso='FRA' and date>= '2021-05-11' ;
SELECT iso,hab,pib FROM Pays WHERE iso='FRA';

-----------------

DELETE FROM Statistiques_covid WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Statistiques_lieux_visites WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Mesures_distanciations WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Mesures_economiques WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Population WHERE iso= 'FRA' and date>= '2021-05-11' ;
DELETE FROM Hopitaux WHERE iso= 'FRA' and nom = 'Hopital Magique' ;
