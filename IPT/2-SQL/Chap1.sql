-- Pour le 03/06 : 

-- INE des étudiants de PCSI, (utiliser la table Classes, et sa colonne fililère), 
-- Puis les noms des élèves de PCSI


SELECT INE
    FROM Classes JOIN Parcours ON Classes.classe=Parcours.classe
    WHERE filière = "PCSI"



SELECT Etudiants.INE,nom,prénom
    FROM Classes JOIN Parcours ON Classes.classe=Parcours.classe
                 JOIN Etudiants ON Etudiants.INE = Parcours.INE
    WHERE filière = "PCSI"
      AND Parcours.année=2019


-- Trions le resultat par classe


SELECT Etudiants.INE,nom,prénom
    FROM Classes JOIN Parcours ON Classes.classe=Parcours.classe
                 JOIN Etudiants ON Etudiants.INE = Parcours.INE
    WHERE filière = "PCSI"
      AND Parcours.année=2019
ORDER BY Classes.classe, prénom DESC


-- Pour le 10/06

-- Les pays d'Afrique : 

SELECT name
FROM country
WHERE continent = "Africa"


-- Le nombre d'habitants de Buenos Aires

SELECT population
FROM city
WHERE  name = "Buenos Aires"


-- Le nombre de pays où on parle français.

SELECT countrycode
FROM countrylanguage
WHERE  language = "French"

SELECT COUNT(*)
FROM countrylanguage
WHERE  language = "French"

SELECT name
FROM country join countrylanguage on country.code=countrylanguage.countrycode
WHERE  language = "French"

-- Pays où au moins la moitié de la population parle français

SELECT percentage,name
FROM country join countrylanguage on country.code=countrylanguage.countrycode
WHERE  language = "French" AND percentage>50

-- Pays où le français est la langue officiel

SELECT name
FROM country join countrylanguage on country.code=countrylanguage.countrycode
WHERE  language = "French" AND isOfficial="T"


-- Cours : 



SELECT nom,prénom
    From Etudiants JOIN parcours ON Etudiants.INE = Parcours.INE
    WHERE année=2017 AND classe=801




SELECT Lycées.nom,commune, Etudiants.nom
    From Etudiants JOIN parcours Parcours2018 ON Etudiants.INE = Parcours2018.INE
                   JOIN lycée ON Lycées.code = parcours2018.code_étab
                   JOIN Parcours Parcours2019 ON Parcours2018.INE=Parcours2019.INE
    WHERE Parcours2018.année=2018
      AND Parcours2019.année=2019
      AND Parcours2019.classe=801


--Regroupement :

--Deux étapes
--1) Le logiciel de BDD rassemble toutes les lignes 
--qui ont la même valeur selon une certaine colonne


SELECT
    FROM Classes, COUNT(*) as nb_classe, SUM(classe), AVG(classe)

    GROUP BY année  --Ceci crée deux groupe:
                    -- Les classes de première année, et les classe de deuxième année


--Nombre d'élèves dans chaque classe cette année :

--Table(s) à utiliser : Parcours


SELECT classe,count(*) AS nb_élèves
    FROM Parcours
    -- Ne gardons que les élèves entrés en 2019 --
    WHERE année=2019
    GROUP BY classe


-- Nombre de lycée par département


SELECT département, COUNT(*) as nb_lycées
    FROM Lycée
    GROUP BY lycées.département


-- Nombre  d'élèves en 801 par année
-- Table(s) utile(s) : Parcours
-- Regroupement : selon l'année

SELECT année, COUNT(*) as nombre_d_eleve_en_801
    FROM Parcours
    WHERE classe=801
    GROUP BY année

-- Classes ayant au moins 30 élèves en 2019 ?

SELECT classe, COUNT(*)
    FROM Parcours
    WHERE année=2019        -- Condition sur les lignes
    GROUP BY classe
    HAVING COUNT(*) > 30    -- Condition sur les regroupements
                            -- S'exprime à l'aide de fonctions d'agrégation

