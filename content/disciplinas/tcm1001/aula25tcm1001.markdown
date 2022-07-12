---
date: "2022-05-24"
title: Aula 25 - Projeto de trocadores de calor
type: book
weight: 70
---

## Exemplo de projeto

Exercício 11.77 de [1]: Considere um ciclo de Rankine com o vapor d’água saturado deixando a caldeira a uma pressão de 2 MPa e uma pressão no condensador de 10 kPa.

a) Calcule a eficiência térmica desse ciclo de Rankine ideal;
b) Se o trabalho reversível líquido para o ciclo for de 0,5 MW, calcule a vazão de água de resfriamento requerida no condensador a 15 ˚C com uma elevação permitida de 10 ˚C;
c) Projete um trocador de calor casco e tubos (um passe no casco e múltiplos passes nos tubos) que irá satisfazer as condições de taxa de transferência de calor e de temperatura requeridas no condensador. Seu projeto deve especificar o número de tubos e seus diâmetro e comprimento.

RESPOSTA DA a):

Uma grande parte das especificações de trocadores de calor envolve aplicações em ciclos de potência ou de refrigeração, e assim este exemplo é bastante relevante.

Vamos denotar os seguintes estados do vapor (fluido de trabalho do ciclo):

- 1: entrada da bomba/saída do condensador
- 2: entrada da caldeira/saída da bomba
- 3: entrada da turbina/saída da caldeira
- 4: entrada do condensador/saída da turbina

Vamos considerar um ciclo ideal (sem nenhum tipo de irreversibilidade interna), em regime permanente, e onde os efeitos de energia cinética e potencial são desprezíveis.

Os estados podem ser calculados usando uma biblioteca de propriedades termodinâmicas e usando um diagrama de um ciclo Rankine como base:


```python
from CoolProp.CoolProp import PropsSI

P1 = 10e3
P2 = 2e6

h1 = PropsSI("H","P",P1,"Q",0,"Water")
s1 = PropsSI("S","P",P1,"Q",0,"Water")

s2 = s1
h2 = PropsSI("H","P",P2,"S",s2,"Water")

h3 = PropsSI("H","P",P2,"Q",1,"Water")
s3 = PropsSI("S","P",P2,"Q",1,"Water")

s4 = s3
h4 = PropsSI("H","P",P1,"S",s4,"Water")

# todas as grandezas abaixo são positivas
qcald = h3-h2
wturb = h3-h4
wbomb = h2-h1
qcond = h4-h1

wliq = wturb - wbomb
eta = wliq/qcald

print("Eficiência térmica = %.2f %%" %(eta*100))
```

```
## Eficiência térmica = 30.32 %
```

RESPOSTA DA b):

Da especificação de potência líquida, a vazão de vapor é:


```python
W_dot = 0.5e6
m_dot_v = W_dot/wliq #vazão de vapor
print("Vazão de vapor: %.3f kg/s" %(m_dot_v,))
```

```
## Vazão de vapor: 0.633 kg/s
```

Aplicando a Primeira Lei da Termodinâmica no condensador, do lado do vapor (fluido quente)


```python
Q_dot_cond = qcond*m_dot_v
print(Q_dot_cond/1e6)
```

```
## 1.149079889292989
```

Essa é a troca de calor no condensador; toda essa energia vai para a água de resfriamento (fluido frio, que vamos denotar por "w"):


```python
t_w_ent = 15
dt_w = 10
t_w_sai = t_w_ent + dt_w

t_w_mean = (t_w_ent+t_w_sai)/2
T_w_mean = t_w_mean+273
cp_w = PropsSI("CPMASS","T",T_w_mean,"Q",0,"Water")

m_dot_w = Q_dot_cond/(cp_w*(t_w_sai-t_w_ent))
print("Vazão de água de resfriamento: %.3f kg/s" %(m_dot_w,))
```

```
## Vazão de água de resfriamento: 27.461 kg/s
```

Observe que há uma razão de cerca de 40 vezes mais vazão de água de resfriamento que de vapor, o que é típico [2]. Por que será?

UMA POSSÍVEL SOLUÇÃO PARA c):

O fato das temperaturas estarem fixadas implica no cálculo possível das propridades do fluido frio:


```python
k = PropsSI("CONDUCTIVITY","T",T_w_mean,"Q",0,"Water")
rho = PropsSI("D","T",T_w_mean,"Q",0,"Water")
mu = PropsSI("VISCOSITY","T",T_w_mean,"Q",0,"Water")
Pr = PropsSI("PRANDTL","T",T_w_mean,"Q",0,"Water")
```

A área de troca de calor, ignorando a espessura dos tubos, é `\(A = N \pi D L\)`, sendo `\(N\)` o número de tubos, `\(D\)` o seu diâmetro, e `\(L\)` o comprimento total. O uso do método MLDT ou da efetividade vai nos dar uma equação, e assim, precisamos de mais duas especificações.

Para o diâmetro, precisamos olhar em catálogos de tubos, como [esse aqui](https://tubonasa.com.br/site/images/portfolio/Catalogo-Tubonasa.pdf)


```python
D = 0.25*101.60e-3 # 1 pol
```

Para o número de tubos, um dos métodos é prescrever uma velocidade média.


```python
u_m  = 5
```

E então:


```python
from math import pi
N = round(4*m_dot_w/(rho*u_m*pi*D**2))
if N < 1:
  N = 1
u_m = 4*m_dot_w/(rho*N*pi*D**2)
```

Agora sim, podemos usar o método da efetividade:


```python
from math import log

C_dot_min = m_dot_w*cp_w
t_v = PropsSI("T","P",P1,"Q",1,"Water")-273
DeltaT_max = t_v - t_w_ent
qmax = C_dot_min*DeltaT_max
epsilon = qcond/qmax

NUT = -log(1-epsilon)
UA = NUT*C_dot_min

Re = rho*u_m*D/mu
Nu = 0.023*Re**0.8*Pr**(0.4)
hi = Nu*k/D

he = 10000

U = (1/hi + 1/he)**(-1)

A = UA/U
L = A/(N*pi*D)
print("Comprimento total de cada tubo = %.2f m" %(L))
```

```
## Comprimento total de cada tubo = 15.98 m
```


## Referências

[1]: , Incropera, F. P.; Dewitt, D. P.; Bergman, T. L.; Lavine, A. S. Fundamentos da Transferência de Calor e de Massa (6 ed.). Rio de Janeiro: LTC, 2008.

[2]: Lora, E. E. S., & Nascimento, M. A. R. do. Geração Termelétrica: Planejamento, Projeto e Operação. Rio de Janeiro: Interciência, 2004.
