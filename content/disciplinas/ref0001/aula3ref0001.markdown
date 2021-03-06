---
date: "2022-04-12"
title: Aula 3 - Variações do Ciclo Padrão de Compressão de Vapor
type: book
weight: 30
---



Na [aula anterior](https://fpfortkamp.com/disciplinas/ref0001/aula2ref0001/), falamos do Ciclo Padrão de Compressão de Vapor para Sistemas de Refrigeração. Este ciclo é mais realista que o Ciclo de Carnot ao modelar sistemas reais e considerar como de fato os componentes funcionam, especialmente em que região do domo de saturação eles trabalham.

Porém, o ciclo visto ainda é muito ideal, como pode ser visto na figura abaixo (com código para gerar o ciclo!):


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine
from CoolProp.CoolProp import PropsSI
import numpy as np
import matplotlib.pyplot as plt

plt.rc('font', size=14) 

# Vapor compression cycle analysis

# Use different color codes to change the color of the plots
color = 'r'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True

Tevap = 0 + 273
Tcond = 40 + 273
fluid = "R717"

h1 = PropsSI("H","T",Tevap,"Q",1,fluid)
s1 = PropsSI("S","T",Tevap,"Q",1,fluid)
Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
P1 = Pevap

Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)

P2 = Pcond
s2 = s1
h2 = PropsSI("H","P",P2,"S",s2,fluid)

P3 = Pcond
h3 = PropsSI("H","T",Tcond,"Q",0,fluid)

P4 = Pevap
h4 = h3

# All the states are known, now.
#
qL = h1-h4
qH = h2-h3
wcomp = h2-h1
COP = qL/wcomp


# Generate some diagrams
# Let figure 1 be a P-h diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Enthalpy, h (kJ/kg)')
ax1.set_ylabel('Pressure, P (bar)')
ax1.set_title('Vapor compression Cycle P-h Diagram')


# Generate the dome on both plots
Tt = PropsSI("TTRIPLE",fluid)
Pt = PropsSI("PTRIPLE",fluid)

Tc = PropsSI("TCRIT",fluid)
Pc = PropsSI("PCRIT",fluid)

T = np.arange(Tt,Tc,2.5)

hL = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",0,fluid) for Ti in T
])
hV = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",1,fluid) for Ti in T
])
P = 1e-5*np.array([
  PropsSI("P","T",Ti,"Q",0,fluid) for Ti in T
])

ax1.plot(hL,P,'k')
ax1.plot(hV,P,'k')

# Process 1-2
p = np.linspace(P1,P2)
h = np.array([PropsSI("H","P",Pi,"S",s1,fluid) for Pi in p])
ax1.plot(h*1e-3,1e-5*p,color,linewidth=1.5)

# Process 2-3
ax1.plot(1e-3*np.array([h2,h3]),1e-5*np.array([P2,P3]),color,linewidth=1.5)

# Process 3-4
ax1.plot(1e-3*np.array([h3,h4]),1e-5*np.array([P3,P4]),color,linewidth=1.5)

# Process 4-5
ax1.plot(1e-3*np.array([h4,h1]),1e-5*np.array([P4,P1]),color,linewidth=1.5)

ax1.grid('on')
ax1.set_yscale('log')

ax1.set_ylim(bottom = 1)
```

```
## (1, 157.92471879842554)
```

```python
ax1.set_xlim(left = 0)
```

```
## (0.0, 1882.076035779616)
```

```python
if show_text:
    ax1.text(1.03e-3*h1,0.99*1e-5*P1,"1")
    ax1.text(1.01e-3*h2,0.99*1e-5*P2,"2")
    ax1.text(0.90e-3*h3,0.99*1e-5*P3,"3")
    ax1.text(0.90e-3*h4,0.99*1e-5*P4,"4")

