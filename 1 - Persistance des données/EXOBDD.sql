/* PAPYRUS BDD 

DROP DATABASE papyrus;

CREATE DATABASE papyrus;

USE papyrus;

CREATE TABLE `fournis` (
  `numfou` int NOT NULL,
  `nomfou` varchar(25) NOT NULL,
  `ruefou` varchar(50) NOT NULL,
  `posfou` char(5) NOT NULL,
  `vilfou` varchar(30) NOT NULL,
  `confou` varchar(15) NOT NULL,
  `satisf` tinyint(4) DEFAULT NULL, 
  CHECK (`satisf` >=0 AND `satisf` <=10),
  PRIMARY KEY (`numfou`)
);

INSERT INTO `fournis` (`numfou`, `nomfou`, `ruefou`, `posfou`, `vilfou`, `confou`, `satisf`) VALUES
	(120, 'GROBRIGAN', '20 rue du papier', '92200', 'papercity', 'Georges', 8),
	(540, 'ECLIPSE', '53 rue laisse flotter les rubans', '78250', 'Bugbugville', 'Nestor', 7),
	(8700, 'MEDICIS', '120 rue des plantes', '75014', 'Paris', 'Lison', 0),
	(9120, 'DISCOBOL', '11 rue des sports', '85100', 'La Roche sur Yon', 'Hercule', 8),
	(9150, 'DEPANPAP', '26 avenue des locomotives', '59987', 'Coroncountry', 'Pollux', 5),
	(9180, 'HURRYTAPE', '68 boulevard des octets', '4044', 'Dumpville', 'Track', 0);

CREATE TABLE `produit` (
  `codart` char(4) NOT NULL,
  `libart` varchar(30) NOT NULL,
  `stkale` int(11) NOT NULL,
  `stkphy` int(11) NOT NULL,
  `qteann` int(11) NOT NULL,
  `unimes` char(5) NOT NULL,
  PRIMARY KEY (`codart`)
) ;


INSERT INTO `produit` (`codart`, `libart`, `stkale`, `stkphy`, `qteann`, `unimes`) VALUES
	('B001', 'Bande magnétique 1200', 20, 87, 240, 'unite'),
	('B002', 'Bande magnétique 6250', 20, 12, 410, 'unite'),
	('D035', 'CD R slim 80 mm', 40, 42, 150, 'B010'),
	('D050', 'CD R-W 80mm', 50, 4, 0, 'B010'),
	('I100', 'Papier 1 ex continu', 100, 557, 3500, 'B1000'),
	('I105', 'Papier 2 ex continu', 75, 5, 2300, 'B1000'),
	('I108', 'Papier 3 ex continu', 200, 557, 3500, 'B500'),
	('I110', 'Papier 4 ex continu', 10, 12, 63, 'B400'),
	('P220', 'Pré-imprimé commande', 500, 2500, 24500, 'B500'),
	('P230', 'Pré-imprimé facture', 500, 250, 12500, 'B500'),
	('P240', 'Pré-imprimé bulletin paie', 500, 3000, 6250, 'B500'),
	('P250', 'Pré-imprimé bon livraison', 500, 2500, 24500, 'B500'),
	('P270', 'Pré-imprimé bon fabrication', 500, 2500, 24500, 'B500'),
	('R080', 'ruban Epson 850', 10, 2, 120, 'unite'),
	('R132', 'ruban impl 1200 lignes', 25, 200, 182, 'unite');



CREATE TABLE `entcom` (
  `numcom` int(11) NOT NULL AUTO_INCREMENT,
  `obscom` varchar(50) DEFAULT NULL,
  `datcom` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `numfou` int(11) DEFAULT NULL,
  PRIMARY KEY (`numcom`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`)
);


INSERT INTO `entcom` (`numcom`, `obscom`, `datcom`, `numfou`) VALUES
	(70010, '', '2018-04-23 15:59:51', 120),
	(70011, 'Commande urgente', '2018-04-23 15:59:51', 540),
	(70020, '', '2018-04-23 15:59:51', 9120),
	(70025, 'Commande urgente', '2018-04-23 15:59:51', 9150),
	(70210, 'Commande cadencée', '2018-04-23 15:59:51', 120),
	(70250, 'Commande cadencée', '2018-04-23 15:59:51', 8700),
	(70300, '', '2018-04-23 15:59:51', 9120),
	(70620, '', '2018-04-23 15:59:51', 540),
	(70625, '', '2018-04-23 15:59:51', 120),
	(70629, '', '2018-04-23 15:59:51', 9180);



CREATE TABLE `ligcom` (
  `numcom` int(11) NOT NULL,
  `numlig` tinyint(4) NOT NULL,
  `codart` char(4) NOT NULL,
  `qtecde` int(11) NOT NULL,
  `priuni` decimal(5,0) NOT NULL,
  `qteliv` int(11) DEFAULT NULL,
  `derliv` date NOT NULL,
  PRIMARY KEY (`numcom`,`numlig`),
  KEY `codart` (`codart`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`numcom`) REFERENCES `entcom` (`numcom`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
);


INSERT INTO `ligcom` (`numcom`, `numlig`, `codart`, `qtecde`, `priuni`, `qteliv`, `derliv`) VALUES
	(70010, 1, 'I100', 3000, 470, 3000, '2007-03-15'),
	(70010, 2, 'I105', 2000, 485, 2000, '2007-07-05'),
	(70010, 3, 'I108', 1000, 680, 1000, '2007-08-20'),
	(70010, 4, 'D035', 200, 40, 250, '2007-02-20'),
	(70010, 5, 'P220', 6000, 3500, 6000, '2007-03-31'),
	(70010, 6, 'P240', 6000, 2000, 2000, '2007-03-31'),
	(70011, 1, 'I105', 1000, 600, 1000, '2007-05-16'),
	(70011, 2, 'P220', 10000, 3500, 10000, '2007-08-31'),
	(70020, 1, 'B001', 200, 140, 0, '2007-12-31'),
	(70020, 2, 'B002', 200, 140, 0, '2007-12-31'),
	(70025, 1, 'I100', 1000, 590, 1000, '2007-05-15'),
	(70025, 2, 'I105', 500, 590, 500, '2007-03-15'),
	(70210, 1, 'I100', 1000, 470, 1000, '2007-07-15'),
	(70250, 1, 'P230', 15000, 4900, 12000, '2007-12-15'),
	(70250, 2, 'P220', 10000, 3350, 10000, '2007-11-10'),
	(70300, 1, 'I100', 50, 790, 50, '2007-10-31'),
	(70620, 1, 'I105', 200, 600, 200, '2007-11-01'),
	(70625, 1, 'I100', 1000, 470, 1000, '2007-10-15'),
	(70625, 2, 'P220', 10000, 3500, 10000, '2007-10-31'),
	(70629, 1, 'B001', 200, 140, 0, '2007-12-31'),
	(70629, 2, 'B002', 200, 140, 0, '2007-12-31');



CREATE TABLE `vente` (
  `codart` char(4) NOT NULL,
  `numfou` int(11) NOT NULL,
  `delliv` smallint(6) NOT NULL,
  `qte1` int(11) NOT NULL,
  `prix1` decimal(5,0) NOT NULL,
  `qte2` int(11) DEFAULT NULL,
  `prix2` decimal(5,0) DEFAULT NULL,
  `qte3` int(11) DEFAULT NULL,
  `prix3` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`codart`,`numfou`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
) ;


INSERT INTO `vente` (`codart`, `numfou`, `delliv`, `qte1`, `prix1`, `qte2`, `prix2`, `qte3`, `prix3`) VALUES
	('B001', 8700, 15, 0, 150, 50, 145, 100, 140),
	('B002', 8700, 15, 0, 210, 50, 200, 100, 185),
	('D035', 120, 0, 0, 40, 0, 0, 0, 0),
	('D035', 9120, 5, 0, 40, 100, 30, 0, 0),
	('I100', 120, 90, 0, 700, 50, 600, 120, 500),
	('I100', 540, 70, 0, 710, 60, 630, 100, 600),
	('I100', 9120, 60, 0, 800, 70, 600, 90, 500),
	('I100', 9150, 90, 0, 650, 90, 600, 200, 590),
	('I100', 9180, 30, 0, 720, 50, 670, 100, 490),
	('I105', 120, 90, 10, 705, 50, 630, 120, 500),
	('I105', 540, 70, 0, 810, 60, 645, 100, 600),
	('I105', 8700, 30, 0, 720, 50, 670, 100, 510),
	('I105', 9120, 60, 0, 920, 70, 800, 90, 700),
	('I105', 9150, 90, 0, 685, 90, 600, 200, 590),
	('I108', 120, 90, 5, 795, 30, 720, 100, 680),
	('I108', 9120, 60, 0, 920, 70, 820, 100, 780),
	('I110', 9120, 60, 0, 950, 70, 850, 90, 790),
	('I110', 9180, 90, 0, 900, 70, 870, 90, 835),
	('P220', 120, 15, 0, 3700, 100, 3500, 0, 0),
	('P220', 8700, 20, 50, 3500, 100, 3350, 0, 0),
	('P230', 120, 30, 0, 5200, 100, 5000, 0, 0),
	('P230', 8700, 60, 0, 5000, 50, 4900, 0, 0),
	('P240', 120, 15, 0, 2200, 100, 2000, 0, 0),
	('P250', 120, 30, 0, 1500, 100, 1400, 500, 1200),
	('P250', 9120, 30, 0, 1500, 100, 1400, 500, 1200),
	('R080', 9120, 10, 0, 120, 100, 100, 0, 0),
	('R132', 9120, 5, 0, 275, 0, 0, 0, 0);

    */



