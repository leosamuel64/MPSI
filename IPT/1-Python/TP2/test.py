
# Recherche d'une chaine dans une autre
## entrée m et t deux chaines str
#Sortie : Bool si m appartient ou non à t

def estPresentPlacei(m,t,i):
	res = True
	for j in range (0,len(m)):
		if t[i+j]==m[j]:
			None
		else:
			res = False

	return res



def estPresent(m,t):
	res = False
	for i in range (0,len(t)-len(m)):
		if estPresentPlacei(m,t,i):
			res= True
	return res

#print(estPresent("ont","bonjour"))

def forQuiPlante():
	"""info help"""

	aparcourir = [1,2,3]
	for i in aparcourir:
		aparcourir.append(12)
	return "FIN"

#print(forQuiPlante())



def puissance(x,n):
	res = 1
	for i in range (0,n):
		## res contient x**(i)
		res *= x
		## res contient x**(i+1)
	return res

#print(puissance(2,2))


def estTrié(t):
	res=True
	for i in range(1,len(t)):
		### Ici res est vrai ssi t[0:i] est trié
		if t[i-1] > t[i]:
			res = False

	return res

#print(estTrié([0,1,5,3,4,5]))



def plusPetitDiviseur(n):
	"""	Entrée : n entier > 1
		Sortie : Le plus petit diviseur de n qui soit > 1
	"""

	d=2
	while n%d != 0:
		# ici, n n'est pas divisible par les éléments de [[2,d]].
		d+=1
		# ici, n n'est pas divisible par les éléments de [[2,d-1]].

	return d

print(plusPetitDiviseur(21))





