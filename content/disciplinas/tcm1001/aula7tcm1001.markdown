---
date: "2022-04-25"
title: Aula 7 - Aletas
type: book
weight: 20
---

## Exemplos

### Exercício 3.108 de [1]


```python
from numpy.linalg import solve
import numpy as np
from math import pi, sqrt, exp

Tinf = 20
T1 = 200
h = 500
D = 5e-3
L = 50e-3
Rtc = 4e-4
k = 100
T3 = 100

P = pi*D
Atr = pi*0.25*D**2
m = sqrt(h*P/(k*Atr))
theta1 = T1 - Tinf
theta3 = T3 - Tinf

A = np.array(
  [
    [m*L - 1, -m*L-1],
    [exp(m*L)*(-1-k*m*Rtc),exp(-m*L)*(k*m*Rtc-1)]
    ]
    )
b = np.array([-theta1,-theta3])
x = solve(A,b)
C1, C2 = x
theta2 = C1 + C2
T2 = Tinf + theta2
print(T2)
```

```
## 64.75491775335973
```


```python
import matplotlib.pyplot as plt
plt.rcParams['font.size'] = 14

fig,ax = plt.subplots()
ax.plot([-L,0],[theta1,theta2],'k-')
xa = np.linspace(0,L)
thetaa = C1*np.exp(m*xa) + C2*np.exp(-m*xa)
ax.plot(xa,thetaa,'k-')
ax.set_xlabel('x [m]')
ax.set_ylabel('Excesso de temperatura [ºC]')
ax.grid()
plt.show()
```

<img src="/disciplinas/tcm1001/aula7tcm1001_files/figure-html/unnamed-chunk-2-1.png" width="672" />

### Exercício 3.129 de [1]


```python
from math import log

kA = 200
TA = 75
Tb = 100
TB = 60
Tinf = 25

kB = (sqrt(kA)*(log((TA-Tinf)/(Tb-Tinf)))/(log((TB-Tinf)/(Tb-Tinf))))**2
print(kB)
```

```
## 56.60664294295738
```

## Referências

[1]: Bergman, T. L., Lavine, A. S., Incropera, F. P., & Dewitt, D. P. Fundamentos da Transferência de Calor e de Massa (7 ed.). Rio de Janeiro: LTC, 2014.