--REQUETTES BDD EXO  Formaliser  des requêtes SQL ncode
 

--ex 8 _8. Afficher le nom et le prénom des employés dont le nom est
--alphabétiquement antérieur au prénom.

SELECT * FROM `COMMERCIAL` WHERE nom<prenom; 



--ex 8 _9. Afficher le nom, le salaire et le numéro du département des employés
--dont le titre est « Représentant », le numéro de département est 35 et
--le salaire est supérieur à 20000.

SELECT * FROM `PRODUIT` join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat WHERE `prxHT`>=100 and PRODUIT.idCat = 4; 



--ex 8 _10.Afficher le nom, le titre et le salaire des employés dont le titre est
--« Représentant » ou dont le titre est « Président ».

SELECT * FROM `PRODUIT` join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat WHERE `prxHT`>=100 and (PRODUIT.idCat = 4 OR PRODUIT.idCat=12); 

/*ex 8 _13.Afficher le nom, et le salaire des employés dont le salaire est compris
entre 20000 et 30000.*/

SELECT * FROM `PRODUIT` 
join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat
WHERE `prxHT`>=50  and prxHT<=100

/*OU */

SELECT * FROM `PRODUIT` join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat WHERE prxHT BETWEEN 50 AND 100; 


/*III LES BESOINS D’AFFICHAGE

1. Quelles sont les commandes du fournisseur 09120 ?*/
SELECT * FROM `entcom` WHERE numfou = 09120; 

