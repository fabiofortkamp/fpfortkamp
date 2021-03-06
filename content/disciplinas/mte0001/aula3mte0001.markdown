---
date: "2022-04-06"
title: Aula 3 Teórica - Ciclos Reais de Motores de Combustão Interna
type: book
weight: 40
---

## Ciclos indicados e potência indicada

[Anteriormente](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/) descrevemos os ciclos ideias de motores de combustão interna e como calcular a eficiência e o trabalho específico líquido dos ciclos, e discutimos a influência de cada parâmetro.

Estes ciclos são *aproximações*, que usam as *Hipóteses do Padrão a Ar Frio*, que tentam ser mais realistas que o [Ciclo de Carnot](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/) ao descrever o funcionamento dos motores, enquanto ainda são facilmente analisáveis. As tendências e a importância dos parâmetros (e.g. razão de compressão) previstas pelos ciclos ideais, de maneira geral, se confirmam nos motores reais [1].

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

Por quê o consumo específico é menor em motores Diesel? Por que eles são mais eficientes, conforme visto [anteriormente](https://fpfortkamp.com/disciplinas/mte0001/aula2mte0001/). Podemos definir agora uma eficiência global: o combustível flui com `\(\dot{m}_{\mathrm{c}}\)` e têm um poder calorífico inferior PCI (a quantidade de energia por massa de combustível que é liberada na combustão, e que vamos estudar mais para a frente; esse valor é de ca. 44 MJ, sem grandes diferenças entre gasolina e Diesel). A eficiência global é:

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

## Referências

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[2]: Brunetti, F. Motores de Combustão Interna - Volume 1. São Paulo: Blucher, 2012.

[3]: Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.

[4]: Nieto Garzón, N. A., Oliveira, A. A. M., Hartmann, R. M. et al. Experimental and thermodynamic analysis of a compression ignition engine operating with straight soybean oil. J Braz. Soc. Mech. Sci. Eng. 37, 1467–1478 (2015). https://doi.org/10.1007/s40430-014-0287-z


