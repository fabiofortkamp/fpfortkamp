---
date: "2022-03-31"
title: Aula 2 - Funcionamento e componentes de geradores de vapor
type: book
weight: 30
---

## O Ciclo de Potência a Vapor com Reaquecimento

[Anteriormente](https://fpfortkamp.com/disciplinas/st1gee1/aula1st1gee1/), discutimos as aplicações de geradores de vapor, e mencionamos que, para aproveitar o máximo as altas temperaturas dos gases quentes liberados em processos de combustão industriais, geradores de vapor são usualmente empregados em ciclos de potência, onde a turbina funciona a altas temperaturas. 

Em termos de implementação de um gerador de vapor, temos um esquema assim:

{{< figure src="gerador-adaptado.png" caption="Fonte: Adaptado de [1]">}}

cujo ciclo termodinâmico aproximado seria:

{{< figure src="reaquecimento-adaptado.png" caption="Fonte: Adaptado de [2]">}}

A água é captada de uma fonte, tratada, bombeada e passa pelo economizador, onde é pré-aquecida até entrar no tambor, um vaso de pressão separador. A água é aquecida pelo vapor quente presente no tambor, e sai como líquido saturado em direção às paredes d'água - tubos fixados na parede da fornalha, onde a água recebe calor por radiação resultante do processo de combustão e é vaporizada, retornando ao tambor. Este separa o vapor saturado que passa pelos superaquecedores, vai para a primeira turbina, e ao retornar é reaquecido, antes de seguir para o segundo estágio de expansão. Observe o fluxo de gases quentes que vai transferindo calor para a água em diversos estágios.

### Exemplos



Problema 8.18 de [3]: Medições mostram que, em um ciclo Rankine ideal com superaquecimento e reaquecimento:
A temperatura na entrada da primeira turbina é de 600 ºC
A pressão na entrada da primeira turbina é de 10 MPa
A temperatura na saída do reaquecedor é de 500 ºC
A pressão de condensação é de 6 kPa
O título na entrada do condensador é de 90% (valor mínimo recomendado)
Qual a eficiência térmica desse ciclo?




```python
from CoolProp.CoolProp import PropsSI

P4 = 10e6
T4 = 600 + 273
T6 = 500 + 273
P7 = 6e3
x7 = 0.9

h1 = PropsSI("H","P",P7,"Q",0,"Water")
s1 = PropsSI("S","P",P7,"Q",0,"Water")

h8 = PropsSI("H","P",P7,"Q",1,"Water")
s8 = PropsSI("S","P",P7,"Q",1,"Water")

h7 = h1 + x7*(h8-h1)
s7 = s1 + x7*(s8-s1)

h4 = PropsSI("H","P",P4,"T",T4,"Water")
s4 = PropsSI("S","P",P4,"T",T4,"Water")


h2 = PropsSI("H","P",P4,"S",s1,"Water")

P6 = PropsSI("P","S",s7,"T",T6,"Water")
h6 = PropsSI("H","P",P6,"T",T6,"Water")

h5 = PropsSI("H","P",P6,"S",s4,"Water")

qent = (h4 - h2) + (h6-h5)
qsai = h7 - h1
wliq = qent - qsai
eta = wliq/qent
print(eta)
```

```
## 0.4419315185005392
```

## Referências


[1]: Bazzo, E. Geração de vapor (2 ed.). Florianópolis: Editora UFSC, 1995.

[2]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[3]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.


