#! /usr/bin/python3
# -*- coding: utf-8 -*-



##### NE FONCTIONNE QUE EN PYTHON 2.X

def extraire(chemin):
	entree = open(chemin,'r')
	res=[]
	for ligne in entree:	#la variable va parcourir chaque ligne du fichier
		t=ligne.strip().split(';')
		res.append(t)
	return res

def SepNomPrenom(liste):
	Nom=[]
	Prenom=[]
	for i in range (0,len(liste)):
		Nom.append(liste[i][0])
		Prenom.append(liste[i][1])

	return Prenom,Nom


def nbEleveVoyelle(listePrenom):
	voyelle=["A","E","I","O","U","Y"]
	somme = 0
	for i in range(0,len(listePrenom)):
		if listePrenom[i][0] in voyelle:
			somme+=1
	return somme


listeEleve = extraire("801.csv")

Prenom,Nom = SepNomPrenom(extraire("801.csv"))

#print(Prenom)

#print(nbEleveVoyelle(Prenom))

def ajouteNbEleveNom(listeNom,listePrenom):
	NewList=[]
	Num = range(0,len(listeNom))
	for i in range(0,len(listeNom)):
		NewList.append([i,listeNom[i],listePrenom[i]])

	return NewList

#ajouteNbEleveNom(Nom,Prenom)

def Groupe(listeEleve):

	listeGroupe=[]
	nbEleve = len(listeEleve)  ## Eleve à répartir
	div=[]
	while nbEleve > 0:
		if nbEleve-3 >= 0:
			div.append(3)
			nbEleve -= 3
		elif nbEleve-2 >= 0:
			div.append(2)
			nbEleve -= 2
		elif nbEleve-1 >= 0:
			div.append(1)
			nbEleve -= 1

	nGroupe=len(div)

	n=0

	for i in range(0,len(div)):
		for j in range(0,div[i]):
			Groupe =[]

			if div[i]==3:
				Groupe.append([listeEleve[n],listeEleve[n+1],listeEleve[n+2]])
				n += 3
			elif div[i] ==2:
				Groupe.append([listeEleve[n],listeEleve[n+1]])
				n += 2
			elif div[i]==1:
				Groupe.append([listeEleve[n]])
				n += 1
			print(len(div),n)
			

	return listeGroupe
 














			###listeGroupe.append(str(listeEleve[nbEleve])+" "+str(listeEleve[nbEleve+1])+" "+str(listeEleve+2))
			

	#return div,len(listeEleve)
#print(len(listeEleve))
print(Groupe(listeEleve))