plt.show()
#plt.show(block=False)
```

<img src="/disciplinas/ref0001/aula3ref0001_files/figure-html/unnamed-chunk-1-1.png" width="672" />

Nesta aula, vamos ver variações do Ciclo Padrão que tornam ele mais realista.

## Vazão de refrigerante

Utilizando uma Análise de Primeira Lei, a capacidade de refrigeração e a potência de compressão são dadas por (respectivamente):

$$
\dot{Q}_{\mathrm{L}} = \dot{m}(h_1-h_4)
$$

$$
\dot{W}_{\mathrm{ent}} = \dot{m}(h_2 - h_1)
$$

De onde vem essa vazão mássica? Do compressor! Acontece que os compressores não fornecem uma vazão mássica, e sim uma *volumétrica* (eles deslocam um determinado volume de fluido). Vamos assumir um compressor ideal, sem volume morto. Assim, a vazão mássica real pode ser calculada como:

$$
\dot{m} = \frac{\dot{\mathcal{V}} _{\mathrm{D}}}{v _1}
$$

onde o numerador é a taxa de deslocamento do compressor. Para um dado compressor ideal, contendo `\(z\)` cilindros, funcionando numa determinada rotação fixa `\(n\)` (que vem da rede elétrica, geralmente), a taxa de deslocamento é:

$$
\dot{\mathcal{V}} _{\mathrm{D}} = {\mathcal{V}} _{\mathrm{D}} n z
$$

onde `\(\mathcal{V} _{\mathrm{D}}\)` é a cilindrada ou volume deslocado do motor. Observe em um [datasheet de compressor](https://products.embraco.com/commtrol/api/pdf/compressor/datasheet/7187?&condensing_temperature=54.4&evaporating_temperature=-23.3&units=w&units_temp=metric-system&filters%5Bbare%5D=513701421&filters%5Brefrigerant%5D%5B%5D=R-600a&filters%5Bstandard%5D=ASHRAE&filters%5Bfrequency%5D=60) que todos esses parâmetros são fixos na construção do compressor (com alguns detalhes que vamos vamos ver mais para a frente, como a variação da rotação ou a desativação de cilindros). Logo, é a taxa de deslocamento que é constante (para um dado compressor) e não depende do ciclo (i.e. em que temperaturas ele vai trabalhar); a vazão mássica vai depender do volume específico na sucção.

Podemos reescrever as expressões anteriores como:

$$
\dot{Q} _{\mathrm{L}} = \dot{\mathcal{V}}  _{\mathrm{D}}\frac{(h _1-h _4)}{v _1}
$$

onde o numerador da fração é chamado de *efeito refrigerante*, e a fração como um todo é chamado de *efeito refrigerante volúmico*. 

Para a potência:

$$
\dot{W} _{\mathrm{ent}} = \dot{\mathcal{V}} _{\mathrm{D}}\frac{(h _2-h _1)}{v _1}
$$

onde o numerador é o *trabalho de compressão*, a fração é o *trabalho volúmico*.

Isso vai ser importante nas análises a seguir.

## Modificações do Ciclo Padrão

Num diagrama `\(P-h\)`, o efeito refrigerante  e o trabalho de compressão podem ser obtidas pelo "comprimento" horizontal desse processo.

Vamos discutir como melhorar esse ciclo, i.e. aumentar a capacidade e o COP. Como restrição, não podemos mexer nas pressões de evaporação e condensação, pois elas são dependentes das condições ambientes, como vamos ter oportunidade de ver em aulas futuras.

Baseado nisso, partindo de um ciclo assim, o que vocês fariam para aumentar a **capacidade**. O que vocês fariam para aumentar o **COP**?

Basicamente, encontramos duas modificações básicas que tendem a melhorar o Ciclo Padrão:

### Subresfriamento na saída do condensador

Pode ser feito superdimensionando o condensador, aumentando a área para continuar resfriando. Nesse caso, qual o limite inferior dessa temperatura?


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine
from CoolProp.CoolProp import PropsSI
import numpy as np
import matplotlib.pyplot as plt

plt.rc('font', size=14) 

# Vapor compression cycle analysis

# Use different color codes to change the color of the plots
color = 'r'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True

Tevap = 0 + 273
Tcond = 40 + 273
dTsub = 10
fluid = "R717"

h1 = PropsSI("H","T",Tevap,"Q",1,fluid)
s1 = PropsSI("S","T",Tevap,"Q",1,fluid)
Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
P1 = Pevap

Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)

P2 = Pcond
s2 = s1
h2 = PropsSI("H","P",P2,"S",s2,fluid)

P3 = Pcond
h3 = PropsSI("H","T",Tcond-dTsub,"Q",0,fluid)

P4 = Pevap
h4 = h3

# All the states are known, now.
#
qL = h1-h4
qH = h2-h3
wcomp = h2-h1
COP = qL/wcomp


# Generate some diagrams
# Let figure 1 be a P-h diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Enthalpy, h (kJ/kg)')
ax1.set_ylabel('Pressure, P (bar)')
ax1.set_title('Vapor compression Cycle P-h Diagram')


# Generate the dome on both plots
Tt = PropsSI("TTRIPLE",fluid)
Pt = PropsSI("PTRIPLE",fluid)

Tc = PropsSI("TCRIT",fluid)
Pc = PropsSI("PCRIT",fluid)

T = np.arange(Tt,Tc,2.5)

hL = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",0,fluid) for Ti in T
])
hV = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",1,fluid) for Ti in T
])
P = 1e-5*np.array([
  PropsSI("P","T",Ti,"Q",0,fluid) for Ti in T
])

ax1.plot(hL,P,'k')
ax1.plot(hV,P,'k')

# Process 1-2
p = np.linspace(P1,P2)
h = np.array([PropsSI("H","P",Pi,"S",s1,fluid) for Pi in p])
ax1.plot(h*1e-3,1e-5*p,color,linewidth=1.5)

# Process 2-3
ax1.plot(1e-3*np.array([h2,h3]),1e-5*np.array([P2,P3]),color,linewidth=1.5)

# Process 3-4
ax1.plot(1e-3*np.array([h3,h4]),1e-5*np.array([P3,P4]),color,linewidth=1.5)

# Process 4-5
ax1.plot(1e-3*np.array([h4,h1]),1e-5*np.array([P4,P1]),color,linewidth=1.5)

ax1.grid('on')
ax1.set_yscale('log')

ax1.set_ylim(bottom = 1)
```

