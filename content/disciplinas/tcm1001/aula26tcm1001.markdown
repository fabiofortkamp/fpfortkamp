---
date: "2022-05-24"
title: Aula 26 - Perda de carga em trocadores de calor
type: book
weight: 80
---

## Revisando o projeto

Revisitando o exemplo da [aula anterior](https://fpfortkamp.com/disciplinas/tcm1001/aula25tcm1001), vamos testar diferentes soluções e calcular o que varia entre as diferentes soluções *viáveis* de projeto (que garantem a transferência de calor entre os requisitos de temperatura e vazão):




```python
from CoolProp.CoolProp import PropsSI
from math import pi, log
import numpy as np

P1 = 10e3
P2 = 2e6

h1 = PropsSI("H","P",P1,"Q",0,"Water")
s1 = PropsSI("S","P",P1,"Q",0,"Water")

s2 = s1
h2 = PropsSI("H","P",P2,"S",s2,"Water")

h3 = PropsSI("H","P",P2,"Q",1,"Water")
s3 = PropsSI("S","P",P2,"Q",1,"Water")

s4 = s3
h4 = PropsSI("H","P",P1,"S",s4,"Water")

# todas as grandezas abaixo são positivas
qcald = h3-h2
wturb = h3-h4
wbomb = h2-h1
qcond = h4-h1

wliq = wturb - wbomb
eta = wliq/qcald

W_dot = 0.5e6
m_dot_v = W_dot/wliq #vazão de vapor

Q_dot_cond = qcond*m_dot_v

# água de resfriamento

t_w_ent = 15
dt_w = 10
t_w_sai = t_w_ent + dt_w

t_w_mean = (t_w_ent+t_w_sai)/2
T_w_mean = t_w_mean+273
cp_w = PropsSI("CPMASS","T",T_w_mean,"Q",0,"Water")

m_dot_w = Q_dot_cond/(cp_w*(t_w_sai-t_w_ent))

# Propriedades da água de resfriamento
# Isto não muda com o projeto do trocador
k = PropsSI("CONDUCTIVITY","T",T_w_mean,"Q",0,"Water")
rho = PropsSI("D","T",T_w_mean,"Q",0,"Water")
mu = PropsSI("VISCOSITY","T",T_w_mean,"Q",0,"Water")
Pr = PropsSI("PRANDTL","T",T_w_mean,"Q",0,"Water")

## DECISÕES DE PROJETO

D_pol_list = np.array([0.25,0.5,1,2,4])
u_m  = 5
t_tubo = 3e-3

for D_pol in D_pol_list:
  print("D = %.2f pol" %(D_pol,))
  D = D_pol*0.0254
  N = round(4*m_dot_w/(rho*u_m*pi*D**2))
  if N < 1:
    N = 1
  u_m = 4*m_dot_w/(rho*N*pi*D**2)
  
  C_dot_min = m_dot_w*cp_w
  t_v = PropsSI("T","P",P1,"Q",1,"Water")-273
  DeltaT_max = t_v - t_w_ent
  qmax = C_dot_min*DeltaT_max
  epsilon = qcond/qmax
    
  NUT = -log(1-epsilon)
  UA = NUT*C_dot_min
  
  Re = rho*u_m*D/mu
  Nu = 0.023*Re**0.8*Pr**(0.4)
  hi = Nu*k/D
  
  he = 10000
  
  U = (1/hi + 1/he)**(-1)
  
  A = UA/U
  L = A/(N*pi*D)
  De = D + 2*t_tubo
  V = pi*(De**2-D**2)/4*L*N
  
  f = (0.790*log(Re)-1.64)**(-2)
  Deltap = f*L/D*rho*u_m**2/2
  Wb = Deltap*m_dot_w/rho
  
  print("Comprimento total de cada tubo = %.2f m" %(L))
  print("Volume total de tubos = %.2g m3" %(V,))
  print("Número de tubos = %d" %(N,))
  print("Potência de bombeamento = %.2f kW" %(1e-3*Wb))
  
```

```
## D = 0.25 pol
## Comprimento total de cada tubo = 3.62 m
## Volume total de tubos = 0.056 m3
## Número de tubos = 174
## Potência de bombeamento = 4.56 kW
## D = 0.50 pol
## Comprimento total de cada tubo = 7.68 m
## Volume total de tubos = 0.049 m3
## Número de tubos = 43
## Potência de bombeamento = 4.20 kW
## D = 1.00 pol
## Comprimento total de cada tubo = 15.98 m
## Volume total de tubos = 0.047 m3
## Número de tubos = 11
## Potência de bombeamento = 3.62 kW
## D = 2.00 pol
## Comprimento total de cada tubo = 32.12 m
## Volume total de tubos = 0.049 m3
## Número de tubos = 3
## Potência de bombeamento = 2.70 kW
## D = 4.00 pol
## Comprimento total de cada tubo = 58.20 m
## Volume total de tubos = 0.057 m3
## Número de tubos = 1
## Potência de bombeamento = 1.28 kW
```
