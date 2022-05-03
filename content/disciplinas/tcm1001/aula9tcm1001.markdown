---
date: "2022-04-25"
title: Aula 9 - Aletas com seção transversal variável
type: book
weight: 40
---

## Comparação de geometrias aletas

Exercício 3.123, Incropera 6a edição.


```python
from math import  sqrt, log, tanh
from scipy.special import kv, iv

Tinf = 20
Tb = 100
h = 50
t = 3e-3
L = 15e-3
k = 185

m = sqrt(2*h/(k*t))
thetab = Tb - Tinf

Lc = L + t/2
mL = m*L
mLc = m*Lc

## Aleta retangular
print("Aleta Retangular")
```

```
## Aleta Retangular
```

```python
etar = tanh(mLc)/mLc
print("Eficiência = %.2f %%" %(etar*100))
```

```
## Eficiência = 98.40 %
```

```python
Afr = 2*Lc
qar = etar*h*Afr*thetab 
print("Calor trocado pela aleta = %.2f W/m" %(qar))
```

```
## Calor trocado pela aleta = 129.88 W/m
```

```python
V = t*L
print("Volume da aleta = %.2g m3/m" %(V))
```

```
## Volume da aleta = 4.5e-05 m3/m
```

```python
print()

## Aleta triangular
```

```python
print("Aleta Triangular")
```

```
## Aleta Triangular
```

```python
etat = (1.0/mL)*iv(1,2*mL)/iv(0,2*mL)
print("Eficiência = %.2f %%" %(etat*100))
```

```
## Eficiência = 98.03 %
```

```python
Aft = 2*sqrt(L**2 + (t/2)**2)
qat = etat*h*Aft*thetab 
print("Calor trocado pela aleta = %.2f W/m" %(qat))
```

```
## Calor trocado pela aleta = 118.22 W/m
```

```python
V = t/2*L
print("Volume da aleta = %.2g m3/m" %(V))
```

```
## Volume da aleta = 2.2e-05 m3/m
```

```python
print()

## Aleta parabólica
```

```python
print("Aleta Parabólica")
```

```
## Aleta Parabólica
```

```python
etap = 2/(sqrt(4*(mL)**2 + 1) + 1)
print("Eficiência = %.2f %%" %(etap*100))
```

```
## Eficiência = 96.24 %
```

```python
C1 = sqrt(1 + (t/L)**2)
Afp = C1*L + (L**2)/t*log(t/L + C1)
qap = etap*h*Afp*thetab 
qap0 = qap
print("Calor trocado pela aleta = %.2f W/m" %(qap))
```

```
## Calor trocado pela aleta = 116.26 W/m
```

```python
V = t/3*L
print("Volume da aleta = %.2g m3/m" %(V))
```

```
## Volume da aleta = 1.5e-05 m3/m
```

```python
print()
```


```python
L = 0.9*15e-3
mL = m*L
print("Aleta Parabólica mais curta")
```

```
## Aleta Parabólica mais curta
```

```python
etap = 2/(sqrt(4*(mL)**2 + 1) + 1)
print("Eficiência = %.2f %%" %(etap*100))
```

```
## Eficiência = 96.92 %
```

```python
C1 = sqrt(1 + (t/L)**2)
Afp = C1*L + (L**2)/t*log(t/L + C1)
qap = etap*h*Afp*thetab 
print("Calor trocado pela aleta = %.2f W/m" %(qap))
```

```
## Calor trocado pela aleta = 105.52 W/m
```

```python
V = t/3*L
print("Volume da aleta = %.2g m3/m" %(V))
```

```
## Volume da aleta = 1.3e-05 m3/m
```

```python
print()
```

```python
dq = (qap0 - qap)/qap0
print("Redução no calor = %.2f %%" %(100*dq,))
```

```
## Redução no calor = 9.23 %
```

