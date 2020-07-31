def est_bissextile(n):
	if n%4 == 0:
		if n%100 != 0:
			return True


		elif n%400==0:
			return True

		else:
			return False

	else:
		return False

def est_bissextile2(n):
	if n%4 == 0 and (n%100 != 0 or n%400==0):
		return True

	else:
		return False


def est_bissextile_global(n):
	if n>1582:

		if n%4 == 0 and (n%100 != 0 or n%400==0):
			return True

		else:
			return False
	
	elif n%4 == 0 and (n%100 != 0 or n%400==0):
		return True

	else:
		return False



def nbDeJours(n):
	if est_bissextile2(n):
		return 366
	else:
		return 365

def nbDeJoursGlobal(n):
	if est_bissextile_global(n):
		return 366
	else:
		return 365


print(est_bissextile_global(8))