```
## (1, 157.92471879842554)
```

```python
ax1.set_xlim(left = 0)
```

```
## (0.0, 1882.076035779616)
```

```python
if show_text:
    ax1.text(1.03e-3*h1,0.99*1e-5*P1,"1")
    ax1.text(1.01e-3*h2,0.99*1e-5*P2,"2")
    ax1.text(0.90e-3*h3,0.99*1e-5*P3,"3")
    ax1.text(0.90e-3*h4,0.99*1e-5*P4,"4")

plt.show()
#plt.show(block=False)
```

<img src="/disciplinas/ref0001/aula3ref0001_files/figure-html/unnamed-chunk-2-3.png" width="672" />

Cálculo da entalpia desse novo ponto 3: considerar o ponto de líquido saturado na temperatura desse ponto (lembrando que vai estar na mesma pressão do condensador, mas a uma temperatura mais baixa).

O subresfriamento sempre aumenta a capacidade? Sempre aumenta o COP?

### Superaquecimento na entrada do compressor

Sempre é feito por uma questão de segurança: reduzir a probabilidade de gotículas de líquido entrarem no compressor ("golpe de líquido"). Mas o que acontece com a capacidade e a potência?


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine
from CoolProp.CoolProp import PropsSI
import numpy as np
import matplotlib.pyplot as plt

plt.rc('font', size=14) 

# Vapor compression cycle analysis

# Use different color codes to change the color of the plots
color = 'r'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True

Tevap = 0 + 273
Tcond = 40 + 273
dTsup = 10
fluid = "R717"

Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
h1 = PropsSI("H","T",Tevap + dTsup,"P",Pevap,fluid)
s1 = PropsSI("S","P",Pevap,"H",h1,fluid)
P1 = Pevap

Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)

P2 = Pcond
s2 = s1
h2 = PropsSI("H","P",P2,"S",s2,fluid)

P3 = Pcond
h3 = PropsSI("H","T",Tcond,"Q",0,fluid)

P4 = Pevap
h4 = h3

# All the states are known, now.
#
qL = h1-h4
qH = h2-h3
wcomp = h2-h1
COP = qL/wcomp


# Generate some diagrams
# Let figure 1 be a P-h diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Enthalpy, h (kJ/kg)')
ax1.set_ylabel('Pressure, P (bar)')
ax1.set_title('Vapor compression Cycle P-h Diagram')


# Generate the dome on both plots
Tt = PropsSI("TTRIPLE",fluid)
Pt = PropsSI("PTRIPLE",fluid)

Tc = PropsSI("TCRIT",fluid)
Pc = PropsSI("PCRIT",fluid)

