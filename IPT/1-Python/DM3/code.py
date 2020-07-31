import numpy as np
import matplotlib.pyplot as plt
import bib_epidemie as lib

# III
# 1 - X(t) est un vecteur, il est plus facile d'utiliser les tableaux Numpy qui gère les calculs entre
# tableau

# 2

def Xprime (X,c,d,r):
    """entrée : X qui contient X(t)
    sortie : X'(t)"""
    S,M=X[0],X[3]
    return np.array([-c*S*M,d*M,r*M,c*S*M-(d+r)*M])

M0 = 3.5/70e6
c=0.37/2
d=(19/300)
r=(1/300)

def euler(t0,tf,M0,dt,c,d,r):
    X=np.array( [1-M0,0,0,M0])
    t=t0
    tX=[]
    tt=[]
    while t<tf:
        X= X + dt*Xprime(X,c,r,d)
        tX.append(X)
        t+=dt
        tt.append(t)
    return tt,tX

def euler2(t0,tf,M0,dt,c,d,r):
    X=np.array( [1-M0,0,0,M0])
    t=t0
    tX=[]
    tt=[]
    while t<tf:
        if t> 9+29+10 :
            c=0.37
        X= X + dt*Xprime(X,c,r,d)
        tX.append(X)
        t+=dt
        tt.append(t)
    return tt,tX







# 4)
# La formule qui relie m,r et d est
# m = (d)/(d+r)
# 

# 2a)
# pour tout t € |R, 
# M'(t)=-d(d+r)M(t)
# M



# lib.dessins_données_passé(10 + 25,10 + 29 + 14)

# tx,ty=lib.extrait_donnée(10+25, 10+29+14)
# print(tx)
# print(ty)

# res = []
# for i in range (len(ty)):
#     res.append(i)

# print(np.polyfit(res,np.log(ty),1))

def dessin( M0, c, r, d, tf, t0=0, D0=0, R0=0, dt=1):
    tt, tX =euler2(t0,tf,M0,1,c,d,r) #Adapter ici selon le nom et l'ordre des arguments de votre fonction.
    plt.plot(tt, [X[0] for X in tX], label="sains")
    plt.plot(tt, [X[1] for X in tX],label="décédés")
    plt.plot(tt, [X[2] for X in tX], label="rétablis")
    plt.plot(tt, [X[3] for X in tX], label="malades")
    
    plt.xlabel("Temps (jours)")
    plt.ylabel("Proportion de population")
    plt.legend()
    plt.show()
    print("{} morts".format(tX[-1][1]*70e6))

dessin(M0,c,r,d, 300)