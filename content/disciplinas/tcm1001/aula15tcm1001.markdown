---
date: "2022-05-24"
title: Aula 15 - Convecção Externa Turbulenta sobre placa plana e cilindro
type: book
weight: 60
---

## Placa plana

Exercício 7.33 de [1]: Ar, a 27 ˚C e com uma velocidade de corrente livre de 10 m/s, é usado para resfriar componentes eletrônicos montados sobre uma placa de circuito impresso. Cada componente, com 4 mm por 4 mm, dissipa 40 mW, que são removidos pela superfície superior dos componentes. 

Um gerador de turbulência está localizado na aresta frontal da placa, fazendo com a  camada-limite seja turbulenta.

Estime a temperatura da superfície do quarto componente, localizado a 15 mm da  aresta frontal da placa.

*Sugestão*: usamos a bilioteca [CoolProp](http://www.coolprop.org/coolprop/HighLevelAPI.html#parameter-table) para calcular as propriedades:


```python
from CoolProp.CoolProp import PropsSI

fluid = 'Air'


Tinf = 300
Ts = 330 #estimativa inicial

# todas as propriedades devem ser avaliadas
# na temperatura de filme
Tf = (Ts+Tinf)/2 
uinf = 10
xo = 15e-3
b = 4e-3
A = b**2
P = 101325

mu = PropsSI("VISCOSITY","T",Tf,"P",P,fluid)
rho = PropsSI("D","T",Tf,"P",P,fluid)
k = PropsSI("CONDUCTIVITY","T",Tf,"P",P,fluid)
Pr = PropsSI("PRANDTL","T",Tf,"P",P,fluid)
nu = mu/rho

# hipótese: o número de Nusselt médio (sobre o 
# chip) é igual ao local no centro do chip 
# que é bem pequeno
Re = uinf*xo/nu
Nu = 0.0296*Re**(0.8)*Pr**(1/3) # turbulento
h = Nu*k/xo

q = 40e-3
Ts = Tinf + q/(h*A)
print(Ts)
```

```
## 336.40928285265005
```

Sugestões

1. Modifique o programa acima para iterar automaticamente na temperatura de superfície
2. Veja o que acontece conforme você muda a estimativa inicial.
## Referências

[1]: Bergman, T. L., Lavine, A. S., Incropera, F. P., & Dewitt, D. P. Fundamentos da Transferência de Calor e de Massa (7 ed.). Rio de Janeiro: LTC, 2014.