/*3. Afficher le nombre de commandes fournisseurs passées, et le nombre
de fournisseur concernés.*/

SELECT count(numcom), COUNT(numfou) FROM `ligcom` join vente on vente.codart = ligcom.codart; 

SELECT count(numcom), COUNT(numfou) FROM `ligcom` join vente on vente.codart = ligcom.codart group by numfou; 


/*4. Editer les produits ayant un stock inférieur ou égal au stock d'alerte et
dont la quantité annuelle est inférieur est inférieure à 1000
(informations à fournir : n° produit, libellé produit, stock, stock actuel
d'alerte, quantité annuelle)*/

SELECT * FROM `produit` WHERE stkale>=stkphy and qteann<1000; 

//*5. Quels sont les fournisseurs situés dans les départements 75 78 92 77 ?
L’affichage (département, nom fournisseur) sera effectué par
département décroissant, puis par ordre alphabétique*/

SELECT nomfou, posfou FROM `fournis` WHERE posfou LIKE '75%' or posfou LIKE '78%' OR posfou LIKE '92%' or posfou LIKE '77%' ORDER by posfou desc , nomfou ASC; 

--6. Quelles sont les commandes passées au mois de mars et avril ?

SELECT * FROM `entcom` WHERE MONTH(datcom)= 3 or MONTH(datcom)= 4

/*7. Quelles sont les commandes du jour qui ont des observations
particulières ?*/

 SELECT * FROM entcom WHERE datcom = CURRENT_DATE and obscom != NULL 

--8. Lister le total de chaque commande par total décroissant

SELECT sum(priuni*qtecde) as summ , numcom FROM `ligcom` GROUP by numcom ORDER by summ desc; 


/*9. Lister les commandes dont le total est supérieur à 10 000€ ; on exclura
dans le calcul du total les articles commandés en quantité supérieure
ou égale à 1000.*/


SELECT sum(priuni*`qtecde`) as summ , qtecde, numcom FROM `ligcom` GROUP by numcom HAVING summ>10000 AND qtecde>1000; 

--10. Lister les commandes par nom fournisseur

SELECT * FROM ligcom as l 
JOIN vente as p on p.codart = l.codart
JOIN fournis as f on f.numfou = p.numfou
ORDER by f.numfou asc 


//*11. Sortir les produits des commandes ayant le mot "urgent' en
observation?*/

SELECT * FROM `entcom` WHERE obscom like '%urgent%'; 



--12. Lister le nom des fournisseurs susceptibles de livrer au moins un article

SELECT *  FROm fournis  as f
JOIN entcom as e on e.`numfou` = f.numfou
join ligcom as l on e.numcom = l.numcom
where qteliv > 0



/*13. Coder de 2 manières différentes la requête suivante
Lister les commandes (Numéro et date) dont le fournisseur est celui de
la commande 70210 :*/

SELECT e.numcom,`datcom` , f.numfou FROm fournis as f JOIN entcom as e on e.`numfou` = f.numfou join ligcom as l on e.numcom = l.numcom where l.numcom = 70210; 


/*
VIEWS 


    1. Afficher la liste des hôtels avec leur station */

       create view v_hotelStation
       AS 
       SELECT * FROM `hotel` 
       left join station on station.sta_id = hotel.hot_sta_id

   -- 2. Afficher la liste des chambres et leur hôtel 
       
create view v_hotelChambre
AS 
SELECT * FROM `hotel` 
left join chambre on chambre.cha_hot_id = hotel.hot_sta_id

  --  3. Afficher la liste des réservations avec le nom des clients 

create view v_clientResa
AS 
SELECT * FROM reservation
left join client on client.cli_id = reservation.res_cli_id

 --   4. Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station 

create VIEW v_chambreHotelStation
AS
SELECT chambre.cha_numero,hot_nom, station.sta_nom FROM hotel
left join station on station.sta_id = hotel.hot_sta_id
right join chambre on chambre.cha_hot_id = hotel.hot_id
GROUP BY chambre.cha_id

  --  5. Afficher les réservations avec le nom du client et le nom de l’hôtel 

