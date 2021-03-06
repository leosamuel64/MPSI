#! /usr/bin/python3
# -*- coding: utf-8 -*-

import numpy.random as rd

A = [  [0,0,1,1,0,0,0],
       [0,1,0,0,1,0,0],
       [0,1,1,1,1,0,0],
       [0,1,0,0,1,0,0],
       [0,1,0,0,1,0,0]] 

dix = [[0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0]] 

un = [ [0, 1, 0,0,0,0,0],
       [1, 1, 0,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [0, 1, 0,0,0,0,0]]

un2 = [ [0, 1, 0,0,0,0,0],
       [1, 1, 0,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [1, 1, 1,0,0,0,0]]

zéro=[ [0, 1, 0,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [0, 1, 0,0,0,0,0]]

zéro2=[ [1, 1, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [1, 1, 1,0,0,0,0]]
       
deux =[[1, 1, 0,0,0,0,0],
       [0, 0, 1,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [1, 0, 0,0,0,0,0],
       [1, 1, 1,0,0,0,0]]

trois=[[1, 1, 0,0,0,0,0],
       [0, 0, 1,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [0, 0, 1,0,0,0,0],
       [1, 1, 0,0,0,0,0]]

quatre=[[0, 1, 0,0,0,0,0],
        [1, 0, 0,0,0,0,0],
        [1, 1, 1,0,0,0,0],
        [0, 1, 0,0,0,0,0],
        [0, 1, 0,0,0,0,0]]

cinq=[ [1, 1, 1,0,0,0,0],
       [1, 0, 0,0,0,0,0],
       [1, 1, 0,0,0,0,0],
       [0, 0, 1,0,0,0,0],
       [1, 1, 0,0,0,0,0]]

six= [ [0, 1, 0,0,0,0,0],
       [1, 0, 0,0,0,0,0],
       [1, 1, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [0, 1, 0,0,0,0,0]]

sept  =[[1, 1, 1,0,0,0,0],
        [0, 0, 1,0,0,0,0],
        [0, 1, 0,0,0,0,0],
        [1, 0, 0,0,0,0,0],
        [1, 0, 0,0,0,0,0]]

huit=[ [1, 1, 1,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [0, 1, 0,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [1, 1, 1,0,0,0,0]]

neuf=[ [0, 1, 0,0,0,0,0],
       [1, 0, 1,0,0,0,0],
       [0, 1, 1,0,0,0,0],
       [0, 0, 1,0,0,0,0],
       [1, 1, 0,0,0,0,0]]

dix =  [[0,1,0,0,0,1,0],
        [1,1,0,0,1,0,1],
        [0,1,0,0,1,0,1],
        [0,1,0,0,1,0,1],
        [0,1,0,0,0,1,0]]

onze  =[[0,1,0,0,0,1,0],
        [1,1,0,0,1,1,0],
        [0,1,0,0,0,1,0],
        [0,1,0,0,0,1,0],
        [0,1,0,0,0,1,0]]

douze =[[0,1,0,0,1,1,0],
        [1,1,0,0,0,0,1],
        [0,1,0,0,0,1,0],
        [0,1,0,0,1,0,0],
        [0,1,0,0,1,1,1]]

treize=[[0,1,0,0,1,1,0],
        [1,1,0,0,0,0,1],
        [0,1,0,0,0,1,0],
        [0,1,0,0,0,0,1],
        [0,1,0,0,1,1,0]]

quatorze=[[0,1,0,0,0,1,0],
          [1,1,0,0,1,0,0],
          [0,1,0,0,1,1,1],
          [0,1,0,0,0,1,0],
          [0,1,0,0,0,1,0]]




TOUT=[(zéro,0),(zéro2,0),(un,1),(un2,1), (deux,2), (trois,3), (quatre,4), (cinq,5), (six,6), (sept,7), (huit,8), 
      (neuf,9),(dix,10),(onze,11),(douze,12),(treize,13),(quatorze,14)]
# Listes des couples (image, chiffre qu'elle représente)

NB_SORTIES=15 # Variable globale représentant le nombre de neurones de sortie



def nvLigne(n):
    res=[]
    for i in range(n):
        res.append(rd.rand())
    return res

def nvMat(n,p):
    res=[]
    for i in range(n):
        res.append(nvLigne(p))
    return res

def init_P(n,p,q):
    """ Renvoie une matrice de format (n,p,q) remplie de flottant aléatoires dans [0,1[."""
    res=[]
    for i in range(n):
        res.append( nvMat(p,q))
    return res




