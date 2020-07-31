def dicho(f,a,b,eps):
    """ Entrée :        - f une fonction
                        - a,b deux flottant tels que a<b
        
        Précondition :  - f est continue sur [a,b]
                        - f(a)<0 et f(b)>0 

        Sortie :        - deux nombre x et y tels que [x,y] contient une solution de l'equation
                          et |x-y| < eps  
    """

    x,y = a,b
    while y-x > eps:
        m = (x+y)/2
        if f(m)>0:
            # On a f(x)<0 et f(m)> 0
            # Donc les hypotheses du TVI sont vérifiées sur [x,m]
            y=m
        else:
            x=m
       
        
    
    return x,y

#print(dicho(lambda x:x**2-2, 0, 2, 0.0001))

def dichoRec(f,a,b,eps):
    
    if b-a<eps:
        return a,b
    else:
        m=(a+b)/2
        if f(m)>0:
            return dichoRec(f,a,m,eps)
        else:
            return dichoRec(f,m,b,eps)

print(dichoRec(lambda x:x**2-2, 0, 2, 0.0001))