-- Nb de lycées d'où viennent au moins 3 élèves

SELECT Lycées.nom, Lycée.commune, code_étab, COUNT(*) AS nb_élèves
    FROM Parcours JOIN Lycées ON Parcours.code_étab = Lycées.code
    WHERE année=2018
    GROUP BY code_étab
    HAVING COUNT(*)>3

-- Sous-requêtes :
-- Les résulats d'une requête est considérer comme une nouvelle table :
-- On peut donc y faire une nouvelle requête



SELECT max(nb_eleves) 
    FROM (
        SELECT classe, COUNT(*) as nb_eleves
            FROM Parcours
            WHERE année=2019        -- Condition sur les lignes
            GROUP BY classe
    )

-- Cas particuier :

-- Lorsqu'une requete ne renvoie qu'un seul élément, 
-- Celui ci peut etre considéré comme une simple valeur.
-- Et on peut l'utiliser dans un WHERE

-- Exemple : code du lycée Barthou

SELECT code
    FROM Lycée
    WHERE nom="LOUIS BARTHOU" AND commune ="PAU"
    ;

-- Maintenant, les élèves qui étaient au lycée Barthou en 2019 :

SELECT nom,prenom
    FROM Parcours JOIN Etudiants ON Parcours.INE = Etudiants.INE
    WHERE code_étab = (SELECT code
                            FROM Lycée
                            WHERE nom="LOUIS BARTHOU" AND commune ="PAU"
                        )

-- Pour cet exemple, on pouvait plus simplement faire une autre jointure avec Lycées.

-- Eleves qui était dans un etablissement apelé Louis Barthou en 2019
SELECT nom,prenom
    FROM Parcours JOIN Etudiants ON Parcours.INE = Etudiants.INE
    WHERE code_étab IN (SELECT code     -- On utilise IN au lieu de = (comme Python)
                            FROM Lycée
                            WHERE nom="LOUIS BARTHOU" AND commune ="PAU"
                        )

-- Exemple plus complexe de sous-requête : les élèves dans une classe ayant au moins 30 eleves

SELECT classe
    FROM Parcours
    WHERE année=2019
    GROUP BY classe
    HAVING COUNT(*) > 30 

-- Etape 2 : les eleves dans une de ces classes

SELECT nom,prénom
    FROM Parcours JOIN Etudiants ON Parcours.INE = Etudiants.INE
    WHERE année = 2019
        AND classe IN (
                    SELECT classe
                        FROM Parcours
                        WHERE année=2019
                        GROUP BY classe
                        HAVING COUNT(*) > 30 
                        )

-- Bonus : Vues
-- Permet d'enregistrer une requête et de l'utiliser plus tard comme si c'était une table

-- ex: enregistrer la vue des nombres d'éleves par classe

SELECT classe, COUNT(*) AS nb_élèves 
    FROM Parcours
    WHERE année=2019

SELECT *
    FROM nombre_d_eleve_par_classe;

SELECT Max(nb_eleves) FROM nombre_d_eleve_par_classe;

SELECT classe
    FROM nombre_d_eleve_par_classe
    WHERE nb_eleves = (
                        SELECT Max(nb_eleves) FROM nombre_d_eleve_par_classe
                        )

-- Opération ensemblistes : Union, intersection, difference

SELECT nom, commune,departement
    FROM Lycées
    WHERE département < 65

    INTERSECT

SELECT nom, commune
    FROM Lycées
    WHERE département > 40

-- UNION ,EXCEPT, INTERSECT

-- TD

