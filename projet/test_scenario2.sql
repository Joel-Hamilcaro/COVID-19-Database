\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "\n\n\n\n\n";
\! echo "TEST ---------------------------------------------";

\i prepare.sql;
\i delete_indexes.sql;
\i create_indexes.sql;
\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Nombre d'habitant en France le 1 mai 2020";
\! echo "EXECUTE nb_hab('FRA','2020-05-01')";

EXECUTE nb_hab('FRA','2020-05-01');

\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Nombre de cas aux USA le 14 mai 2020";
\! echo "execute covid ('USA','2020-05-14');";

 execute covid ('USA','2020-05-14');


 \! echo "\n\n\n";
 \! echo "---------------------------------------------";
 \! echo "\n";
 \! echo "Dates où le nombre de cas par jour dépasse 50000 au Royaume-Uni";
 \! echo " execute depasser ('GBR', 50000);";

execute depasser ('GBR', 50000);

\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Dates où le nombre de décès par jour dépasse 800 en Italie";
\! echo " execute depasser ('ITA', 800);";

execute dc_depasser ('ITA', 800);


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Liste des date et pays où la fréquentation des lieux de distractions (restaurants, cinéma, spectacles...) a augmenté d'un facteur 70";
\! echo "execute dist_depasser_all(70);"

execute dist_depasser_all(70);


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Dates du début des mesures de confinement/couvre-feu en France";
\! echo "execute dconf ('FRA', 2);"


execute dconf ('FRA', 2);


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Afficher l'évolution de l'épidémie sans port de masque aux USA";
\! echo "execute sans_masque('USA');"


execute sans_masque('USA');


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Afficher l'évolution de l'épidémie avec port de masque aux USA";
\! echo "execute masque('USA');"


execute masque('USA');


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Afficher les pays dont la population ne respecte pas les mesures de distanciations";
\! echo "execute respecte"

execute respecte;

\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Difference du nombre de cas par jour en Chine entre le avril 2020 et le juin 2020";
\! echo "execute evolution_cas('CHN','2020-04-01','2020-06-01');"

execute evolution_cas('CHN','2020-04-01','2020-06-01');


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Nombre de cas total en France entre le mars 2020 et le mai 2021";
\! echo "execute nb_total('FRA','2020-03-01','2021-05-01');"

execute nb_total('FRA','2020-03-01','2021-05-01');


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Nombre d'hospitalisation total en Espagne le mois de janvier 2021";
\! echo "execute hosp_total('ESP','2021-01-01','2021-02-01');"

execute hosp_total('ESP','2021-01-01','2021-02-01');

\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Equivalent de la table Statistiques_covid mais en nombre cumulés pour la Pologne (on se limite aux 30 premières lignes)";
\! echo "execute cum_stats_limit('POL',30); "

execute cum_stats_limit('POL',30);


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Pays qui n'ont jamais imposé de port de masque";
\! echo "execute jamais_masque; "

execute jamais_masque;


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Pays qui n'ont jamais confiné";
\! echo "execute jamais_conf; "

execute jamais_conf;


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "Pays qui n'ont jamais fermé les écoles";
\! echo "execute jamais_ferme_ecole; "

execute jamais_ferme_ecole;


\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "20 pays les plus stricts";
\! echo "execute top_strict(20); "

execute top_strict(20);

\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "20 pays avec le plus de cas (ratio par rapport à la population) entre fevrier 2020 et mai 2021";
\! echo "execute top_cas(20); "

execute top_cas(20,'2020-02-01','2021-05-01');

\! echo "\n\n\n";
\! echo "---------------------------------------------";
\! echo "\n";
\! echo "20 pays avec le plus de deces (ratio par rapport à la population) entre fevrier 2020 et mai 2021";
\! echo "execute top_deces(20); "

execute top_deces(20,'2020-02-01','2021-05-01');
