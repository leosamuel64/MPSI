import cv2
import numpy.random as rd
from libneurones2 import *


def convert(img,output):
	""" 
		Entrée : 	- img : Image
					- output : fichier texte pour enregistrer la matrice

		Sortie : 	- Image convertie en matrice dans un fichier texte
	"""


	img = cv2.imread(img,0)
	img = cv2.bitwise_not(img)

	img = img/255
	img = img //1

	newimg = nvMat(len(img),len(img[0]))

	for i in range(0,len(img)):
		for j in range(0,len(img[0])):
			newimg[i][j] = int(img [i][j])

	monfichier = open(output,'a')

	monfichier.write(str(newimg))

convert('img.jpg','output.txt')




