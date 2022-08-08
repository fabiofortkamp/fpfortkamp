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
## 0.4419315185003957
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

### Exercícios numéricos

Vamos resolver o exercício 2.1 de [1]:

Primeiramente, vamos analisar um balanço de massa no atemperador (dispositivo onde água fria entra para controlar a temperatura do vapor):


```python
# Dados das tabelas do exercício
m11 = 94.1 # kg/s
m13 = 97.4
mw = m13-m11
print("Vazão no atemperador = %.1f kg/s" %(mw,))
```

```
## Vazão no atemperador = 3.3 kg/s
```

As paredes d'água são responsáveis pela mudança de estados 2-3, não esquecendo de contabilizar a saída de líquido saturado, logo:


```python
P2 = 140e5
T2 = 180+273

P3 = 140e5
T3 = 336.8 + 273
x3 = 0.99

m3 = 93
m2 = 94
mp = m2-m3
h2 = PropsSI("H","T",T2,"P",P2,"Water")
h3 = PropsSI("H","T",T3,"Q",x3,"Water")
hp = PropsSI("H","Q",0,"P",P2,"Water")

Q_dot_PA = m3*h3 + mp*hp - m2*h2
print("Calor cedido para paredes d'água = %.2f MW" %(1e-6*Q_dot_PA))
```

```
## Calor cedido para paredes d'água = 173.61 MW
```

Observe a importância do economizador: quanto mais energia o estado 2 adiciona, menos energia as paredes d'água precisa adicionar para chegar no estado 3 - o que economiza custo dos tubos e combustível.

Para os superaquecedores:


```python
m8 = m9 = 100
T8 = 440 + 273
P8 = 135e5

T9 = 520+273
P9 = 130e5

h8 = PropsSI("H","T",T8,"P",P8,"Water")
h9 = PropsSI("H","T",T9,"P",P9,"Water")
Q_dot_S = m8*(h9-h8)
print("Calor cedido para superaquecedores = %.2f MW" %(1e-6*Q_dot_S))
```

```
## Calor cedido para superaquecedores = 23.88 MW
```

Para os reaquecedores:


```python
m10 = 94.1
T10 = 340 + 273
P10 = 32e5

T13 = 520+273
P13 = 28e5

Pw = 140e5
Tw = 180+273
h10 = PropsSI("H","T",T10,"P",P10,"Water")
h13 = PropsSI("H","T",T13,"P",P13,"Water")
hw = PropsSI("H","T",Tw,"P",Pw,"Water")
Q_dot_R = m13*h13 - (m10*h10 + mw*hw)
print("Calor cedido para reaquecedores = %.2f MW" %(1e-6*Q_dot_R))
```

```
## Calor cedido para reaquecedores = 48.23 MW
```

Já para a questão 2.2, temos:


```python
m_dot_cb = 20
Tcb = 25+273
PCI = 17.473e6
mar = 7.357
omega = 0.013
mg = 8.080
mcz = 0.295
Tar = 300+273

cpcb = 1.5e3
cpar = 1e3
cpvp = 2e3 # @ 150 ºC de temperatura média

# Calor liberado na combustão:
Q_dot_d = m_dot_cb*(PCI + cpcb*(Tcb-273) + mar*(cpar + omega*cpvp)*(Tar-273))
print("Calor liberado na combustão = %.2f MW" %(1e-6*Q_dot_d))
```

```
## Calor liberado na combustão = 395.50 MW
```


```python
Q_dot_G = Q_dot_d - (Q_dot_PA + Q_dot_S + Q_dot_R)

# assumir uma temperatura de 1000ºC, de maneira que 
cpg = 1.15e3
cpcz  = 1.08e3

# Balanço de energia no lado dos gases:
Tg = Q_dot_G/(m_dot_cb*(mg*cpg + mcz*cpcz))
print("Temperatura dos gases = %.2f ºC" %(Tg,))
```

```
## Temperatura dos gases = 779.30 ºC
```

Esse valor deveria ser corrigido, calculando um novo calor específico na nova temperatura média.

## Referências


[1]: Bazzo, E. Geração de vapor (2 ed.). Florianópolis: Editora UFSC, 1995.

[2]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[3]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.


