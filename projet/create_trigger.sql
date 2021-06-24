-- Population -> Pays
-- Les données sur les naissances et décès (table Population)
-- influent sur le nombre d'habitant (table Pays)

CREATE OR REPLACE FUNCTION hab_population_update()
RETURNS trigger AS $$
  BEGIN
    IF (TG_OP = 'INSERT') THEN
      UPDATE Pays
      SET hab = hab - COALESCE(NEW.deces,0) + COALESCE(NEW.naiss,0)
      WHERE iso = NEW.iso;
      RETURN NEW;
    END IF;
    IF (TG_OP = 'UPDATE') THEN
      UPDATE Pays
      SET hab = hab - (COALESCE(NEW.deces,0) - COALESCE(OLD.deces,0))
      + (COALESCE(NEW.naiss,0) - COALESCE(OLD.naiss,0))
      WHERE iso = NEW.iso AND iso = OLD.iso;
      RETURN NEW;
    END IF;
    IF (TG_OP = 'DELETE') THEN
      UPDATE Pays
      SET hab = hab + (COALESCE(OLD.deces,0)) - (COALESCE(OLD.naiss,0))
      WHERE iso = OLD.iso;
      RETURN OLD;
    END IF;
    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AAB_Population_Pays_trigger
BEFORE INSERT OR UPDATE OR DELETE ON Population
FOR EACH ROW
EXECUTE PROCEDURE hab_population_update();

-- Stats_Covid -> Pays
-- Les données sur les décès due au COVID (table Stats_Covid)
-- influent sur le nombre d'habitant (table Pays)

CREATE OR REPLACE FUNCTION hab_deces_covid_update()
RETURNS trigger AS $$
  BEGIN
    IF (TG_OP = 'INSERT') THEN
      UPDATE Pays
      SET hab = hab - COALESCE(NEW.deces,0)
      WHERE iso = NEW.iso;
      RETURN NEW;
    END IF;
    IF (TG_OP = 'UPDATE') THEN
      UPDATE Pays
      SET hab = hab - (COALESCE(NEW.deces,0) - COALESCE(OLD.deces,0))
      WHERE iso = NEW.iso AND iso = OLD.iso;
      RETURN NEW;
    END IF;
    IF (TG_OP = 'DELETE') THEN
      UPDATE Pays
      SET hab = hab + (COALESCE(OLD.deces,0))
      WHERE iso = OLD.iso;
      RETURN OLD;
    END IF;
    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AAB_Covid_Pays_trigger
BEFORE DELETE OR INSERT OR UPDATE ON Statistiques_covid
FOR EACH ROW
EXECUTE PROCEDURE hab_deces_covid_update();


-- Stats_Covid -> Pays
-- Le nombre de cas (table Stats_Covid) ne peut pas dépasser le nombre
-- d'habitant du pays. (idem pour hospitalisés,décès,rea,testés,vaccinés)

CREATE OR REPLACE FUNCTION cas_constraint()
RETURNS trigger AS $$
  DECLARE
    dc INT8;
    ns INT8;
    hb INT8;
    dcc INT8;
  BEGIN
    dc = (SELECT sum(deces) as deces FROM Population WHERE iso = NEW.iso and date > NEW.date);
    ns = (SELECT sum(naiss) as naiss FROM Population WHERE iso = NEW.iso and date > NEW.date);
    dcc = (SELECT sum(deces) as deces FROM Statistiques_covid WHERE iso = NEW.iso and date > NEW.date);
    hb = (SELECT hab FROM Pays WHERE iso = NEW.iso);
    IF (NEW.cas > hb+COALESCE(dc+dcc-ns,0) ) THEN
      raise notice 'Le nombre de cas ne peut pas dépasser le nombre d"habitants :%',  hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    IF (NEW.deces > hb+dc+dcc-ns ) THEN
      raise notice 'Le nombre de décès ne peut pas dépasser le nombre d"habitants :%',  hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    IF (NEW.rea > hb+dc+dcc-ns ) THEN
      raise notice 'Le nombre de personnes en réanimation ne peut pas dépasser le nombre d"habitants :%',  hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    IF (NEW.hosp > hb+dc+dcc-ns ) THEN
      raise notice 'Le nombre d"hospitalisés ne peut pas dépasser le nombre d"habitants :%', hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    IF (NEW.tests > hb+dc+dcc-ns ) THEN
      raise notice 'Le nombre de testés ne peut pas dépasser le nombre d"habitants :%', hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    IF (NEW.vacc > hb+dc+dcc-ns ) THEN
      raise notice 'Le nombre de vaccinés ne peut pas dépasser le nombre d"habitants :%',  hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AAA_cas_hab_trigger
