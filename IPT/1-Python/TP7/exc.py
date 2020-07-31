import matplotlib.pyplot as plt
import numpy as np

K0 = 3*10**(-59)

def f(alpha):
    return 2*K0*(1-alpha)**2*(1+alpha/2)-alpha**3

def trace_f(xmin,xmax, N=100):
    tx=np.linspace(xmin,xmax,N)
    ty= [f(x) for x in tx]
    plt.plot(tx,ty)
    plt.grid()
    plt.show()

trace_f(-1,2)