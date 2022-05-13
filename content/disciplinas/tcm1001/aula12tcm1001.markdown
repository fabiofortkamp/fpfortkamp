---
date: "2022-04-25"
title: Aula 12 - Introdução à Convecção
type: book
weight: 50
---

## Calculo do coeficiente de transferência de calor por convecção a partir do perfil de temperaturas

Exercício 6.10 de [1]: Considere o fluxo de ar sobre a superfície de uma placa mantida a uma temperatura dde 220 ˚C. O perfil de tempertaura do fluxo do ar é dado como:

$$
T(y) = T_{\mathrm{\infty}} - \left(T_{\mathrm{\infty}} - T_{\mathrm{s}}\right)\exp\left(-\frac{V}{\alpha}y\right)
$$

O fluxo de ar a 1 atm tem velocidade de fluxo livre e temperatura de 0,08 m/s e 20 ˚C. Determine o fluxo de calor na superfície da placa.

**Solução**: dado um perfil na camada limite, o coeficiente de transferência de calor por convecção é *definido* como:

$$
h = \frac{-k \left(\frac{\mathrm{d}T}{\mathrm{d}y}\right)_{y=0}}{T_{\mathrm{s}} - T_{\mathrm{\infty}}}
$$
onde então, para esse caso,

$$
\frac{\mathrm{d}T}{\mathrm{d}y} = (T_{\mathrm{\infty}}-T_{\mathrm{s}})\frac{V}{\alpha}\exp\left(-\frac{V}{\alpha}y\right)
$$

E portanto:

$$
h = \frac{k V}{\alpha}
$$
e então, basta aplicar a Lei de Resfriamento de Newton.

As propriedades devem ser aplicadas na *temperatura de filme*, definida como a média aritmética entre a temperatura da superfície e a temperatura livre do fluido.

Calculos de propriedades de fluido são bastante facilitadas pelo uso da biblioteca [CoolProp](http://www.coolprop.org/coolprop), conforme explicitado pelo código abaixo:


```python
from CoolProp.CoolProp import PropsSI

Tinf = 20
Ts = 220
V = 0.08

Tf = (Tinf + Ts)/2 + 273 # CoolProp precisa sempre de T em kelvin
fluid = "Air"
P = 101.325e3

k = PropsSI("CONDUCTIVITY","T",Tf,"P",P,fluid)
rho = PropsSI("D","T",Tf,"P",P,fluid)
cp = PropsSI("CPMASS","T",Tf,"P",P,fluid)
alpha = k / (rho*cp)

h = k * V / alpha
qflux = h*(Ts-Tinf)
print("Fluxo de calor = %.2f W/m2" %(qflux))
```

```
## Fluxo de calor = 14560.12 W/m2
```

## Coeficientes médios e locais

Exercrcício 6.7 de [2]: Escoamento paralelo de ar atmosférico sobre uma placa plana de 3 m de comprimento é perturbado por um conjunto de barras. Medições resultam numa correlação para o coeficiente convectivo local de  `\(h(x) = 0.7 + 13.6x  - 3.4x^2\)`, x em m e h em W/m$^2$K. Calcule o valor médio por toda a placa e a relação entre o valor médio e o local no final da placa.

Dica: use [`scipy.integrate`](https://docs.scipy.org/doc/scipy/tutorial/integrate.html) para fazer a integração numérica.


```python
from scipy.integrate import quad
L = 2

def h(x):
  return 0.7 + 13.6*x - 3.4*x**2

h_medio = 1/L * quad(h,0,L)[0] # integração numérica

hL = h(L)
r = h_medio/hL
print("Coeficiente médio = %.2f W/(m2 K)" %(h_medio))
```

```
## Coeficiente médio = 9.77 W/(m2 K)
```

```python
print("Razão entre coeficiente médio e local no final da placa = %.2f" %(r,))
```

```
## Razão entre coeficiente médio e local no final da placa = 0.68
```

```python
print("Coeficiente no meio da placa = %.2f W/(m2 K)" %(h(L/2)))
```

```
## Coeficiente no meio da placa = 10.90 W/(m2 K)
```

## Referências

[1]: Çengel, Y. A., & Ghajar, A. J. Transferência de Calor e Massa: Uma Abordagem Prática (4 ed.). Porto Alegre: AMGH, 2011

[2]: Bergman, T. L., Lavine, A. S., Incropera, F. P., & Dewitt, D. P. Fundamentos da Transferência de Calor e de Massa (7 ed.). Rio de Janeiro: LTC, 2014.
