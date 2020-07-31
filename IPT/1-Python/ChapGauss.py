def transpose(M, i1, i2):
    """ Effectue Li1 <-> Li2 sur M"""
    M[i1], M[i2] = M[i2], M[i1]


# Attention : ne fonctionne pas avec un tableau numpy...
# L'intruction M[i1]=M[i2] copie la ligne M[i2] dans la ligne i1 de M
# Pour numpy, utiliser :
def transpose(M, i1, i2):
    """ Effectue Li1 <-> Li2 sur M"""
    for j in range(len(M[i1])):
            M[i1][j], M[i2][j] = M[i2][j], M[i1][j]



# Dilatations
def dilate(M, i1, λ ):
    """ Effectue Li1 <- λ Li1 """
    for j in range(len(M[i1])):
        M[i1][j] *= λ

# Transvections
def transvecte(M, i1, i2, λ):
    """ Effectue Li1 <- Li1 + λ Li2"""
    
    for j in range(len(M[i1])):
        M[i1][j] = M[i1][j] + λ* M[i2][j]

### 2.2 Annule colonne ###

M= [[1, 2, 4],
    [0, 1, 3],
    [0,-1, 5],
    [0, 2, 7]]
# On veut traiter la deuxième colonne, en utilisant la case (1,1) comme pivot
                   # Effectuons : L0 <- L0-2L1. Càd transvecte(M, 0, -2)
                   # L2 <- L2 + L1
                   # L3 <- L3 -  2L1
def annuleColonne(M, i0, j):
    """ Précondition : M[i0][j]==1.
        Effet : utilise M[i0][j] comme pivot pour annuler tous les coeff au dessus et en dessous de la case (i0,j)"""
    n=len(M)
    for i in range(n):
        if i != i0:
            transvecte(M,i, i0, -M[i][j]) # On annule la case (i,j)

exemple=[[1,2,3],[5,1,0],[4,2,3]]
exemple2=[[1,2,3],[1,2,0],[4,2,3]]
# dans exemple2, on obtient un 0 en case 1,1. -> Il faut trasposer L1 et L2.

exemple3=[[1,2,3],[1,2,0],[1,2,4]]
# Dans exemple3, après un annuleColonne(0,0), la col 2 est nulle à partir de la ligne 1...Impossible d'y trouver un pivot !
# La col 2 est déjà échelonnée avec la première -> rien à faire !
# On passe à la col3. On utilise comme pivot la case (1,2)

def affiche_mat(M):
    for l in M:
        print(l)


def cherchePivot(M,i0,j):
    """
    Entrée : (i0,j), indices de la case où on souhaite mettre le prochain pivot.
    Sortie : le premier indice i>= i0 tel que M[i][j]≠0, ou None s'il n'en existe pas."""

    i=i0
    n=len(M) # nb de lignes
    while i<n and M[i][j]==0: # la case i,j ne peut pas servir de pivot
        i+=1
    # Sortie de boucle, on a la négation de la condition de boucle, càd
    # i>=n ou M[i][j]≠0
    if i==n :
        return None
    else: # M[i][j]≠0
        return i



    
    
# enfin, le pg final

def pivot_ligne(M):

    p = len(M[0])
    i = 0 # indice de la ligne où on veut mettre le prochain pivot
    
    # On traite chaque colonne l'une après l'autre
    for j in range(p):
        # But : mettre 1 en case (i,j)
        ipivot = cherchePivot(M,i,j)
        if ipivot !=None :
            # Ramenons le coeff non nul M[ipivot][j] en case (i,j)
            transpose(M,ipivot,i)
            # Transformons ce pivot en 1
            dilate(M,i,1/M[i][j])
            # On est alors dans les conditions d'application de annuleColonne
            annuleColonne(M,i,j)
            # màj i
            i+=1
        else:
            #La colonne j est entièrement nulle à partir de la case i
            None # On ne fait rien, et en particulier on garde le même i. (Vous pouvez donc supprimer ce else et son None.)


mat = [ [1,2,4],
        [0,1,3],
        [0,-1,5],
        [0,2,7]]

# pivot_ligne(mat)
# affiche_mat(mat)