CREATE VIEW v_resaclienthotel
as
SELECT DISTINCT reservation.res_date , reservation.res_date_debut, reservation.res_date_fin, client.cli_nom, client.cli_ville, hotel.hot_nom FROM reservation
left join client on client.cli_id = reservation.res_cli_id
right join chambre on reservation.res_cha_id = chambre.cha_id
JOIN hotel on chambre.cha_hot_id = hotel.hot_id
GROUP BY reservation.res_id


/*PROCEDURES
Exercice 1 : création d'une procédure stockée sans paramètre
    • Créez la procédure stockée Lst_fournis correspondant à la requête n°2 afficher le code des fournisseurs pour lesquels une commande a été passée. 
    • Exécutez la pour vérifier qu’elle fonctionne conformément à votre attente. 
    • Exécutez la commande SQL suivante pour obtenir des informations sur cette procédure stockée : */



DELIMITER |
create PROCEDURE nbrComByFou()
BEGIN
SELECT count(numcom), COUNT(numfou) FROM `ligcom` join vente on vente.codart = ligcom.codart group by numfou; 
END |
DELIMITER ;

/*
Exercice 2 : création d'une procédure stockée avec un paramètre en entrée
Créer la procédure stockée Lst_Commandes, qui liste les commandes ayant un libellé particulier dans le champ obscom (cette requête sera construite à partir de la requête n°11). 
*/
DELIMITER |
CREATE PROCEDURE Lst_Commandes(in mot varchar(50))
BEGIN
declare motForma varchar(50);
set motForma = concat('%',mot,'%');
SELECT * FROM `entcom` WHERE obscom like motForma; 
END |
DELIMITER ;

call Lst_Commandes('urgent');
/*
Exercice 3 : création d'une procédure stockée avec plusieurs paramètres
Créer la procédure stockée CA_ Fournisseur, qui pour un code fournisseur et une année entrée en paramètre, calcule et restitue le CA potentiel de ce fournisseur pour l'année souhaitée (cette requête sera construite à partir de la requête n°19). 
On exécutera la requête que si le code fournisseur est valide, c'est-à-dire dans la table FOURNIS. 
Testez cette procédure avec différentes valeurs des paramètres. */


DELIMITER |
CREATE PROCEDURE CA_Fournisseur(in annee varchar(4),in codeFour varchar(50))
BEGIN
IF(SELECT numfou from fournis where numfou = codeFour) 
THEN
SELECT nomfou , sum(priuni*qteliv),year(datcom) FROM `ligcom` 
JOIN entcom on entcom.numcom = ligcom.numcom
JOIN fournis on entcom.numfou = fournis.numfou
where year(datcom) = annee AND fournis.numfou = codeFour;
ELSE 
SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Fournisseur Invalide';
END IF;
END |
DELIMITER ;

TRIGGERS

DELIMITER |
CREATE TRIGGER insert_station AFTER INSERT ON station
    FOR EACH ROW
    BEGIN
    DECLARE altitude INT;
   SET altitude = NEW.sta_altitude;
   IF altitude<1000 THEN
    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion altitude !';
        END IF;
END | 
DELIMITER ;


/*

Exercices
A partir de l'exemple suivant, créez les déclencheurs suivants :
    1. modif_reservation : interdire la modification des réservations (on autorise l'ajout et la suppression). */
DELIMITER |
CREATE TRIGGER modif_reservation AFTER UPDATE ON reservation
    FOR EACH ROW
    BEGIN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Impossible de modifier la table ';
END |
DELIMITER ;

  --  2. insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations. 

DELIMITER |
CREATE TRIGGER testinsert after INSERT ON reservation
for EACH ROW
BEGIN 

DECLARE hotNom varchar(80);
DECLARE cptNom int;
SET hotNom = (SELECT hotel.hot_nom FROM hotel JOIN chambre ON hotel.hot_id = chambre.cha_hot_id JOIN reservation ON chambre.cha_id = reservation.res_cha_id WHERE res_id  = NEW.res_id LIMIT 1);
set cptNom = (select COUNT(hot_nom) FROM `v_resaclienthotel`where v_resaclienthotel.hot_nom = hotNom LIMIT 1);

IF cptNom>9
THEN 
SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion des reservations !'; 
END IF;
END |
DELIMITER ;

   -- 3. insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations. 

DROP TRIGGER IF EXISTS `refusReservation`;CREATE DEFINER=`admin`@`localhost` TRIGGER `refusReservation` AFTER INSERT ON `reservation` FOR EACH ROW BEGIN DECLARE clientNom int; DECLARE cptNom int; SET clientNom = (SELECT client.cli_id FROM client JOIN reservation ON reservation.res_cli_id = client.cli_id WHERE client.cli_id = NEW.res_cli_id LIMIT 1); set cptNom = (select COUNT(reservation.res_cli_id) FROM reservation where reservation.res_cli_id = clientNom LIMIT 1); IF cptNom>3 THEN SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'REFUS D\'INSERTION, ce client a deja loué 3 fois'; END IF; END 


    --4. insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, si ce total est supérieur à 50, on interdit l'insertion de la chambre. 
