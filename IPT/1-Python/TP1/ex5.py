def trinome(a,b,c):
	#Prrécondition a>0
	#a*x**2 + b*x + c
	delta = b**2 - 4*a*c
	if delta > 0:
		return (-b+(delta**0.5)) / (2*a) , (-b+(delta**0.5)) / (2*a)

	elif delta == 0:
		return -b/(2*a)

	else :
		return (-b+complex(0,1)*(delta**0.5)) / (2*a) , (-b+complex(0,1)*(delta**0.5)) / (2*a)


def degre1(b,c):
	#b*x + c
	solution = -c/b
	return solution


def solve(a,b,c):
	if a != 0:
		return trinome(a,b,c)
	else:
		return degre1(b,c)

print(trinome(0,2,-2))




