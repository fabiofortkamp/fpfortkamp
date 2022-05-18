---
date: "2022-05-17"
title: Aula 9 - Condensadores e Evaporadores
type: book
weight: 70
---

## Efeito do UA dos trocadores de calor sobre a potência de um sistema de refrigeração


De [1]: Um ar-condicionado de Carnot opera entre as temperaturas interna e externa de 23 e 43 ºC, respectivamente, e remove 5 kW de uma construção. A eficiência do motor do compressor e do ventilador é de 80 %, e 0,2 kW são necessários para operar o ventilador.

a) Admitindo resistências térmicas desprezíveis entre o refrigerante no condensador e o ar exterior, e entre o refrigerante no evaporador e o ar interior, calcule a potência exigida pelo motor.
b) Se as resistências térmicas totais entre o refrigerante e o ar nas seções de evaporação e de condensação forem as mesmas, 3E-3 K/W, calcule as temperaturas de condensação e de evaporação exigidas e a potência exigida pelo motor



```python
T_L = 23 + 273
T_H = 43 + 273
Qdot_L = 5
eta_m  = 0.8
Wdot_v = 0.2

COP_Carnot = T_L/(T_H-T_L)
Wdot_Carnot = Qdot_L/COP_Carnot

Wdot_ideal = (Wdot_Carnot + Wdot_v)/eta_m
print("Potência com trocadores ideais = %.2f kW" %(Wdot_ideal,))
```

```
## Potência com trocadores ideais = 0.67 kW
```

```python
R= 3.0 #K/kW
UA_H = UA_L = 1/R

T_LE = T_L - Qdot_L/UA_L
T_HE = T_H*(1 + Qdot_L/(T_L*UA_H))

COP_endot = T_LE/(T_HE-T_LE)
Wdot_endot = Qdot_L/COP_endot
Wdot_endot = (Wdot_endot + Wdot_v)/eta_m
print("Potência com trocadores imperfeitos = %.2f kW" %(Wdot_endot,))
```

```
## Potência com trocadores imperfeitos = 1.38 kW
```

Neste exemplo, o `\(UA\)` dos trocadores é igual? E se eles forem diferentes? Podemos definir, por exemplo, o `\(UA\)` do evaporador como uma fração do `\(UA\)` total, como se o *custo total* fosse fixo e o problema é distribuir esse *inventário* de condutância entre os trocadores [2]:


```python
T_L = 23 + 273
T_H = 43 + 273
Qdot_L = 5
eta_m  = 0.8
Wdot_v = 0.2

COP_Carnot = T_L/(T_H-T_L)
Wdot_Carnot = Qdot_L/COP_Carnot

Wdot_ideal = (Wdot_Carnot + Wdot_v)/eta_m
print("Potência com trocadores ideais = %.2f kW" %(Wdot_ideal,))
```

```
## Potência com trocadores ideais = 0.67 kW
```

```python
Rt= 1.5 #K/kW
UA_t = 1/Rt
y = 0.5
UA_L = y*UA_t
UA_H = (1-y)*UA_t

T_LE = T_L - Qdot_L/UA_L
T_HE = T_H*(1 + Qdot_L/(T_L*UA_H))

COP_endot = T_LE/(T_HE-T_LE)
Wdot_endot = Qdot_L/COP_endot
Wdot_endot = (Wdot_endot + Wdot_v)/eta_m
print("Potência com trocadores imperfeitos = %.2f kW" %(Wdot_endot,))
```

```
## Potência com trocadores imperfeitos = 1.38 kW
```

Em termos gráficos:


```python
import matplotlib.pyplot as plt
import numpy as np

T_L = 23 + 273
T_H = 43 + 273
Qdot_L = 5
eta_m  = 0.8
Wdot_v = 0.2

COP_Carnot = T_L/(T_H-T_L)
Wdot_Carnot = Qdot_L/COP_Carnot

Wdot_ideal = (Wdot_Carnot + Wdot_v)/eta_m
print("Potência com trocadores ideais = %.2f kW" %(Wdot_ideal,))
```

```
## Potência com trocadores ideais = 0.67 kW
```

```python
Rt= 1.5 #K/kW
UA_t = 1/Rt
y = np.linspace(0.1,0.9)
UA_L = y*UA_t
UA_H = (1-y)*UA_t

T_LE = T_L - Qdot_L/UA_L
T_HE = T_H*(1 + Qdot_L/(T_L*UA_H))

COP_endot = T_LE/(T_HE-T_LE)
Wdot_endot = Qdot_L/COP_endot
Wdot_endot = (Wdot_endot + Wdot_v)/eta_m

fig, ax = plt.subplots()
ax.plot(y,COP_endot,'k-')
ax.set_xlabel("UA(evap)/UA(total)")
ax.set_ylabel("COP")
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula8ref0001_files/figure-html/unnamed-chunk-3-1.png" width="672" />
Portanto, o COP é maximizado quando os trocadores são equilibrados; isso aponta para o perigo de sobre-otimizar um componente individual sem levar em conta o desempenho do sistema.

## Referências:

[1]: Bergman, T. L., Lavine, A. S., Incropera, F. P., & Dewitt, D. P. Fundamentos da Transferência de Calor e de Massa (7 ed.). Rio de Janeiro: LTC, 2014.

[2]: Bejan, A. Entropy generation minimization: the method of thermodynamic optimization of finite-size systems and finite-time processes. Boca Raton: CRC Press, 1996.
