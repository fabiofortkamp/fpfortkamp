---
date: "2022-05-24"
title: Aula 10 Teórica - Análise de Segunda Lei de Combustão 
type: book
weight: 90
---

## Uma Revisão de Termodinâmica de Misturas

Na [aula passada](https://fpfortkamp.com/disciplinas/mte0001/aula9mte0001/), detalhamos uma Análise de Primeira Lei de um processo de combustão em sistema fechado. Ao fazer isso, nós aplicamos uma regra de misturas conhecida como a Lei de Amagat: quando você tem uma mistura de gases ideais (como é o gaso dos gases de combustão) a uma pressão `\(P\)` e a uma temperatura `\(T\)`, o volume da mistura é a soma dos volumes que cada gás teria se estivesse isolado na mesma temperatura `\(T\)` e pressão `\(P\)`. 

Isso não é tão óbvio quanto parece porque, em uma mistura, podemos facilmente considerar que todos os componentes estão na mesma temperatura, mas não na mesma pressão; cada gás contribui um pouco para a pressão total, já que esta é a soma das forças que as moléculas fazem sobre uma parede de área unitária.

Assim, em uma mistura de `\(k\)` componentes, consideramos que cada componente `\(i\)` tem a sua fração molar `\(y_i\)`, e a sua *pressão parcial* é `\(P_i = y_i P\)`.

### Variação de energia e entropia em um processo de mistura

Para os gases ideais, a entalpia e a energia interna são funções apenas da temperatura, então se a temperatura de cada componente é a temperatura da mistura, então a entalpia da mistura é simplesmente a soma das entalpias inviduais - e de fato fizemos isso extensivemente nas últimas aulas. *Porém, mesmo para gases ideais, a entropia depende da pressão*. Se você mistura `\(k\)` componentes individualmente na mesma temperatura `\(T\)`, a temperatura "parcial" continua sendo `\(T\)`. Se você mistura os `\(k\)` componentes, todos originalmente na mesma pressão `\(P\)`, a pressão final de cada componente não vai ser `\(P\)`, mas `\(P_i\)`, e portanto a entropia muda. 

Seja um componente `\(i\)` que estava originalmente a `\(P\)`, e após a mistura está a `\(y_i P\)`. Assumindo que a temperatura não muda, a variação da entropia de `\(i\)` durante a mistura é:

$$
\Delta s_i = s_{i,\mathrm{misturado}} - s_{i,\mathrm{isolado}} = -R_u \ln \frac{P_i}{P} = -R_u \ln y_i
$$

Como `\(y_i < 1\)`, `\(\Delta s_i > 0\)`. *O processo de mistura de gases gera entropia*, e isso tem consequências do ponto de vista da Segunda Lei da Termodinâmica.

### Processos de mistura e separação e irreversibilidades

Se, como colocado acima, o processo de mistura gera entropia, então ele é irreversível; *trabalho poderia ser gerado se o processo fosse feito de maneira controlada*:

{{< youtube 5UxCUuk4CEs >}}

e o reverso pode ser feito -  trabalho pode ser adicionado a uma mistura para separar os componentes:

{{< youtube U4xZI2WHOQo >}}

Note nos dois vídeos acima como a *pressão* da mistura é manipulada, já que, como colocado, isso afeta a entropia e então o sentido em que trabalho pode ser adicionado.

## Variação de entropia em sistemas reativos

Os exemplos acima não correspondem a reações químicas, mas simplesmente a misturas (onde não há liberação de calor ou mudança na composição), mas esses conceitos podem ser estendidos para o estudo da combustão.

Realizando um balanço de entropia em um sistema reativo entre reagentes (R) e produtos (P), que troca calor `\(Q\)` com uma fonte a `\(T_f\)`, temos:

$$
S_{\mathrm{ger}} = S _{\mathrm{P}} - S _{\mathrm{R}} - \frac{Q}{T _f}
$$
Agora: como calculamos a entropia total da *mistura* de reagentes e da *mistura* de produtos?

A **Terceira Lei da Termodinâmica** diz que a entropia de uma substância cristalina pura à temperaratura de 0 K é 0 [1]. Os gases ideais que tratamos nos produtos e nos reagentes obviamente não são substâncias cristalinas e obviamente não estão a 0 K, então precisamos calcular variações. Nós temos tabelados valores da *entropia absoluta* `\(\overline{s} _i^o\)` de diversos gases em uma dada temperatura `\(T\)` a na pressão padrão `\(P_o = 1\ \mathrm{atm}\)`. A entropia de cada componente na mistura (de reagentes ou produtos) é então:

$$
\overline{s} _i (T _m,P _i) = \overline{s} _i^o - R_u \ln \frac{y _i P _m}{P _o}
$$
onde cada fase `\(m = {R,P}\)` está na temperatura `\(T_m\)` e pressão `\(P_m\)`.

## Trabalho reversível

Como visto anteriormente, a geração de entropia devido à reação química (descontada devidamente da transferência de calor devido à reação) pode ser revertida em trabalho, mas raramente o é. O trabalho perdido durante esse processo, isto é, o máximo trabalho que poderia ser gerado, por ser computado por:

$$
W_{\mathrm{max}} = T_0 S_{\mathrm{ger}}
$$

onde `\(T_0\)` é a temperatura da vizinhança, usualmente admitida como equivalente à temperatura do estado padrão (298 K).

## Exemplos

Ex. 15-91 de [1]: Octano líquido ($\mathrm{C} _8 \mathrm{H} _{18}$) a 25 ˚C e 1 atm entra a uma vazão de 0,25 kg/min em uma câmara de combustão que opera em regime permanente. Ele é queimado com 50% de excesso de ar, que também entra na  câmara a 25 ˚C e 1 atm. Após a combustão, os produtos são resfriados até 25 ˚C.  Os  produtos saem a 1 atm e a temperatura ambiente é 298K. Considerando uma combustão completa, na qual todo a água formada está na forma líquida, determine

a) Taxa de transferência de calor da câmara de combustão;

