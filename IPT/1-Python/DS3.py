## PARTIE 1 : GAUSS

def transpose(M,L1,L2):
    """Effectue L1<->L2"""
    M[L1],M[L2]=M[L2],M[L1]

def dilate(M,L,k):
    """ Effectue L<- k*L"""
    for j in range(len(M[L])):
        M[L][j]*=k

def transvecte(M,L1,L2,k):
    """Effectue L1 <- L1+ k*L2"""
    for j in range (len(M[L1])):
        M[L1][j] = M[L1][j]+k*M[L2][j]


def annuleColonne(M,i0,j):
    """ Précondition : M[0][j] ==1.

        Effet : utilise [i0][j] comme pivot pour annuler tous les coeff au dessus et en dessous de la case (i0,j)"""
    n = len(M)
    for i in range(n):
        if i != i0:
            transvecte(M,i,i0,-M[i][j])

def affiche_mat(M):
    for l in M:
        print(l)

def cherchePivot(M,i0,j):
    """ Entrée : (i0,j), indice de la case où on souhaite mettre le prochain pivot.
        
        Sortie : l'indice i>=i0 tq |M[i][j]| soit maximal ou None s'il n'en existe pas."""
    i=i0
    n=len(M)
    while i<n and M[i][j]==0:
        i+=1
    if i==n:
        return None
    else:
        return i

# Enfin le pg final:

def pivot_ligne(M):
    """ Applique le pivot de Gauss à la matrice M """
    p=len(M[0])
    i = 0
    for j in range(p):
        ipivot = cherchePivot(M,i,j)
        if ipivot != None:
            transpose(M,ipivot,i)
            dilate(M,i,1/M[i][j])
            annuleColonne(M,i,j)
            i+=1

mat = [ [1,2,-1,1],
        [1,0,1,0],
        [1,1,2,1]
]

pivot_ligne(mat)
#affiche_mat(mat)


## PARTIE 2 : EULER

g=9.81
R=8.314
P0=1
T0=288
M=29
m=2.7
V0=9

n=380.9


def P(a):
    return P0*(1-(0.0065*a)/(288.15))**5.255

# print(P(100))

def T(a):
    if a< 11000:
        return T0-((a/1000)*6.5)
    elif a>=11000 and a<20000:
        return 216.5
    else:
        return 216.5+((a/1000)-20) 

# print(T(31000))

def Poids():
    return m*g

# print(Poids())

def archimede(a):
    rho_a=P(a)/(R*T(a))
    V_a= (n*T(a))/P(a)

    return -rho_a*V_a*g
    
def acceleration(a):
    return (archimede(a)+Poids())/m