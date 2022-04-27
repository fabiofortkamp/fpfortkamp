---
date: "2022-04-20"
title: Aula 5 - Mais detalhes sobre o desempenho de compressores
type: book
weight: 40
---


## Comparação entre compressores alternativos e rotativos

Vamos importar três conjuntos de dados, que foram retirados de diferentes catálogos. O compressor alternativo foi abordado na [aula passada](https://products.embraco.com/commtrol/api/pdf/compressor/datasheet/7187?&condensing_temperature=54.4&evaporating_temperature=-23.3&units=w&units_temp=metric-system&filters%5Bbare%5D=513701421&filters%5Brefrigerant%5D%5B%5D=R-600a&filters%5Bstandard%5D=ASHRAE&filters%5Bfrequency%5D=60), enquanto os outros foram retirados [deste catálogo de compressor scroll](https://www.bitzer.de/shared_media/documentation/esp-100-6.pdf) e [deste compressor parafuso](https://www.bitzer.de/shared_media/documentation/sp-300-5.pdf)


```python
import pandas as pd

recdf = pd.read_csv("reciprocating.csv",delimiter=',',skiprows=5)
print(recdf)
```

```
##     Evaporating Temperature [C]  ...   Efficiency [W/W]
## 0                           -35  ...               1.29
## 1                           -30  ...               1.52
## 2                           -25  ...               1.77
## 3                           -20  ...               2.04
## 4                           -15  ...               2.33
## 5                           -10  ...               2.63
## 6                           -35  ...               1.24
## 7                           -30  ...               1.41
## 8                           -25  ...               1.61
## 9                           -20  ...               1.82
## 10                          -15  ...               2.05
## 11                          -10  ...               2.28
## 12                          -35  ...               1.16
## 13                          -30  ...               1.32
## 14                          -25  ...               1.48
## 15                          -20  ...               1.66
## 16                          -15  ...               1.85
## 17                          -10  ...               2.04
## 
## [18 rows x 7 columns]
```

```python
screwdf = pd.read_csv("screw.csv",delimiter=',',skiprows=6)
print(screwdf)
```

```
##     Evaporating Temperature [C]  ...  Power [W]
## 0                           -15  ...       5810
## 1                           -10  ...       6020
## 2                            -5  ...       6230
## 3                             0  ...       6440
## 4                             5  ...       6650
## 5                            10  ...       6860
## 6                            -5  ...       8070
## 7                             0  ...       8280
## 8                             5  ...       8490
## 9                            10  ...       8710
## 10                           15  ...       8920
## 11                            0  ...      10660
## 12                            5  ...      10850
## 13                           10  ...      11040
## 14                           15  ...      11240
## 
## [15 rows x 4 columns]
```

```python
scrolldf = pd.read_csv("scroll.csv",delimiter=',',skiprows=6)
print(scrolldf)
```

```
##     Evaporating Temperature [C]  ...  Power [W]
## 0                         -15.0  ...       2980
## 1                         -10.0  ...       2990
## 2                          -5.0  ...       3000
## 3                           0.0  ...       3020
## 4                           5.0  ...       3060
## 5                           7.5  ...       3080
## 6                          10.0  ...       3110
## 7                          12.5  ...       3150
## 8                         -15.0  ...       3710
## 9                         -10.0  ...       3720
## 10                         -5.0  ...       3740
## 11                          0.0  ...       3770
## 12                          5.0  ...       3800
## 13                          7.5  ...       3810
## 14                         10.0  ...       3830
## 15                         12.5  ...       3840
## 16                        -15.0  ...       4690
## 17                        -10.0  ...       4650
## 18                         -5.0  ...       4640
## 19                          0.0  ...       4670
## 20                          5.0  ...       4700
## 21                          7.5  ...       4750
## 22                         10.0  ...       4730
## 23                         12.5  ...       4730
## 
## [24 rows x 4 columns]
```

Comparando a vazão real e ideal de compressores alternativos:


```python
import matplotlib.pyplot as plt
from CoolProp.CoolProp import PropsSI
import numpy as np

plt.rc('font', size=12)

Vd = 13.54e-6 # in m3
n = 60 #Hz
z = 1
fluid = 'R600a'
Treturn = 32.2 + 273

Vd_dot = Vd * n * z # m3/s

T_cond = np.unique(recdf["Condensing Temperature [C]"].values)
fig, ax = plt.subplots()
colors=["k","b","r"]

i = 0
for Tc in T_cond:
  df = recdf[recdf["Condensing Temperature [C]"] == Tc]
  T_evap = df["Evaporating Temperature [C]"].values
  m_dot_actual = df["Gas Flow Rate [kg/h]"].values
  
  # we take the inverse of the density 
  # of the vapor at the evaporing *pressure*
  # and the return gas temperature
  v_in = np.array([(1.0/PropsSI("D","T",Treturn,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)) for Te in T_evap])
  m_dot_ideal = 3600*Vd_dot/v_in
  
  ax.plot(T_evap,m_dot_ideal,'-',color=colors[i],label="Ideal, Tcond = %.2f ºC" %(Tc))
  ax.plot(T_evap,m_dot_actual,'o',color=colors[i],label="Actual")
  
  i = i+1
  
ax.set_xlabel("Evaporating temperature [ºC]")
ax.set_ylabel("Gas flow rate [kg/h]")
ax.legend()
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-2-1.png" width="672" />

Em termos de eficiência volumétrica:


```python
import matplotlib.pyplot as plt
from CoolProp.CoolProp import PropsSI
import numpy as np

plt.rc('font', size=12)

Vd = 13.54e-6 # in m3
n = 60 #Hz
z = 1
fluid = 'R600a'
Treturn = 32.2 + 273

Vd_dot = Vd * n * z # m3/s

T_cond = np.unique(recdf["Condensing Temperature [C]"].values)
fig, ax = plt.subplots()
colors=["k","b","r"]

i = 0
for Tc in T_cond:
  df = recdf[recdf["Condensing Temperature [C]"] == Tc]
  T_evap = df["Evaporating Temperature [C]"].values
  m_dot_actual = df["Gas Flow Rate [kg/h]"].values
  
  # we take the inverse of the density 
  # of the vapor at the evaporing *pressure*
  # and the return gas temperature
  v_in = np.array([(1.0/PropsSI("D","T",Treturn,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)) for Te in T_evap])
  m_dot_ideal = 3600*Vd_dot/v_in
  eta_v = m_dot_actual/m_dot_ideal
  
  ax.plot(T_evap,eta_v*100,'-',color=colors[i],label="Tcond = %.2f ºC" %(Tc))
  
  i = i+1
  
ax.set_xlabel("Evaporating temperature [ºC]")
ax.set_ylabel("Volumetric efficiency [%]")
ax.set_ylim(50,110)
```

```
## (50.0, 110.0)
```

```python
ax.legend()
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-3-3.png" width="672" />

Como reduzir isso a uma única curva? Será que apenas a razão de pressões de condensação e evaporação determina a eficiência volumétrica?



```python

fig, ax = plt.subplots()
colors=["k","b","r"]

T_cond = np.unique(recdf["Condensing Temperature [C]"].values)


i = 0
for Tc in T_cond:
  df = recdf[recdf["Condensing Temperature [C]"] == Tc]
  T_evap = df["Evaporating Temperature [C]"].values
  m_dot_actual = df["Gas Flow Rate [kg/h]"].values
  
  # we take the inverse of the density 
  # of the vapor at the evaporing *pressure*
  # and the return gas temperature
  v_in = np.array([(1.0/PropsSI("D","T",Treturn,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)) for Te in T_evap])
  m_dot_ideal = 3600*Vd_dot/v_in
  eta_v = m_dot_actual/m_dot_ideal
  
  Pcond = PropsSI("P","T",Tc+273,"Q",1,fluid)
  Pevap = np.array([PropsSI("P","T",Te+273,"Q",1,fluid) for Te in T_evap])
  ax.plot(Pcond/Pevap,eta_v*100,'-',color=colors[i],label="Tcond = %.2f ºC" %(Tc))
  
  i = i+1
  
ax.set_xlabel("Condensing pressure / Evaporating pressure")
ax.set_ylabel("Volumetric efficiency [%]")
ax.legend()
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-4-5.png" width="672" />
Pelo jeito não. Você tem alguma outra sugestão de variável única que determine a eficiência volumétrica?

## Curvas de capacidade do compressor alternativo

Vamos plotar o desempenho do compressor alternativo em termos da sua capacidade de refrigeração:


```python
import matplotlib.pyplot as plt
from CoolProp.CoolProp import PropsSI
import numpy as np

plt.rc('font', size=12)

Vd = 13.54e-6 # in m3
n = 60 #Hz
z = 1
fluid = 'R600a'
Treturn = 32.2 + 273

Vd_dot = Vd * n * z # m3/s

T_cond = np.unique(recdf["Condensing Temperature [C]"].values)
fig, ax = plt.subplots()
colors=["k","b","r"]

i = 0
for Tc in T_cond:
  df = recdf[recdf["Condensing Temperature [C]"] == Tc]
  T_evap = df["Evaporating Temperature [C]"].values
  Q_dot_actual = df["Cooling Capacity [W]"].values
  
  ax.plot(T_evap,Q_dot_actual,'o',color=colors[i],label="Tcond = %.2f ºC" %(Tc))
  
  i = i+1
  
ax.set_xlabel("Evaporating temperature [ºC]")
ax.set_ylabel("Cooling Capacity [W]")
ax.legend()
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-5-7.png" width="672" />
Como calcular a capacidade em um ponto novo?

Vamos utilizar *aprendizado de máquina*: selecionar alguns pontos para tentar uma reação cúbica:

$$
\dot{Q} _{\mathrm{L}} = a _0 + a _1  t _{\mathrm{evap}} + a _2 t _{\mathrm{evap}}^2 + a_3 t _{\mathrm{evap}} ^3 
$$
onde `\(t_{\mathrm{evap}}\)` é a temperaratura de evaporação em graus Celsius. 

No aprendizado *supervisionado*, nós selecionamos alguns pontos para ajustar os coeficientes, utilizando o [um modelo de regressão linear](https://scikit-learn.org/stable/modules/linear_model.html). Observe que o modelo é linear *nos coeficientes*, que são as incógnitas; os valores de temperatura de evaporação e suas potências são determinados a partir dos dados.


```python
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import Pipeline

X = recdf.values[:,:1] # first column (evaporating temperature) as a 2D array, as required
YQL = recdf["Cooling Capacity [W]"].values

# 80 % of data selected at random to find ("fit") the coeficientes
X_train,X_test,QL_train,QL_test = train_test_split(X,YQL,test_size=0.2) 

QL_quadratic_model = Pipeline(
[
('poly', PolynomialFeatures(degree=3)),
('linear', LinearRegression(fit_intercept=False))])
QL_quadratic_model.fit(X_train, QL_train)

# now evalutate the model at the test values
# (not used to calculate the coefficients)
```

```
## Pipeline(steps=[('poly', PolynomialFeatures(degree=3)),
##                 ('linear', LinearRegression(fit_intercept=False))])
```

```python
QL_quadratic_pred = QL_quadratic_model.predict(X_test)

fig4, ax4 = plt.subplots()
ax4.scatter(QL_test,QL_quadratic_pred)
ax4.grid()
ax4.set_xlabel('Simulated cooling capacity (test set) [W]]')
ax4.set_ylabel('Predicted cooling capacity (test set) [W]')
ax4.set_title('accuracy (R^2) =  %.5f'
% r2_score(QL_test, QL_quadratic_pred))
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-6-9.png" width="672" />

Agora podemos simplesmente *prever* os dados em um novo valor de temperatura de evaporação:


```python
print(QL_quadratic_model.predict(np.array([[-17]])))
```

```
## [410.41090942]
```

Os coeficientes são ( `\(a_0\)`--$a_3$):


```python
print(QL_quadratic_model.named_steps["linear"].coef_)
```

```
## [ 8.21786671e+02  2.92755107e+01  2.96324817e-01 -1.36382586e-04]
```

## Desempenho de compressores scroll

Para compressores scroll:


```python
import matplotlib.pyplot as plt
from CoolProp.CoolProp import PropsSI
import numpy as np

plt.rc('font', size=12)

fluid = 'R134a'
Treturn = 20

Vd_dot = 25 # m3/h

T_cond = np.unique(scrolldf["Condensing Temperature [C]"].values)
fig, ax = plt.subplots()
colors=["k","b","r"]

i = 0
for Tc in T_cond:
  df = scrolldf[scrolldf["Condensing Temperature [C]"] == Tc]
  T_evap = df["Evaporating Temperature [C]"].values
  h4 = PropsSI("H","T",Tc+273,"Q",0,fluid)
  v_in = np.empty_like(T_evap)
  h1 = np.empty_like(T_evap)
  
  for (j,Te) in enumerate(T_evap):
    if (Tc == 50 and Te <= -10):
      v_in[j] = 1.0/PropsSI("D","T",Te+273+10,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)
      h1[j] = PropsSI("H","T",Te+273+10,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)
    else:
      v_in[j] = 1.0/PropsSI("D","T",Treturn+273,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)
      h1[j] = PropsSI("H","T",Treturn+273,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid)
  
  Q_dot_actual = df["Cooling Capacity [W]"].values
  m_dot_actual = 3600*Q_dot_actual/(h1-h4)
  
  # we take the inverse of the density 
  # of the vapor at the evaporing *pressure*
  # and the return gas temperature
  
  m_dot_ideal = Vd_dot/v_in
  eta_v = m_dot_actual/m_dot_ideal
  
  ax.plot(T_evap,eta_v*100,'-',color=colors[i],label="Ideal, Tcond = %.2f ºC" %(Tc))
  i = i+1
  
ax.set_xlabel("Evaporating temperature [ºC]")
ax.set_ylabel("Volumetric efficiency [%]")
ax.set_ylim(50,110)
```

```
## (50.0, 110.0)
```

```python
ax.legend()
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-9-11.png" width="672" />
Essa é a grande vantagem dos compressores scroll: sua alta eficiência volumétrica. Porém, atente-se ao custo desses compressores.

## Desempenho de compressores parafuso


```python
import matplotlib.pyplot as plt
from CoolProp.CoolProp import PropsSI
import numpy as np

plt.rc('font', size=12)

fluid = 'R134a'

Vd_dot = 46 # m3/h

T_cond = np.unique(screwdf["Condensing Temperature [C]"].values)
fig, ax = plt.subplots()
colors=["k","b","r"]

i = 0
for Tc in T_cond:
  df = screwdf[screwdf["Condensing Temperature [C]"] == Tc]
  T_evap = df["Evaporating Temperature [C]"].values
  Pcond = PropsSI("P","T",Tc+273,"Q",0,fluid)
  h4 = PropsSI("H","T",Tc+273-5,"P",Pcond,fluid)
  v_in = np.array([1.0/PropsSI("D","T",Te+273+10,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid) for Te in T_evap])
  h1 = np.array([PropsSI("H","T",Te+273+10,"P",PropsSI("P","T",Te+273,"Q",1,fluid),fluid) for Te in T_evap])
  
  Q_dot_actual = df["Cooling Capacity [W]"].values
  m_dot_actual = 3600*Q_dot_actual/(h1-h4)
  
  # we take the inverse of the density 
  # of the vapor at the evaporing *pressure*
  # and the return gas temperature
  
  m_dot_ideal = Vd_dot/v_in
  eta_v = m_dot_actual/m_dot_ideal
  
  ax.plot(T_evap,eta_v*100,'-',color=colors[i],label="Ideal, Tcond = %.2f ºC" %(Tc))
  i = i+1
  
ax.set_xlabel("Evaporating temperature [ºC]")
ax.set_ylabel("Volumetric efficiency [%]")
ax.set_ylim(50,110)
```

```
## (50.0, 110.0)
```

```python
ax.legend()
ax.grid()
plt.show()
```

<img src="/disciplinas/ref0001/aula5ref0001_files/figure-html/unnamed-chunk-10-13.png" width="672" />
O rendimento volumétrico dos compressores parafuso não tão alto como os scroll, mas mais alto que os compressores alternativos. Além disso, o ponto de operação influencia bastante; como você pode reduzir os dados?

