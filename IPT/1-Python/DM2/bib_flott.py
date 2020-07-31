#! /usr/bin/python3
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

def rho_exemple(x,y,z):
    """ Un espèce de clou, avec la tête moins dense.
    Inclu dans [-1,1]×[-1,1]×[-1,1]."""

    if .5>y>0: # Partie haute : la tête
        if x**2+z**2<1: #C'est un cylindre de rayon 1
            return 1
        else:
            return 0
    elif -1<y<=0:
        if x**2+z**2<.25: #C'est un cylindre de rayon .5
            return 4
        else:
            return 0
    else:return 0

#Affichage

def affiche(rho,xmin, xmax, ymin, ymax, zmin, zmax,N=100,Npoints=100):
    """ Affiche l'objet et son centre de gravité.
    La couleur est proportionelle à la masse de la partie le l'objet pour un x et un y fixé, en sommant sur z."""

    dx=(xmax-xmin)/Npoints
    dy=(ymax-ymin)/Npoints
    dz=(zmax-zmin)/Npoints
    
    def pix_vers_coord(i,j,k):
        """ Pour cette fonctiom, l'origine du repère est en haut à gauche (compatible avec imshow)"""
        return (ymin+j*dy,xmax-i*dx,  zmin+k*dz)
    def coord_vers_pix(x,y,z):
        """ Pour cette fonctiom, l'origine du repère est en bas à gauche (compatible avec scatter)"""
        return (int( (x-xmin)/dx), int(Npoints-(y-ymin)/dy))
    
    im=np.empty((Npoints,Npoints),dtype=float)
    
    for i in range(Npoints):
        for j in range(Npoints):
            im[i,j] = sum(rho(*pix_vers_coord(i,j,k)) for k in range(Npoints))
    G=centre_grav(rho,xmin, xmax, ymin, ymax, zmin, zmax)
    print("Centre de gravité : ",G)
    iG, jG = coord_vers_pix(*G)
    plt.scatter([iG],[jG],label="Centre de gravité")
    plt.imshow(im)
    plt.legend()
    plt.show()


def afficheDansR1(theta,h,rho,xmin, xmax, ymin, ymax, zmin, zmax,N=100,Npoints=100):
    """ Affiche l'objet et son centre de gravité.
    La couleur est proportionelle à la masse de la partie le l'objet pour un x et un y fixé, en sommant sur z."""

    dx=(xmax-xmin)/Npoints
    dy=(ymax-ymin)/Npoints
    dz=(zmax-zmin)/Npoints
    
    def pix_vers_coord(i,j,k):
        """ Pour cette fonctiom, l'origine du repère est en haut à gauche (compatible avec imshow)"""
        return (ymin+j*dy,xmax-i*dx,  zmin+k*dz)
    def coord_vers_pix(x,y,z):
        """ Pour cette fonctiom, l'origine du repère est en bas à gauche (compatible avec scatter)"""
        return (int( (x-xmin)/dx), int(Npoints-(y-ymin)/dy))
    def rho_dans_R1(x,y,z):
        """ Entrée : coord dans R1"""
        return rho(*coord_R0_vers_coord_R1(x,y,z,theta))
    
    im=np.empty((Npoints,Npoints),dtype=float)
    
    for i in range(Npoints):
        for j in range(Npoints):
            im[i,j] = sum(rho_dans_R1(*pix_vers_coord(i,j,k)) for k in range(Npoints))
            
    # Coord du centre de grav dans R1
    G=centre_grav(rho_dans_R1,xmin, xmax, ymin, ymax, zmin, zmax)
    iG, jG = coord_vers_pix(*G)
    plt.scatter([iG],[jG],label="Centre de gravité")

    F=centre_flott(rho_dans_R1,theta,h,xmin, xmax, ymin, ymax, zmin, zmax)
    iF, jF = coord_vers_pix(*F)
    plt.scatter([iF],[jF],label="Centre de flottaison")


    eauG = coord_vers_pix(xmin,h,0)
    eauD = coord_vers_pix(xmax,h,0)
    plt.plot([eauG[0],eauD[0]], [eauG[1],eauD[1]], label="eau", color="blue")
    
    plt.imshow(im)
    plt.legend()
    plt.show()