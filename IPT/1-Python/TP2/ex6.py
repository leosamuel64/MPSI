## A finir et ex 8 si possible
import time


def pourTout(t,p):
	res = True
	for i in range(0,len(t)):
		if not p(t[i]):
			res = False
	return res


#print(pourTout([10,10,10,10,10],lambda x:x==10))

def IlExiste(t,p):
	res = False
	for i in range(0,len(t)):
		if p(t[i]):
			res = True
	return res

def IlExisteOpti(t,p):
	res = False
	i = 0
	while i<len(t) and res != True:
		if p(t[i]):
			res = True
		i += 1
	return res

#print(IlExiste([1,2,3,4,5,6],lambda x:x==3))

def testgain(val):
	deb = time.time()

	IlExiste(list(range(0,1000000)),lambda x:x==val)
	fin = time.time()
	t1 = fin-deb

	deb = time.time()

	IlExisteOpti(list(range(0,1000000)),lambda x:x==val)
	fin = time.time()
	t2 = fin-deb

	return t1,t2, t1/t2

print(testgain(500000))


def IlExisteUnique(t,p): 
	compteur=0
	for i in range(0,len(t)):
		if p(t[i]):
			compteur+=1

	if compteur ==1:
		return True
	else:
		return False
	
#print(IlExisteUnique([1,2,3,3,5,6],lambda x:x==3))

###		Question 4
print(pourTout([10,10,10,9,10],lambda x:x%2==0))

