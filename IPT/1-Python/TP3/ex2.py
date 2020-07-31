def f(a,b):
	x = 0
	y = a
	## Ici, a= b*x +y
	while y>=b:
		## Ici, a= b*x +y
		x+=1
		y-=b
		## Ici, a= b*x +y
		count+=1
	return (x,y)

def fLisible(a,b):
	""" Entrée :	 -a,b entiers
		
		Sortie :	 -couple (quotient,reste) ## OU (a//b , a%b)
		
		Effet :		 -Division euclidienne de a par b
	"""

	quotient = 0
	reste = a

	if b<0:
		while abs(reste) <= b :
			quotient-=1
			reste += b
	else:
	
		while abs(reste) >= b:
			
			quotient+=1

		
			reste-=b
	
		

	
	return (quotient,reste)

def fUltime(a,b):
	return (a//b, a%b)


print(fLisible(35,-3))
print(fUltime(35,-3))

"""
## 1)

2,1 => 2,0
15,5 => 3,0
15,6 => 2,3 

a = b*x + y
dividende = diviseur*quotient +reste

## 4) 

Pour que l'algorithme termine, il faut que b =/= 0

## 5) 
Soit b =/= 0,
La quantité reste-b est :
	- Positive
	- Décroissante
	- Entière

## 7)
Pour tout k € |N*, notons x(k) la valeur de x au rang k et y(k) la valeur de y au rang k.
Pour tout k € |N*, Notons P(k) : "a = b*x(k) +y(k)". Montrons par récurrence sur k P(k).

Init : 
	Mq a = b*0+y(0).
	On a y(0) = a donc b*0+y(0)=a. P(0) est alors vraie.

Hérédité : 
	Soit k tq P(k)
	
	Montrons P(k+1): "a = b*x(k+1)+y(k+1)"

	b*(k+1)+y(k+1) = b*k + b + y(k)-b
				   = b*k + y(k)

				   = a 					## Par hypothèse de récurrence
	

		Alors P(k+1).

Conclusion : 
	Pour tout k € |N*,P(k).

Cette fonction renvoie donc bien le bon résultat.

## 8)

La boucle s'éxécute a//b











"""



