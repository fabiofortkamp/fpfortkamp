---
date: "2022-04-25"
title: Aula 8 - Desempenho de Aletas
type: book
weight: 20
---


```python
from math import pi, sqrt, exp, cosh, sinh, tanh

Tinf = 20
Tb = 200
h = 1000
t = 5e-3
w = 0.1
L = 0.5
k = 100

P = 2*(w+t)
Ac = w*t
m = sqrt(h*P/(k*Ac))
thetab = Tb - Tinf

qb = h*Ac*thetab
print("Calor trocado pela base = %.2f W" %(qb))
```

```
## Calor trocado pela base = 90.00 W
```

```python
M = sqrt(h*P*k*Ac)*thetab
qa = M*(sinh(m*L)+(h/(m*k))*cosh(m*L))/(cosh(m*L)+(h/(m*k))*sinh(m*L))
print("Calor trocado pela aleta = %.2f W" %(qa))
```

```
## Calor trocado pela aleta = 583.27 W
```

```python
print("Efetividade da aleta = %.2f " %(qa/qb))
```

```
## Efetividade da aleta = 6.48
```

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,L)
theta1 = thetab*((np.cosh(m*(L-x)) + (h/(m*k))*np.sinh(m*(L-x)))/(np.cosh(m*(L)) + (h/(m*k))*np.sinh(m*(L))))

k2 = 5000000000
M2 = sqrt(h*P*k2*Ac)*thetab
m2 = sqrt(h*P/(k2*Ac))
theta2 = thetab*((np.cosh(m2*(L-x)) + (h/(m2*k2))*np.sinh(m2*(L-x)))/(np.cosh(m2*(L)) + (h/(m2*k2))*np.sinh(m2*(L))))
plt.rcParams['font.size'] = 14

fig,ax = plt.subplots()
T1 = Tinf + theta1
ax.plot(x,T1,'k-')
T2 = Tinf + theta2
ax.plot(x,T2,'k--')
ax.set_xlabel('x []')
ax.set_ylabel('Temperatura [ºC]')
ax.grid()
plt.show()
```

<img src="/disciplinas/tcm1001/aula8tcm1001_files/figure-html/unnamed-chunk-1-1.png" width="672" />

```python
qa2 = M2*(sinh(m2*L)+(h/(m2*k2))*cosh(m2*L))/(cosh(m2*L)+(h/(m2*k2))*sinh(m2*L))
print("Calor trocado pela aleta com condutuvidade maior= %.2f W" %(qa2))
```

```
## Calor trocado pela aleta com condutuvidade maior= 18989.87 W
```





```python
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams['font.size'] = 14

fig,ax = plt.subplots()
x = np.linspace(1,100)
ax.plot(x,np.tanh(x)/x,'k-')
ax.set_xlabel('mL []')
ax.set_ylabel('Eficiência de aleta []')
ax.grid()
plt.show()
```

<img src="/disciplinas/tcm1001/aula8tcm1001_files/figure-html/unnamed-chunk-2-3.png" width="672" />




```python
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams['font.size'] = 14

fig,ax = plt.subplots()
x = np.linspace(1,100)
ax.plot(x,np.tanh(x),'k-')
ax.set_xlabel('mL []')
ax.set_ylabel('tanh (mL) []')
ax.grid()
plt.show()
```

<img src="/disciplinas/tcm1001/aula8tcm1001_files/figure-html/unnamed-chunk-3-5.png" width="672" />