BEFORE INSERT OR UPDATE ON Statistiques_covid
FOR EACH ROW
  EXECUTE PROCEDURE cas_constraint();

-- Population -> Pays
-- Le nombre de deces (table Population) ne peut pas dépasser le nombre
-- d'habitant du pays.

CREATE OR REPLACE FUNCTION deces_constraint()
RETURNS trigger AS $$
  DECLARE
  DECLARE
    dc INT8;
    ns INT8;
    hb INT8;
    dcc INT8;
  BEGIN
    dc = (SELECT sum(deces) as deces FROM Population WHERE iso = NEW.iso and date > NEW.date);
    ns = (SELECT sum(naiss) as naiss FROM Population WHERE iso = NEW.iso and date > NEW.date);
    dcc = (SELECT sum(deces) as deces FROM Statistiques_covid WHERE iso = NEW.iso and date > NEW.date);
    hb = (SELECT hab FROM Pays WHERE iso = NEW.iso);
    IF (NEW.deces >  hb+COALESCE(dc+dcc-ns,0) ) THEN
      raise notice 'Le nombre de deces ne peut pas dépasser le nombre d"habitants : %', hb+COALESCE(dc+dcc-ns,0);
      return NULL;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AAA_deces_hab_trigger
BEFORE INSERT OR UPDATE ON Population
FOR EACH ROW
  EXECUTE PROCEDURE deces_constraint();



---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- Hopitaux -> Pays
-- Les données sur les hôpitaux (table Hopitaux) influe sur le
-- nombre de lits pour mille habitants (table Pays)

  CREATE OR REPLACE FUNCTION lits_update()
    RETURNS trigger AS $$
    DECLARE
      total_lits INT8;
    BEGIN
     IF (TG_OP = 'INSERT') THEN
       total_lits = (SELECT COALESCE(lits,0) FROM Pays WHERE iso = NEW.iso)
       *(SELECT hab FROM Pays WHERE iso = NEW.iso)/1000;
       total_lits = COALESCE(total_lits,0);
       UPDATE Pays
       SET lits = COALESCE( (total_lits+NEW.lits+0.0)/hab*1000 ,0)
       WHERE iso = NEW.iso;
       RETURN NEW;
     END IF;
     IF (TG_OP = 'UPDATE') THEN
      total_lits = (SELECT lits FROM Pays WHERE iso = NEW.iso)*
      (SELECT hab FROM Pays WHERE iso = NEW.iso)/1000;
      total_lits = COALESCE(total_lits,0);
      UPDATE Pays
      SET lits = COALESCE( (total_lits+NEW.lits-OLD.lits+0.0)/hab*1000 ,0)
      WHERE iso = NEW.iso;
      RETURN NEW;
     END IF;
     IF (TG_OP = 'DELETE') THEN
      total_lits = (SELECT lits FROM Pays WHERE iso = OLD.iso)*
      (SELECT hab FROM Pays WHERE iso = OLD.iso)/1000;
      total_lits = COALESCE(total_lits,0);
      UPDATE Pays
      SET lits = COALESCE( (total_lits-OLD.lits+0.0)/hab*1000 ,0)
      WHERE iso = OLD.iso;
      RETURN OLD;
     END IF;
    END;
  $$ LANGUAGE plpgsql;

CREATE TRIGGER AAA_Hopitaux_Pays_trigger
BEFORE INSERT OR UPDATE OR DELETE ON Hopitaux
FOR EACH ROW
EXECUTE PROCEDURE lits_update();

-- Statistiques_lieux_visites -> Pays
-- Les données sur les lieux visités (Statistiques_lieux_visites)
-- influent sur l'esperance de vie (table Pays)