T = np.arange(Tt,Tc,2.5)

hL = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",0,fluid) for Ti in T
])
hV = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",1,fluid) for Ti in T
])
P = 1e-5*np.array([
  PropsSI("P","T",Ti,"Q",0,fluid) for Ti in T
])

ax1.plot(hL,P,'k')
ax1.plot(hV,P,'k')

# Process 1-2
p = np.linspace(P1,P2)
h = np.array([PropsSI("H","P",Pi,"S",s1,fluid) for Pi in p])
ax1.plot(h*1e-3,1e-5*p,color,linewidth=1.5)

# Process 2-3
ax1.plot(1e-3*np.array([h2,h3]),1e-5*np.array([P2,P3]),color,linewidth=1.5)

# Process 3-4
ax1.plot(1e-3*np.array([h3,h4]),1e-5*np.array([P3,P4]),color,linewidth=1.5)

# Process 4-5
ax1.plot(1e-3*np.array([h4,h1]),1e-5*np.array([P4,P1]),color,linewidth=1.5)

ax1.grid('on')
ax1.set_yscale('log')

ax1.set_ylim(bottom = 1)
```

```
## (1, 157.92471879842554)
```

```python
ax1.set_xlim(left = 0)
```

```
## (0.0, 1919.0615033990512)
```

```python
if show_text:
    ax1.text(1.03e-3*h1,0.99*1e-5*P1,"1")
    ax1.text(1.01e-3*h2,0.99*1e-5*P2,"2")
    ax1.text(0.90e-3*h3,0.99*1e-5*P3,"3")
    ax1.text(0.90e-3*h4,0.99*1e-5*P4,"4")

plt.show()
#plt.show(block=False)
```

<img src="/disciplinas/ref0001/aula3ref0001_files/figure-html/unnamed-chunk-3-5.png" width="672" />

Em primeiro lugar: só pode aumentar a capacidade se essa área adicional de troca de calor está em contato com a fonte fria. Mas considerando que está, vai necessariamente aumentar a capacidade? Lembrem do conceito de compressor que eu apresentei antes.

Ao arrastar o ponto 1 para a direita, o efeito refrigerante sempre aumenta, mas o vapor está se expandindo e o volume específico também aumenta; se esse efeito ultrapassar o efeito de entalpia, cada unidade de massa carrega mais energia, mas também ocupa mais volume e o compressor libera menos massa.

Em relação à potência de compressão, de maneira similar vamos ter esse conflito. O trabalho de compressão pode aumentar ou diminuir, dependendo da forma da isentrópica, lembrando que o estado de descarga é definido pela pressão. Se a isentrópica ficar mais horizontal, o trabalho aumenta. Mas ainda precisamos considerar o efeito volúmico; mesmo se aumentar o trabalho, o compressor acaba fazendo menos trabalho por menos massa escoando.

Tudo são propriedades do fluido refrigerante.


```python
from CoolProp.CoolProp import PropsSI

Tevap = 273
Tcond = 35 + 273
fluid = "R134a"

Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)

h1 = PropsSI("H","T",Tevap,"Q",1,fluid)
v1 = 1/PropsSI("D","T",Tevap,"Q",1,fluid)

dTsup = 5
h1linha = PropsSI("H","T",Tevap+dTsup,"P",Pevap,fluid)
v1linha = 1/PropsSI("D","T",Tevap+dTsup,"P",Pevap,fluid)
h4 = PropsSI("H","T",Tcond,"Q",0,fluid)

