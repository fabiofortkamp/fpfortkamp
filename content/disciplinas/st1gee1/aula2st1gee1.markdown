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

## E do lado dos gases?

Muito do que foi visto até aqui provavelmente é apenas uma revisão. A grande questão dessa disciplina é juntar cálculos do Ciclo Rankine com cálculos da combustão.

Fazemos agora uma análise de Primeira Lei na Fornalha. O ar entra a `\(T_{\mathrm{ar}}\)` e carrega uma certa umidade absoluta `\(\omega_{\mathrm{ar}}\)` (na mesma temperatura). O combustível entra a `\(T_{\mathrm{cb}}\)` e vazão `\(\dot{m}_{\mathrm{cb}}\)`, em relação à qual todas as vazões são referenciadas. Quando escrevemos `\(m_i\)`, sem o ponto em cima, estamos falando da vazão do componente `\(i\)` por unidade de vazão de combustível. Essas grandezas específicas podem ser calculadas com base na reação de combustão e na composição dos combustíveis, conforme será visto mais para frente.

O combustível entra em combustão e libera o seu *poder calorífico inferior* `\(\mathrm{PCI}\)`. A soma do PCI e das energias sensíveis do ar e do combustível é o *calor disponível na combustão*:

$$
\dot{Q} _{\mathrm{D}} = \dot{m} _{\mathrm{cb}} \left(h _{\mathrm{cb}} + m _{\mathrm{ar}}\left(h _{\mathrm{ar}} + \omega _{\mathrm{ar}} h _{\mathrm{\omega}}\right) + \mathrm{PCI}\right)
$$

Parte desse calor é liberado para as paredes d'água `\(\dot{Q}_{\mathrm{P}}\)`, para o superaquecedor `\(\dot{Q}_{\mathrm{S}}\)` e para o reaquecedor `\(\dot{Q}_{\mathrm{R}}\)`. Estas três grandezas são associadas à análise do Ciclo Rankine.

O que resta de energia na fornalha se reverte em *energia residual dos gases e das cinzas*:

$$
\dot{Q}  _{\mathrm{G}} = \dot{m} _{\mathrm{cb}}\left(m _{\mathrm{g}}h _{\mathrm{g}} + m _\mathrm{cz}h _{\mathrm{cz}}\right)
$$

O balanço de energia na fornalha é então

$$
\dot{Q} _{\mathrm{D}} = \dot{Q} _{\mathrm{P}} + \dot{Q} _{\mathrm{R}} + \dot{Q} _{\mathrm{S}} + \dot{Q} _{\mathrm{G}}
$$


Há mais uma simplificação que pode ser feita: assumimos que a temperatura de referência de todas as substâncias é 0 ºC, com isso:

$$
h_i = c_{p,i} T_i
$$

onde, ressalte-se a temperatura deve ser em graus Celsius. O calor espeecífico de cada substância pode ser computado com tabelas apropriadas [1], e deve ser computado na temperatura média entre 0 ºC e a temperatura do componente (i.e. metade da temperatura do componente). Outra simplificação usada é assumir que as cinzas e os gases estão na mesma temperatura `\(T_{\mathrm{g}}\)`.

## Referências


[1]: Bazzo, E. Geração de vapor (2 ed.). Florianópolis: Editora UFSC, 1995.

[2]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[3]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.


