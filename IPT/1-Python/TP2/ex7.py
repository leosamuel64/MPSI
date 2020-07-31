def barre(t,a):
	for i in range (0,len(t)):
		if t[i]%a == 0 and t[i]!=a:
			t[i]=0
	return t

#print(barre([1,2,3,4,5,6,7,8,9,10],2))

def initialisation(n):
	t = list(range(0,n))
	return t

#print(initialisation(10))

def sansZero(t):
	nt = []
	for i in range (0,len(t)):
		if t[i]!=0:
			nt.append(t[i])
	return nt

#print(sansZero([0,0,0,0,3,4,0]))

def Eratosthene(n):
	t = initialisation(n)
	for i in range(2,n):
		t = barre(t,i)
	nt = sansZero(t)
	nt.pop(0)
	return nt


#print(Eratosthene(1000))
Eratosthene(10000)