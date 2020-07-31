import time 

def Hcroissant(n):
    somme = 0
    for k in range(1,n+1):
        somme += 1/k
    return somme




def Hdecroissant(n):
    somme = 0
    for k in range (n+1,0,-1):
        somme += 1/k
    return somme

a= 1000000


print(Hcroissant(a))
print(Hdecroissant(a))
print(Hcroissant(a)-Hdecroissant(a))


"""
deb=time.time()
print(Hcroissant(a))
print(time.time()-deb)

deb=time.time()
print(Hcroissant(a))
print(time.time()-deb)
"""

"""
Laquelle est a la plus precise ?
    - La deuxieme car l'addition de flottants n'est pas commutative  

"""