-- -2-
-- 2 Le nom des pays où on parle français.
SELECT name
FROM country join countrylanguage on country.code=countrylanguage.countrycode
WHERE  language = "French"
-- 3 Le nom des pays dont le français est la langue officielle
SELECT name
FROM country join countrylanguage on country.code=countrylanguage.countrycode
WHERE  language = "French" AND isofficial = "T"
-- 4 Les différents districts en Australie
SELECT  DISTINCT district
FROM City join country on country.code=city.countrycode
WHERE  country.name = "Australia"
-- 5 Les villes où on parle ousbèque
SELECT name
FROM City JOIN countrylanguage ON city.countrycode=countrylanguage.countrycode
WHERE  countrylanguage.language = "Uzbek"
-- 6 Les couples de pays ayant la même langue officielle
SELECT pays1.name, pays2.name, lang1.language
FROM countrylanguage AS lang1 JOIN country AS pays1 ON lang1.countrycode = pays1.code
							  JOIN country AS pays2 ON lang1.language = lang2.language
							  JOIN countrylanguage AS lang2 ON lang2.countrycode=pays2.code
	WHERE pays1.code <> pays2.code

-- -3-
-- 1 Nombre de ville (dans la base) par pays.
SELECT coutrycode,COUNT(*)
FROM city
GROUP BY countrycode

-- 2 Nombre de ville (dans la base) par pays et nom du pays
SELECT country.name,COUNT(*)
FROM city JOIN country ON city.countrycode = country.code
GROUP BY country.name

-- 3 Calculer la somme des pourcentages des différentes langues parlées dans chaque pays
SELECT country.name,SUM(percentage)
	FROM countrylanguage JOIN country ON countrylanguage.countrycode = country.code 
	GROUP BY country.name

-- 4 Récupérer les pays pour lesquels cette somme ne vaut pas 100
SELECT country.name,SUM(percentage)
	FROM countrylanguage JOIN country ON countrylanguage.countrycode = country.code 
	GROUP BY country.name
	HAVING SUM(percentage)<100

-- 5 Les pays ayant au moins trois villes à plus d’un million d’habitants
SELECT country.name,COUNT(*)
	FROM City JOIN country ON city.countrycode = country.code
	WHERE city.population>1000000
	GROUP BY country.name
	HAVING COUNT(*)>=3

-- -4-
-- 1 Le pays où l’espérance de vie est maximale
SELECT country.name
	FROM country
	WHERE lifeExpectancy = (SELECT MAX(lifeExpectancy)
								FROM country
							)
-- 2 . Les pays où l’espérance de vie est inférieure à la moyenne mondiale. 
--On pourra calculer l’espérance de vie moyenne
--par un simple AVG(lifeExpectancy) même si le résultat n’est pas tout à fait correct.
SELECT country.name
	FROM country
	WHERE lifeExpectancy < (SELECT AVG(lifeExpectancy)
								FROM country
							)

-- POUR LE 24/06 : Finir la feuille (3,4,5,6,7)

-- Vrai formule pour l'éspérance de vie moyenne sur Terre :
-- (\sum_pays population x experance de vie) / sum_pay population


SELECT SUM(lifeExpectancy*population)/SUM(population)
    FROM country
;

SELECT name , lifeExpectancy
    FROM country
    WHERE lifeExpectancy < (
                            SELECT SUM( lifeExpectancy * population )/ SUM( population )
                            FROM country
                            )
;

-- 4. Le(s) pays créé(s) le plus récemment

SELECT name
    FROM country
    WHERE indepYear in (
                    SELECT MAX(indepYear)
                    FROM country
                    )

-- 5. Les langues parlées dans un maximum de pays

-- étape 1 : le nb de pays où on parle chaque langue.
CREATE VIEW nb_pays_par_langue
AS
SELECT language , COUNT(*) AS nb_pays
    FROM countrylanguage
    GROUP BY language
;

SELECT language , nb_pays
    FROM nb_pays_par_langue
    WHERE nb_pays = (
                    SELECT MAX(nb_pays)
                    FROM nb_pays_par_langue
                    )

-- 6. Les langues parlées par un maximum de personnes.


SELECT countrylanguage.language , sum(country.population*countrylanguage.percentage)/100 as nb
	FROM countrylanguage JOIN country ON country.code = countrylanguage.countrycode
	Group BY countrylanguage.language

SELECT language , nb
    FROM nb_personnes_par_langue2
    WHERE nb = (
                SELECT MAX(nb)
                FROM nb_personnes_par_langue2
                )