qvolumico = (h1-h4)/v1
print(qvolumico*1e-3)
```

```
## 2149.0285308674083
```

```python
qvolumico_linha= (h1linha-h4)/v1linha
print(qvolumico_linha*1e-3)
```

```
## 2157.5834979511515
```

### Trocador de calor intermediário

Na prática, os dois efeitos acima são alcançados simultaneamente: o tubo capilar forma um trocador de calor com a linha de sucção (tubulação entre evaporador e compressor):

{{< figure src="tcls-hermes.png" caption="Fonte: [1]">}}

Além da maneira mostrada acima, o tubo capilar pode ser enrolado em volta da linha de sucção [2].


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine
from CoolProp.CoolProp import PropsSI
import numpy as np
import matplotlib.pyplot as plt

plt.rc('font', size=14) 

# Vapor compression cycle analysis

# Use different color codes to change the color of the plots
color = 'r'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True

Tevap = 0 + 273
Tcond = 40 + 273
dTsup = 10
fluid = "R717"

Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
hvevap = PropsSI("H","P",Pevap,"Q",1,fluid)
h1 = PropsSI("H","T",Tevap + dTsup,"P",Pevap,fluid)
s1 = PropsSI("S","P",Pevap,"H",h1,fluid)
P1 = Pevap

Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)

P2 = Pcond
s2 = s1
h2 = PropsSI("H","P",P2,"S",s2,fluid)


P3 = Pcond
hlcond = PropsSI("H","P",P3,"Q",0,fluid)
h3 = hlcond - (h1 - hvevap)

P4 = Pevap
h4 = h3

# All the states are known, now.
#
qL = h1-h4
qH = h2-h3
wcomp = h2-h1
COP = qL/wcomp


# Generate some diagrams
# Let figure 1 be a P-h diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Enthalpy, h (kJ/kg)')
ax1.set_ylabel('Pressure, P (bar)')
ax1.set_title('Vapor compression Cycle P-h Diagram')


# Generate the dome on both plots
Tt = PropsSI("TTRIPLE",fluid)
Pt = PropsSI("PTRIPLE",fluid)

Tc = PropsSI("TCRIT",fluid)
Pc = PropsSI("PCRIT",fluid)

T = np.arange(Tt,Tc,2.5)

hL = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",0,fluid) for Ti in T
])
hV = 1e-3*np.array([
  PropsSI("H","T",Ti,"Q",1,fluid) for Ti in T
])
P = 1e-5*np.array([
  PropsSI("P","T",Ti,"Q",0,fluid) for Ti in T
])

ax1.plot(hL,P,'k')
ax1.plot(hV,P,'k')

# Process 1-2
p = np.linspace(P1,P2)
h = np.array([PropsSI("H","P",Pi,"S",s1,fluid) for Pi in p])
ax1.plot(h*1e-3,1e-5*p,color,linewidth=1.5)

# Process 2-3
ax1.plot(1e-3*np.array([h2,h3]),1e-5*np.array([P2,P3]),color,linewidth=1.5)

# Process 3-4
ax1.plot(1e-3*np.array([h3,h4]),1e-5*np.array([P3,P4]),color,linewidth=1.5)

# Process 4-5
ax1.plot(1e-3*np.array([h4,h1]),1e-5*np.array([P4,P1]),color,linewidth=1.5)

ax1.grid('on')
ax1.set_yscale('log')

ax1.set_ylim(bottom = 1)
```

```
## (1, 157.92471879842554)
```

```python
ax1.set_xlim(left = 0)
```

```
## (0.0, 1919.0615033990512)
```

```python
if show_text:
    ax1.text(1.03e-3*h1,0.99*1e-5*P1,"1")
    ax1.text(1.01e-3*h2,0.99*1e-5*P2,"2")
    ax1.text(0.90e-3*h3,0.99*1e-5*P3,"3")
    ax1.text(0.90e-3*h4,0.99*1e-5*P4,"4")

plt.show()
#plt.show(block=False)
```

<img src="/disciplinas/ref0001/aula3ref0001_files/figure-html/unnamed-chunk-5-7.png" width="672" />
    
Observe que o grau de superaquecimento e o grau de subresfriamento não são independentes, pois deve ser satisfeito o balanço de energia no trocador intermediário:

$$
h _l(P _{\mathrm{cond}}) - h_3 = h_1 - h _v(P _{\mathrm{evap}})
$$

## Eficiência isentrópica de compressão

Por fim, o processo de compressão muitas vezes não é ideal, e podemos ajustar os dados experimentais em termos de uma *eficiência isentrópica de compressão*:

$$
    \eta _{\mathrm{s,comp}} = \frac{w _{\mathrm{ent,rev}}}{w _{\mathrm{ent,real}}} = \frac{h _{2s} - h _1}{h _2-h _1}
$$
onde a eficiência, como falado, pode ser ajustada de dados experimentais, e o estado "2s" é o estado que haveria se o processo fosse isentrópico. O estado "2" é o estado real que deve ser usado nos cálculos de Primeira Lei.

O que causa essa geração de entropia?

