---
date: "2022-05-12"
title: Aula 6 - Caldeiras
type: book
weight: 50
---

## Alimentação de caldeiras

Considere um gerador de vapor que opera a 141 bar e consome 100 kg/s de vapor. As bombas [deste catálogo](https://www.shinkohir.co.jp/pdf/catalog/Centrifugal_Pumps_CL-100D.pdf) dão conta do recado?


```python
from CoolProp.CoolProp import PropsSI

P1 = 1e5
T1 = 25 + 273
u1 = PropsSI("U","P",P1,"T",T1,"Water")
rho1 = PropsSI("D","P",P1,"T",T1,"Water")

s1 = PropsSI("S","P",P1,"T",T1,"Water")

P2 = 141e5
s2 = s1
u2 = PropsSI("U","P",P2,"S",s1,"Water")
rho2 = PropsSI("D","P",P2,"S",s1,"Water")
g = 9.81

mdot_v = 100
Vdot_v = mdot_v / rho1


H = 1/g*(P2/rho2 - P1/rho1) + (u2-u1)/g
print("Capacity = %.2f m3/h" %(Vdot_v*3600,))
```

```
## Capacity = 361.05 m3/h
```

```python
print("Head = %.2f m" %(H,))
```

```
## Head = 1426.86 m
```

```python
print((u2-u1)/g)
```

```
## 4.4199799340862445
```
Se você olhar o catálogo, vai ver que sim.

## Ciclo regenerativo - desaeração

De [1]: Uma usina de potência opera em um ciclo regenerativo de vapor com um AAA aberto. Vapor entra no primeiro estágio da turbina a 12 MPa e 520 ˚C e expande a 1 MPa, onde parte do vapor é extraído e direcionado a um AAA aberto operando nessa pressão. O restante do vapor expande através do segundo estágio da turbina até 6 kPa. Líquido saturado sai do AAA a 1 MPa. Considerando processos isentrópicos na turbina e na bomba, calcule:
a) eficiência térmica
b) Vazão de vapor no primeiro estágio da turbina, em kg/h, para uma potência líquida de 330 MW.
Em seguida, compare esses valores com um ciclo Rankine com superaquecimento operando nas mesmas condições sem regeneração. Calcule a economia de combustível (em kg/s), considerando óleo de caldeira (PCI = 41,6 MJ/kg) com eficiência de caldeira de 85%.



```python
from CoolProp.CoolProp import PropsSI

P_cald = 12e6
T6 = 520
P_AAA = 1e6
P_cond = 6e3
W_dot_liq = 330e6

fluid = 'Water'

print("Ciclo com regeneração")
```

```
## Ciclo com regeneração
```

```python
h1 = PropsSI("H","P",P_cond,"Q",0,fluid)
v1 = 1.0/PropsSI("D","P",P_cond,"Q",0,fluid)

h2 = h1 + v1*(P_AAA-P_cond)

h3 = PropsSI("H","P",P_AAA,"Q",0,fluid)
v3 = 1.0/PropsSI("D","P",P_AAA,"Q",0,fluid)

h4 = h3 + v3*(P_cald-P_AAA)

h5 = PropsSI("H","P",P_cald,"Q",1,fluid)
h6 = PropsSI("H","P",P_cald,"T",T6+273,fluid)
s6 = PropsSI("S","P",P_cald,"T",T6+273,fluid)

s7 = s6
h7 = PropsSI("H","P",P_AAA,"S",s7,fluid)

s8 = s6
h8 = PropsSI("H","P",P_cond,"S",s8,fluid)

y = (h3-h2)/(h7-h2)

wTI = h6-h7
wTII = (1-y)*(h7-h8)
wBI = (1-y)*(h2-h1)
wBII = (h4-h3)

w_liq = wTI + wTII - wBI - wBII

q_cald = h5-h4
q_superaq = h6-h5
q_ent = q_cald + q_superaq

eta = w_liq / q_ent
print("Eficiência = %.2f %%" %(100*eta))
```

```
## Eficiência = 45.54 %
```

```python
m_dot_v = W_dot_liq / w_liq

m_dot_v_kg_h = m_dot_v * 3600
print("Vazão de vapor = %.2f kg/h" %(m_dot_v_kg_h))
```

```
## Vazão de vapor = 992657.36 kg/h
```

```python
Q_ent_reg = m_dot_v*q_ent

print()
```

```python
print("Ciclo sem regeneração")
```

```
## Ciclo sem regeneração
```

```python
h1 = PropsSI("H","P",P_cond,"Q",0,fluid)
v1 = 1.0/PropsSI("D","P",P_cond,"Q",0,fluid)

h2 = h1 + v1*(P_cald-P_cond)

h3 = PropsSI("H","P",P_cald,"Q",1,fluid)
h4 = PropsSI("H","P",P_cald,"T",T6+273,fluid)
s4 = PropsSI("S","P",P_cald,"T",T6+273,fluid)

s5 = s4
h5 = PropsSI("H","P",P_cond,"S",s5,fluid)


wT = h4-h5
wB = (h2-h1)

w_liq = wT  - wB

q_cald = h3-h2
q_superaq = h4-h3
q_ent = q_cald + q_superaq

m_dot_v = W_dot_liq / w_liq

Q_ent_super = m_dot_v * q_ent

eta = w_liq / q_ent
print("Eficiência = %.2f %%" %(100*eta))
```

```
## Eficiência = 42.36 %
```

```python
m_dot_v_kg_h = m_dot_v * 3600
print("Vazão de vapor = %.2f kg/h" %(m_dot_v_kg_h))

## Consumo de combustível
```

```
## Vazão de vapor = 865829.53 kg/h
```

```python
eta_c = 0.85
PCI = 41.6e6
Deltam = (Q_ent_super - Q_ent_reg)/(eta_c * PCI)

print("Redução no consumo ao usar regeneração = %.2f kg/s de óleo" %(Deltam))
```

```
## Redução no consumo ao usar regeneração = 1.54 kg/s de óleo
```

## Variação da densidade da água líquida e vapor com a pressão


```python
import matplotlib.pyplot as plt
import numpy as np

P = np.linspace(1e5,160e5)
rhol = np.array([PropsSI("D","P",Pi,"Q",0,"Water") for Pi in P])
rhov = np.array([PropsSI("D","P",Pi,"Q",1,"Water") for Pi in P])

fig, ax = plt.subplots()
ax.plot(1e-5*P,rhol,'k-')
ax.plot(1e-5*P,rhov,'k--')
ax.set_xlabel("Pressão [bar]")
ax.set_ylabel("Densidade [kg/m3]")
ax.grid()
plt.show()
```

<img src="/disciplinas/st1gee1/aula6st1gee1_files/figure-html/unnamed-chunk-3-1.png" width="672" />

## Referências

[1]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.





