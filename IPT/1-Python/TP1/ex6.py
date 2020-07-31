import numpy as np

def alea(n):
	x = np.random.randint(0,n)
	y = np.random.randint(0,n)

	while x==y:
		x = np.random.randint(0,n)
		y = np.random.randint(0,n)
	return x,y

print(alea(2))