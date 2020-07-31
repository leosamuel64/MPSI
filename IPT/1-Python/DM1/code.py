from libneurones import *
import math
import os
import time

P=init_P(5, 3, 10)


def estActivé(k,Im,P):

	somme = 0
	for i in range(0,5):
		for j in range(0,3):
			somme += (P[i][j][k])*(Im[i][j])
	if somme >= 1:
		return True
	else :
		return False


def ValestActivé(k,Im,P):

	somme = 0
	for i in range(0,5):
		for j in range(0,3):
			somme += (P[i][j][k])*(Im[i][j])



	return somme

"""while estActivé(1,un,P)==True:
	P = init_P(5,3,10)
	print(estActivé(1,un,P))
	print(P)"""

	

def sorties_activée(Im,P):
	sortieActivée = []
	for i in range(0,10):
		if estActivé(i,Im,P):
			sortieActivée.append(i)

	return sortieActivée


def augmenteCoeffConcernés(Im,P,k0):
	for j in range(0,3):
		for i in range(0,5):
			if Im[i][j] == 1:
				P[i][j][k0] = P[i][j][k0]+0.00001 

def diminueCoeffConcernés(Im,P,k0):
	for j in range(0,3):
		for i in range(0,5):
			if Im[i][j] == 1:
				P[i][j][k0] = P[i][j][k0]-0.00001

def litUneImage(Im,k0,Q):
	
	k0Presence=0
	error = 0
	s=sorties_activée(Im,Q)
	
	if s!=[k0]: #Si il n'y a pas que le bon resultat en sortie:
		
		for k in range(0,len(s)):
			
			if s[k]!=k0:
				diminueCoeffConcernés(Im,Q,s[k])
				error = 1
			
			if s[k]==k0:
				k0Presence = 1
			
		
		if k0Presence == 0:
			augmenteCoeffConcernés(Im,Q,k0)
			error = 1

	return error

#print(litUneImage(un,1,P))
#print(un[4][2])

def ApprentissageUneImg():
	P=init_P(5, 3, 10)

	while litUneImage(un,1,P)==True:
		
		litUneImage(un,1,P)
		
		print(sorties_activée(un,P),ValestActivé(2,un,P),ValestActivé(1,un,P))
		#print(P)
		#time.sleep(0.01)
		#u=os.system('clear')
	return P
	

#print(ApprentissageUneImg())

	

def litLesImages(Q):
	error = 0
	for x in range(0,len(TOUT)):
		error += litUneImage(TOUT[x][0],TOUT[x][1],Q)
	return not bool(error)


#print(litLesImages(P))

def Apprentissage():
	P=init_P(5, 3, 10)

	while litLesImages(P)==False:
		for x in range (0,len(TOUT)):
			litUneImage(TOUT[x][0],TOUT[x][1],P)
	return P



print(Apprentissage())








	