# Application 1 : résoudre un système d'équations
MatAug = [[2,3,-7,4],
          [4,2,-3,5],
          [3,5,-2,1]]

# pivot_ligne(MatAug)
# affiche_mat(MatAug)

# Application 2 : Inverser une matrice Avec la methode de Gauss Jordan

Matr = [[2,3,-7,1,0,0],
        [4,2,-3,0,1,0],
        [3,5,-2,0,0,1]]

#pivot_ligne(Matr)
#affiche_mat(Matr)

# Partie 3 : erreur d'arrondie

eps = 2**-50
M=[[eps,1,0.5],[1,1,1]]

# pivot_ligne(M)
# affiche_mat(M)


# ---------- TD ----------

# Exercice 1 

def solve_syst(M):
    """ Renvoie les solutions du systeme M

        Précondition : M doit être la matrice augmenté du systeme.
    """
    res=[]
    pivot_ligne(M)
    p=len(M)
    for i in range (p):
        res.append(M[i][p])
    return res

Matr = [[2,3,-7,1,0,0],
        [4,2,-3,0,1,0],
        [3,5,-2,0,0,1]]

# print(solve_syst(MatAug))
import copy
import numpy as np
def inverseMat(M):
    """
    Inverse la matrice M avec Gauss-Jordan

    Précondition : M est une matrice Inversible 
    """
    Mat = copy.deepcopy(M)
    nligne=len(Mat)
    nvMat=[]
    # On ajoute l'identité à droite
    for i in range(nligne):
        for j in range (nligne):
            if i == j:
                Mat[i].append(1)
            else:
                Mat[i].append(0)
    pivot_ligne(Mat)
    res = []
    for i in range (nligne):
        ligne=[]
        for j in range (nligne):
            ligne.append(Mat[i][nligne+j])
        res.append(ligne)
    return res


Mat2 = [  [2,3,-7],
          [4,2,-3],
          [3,5,-2]]

# affiche_mat(inverseMat(Mat2))


# Exercice 4 : Diététique

matriceDiet = [ [21.88,6.64,23.24,16.05,8400],  # Energie
                [46.7/100,2.3/100,48.1/100,43.5/100,260],       # Glucides
                [34/100,11/100,35.3/100,13.9/100,70],           # Lipides
                [5.9/100,7.7/100,10.1/100,13.9/100,50]          # Protéines
]

# print(solve_syst(matriceDiet))
# Ce n'est donc pas possible

## Interlude : exemple de système pas de Cramer

MatpC =[    [1,2,3,4],
            [-1,-2,1,2]
]

# pivot_ligne(MatpC)
# affiche_mat(MatpC)


# Exercice 5 : Calcul de déterminant

# Méthode 1 : La grosse formule de la définition

# Complexité de la formule :
# Comptons le nombre d'évaluation de permutation :
# On somme n! termes et chaque terme coute O(n)
# complexité : O(n*n!) -> Ne pas utiliser cette méthode

# Méthode 2 : On developpe par rapport à une colonne
# det(M) = \sum{i=0}^{n-1} (-1)^{i+n+1} M{i,n-1}\Delta_{i,n-1}(M)



def sousMat(M,i,j):
    """ Renvoie la matrice obtenue en suprimant la ligne i et la colonne j de M """
    res = []
    for l in range(len(M)):
        ligne=[]
        if l != i:
            for c in range (len(M[0])):
                if c !=j:
                    ligne.append(M[l][c])
            res.append(ligne)
    return res

mat3 = [    [1,2,3],
            [4,5,6],
            [7,8,9]
]

# print(sousMat(mat3,0,2))

def det(M):
    n=len(M)
    #Cas d'arrêt :
    if n==0:
        return 1
    else:
        res =0
        for i in range (n):
           res += (-1)**(i+n+1)*M[i][n-1]*det(sousMat(M,i,n-1))
        return res

mat4 = [[1,2],
        [3,4]]

# det = 4-6=2

mat5 = [    [3,3,3],
            [1,1,1],
            [2,2,2]
] 

# det = 0

# print(det(mat5))




