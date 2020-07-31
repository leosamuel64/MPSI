def appartient(x,t):
	res = False
	for i in range(0,len(t)):
		if t[i]==x:
			res = True

	return res

## On compte les tests "t[i]==x". Il y a len(t) tests



def appartientMatrice(x,t):
	res = False

	for i in range(0,len(t)):
		for j in range(0,len(t[i])):
			if t[i][j] == x:
				res = True

	return res

## On compte les tests "t[i][j] == x". Il y a donc len(t)*len(t[0]) tests

"""print(appartientMatrice(2,[ [0,1,0,3],
							[5,3,5,3],
							[0,0,0,4]]))

							"""

def estTrié(t):
	res = True
	for i in range(1,len(t)):
		if t[i] < t[i-1]:
			res = False
	return res

## On compte les tests : Il y a len(t)-1 tests soit O(len(t))

print(estTrié([0,1,2,3,10,5,5,6]))

def divEu(a,b):
	x = 0
	y = a
	while y>=b:
		x+=1
		y-=b
		count+=1
	return (x,y)

## On compte les "+": il y en a 3 par boucles. La boucle se termine apres quotient itération
## Il y a donc 3*(quotient)=3*(a/b)= O(a/b)



## Faire EXO 2