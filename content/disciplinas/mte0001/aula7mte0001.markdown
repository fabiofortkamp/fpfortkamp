---
date: "2022-05-09"
title: Aula 7 Teórica - Poder calorífico
type: book
weight: 60
---

Quando analisamos os [ciclos termodinâmicos ideais](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/), a tarefa básica é aplicar a Primeira Lei da Termodinâmica ao sistema composto pelo ar contido no cilindro. Por exemplo, sendo 2 o estado do ar antes da combustão e 3 o estado após, o calor entregue pela fonte quente ao ar por unidade de massa do fluido, é:

$$
q _{\mathrm{ent}} = (u_3 - u_2)
$$

onde `\(u\)` é a energia interna específica do ar. Usando as Hipóteses do Padrão a Ar Frio, podemos expressar a variação de energia interna como função da variação de temperaturas, mas isso não é necessário. Muitas referências, e.g. [1] dispõe de tabelas de `\(u(T)\)` para o ar:

{{< figure src="ig-shapiro.png" caption="Fonte: [1]">}}

O que está plotado nessa tabela? Os valores individuais de energia não têm significado físico, pois só conseguimos medir variações de energia indiretamente através de medições de calor ou trabalho e aplicando a Primeira Lei da Termodinâmica [2].

O que está plotado nessa tabela é o valor de `\(u\)` *em relação a um valor arbitrário* `\(u_0\)`. Podemos reescrever a equação anterior como:

$$
q_{\mathrm{ent}} = (u_3 - u_0) - (u_2 - u_0)
$$

e podemos ver que o valor particular de `\(u_0\)` não importa.

