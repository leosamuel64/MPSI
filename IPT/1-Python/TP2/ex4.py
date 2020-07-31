def somme(t):
	somme = 0
	for i in range (0,len(t)):
		somme += t[i]
	return somme


def maximum(t):
	maxi =t[0]
	for i in range (0, len(t)):
		if t[i]>maxi:
			maxi=t[i]
	return maxi
 


def maximumEtPos(t):
	maxi =t[0]
	for i in range (0, len(t)):
		if t[i]>maxi:
			maxi=t[i]
			ind=i

	return maxi,i-1

def estTrié(t):
	
	for i in range (1,len(t)):
		if t[i]< t[i-1]:
			return False
	return True
		

def carré(x):
	return x**2


def applique(f,t):
	for i in range (0,len(t)):
		t[i]=f(t[i])
	return t


print(applique(lambda x:x**5,[0,1,2,6,4,5]))




