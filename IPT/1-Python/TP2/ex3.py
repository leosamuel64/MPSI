def estPair(n):
	return n%2==0

def estMultipleDe3(n):
	return n%3==0

def estMultipleDe6(n):
	return estPair(n) and estMultipleDe3(n)

def divise(a,b):
	return b%a==0

def estPremier(n):
	somme = 0
	for i in range (1,n):
		if divise(i,n):		
			somme += 1

	return not bool(somme-1)
		


print(estPremier(15))