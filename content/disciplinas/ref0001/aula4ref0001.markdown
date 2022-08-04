---
date: "2022-04-20"
title: Aula 4 - Tipos de Compressores
type: book
weight: 40
---

## Modelagem de compressores alternativos

A vazão dos compressores alternativos não é a vazão ideal [mostrada na aula anterior](https://fpfortkamp.com/disciplinas/ref0001/aula3ref0001/), mas inclui a eficiência volumétrica: restrições induzidas pelo volume morto e perdas nas válvulas.

[Neste post](https://fpfortkamp.com/post/superheat/), você pode ver como os dados de um datasheet de compressor podem ser convertidos em texto, o que é a eficiência volumétrica e como ela é calculada.

O modelo mais básico de eficiência volumétrica inclui apenas a expansão do volume morto:

$$
\eta_{\mathrm{v,VM}} = 1 + \varepsilon\left(1-\frac{v _{\mathrm{asp}}}{v _{\mathrm{desc}}}\right)
$$

onde `\(\varepsilon\)` é a relação entre o volume morto e a cilindrada.

Uma análise bastante útil que se faz é, ao considerar possíveis variações do ciclo de refrigeração, verificar o que acontece quando o mesmo compressor é usado com diferentes trocadores de calor, isto é, quando as condições de evaporação e condensação mudam.

Nos códigos abaixo vemos como as métricas variam conforme a temperatura de evaporação varia, mantendo a temperatura de condensação fixa, e usando o Ciclo Padrão ideal (sem superaquecimento ou subresfriamento, compressão ideal).


```python
import matplotlib.pyplot as plt
import numpy as np
from CoolProp.CoolProp import PropsSI

fluid = 'R600a'
Vd = 13.54e-6 # in m3
n = 60 #Hz
z = 1


Vd_dot = Vd * n * z # m3/s
fig30, ax30 = plt.subplots()

Tcond = 35
Tevap_list = np.linspace(-35,35)
etav_list = []
mdot_list = []

Pcond = PropsSI("P","T",Tcond+273,"Q",1,fluid)
h4 = PropsSI("H","P",Pcond,"Q",0,fluid)
epsilon = 0.01

for Te in Tevap_list:
  v1 = 1.0/PropsSI("D","T",Te+273,"Q",1,fluid)
  s1 = PropsSI("S","T",Te+273,"Q",1,fluid)
  v2 = 1.0/PropsSI("D","P",Pcond,"S",s1,fluid)
  h1 = PropsSI("H","T",Te+273,"Q",1,fluid)
  etav = 1 + epsilon*(1-v1/v2)
  mdot = etav * Vd_dot/v1
  qL = (h1-h4)*1e-3
  mdot_list.append(3600*mdot)
  etav_list.append(100*etav)

ax30.plot(Tevap_list,mdot_list,'ko-',label="Mass Flow Rate")
ax30.set_xlabel("Evaporating temperature [ºC]")
ax30.set_ylabel("Mass flow rate [kg/h]")

ax40 = ax30.twinx()
ax40.plot(Tevap_list,etav_list,'kx--',label="Volumetric efficiency")
ax40.set_ylabel("Volumetric efficiency [%]")
ax40.grid()
fig30.legend()
plt.show()
```

<img src="/disciplinas/ref0001/aula4ref0001_files/figure-html/unnamed-chunk-1-1.png" width="672" />


```python
import matplotlib.pyplot as plt
import numpy as np
from CoolProp.CoolProp import PropsSI

fluid = 'R600a'
Vd = 13.54e-6 # in m3
n = 60 #Hz
z = 1


Vd_dot = Vd * n * z # m3/s
fig30, ax30 = plt.subplots()

Tcond = 35
Tevap_list = np.linspace(-35,35)
qL_list = []
QL_list = []

Pcond = PropsSI("P","T",Tcond+273,"Q",1,fluid)
h4 = PropsSI("H","P",Pcond,"Q",0,fluid)
epsilon = 0.01

for Te in Tevap_list:
  v1 = 1.0/PropsSI("D","T",Te+273,"Q",1,fluid)
  s1 = PropsSI("S","T",Te+273,"Q",1,fluid)
  v2 = 1.0/PropsSI("D","P",Pcond,"S",s1,fluid)
  h1 = PropsSI("H","T",Te+273,"Q",1,fluid)
  etav = 1 + epsilon*(1-v1/v2)
  mdot = etav * Vd_dot/v1
  qL = (h1-h4)*1e-3
  qL_list.append(qL)
  QL_list.append(mdot*qL)
  
ax30.plot(Tevap_list,qL_list,'ko-',label="Effect")
ax30.set_xlabel("Evaporating temperature [ºC]")
ax30.set_ylabel("Cooling effect [kJ/kg]")

ax40 = ax30.twinx()
ax40.plot(Tevap_list,QL_list,'kx--',label="Power")
ax40.set_ylabel("Cooling capacity [kW]")
ax40.grid()
fig30.legend()
plt.show()
```

<img src="/disciplinas/ref0001/aula4ref0001_files/figure-html/unnamed-chunk-2-3.png" width="672" />


```python

fig30, ax30 = plt.subplots()

Tcond = 35
Tevap_list = np.linspace(-35,35)
w_list = []
Wcomp_list = []

Pcond = PropsSI("P","T",Tcond+273,"Q",1,fluid)
h4 = PropsSI("H","P",Pcond,"Q",0,fluid)
epsilon = 0.01

for Te in Tevap_list:
  v1 = 1.0/PropsSI("D","T",Te+273,"Q",1,fluid)
  s1 = PropsSI("S","T",Te+273,"Q",1,fluid)
  v2 = 1.0/PropsSI("D","P",Pcond,"S",s1,fluid)
  h1 = PropsSI("H","T",Te+273,"Q",1,fluid)
  h2 = PropsSI("H","P",Pcond,"S",s1,fluid)
  
  etav = 1 + epsilon*(1-v1/v2)
  mdot = etav * Vd_dot/v1
  w = (h2-h1)*1e-3
  w_list.append(w)
  Wcomp_list.append(mdot*w)
  
ax30.plot(Tevap_list,w_list,'ko-',label="Work")
ax30.set_xlabel("Evaporating temperature [ºC]")
ax30.set_ylabel("Specific work [kJ/kg]")

ax40 = ax30.twinx()
ax40.plot(Tevap_list,Wcomp_list,'kx--',label="Power")
ax40.set_ylabel("Power [kW]")
ax40.grid()
fig30.legend()
plt.show()
```

<img src="/disciplinas/ref0001/aula4ref0001_files/figure-html/unnamed-chunk-3-5.png" width="672" />

Sugestões de outras análises:


1. Como o COP varia com a mudança nas condições de operação?
2. Inverta a análise: mantenha a temperatura de evaporação fixa e varie a temperatura de condensação. O que acontece?
3. Usando o [post](https://fpfortkamp.com/post/superheat/) como base, plote a eficiência volumétrica de volume morto (analisada acima) com a eficiência volumétrica real, variando `\(\varepsilon\)`.