DELIMITER |
CREATE TRIGGER MaxChambres after INSERT ON chambre
for EACH ROW
BEGIN 
DECLARE CptTotalChambre INT;
SET CptTotalChambre=(SELECT sum(chambre.cha_capacite) FROM chambre WHERE chambre.cha_hot_id = NEW.cha_hot_id LIMIT 1);
IF CptTotalChambre>50
THEN 
SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'REFUS AJOUT : capacité maximale atteinte'; 
END IF;
END |
DELIMITER ;


--TRIGGERS ON CP 
/*Avoir un trigger qui met à jour le total de la commande a l’ajout d’un produits
Travail à réaliser
    1. Mettez en place ce trigger, puis ajoutez un produit dans une commande, vérifiez que le champ total est bien mis à jour.*/
       
CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;

   -- 2. on ajoute des produits dans la commande, les modifications ou suppressions ne permettent pas de recalculer le total. Modifiez le code ci-dessus pour faire en sorte que la modification ou la suppression de produit recalcul le total de la commande.

CREATE TRIGGER update_total AFTER update ON lignedecommande
    FOR EACH ROW
    BEGINREQUETTES BDD EXO  Formaliser des requêtes SQL ncode
 

/*ex 8 _8. Afficher le nom et le prénom des employés dont le nom est
alphabétiquement antérieur au prénom.*/

SELECT * FROM `COMMERCIAL` WHERE nom<prenom; 



/*ex 8 _9. Afficher le nom, le salaire et le numéro du département des employés
dont le titre est « Représentant », le numéro de département est 35 et
le salaire est supérieur à 20000.*/

SELECT * FROM `PRODUIT` join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat WHERE `prxHT`>=100 and PRODUIT.idCat = 4; 



/*ex 8 _10.Afficher le nom, le titre et le salaire des employés dont le titre est
« Représentant » ou dont le titre est « Président ».*/

SELECT * FROM `PRODUIT` join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat WHERE `prxHT`>=100 and (PRODUIT.idCat = 4 OR PRODUIT.idCat=12); 

/*ex 8 _13.Afficher le nom, et le salaire des employés dont le salaire est compris
entre 20000 et 30000.*/

SELECT * FROM `PRODUIT` 
join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat
WHERE `prxHT`>=50  and prxHT<=100

--OU 

SELECT * FROM `PRODUIT` join CATEGORIE on CATEGORIE.idCat = PRODUIT.idCat WHERE prxHT BETWEEN 50 AND 100; 


/*III LES BESOINS D’AFFICHAGE

1. Quelles sont les commandes du fournisseur 09120 ?*/
SELECT * FROM `entcom` WHERE numfou = 09120; 

/*3. Afficher le nombre de commandes fournisseurs passées, et le nombre
de fournisseur concernés.*/

SELECT count(numcom), COUNT(numfou) FROM `ligcom` join vente on vente.codart = ligcom.codart; 

SELECT count(numcom), COUNT(numfou) FROM `ligcom` join vente on vente.codart = ligcom.codart group by numfou; 


/*4. Editer les produits ayant un stock inférieur ou égal au stock d'alerte et
dont la quantité annuelle est inférieur est inférieure à 1000
(informations à fournir : n° produit, libellé produit, stock, stock actuel
d'alerte, quantité annuelle)*/

SELECT * FROM `produit` WHERE stkale>=stkphy and qteann<1000; 

/*5. Quels sont les fournisseurs situés dans les départements 75 78 92 77 ?
L’affichage (département, nom fournisseur) sera effectué par
département décroissant, puis par ordre alphabétique*/

SELECT nomfou, posfou FROM `fournis` WHERE posfou LIKE '75%' or posfou LIKE '78%' OR posfou LIKE '92%' or posfou LIKE '77%' ORDER by posfou desc , nomfou ASC; 

--6. Quelles sont les commandes passées au mois de mars et avril ?

SELECT * FROM `entcom` WHERE MONTH(datcom)= 3 or MONTH(datcom)= 4

/*7. Quelles sont les commandes du jour qui ont des observations
particulières ?*/

 SELECT * FROM entcom WHERE datcom = CURRENT_DATE and obscom != NULL 

--8. Lister le total de chaque commande par total décroissant

SELECT sum(priuni*qtecde) as summ , numcom FROM `ligcom` GROUP by numcom ORDER by summ desc; 


/*9. Lister les commandes dont le total est supérieur à 10 000€ ; on exclura
dans le calcul du total les articles commandés en quantité supérieure
ou égale à 1000.*/


SELECT sum(priuni*`qtecde`) as summ , qtecde, numcom FROM `ligcom` GROUP by numcom HAVING summ>10000 AND qtecde>1000; 

--10. Lister les commandes par nom fournisseur

SELECT * FROM ligcom as l 
JOIN vente as p on p.codart = l.codart
JOIN fournis as f on f.numfou = p.numfou
ORDER by f.numfou asc 


