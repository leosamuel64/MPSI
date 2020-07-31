def somme(initial,fin):
	"""	somme des entier positif
		initial : valeur initial de i
		fin : valeur de n				"""
	i=initial
	somme = 0
	for x in range (initial,fin-1):
		i += 1
		somme = somme +i
	return somme



def somme2(initial,fin):
	"""	Somme des 2**i
		initial : valeur initial de i
		fin : valeur de n				"""
	i=initial
	somme = 0
	for x in range (initial,fin-1):
		i += 1
		somme = somme +2**i
	return somme

def somme3(initial,fin):
	"""	
		Somme des entiers impaires entre initial et fin
		initial : valeur initial de i
		fin : valeur de n				"""
	i=initial
	somme = 0
	for x in range (initial,fin-1):
		i += 1
		if i % 2 == 1:
			somme = somme + i
	return somme

def factorielle(n):
	"""retourne la factorielle de n. """
	factorielle=1
	for i in range (1,n+1):
		factorielle=factorielle*i
	return factorielle

	

def somme4(initial,fin):
	"""	Somme des 1/factorielle(i)
		initial : valeur initial de i  !!!!! i > 0
		fin : valeur de n				"""
	i=initial
	somme = 0.0
	for x in range (initial,fin-1):
		somme = somme +(1/factorielle(x))
	return somme



print(somme4(0,10))


