---
date: "2022-05-24"
title: Aula 9 Teórica - Análise de Primeira Lei de Combustão em Sistema Fechado
type: book
weight: 80
---

Quando começamos a discussão sobre trocas energéticas na combustão, começamos com um
[modelo de reação isotérmica  e isobárica](https://fpfortkamp.com/disciplinas/mte0001/aula7mte0001/), o que nos levou ao conceitos de *entalpia de formação* e *poder calorífico*. Em seguida, relaxamos a hipótese de isotermia e consideramos reações na qual a temperatura varia; no limite, se a reação for *adiabática*, os produtos vão absorver toda a energia liberada e atingir a temperatura máxima, a [*temperatura adiabática de chama*](https://fpfortkamp.com/disciplinas/mte0001/aula8mte0001/). Está na hora de relaxar a hipótese de pressão constante; ela é boa para modelar a combustão que acontece *em regime permanente* quando o combustível e o ar escoam (com perda de pressão desprezível), mas não representa o que acontece em motores de combustão interna, onde o ar e o combustível entram, as válvulas fecham, e a reação acontece em um sistema fechado.

## Primeira Lei para Sistemas Fechados

Nesse caso, voltamos à aplicação da Primeira Lei da Termodinâmica entre reagentes e produtos:


$$
Q_{R-P} - W_{R-P} = U_P - U_R
$$

onde agora não podemos considerar o trabalho isobárico, e portanto não podemos usar diretamente a entalpia. Entretanto, como já temos relações bem estabelecidas para a entalpia, e para evitar uma "energia interna de formação", podemos aplicar a transformação:

$$
U = H - P\mathcal{V}
$$

Portanto,

$$
U_P = H_P - P_P \mathcal{V}_P
$$
Usando a definição de entalpia molar, e considerando que cada "fase" `\(k\)` (reagentes ou produtos) tem `\(m_k\)` componentes:

$$
H_k = \sum_{j=1}^{m_k} n_j \left( \overline{h} _{f,j}^o(T _o,P _o) + \left(\overline{h} _{\mathrm{sens},j} (T,P) - \overline{h} _{\mathrm{sens},j} (T _o,P _o)\right)\right)
$$
Para o volume, aplicamos a *Lei de Amagat* [1]: o volume total de uma mistura de gases ideais é a soma dos volumes parciais nas condições da mistura:

$$
\mathcal{V} _k = \sum _{j=1}^{m _k} n _j (P _k\ \overline{v} _j (T _k,P _k))
$$
Observe que

$$
P_k\ \overline{v}_j (T_k,P_k) = R_u T_k
$$
para qualquer gás ideal *j*.

### Exemplos de reações de sistemas fechados:

Ex. 15-68 de [1]: Um tanque com volume constante contém uma mistura de 120g de gás metano e 600g de gás oxigênio a 298 K e 200 kPa. O conteúdo do tanque é então incendiado, e o gás metano queima completamente. Considerando que a temperatura final é de 1200 K, determine a pressão final do tanque e a quantidade de calor transferida durante esse processo.

Ex. 15-71 de [1]: Um tanque com volume constante contém uma mistura de 1 kmol de benzeno e 30% de excesso de ar a 25 ºC e 1 atm. O conteúdo do tanque é incendiado e todo o hidrogênio do combustível queima em vapor d'água, mas apenas 92% do carbono queimam em `\(\mathrm{CO2}\)`; os 8% restantes formam `\(\mathrm{CO}\)`. Considerando que a temperatura final é de 1000 K, determine a quantidade de calor transferida da câmara de combustão durante esse processo.

**Sugestão**: usando os exemplos trabalhados na [aula passada](https://fpfortkamp.com/disciplinas/mte0001/aula8mte0001/) como guia, implemente os exercícios acima em Python!

## Transferência de calor de reação

Nos exemplos anteriores, a temperatura dos gases era dada. De onde vem esse calor? Esta temperatura é estabelecida pelo pelo sistema de arrefecimento sob risco de superaquecer as partes metálicas do motor. *Correlações experimentais* de transferência de calor são usadas para calcular as relações entre taxas e temperaturas, principalmente da forma [2]:

$$
\mathrm{Nu} = C \mathrm{Re}^m \mathrm{Pr}^n
$$

onde o número de Nusselt baseado no diâmetro do cilindro `\(D\)` é:

$$
\mathrm{Nu} = \frac{\hbar D}{k}
$$ 

O coeficiente de transferência de calor `\(\hbar\)` é definido pela chamada *Lei de Resfriamento de Newton*:

$$
\hbar = \frac{\dot{Q}}{A \left(T_P - T_{\mathrm{parede}}\right)}
$$

onde `\(A\)` é a área de transferência de calor entre os produtos da combustão e a parede.

O número de Reynolds que usa a velocidade média do pistão é [2]

$$
\mathrm{Re} = \frac{2 L N D}{\nu}
$$
onde `\(L\)` é o curso do pistão. 

Essas correlações usam as propriedades dos gases de combustão: a viscosidade cinemática `\(\nu\)`, a condutividade térmica `\(k\)` e o número de Prandtl `\(\mathrm{Pr}\)`. Como uma primeira aproximação, as propriedades do ar na temperatura média entre parede e gases (já que tudo são gases ideais).

Para a transferência de calor após a combustão, [2] recomenda `\(C = 0.4, m = 0.75, n = 0.4\)`.

### Exemplo

Considere um motor de combustão interna mono-cilindro quadrado de diâmetro 5 cm na rotação de 2500 rpm; gasolina com PCI de 44 MJ/kg e fração combustível-ar  de 0,0685 é queimada estequiometricamente, onde os reagentes entram a 300 K e 1 atm. Se a parede do cilindro deve ser mantida a 400 K, qual será a temperatura dos gases? Assuma que 1/3 da energia liberada na combustão é transportada para a parede (o restante vira trabalho e energia dos gases de escapamento)


```python
import math
from CoolProp.CoolProp import PropsSI

N = 2500

D = 5e-2
L = D
A = math.pi*D*L
V = math.pi*D**2 * L/4

T_R = 300
P_R = 101325
rho_a_i = PropsSI("D","T",T_R,"P",P_R,"Air")
eta_v = 0.8
m_dot_a = rho_a_i * eta_v * V*(N/60)*1/2
F = 0.0685
PCI = 44e6
T_parede = 400

Qdot = 1/3*m_dot_a*F*PCI

# hipótese
T_P = 2000
P_P = P_R*(T_P/T_R)

T_f = (T_P + T_parede)/2
mu = PropsSI("VISCOSITY","T",T_f,"P",P_P,"Air")
rho = PropsSI("D","T",T_f,"P",P_P,"Air")
k = PropsSI("CONDUCTIVITY","T",T_f,"P",P_P,"Air")
Pr = PropsSI("PRANDTL","T",T_f,"P",P_P,"Air")

nu = mu/rho

C = 0.4
m = 0.75
n = 0.4

Re = 2 * L * (N/60)*D/nu
Nu = C*Re**m * Pr**n
h = Nu*k/D

T_P = T_parede + Qdot/(A*h)
print(T_P)
```

```
## 912.2443877051958
```

Para terminar: como agora a temperatura de parede deve ser mantida?

## Referências

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