Na análise de combustão de máquinas térmicas, porém, temos de levar em conta que [em uma reação de combustão diferentes produtos vão se formar](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/). Cada substância (oxigênio, nitrogênio, dióxido de carbono, vapor d'água) vai ter o termo `\(u_{0, subst.}\)` e esses termos não vão se cancelar. Assim, quando se analisam reações químicas do ponto de vista energético, o estado de referência é importante.

## Entalpia de reação

Considere um volume de controle geral ao redor de um motor de combustão interna, 

{{< figure src="engine-cv-heywood.png" caption="Fonte: [3]">}}

Vamos aplicar a Primeira Lei da Termodinâmica à mistura de reagentes (ar e combustível - simbolizados por "R") que vão formar os produtos (simbolizados por "P"). Sendo `\(Q\)` o calor que entra e `\(W\)` o trabalho que sai, temos:

$$
Q_{R-P} - W_{R-P} = U_P - U_R
$$

O modelo mais básico de reação é *isotérmica e isobárica*, onde a pressão e a temperatura são mantidas no **estado padrão** que serve de referência (por convenção) para os cálculos de energia: `\(P = P_o = 1\,\mathrm{atm}\)`, `\(T = T_o = 298\,\mathrm{K}\)`.

O trabalho de um sistema que se expande isobaricamente é:

$$
W_{R-P} = P_o(\mathcal{V}_P - \mathcal{V}_R)
$$

onde `\(\mathcal{V}\)` é o volume da mistura, donde temos:

$$
Q_{R-P} = H^o_P - H_R^o = \Delta H^o < 0
$$

onde `\(H_i^o = U_i (T_o) + P_o \mathcal{V}_i (T_0,P_0)\)`. A grandeza `\(-\Delta H^o\)` é chamada de *calor (ou entalpia) de reação (ou combustão)* [3].

## Entalpia de formação

Como calcular os termos de entalpia na definição de entalpia de reação? 

Seja `\(j\)` o estado ($j = {R,P}$), e `\(n_j\)` o número de componentes em cada estado.

Nesse modelo inicial (onde, repetimos, a reação é isotérmica e isobárica), as entalpias só podem variar por conta da composição, já que o estado termodinâmico intensivo está fixado.

A entalpia de um componente `\(i\)` no estado padrão é a sua *entalpia de formação padrão*, que é um valor tabelado considerando que a entalpia de formação dos seguintes componentes é nula [4]: `\(\mathrm{O}_2, \mathrm{N}_2, \mathrm{H2}, \mathrm{C}, \mathrm{S}\)`.

Seja `\(j\)` o estado ($j = {R,P}$), e `\(m_j\)` o número de componentes em cada estado. Cada componente individual `\(i\)` tem o seu número de moles no estado `\(j\)` `\(n_{i,j}\)`. Então:

$$
H_j = \sum_{i=1}^{r_j} n_{i,j} \overline{h}_{f,i}^o
$$

onde a barra é para enfatizar que a entalpia é na base molar.


## Explorando dados de entalpia de formação

Vamos voltar à tabela de dados de combustíveis e componentes [1,3], que pode ser baixada [aqui](http://fpfortkamp.com/disciplinas/mte0001/hformation.csv)


```r
hf = read.csv("hformation.csv")
hf
```

```
##                Substance     Formula M.kg.kmol. Enthalpy.of.formation.kJ.kmol.
## 1                 Carbon        C(s)      12.01                              0
## 2                 Sulfur        S(s)     32.054                              0
## 3         Sulfur dioxide      SO2(g)     64.066                        -267100
## 4           Hydrogen gas       H2(g)      2.016                              0
## 5           Nitrogen gas       N2(g)      28.01                              0
## 6             Oxygen gas       O2(g)      32.00                              0
## 7         Carbon dioxide      CO2(g)      44.01                        -393520
## 8        Carbon monoxide       CO(g)      28.01                        -110530
## 9                  Steam      H2O(g)      18.02                        -241820
## 10                 Water      H2O(l)      18.02                        -285830
## 11     Hydrogen peroxide     H2O2(g)      34.02                        -136310
## 12               Ammonia      NH3(g)      17.03                         -46190
## 13                Oxygen        O(g)      16.00                         249170
## 14              Hydrogen        H(g)      1.008                         218000
## 15              Nitrogen        N(g)      14.01                         472680
## 16              Hydroxyl       OH(g)      17.01                          39460
## 17               Methane      CH4(g)      16.04                         -74850
## 18             Acetylene     C2H2(g)      26.04                         226730
## 19              Ethylene     C2H2(g)      28.05                          52280
## 20                Ethane     C2H6(g)      30.07                         -84680
## 21             Propylene     C3H6(g)      42.08                          20410
## 22               Propane     C3H8(g)      44.09                        -103850
## 23                Butane    C4H10(g)      58.12                        -126150
## 24               Pentane    C5H12(g)      72.15                        -146440
## 25          Octane vapor    C8H18(g)     114.22                        -208450
## 26         Octane liquid    C8H18(l)     114.22                        -249910
## 27               Benzene     C6H6(g)      78.11                          82930
## 28  Methyl alcohol vapor    CH3OH(g)      32.04                        -200890
## 29 Methyl alcohol liquid    CH3OH(l)      32.04                        -238810
## 30   Ethyl alcohol vapor   C2H5OH(g)      46.07                        -235310
## 31  Ethyl alcohol liquid   C2H5OH(l)      46.07                        -277690
## 32              Gasoline CnH1.87n(l)        110                             NA
## 33          Light Diesel  CnH1.8n(l)        170                             NA
## 34          Heavy Diesel  CnH1.7n(l)        200                             NA
## 35           Natural Gas  CnH3.8n(l)      N0.1n                             NA
##    Gibbs.function.of.formation..kJ.kmol. Absolute.entropy..kJ.kmolK. HHV.kJ.kg.
## 1                                      0                        5.74      32770
## 2                                     NA                          NA         NA
## 3                                     NA                          NA         NA
## 4                                      0                      130.57     141780
## 5                                      0                      191.50         NA
## 6                                      0                      205.03         NA
## 7                                -394380                      213.69         NA
## 8                                -137150                      197.54         NA
## 9                                -228590                      188.72         NA
## 10                               -237180                       69.95         NA
## 11                               -105600                      232.63         NA
## 12                                -16590                      192.33         NA
## 13                                231770                      160.95         NA
## 14                                203290                      114.61         NA
## 15                                455510                      153.19         NA
## 16                                 34280                      183.75         NA
## 17                                -50790                      186.16      55510
## 18                                209170                      200.85      49910
## 19                                 68120                      219.83      50300
## 20                                -32890                      229.49      51870
## 21                                 62720                      266.94      48920
## 22                                -23490                      269.91      50350
## 23                                -15710                      310.03      49500
## 24                                 -8200                      348.40      49010
## 25                                 17320                      463.67      48260
## 26                                  6610                      360.79      47900
## 27                                129660                      269.20      42270
## 28                               -162140                      239.70      23850
## 29                               -166290                      126.80      22670
## 30                               -168570                      282.59      30590
## 31                                174890                      160.70      29670
## 32                                    NA                          NA      47300
## 33                                    NA                          NA      46100
## 34                                    NA                          NA      45500
## 35                                    NA                          NA      50000
##    LHV.kJ.kg.
## 1       32770
## 2          NA
## 3          NA
## 4      119950
## 5          NA
## 6          NA
## 7          NA
## 8          NA
## 9          NA
## 10         NA
## 11         NA
## 12         NA
## 13         NA
## 14         NA
## 15         NA
## 16         NA
## 17      50020
## 18      48220
## 19      47160
## 20      47480
## 21      45780
## 22      46360
## 23      45720
## 24      45350
## 25      44790
## 26      44430
## 27      40580
## 28      21110
## 29      19920
## 30      27720
## 31      26800
## 32      44000
## 33      43200
## 34      42800
## 35      45000
```



```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.5     v purrr   0.3.4
## v tibble  3.1.6     v dplyr   1.0.8
## v tidyr   1.2.0     v stringr 1.4.0
## v readr   2.1.2     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
p <- ggplot(data = hf, )
p + geom_col(mapping=aes(x = reorder(Substance,-Enthalpy.of.formation.kJ.kmol.), y = Enthalpy.of.formation.kJ.kmol.))  +
  coord_flip() + 
    labs(y = "Standard enthalpy of formation [kJ/kmol]", x = "Substance")
```

```
## Warning: Removed 4 rows containing missing values (position_stack).
```

<img src="/disciplinas/mte0001/aula7mte0001_files/figure-html/unnamed-chunk-2-1.png" width="672" />
Os componentes com entalpia de formação padrão negativa são aqueles onde o calor de reação *sai* do sistema. Observe os componentes com valor positivo: é preciso fornecer uma grande quantidade de energia para obter nitrogênio monoatômico.

## Exemplo 1

Calcular a entalpia de reação da combustão estequiométrica de metano

$$
\mathrm{C} \mathrm{H}_4  + a_t\left(\mathrm{O}_2 + 3.76 \mathrm{N}_2\right) \to a \mathrm{CO2} + b \mathrm{H_2O} + c\mathrm{N}_2
$$

```python
import pandas as pd

HFDF = pd.read_csv("hformation.csv",index_col=0)

def hfo(component):
  return float(HFDF["Enthalpy of formation(kJ/kmol)"][component])

def MM(component):
  return float(HFDF["M(kg/kmol)"][component])

## Balanço de reações
a = 1
b = 2
at = a + b/2
c = 3.76*at

HP = a*hfo("Carbon dioxide") + b*hfo("Steam") + c*hfo("Nitrogen gas")
HR = hfo("Methane") + at*hfo("Oxygen gas") + 2.76*at*hfo("Nitrogen gas")

DeltaH = HP - HR
print("Calor de reação = %.2f kJ/kmol" %(-DeltaH))
```

```
## Calor de reação = 802310.00 kJ/kmol
```

E onde entra o tal *poder calorífico inferior*? Compare o valor


```python
print("%.2f kJ/kg" %(-DeltaH/MM("Methane")))
```

```
## 50019.33 kJ/kg
```

Com o valor de PCI do metano retirado da tabela:


```python
def LHV(component):
  return float(HFDF["LHV(kJ/kg)"][component])

print("%.2f kJ/kg" %(LHV("Methane")))
```

```
## 50020.00 kJ/kg
```

E você vai compreender que o *Poder Calorífico Inferior* é a entalpia de reação escrita na base mássica, *considerando uma reação estequiométrica isotérmica no estado padrão*.

### Poderes caloríficos inferior e superior

O *poder calorífico superior* pode ser obtido da mesma forma, supondo que a água está na forma líquida; repetindo o código anterior:


```python
# 'steam' foi trocado por 'water'
HP = a*hfo("Carbon dioxide") + b*hfo("Water") + c*hfo("Nitrogen gas")
HR = hfo("Methane") + at*hfo("Oxygen gas") + 2.76*at*hfo("Nitrogen gas")

DeltaH = HP - HR
print("Calor de reação (água líquida) = %.2f kJ/kg" %(-DeltaH/MM("Methane")))
```

```
## Calor de reação (água líquida) = 55506.86 kJ/kg
```

```python
print("PCS retirado da tabela = %.2f kJ/kg" %(float(HFDF["HHV(kJ/kg)"]["Methane"])))
```

```
## PCS retirado da tabela = 55510.00 kJ/kg
```

As diferenças podem ser devido a diferentes erros de medição nas entalpias, na massa molar e no poder calorífico.

### Exemplo de medição de poder calorífico

Falando nisso, como o poder calorífico pode ser medido [4]?

Uma amostra de 1 g de determinado combustível é queimada em um calorímetro que contém 2 kg de água na presença de 100 g de ar na câmara de reação. Considerando que a temperatura se eleva em 2,5 ºC quando equilíbrio é estabelecido, determine o poder calorífico do comsbutível.


## Referências

[1]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.

[2]: Callen, H. B. Thermodynamics and an Introduction to Thermostatistics (2nd ed.). John Wiley and Sons, 1985.

[3]: Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.

[4]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