# cxté
# Comptons les *
# Pour tout n \in \N, soit Cn le nb max de * pour une matrice de format n*n
# On a c0=0
#\forall n € N*, C_n = n*C_{n-1} + O(n)
#                    >= n*C_{n-1}
# Donc \forall n \in \N ,C_n >= cte*n!

# Donc cette méthode n'est pas plus éfficace que la première !
# (Elle est plus simple que de chercher les permutations (premeiere méthode))

# Pour mercredi :  méthode avec le pivot de Gauss


def transvection(A,i,k,c):
    m = len(A[0])
    for j in range (0,m):
        A[k][j] -= c*A[i][j]
    return A

def recherche_pivot(A,i):
    n = len(A)
    maxi, pivot = abs(A[i][i]), i
    for k in range (i+1,n):
        elem = abs(A[k][i])
        if elem > maxi:
            maxi, pivot = elem, k
    return (pivot)
  
def triangule(M):
    """ Triangule la matrice M et renvoie coefficient a appliquer au detrminant """
    n, m = len(M), len(M[0])
    p = 0
    for i in range(n-1):
        k = recherche_pivot(M, i)
        if k != i:
            transpose(M,i,k)
            p += 1
        for k in range(i+1, n):
            transvection(M, i, k, M[k][i] / M[i][i])
    if p%2==1: #Si p est impaire
        s = -1
    else:
        s = 1
    return s



def determinant(M):
    s = triangule(M)
    res = 1
    for i in range(len(M)):
        res*=M[i][i]
    return s*res

matdet = [  [-2,2,-3],
            [-1,1,3],
            [2,0,-1],
]
import time


# deb = time.time()
# print(str(determinant(matdet))+" ----> "+str(time.time()-deb))


matdet = [  [-2,2,-3],
            [-1,1,3],
            [2,0,-1],
]

mat = [ [1,1,1],
        [2,0,1],
        [-1,1,2]
]

# print(det(mat))

# deb = time.time()
# print(str(det(matdet))+" ----> "+str(time.time()-deb))

# Exercice 8 : Triacide

pH=6
c0=1 # mol/L

"""
Formule du pKa:

pKa = -log(Ka)
pKA = -log[base] - log[H+] +log(acide))
Ka = ([base][H+])/[acide]
"""

pKa1=2.1
pKa2=7.2
pKa3=12.4

"""
log(c1)  -log[c2]                   = pKa1 - pH
         +log(c2) -log[c3]          = pKa2 - pH
                  +log(c3) -log[c4] = pKa3 - pH

"""
e = 10^(-52)

matChim = [ [1,-1,0,0,pKa1 - pH],
            [0,1,-1,0,pKa2 - pH],
            [0,0,1,-1,pKa3 - pH]
]

# pivot_ligne(matChim)
# affiche_mat(matChim)


def concentration(pH,c0):
    """
    Renvoie les concentrations (c1,c2,c3,c4) correspondant à ces valeurs de c0 et du pH
    """
    mat = [ [1,-1,0,0,pKa1-pH],
            [0,1,-1,0,pKa2-pH],
            [0,0,1,-1,pKa3-pH]
        ]

    pivot_ligne(mat)
    a=mat[0][4]
    b=mat[1][4]
    c=mat[2][4]

    c4 = c0 / (10**a +10**b + 10**c + 1)
    return (c4*10**a),(c4*10**b),(c4*10**c),c4

print(concentration(6,1))

import matplotlib.pyplot as plt

def courbes(c0,nbpoint=1000):
    """ Trace les courbes des quatres concentrations en fonction du pH"""
    pH=0
    pas = 14/nbpoint
    c1 = []
    c2 = []
    c3 = []
    c4 = []
    p = []


    while pH<14:
        a,b,c,d = concentration(pH,c0)
        c1.append(a)
        c2.append(b)
        c3.append(c)
        c4.append(d)
        p.append(pH)
        pH+=pas
    plt.plot(p,c1,label="c1")
    plt.plot(p,c2,label="c2")
    plt.plot(p,c3,label="c3")
    plt.plot(p,c4,label="c4")   
    plt.legend()
    plt.show()

courbes(1) 


