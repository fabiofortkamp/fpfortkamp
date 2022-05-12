---
date: "2022-05-12"
title: Aula 5 - Caldeiras
type: book
weight: 50
status: draft
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
Se você olhar o catálogo, vai ver que sim.

