def nombre_de_glomorphe(n_glomorphe_init,n_annee):
	""" n_annee est le nombre d'année 
		glomorpheinit est le nombre de glomorphe au début	
	"""

	n_glomorphe_elevage = n_glomorphe_init
	n_glomorphe_nature = 0

	for i in range (0,n_annee):
		n_glomorphe_elevage = n_glomorphe_elevage * 6 - 8
		n_glomorphe_nature = n_glomorphe_nature + 8
		n_glomorphe_total = n_glomorphe_elevage + n_glomorphe_nature

	return n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total

def nombre_de_glomorphe_a_pois(n_glomorphe_init,n_annee):
	""" n_annee est le nombre d'année 
		glomorpheinit est le nombre de glomorphe au début	
	"""
	if n_glomorphe_init < 3:
		print("erreur : nombre de glomorpge < 3")
		exit()

	n_glomorphe_elevage = n_glomorphe_init
	n_glomorphe_nature = 0

	for i in range (0,n_annee):
		n_glomorphe_elevage = n_glomorphe_elevage * 4 - 8
		n_glomorphe_nature = n_glomorphe_nature + 8
		n_glomorphe_total = n_glomorphe_elevage + n_glomorphe_nature

	return n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total




def depassement_elevage(n,n_glomorphe_init):
	i=1
	n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total = nombre_de_glomorphe(n_glomorphe_init,i)
	while  n_glomorphe_elevage < n:
		i+=1
		n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total = nombre_de_glomorphe(n_glomorphe_init,i)

	return i,n_glomorphe_elevage

def depassement_total(n,n_glomorphe_init):
	i=1
	n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total = nombre_de_glomorphe(n_glomorphe_init,i)
	while  n_glomorphe_total < n:
		i+=1
		n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total = nombre_de_glomorphe(n_glomorphe_init,i)

	return i,n_glomorphe_total




def depassement_total_a_pois(n,n_glomorphe_init):
	i=1
	n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total = nombre_de_glomorphe_a_pois(n_glomorphe_init,i)
	while  n_glomorphe_total < n:
		i+=1
		n_glomorphe_nature, n_glomorphe_elevage, n_glomorphe_total = nombre_de_glomorphe_a_pois(n_glomorphe_init,i)

	return i,n_glomorphe_total

print(depassement_total_a_pois(10000,2))