def divise(a,b):
	
	return not bool(b % a)

#print(divise(2,3))

def diviseur(n):
	i = 2
	while not divise(i,n):
		i+=1

	return i

#print(diviseur(14))

def decomposition(n):
	listediviseur = []
	produitdiv = 1
	nmod = n

	while produitdiv != n:
		div = diviseur(nmod)

		listediviseur.append(div)
		produitdiv = produitdiv * div
		nmod = nmod/div

	return listediviseur

print(decomposition(24))	
