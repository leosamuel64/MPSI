def extraitDonnées(Chemin):
    res = []
    entrée = open(Chemin,'r')
    for ligne in entrée:
        t,v,va=map(float,ligne.strip().split(";"))
        res.append([t,v,va])
    entrée.close
    return res

extraitDonnées("aubisque.csv")

def distance_et_dénivelé_Total(chemin):
    valeur=extraitDonnées(chemin)
    
    distance = 0
    dénivelé = 0


    for i in range(len(valeur)-1):

        Dtps = valeur[i+1][0]-valeur[i][0]
        distance += Dtps*valeur[i][1]
        dénivelé += Dtps*valeur[i][2]


    return distance, dénivelé

print(distance_et_dénivelé_Total("aubisque.csv"))

def DistanceOpti(chemin):
    """Entrée : adresse de csv
    Sortie : un tableau qui contient les données du fichier"""
    dist=0
    entrée= open(chemin, "r")
    tprec, vprec, vaprec = map(float,entrée.readline().strip().split(";"))
    for ligne in entrée :
        #on récupère instant de la mesure, vitesse et vitesse ascentionnelle
        #t,v,va : à l'instant ti
        #tprec,vprec,vaprec : à l'instant t(i-1)
        t, v, va = map(float,ligne.strip().split(";"))
        dt=t-tprec
        dv=(v+vprec)/2
        dist+=dv*dt
        tprec,vprec,vaprec=t,v,va
    entrée.close()
    return dist

#print(DistanceOpti("aubisque.csv"))

def Opti(chemin):
    """Entrée : adresse de csv
    Sortie : un tableau qui contient les données du fichier"""
    dist=0
    deniv=0
    entrée= open(chemin, "r")
    tprec, vprec, vaprec = map(float,entrée.readline().strip().split(";"))
    for ligne in entrée :
        #on récupère instant de la mesure, vitesse et vitesse ascentionnelle
        #t,v,va : à l'instant ti
        #tprec,vprec,vaprec : à l'instant t(i-1)
        t, v, va = map(float,ligne.strip().split(";"))
        dt=t-tprec
        dv=(v+vprec)/2
        dist+=dv*dt
        dva=(va+vaprec)/2
        deniv+=dva*dt
        tprec,vprec,vaprec=t,v,va
    entrée.close()
    return dist,deniv

print(Opti("aubisque.csv"))


import matplotlib.pyplot as plt

def profil(chemin):
    dist=0
    deniv=0
    tdist=[0]
    talt=[563]

    entrée= open(chemin, "r")
    tprec, vprec, vaprec = map(float,entrée.readline().strip().split(";"))
    for ligne in entrée :
        #on récupère instant de la mesure, vitesse et vitesse ascentionnelle
        #t,v,va : à l'instant ti
        #tprec,vprec,vaprec : à l'instant t(i-1)
        t, v, va = map(float,ligne.strip().split(";"))
        dt=t-tprec
        dv=(v+vprec)/2
        dist+=dv*dt
        tdist.append(dist)
        dva=(va+vaprec)/2
        deniv+=dva*dt
        talt.append(deniv+563)
        tprec,vprec,vaprec=t,v,va
        
    entrée.close()

    plt.plot(tdist,talt)
    plt.show()
    return dist,deniv

profil("aubisque.csv")