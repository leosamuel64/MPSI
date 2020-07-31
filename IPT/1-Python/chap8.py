def rec_gauche(f,a,b,N):
    h=(b-a)/N
    somme = 0
    for i in range(0,N):
        somme += f(a+i*h)
    return h*somme

def trapezes(f,a,b,N):
    h=(b-a)/N
    somme=(f(a)+f(b))/2
    for i in range(1,N):
        somme+= f(a+i*h)
    return h*somme

## calculons pi
print(4*trapezes(lambda t:1/(1+t**2),0,1,1000))