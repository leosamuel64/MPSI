import time


def exemple1(n):
	res=[]
	for i in range(0,n):
		res.append(i**i)
	return res






def exemple2(n):
	res=[]
	for i in range(0,n):
		res.append(2**i)
	return res




def sansDoublon(t):
	deb=time.time()
	res=[]
	n=len(t)
	for i in range(0,n):
		if not (t[i] in t[i+1:n]):
			res.append(t[i])

	return res, time.time()-deb

def sansDoublon2(t):
	deb=time.time()
	res=[]
	n=len(t)
	for i in range(0,n):
		if not (t[i] in res):
			res.append(t[i])

	return res,time.time()-deb

	"""
t,a=sansDoublon([1,1,2,3,4,4,3,2,5,6,5,1])
c,b=sansDoublon2([1,1,2,3,4,4,3,2,5,6,5,1])
print(a/b)"""

def equilibre(t1,t2):
	while len(t1) < len(t2):
		x=t2.pop
		t1.append(x)



def chercheDicho(t,x):
	""" Entrée : 		- t un tableau
						- x un élément

		Précondition :	- t est trié

		Sortie : 		- le booléen x € t
	"""

	deb = 0			## indice de la zone de recherche ( t[deb:fin] )
	fin = len(t) 
	trouvé = False	## indique si on a trouvé x

	while fin > deb and not trouvé:
		m=(deb+fin)//2
		if x < t[m]:
			##Poursuivre à gauche
			fin = m
		elif x > t[m]:
			##Poursuivre à droite
			deb = m+1
		else :
			# t[m]==x
			trouvé = True


	return trouvé

print(chercheDicho([1,2,3,5,7,8,9],4))

""" Terminaison : 
fin- deb

N le nb de tours
A i €[[0,N[[ di et fi les valeurs de deb et fin après i itération

Soit i € [[0,N-1[[ Si on est ds le 1er cas du if : f([i+1]/2)
d(i+1)=d(i)
"""