/*11. Sortir les produits des commandes ayant le mot "urgent' en
observation?*/

SELECT * FROM `entcom` WHERE obscom like '%urgent%'; 



--12. Lister le nom des fournisseurs susceptibles de livrer au moins un article

SELECT *  FROm fournis  as f
JOIN entcom as e on e.`numfou` = f.numfou
join ligcom as l on e.numcom = l.numcom
where qteliv > 0



/*13. Coder de 2 manières différentes la requête suivante
Lister les commandes (Numéro et date) dont le fournisseur est celui de
la commande 70210 :*/

SELECT e.numcom,`datcom` , f.numfou FROm fournis as f JOIN entcom as e on e.`numfou` = f.numfou join ligcom as l on e.numcom = l.numcom where l.numcom = 70210; 



/*14. Dans les articles susceptibles d’être vendus, lister les articles moins
chers (basés sur Prix1) que le moins cher des rubans (article dont le
premier caractère commence par R). On affichera le libellé de l’article
et prix1*/

SELECT p.codart FROM `produit`as p
right join vente as v on v.codart = p.codart
where p.codart like "R%" where prix1 > ??
/* Le produit ref like "R%" n'as pas de prix*/


/*
VIEWS 


    1. Afficher la liste des hôtels avec leur station */
       create view v_hotelStation
       AS 
       SELECT * FROM `hotel` 
       left join station on station.sta_id = hotel.hot_sta_id

   -- 2. Afficher la liste des chambres et leur hôtel 
       
create view v_hotelChambre
AS 
SELECT * FROM `hotel` 
left join chambre on chambre.cha_hot_id = hotel.hot_sta_id

 --   3. Afficher la liste des réservations avec le nom des clients 

create view v_clientResa
AS 
SELECT * FROM reservation
left join client on client.cli_id = reservation.res_cli_id

 --   4. Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station 

create VIEW v_chambreHotelStation
AS
SELECT chambre.cha_numero,hot_nom, station.sta_nom FROM hotel
left join station on station.sta_id = hotel.hot_sta_id
right join chambre on chambre.cha_hot_id = hotel.hot_id
GROUP BY chambre.cha_id

   -- 5. Afficher les réservations avec le nom du client et le nom de l’hôtel 

CREATE VIEW v_resaclienthotel
as
SELECT DISTINCT reservation.res_date , reservation.res_date_debut, reservation.res_date_fin, client.cli_nom, client.cli_ville, hotel.hot_nom FROM reservation
left join client on client.cli_id = reservation.res_cli_id
right join chambre on reservation.res_cha_id = chambre.cha_id
JOIN hotel on chambre.cha_hot_id = hotel.hot_id
GROUP BY reservation.res_id

/*
PROCEDURES
Exercice 1 : création d'une procédure stockée sans paramètre
    • Créez la procédure stockée Lst_fournis correspondant à la requête n°2 afficher le code des fournisseurs pour lesquels une commande a été passée. 
    • Exécutez la pour vérifier qu’elle fonctionne conformément à votre attente. 
    • Exécutez la commande SQL suivante pour obtenir des informations sur cette procédure stockée : 

*/

DELIMITER |
create PROCEDURE nbrComByFou()
BEGIN
SELECT count(numcom), COUNT(numfou) FROM `ligcom` join vente on vente.codart = ligcom.codart group by numfou; 
END |
DELIMITER ;

/*
Exercice 2 : création d'une procédure stockée avec un paramètre en entrée
Créer la procédure stockée Lst_Commandes, qui liste les commandes ayant un libellé particulier dans le champ obscom (cette requête sera construite à partir de la requête n°11). 
*/

DELIMITER |
CREATE PROCEDURE Lst_Commandes(in mot varchar(50))
BEGIN
declare motForma varchar(50);
set motForma = concat('%',mot,'%');
SELECT * FROM `entcom` WHERE obscom like motForma; 
END |
DELIMITER ;

call Lst_Commandes('urgent');
/*
Exercice 3 : création d'une procédure stockée avec plusieurs paramètres
Créer la procédure stockée CA_ Fournisseur, qui pour un code fournisseur et une année entrée en paramètre, calcule et restitue le CA potentiel de ce fournisseur pour l'année souhaitée (cette requête sera construite à partir de la requête n°19). 
On exécutera la requête que si le code fournisseur est valide, c'est-à-dire dans la table FOURNIS. 
Testez cette procédure avec différentes valeurs des paramètres. 
*/

DELIMITER |
CREATE PROCEDURE CA_Fournisseur(in annee varchar(4),in codeFour varchar(50))
BEGIN
IF(SELECT numfou from fournis where numfou = codeFour) 
THEN
SELECT nomfou , sum(priuni*qteliv),year(datcom) FROM `ligcom` 
JOIN entcom on entcom.numcom = ligcom.numcom
JOIN fournis on entcom.numfou = fournis.numfou
where year(datcom) = annee AND fournis.numfou = codeFour;
ELSE 
SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Fournisseur Invalide';
END IF;
END |
DELIMITER ;

