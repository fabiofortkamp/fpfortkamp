---
date: "2022-04-20"
title: Aula 4 - Ciclos com sobre-expansão
type: book
weight: 50
---

## O que a Análise de Segunda Lei dos Ciclos Ideais mostra

[Anteriormente](https://fpfortkamp.com/disciplinas/st2mte1/aula3st2mte1/) analisamos o Ciclo Otto do ponto de vista da Segunda Lei, determinando os processos que mais contribuem para a perda de trabalho. O culpado parece ser o processo de exaustão. Isso é sempre verdade?

No código abaixo, nós testamos diferentes combinações de ciclo Otto e, se acharmos alguma condição onde o trabalho perdido na combustão é maior, imprimimos uma mensagem:


```python
from math import log

import numpy as np

import pyromat as pm

T1_list = range(250,400)
T3_list = range(1300,2000)
rcomp_list = range(8,12)

air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

for T1 in T1_list:
  for T3 in T3_list:
    for rcomp in rcomp_list:
      
      T2 = T1*rcomp**(k-1)
      T4 = T3/(rcomp**(k-1))
      qent = cv*(T3-T2)
      qsai = cv*(T4-T1)
      ds = cv*log(T3/T2)
      sger_23 = ds - qent/T3
      sger_41 = -ds + qsai/T1
      wperdido_23 = T1*sger_23
      wperdido_41 = T1*sger_41
      if wperdido_23 > wperdido_41:
        print("Nesta condição a combustão domina as perdas:")
        print("Razão de compressão = %.2f" %(rcomp,))
        print("Temperatura mínima = %.2f K" %(T1,))
        print("Temperatura máxima = %.2f K" %(T3,))
        print()
        
print()
```

Pelo jeito, a exaustão sempre domina as perdas.

Analisando um Ciclo Otto:


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine

import matplotlib.pyplot as plt
plt.rc('font', size=14) 
rcomp = 8
T1 = 300
P1 = 1
T3 = 1500
Vd = 1
Vmin = Vd/(rcomp-1)
Vmax = Vmin + Vd

air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

# Use different color codes to change the color of the plots
color = 'k'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True

# Generate some diagrams
# Let figure 1 be a P-v diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Volume, V (L)')
ax1.set_ylabel('Pressão, P (bar)')
ax1.set_title('Ciclo Otto Ideal')


# Process 1-2
V = np.linspace(Vmin,Vmin + Vd)
P = P1 * (V/Vmax)**(-k)
P2 = max(P)
T2 = T1 * rcomp**(k-1)
ax1.plot(V,P,color,linewidth=1.5)

# Process 2-3
P3 = P2 * T3/T2
ax1.plot([Vmin,Vmin],[P2,P3],color,linewidth=1.5)

# Process 3-4
V = np.linspace(Vmin,Vmin + Vd)
P = P3 * (V/Vmin)**(-k)
P4 = min(P)
ax1.plot(V,P,color,linewidth=1.5)

# Process 4-1
Vmax = Vmin + Vd
ax1.plot([Vmax,Vmax],[P4,P1],color,linewidth=1.5)

ax1.grid('on')

#ax1.set_ylim(bottom = 1)
#ax1.set_xlim(left = 0)

if show_text:
  ax1.text(1.001*Vmax,0.7*P1,"1")
  ax1.text(1*Vmin,P2,"2")
  ax1.text(0.999*Vmin,1.001*P3,"3")
  ax1.text(1.001*Vmax,1.3*P4,"4")


plt.show()
```

<img src="/disciplinas/st2mte1/aula4st2mte1_files/figure-html/unnamed-chunk-2-1.png" width="672" />

Uma maneira de reduzir as perdas na combustão é simplesmente reduzir a temperatura máxima:


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine


plt.rc('font', size=14) 
rcomp = 8
T1 = 300
P1 = 1
T3 = 1500
T3min = 1000
Vd = 1
Vmin = Vd/(rcomp-1)
Vmax = Vmin + Vd

air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

# Use different color codes to change the color of the plots
color = 'k'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True




# Generate some diagrams
# Let figure 1 be a P-v diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Volume, V (L)')
ax1.set_ylabel('Pressão, P (bar)')
ax1.set_title('Ciclo Otto Ideal')


# Process 1-2
V = np.linspace(Vmin,Vmin + Vd)
P = P1 * (V/Vmax)**(-k)
P2 = max(P)
T2 = T1 * rcomp**(k-1)
ax1.plot(V,P,color,linewidth=1.5)

# Process 2-3
P3 = P2 * T3/T2
P3min = P2*T3min/T2
ax1.plot([Vmin,Vmin],[P2,P3],color,linewidth=1.5)
ax1.plot([Vmin,Vmin],[P2,P3min],'k--',linewidth=1.5)

# Process 3-4
V = np.linspace(Vmin,Vmin + Vd)
P = P3 * (V/Vmin)**(-k)
Pr = P3min* (V/Vmin)**(-k)
P4 = min(P)
P4min = min(Pr)
ax1.plot(V,P,color,linewidth=1.5)
ax1.plot(V,Pr,'k--',linewidth=1.5)

# Process 4-1
Vmax = Vmin + Vd
ax1.plot([Vmax,Vmax],[P4,P1],color,linewidth=1.5)
ax1.plot([Vmax,Vmax],[P4min,P1],'k--',linewidth=1.5)

ax1.grid('on')

#ax1.set_ylim(bottom = 1)
#ax1.set_xlim(left = 0)

plt.show()
```

<img src="/disciplinas/st2mte1/aula4st2mte1_files/figure-html/unnamed-chunk-3-3.png" width="672" />

O ciclo "reduzido" (tracejado) tem mesma eficiência do ciclo original (por quê?), mas menor eficiência de Carnot (pois funciona entre um intervalo de temperaturas menor). Portanto, a sua eficiência de Segunda Lei é maior. Mas qual a desvantagem desse ciclo?

Como você poderia pensar numa arquitetura de ciclo diferente que reduza as perdas na descarga e portanto aumente a eficiência?

## Sobre-expansão


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine


plt.rc('font', size=14) 
rcomp = 8
rexp = 10
T1 = 300
P1 = 1
T3 = 1500
T3min = 1000
Vd = 1
Vmin = Vd/(rcomp-1)
Vmax = rexp*Vmin

air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

# Use different color codes to change the color of the plots
color = 'k'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True




# Generate some diagrams
# Let figure 1 be a P-v diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Volume, V (L)')
ax1.set_ylabel('Pressão, P (bar)')
ax1.set_title('Ciclo com sobre-expansão')


# Process 1-2
V = np.linspace(Vmin,Vmin + Vd)
P = P1 * (V/Vmax)**(-k)
P2 = max(P)
T2 = T1 * rcomp**(k-1)
ax1.plot(V,P,color,linewidth=1.5)

# Process 2-3
P3 = P2 * T3/T2
ax1.plot([Vmin,Vmin],[P2,P3],color,linewidth=1.5)

# Process 3-4
V = np.linspace(Vmin,Vmin + Vd)
VA = np.linspace(Vmin,Vmax)
P = P3 * (V/Vmin)**(-k)
Pr = P3 *(VA/Vmin)**(-k)
P4 = min(P)
P4min = min(Pr)
ax1.plot(V,P,color,linewidth=1.5)
ax1.plot(VA,Pr,'k--',linewidth=1.5)

# Process 4-1
ax1.plot([Vmin+Vd,Vmin+Vd],[P4,P1],color,linewidth=1.5)

ax1.plot([Vmax,Vmax],[P4min,P1],'k--',linewidth=1.5)

ax1.plot([Vmax,Vmin+Vd],[P1,P1],'k--',linewidth=1.5)

ax1.grid('on')

#ax1.set_ylim(bottom = 1)
#ax1.set_xlim(left = 0)

plt.show()
```

<img src="/disciplinas/st2mte1/aula4st2mte1_files/figure-html/unnamed-chunk-4-5.png" width="672" />

onde agpra definimos uma razão de expansão: o volume máximo, ao final da expansão, pelo volume mínimo (PMS). A razão de compressão continua sendo definida durante a compressão.

O limite desse processo é o *Ciclo Atkinson Ideal*, onde a expansão ocorre até a pressão de admissão (a mínima pressão disponível):


```python
# adaptado de http://pyromat.org/doc_howto.html#cycle_rankine


plt.rc('font', size=14) 
rcomp = 8

T1 = 300
P1 = 1
T3 = 1500
T3min = 1000
Vd = 1
Vmin = Vd/(rcomp-1)


air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

T2 = T1*rcomp**(k-1)
qent = cv*(T3-T2)
rexp = (rcomp*(rcomp**(k-1) + qent/(cv*T1)))**(1/k)
Vmax = rexp*Vmin

# Use different color codes to change the color of the plots
color = 'k'    # Red
#color = 'b'   # Blue
# This is a True/False flag to deactivate the plot text
show_text = True
# This is a True/False flag to allow over-plotting of previous results
clear_plots = True




# Generate some diagrams
# Let figure 1 be a P-v diagram
f1 = plt.figure(1,)
if clear_plots:
    plt.clf()
ax1 = f1.add_subplot(111)
ax1.set_xlabel('Volume, V (L)')
ax1.set_ylabel('Pressão, P (bar)')
ax1.set_title('Ciclo Atkinson')


# Process 1-2
V = np.linspace(Vmin,Vmin + Vd)
P = P1 * (V/Vmax)**(-k)
P2 = max(P)
T2 = T1 * rcomp**(k-1)
ax1.plot(V,P,color,linewidth=1.5)

# Process 2-3
P3 = P2 * T3/T2
ax1.plot([Vmin,Vmin],[P2,P3],color,linewidth=1.5)

# Process 3-4
V = np.linspace(Vmin,Vmin + Vd)
VA = np.linspace(Vmin,Vmax)
P = P3 * (V/Vmin)**(-k)
Pr = P3 *(VA/Vmin)**(-k)
P4 = min(P)
P4min = min(Pr)
ax1.plot(V,P,color,linewidth=1.5)
ax1.plot(VA,Pr,'k--',linewidth=1.5)

# Process 4-1
ax1.plot([Vmin+Vd,Vmin+Vd],[P4,P1],color,linewidth=1.5)

ax1.plot([Vmax,Vmax],[P4min,P1],'k--',linewidth=1.5)

ax1.plot([Vmax,Vmin+Vd],[P1,P1],'k--',linewidth=1.5)

ax1.grid('on')

#ax1.set_ylim(bottom = 1)
#ax1.set_xlim(left = 0)

plt.show()
```

<img src="/disciplinas/st2mte1/aula4st2mte1_files/figure-html/unnamed-chunk-5-7.png" width="672" />
A razão de expansão máxima é dada por:

$$
r _{\mathrm{exp}}^k = r _{\mathrm{comp}}\left(r _{\mathrm{comp}}^{(k-1)} + \frac{q _{\mathrm{ent}}}{c_v T_1}\right)
$$

Seja

$$
r' = \frac{r _{\mathrm{exp}}}{r _{\mathrm{comp}}}
$$
Derive uma expressão para a eficiência térmica do Ciclo Atkinson em função apenas de `\(k\)`, `\(r _{\mathrm{comp}}\)` e `\(r'\)`.


```python
import numpy as np
import pyromat as pm
import matplotlib.pyplot as plt

plt.rc('font', size=14) 

rcomp = 12
T1 = 200
qent = np.linspace(100,10000)

air = pm.get("ig.air")

cv = air.cv(T=298)[0]
cp = air.cp(T=298)[0]
k = cp/cv

rexp = (rcomp*(rcomp**(k-1) + qent/(cv*T1)))**(1/k)

rl = rexp/rcomp

eta = 1 - k*rcomp**(1-k)*(rl-1)/(rl**k -1)
fig, ax = plt.subplots()
ax.plot(qent,eta)
ax.set_xlabel("Entrada de calor [kJ/kg]")
ax.set_ylabel("Eficiência térmica")
plt.show()
```

<img src="/disciplinas/st2mte1/aula4st2mte1_files/figure-html/unnamed-chunk-6-9.png" width="672" />

## Implementação

A implementação original do Ciclo Atkinson usava um mecanismo de barras para conseguir os tempos de compressão e exaustão diferentes:

{{< figure src="Atkinson_Engine_with_Intake.gif" caption="Fonte: https://commons.wikimedia.org/w/index.php?curid=41612521">}}

A implementação moderna é baseada em válvulas:

{{< youtube WKKILW3Zj_Y >}}

Portanto, a *eficiência volumétrica* do Ciclo Atkinson é menor. Como você pode calcular essa eficiência volumétrica, e como você pode determinar como a potência do ciclo Atkinson cai, em relação a um Ciclo Otto?


## Para saber mais

Por causa da sua baixa potência, os motores Atkinson são muito usados em carros híbridos: em situações de alta demanda de potência, o sistema de controle prioriza o motor elétrico. [Estas](https://quatrorodas.abril.com.br/auto-servico/o-que-ha-de-diferente-nos-motores-de-ciclo-atkinson-e-miller/
) [reportagens](https://www.flatout.com.br/diesel-atkinson-e-miller-conheca-os-ciclos-mais-economicos-de-motor/
) falam mais sobre isso.

Claro que isso gera o debate de se isso não transfere a eficiência para usinas terméletricas (o pior caso). Porém, as maiores usinas são mais eficientes que os melhores motores [1]. Por quê?

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.