CREATE OR REPLACE FUNCTION e_vie_update()
  RETURNS trigger AS $$
  BEGIN
  IF (TG_OP = 'INSERT') THEN
    UPDATE Pays
    SET e_vie = e_vie-COALESCE(NEW.dist*0.0001,0)-COALESCE(NEW.achat*0.0001,0)
    -COALESCE(NEW.parc*0.0001,0)-COALESCE(NEW.transp*0.0001,0)
    -COALESCE(NEW.travail*0.0001,0)+COALESCE(NEW.resid*0.0001,0)
    WHERE iso = NEW.iso;
  RETURN NEW;
    RETURN NEW;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
    UPDATE Pays
    SET e_vie = e_vie-(COALESCE(NEW.dist,0)-COALESCE(OLD.dist,0))*0.0001
    -(COALESCE(NEW.achat,0)-COALESCE(OLD.achat,0))*0.0001
    -(COALESCE(NEW.parc,0)-COALESCE(OLD.parc,0))*0.0001-(COALESCE(NEW.transp,0)
    -COALESCE(OLD.transp,0))*0.0001
    -(COALESCE(NEW.travail,0)-COALESCE(OLD.travail,0))*0.0001
    +(COALESCE(NEW.resid,0)-COALESCE(OLD.resid,0))*0.0001
    WHERE iso = NEW.iso;
   RETURN NEW;
  END IF;
  IF (TG_OP = 'DELETE') THEN
  UPDATE Pays
  SET e_vie = e_vie-COALESCE((-OLD.dist)*0.0001,0)-COALESCE((-OLD.achat)*0.0001,0)
  -COALESCE((-OLD.parc)*0.0001,0)-COALESCE((-OLD.transp)*0.0001,0)
  -COALESCE((-OLD.travail)*0.0001,0)+COALESCE((-OLD.resid)*0.0001,0)
  WHERE iso = OLD.iso;
   RETURN OLD;
  END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AAA_Statistiques_lieux_visites_Pays_trigger
AFTER INSERT OR UPDATE OR DELETE ON Statistiques_lieux_visites
FOR EACH ROW
EXECUTE PROCEDURE e_vie_update();


-- Mesures_economiques -> Pays
-- Les données sur les mesures économiques (table Mesures_economiques)
-- influent sur le PIB (table Pays).

CREATE OR REPLACE FUNCTION pib_update()
  RETURNS trigger AS $$
  DECLARE
    total_pib INT8;
    nb_hab INT8;
    pib_hab INT8;
  BEGIN
  IF (TG_OP = 'INSERT') THEN
    nb_hab = (SELECT hab FROM Pays WHERE iso = NEW.iso );
    pib_hab = (SELECT pib FROM Pays WHERE iso = NEW.iso );
    total_pib = nb_hab*pib_hab;
    total_pib = total_pib - COALESCE(NEW.inv_sante,0)-COALESCE(NEW.inv_vacc,0)
    -COALESCE(NEW.inv_rel,0)+COALESCE(NEW.aides_int,0);
    UPDATE Pays
    SET pib = ROUND(total_pib/nb_hab,2)
    WHERE iso = NEW.iso;
    RETURN NEW;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
    nb_hab = (SELECT hab FROM Pays WHERE iso = NEW.iso );
    pib_hab = (SELECT pib FROM Pays WHERE iso = NEW.iso );
    total_pib = nb_hab*pib_hab;
    total_pib = total_pib - COALESCE(NEW.inv_sante,0)-COALESCE(-OLD.inv_sante,0)
    -COALESCE(NEW.inv_vacc,0)-COALESCE(-OLD.inv_vacc,0)
    -COALESCE(NEW.inv_rel,0)-COALESCE(-OLD.inv_rel,0)+COALESCE(NEW.aides_int,0)
    +COALESCE(-OLD.aides_int,0);
    UPDATE Pays
    SET pib = ROUND(total_pib/nb_hab,2)
    WHERE iso = NEW.iso;
    RETURN NEW;
  END IF;
  IF (TG_OP = 'DELETE') THEN
    nb_hab = (SELECT hab FROM Pays WHERE iso = OLD.iso );
    pib_hab = (SELECT pib FROM Pays WHERE iso = OLD.iso );
    total_pib = nb_hab*pib_hab;
    total_pib = total_pib -COALESCE(-OLD.inv_sante,0)-COALESCE(-OLD.inv_vacc,0)
    -COALESCE(-OLD.inv_rel,0)+COALESCE(-OLD.aides_int,0);
    UPDATE Pays
    SET pib = ROUND(total_pib/nb_hab,2)
    WHERE iso = OLD.iso;
   RETURN OLD;
  END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AAA_Mesures_economiques_Pays_trigger