TRIGGERS

DELIMITER |
CREATE TRIGGER insert_station AFTER INSERT ON station
    FOR EACH ROW
    BEGIN
    DECLARE altitude INT;
   SET altitude = NEW.sta_altitude;
   IF altitude<1000 THEN
    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion altitude !';
        END IF;
END | 
DELIMITER ;


/*
Exercices
A partir de l'exemple suivant, créez les déclencheurs suivants :
    1. modif_reservation : interdire la modification des réservations (on autorise l'ajout et la suppression). */

DELIMITER |
CREATE TRIGGER modif_reservation AFTER UPDATE ON reservation
    FOR EACH ROW
    BEGIN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Impossible de modifier la table ';
END |
DELIMITER ;

    --2. insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations. 

DELIMITER |
CREATE TRIGGER testinsert after INSERT ON reservation
for EACH ROW
BEGIN 

DECLARE hotNom varchar(80);
DECLARE cptNom int;
SET hotNom = (SELECT hotel.hot_nom FROM hotel JOIN chambre ON hotel.hot_id = chambre.cha_hot_id JOIN reservation ON chambre.cha_id = reservation.res_cha_id WHERE res_id  = NEW.res_id LIMIT 1);
set cptNom = (select COUNT(hot_nom) FROM `v_resaclienthotel`where v_resaclienthotel.hot_nom = hotNom LIMIT 1);

IF cptNom>9
THEN 
SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion des reservations !'; 
END IF;
END |
DELIMITER ;

--    3. insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations. 

DROP TRIGGER IF EXISTS `refusReservation`;CREATE DEFINER=`admin`@`localhost` TRIGGER `refusReservation` AFTER INSERT ON `reservation` FOR EACH ROW BEGIN DECLARE clientNom int; DECLARE cptNom int; SET clientNom = (SELECT client.cli_id FROM client JOIN reservation ON reservation.res_cli_id = client.cli_id WHERE client.cli_id = NEW.res_cli_id LIMIT 1); set cptNom = (select COUNT(reservation.res_cli_id) FROM reservation where reservation.res_cli_id = clientNom LIMIT 1); IF cptNom>3 THEN SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'REFUS D INSERTION, ce client a deja loué 3 fois'; END IF; END 


  --  4. insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, si ce total est supérieur à 50, on interdit l'insertion de la chambre. 
DELIMITER |
CREATE TRIGGER MaxChambres after INSERT ON chambre
for EACH ROW
BEGIN 
DECLARE CptTotalChambre INT;
SET CptTotalChambre=(SELECT sum(chambre.cha_capacite) FROM chambre WHERE chambre.cha_hot_id = NEW.cha_hot_id LIMIT 1);
IF CptTotalChambre>50
THEN 
SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'REFUS AJOUT : capacité maximale atteinte'; 
END IF;
END |
DELIMITER ;


/*TRIGGERS ON CP 
Avoir un trigger qui met à jour le total de la commande a l’ajout d’un produits
Travail à réaliser
    1. Mettez en place ce trigger, puis ajoutez un produit dans une commande, vérifiez que le champ total est bien mis à jour.*/
       
CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;

  --  2. on ajoute des produits dans la commande, les modifications ou suppressions ne permettent pas de recalculer le total. Modifiez le code ci-dessus pour faire en sorte que la modification ou la suppression de produit recalcul le total de la commande.

CREATE TRIGGER update_total AFTER update ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;


  --  3. Un champ remise était prévu dans la table commande. Prenez en compte ce champ dans le code de votre trigger.

CREATE TRIGGER del_total AFTER delete ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = old.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;

/*Créer une table ARTICLES_A_COMMANDER avec les colonnes :
    • CODART : Code de l'article, voir la table produit 
    • DATE : date du jour (par défaut) 
    • QTE : à calculer 
Créer un déclencheur UPDATE sur la table produit : lorsque le stock physique devient inférieur ou égal au stock d'alerte, une nouvelle ligne est insérée dans la table ARTICLES_A_COMMANDER. 
Attention, il faut prendre en compte les quantités déjà commandées dans la table ARTICLES_A_COMMANDER .
Pour comprendre le problème :
Soit l'article I120, le stock d'alerte = 5, le stock physique = 20
    1. Nous retirons 15 produits du stock. stock d'alerte = 5, le stock physique = 5, le stock physique n'est pas inférieur au stock d'alerte, on ne fait rien.
    2. Nous retirons 1 produit du stock. stock d'alerte = 5, le stock physique = 4, le stock physique est inférieur au stock d'alerte, nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) = 1
    3. Nous retirons 2 produit du stock. stock d'alerte = 5, le stock physique = 2. le stock physique est inférieur au stock d'alerte, nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) – quantité déjà commandée dans ARTICLES_A_COMMANDER : QTE = (5 - 2) – 1 = 2
*/

DELIMITER |
CREATE TRIGGER commande_urgent AFTER update ON produit
    FOR EACH ROW
