#! /usr/bin/python3
# -*- coding: utf-8 -*-
import numpy as np


# Tracer les courbes
import matplotlib.pyplot as plt

def dessin( M0, c, r, d, tf, t0=0, D0=0, R0=0, dt=1):
    tt, tX =euler( M0, c, r, d, tf, t0=t0, D0=D0,R0=R0, dt=dt) #Adapter ici selon le nom et l'ordre des arguments de votre fonction.
    plt.plot(tt, [X[0] for X in tX], label="sains")
    plt.plot(tt, [X[1] for X in tX],label="décédés")
    plt.plot(tt, [X[2] for X in tX], label="rétablis")
    plt.plot(tt, [X[3] for X in tX], label="malades")
    
    plt.xlabel("Temps (jours)")
    plt.ylabel("Proportion de population")
    plt.legend()
    plt.show()
    print("{} morts".format(tX[-1][1]*70e6))




# Pour extraire les données expérimentale


chemin_confirmés="time_series_covid19_confirmed_global.csv"# À modifier si le fichier est ailleurs...
ligne_france=118
# La ligne 0 donne les noms des colonnes, en particulier les dates
#début au 22 janvier
avant_confinement = 9+29+10 # Nb de jours entre le début des mesures et le début du confinememt en France.


def enlève_année(c):
    """Entrée : chaîne de caractère représentant une date au format "j/m/a", l'année sur deux chiffres.
     Sortie : la date sans l'année."""
    return c[:-3]


def extrait_donnée(début, fin, chemin=chemin_confirmés):
    """
    Entrée : deux indices début et fin
    Sortie : deux tableaux : (dates, nb de malades officiellement recencés)
             On ne renvoie que les données qui correspondent à une date située entre début et fin après le 22 janvier.
    """
    entrée=open(chemin)
    premièreLigne=list(map(enlève_année,entrée.readline().split(",")[4+début:4+fin]))
    for x in range(ligne_france-2):
        entrée.readline()
    d=list(map(int, entrée.readline().split(",")[4+début:4+fin]))
    return premièreLigne, d



def dessins_données_passé(début, fin, chemin=chemin_confirmés):
    premièreLigne, d = extrait_donnée(début, fin, chemin=chemin)
    # plt.plot(premièreLigne, d, label="cas confirmés" )
    # plt.xlabel("date")
    # plt.ylabel("nombre de cas")
    # plt.legend()
    # plt.title("nombre de cas en fonction de la date")
    # plt.show()

    plt.plot(premièreLigne, np.log(d), label="ln(cas confirmés)" )
    plt.title("ln(nombre de cas) en fonction de la date")
    plt.xlabel("date")
    plt.legend()
    plt.show()
