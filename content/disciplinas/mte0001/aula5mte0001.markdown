---
date: "2022-04-19"
title: Aula 5 Teórica - Combustíveis
type: book
weight: 50
---

Nas aulas anteriores, nós investigamos o funcionamento de motores de combustão interna (MCI), através dos seus ciclos [ideais](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/) e [reais](https://fpfortkamp.com/disciplinas/mte0001/aula3mte0001/). A análise básica que foi feita era calcular as entradas e saídas de calor e o trabalho líquido obtido.

O trabalho é obtido *a partir* do calor fornecido, e portanto agora é um bom momento para estudarmos a combustão, a fonte de energia para as máquinas térmicas que vamos trabalhar no nosso curso.

A reação de combustão é uma reação exotérmica que acontece entre gases; os combustíveis líquidos são primeiro vaporizados (nos MIF, pela vela; nos MIE, pela transferência de calor com ar quente pressurizado). Quando a temperatura na câmara de combustão é alta o suficiente, forma-se uma *chama* que se propaga em direção às paredes do cilindro; nos MIF, essa chama se inicia próximo à vela, enquanto nos MIE diversos pontos formam uma chama [1].

## Que características de combustíveis importam?

Vamos voltar aos dados de eficiência de motores vistos na [aula 1](https://fpfortkamp.com/disciplinas/mte0001/aula1mte0001/), mas agora separar de acordo com o *fuel type*:


```r
library(tidyverse)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(shape=fl))+
  labs(x = "Cilindrada [litros]", y = "Eficiência em rodovias [milhas por galão]")
```

<img src="/disciplinas/mte0001/aula5mte0001_files/figure-html/unnamed-chunk-1-1.png" width="672" />

Não foi possível encontrar informações sobre o que quer dizer cada símbolo - uma amostra de como, na engenharia, grande parte do trabalho é simplesmente ir atrás de informações. Mas não vamos nos prender nisso; o objetivo é ver se há alguma tendência clara de combustíveis. Aparentemente, os carros mais eficientes entre todos usam o que deve ser "diesel" - o que já tínhamos explorado na análise de ciclos. Na faixa de alta cilindrada, os carros mais eficientes usam o que deve ser "gasolina premium" - mas já tínhamos notado que esses pontos são de carros esportivos, mais caros, e que portanto devem ser testados com combustíveis mais refinados. 

Como visto [anteriormente](https://fpfortkamp.com/disciplinas/mte0001/aula3mte0001/), a *eficiência global* de um motor é a razão entre a potência efetiva (que sai do eixo) e o calor liberado na combustão. Pode-se mostrar que:

$$
\eta_{\mathrm{g}} = \eta_{\mathrm{t}} \eta_{\mathrm{m}}
$$

onde a eficiência térmica `\(\eta_{\mathrm{t}}\)` e a eficiência mecânica `\(\eta_{\mathrm{m}}\)` dependem muito pouco do fluido utilizado.

Podemos também mostrar que:

$$
\eta_{\mathrm{g}} = \frac{1}{\dot{C}_{\mathrm{c}} {\mathrm{PCI}}}
$$

Portanto, a primeira propriedade que importa dos combustíveis é o seu *poder calorífico inferior*. Este é um valor "tabelado", embora não seja constante; ele usualmente é medido em uma reação controlada no *estado padrão*: 1 atm, 25 ºC.

A tabela abaixo contém dados de [1] e [2]:


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
p <- ggplot(data = hf, mapping=aes(x = reorder(Substance,-LHV.kJ.kg.), y = LHV.kJ.kg.))
p + geom_col()  + coord_flip() + 
    labs(y = "PCI [kJ/kg]", x = "Substância")
```

```
## Warning: Removed 14 rows containing missing values (position_stack).
```

<img src="/disciplinas/mte0001/aula5mte0001_files/figure-html/unnamed-chunk-3-1.png" width="672" />

Observem a ordem de magnitude do poder calorífico! Mas como isso influencia o desempenho de motores?

Exercício adaptado 2.8 de [1]: calcular o consumo específico de iso-octano, gasolina, etanol, hidrogênio; considerar um MIF com eficiência global de 0,3, independente do combustível.


```python
# in MJ/kg, from [1]
PCI_dict = {
"Gasoline": 44,
"Isooctane": 44.3,
  "Ethanol": 26.9,
  "Hydrogen": 120
}

etag = 0.3

print("Consumo específico:")
```

```
## Consumo específico:
```

```python
for fuel in PCI_dict:
  # 1 MJ = 1000 kW*s = 1/3.6 kWh
  ce = 1/(etag*PCI_dict[fuel]/3.6)
  print("%s: %.3f kg/kWh" %(fuel,ce))
```

```
## Gasoline: 0.273 kg/kWh
## Isooctane: 0.271 kg/kWh
## Ethanol: 0.446 kg/kWh
## Hydrogen: 0.100 kg/kWh
```

Mas:


```python

# in USD/kg
prices = {
"Gasoline": 1.4*0.748,
"Ethanol": 1.07*0.79,
"Hydrogen": 14 
}

etag = 0.3

print("Preço por potência:")
```

```
## Preço por potência:
```

```python
for fuel in prices:
  # 1 MJ = 1000 kW*s = 1/3.6 kWh
  ce = 1/(etag*PCI_dict[fuel]/3.6)
  pe = ce*prices[fuel]
  print("%s: %.3f USD/kWh" %(fuel,pe))
```

```
## Gasoline: 0.286 USD/kWh
## Ethanol: 0.377 USD/kWh
## Hydrogen: 1.400 USD/kWh
```

Por que há essas diferenças?

## Composição de combustíveis

A maioria dos combustíveis usados em máquinas térmicas são *derivados do petróleo*: misturas de hidrocarbonetos com pequenas frações de enxofre (como no caso do Diesel), nitrogênio e oxigênio (como no caso de etanol).

O gás hidrogênio, conforme exposto acima, têm alto poder calorífico, mas ele não vêm do petróleo (não tem carbono), e precisa ser separado do oxigênio na água. Como teremos oportunidade de ver, isso requer *grande* quantidade de energia, energia essa que muitas vezes é gerada por reações de combustão. Na prática, os motores a hidrogênio apenas transferem a reação de combustão, dos veículos para usinas termelétricas, mas isso geralmente aumenta a eficiência [3].

A gasolina muitas vezes é modelada como `\(\mathrm{C_8 H_{18}}\)`, o que significa que para cada 8 kmol de átomos de C há 9 kmol de `\(\mathrm{H_2}\)` (que é como costumamos representar o hidrogênio). Mas o quanto isso representa em massa?

A quantidade de 1 kmol de uma substância `\(i\)` pesa `\(M_i\)`, o seu peso molecular, que é tabelado e constante para cada substância. Por exemplo, as massas moleculares do carbono e hidrogênio respectivamente são:


```python
import pandas as pd

hfdf = pd.read_csv("hformation.csv",index_col=0)

for component in ["Hydrogen gas","Carbon"]:
  print("M(%s) = %.2f kg/kmol" %(component,float(hfdf["M(kg/kmol)"][component])))
  
```

```
## M(Hydrogen gas) = 2.02 kg/kmol
## M(Carbon) = 12.01 kg/kmol
```

Portanto:

1. Qual a composição em base mássica da gasolina?
2. Qual a composição em base mássica do etanol `\(\mathrm{C}\mathrm{H}_3\mathrm{O}_{0.5}\)`?

## Composição do ar

O combustível na verdade só precisa de oxigênio para queimar; a não ser em temperaturas muito altas, quando se oxida, ele é inerte, mas deve entrar nos balanços de massa e energia. Na verdade, a maior parte do ar é nitrogênio: de cada 100 litros de ar seco, 78,09 L é de gás nitrogênio (o restante é oxigênio e outros gases).

A proporção acima está na *base volumétrica* ou *molar*; vamos sempre assumir a hipótese de que todos os fluidos gasosos são gases ideais, e todos os gases ideais na mesma pressão e temperatura ocupam o mesmo volume, independente de qual gás seja. Portanto, de maneira aproximada, podemos dizemos que 100 kmol de ar seco contém 79 kmol de gás nitrogênio e 21 de gás oxigênio. Em termos proporcionais, cada kmol de `\(\mathrm{O_2}\)` vem acompanhado de 79/21 = 3,76 kmol de `\(\mathrm{N_2}\)`.

Qual a massa molecular de 1 kmol de ar, então? E qual a sua constante de gás?

## Combustão estequiométrica 

Determinar a composição do ar e comsbutível é fundamental para escrever a reação *estequiométrica* do combustível, isto é, uma reação completa onde não sobra oxigênio nos produtos e:

1. Todo o carbono se oxida em dióxido de carbono
2. Todo o hidrogênio se oxida em vapor d'água
3. Todo o enxofre se oxida em dióxido de enxofre

De maneira geral:

$$
\mathrm{C}_n \mathrm{H}_m \mathrm{N}_p \mathrm{O}_q \mathrm{S} + a_t\left(\mathrm{O}_2 + 3.76 \mathrm{N}_2\right) \to a \mathrm{CO2} + b \mathrm{H_2O} + c\mathrm{N}_2 + d \mathrm{SO}_2 
$$
onde os 5 coeficientes são determinados a partir de balanços de massa dos 5 elementos presentes na equação.

Ex. 3.1 de [1]: isooctano é suprido a um MIF de 4 cilindros a 2 g/s. Calcule a vazão de ar para uma condição estequiométrica. Se o motor de 2,4 L está operando a 1500 rpm, estime a eficiência volumétrica.


## Referências

[1]: Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.

[2]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.

[3]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.