BEGIN
        DECLARE prod_id char(4); -- create variable for product id
        DECLARE stkale int; -- create variable for stock alerte
        DECLARE stkphy int; -- create variable for physical stock
     	DECLARE missing_nbr1 int;
        DECLARE missing_nbr2 int;
        DECLARE qte int;

        SET prod_id = NEW.codart ; -- id of product after update 
        set qte = (select sum(ARTICLES_A_COMMANDER.qte) from ARTICLES_A_COMMANDER where ARTICLES_A_COMMANDER.codart= NEW.codart);
        SET stkale = NEW.stkale ; -- stkale of product after update 
        SET stkphy = NEW.stkphy ; -- stkphy of product after update 
        SET missing_nbr1 =  stkale - (stkphy + qte) ;  -- combien a commander ? 
        SET missing_nbr2 =  ( stkale - stkphy ) ;  -- combien a commander ?      
            IF stkphy < stkale -- SI LE STOCK PHYSIQUE EST PLUS BAS QUE LE STOCK ALERTE 
            THEN 
                IF (SELECT COUNT(ARTICLES_A_COMMANDER.idCommande) from ARTICLES_A_COMMANDER where codart = prod_id ) != 0 -- S'il existe déjà une commande ? 
            THEN    
                    INSERT INTO ARTICLES_A_COMMANDER (ARTICLES_A_COMMANDER.codart, ARTICLES_A_COMMANDER.qte) values ( prod_id, missing_nbr1); -- insertion de la commande 
                ELSE 
     INSERT INTO ARTICLES_A_COMMANDER (ARTICLES_A_COMMANDER.codart, ARTICLES_A_COMMANDER.qte) values ( prod_id, missing_nbr2); -- insertion de la commande 
                END IF;  
            END IF;
       END |
DELIMITER ;

        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;


  --  3. Un champ remise était prévu dans la table commande. Prenez en compte ce champ dans le code de votre trigger.
CREATE TRIGGER del_total AFTER delete ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = old.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END;

/*Créer une table ARTICLES_A_COMMANDER avec les colonnes :
    • CODART : Code de l'article, voir la table produit 
    • DATE : date du jour (par défaut) 
    • QTE : à calculer 
Créer un déclencheur UPDATE sur la table produit : lorsque le stock physique devient inférieur ou égal au stock d'alerte, une nouvelle ligne est insérée dans la table ARTICLES_A_COMMANDER. 
Attention, il faut prendre en compte les quantités déjà commandées dans la table ARTICLES_A_COMMANDER .
Pour comprendre le problème :
Soit l'article I120, le stock d'alerte = 5, le stock physique = 20
    1. Nous retirons 15 produits du stock. stock d'alerte = 5, le stock physique = 5, le stock physique n'est pas inférieur au stock d'alerte, on ne fait rien.
    2. Nous retirons 1 produit du stock. stock d'alerte = 5, le stock physique = 4, le stock physique est inférieur au stock d'alerte, nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) = 1
    3. Nous retirons 2 produit du stock. stock d'alerte = 5, le stock physique = 2. le stock physique est inférieur au stock d'alerte, nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) – quantité déjà commandée dans ARTICLES_A_COMMANDER : QTE = (5 - 2) – 1 = 2
*/

DELIMITER |
CREATE TRIGGER commande_urgent AFTER update ON produit
    FOR EACH ROW
BEGIN
        DECLARE prod_id char(4); -- create variable for product id
        DECLARE stkale int; -- create variable for stock alerte
        DECLARE stkphy int; -- create variable for physical stock
     	DECLARE missing_nbr1 int;
        DECLARE missing_nbr2 int;
        DECLARE qte int;

        SET prod_id = NEW.codart ; -- id of product after update 
        set qte = (select sum(ARTICLES_A_COMMANDER.qte) from ARTICLES_A_COMMANDER where ARTICLES_A_COMMANDER.codart= NEW.codart);
        SET stkale = NEW.stkale ; -- stkale of product after update 
        SET stkphy = NEW.stkphy ; -- stkphy of product after update 
        SET missing_nbr1 =  stkale - (stkphy + qte) ;  -- combien a commander ? 
        SET missing_nbr2 =  ( stkale - stkphy ) ;  -- combien a commander ?      
            IF stkphy < stkale -- SI LE STOCK PHYSIQUE EST PLUS BAS QUE LE STOCK ALERTE 
            THEN 
                IF (SELECT COUNT(ARTICLES_A_COMMANDER.idCommande) from ARTICLES_A_COMMANDER where codart = prod_id ) != 0 -- S'il existe déjà une commande ? 
            THEN    
                    INSERT INTO ARTICLES_A_COMMANDER (ARTICLES_A_COMMANDER.codart, ARTICLES_A_COMMANDER.qte) values ( prod_id, missing_nbr1); -- insertion de la commande 
                ELSE 
     INSERT INTO ARTICLES_A_COMMANDER (ARTICLES_A_COMMANDER.codart, ARTICLES_A_COMMANDER.qte) values ( prod_id, missing_nbr2); -- insertion de la commande 
                END IF;  
            END IF;
       END |
DELIMITER ;
