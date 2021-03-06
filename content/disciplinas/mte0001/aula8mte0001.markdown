---
date: "2022-05-16"
title: Aula 8 Teórica - Temperatura adiabática de chama
type: book
weight: 70
---

[Na última aula](https://fpfortkamp.com/disciplinas/mte0001/aula7mte0001/), começamos a detalhar o comportamento energético dos processos de combustão. Nosso objetivo é calcular a energia liberada quando um combustível é queimado e usar isto como dado de entrada na análise dos ciclos termodinâmicos de máquinas térmicas, e começamos isso com um modelo muito básico de reação *isobárica* e *isotérmica*, onde a variação energética é apenas devido a mudanças na composição. 

Uma reação real não é isotérmica; os produtos de combustão ficam quentes. Em Termodinâmica, geralmente estamos interessados em *limites*: "quão quentes podem ficar os gases de combustão"? A resposta é a **temperatura adiabática de chama**.

## Entalpia de uma substância fora do estado padrão

Vamos continuar assumindo que a pressão é a mesma, de maneira que as transferências de calor e trabalho se convertem em variações de entalpia.

Como vimos, a entalpia de todas as substâncias no estado padrão, devido apenas à sua energia química, é a sua entalpia de formação.

Em um estado `\((T,P)\)`, a entalpia molar de uma substância é então:

$$
\overline{h}(T,P) = \overline{h} _f^o(T _o,P _o) + \left(\overline{h} _{\mathrm{sens}} (T,P) - \overline{h} _{\mathrm{sens}} (T _o,P _o)\right)
$$
onde o termo do lado direito diz respeito a valores tabelados de entalpia de uma substância pura:


{{< figure src="ig-shapiro.png" caption="Fonte: [1]">}}

Observe que na análise energética de uma substância pura *tanto* a entalpia de formação *quanto* a entalpia sensível (i.e. dependente apenas da temperatura) no estado padrão somem e não fazem diferença nenhuma na análise.

## Primeira Lei da Termodinâmica para uma reação adiabática

Você já deve ter reparado que, ao estudar processos termodinâmicos, geralmente consideramos os limites de *processos isotérmicos* e *processos adiabáticos*. Na aula anterior estudamos as reações isotérmicas, e hoje vamos nos dedicar as reações adiabáticas, com a consideração adicional de que não há nenhuma realização de trabalho que não seja o de fronteira (que já foi incluído na entalpia).

Assim, a entalpia dos reagentes deve se conservar nos produtos:

$$
\sum_R n \left(\overline{h} _f^o + \left(\overline{h}  - \overline{h}^o  \right)\right) = \sum_P n \left(\overline{h} _f^o + \left(\overline{h} - \overline{h}^o  \right)\right)
$$

onde abandonamos o subscrito "sens" e `\(\overline{h}^o\)` é a entalpia sensível no estado padrão. 

Como a entalpia de formação via de regra diminui em uma reação (geralmente indo de zero a um valor bastante negativo), a parcela sensível da entalpia precisa aumentar para compensar. 

Usualmente, adimitimos que os produtos estão em equilíbrio termodinâmico, e portanto estão todos na mesma temperatura. A temperatura dos produtos que satisfaz o balanço acima é a a *temperatura adiabática de chama*, a máxima temperatura alcançada em uma reação de combustão (a não ser que calor ou trabalho extra sejam adicionados *ao* sistema, o que não é usual). Numa reação real, os gases saem mais frios que isso por causa da perda de calor [2].

## Cálculo da temperatura adiabática de chama com tabelas e bibliotecas computacionais

Ex. 15.81 de [2]: Octano líquido ($\mathrm{C} _8\mathrm{H} _{18}) é queimado no combustor 
adiabático de pressão constante de um motor de avião com 40% de excesso de ar. O ar 
entra nesse combustor a 600 kPa e 307 ˚C, e o combustível é injetado no combustor a 25 
˚C. Estime a temperatura na qual os produtos da combustão deixam o combustor.

### Solução usando bibliotecas computacionais

Podemos usar a biblioteca [PYroMat](http://pyromat.org/documentation.html) para isso, juntamente com [uma tabela de entalpias de formação](http://fpfortkamp.com/disciplinas/mte0001/hformation.csv); não importa que sejam de fontes separadas, pois na análise de entalpia sensível aparecem apenas *diferenças* de entalpia.


```python
import pyromat as pm
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

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
# C8H18 + 1.4ath (O2 + 3.76N2) =  aCO2 +bH2O +c O2 + d N2 
a = 8
b = 9
ath = 12.5
c = 5
d = 65.8

T0 = 298
T_reac = 307+273

Hreac = hfo("Octane liquid") + 1.4*ath*(O2.h(T=T_reac) - O2.h(T=T0))*MMO2 + 1.4*3.76*(N2.h(T=T_reac) - N2.h(T=T0))*MMN2

def Hprod(T):
  hCO2 = hfo("Carbon dioxide") + (CO2.h(T=T)-CO2.h(T0))*MMCO2
  hH2O = hfo("Steam") + (H2O.h(T=T)-H2O.h(T0))*MMH2O
  hO2 = hfo("Oxygen gas") + (O2.h(T=T)-O2.h(T0))*MMO2
  hN2 = hfo("Nitrogen gas") + (N2.h(T=T)-N2.h(T0))*MMN2
  H = a*hCO2 + b*hH2O + c*hO2 + d*hN2
  return H

fig, ax = plt.subplots()

Tvalues = np.linspace(T0,3000)
ax.plot(Tvalues,Hreac[0]*np.ones_like(Tvalues),'k--',label="Reagentes")
ax.plot(Tvalues,Hprod(Tvalues),'k-',label="Produtos")
ax.set_xlabel("Temperatura [K]")
ax.set_ylabel("Entalpia [kJ/kmol(cb)]")
ax.legend()
ax.grid(True)
plt.show()
```

<img src="/disciplinas/mte0001/aula8mte0001_files/figure-html/unnamed-chunk-1-1.png" width="672" />

Podemos calcular de maneira exata *zerando* a função "resíduo" entre os dois lados do balanço:


```python
from scipy.optimize import brentq

def fres_ad(T):
  return Hreac[0] - Hprod(T)[0]

T_min = T0
T_max = 100000

Tad = brentq(fres_ad,T_min,T_max)
print("Temperatura adiabática de chama: %.2f K" %(Tad,))
```

```
## Temperatura adiabática de chama: 1969.74 K
```











## Referências

[1]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.


[2]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

