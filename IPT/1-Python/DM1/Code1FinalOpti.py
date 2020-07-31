from libneurones import *



def estActivé(k,Im,P):
	""" 
		Entrée : 	- k : Nombre cible
					- Im : matrice du nombre cible
					- P : Matrice des Poids

		Sortie : 	- Booléen : Neurone activé
	"""

	somme = 0
	for i in range(0,len(Im)):
		for j in range(0,len(Im[0])):
			somme += (P[i][j][k])*(Im[i][j])
	if somme >= 1:
		return True
	else :
		return False
	

def sorties_activées(Im,P):
	""" 
		Entrée : 	- Im : Matrice du nombre

		Sortie : 	- Tableau : Sorties activées
	"""

	sortiesActivées = []
	for i in range(0,NB_SORTIES):
		if estActivé(i,Im,P):
			sortiesActivées.append(i)

	return sortiesActivées


def augmenteCoeffConcernés(Im,P,k0):
	""" 
		Entrée : 	- Im : Matrice du nombre
					- P : Matrice des Poids
					- k0 : Nombre cible

		Sortie : 	- Augmente les poids
	"""
	for j in range(0,len(Im[0])):
		for i in range(0,len(Im)):
			if Im[i][j]:
				P[i][j][k0] += 0.1 

def diminueCoeffConcernés(Im,P,k0):
	""" 
		Entrée : 	- Im : Matrice du nombre
					- P : Matrice des Poids
					- k0 : Nombre cible

		Sortie : 	- Diminue les poids
	"""
	for j in range(0,len(Im[0])):
		for i in range(0,len(Im)):
			if Im[i][j]:
				P[i][j][k0] -= 0.1

def litUneImage(Im,k0,Q):
	""" 
		Entrée : 	- Im : Matrice du nombre
					- Q : Matrice des Poids
					- k0 : Nombre cible

		Sortie : 	- Booléen : reconnaissance incorrecte
					- Modifie les poids si besoin
	"""
	
	k0Presence=False
	error = False
	s=sorties_activées(Im,Q)
	
	if s!=[k0]: #Si il n'y a pas que le bon resultat en sortie:
		
		for k in range(0,len(s)):
			
			if s[k]!=k0:
				diminueCoeffConcernés(Im,Q,s[k])
				error = True
			
			if s[k]==k0:
				k0Presence = True
		
		if not k0Presence:
			augmenteCoeffConcernés(Im,Q,k0)
			error = True

	return error
	

def litLesImages(Q):
	""" 
		Entrée : 	- Q : Matrice des Poids

		Sortie : 	- Booléen : Les reconnaissances sont correctes
	"""
	error = 0
	for x in range(0,len(TOUT)):
		error += litUneImage(TOUT[x][0],TOUT[x][1],Q)

	return not bool(error)


def Apprentissage():
	""" 
		Sortie : 	- Matrice des poids finale
	"""
	P=init_P(len(TOUT[0][0]), len(TOUT[0][0][0]), NB_SORTIES)

	while litLesImages(P)==False:
		
		for x in range (0,len(TOUT)):				# Correction des poids
			litUneImage(TOUT[x][0],TOUT[x][1],P)
	
	return P



print(Apprentissage())








	

