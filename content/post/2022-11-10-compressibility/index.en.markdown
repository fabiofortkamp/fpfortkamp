---
title: 'Compressibility and Expandability: what are they and how to calculate'
author: Fábio P. Fortkamp
date: '2022-11-10'
slug: compressibility
categories:
  - Articles
tags:
  - thermodynamics
subtitle: ''
summary: ''
authors: []
lastmod: '2022-11-10T13:23:16-03:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

One of my disappointments back when I was teaching is that I never taught a Thermodynamics class. I heard it is a terrible subject to teach, with high failing rates, but I'd like to have that experience nevertheless. 

Speaking as someone who studied Thermodynamics as an undergrad student and then during graduate school, and who taught classes that depended on Thermodynamics, I think there is a big specific problem with these courses: students have this subject too early in the curriculum, without the maturity to proper understand the difficult concepts. Also, it becomes too easy to forget what you saw in a Thermodynamics class 15 years ago.

## Expansion coefficients

I'm telling this story from personal experience: I'm working on a project where I have to deal with two "expansion coefficients" that all substances have -- how they expand (or contract) upon receiving energy -- , but that do not appear often in most thermodynamic analyses. Hence, I had to go back to the textbooks to understand them.

I'm taking the definitions below from [1]. The first coefficient is the *volumetric isobaric expansivity*, which measured how the volume of a substance changes you heat it up at constant pressure:

$$
\beta = \frac{1}{v}\left(\frac{\partial v}{\partial T}\right)_p
$$

where `\(v\)` is the specific volume, `\(p\)`  is the pressure and `\(T\)` the absolute temperature. This coefficient has units of K$^{-1}$, and can be negative; famously, liquid water expands when cooled down below 4 ºC (this is why water bottles can break in the freezer). Most substances, however, expand when heated up ($\beta > 0$). 

The volumetric expansivity may be familiar to Heat Transfer students, and it appears in Free Convection theory; fluids with large values of `\(\beta\)` change density substantially and then move around quickly when temperature gradients are present.

The other coefficient is the *isothermal compressibility*:

$$
\alpha = -v \left(\frac{\partial v}{\partial p}\right)_T
$$

This coefficient, with units of Pa$^{-1}$ can never be negative: if you exert force in a piston with some fluid at constant temperature, it *will* contract.

## Calculating expansivity and compressibility with CoolProp

Beware that the coefficients above have many names, depending on the source you are using. To calculate them using the CoolProp library in Python, for instance, I had to look up the [available functions](http://www.coolprop.org/coolprop/HighLevelAPI.html#parameter-table). 

Notice that, as derivatives of `\(p-v-T\)` relations, `\(\alpha\)` and `\(\beta\)` are properties of state, depending on two other properties to be calculated. For instance, the expansivity of air at atmospheric pressure and ambient temperature is:


```python
from CoolProp.CoolProp import PropsSI
T0 = 298 # K
P0 = 101.325e3 # Pa
fluid = 'Air'
beta = PropsSI("ISOBARIC_EXPANSION_COEFFICIENT","T",T0,"P",P0,fluid)
print("%.3e K^-1" %(beta,))
```

```
## 3.365e-03 K^-1
```
And the compressibility can be calculated as:


```python
alpha = PropsSI("ISOTHERMAL_COMPRESSIBILITY","T",T0,"P",P0,fluid)
print("%.3e Pa^-1" %(alpha,))
```

```
## 9.872e-06 Pa^-1
```

## Relationship to specific heat

The Mayer relation is [1]:

$$
c_p - c_v = \frac{vT\beta^2}{\alpha}
$$

where `\(c_p\)` and `\(c_v\)` are respectively the constant-pressure and constant-volume speficic heats. The right hand side is always non-negative, which enforces `\(c_p \ge c_v\)`. The equality sign applies from *incompressible substances*, for which `\(\beta = 0\)`. 

Let us verify that relation:


```python
c_p = PropsSI("CPMASS","T",T0,"P",P0,fluid)
c_v = PropsSI("CVMASS","T",T0,"P",P0,fluid)
v = 1/PropsSI("D","T",T0,"P",P0,fluid)
print(c_p - c_v - v*T0*beta**2/alpha)
```

```
## 0.0
```
### An aside about how these properties are calculated

Engineers should beware of black boxes. In the examples above (and below), what exactly is CoolProp doing?

If you are doing a serious project involving thermodynamic and transport properties, you should definitely check out the [CoolProp documentation on fluid properties](http://www.coolprop.org/fluid_properties/PurePseudoPure.html)

As explained before, `\(\alpha\)` and `\(\beta\)` can be calculated with only knowledge of the equation of state (EOS). Specific heats cannot be calculated from an EOS; additional information about the *energy* of the fluid is needed [2], usually from empirical correlations. What the Mayer relation enforces is that *only the difference between specific heats* can be determined from an EOS; but if you also have a model for `\(c_p\)`, you can calculate `\(c_v\)` and vice-versa. You don't need two different models for the two specific heats.

Check out the CoolProp documentation page above to see what other information, besides the EOS, is needed to build up the CoolProp database.

## Comparison between gases

If we pick only gases commonly present in mechanical engineering applications, how do the values of `\(\alpha\)` and `\(\beta\)` vary between them?

When doing this sort of analysis, I always find it useful to use [pandas](https://pandas.pydata.org/docs/getting_started/) to build a table and work from there:


```python
from pandas import Series, DataFrame
import numpy as np

gases = [
  "Air",
  "Argon",
  "CarbonDioxide",
  "Ethane",
  "Helium",
  "IsoButane",
  "Nitrogen",
  "Methane"]
  
alphav = np.empty_like(gases,dtype='float')
betav = np.empty_like(gases,dtype='float')

for i,gas in enumerate(gases):
  alphav[i] = PropsSI("ISOTHERMAL_COMPRESSIBILITY","T",T0,"P",P0,gas)
  betav[i] = PropsSI("ISOBARIC_EXPANSION_COEFFICIENT","T",T0,"P",P0,gas)

df = DataFrame(
  {
    "Gas": gases,
    "alpha [MPa^-1]": 1e6*alphav,
    "beta [K-1]": betav
}
)
print(df)
```

```
##              Gas  alpha [MPa^-1]  beta [K-1]
## 0            Air        9.872466    0.003365
## 1          Argon        9.875500    0.003366
## 2  CarbonDioxide        9.919539    0.003412
## 3         Ethane        9.945354    0.003435
## 4         Helium        9.864455    0.003354
## 5      IsoButane       10.145642    0.003660
## 6       Nitrogen        9.871181    0.003364
## 7        Methane        9.886582    0.003377
```

Frankly, this result, with this low variation between gases, surprises me. Mind you that CoolProp is not just using Ideal Gas relations (otherwise the compressibility and expandability of the gases would be equal - prove it!), but is actually using experimental `\(p-v-T\)` data. It just so happens that there is not a wide variation between gases.

## Final remarks

I've written this post because I needed to learn more about these properties, and I hope it will help more people. Please share it if you find it useful!

## References

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[2]: Callen, H. B. Thermodynamics and an Introduction to Thermostatistics (2nd ed.). John Wiley and Sons, 1985.
