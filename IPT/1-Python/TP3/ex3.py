import numpy.random as rd

def f(t):
	r=0
	i=0
	count = 0
	while i <len(t):
		count+=1
		r= 2*r + 3*r**2
		if rd.randint(0,2)==0:
			t.pop()
		else :
			i+=1
	return r

print(f([0,0,0,0,0,0,0,0]))



"""
## 1)

La quantité (len(t)-i) est :
	- Décroissante à chaque itération
	- Positive
	- Entiere

	==> Donc c'est un invariant de boucle et la boucle se termine

## 2)

La boucle va s'éxecuter len(t) fois

## 3)
f renvoie 0

DEM : 
Pour tout n € |N,Notons P(n) : "r(n)=0". Montrons Par récurrence sur n P(n).

## Init avant la boucle : 

r(0) = 0 donc P(0) est vraie

## Hérédité : 

Suposons P(n) vraie a un certain rang de n.
Montrons P(n+1): r(n+1) = 0

r(n+1) = 2*r(n) + 3*r(n)**2

Or par hypothèse de récurrence, r(n)=0 donc:
r(n+1) = 2*0 + 3*0**2
r(n+1) = 0

Donc P(n+1) est aussi vraie

## Conclusion :

Donc pour tout n € |N, P(n) est vraie





"""