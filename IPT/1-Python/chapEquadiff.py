#! /usr/bin/python3
# -*- coding: utf-8 -*-


############# TP sur la méthode d'Euler ####################


def semiImplicite2( t0, tf, y0, z0, F, h):
    """
    Résout l'équation f''(t) = F( f'(t), f(t), t)
    avec les CI f(t0) = y0 et f'(t0) = z0
    selon la méthode d'Euler, avec un pas de h."""

    t=t0
    y=y0 #valeur approchée de f(t)
    z=z0 #valeur approchée de f'(t)
    tt=[t]
    ty=[y]
    # Si on veut on peut garder aussi les valeurs de z dans un tab

    while t<tf:
        z += h*F(z, y, t)   #nouvelle valeur de z
        y += h*z  # nouvelle valeur de y

        # en fait la formule utilisée ici est  y_{i+1} = y_i +h*z_{i+1}
        t += h   #nouvelle valeur de t
        tt.append(t)
        ty.append(y)

    return tt, ty


def euler2( t0, tf, y0, z0, F, h):
    """
    Résout l'équation f''(t) = F( f'(t), f(t), t)
    avec les CI f(t0) = y0 et f'(t0) = z0
    selon la méthode d'Euler, avec un pas de h."""

    t=t0
    y=y0 #valeur approchée de f(t)
    z=z0 #valeur approchée de f'(t)
    tt=[t]
    ty=[y]
    # Si on veut on peut garder aussi les valeurs de z dans un tab

    while t<tf:
        y += h*z  # nouvelle valeur de y
        z += h*F(z, y-h*z, t)   #nouvelle valeur de z
        t += h   #nouvelle valeur de t
        tt.append(t)
        ty.append(y)

    return tt, ty



#### 1.1) Méthode de Verlet


def verlet( F, t0, y0, yp0, h, tf) :
    """
    Résout l'équation  f''(t) = F(f(t)) par la méthode de verlet 
    """

    t, y = t0, y0
    yprec = y0 -h*yp0 + h**2/2*F(y0)  # Valeur de y à l'intant t-h

    tt, ty = [t], [y]

    while t < tf :
        sauv=y
        y = 2*y - yprec + h**2*F(y) # nouvelle valeur de y
        yprec=sauv
        t+=h
        tt.append(t)
        ty.append(y)
        
    return tt, ty


# ex : oscillateur harmonique
# y''= -y
# y(0)=1  y'(0)=0
# -> alors y(t)=cos(t)

import matplotlib.pyplot as plt
import numpy as np

def dessin(t0, y0, yp0, F, h, tf ):
    tt, ty = verlet( F, t0, y0, yp0, h, tf) 
    plt.plot(tt,ty)


    
# Pour mardi 8 : appliquer Verlet au pendule

l= 1 #longueur du fil
g=9.81
m=0.2#en kg

import numpy as np

def F_pour_pendule(y):
    """ fonction telle que l'équation du pendule s'écrive:
    θ''(t) = F_pour_pendule(θ(t))
    """
    return -g/l*np.sin(y)

def F_pour_penduleEuler(yp,  y, t):
    return -g/l*np.sin(y)


def dessinPendule(t0, y0, yp0, h, tf ):
    tt,ty = semiImplicite2( t0, tf, y0, yp0, F_pour_penduleEuler, h)
    plt.plot(tt,ty, label="semi-implicite")

    tt,ty = euler2( t0, tf, y0, yp0, F_pour_penduleEuler, h)
    plt.plot(tt,ty, label="Euler")
    
    tt, ty = verlet( F_pour_pendule, t0, y0, yp0, h, tf) 
    plt.plot(tt,ty, label="Verlet")

    plt.show()




def nb_osc(tf, dt, theta0, thetap0):
    _,ttheta = verlet(0, tf, theta0, thetap0, F_pendule, dt)
    #Comptons les passages par 0
    res=0
    for i in range (0, len(ttheta)-1):
        if ttheta[i]>0 and ttheta[i+1]<0 :
            res+=1
    return res

def duree_osc(tf,dt,theta0,thetap0):
    tt,ttheta = verlet(0, tf, theta0, thetap0, F_pendule, dt)
    res=[]
    deja_un_passage = False
    t_dernier_passage = float("inf")

    for i in range(len(ttheta)-1):
        if ttheta[i] < 0 and ttheta[i+1]>0:
            if deja_un_passage :
                res.append(tt[i]-ttl)

            else:
                deja_un_passage= True
            ttl = tt[i]
         
    return res

    


    
