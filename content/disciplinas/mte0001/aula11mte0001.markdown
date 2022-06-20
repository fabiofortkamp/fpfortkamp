---
date: "2022-05-24"
title: Aula 11 Teórica - "Pegadinhas" da combustão
type: book
weight: 100
---

## Algumas questões conceituais

1. Em condições típicas de combustão, a não ser que a temperatura seja muito alta, o nitrogênio presente no ar se conserva e tudo que entra sai da reação. Por precisamos colocá-lo então nas reações químicas?
2. Qual a diferença entre entalpia de combustão e entalpia de formação?
3. Considere um processo de combustão completa durante a qual os reagentes e produtos de combustão são mantidos no mesmo estado. A combustão é atingida com a) 100% de ar teórico, b) 200% de ar teórico, c) a quantidade quimicamente correta de oxigênio puro. Em qual caso a quantidade de calor transferida será menor?

## Combustão em Regime Permanente ou de Sistema Fechado

Metano é queimado com uma quantidade estequiométrica de ar, e ambas as correntes são alimentadas a 1 atm e 298 K. A temperatura final dos produtos é de 1000 K. Calcule a quantidade de calor transferido, por kmol de combustível, assumindo:

a) Combustão em regime permanente
b) Combustão em sistema fechado

A tabela em csv usada abaixo está disponível [aqui](http://fpfortkamp.com/disciplinas/mte0001/hformation.csv)


```python
import pyromat as pm
import pandas as pd

T0 = 298
P0 = 1 #atm
Treac = T0
Tprod = 1000
Ru = 8.314

HFDF = pd.read_csv("hformation.csv",index_col=0)

def hfo(component):
  return float(HFDF["Enthalpy of formation(kJ/kmol)"][component])

def MM(component):
  return float(HFDF["M(kg/kmol)"][component])

N2 = pm.get('ig.N2')
O2 = pm.get('ig.O2')
CO2 = pm.get('ig.CO2')
H2O = pm.get('ig.H2O')

MMO2 = MM("Oxygen gas")
MMCO2 = MM("Carbon dioxide")
MMH2O = MM("Steam")
MMN2 = MM("Nitrogen gas")

# Reação:
# CH4 + ath(O2 + 3.76N2) -> aCO2 + bH20 + cN2

a = 1
b = 2
ath = a + b/2
c = 3.76*ath


Hreac = hfo("Methane") + ath*(O2.h(T=Treac) - O2.h(T=T0))*MMO2 + 3.76*(N2.h(T=Treac) - N2.h(T=T0))*MMN2

def Hprod(T,correction):
  
  hCO2 = hfo("Carbon dioxide") + (CO2.h(T=T)-CO2.h(T0))*MMCO2 + correction
  hH2O = hfo("Steam") + (H2O.h(T=T)-H2O.h(T0))*MMH2O + correction
  hN2 = hfo("Nitrogen gas") + (N2.h(T=T)-N2.h(T0))*MMN2 + correction
  H = a*hCO2 + b*hH2O + c*hN2
  return H

## Regime permanente
print("Regime permanente")
```

```
## Regime permanente
```

```python
correction = 0
Q_RP = Hprod(Tprod,correction) - Hreac
print("Q = %.2f kJ/kmol(cb)" %(Q_RP))

## Sistema fechado
```

```
## Q = -555452.01 kJ/kmol(cb)
```

```python
print("Sistema fechado")
```

```
## Sistema fechado
```

```python
correction_prod = -Ru*Tprod
correction_reac = -Ru*Treac
Q_SF = Hprod(Tprod,correction_prod) - (Hreac + (1+ath)*correction_reac)
print("Q = %.2f kJ/kmol(cb)" %(Q_SF))
```

```
## Q = -635482.57 kJ/kmol(cb)
```

Por que essa diferença?

## Reagentes e produtos misturados ou não

No exemplo anterior, para o caso da combustão em regime permanente, determine a geração de entropia por kmol de combustível, para os casos:

a) Ar e combustíveis entram em correntes separadas, cada uma a 1 atm
b) Ar e combustíveis entram pré-misturados em uma tubulação a 1 atm


```python
from math import log

# Caso a)
print("Correntes separadas")
```

```
## Correntes separadas
```

```python
def sostd(component):
  """
  Return absolute entropy of  'component' in [kJ/kmol K]
  in the standard state (298 K, 1 atm)
  """
  return float(HFDF["Absolute entropy (kJ/kmolK)"][component])

s_CH4 = sostd("Methane")

# the air is provided at the standard state, 
# but each of its components are at parcial pressures
y_O2_R = 0.21
y_N2_R = 1 - y_O2_R

s_O2_R = sostd("Oxygen gas") - Ru*log(y_O2_R)
s_N2_R = sostd("Nitrogen gas") - Ru*log(y_N2_R)

S_R = s_CH4 + ath*s_O2_R + ath*3.76*s_N2_R

# in the products
n_total = a + b + c
y_CO2 = a/n_total
y_H2O = b/n_total
y_N2 = c/n_total

s_CO2 = sostd("Carbon dioxide") - Ru*log(y_CO2)
s_H2O = sostd("Water") - Ru*log(y_H2O)
s_N2 = sostd("Nitrogen gas") - Ru*log(y_N2)

S_P = a*s_CO2 + b*s_H2O + c*s_N2

S_ger_sep = S_P - S_R  - Q_RP/T0
print("S_ger = %.3f kJ/(kmol(cb) K)" %(S_ger_sep,))
```

```
## S_ger = 1648.774 kJ/(kmol(cb) K)
```


```python
# Caso b)
print("Correntes misturadas")
```

```
## Correntes misturadas
```

```python
y_cb = 1/(1+ath)
y_air = 1-y_cb

s_CH4_mist = sostd("Methane") - Ru*log(y_cb)

# the air is provided at the standard state, 
# but each of its components are at parcial pressures
y_O2_R_mist = 0.21*y_air
y_N2_R_mist = (1 - y_O2_R)*y_air

s_O2_R_mist = sostd("Oxygen gas") - Ru*log(y_O2_R)
s_N2_R_mist = sostd("Nitrogen gas") - Ru*log(y_N2_R)

S_R_mist = s_CH4_mist + ath*s_O2_R_mist + ath*3.76*s_N2_R_mist

S_ger_mist = S_P - S_R_mist  - Q_RP/T0
print("S_ger = %.3f kJ/(kmol(cb) K)" %(S_ger_mist,))
```

```
## S_ger = 1639.640 kJ/(kmol(cb) K)
```

Por que essa diferença?
