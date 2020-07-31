-- 1

SELECT Prénom,COUNT(*)
	FROM prenoms
	WHERE Sexe = "F"
	GROUP BY Prénom

SELECT Prénom,COUNT(*)
	FROM prenoms
	WHERE Sexe = "M"
	GROUP BY Prénom

-- 2

SELECT	feminins.Prénom, feminins.nbFilles, Masculins.nbGarcons
	FROM feminins JOIN masculins ON feminins.Prénom = masculins.Prénom

-- 3

SELECT Prénom
	FROM feminins
EXCEPT
SELECT Prénom
	FROM epicenes

SELECT Prénom
	FROM masculins
EXCEPT
SELECT Prénom
	FROM epicenes

-- 4

SELECT Prénom, 1 as Taux_de_féminité
	FROM purementFeminin
UNION
SELECT Prénom, 0 as Taux_de_féminité
	FROM purementMasculin
UNION
SELECT Prénom, nbFilles/(nbGarcons+nbFilles+0.0) as Taux_de_féminité
	FROM epicenes