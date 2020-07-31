import numpy as np

g=9.81
rho_He=0.169
rho_Pb=1.135*10**4
rho_air=1.225
pi = np.pi


def integrale(f,a,b,N=100):
    """Calcul l'integrale de f entre a et b avec N subdivision"""
    h=(b-a)/N
    somme=(f(a)+f(b))/2
    for i in range(1,N):
        somme+= f(a+i*h)
    return h*somme


def R_exemple(x):
    return 4.5*np.sin(x*np.pi/10)


def surface(R,l):
    return 2*pi*integrale(R,0,l)

def volume(R,l):
    return pi*integrale(lambda x:R(x)**2,0,l)



def vole(R,l,e=0.01):
    return volume(R,l)*(rho_air-rho_He) >= rho_Pb*e*surface(R,l)

print(vole(R_exemple,20))



