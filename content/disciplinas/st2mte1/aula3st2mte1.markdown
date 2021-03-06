---
date: "2022-04-06"
title: Aula 3 - Análise de Perdas em Motores de Combustão Interna
type: book
weight: 40
---

## Análise de Segunda Lei dos Ciclos Ideais

[Anteriormente](https://fpfortkamp.com/disciplinas/st2mte1/aula2st2mte1/) descrevemos os ciclos ideias de motores de combustão interna e como calcular a eficiência e o trabalho específico líquido dos ciclos, e discutimos a influência de cada parâmetro.

Em particular, estamos focando na *eficiência*.

Um Ciclo Otto ou Diesel **ideais** ainda vão ter eficiência menor que um ciclo de Carnot entre as mesmas temperaturas:


```python
import pyromat as pm
import matplotlib.pyplot as plt
import numpy as np

T1 = 35 + 273
T3 = 1500
rcomp = 9.5

air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

T2 = T1*rcomp**(k-1)
T4 = T3/(rcomp**(k-1))

qent = cv*(T3-T2)
qsai = cv*(T4-T1)
wliq = qent - qsai
eta = wliq/qent

eta_Carnot = 1 - T1/T3

print("Eficiência do ciclo Otto = %.2f %%" %(100*eta,))
```

```
## Eficiência do ciclo Otto = 59.36 %
```

```python
print("Eficiência do ciclo Carnot = %.2f %%" %(100*eta_Carnot,))
```

```
## Eficiência do ciclo Carnot = 79.47 %
```

Por que isso acontece?

Os processos de compressão e de expansão são isentrópicos, *assim como no Ciclo de Carnot*. Portanto, as perdas estão no processo de transferência de calor!


Podemos definir uma **Eficiência de Segunda Lei** como a razão entre a eficiência térmica e a eficiência térmico do Ciclo de Carnot entre as mesmas fontes.


```python
eta_II = eta / eta_Carnot
print("Eficiência de Segunda Lei para o exemplo anterior = %.2f %%" %(100*eta_II,))
```

```
## Eficiência de Segunda Lei para o exemplo anterior = 74.70 %
```

O melhoramento possível não é a eficiência térmica chegar a 100% (o que é impossível a não ser que `\(T_{\mathrm{L}} \to 0\)`  ou `\(T_{\mathrm{H}} \to \infty\)`), mas a eficiência de segunda lei chegar a 100 %.

Acontece que podemos quantificar o *trabalho perdido* em um processo e no ciclo como um todo.

Lembram da Desigualdade de Clausius?

$$
\oint\frac{\delta q}{T} \le 0
$$

Todo ciclo termodinâmico de um sistema fechado (isto é, sem reposição de fluido) deve satisfazer isso. Por que **deve**? Porque não há evidência experimental em contrário; nunca se conseguiu construir um ciclo que consiga desobedecer isso [5].

A força da desigualdade é medida pela *geração de entropia*, que por convenção é positiva:

`$$s _\mathrm{ger} = -\oint\frac{\delta q}{T} \ge 0
$$

Onde a taxa de transferência de calor é positiva quando entra no ciclo. Logo, as duas equações que regem o sistema são:

$$
q _{\mathrm{L}} + w _{\mathrm{liq}} - q _{\mathrm{H}} = 0
$$

$$
s _\mathrm{ger} = \frac{q _{\mathrm{L}}}{T _{\mathrm{L}}} - \frac{q _{\mathrm{H}}}{T _{\mathrm{H}}} \ge0
$$

Multiplicando a Segunda Lei por `\(T_{\mathrm{L}}\)`

$$
T _{\mathrm{L}}s _\mathrm{ger} = -\frac{q _{\mathrm{H}}T _{\mathrm{L}}}{T _{\mathrm{H}}} + q _{\mathrm{L}} \ge0
$$

O calor rejeitado é geralmente a grandeza que menos interessa para nós, porque nós precisamos de uma potência e temos que pagar uma adição de calor. Assim, vou expressar essa taxa como função da geração de entropia e substituir na primeira lei:

$$
\left(\frac{q _{\mathrm{H}}T _{\mathrm{L}}}{T _{\mathrm{H}}} + T _{\mathrm{L}}s _\mathrm{ger}\right) + w _{\mathrm{liq}} - q _{\mathrm{H}} = 0
$$



vamos expressar o trabalho:

$$
w _{\mathrm{liq}} =  q _{\mathrm{H}} \left(1 - \frac{T _{\mathrm{L}}}{T _{\mathrm{H}}}\right) - T _{\mathrm{L}}s _\mathrm{ger}
$$

observe que os dois termos do lado direito são positivos. O que são esses termos?

O *trabalho perdido* é uma medida do quanto a irreversibilidade contribui para que o trabalho gerado não seja tão alto quanto possível se o ciclo fosse reversível:

$$
w_{\mathrm{perdido}} = T_{\mathrm{L}}s_{\mathrm{ger}}
$$

onde fazemos um balanço de entropia em um processo, considerando estados de *entrada* (início) e *saída* de um processo:

$$
s _{\mathrm{sai}} - s _{\mathrm{ent}} = \frac{q _{\mathrm{ent}}}{T _{\mathrm{f,ent}}} + s _{\mathrm{ger}}
$$


Observe que o termo de transferência de calor incluir a temperatura de fronteira; temos que traçar um volume de controle tal que essa temperatura seja facilmente definida. Se o calor sai, esse termo é negativo.

O trabalho perdido também é chamado de *destruição de exergia*.

Para um gás ideal com calores específicos constantes (padrão a ar frio):

$$
s _{\mathrm{sai}} - s _{\mathrm{ent}} = c _v \ln \frac{T _{\mathrm{sai}}}{T _{\mathrm{ent}}} + R \ln \frac{v _{\mathrm{sai}}}{v _{\mathrm{ent}}} = c_p \ln \frac{T _{\mathrm{sai}}}{T _{\mathrm{ent}}} - R \ln \frac{P _{\mathrm{sai}}}{P _{\mathrm{ent}}}
$$

### Análise de Segunda Lei do exemplo anterior


```python
from math import log
ds = cv*log(T3/T2)
sger_23 = ds - qent/T3
sger_41 = -ds + qsai/T1
wperdido_23 = T1*sger_23
wperdido_41 = T1*sger_41
print("Trabalho perdido na combustão = %.2f kJ/kg" %(wperdido_23))
```

```
## Trabalho perdido na combustão = 41.54 kJ/kg
```

```python
print("Trabalho perdido na exaustão = %.2f kJ/kg" %(wperdido_41))
```

```
## Trabalho perdido na exaustão = 65.53 kJ/kg
```

O que isso significa na prática?

O que significam os valores de trabalho líquido e trabalho perdido?


```python
(wliq + wperdido_23 + wperdido_41)/qent - eta_Carnot
```

```
## 1.1102230246251565e-16
```

## Ciclos Reais

Mesmo ciclos ideais, portanto, têm perdas. O que dizer dos ciclos reais?

O ciclo que de fato é seguido pelos motores pode ser medido: a pressão é medida com um transdutor, e a posição do virabrequim `\(\alpha\)` em relação a uma origem (quando o cilindro analisado está com o pistão no ponto morto superior) é registrada com um sensor de rotação. Com considerações geométricas, a posição do virabrequim pode ser transformada em informações sobre o volume contido no pistão


{{< figure src="alpha-brunetti.png" caption="Fonte: [2]">}}

Sendo `\(L\)` o comprimento da biela e `\(r\)` o comprimento da manivela, pode-se mostrar que a posição `\(x\)` do pistão a partir do PMS é [2]:

$$
x = r (1 - \cos \alpha) + L \left(1 -\sqrt{1 - \left(\frac{r}{L}\right)^2 \sin^2 \alpha}\right)
$$

E o volume então varrido pelo pistão é:

$$
V = V_2 + x \frac{\pi}{4}D^2
$$

onde `\(V_2\)` é o volume morto quando o pistão está no PMS, e `\(D\)` é o diâmetro do pistão. Mais detalhes podem ser conferidos em [2].

O resultado é um diagrama assim:

{{< figure src="ciclo-otto-real.png" caption="Fonte: [2]">}}

Tome um tempo para analisar no que esta figura difere do ciclo Otto ideal. Por quê é diferente?

Uma grandeza bastante útil que pode ser obtida diretamente do diagrama acima (que é chamado de *diagrama indicado*) é o *trabalho indicado por ciclo*, [kJ/ciclo]:

$$
W_{\mathrm{i}} = \oint P \mathrm{d}\mathcal{V}
$$

onde, cuidado com dois pontos:

1. Ao contrário do que geralmente se usa com ciclos ideais, aqui o volume é o *total* [m$^3$], e não o específico [m$^3$/kg]
2. A área calculada acima não leva a pequena área contida entre os processos de admissão e descarga; para correta definição do trabalho indicada, apenas a "grande área" do diagrama acima deve ser contabilizada.

Como estabelecido anteriormente, a posição do virabrequim pode ser medida, e este sinal pode ser diferenciado para medir a *rotação* do virabrequim `\(N\)`. Seja agora `\(n_{\mathrm{R}}\)` o número de ciclos do virabrequim necessários para completar um ciclo termodinâmico; este parâmetro é igual a 2 para motores de 4 tempos e igual a 1 para motores de dois tempos.

A *potência indicada* é então:

$$
\dot{W}_{\mathrm{i}} = W _{\mathrm{i}}\frac{N}{n _{\mathrm{R}}}
$$

## Torque e potência efetiva

Ao rotacionar, o virabrequim transmite um certo *torque*, a capacidade de exercer forças sobre um certo braço de alavanca. Este torque é transmitido para a embreagem, e dali para outros sistemas.

O torque do virabrequim pode ser medido com um *dinamômetro*, medindo literamente a força que o motor faz e o braço de alavanca em relação ao ponto de medição da força:

{{< figure src="dinamometro-heywood.png" caption="Fonte: [3]">}}

Na figura acima, o torque obtido é:

$$
T = Fb
$$

E a potência *efetiva*, i.e. aquela que efetivamente sai do motor, é:

$$
\dot{W}_{\mathrm{e}} = 2\pi T N
$$

Para um determinado motor, o torque (e a potência efetiva) são *funções da rotação e da quantidade de ar e combustível presentes no cilindro*. A figura abaixo mostra exemplos de curvas de um motor Diesel, em máximo para máxima aceleração [4]:

{{< figure src="curva-motores-garzon.png" caption="Curvas de torque e potência para um motor Diesel em máxima aceleração para três combustíveis: 100% de óleo de soja (100S), 100% de óleo diesel (100D), e uma mistura de iguais proporções de cada (50S/50D). Fonte: [4]" >}}

Tome um tempo para analisar essas figuras; alguns pontos para reflexão [3]:

1. Por que o torque em altas rotações é mais baixo que em baixas rotações?
2. Por que a curva de potência tem um máximo bem definido?
3. Por que a rotação na potência máxima não é a rotação no torque máximo?

## Atrito e eficiência mecânica

A chave para entender os pontos anteriores é o *atrito*. Em motores, atrito não contempla apenas "fricção", mas toda forma de perda mecânica: aquilo que o ciclo termodinâmico entrega, que acontece com o fluido de trabalho dentro do cilindro, e que não chega na árvore de transmissão:

$$
\dot{W} _{\mathrm{a}} = \dot{W} _{\mathrm{i}} - \dot{W} _{\mathrm{e}}
$$
Com isso, definimos a *eficiência mecânica*:

$$
\eta_{\mathrm{m}} = \frac{\dot{W} _{\mathrm{e}}}{\dot{W} _{\mathrm{i}}}
$$

A eficiência mecânica de motores atuais é bem alta, superior a 90%, mas cai com rotações altas [3], porque inclui as perdas com o escoamento de gás em altas velocidades que é dissipada no processo de escape (mesmo motores turboalimentados não conseguem aproveitar energia cinética totalmente). Lembrando que, se o curso do cilindro é `\(S\)`, a velocidade média do pistão é:

$$
\overline{S}_{\mathrm{p}} = 2 S N
$$


## Pressão média

As grandezas todas de potência descritas até agora crescem com a cilindrada. De fato, podemos reescrever a equação do trabalho indicado como:

$$
W_{\mathrm{i}} = \oint P \mathrm{d}\mathcal{V} = \mathrm{PMI} \ \mathcal{V}_{\mathrm{D}}
$$
Isto é, o trabalho indicado é o produto de uma pressão média pela cilindrada.


Podemos também definir uma pressão média efetiva:

$$
\mathrm{PME} = \frac{\dot{W} _{\mathrm{e}}}{\frac{N}{n _{\mathrm{R}}} \mathcal{V} _{\mathrm{D}}}
$$
Em ordens de grandeza: motores de ignição por faísca têm PME da ordem de 1000 kPa na rotação de máximo torque. Os valores de PME na rotação de máxima potência são menores (por quê?). Os valores de PME de motores Diesel (de tamanho comparável) também são menores. Turboalimentar o motor significa aumentar sua PME [3].

### Pressão média de atrito

Esta "normalização" da potência em relação à cilindrada é bastante útil, pois podemos realizar medições com motores de construção parecida, mas tamanhos diferentes, e analisar que parâmetros importam para o atrito *que não simplesmente a cilindrada*.

Como você definiria então uma *pressão média de atrito*?

Heywood [3] apresenta uma correlação de pressão médida de atrito válida para MIF em carga total, com cilindradas de 0,8 a 2L:

$$
\mathrm{PMA}[\mathrm{bar}] = 0.97 + 0.15\frac{N[\mathrm{RPM}]}{1000} + 0.05\left(\frac{N[\mathrm{RPM}]}{1000}\right)^2
$$

*A potência de atrito depende primariamente da rotação* [3]:

- Em baixas velocidades, o que domina é o contato metálico (motor parado, sem lubrificação)
- Em médias velocidades, o que domina é o atrito viscoso dos fluidos
- Em altas velocidades, o que domina é a dissipação turbulenta dos gases em altas velocidades (proporcional à energia cinética)

## Consumo de combustível

Para funcionar e gerar uma potência efetiva `\(\dot{W}_{\mathrm{e}}\)`, em uma determinada rotação `\(N\)` e com um determinado nível de aceleração, o motor consome uma vazão de ar `\(\dot{m}_{\mathrm{a}}\)` e de combustível `\(\dot{m}_{\mathrm{c}}\)`. 

Com isso, definimos uma razão combustível-ar ($F$):

$$
F = \frac{\dot{m} _{\mathrm{c}}}{\dot{m} _{\mathrm{a}}}
$$

A razão inversa *ar-combustível* `\(r = \frac{1}{F}\)` é da ordem 12-18 para MIF e 18-70 para MIE [4].

Definimos também consumos específicos da seguinte forma:

$$
\dot{C} _{\mathrm{a}}  = \frac{\dot{m} _{\mathrm{a}}}{\dot{W} _{\mathrm{e}}}
$$

$$
\dot{C} _{\mathrm{c}}  = \frac{\dot{m} _{\mathrm{c}}}{\dot{W} _{\mathrm{e}}}
$$

O consumo específico de combustível naturalmente deve ser o menor possível. Em MIF, estamos falando em 270 g/kWh, e cerca de 20% menor em MIE [3].

Por quê o consumo específico é menor em motores Diesel? Por que eles são mais eficientes, conforme visto [anteriormente](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/). Podemos definir agora uma eficiência global: o combustível flui com `\(\dot{m}_{\mathrm{c}}\)` e têm um poder calorífico inferior PCI (a quantidade de energia por massa de combustível que é liberada na combustão, e que vamos estudar mais para a frente; esse valor é de ca. 44 MJ, sem grandes diferenças entre gasolina e diesel). A eficiência global é:

$$
\eta _{\mathrm{g}} = \frac{\dot{W} _{\mathrm{e}}}{\dot{m} _{\mathrm{c}}\mathrm{PCI}}
$$


A última eficiência que vamos usar é a eficiência volumétrica, que só é definida para motores de 4 tempos:


$$
\eta _{\mathrm{v}} = \frac{\dot{m}   _{\mathrm{a}}}{\rho _{\mathrm{a,i}} \mathcal{V}  _{\mathrm{D}}\frac{N}{2}}
$$

onde `\(\rho_{\mathrm{a,i}}\)` é a densidade do ar na admissão. A eficiência volumétrica não é de 100% por causa das perdas de carga nas válvulas, filtros e tubulações de admissão.



## Desafios:

Adaptados de [3]:

1. Encontre uma expressão para a PME como função de eficiência global, eficiência volumétrica, poder calorífico, razão combustível-ar e densidade do ar na admissão e explique por quê a PME de MIE é menor que MIF. O que isso significa?
2. Quais as vantagens e desvantagens de usar 4 válvulas por cilindro em vez de duas?
3. Como, usando apenas as equações teóricas apresentadas aqui, podemos construir uma curva real de potência?


```python
import numpy as np
N = np.linspace(1000,4000)
etav = 1
rho = 1
VD = 1e-3

m_dot_A = etav * rho * VD * (N/(2*60))
W_dot_i = m_dot_A * wliq

PMA = 0.97 + 0.15*N/1000 + 0.05*(N/1000)**2
W_dot_a = (PMA*1e2)*VD*(N/(2*60))

W_dot_e = W_dot_i - W_dot_a
fig,ax = plt.subplots()
ax.plot(N,W_dot_e)
ax.set_xlabel("Rotação [RPM]")
ax.set_ylabel("Potência efetiva [kW]")
plt.show()
```

<img src="/disciplinas/st2mte1/aula3st2mte1_files/figure-html/unnamed-chunk-5-1.png" width="672" />

## Referências

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[2]: Brunetti, F. Motores de Combustão Interna - Volume 1. São Paulo: Blucher, 2012.

[3]: Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.

[4]: Nieto Garzón, N. A., Oliveira, A. A. M., Hartmann, R. M. et al. Experimental and thermodynamic analysis of a compression ignition engine operating with straight soybean oil. J Braz. Soc. Mech. Sci. Eng. 37, 1467–1478 (2015). https://doi.org/10.1007/s40430-014-0287-z

[5]: Bejan, A. Advanced Engineering Thermodynamics. New York: John Wiley & Sons, 1988.

