---
date: "2022-05-24"
title: Aula 9 - Curvas de equilíbrio em tubos capilares
type: book
weight: 80
---

## Vazão de compressores

Um compressor succiona vapor do evaporador e o comprime até a pressão de condensação, como [já](https://fpfortkamp.com/disciplinas/ref0001/aula4ref0001/) [visto](https://fpfortkamp.com/post/superheat/).

Vamos considerar para esta aula que segue um compressor alternativo ideal (isentrópico) monocilindro de simples efeito com volume morto, com cilindrada `\(\mathcal{V}_{\mathrm{D}}\)` e fração de volume morto (em relação à cilindrada) `\(\varepsilon\)`, que funciona em uma rotação fixa `\(n\)`.

Seja 1 o estado de sucção do compressor, possivelmente superaquecido. A vazão do compressor pode então ser calculada como:

$$
\dot{m} = \frac{\mathcal{V} _{\mathrm{D}}n}{v _1}\left(1 + \varepsilon\left(1-\frac{v  _{\mathrm{1}}}{v (P = P _{\mathrm{cond}},s=s1)}\right)\right)
$$

*No caso particular onde o estado de sucção não tem superaquecimento*, a vazão acima depende apenas das temperaturas de evaporação e condensação:

$$
\dot{m} = \frac{\mathcal{V} _{\mathrm{D}}n}{v _v(t _{\mathrm{evap}})}\left(1 + \varepsilon\left(1-\frac{v _v(t _{\mathrm{evap}})}{v (P = P _{\mathrm{sat}}(t _{\mathrm{cond}}),s=s_v(t  _{\mathrm{evap}}))}\right)\right)
$$

Como vimos anteriormente, as condições de operação em um sistema de refrigeração real mudam, e geralmente mudam no lado de evaporação, pela mudança na carga térmica. Portanto, é interessante analisar a vazão de um compressor de geometria e rotação fixas, a uma temperatura de condensação (ambiente) constante, conforme a temperatura de evaporação muda (novamente, assumindo sucção de vapor saturado):

``` python
import numpy as np
from CoolProp.CoolProp import PropsSI
import matplotlib.pyplot as plt
import pandas as pd

plt.rc('font', size=12)


fluid = 'R134a'

t_evap_values = np.linspace(-20,5)
t_cond_values = np.linspace(35,55)

Vd = 13.54e-6 # in m3
n = 60 #Hz
epsilon = 5e-2

V_dot = Vd*n

def m_dot_compressor_fun(t_evap,t_cond):
  v1 = 1.0/PropsSI("D","T",t_evap+273,"Q",1,fluid)
  s1 = PropsSI("S","T",t_evap+273,"Q",1,fluid)
  P_cond = PropsSI("P","T",t_cond+273,"Q",1,fluid)
  v2 = 1.0/PropsSI("D","S",s1,"P",P_cond,fluid) 
  
  eta_v = 1 - epsilon*(1 - v1/v2)
  m_dot_compressor = V_dot*eta_v/v1
  return m_dot_compressor

# stolen from https://www.delftstack.com/howto/numpy/python-numpy-combinations/#:~:text=We%20can%20also%20use%20the%20meshgrid%20%28%29%20function,and%20returns%20the%20cross-product%20of%20the%20two%20arrays.
X = np.array(np.meshgrid(t_evap_values, t_cond_values)).T.reshape(-1,2)

m_dot_compressor_values = np.array([
  m_dot_compressor_fun(t_evap,t_cond) for (t_evap,t_cond) in X
])

compressor_df = pd.DataFrame(
  {'t_evap[C]': X[:,0],
  't_cond[C]': X[:,1],
  'm_dot[kg/s]': m_dot_compressor_values}
)


t_cond = t_cond_values[-1]
t_evap_tc = compressor_df[compressor_df['t_cond[C]'] == t_cond]['t_evap[C]'].values
m_dot_compressor_tc = compressor_df[compressor_df['t_cond[C]'] == t_cond]['m_dot[kg/s]'].values

fig, ax = plt.subplots()
ax.plot(t_evap_tc,m_dot_compressor_tc*3600,'ko',label='Temp. cond. = %.2f ºC' %(t_cond,))
ax.grid()
ax.legend()
ax.set_xlabel("Temperatura de evaporação [ºC]")
ax.set_ylabel("Vazão mássica [kg/h]")
plt.show()
```

<img src="/disciplinas/ref0001/aula9ref0001_files/figure-html/unnamed-chunk-1-1.png" width="672" />
O que está acontecendo com essa curva:

1.  Como a temperatura de evaporação pode subir? (use os conceitos de trocadores de calor)
2.  Por que a vazão de um compressor sobe com a temperatura de evaporação?

### Ajuste polinomial na vazão de compressores

Podemos tentar ajustar uma curva quadrática a este comportamento:

$$
\dot{m} _{\mathrm{comp}} = a _0 + a _1  t _{\mathrm{evap}} + a _2  t _{\mathrm{evap}}^2
$$

Em termos estatísticos, isso equivale a dizer que, para cada valor `\(t_{\mathrm{evap},i}\)` e sua correspondente vazão `\(\dot{m}_{\mathrm{comp},i}\)`, existem constantes `\(a_j\)` tal que

$$
\dot{m} _{\mathrm{comp},i} = a _0 + a _1  t _{\mathrm{evap},i} + a _2  t _{\mathrm{evap},i}^2 + e_i
$$

onde `\(e_i\)` é um termo de erro, que queremos que seja o menor possível:

$$
`\begin{split}
e_i = & \left(\frac{\mathcal{V}_{\mathrm{D}}n}{v_v(t_{\mathrm{evap},i})}\left(1 + \varepsilon\left(1-\frac{v_v(t_{\mathrm{evap},i})}{v (P = P_{\mathrm{sat}}(t_{\mathrm{cond}}),s=s_v(t_{\mathrm{evap},i}))}\right)\right)\right)- \\
& \left(a _0 + a _1  t _{\mathrm{evap},i} + a _2  t _{\mathrm{evap},i}^2\right)
\end{split}`
$$

As constantes `\(a_j\)` podem ser encontradas pelo método dos mínimos quadrados: elas minimizam a soma dos quadrados dos erros.

Felizmente, podemos fazer esses cálculos de minimização com a biblioteca [scikit-learn](https://scikit-learn.org/stable/modules/linear_model.html#polynomial-regression-extending-linear-models-with-basis-functions).

``` python
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import Pipeline

X = t_evap_tc.reshape(-1,1) # para transformar em 2D
Y = m_dot_compressor_tc # 1D

X_train,X_test,Y_train,Y_test = train_test_split(X,Y,test_size=0.2)

m_dot_compressor_model = Pipeline(
[
('poly', PolynomialFeatures(degree=2)),
('linear', LinearRegression(fit_intercept=False))])

# função que faz o ajuste do modelo de fato:
m_dot_compressor_model.fit(X_train, Y_train)
```

<style>#sk-container-id-1 {color: black;background-color: white;}#sk-container-id-1 pre{padding: 0;}#sk-container-id-1 div.sk-toggleable {background-color: white;}#sk-container-id-1 label.sk-toggleable__label {cursor: pointer;display: block;width: 100%;margin-bottom: 0;padding: 0.3em;box-sizing: border-box;text-align: center;}#sk-container-id-1 label.sk-toggleable__label-arrow:before {content: "▸";float: left;margin-right: 0.25em;color: #696969;}#sk-container-id-1 label.sk-toggleable__label-arrow:hover:before {color: black;}#sk-container-id-1 div.sk-estimator:hover label.sk-toggleable__label-arrow:before {color: black;}#sk-container-id-1 div.sk-toggleable__content {max-height: 0;max-width: 0;overflow: hidden;text-align: left;background-color: #f0f8ff;}#sk-container-id-1 div.sk-toggleable__content pre {margin: 0.2em;color: black;border-radius: 0.25em;background-color: #f0f8ff;}#sk-container-id-1 input.sk-toggleable__control:checked~div.sk-toggleable__content {max-height: 200px;max-width: 100%;overflow: auto;}#sk-container-id-1 input.sk-toggleable__control:checked~label.sk-toggleable__label-arrow:before {content: "▾";}#sk-container-id-1 div.sk-estimator input.sk-toggleable__control:checked~label.sk-toggleable__label {background-color: #d4ebff;}#sk-container-id-1 div.sk-label input.sk-toggleable__control:checked~label.sk-toggleable__label {background-color: #d4ebff;}#sk-container-id-1 input.sk-hidden--visually {border: 0;clip: rect(1px 1px 1px 1px);clip: rect(1px, 1px, 1px, 1px);height: 1px;margin: -1px;overflow: hidden;padding: 0;position: absolute;width: 1px;}#sk-container-id-1 div.sk-estimator {font-family: monospace;background-color: #f0f8ff;border: 1px dotted black;border-radius: 0.25em;box-sizing: border-box;margin-bottom: 0.5em;}#sk-container-id-1 div.sk-estimator:hover {background-color: #d4ebff;}#sk-container-id-1 div.sk-parallel-item::after {content: "";width: 100%;border-bottom: 1px solid gray;flex-grow: 1;}#sk-container-id-1 div.sk-label:hover label.sk-toggleable__label {background-color: #d4ebff;}#sk-container-id-1 div.sk-serial::before {content: "";position: absolute;border-left: 1px solid gray;box-sizing: border-box;top: 0;bottom: 0;left: 50%;z-index: 0;}#sk-container-id-1 div.sk-serial {display: flex;flex-direction: column;align-items: center;background-color: white;padding-right: 0.2em;padding-left: 0.2em;position: relative;}#sk-container-id-1 div.sk-item {position: relative;z-index: 1;}#sk-container-id-1 div.sk-parallel {display: flex;align-items: stretch;justify-content: center;background-color: white;position: relative;}#sk-container-id-1 div.sk-item::before, #sk-container-id-1 div.sk-parallel-item::before {content: "";position: absolute;border-left: 1px solid gray;box-sizing: border-box;top: 0;bottom: 0;left: 50%;z-index: -1;}#sk-container-id-1 div.sk-parallel-item {display: flex;flex-direction: column;z-index: 1;position: relative;background-color: white;}#sk-container-id-1 div.sk-parallel-item:first-child::after {align-self: flex-end;width: 50%;}#sk-container-id-1 div.sk-parallel-item:last-child::after {align-self: flex-start;width: 50%;}#sk-container-id-1 div.sk-parallel-item:only-child::after {width: 0;}#sk-container-id-1 div.sk-dashed-wrapped {border: 1px dashed gray;margin: 0 0.4em 0.5em 0.4em;box-sizing: border-box;padding-bottom: 0.4em;background-color: white;}#sk-container-id-1 div.sk-label label {font-family: monospace;font-weight: bold;display: inline-block;line-height: 1.2em;}#sk-container-id-1 div.sk-label-container {text-align: center;}#sk-container-id-1 div.sk-container {/* jupyter's `normalize.less` sets `[hidden] { display: none; }` but bootstrap.min.css set `[hidden] { display: none !important; }` so we also need the `!important` here to be able to override the default hidden behavior on the sphinx rendered scikit-learn.org. See: https://github.com/scikit-learn/scikit-learn/issues/21755 */display: inline-block !important;position: relative;}#sk-container-id-1 div.sk-text-repr-fallback {display: none;}</style><div id="sk-container-id-1" class="sk-top-container"><div class="sk-text-repr-fallback"><pre>Pipeline(steps=[(&#x27;poly&#x27;, PolynomialFeatures()),
                (&#x27;linear&#x27;, LinearRegression(fit_intercept=False))])</pre><b>In a Jupyter environment, please rerun this cell to show the HTML representation or trust the notebook. <br />On GitHub, the HTML representation is unable to render, please try loading this page with nbviewer.org.</b></div><div class="sk-container" hidden><div class="sk-item sk-dashed-wrapped"><div class="sk-label-container"><div class="sk-label sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-1" type="checkbox" ><label for="sk-estimator-id-1" class="sk-toggleable__label sk-toggleable__label-arrow">Pipeline</label><div class="sk-toggleable__content"><pre>Pipeline(steps=[(&#x27;poly&#x27;, PolynomialFeatures()),
                (&#x27;linear&#x27;, LinearRegression(fit_intercept=False))])</pre></div></div></div><div class="sk-serial"><div class="sk-item"><div class="sk-estimator sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-2" type="checkbox" ><label for="sk-estimator-id-2" class="sk-toggleable__label sk-toggleable__label-arrow">PolynomialFeatures</label><div class="sk-toggleable__content"><pre>PolynomialFeatures()</pre></div></div></div><div class="sk-item"><div class="sk-estimator sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-3" type="checkbox" ><label for="sk-estimator-id-3" class="sk-toggleable__label sk-toggleable__label-arrow">LinearRegression</label><div class="sk-toggleable__content"><pre>LinearRegression(fit_intercept=False)</pre></div></div></div></div></div></div></div>

Agora, podemos comparar alguns valores individuais:

``` python
i = 20
print("Vazão [kg/s] calculada com modelo físico:")
```

    ## Vazão [kg/s] calculada com modelo físico:

``` python
print(m_dot_compressor_tc[i])
```

    ## 0.010656125541301055

``` python
print("Vazão [kg/s] calculada com modelo estatístico:")
```

    ## Vazão [kg/s] calculada com modelo estatístico:

``` python
print(m_dot_compressor_model.predict([[t_evap_tc[i]]])[0])
```

    ## 0.010649873791397712

Vamos ver como o polinômio se sai graficamente:

``` python
fig2, ax2 = plt.subplots()
ax2.plot(t_evap_tc,m_dot_compressor_tc*3600,'ko')
ax2.plot(t_evap_tc,m_dot_compressor_model.predict(t_evap_tc.reshape(-1,1))*3600,'k-')
ax2.grid()
ax2.set_xlabel("Temperatura de evaporação [ºC]")
ax2.set_ylabel("Vazão mássica [kg/h]")
plt.show()
```

<img src="/disciplinas/ref0001/aula9ref0001_files/figure-html/unnamed-chunk-4-3.png" width="672" />
Os coeficientes podem ser encontrados:

``` python
a_vector = m_dot_compressor_model.named_steps["linear"].coef_
print(a_vector)
```

    ## [1.40165786e-02 3.88246666e-04 4.54905921e-06]

## Vazão de tubos capilares

Vamos considerar agora um tubo de diâmetro `\(D\)`. A área de escoamento é `\(A_{\mathrm{c}}\)` O fluido escoa com uma determinada velocidade média mássica `\(u_m\)`:

$$
u_m = \frac{\dot{m}}{\rho A_{\mathrm{c}}}
$$

onde, **por enquanto**, vamos assumir que a densidade é constante.

O escoamento de um fluido através de um tubo de comprimento `\(L\)` gera uma perda de carga `\(\Delta P = P_{\mathrm{cond}} - P_{\mathrm{evap}}\)`:

$$
\Delta P = f \frac{L}{D} \frac{\rho u_m^2}{2}
$$

onde `\(f\)` é o fator de atrito de Darcy, que depende do número de Reynolds.

Como uma primeira aproximação, vamos considerar um valor constante do fator de atrito. Se os outros parâmetros forem dados, a vazão de um tubo capilar pode ser encontrada como:

$$
`\begin{split}
\dot{m} & = \rho u_m A_c \\
& = \sqrt{2 \rho \Delta P \frac{1}{f} \frac{D}{L}}A_{\mathrm{c}}
\end{split}`
$$

Se estipularmos um valor de `\(f\)`, e assumirmos o escoamento apenas do líquido saturado pelo tubo, então:

$$
\dot{m} _{\mathrm{capilar}} = \sqrt{2 \rho _l(t  _{\mathrm{cond}}) \left(P _{\mathrm{sat}}(t  _{\mathrm{cond}}) - P _{\mathrm{sat}}(t   _{\mathrm{evap}})\right) \frac{1}{f} \frac{D}{L}}A _{\mathrm{c}}
$$

Ou seja: a vazão do tubo capilar de geometria fixa e fator de atrito fixo depende apenas das temperaturas de condensação e evaporação - assim como no compressor.

``` python
import math

f = 0.01
D = 1.3e-3
L = 5
Ac = 0.25*math.pi*D**2

def m_dot_tube_fun(t_evap,t_cond):
  P_evap = PropsSI("P","T",t_evap+273,"Q",1,fluid)
  P_cond = PropsSI("P","T",t_cond+273,"Q",1,fluid)
  rhol = PropsSI("D","P",P_cond,"Q",0,fluid)
  DeltaP = P_cond - P_evap
  m_dot_tube = math.sqrt(2*rhol*DeltaP*(1/f)*(D/L))*Ac
  
  return m_dot_tube

m_dot_tube_tc = np.array([
  m_dot_tube_fun(t_evap,t_cond) for t_evap in t_evap_tc
])

fig3, ax3 = plt.subplots()
ax3.plot(t_evap_tc,m_dot_tube_tc*3600,'ko')
ax3.grid()
ax3.set_xlabel("Temperatura de evaporação [ºC]")
ax3.set_ylabel("Vazão mássica [kg/h]")
plt.show()
```

<img src="/disciplinas/ref0001/aula9ref0001_files/figure-html/unnamed-chunk-6-5.png" width="672" />

**Para pensar** : por que o comportamento é inverso ao do compressor?

### Ajuste polinomial na vazão de tubos

Repetindo a análise de compressores, podemos tentar ajustar uma curva quadrática a este comportamento:

$$
\dot{m} _{\mathrm{tubo}} = b _0 + b _1  t _{\mathrm{evap}} + b _2  t _{\mathrm{evap}}^2
$$

``` python
Y_tube = m_dot_tube_tc # 1D

# cuidado que os valores abaixo vão ser 
# sobre-escritos
X_train,X_test,Y_train,Y_test = train_test_split(X,Y_tube,test_size=0.2)

m_dot_tube_model = Pipeline(
[
('poly', PolynomialFeatures(degree=2)),
('linear', LinearRegression(fit_intercept=False))])

# função que faz o ajuste do modelo de fato:
m_dot_tube_model.fit(X_train, Y_train)
```

<style>#sk-container-id-2 {color: black;background-color: white;}#sk-container-id-2 pre{padding: 0;}#sk-container-id-2 div.sk-toggleable {background-color: white;}#sk-container-id-2 label.sk-toggleable__label {cursor: pointer;display: block;width: 100%;margin-bottom: 0;padding: 0.3em;box-sizing: border-box;text-align: center;}#sk-container-id-2 label.sk-toggleable__label-arrow:before {content: "▸";float: left;margin-right: 0.25em;color: #696969;}#sk-container-id-2 label.sk-toggleable__label-arrow:hover:before {color: black;}#sk-container-id-2 div.sk-estimator:hover label.sk-toggleable__label-arrow:before {color: black;}#sk-container-id-2 div.sk-toggleable__content {max-height: 0;max-width: 0;overflow: hidden;text-align: left;background-color: #f0f8ff;}#sk-container-id-2 div.sk-toggleable__content pre {margin: 0.2em;color: black;border-radius: 0.25em;background-color: #f0f8ff;}#sk-container-id-2 input.sk-toggleable__control:checked~div.sk-toggleable__content {max-height: 200px;max-width: 100%;overflow: auto;}#sk-container-id-2 input.sk-toggleable__control:checked~label.sk-toggleable__label-arrow:before {content: "▾";}#sk-container-id-2 div.sk-estimator input.sk-toggleable__control:checked~label.sk-toggleable__label {background-color: #d4ebff;}#sk-container-id-2 div.sk-label input.sk-toggleable__control:checked~label.sk-toggleable__label {background-color: #d4ebff;}#sk-container-id-2 input.sk-hidden--visually {border: 0;clip: rect(1px 1px 1px 1px);clip: rect(1px, 1px, 1px, 1px);height: 1px;margin: -1px;overflow: hidden;padding: 0;position: absolute;width: 1px;}#sk-container-id-2 div.sk-estimator {font-family: monospace;background-color: #f0f8ff;border: 1px dotted black;border-radius: 0.25em;box-sizing: border-box;margin-bottom: 0.5em;}#sk-container-id-2 div.sk-estimator:hover {background-color: #d4ebff;}#sk-container-id-2 div.sk-parallel-item::after {content: "";width: 100%;border-bottom: 1px solid gray;flex-grow: 1;}#sk-container-id-2 div.sk-label:hover label.sk-toggleable__label {background-color: #d4ebff;}#sk-container-id-2 div.sk-serial::before {content: "";position: absolute;border-left: 1px solid gray;box-sizing: border-box;top: 0;bottom: 0;left: 50%;z-index: 0;}#sk-container-id-2 div.sk-serial {display: flex;flex-direction: column;align-items: center;background-color: white;padding-right: 0.2em;padding-left: 0.2em;position: relative;}#sk-container-id-2 div.sk-item {position: relative;z-index: 1;}#sk-container-id-2 div.sk-parallel {display: flex;align-items: stretch;justify-content: center;background-color: white;position: relative;}#sk-container-id-2 div.sk-item::before, #sk-container-id-2 div.sk-parallel-item::before {content: "";position: absolute;border-left: 1px solid gray;box-sizing: border-box;top: 0;bottom: 0;left: 50%;z-index: -1;}#sk-container-id-2 div.sk-parallel-item {display: flex;flex-direction: column;z-index: 1;position: relative;background-color: white;}#sk-container-id-2 div.sk-parallel-item:first-child::after {align-self: flex-end;width: 50%;}#sk-container-id-2 div.sk-parallel-item:last-child::after {align-self: flex-start;width: 50%;}#sk-container-id-2 div.sk-parallel-item:only-child::after {width: 0;}#sk-container-id-2 div.sk-dashed-wrapped {border: 1px dashed gray;margin: 0 0.4em 0.5em 0.4em;box-sizing: border-box;padding-bottom: 0.4em;background-color: white;}#sk-container-id-2 div.sk-label label {font-family: monospace;font-weight: bold;display: inline-block;line-height: 1.2em;}#sk-container-id-2 div.sk-label-container {text-align: center;}#sk-container-id-2 div.sk-container {/* jupyter's `normalize.less` sets `[hidden] { display: none; }` but bootstrap.min.css set `[hidden] { display: none !important; }` so we also need the `!important` here to be able to override the default hidden behavior on the sphinx rendered scikit-learn.org. See: https://github.com/scikit-learn/scikit-learn/issues/21755 */display: inline-block !important;position: relative;}#sk-container-id-2 div.sk-text-repr-fallback {display: none;}</style><div id="sk-container-id-2" class="sk-top-container"><div class="sk-text-repr-fallback"><pre>Pipeline(steps=[(&#x27;poly&#x27;, PolynomialFeatures()),
                (&#x27;linear&#x27;, LinearRegression(fit_intercept=False))])</pre><b>In a Jupyter environment, please rerun this cell to show the HTML representation or trust the notebook. <br />On GitHub, the HTML representation is unable to render, please try loading this page with nbviewer.org.</b></div><div class="sk-container" hidden><div class="sk-item sk-dashed-wrapped"><div class="sk-label-container"><div class="sk-label sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-4" type="checkbox" ><label for="sk-estimator-id-4" class="sk-toggleable__label sk-toggleable__label-arrow">Pipeline</label><div class="sk-toggleable__content"><pre>Pipeline(steps=[(&#x27;poly&#x27;, PolynomialFeatures()),
                (&#x27;linear&#x27;, LinearRegression(fit_intercept=False))])</pre></div></div></div><div class="sk-serial"><div class="sk-item"><div class="sk-estimator sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-5" type="checkbox" ><label for="sk-estimator-id-5" class="sk-toggleable__label sk-toggleable__label-arrow">PolynomialFeatures</label><div class="sk-toggleable__content"><pre>PolynomialFeatures()</pre></div></div></div><div class="sk-item"><div class="sk-estimator sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-6" type="checkbox" ><label for="sk-estimator-id-6" class="sk-toggleable__label sk-toggleable__label-arrow">LinearRegression</label><div class="sk-toggleable__content"><pre>LinearRegression(fit_intercept=False)</pre></div></div></div></div></div></div></div>

``` python
fig4, ax4 = plt.subplots()
ax4.plot(t_evap_tc,m_dot_tube_tc*3600,'ko')
ax4.plot(t_evap_tc,m_dot_tube_model.predict(t_evap_tc.reshape(-1,1))*3600,'k-')
ax4.grid()
ax4.set_xlabel("Temperatura de evaporação [ºC]")
ax4.set_ylabel("Vazão mássica [kg/h]")
plt.show()
```

<img src="/disciplinas/ref0001/aula9ref0001_files/figure-html/unnamed-chunk-7-7.png" width="672" />
Com coeficientes:

``` python
b_vector = m_dot_tube_model.named_steps["linear"].coef_
print(b_vector)
```

    ## [ 1.08658571e-02 -4.76826431e-05 -6.33115460e-07]

## Equilíbrio de curvas

Agora que temos modelos polinomials, podemos manipulá-los mais facilmente. Por exemplo, vamos plotar no mesmo gráfico as duas curvas:

``` python
fig5, ax5 = plt.subplots()
ax5.plot(t_evap_tc,m_dot_tube_model.predict(t_evap_tc.reshape(-1,1))*3600,'k-',label="Tubo")
ax5.plot(t_evap_tc,m_dot_compressor_model.predict(t_evap_tc.reshape(-1,1))*3600,'k--',label="Compressor")
ax5.grid()
ax5.set_xlabel("Temperatura de evaporação [ºC]")
ax5.set_ylabel("Vazão mássica [kg/h]")
ax5.legend()
plt.show()
```

<img src="/disciplinas/ref0001/aula9ref0001_files/figure-html/unnamed-chunk-9-9.png" width="672" />

Neste momento, reflita novamente sobre todas as hipóteses levantadas até aqui. O que significa essa interseção dessa curva?

## Sugestões de análises futuras:

Modifique os modelos de regressão acima para permitir que a vazão do compressor e do tubo capilar sejam funções da temperatura de evaporação e da temperatura de condensação. Dada uma temperatura de condensação, como você pode encontrar a temperatura de evaporação de equilíbrio? E agora, se a temperatura de evaporação muda, qual vai ser a nova temperatura de condensação?

Calcule também como, ao variar a temperatura de condensação, a temperatura de evaporação de equilíbrio e a vazão de equilíbrio mudam.

## Referências:

\[1\]: Bergman, T. L., Lavine, A. S., Incropera, F. P., & Dewitt, D. P. Fundamentos da Transferência de Calor e de Massa (7 ed.). Rio de Janeiro: LTC, 2014.