BEFORE INSERT OR UPDATE OR DELETE ON Mesures_economiques
FOR EACH ROW
EXECUTE PROCEDURE pib_update();


--- Notifications : cas > 10000, r0>1, nombre de vaccin>... , lieux visité != mesure distanciation,


CREATE OR REPLACE FUNCTION covid_notification () RETURNS trigger AS $$
BEGIN

if COALESCE(NEW.CAS,0) > 10000 then
RAISE NOTICE 'Nouveau cas passe 10000'; End if;

if COALESCE(NEW.r0,0) > 1 then
RAISE NOTICE 'R0 dépasse 1'; End if;

if COALESCE(NEW.deces,0) > 1000 then
RAISE NOTICE 'Nouveau deces dépasse 1000'; End if;

if COALESCE(NEW.tests,0) > 10000 then
RAISE NOTICE 'Nouveau test dépasse 10000'; End if;

if COALESCE(NEW.vacc,0) > 1000 then
RAISE NOTICE 'Nouvelle vaccination dépasse 1000'; End if;
RETURN NEW;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER covid_notification_trigger
AFTER INSERT OR UPDATE ON Statistiques_covid
FOR EACH ROW
EXECUTE PROCEDURE covid_notification();


CREATE OR REPLACE FUNCTION lieux_visites_notification()
RETURNS trigger AS $$
BEGIN
  if (COALESCE(NEW.travail,0) > 0 AND
  (SELECT teletra FROM Mesures_distanciations
  WHERE date=NEW.date AND iso=NEW.iso) = 3)
  then
  RAISE NOTICE 'Les gens ne respectent pas les mesures de téléravail'; End if;

  if ((COALESCE(NEW.resid,0) < 0 OR COALESCE(NEW.dist,0) >0 )AND
  (SELECT conf FROM Mesures_distanciations
  WHERE date=NEW.date AND iso=NEW.iso) = 3)
  then
  RAISE NOTICE 'Les gens ne respectent pas les mesure de confinement'; End if;

  if ((COALESCE(NEW.transp,0) >0 )AND
  (SELECT traffic FROM Mesures_distanciations
  WHERE date=NEW.date AND iso=NEW.iso) = 2)
  then
  RAISE NOTICE 'Les gens ne respectent pas les restrictions de déplacement'; End if;
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER lieux_visites_notification_trigger
AFTER INSERT OR UPDATE ON Statistiques_lieux_visites
FOR EACH ROW
EXECUTE PROCEDURE lieux_visites_notification();

-----

CREATE OR REPLACE FUNCTION Mesures_distanciations_notification() RETURNS trigger  AS $$
BEGIN

  if ( COALESCE(NEW.teletra,0) = 3 AND
  (SELECT travail FROM Statistiques_lieux_visites
  WHERE date=NEW.date AND iso = NEW.iso) >0)
  then
  RAISE NOTICE 'Les gens ne respectent pas les mesures de téléravail';
  End if;

  if (COALESCE(NEW.conf,0) = 3 AND
  ((SELECT resid FROM Statistiques_lieux_visites
  WHERE date=NEW.date AND iso = NEW.iso) <0
  or (SELECT dist FROM Statistiques_lieux_visites
  WHERE date=NEW.date AND iso = NEW.iso) >0))
  then
  RAISE NOTICE 'Les gens ne respectent pas les mesure de confinement';
  End if;

  if (COALESCE(NEW.traffic,0) = 2 AND
  (SELECT transp FROM Statistiques_lieux_visites
  WHERE date=NEW.date AND iso = NEW.iso) >0)
  then
  RAISE NOTICE 'Les gens ne respectent pas les restrictions de déplacement';
  End if;
  RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER Mesures_distanciations_notification_trigger
AFTER INSERT OR UPDATE ON Mesures_distanciations
FOR EACH ROW
EXECUTE PROCEDURE Mesures_distanciations_notification();
