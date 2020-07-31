def carre(x):
	return x**2

def pow4(x):
	return(carre(carre(x)))  # 2 multiplication

def altpow4(x):
	return carre(x)*carre(x)	# 3 multiplication donc 50% plus lente

def q3(x):
	x=x+1
	return pow4(x)

def q4(x):
	return 2 + 3*x + 2*carre(x) + 4*pow4(x)

x=15
print(2 + 3*x + 2*(x**2) + 4*(x**4))
print(q4(x))