A partir do [datasheet mostrado anteriormente](https://products.embraco.com/commtrol/api/pdf/compressor/datasheet/7187?&condensing_temperature=54.4&evaporating_temperature=-23.3&units=w&units_temp=metric-system&filters%5Bbare%5D=513701421&filters%5Brefrigerant%5D%5B%5D=R-600a&filters%5Bstandard%5D=ASHRAE&filters%5Bfrequency%5D=60), como podemos estimar a eficiência isentrópica?


```python
Tevap = -10 + 273
Tcond = 35 + 273
Wcomp = 217
m = 6.16/3600
fluid = "R600a"

h1 = PropsSI("H","T",Tevap,"Q",1,fluid)
s1 = PropsSI("S","T",Tevap,"Q",1,fluid)
s2s = s1

Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)
h2s = PropsSI("H","P",Pcond,"S",s2s,fluid)

etasc = (h2s-h1)/(Wcomp/m)
print(etasc)
```

```
## 0.42943582742845204
```
## Exemplo
    
Exercício 11-26 de [3]: Um refrigerador utiliza R-134a como fluido de trabalho. As pressões de evaporação e condensação são 200 kPa e 1400 kPa respectivamente. A eficiência isentrópica de compressão é de 88%. O refrigerante entra no compressor a uma taxa de 0,025 kg/s superaquecido em 10,1 °C e sai do condensador  subresfriado a 4,4 °C. Determine a capacidade, potência e COP para esse ciclo e para o ciclo ideal em comparação.


```python
from CoolProp.CoolProp import PropsSI

Pevap = 200e3
Pcond = 1400e3
dTsup = 10.1
dTsub = 4.4
fluid = "R134a"

Tevap = PropsSI("T","P",Pevap,"Q",1,fluid)
h1 = PropsSI("H","T",Tevap + dTsup,"P",Pevap,fluid)
s1 = PropsSI("S","P",Pevap,"H",h1,fluid)
v1 = 1/PropsSI("D","P",Pevap,"H",h1,fluid)

h5 = PropsSI("H","T",Tevap,"Q",1,fluid)
s5 = PropsSI("S","T",Tevap,"Q",1,fluid)
v5 = 1/PropsSI("D","T",Tevap,"Q",1,fluid)

mideal = 0.025
Vd = mideal * v5

s7 = s5
h7 = PropsSI("H","P",Pcond,"S",s7,fluid)

s2s = s1
h2s = PropsSI("H","P",Pcond,"S",s2s,fluid)

etasc = 0.88
h2 = h1 + (h2s-h1)/etasc

h6 = PropsSI("H","P",Pcond,"Q",0,fluid)
Tcond = PropsSI("T","P",Pcond,"Q",0,fluid)
T3 = Tcond - dTsub

h3 = PropsSI("H","T",T3,"Q",0,fluid)

h4 = h3
h8 = h6

m = Vd / v1
# All the states are known, now.
#
QLideal = mideal*(h5-h8)
Wcompideal = mideal*(h7-h5)
COPideal = QLideal/Wcompideal

QL = m*(h1-h4)
Wcomp = m*(h2-h1)
COP = QL/Wcomp

print(m)
```

```
## 0.023820363261660923
```

```python
print(QLideal)
```

```
## 2930.416777715669
```

```python
print(Wcompideal)
```

```
## 1015.7668127678583
```

```python
print(COPideal)
```

```
## 2.88493061683182
```

```python
print(QL)
```

```
## 3159.7760828710866
```

```python
print(Wcomp)
```

```
## 1160.0062504431605
```

```python
print(COP)
```

```
## 2.7239302216379855
```

```python
print((COP-COPideal)*100/COPideal)
```

```
## -5.580737167628745
```

```python
print(Tevap-273)
```

```
## -9.926272460233065
```

```python
print(Tcond-273)
```

```
## 52.57235906833
```
## Referências

[1]: Hermes, C. J. L. Uma metodologia para a simulação transiente de refrigeradores domésticos. Tese (Doutorado em Engenharia Mecânica). Florianópolis: Universidade Federal de Santa Catarina, 2006.

[2]: Stoecker, W. F., & Jones, J. W. Refrigeração e Ar Condicionado. São Paulo: McGraw-Hill do Brasil, 1985.

[3]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

