def factorielle(n):
	"""retourne la factorielle de n. """
	res=1

	for i in range (1,n+1):
		## Ici res contient (i-1)!
		res*= i
		## Ici res contient i!
	return res

def estPremier(n):
	res = True
	for k in range (1,n):
		## Ici, res est vrai ssi les éléments dans [[2,k[[ ne divise pas n
		if n%k==0:		
			res = False
		## Ici, res est vrai ssi les éléments dans [[2,k+1[[ ne divise pas n

	## Sortie de Boucle : res est vrai ssi les éléments dans [[2,n[[ ne divise pas n (def de nombre premier)


	return res

def appartient(x,t):
	res = False
	for i in range(0,len(t)):
		## Ici, res est faux ssi x n'appartient pas à t[0:i]
		if t[i]==x:
			res = True
		## Ici, res est faux 	ssi x n'appartient pas à t[0:i+1]
		## 		res est vrai 	ssi x appartient à t[0:i+1]

	## Sortie de Boucle : 	res est faux ssi x n'appartient pas à t[0:n]
	##						res est vrai ssi x apartient à t[0:n]
	return res

#print(appartient(3,[1,2,0,4,5]))



def sansZero(t):
	nt = []
	for i in range (0,len(t)):
		## Ici
		if t[i]!=0:
			nt.append(t[i])
		###
	return nt



##### Faire exo 3