---
date: "2022-04-20"
title: Aula 6 - Exercícios de revisão de ciclos e compressores
type: book
weight: 50
---


## Problema 1

Calcule os parâmetros listados a seguir para um ciclo de refrigeração por compressão mecânica de vapor que opera com um subresfriamento de 5ºC na saída do condensador e com um superaquecimento (útil) de 10ºC na saída do evaporador. Assuma que o compressor opera com R-134a e possui uma eficiência isentrópica de 0,70. Assuma também que a temperatura de condensação é de 55ºC e a de evaporação de -23ºC. Repita os cálculos para o refrigerante R-600a e compare os resultados. 

a) Efeito refrigerante específico
b) Efeito refrigerante volúmico
c) Trabalho específico
d) Trabalho volúmico
e) Coeficiente de performance
f) Temperatura de descarga
g) Título da mistura bifásica após a expansão



```python
from CoolProp.CoolProp import PropsSI

tevap = -23
tcond = 55
dTsup = 2
dTsub = 5
etasc = 0.7
fluids = ["R134a","R600a"]
Tevap = tevap + 273
Tcond = tcond + 273

for fluid in fluids:
  print(fluid)
  
  Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
  h1 = PropsSI("H","T",Tevap + dTsup,"P",Pevap,fluid)
  s1 = PropsSI("S","P",Pevap,"H",h1,fluid)
  v1 = 1/PropsSI("D","P",Pevap,"H",h1,fluid)
  
  Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)
  
  s2s = s1
  h2s = PropsSI("H","P",Pcond,"S",s2s,fluid)
  h2 = h1 + (h2s-h1)/etasc
  T2 = PropsSI("T","P",Pcond,"H",h2,fluid)
  
  T3 = Tcond - dTsub
  h3 = PropsSI("H","T",T3,"Q",0,fluid)
  h4 = h3
  
  ere = h1 - h4
  erv = ere/v1
  print("Efeito refrigerante específico = %.2f kJ/kg" %(1e-3*ere))
  print("Efeito refrigerante volúmico = %.2f kJ/m3" %(1e-3*erv))
  
  w = h2 - h1
  wv = w/v1
  print("Trabalho específico = %.2f kJ/kg" %(1e-3*w))
  print("Trabalho volúmico = %.2f kJ/m3" %(1e-3*wv))
  
  COP = ere/w
  print("COP = %.2f" %(COP,))
  
  print("Temperatura de descarga = %.2f ºC" %(T2-273))
    
  x4 = PropsSI("Q","P",Pevap,"H",h4,fluid)
  print("Título = %.2f" %(x4,))
  print()
```

```
## R134a
## Efeito refrigerante específico = 114.82 kJ/kg
## Efeito refrigerante volúmico = 677.16 kJ/m3
## Trabalho específico = 77.32 kJ/kg
## Trabalho volúmico = 455.98 kJ/m3
## COP = 1.49
## Temperatura de descarga = 87.65 ºC
## Título = 0.47
## 
## R600a
## Efeito refrigerante específico = 204.74 kJ/kg
## Efeito refrigerante volúmico = 370.44 kJ/m3
## Trabalho específico = 134.05 kJ/kg
## Trabalho volúmico = 242.55 kJ/m3
## COP = 1.53
## Temperatura de descarga = 71.16 ºC
## Título = 0.46
```

O que isso quer dizer em relação à escolha de fluidos?

## 2

R-134a, é comprimido num compressor ideal, do estado de vapor saturado a -25ºC para uma pressão correspondente a uma temperatura de condensação de 50ºC.
 
a) Considerando que este compressor possui um único cilindro, com diâmetro e curso respectivamente de 21 mm e 16 mm, determinar a potência ideal para uma rotação de 3600 rpm.
b) Admitindo um volume morto de 150 mm$^3$, determine o rendimento volumétrico ideal.
c) Se um mecânico de refrigeração utilizar este compressor para evacuar um sistema de refrigeração, inicialmente cheio de ar, qual a mínima pressão obtida?
d) Calcular a potência requerida do compressor com volume morto.


```python
from CoolProp.CoolProp import PropsSI
from math import pi

tevap = -25
tcond = 50
fluids = ["R134a"]
Tevap = tevap + 273
Tcond = tcond + 273

D = 21e-3
L = 16e-3
n = 60

Vd = L*pi/4*D**2
Vdot = Vd*n
for fluid in fluids:
  print(fluid)
  
  Pevap = PropsSI("P","T",Tevap,"Q",1,fluid)
  h1 = PropsSI("H","T",Tevap,"Q",1,fluid)
  s1 = PropsSI("S","P",Pevap,"Q",1,fluid)
  v1 = 1/PropsSI("D","P",Pevap,"Q",1,fluid)
  
  Pcond = PropsSI("P","T",Tcond,"Q",1,fluid)
  
  s2s = s1
  h2 = PropsSI("H","P",Pcond,"S",s2s,fluid)
  v2 = 1/PropsSI("D","P",Pcond,"S",s2s,fluid)
  
  mdot = Vdot/v1
  Wideal = mdot*(h2-h1)
  print("Potência ideal = %.2f W" %(Wideal,))

  Vem = 150e-9
  epsilon = Vem/Vd
  etav = 1 - epsilon*(v1/v2 - 1)
  print("Eficiência volumétrica ideal = %.2f %%" %(etav*100,))
  
  Patm = 1
  k = 1.4
  Pmin = Patm/((1/epsilon + 1)**k)
  print("Pressão mínima = %.g atm" %(Pmin,))
  
  mdotreal = Vdot/v1*etav
  Wreal = mdotreal*(h2-h1)
  print("Potência real = %.2f W" %(Wreal))
```

```
## R134a
## Potência ideal = 96.06 W
## Eficiência volumétrica ideal = 72.60 %
## Pressão mínima = 0.006 atm
## Potência real = 69.74 W
```