b) Taxa de geração de entropia;

c) Taxa de destruição de trabalho.

Podemos usar a biblioteca [PYroMat](http://pyromat.org/documentation.html) para isso, juntamente com [uma tabela de entalpias de formação](http://fpfortkamp.com/disciplinas/mte0001/hformation.csv); não importa que sejam de fontes separadas, pois na análise de entalpia sensível aparecem apenas *diferenças* de entalpia.


```python
import pyromat as pm
import pandas as pd
from math import log

HFDF = pd.read_csv("hformation.csv",index_col=0)

def hfo(component):
  """
  Return enthalpy of formation of 'component' in [kJ/kmol]
  in the standard state (298 K, 1 atm)
  """
  return float(HFDF["Enthalpy of formation(kJ/kmol)"][component])

def sostd(component):
  """
  Return absolute entropy of  'component' in [kJ/kmol K]
  in the standard state (298 K, 1 atm)
  """
  return float(HFDF["Absolute entropy (kJ/kmolK)"][component])

def MM(component):
  """
  Return the molar mass of 'component' in [kg/kmol]
  """
  return float(HFDF["M(kg/kmol)"][component])

N2 = pm.get('ig.N2')
O2 = pm.get('ig.O2')
CO2 = pm.get('ig.CO2')
H2O = pm.get('ig.H2O')

MMO2 = MM("Oxygen gas")
MMCO2 = MM("Carbon dioxide")
MMH2O = MM("Water")
MMN2 = MM("Nitrogen gas")
# Reaction
# C8H18 + lbd*ath (O2 + 3.76N2) =  aCO2 +bH2O +c O2 + d N2 
lbd = 1.5
a = 8
b = 9
ath = a + b/2
c = (lbd-1)*ath
d = lbd*ath*3.76

T0 = 298
T_reactants = T0

Hreactants = hfo("Octane liquid") + lbd*ath*(O2.h(T=T_reactants) - O2.h(T=T0))*MMO2 + lbd*3.76*(N2.h(T=T_reactants) - N2.h(T=T0))*MMN2

def Hproducts(T):
  hCO2 = hfo("Carbon dioxide") + (CO2.h(T=T)-CO2.h(T0))*MMCO2
  hH2O = hfo("Water") + (H2O.h(T=T)-H2O.h(T0))*MMH2O
  hO2 = hfo("Oxygen gas") + (O2.h(T=T)-O2.h(T0))*MMO2
  hN2 = hfo("Nitrogen gas") + (N2.h(T=T)-N2.h(T0))*MMN2
  H = a*hCO2 + b*hH2O + c*hO2 + d*hN2
  return H

HP = Hproducts(T0)
H_reaction = HP - Hreactants

# First Law:
Qout = - H_reaction # in kJ/kmol(C8H18)

m_dot_C8H18 = 0.25 # kg/min
MMC8H18 = MM("Octane liquid")
n_dot_C8H18 = m_dot_C8H18/MMC8H18 #in kmol/min
Q_dot_out = n_dot_C8H18 * Qout
print("Taxa de transferência de calor = %.2f kJ/min" %(Q_dot_out))

# Second Law Calculations

# in the reactants

# the fuel is provided at the standard state alone
```

```
## Taxa de transferência de calor = 11974.09 kJ/min
```

```python
s_C8H18 = sostd("Octane liquid")

# the air is provided at the standard state, 
# but each of its components are at parcial pressures
y_O2_R = 0.21
y_N2_R = 1 - y_O2_R

R_u = 8.314 # kJ/kmol K

s_O2_R = sostd("Oxygen gas") - R_u*log(y_O2_R)
s_N2_R = sostd("Nitrogen gas") - R_u*log(y_N2_R)

S_R = s_C8H18 + lbd*ath*s_O2_R + lbd*ath*3.76*s_N2_R

# in the products
n_total = a + b + c + d
y_CO2 = a/n_total
y_H2O = b/n_total
y_O2 = c/n_total
y_N2 = d/n_total

s_CO2 = sostd("Carbon dioxide") - R_u*log(y_CO2)
s_H2O = sostd("Water") - R_u*log(y_H2O)
s_O2 = sostd("Oxygen gas") - R_u*log(y_O2)
s_N2 = sostd("Nitrogen gas") - R_u*log(y_N2)

S_P = a*s_CO2 + b*s_H2O + c*s_O2 + d*s_N2

S_ger = S_P - S_R  + Qout/T0
S_dot_ger = n_dot_C8H18*S_ger
print("Taxa de geração de entropia = %.2f kJ/min K" %(S_dot_ger,))
```

```
## Taxa de geração de entropia = 39.48 kJ/min K
```

```python
W_dot_max = S_dot_ger *T0
print("Potência máxima = %.2f kJ/min" %(W_dot_max,))
```

```
## Potência máxima = 11765.87 kJ/min
```

Ex: 14-92 de [2]: Um inventor aﬁrma ter construído um equipamento que a partir 
de 0,001 kg/s de água, obtida numa torneira a 10 ˚C e 100 kPa, produz ﬂuxos separados de 
gás hidrogênio e oxigênio, cada um a 400 K e 175 kPa. Ele diz que seu equipamento opera 
numa sala a 25 ˚C e com um consumo de 10 kW elétricos. Como você avalia esta afirmação?


```python
from CoolProp.CoolProp import PropsSI

# Reaction
# H2O - > pH2 + q O2
p = 1
q = 0.5

T0 = 298
T_reactants = 283
P_reactants = 100e3
P0 = 101.325e3

# for the reactants, we have to use liquid (not gas) properties
h_H2O_0 = 1e-3*PropsSI("H","T",T0,"P",P0,"Water")
h_H2O_R = 1e-3*PropsSI("H","T",T_reactants,"P",P_reactants,"Water")

Hreactants = hfo("Water") + (h_H2O_R - h_H2O_0)*MMH2O

MMH2 = MM("Hydrogen gas")
H2 = pm.get('ig.H2')

def Hproducts(T):
  hO2 = hfo("Oxygen gas") + (O2.h(T=T)-O2.h(T0))*MMO2
  hH2 = hfo("Hydrogen gas") + (H2.h(T=T)-H2.h(T0))*MMH2
  H = p*hH2 + q*hH2
  return H

T_products= 400
HP = Hproducts(T_products)
H_reaction = HP - Hreactants

# First Law:
W_dot = 10

m_dot_H2O = 0.001 # kg/s
n_dot_H2O = m_dot_H2O/MMH2O #in kmol/s

Win = W_dot/n_dot_H2O

Qout = -H_reaction + Win# in kJ/kmol(H2O)


Q_dot_out = n_dot_H2O * Qout # in kW

# Second Law Calculations

# in the reactants

s_H2O_0 = 1e-3*PropsSI("S","T",T0,"P",P0,"Water")
s_H2O_R = 1e-3*PropsSI("S","T",T_reactants,"P",P_reactants,"Water")

S_R = sostd("Water") + (s_H2O_R - s_H2O_0)*MMH2O

# in the product, each component is produced separately
P_each_product = 175e3

s_O2 = sostd("Oxygen gas") + (O2.s(T=T_products,p=1e-5*P0) -O2.s(T=T0,p=1e-5*P0))*MMO2 - R_u*log(P_each_product/P0)
s_H2 = sostd("Hydrogen gas") +  (H2.s(T=T_products,p=1e-5*P0) -H2.s(T=T0,p=1e-5*P0))*MMH2 - R_u*log(P_each_product/P0)

S_P = p*s_H2 + q*s_O2 

S_ger = S_P - S_R  + Qout/T0
S_dot_ger = n_dot_H2O*S_ger

print("Geração de entropia = %.2f kW/K" %(S_dot_ger,))
```

```
## Geração de entropia = -0.01 kW/K
```

O que significa esse valor negativo de geração de entropia?


## Referências

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[2]: Sonntag, R. E; Borgnakke, C.; Van Wylen, G. J. Fundamentos da Termodinâmica (6a ed.). São Paulo: Edgard Blücher, 2003.
