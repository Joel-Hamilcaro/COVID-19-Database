\i delete_all.sql;
-- CREATE DATABASE pjbda;

---------------------------pays------------------------------
--DROP TABLE IF EXISTS Continent CASCADE;
CREATE TABLE Continent(
  code CHAR(2) NOT NULL,
  nom  VARCHAR(25) NOT NULL,
  PRIMARY KEY (code)
);


--DROP   TABLE IF EXISTS Pays CASCADE;
CREATE TABLE Pays(
  code                         CHAR(2)      references Continent(code),
  iso                          CHAR(3)   NOT NULL,
  nom                          VARCHAR(45)  NOT NULL,
  hab             INT          CHECK(hab>=0),
  pl70               FLOAT          CHECK(pl70>=0 AND pl70<=100),
  pl65               FLOAT          CHECK(pl65>=0 AND pl65<=100 AND pl65 >= pl70 ),
  age_md                   FLOAT          CHECK(age_md >= 0 ),
  surface                      FLOAT          CHECK(surface >= 0 ),
  pv_ex             FLOAT          CHECK(pv_ex>=0 AND pv_ex<=100),
  idh                          FLOAT          CHECK(idh>=0 AND idh <=1),
  pib                          FLOAT          CHECK(pib>=0),
  e_vie             FLOAT          CHECK(e_vie>=0 ),
  l_mains     FLOAT          CHECK(l_mains>=0 AND l_mains<=100),
  fumeurs                      FLOAT          CHECK(fumeurs >=0 AND fumeurs<=100),
  pr_diab        FLOAT          CHECK(pr_diab >= 0 AND pr_diab<= 100),
  lits                FLOAT          CHECK(lits>=0),
  m_card   FLOAT          CHECK(m_card>=0 AND m_card<=1000),
  PRIMARY KEY (iso)
);

--DROP   TABLE IF EXISTS Population CASCADE;
CREATE TABLE Population (
  iso             CHAR(3)    references Pays (iso),
  date            DATE          NOT NULL,
  deces           INT           CHECK(deces >=0),
  naiss     INT           CHECK(naiss>=0),
  PRIMARY KEY (iso,date)

);


-------------------------covid----------------------------------



--DROP   TABLE IF EXISTS Statistiques_covid CASCADE;
CREATE TABLE Statistiques_covid(
  date               DATE          NOT NULL,
  iso                CHAR(3)       references Pays (iso),
  cas                INT           CHECK (cas>=0 ),
  deces              INT           CHECK (deces>=0),
  r0                 FLOAT         CHECK (r0>=0),
  rea       INT           CHECK (rea>=0),
  hosp   INT           CHECK (hosp>=0),
  tests              INT           CHECK (tests>=0),
  vacc      INT           CHECK (vacc>=0),
  PRIMARY KEY (iso,date)
);


--DROP   TABLE IF EXISTS Statistiques_lieux_visites CASCADE;
CREATE TABLE Statistiques_lieux_visites(
  date                   DATE          NOT NULL,
  iso                    CHAR(3)    references Pays (iso),
  dist           FLOAT          ,
  achat                 FLOAT           ,
  parc                  FLOAT          ,
  transp  FLOAT           ,
  travail       FLOAT           ,
  resid             FLOAT ,
  PRIMARY KEY (iso,date)
);



----------------------mesures---------------------------



--DROP   TABLE IF EXISTS Mesures_de_distanciations CASCADE;
CREATE TABLE Mesures_distanciations(
  date                         DATE          NOT NULL,
  iso                          CHAR(3)    references Pays (iso),
  conf                  INT           CHECK(conf>=0 AND conf<=3),
  ecole         INT           CHECK(ecole >=0 AND ecole<=3),
  traffic           INT           CHECK(traffic >=0 AND traffic <=2),
  teletra                  INT           CHECK(teletra >=0 AND teletra <=3),
  rassem                INT           CHECK(rassem >=0 AND rassem<=4),
  evt_pub           INT           CHECK(evt_pub>=0 AND evt_pub<=2),
  dpl_reg       INT           CHECK(dpl_reg>=0 AND dpl_reg<=2),
  dpl_int  INT           CHECK(dpl_int>=0 AND dpl_int<=4),
  PRIMARY KEY (iso,date)

);

--DROP   TABLE IF EXISTS Mesures_de_sanitaires CASCADE;
CREATE TABLE Mesures_sanitaires(
  date                            DATE          NOT NULL,
  iso                             CHAR(3)       references Pays (iso),
  info           INT           CHECK(info>=0 AND info<=2),
  pol_test              INT           CHECK(pol_test>=0 AND pol_test<=3),
  trace         INT           CHECK(trace>=0 AND trace<=2),
  masque                  INT           CHECK(masque>=0 AND masque<=4),
  pol_vacc        INT           CHECK(pol_vacc>=0 AND pol_vacc<=5),
  pro_ages  INT           CHECK(pro_ages>=0 AND pro_ages<=3)
);

--DROP   TABLE IF EXISTS Mesures_economiques CASCADE;
CREATE TABLE Mesures_economiques(
  date                                  DATE          NOT NULL,
  iso                                   CHAR(3)       references Pays (iso),
  inv_sante          FLOAT          ,
  inv_vacc       FLOAT          ,
  aides_mng                    INT           CHECK(aides_mng>=0 AND aides_mng<=2),
  alle_mng INT           CHECK(alle_mng>=0 AND alle_mng<=2),
  inv_rel        FLOAT           ,
  aides_int                 FLOAT ,
  PRIMARY KEY (iso,date)
);

CREATE TABLE Hopitaux(
  nom                                  VARCHAR(55)          NOT NULL,
  iso                                  CHAR(3)       references Pays (iso),
  lits          INT           CHECK(lits>=0),
  PRIMARY KEY (nom,iso)
);

-- \i trigger.sql;
