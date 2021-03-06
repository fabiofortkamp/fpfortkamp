---
date: "2022-04-20"
title: Aula 7 - Formação de poluentes
type: book
weight: 70
---

Diversos fenômenos contribuem para a formação de compostos danosos ao ambiente em motores, e estão intimamente ligados ao processo de combustão.

Principais poluentes de motores de ignição por faísca MIF [1]:

- óxido nítrico ($\mathrm{NO}$) e pequenas parcelas de dióxido de nitrogênio ($\mathrm{NO_2}$), que costumamos denotar coletivamente como NOx - da ordem de 20g/kg de combustível em operações típicas. Geram chuva ácida;
- monóxido de carbono ($\mathrm{CO}$) - 200g / kg de combustível. Provocam sufocamento pela reação com hemoglobina;
- hidrocarbonetos não queimados e que evaporam do combustível (HC): metano, tolueno, benzeno. Muitos são carcinogênicos e geram fumaça.

O combustível e tipo de motor influencia. Por exemplo:

- Motores Diesel: emitem mais partículas sólidas; apresentam emissões desprezíveis de `\(\mathrm{CO}\)` por operar com excesso de ar na maior parte do tempo; emissões de HC são tipicamente 20%  dos valores de MIF. Também contém mais enxofre e emitem mais `\(\mathrm{SO}_2\)` (que pode se oxidar em trióxido de enxofre `\(\mathrm{SO}_3\)`, que por sua vez se mistura com água para formar ácido sulfúrico;
- Motores a etanol emitem *aldeídos*, um tipo de hidrocarboneto oxigenado.

### Visão geral da formação de poluentes

Resumo do processo de formação de poluentes [1]:

{{< figure src="heywood-pollutants.png" caption="Fonte: [1]">}}

(*crevice* = "fenda, abertura")


O grupo que possui mais fontes de formação são hidrocarbonetos:

1. A alta pressão durante os tempos de compressão e combustão força mistura não queimada para fendas, que não permitem a propagação da chama ;
2. Os gases aderem quimicamente à parede porosa (fora das fendas, formando um filme); a chama se extingue à medida que se aproxima da parede e não consegue queimar completamente essa camada;
3. São absorvidos pelos filmes de óleo lubrificante e depois dessorvidos não-queimados.

Experimentos mostram que parte desses HC acabam se oxidando durante o tempo de expansão e descarga, mas um pouco ainda escapa pelo sistema de exaustão.

O nível de emissões nos gases de descarga pode ser caracterizado pela **razão de equivalência combustível-ar** [1]

{{< figure src="heywood-emissions.png" caption="Fonte: [1]">}}

Observar que não está em escala; a magnitude de cada poluente deve ser considerada separadamente. Alguns efeitos:

- Misturas mais econômicas emitem menos poluentes (pois há menos combustível); exceto em concentrações muito baixas quando o processo de combustão se torna errático e há aumento de emissões de HC;
- O pico de NO é porque as condições ótimas de combustão aumentam a temperatura da chama (explicação logo mais)


O grande desafio do estudo de emissões de motores é que há poucas opções de controle que agem sobre os três tipos ao mesmo tempo em que asseguram funcionamento energético do motor. Exemplo: ao passar de condições estequiométricas para mais ricas para aumentar a potência, aumentamos as emissões de HC e CO; ao reduzir a quantidade de combustível, aumentamos as emissões de NO.

Notas que essas figuras são para motores Otto; para motores Diesel, o processo de formação é semelhante, e existe ainda a dependência da distribuição da mistura.

## Temperatura adiabática de chama

[Na última aula](https://fpfortkamp.com/disciplinas/st2mte1/aula6st2mte1/), começamos a detalhar o comportamento energético dos processos de combustão, começando com um modelo muito básico de reação *isobárica* e *isotérmica*, onde a variação energética é apenas devido a mudanças na composição. 

Uma reação real não é isotérmica; os produtos de combustão ficam quentes - e esse aumento de temperatura afeta as emissões. Em Termodinâmica, geralmente estamos interessados em *limites*: "quão quentes podem ficar os gases de combustão"? A resposta é a **temperatura adiabática de chama**.

### Entalpia de uma substância fora do estado padrão

Vamos continuar assumindo que a pressão é a mesma, de maneira que as transferências de calor e trabalho se convertem em variações de entalpia.

Como vimos, a entalpia de todas as substâncias no estado padrão, devido apenas à sua energia química, é a sua entalpia de formação.

Em um estado `\((T,P)\)`, a entalpia molar de uma substância é então:

$$
\overline{h}(T,P) = \overline{h} _f^o(T _o,P _o) + \left(\overline{h} _{\mathrm{sens}} (T,P) - \overline{h} _{\mathrm{sens}} (T _o,P _o)\right)
$$

onde o termo do lado direito diz respeito a valores tabelados de entalpia de uma substância pura:


{{< figure src="ig-shapiro.png" caption="Fonte: [2]">}}

Observe que na análise energética de uma substância pura *tanto* a entalpia de formação *quanto* a entalpia sensível (i.e. dependente apenas da temperatura) no estado padrão somem e não fazem diferença nenhuma na análise.

### Primeira Lei da Termodinâmica para uma reação adiabática

Você já deve ter reparado que, ao estudar processos termodinâmicos, geralmente consideramos os limites de *processos isotérmicos* e *processos adiabáticos*. Na aula anterior estudamos as reações isotérmicas, e hoje vamos nos dedicar as reações adiabáticas, com a consideração adicional de que não há nenhuma realização de trabalho que não seja o de fronteira (que já foi incluído na entalpia).

Assim, a entalpia dos reagentes deve se conservar nos produtos:

$$
\sum _R n _{\mathrm{R}}\left(\overline{h} _f^o + \left(\overline{h}  - \overline{h}^o  \right)\right) = \sum_P n _{\mathrm{R}}\left(\overline{h} _f^o + \left(\overline{h} - \overline{h}^o  \right)\right)
$$

onde abandonamos o subscrito "sens" e `\(\overline{h}^o\)` é a entalpia sensível no estado padrão. 

Como a entalpia de formação via de regra diminui em uma reação (geralmente indo de zero a um valor bastante negativo), a parcela sensível da entalpia precisa aumentar para compensar. 

Usualmente, adimitimos que os produtos estão em equilíbrio termodinâmico, e portanto estão todos na mesma temperatura. A temperatura dos produtos que satisfaz o balanço acima é a a *temperatura adiabática de chama*, a máxima temperatura alcançada em uma reação de combustão (a não ser que calor ou trabalho extra sejam adicionados *ao* sistema, o que não é usual). Numa reação real, os gases saem mais frios que isso por causa da perda de calor [3].

### Cálculo da temperatura adiabática de chama com tabelas e bibliotecas computacionais

Ex. 15.81 de [3]: Octano líquido ($\mathrm{C}_8\mathrm{H}_{18}) é queimado no combustor 
adiabático de pressão constante de um motor de avião com 40% de excesso de ar. O ar 
entra nesse combustor a 600 kPa e 307 ˚C, e o combustível é injetado no combustor a 25 
˚C. Estime a temperatura na qual os produtos da combustão deixam o combustor.

**Solução usando bibliotecas computacionais**:  Podemos usar a biblioteca [PYroMat](http://pyromat.org/documentation.html) para isso, juntamente com [uma tabela de entalpias de formação](http://fpfortkamp.com/disciplinas/mte0001/hformation.csv); não importa que sejam de fontes separadas, pois na análise de entalpia sensível aparecem apenas *diferenças* de entalpia.



```python
import pyromat as pm
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

HFDF = pd.read_csv("hformation.csv",index_col=0)

def hfo(component):
  return float(HFDF["Enthalpy of formation(kJ/kmol)"][component])

def MM(component):
  return float(HFDF["M(kg/kmol)"][component])

N2 = pm.get('ig.N2')
O2 = pm.get('ig.O2')
CO2 = pm.get('ig.CO2')
H2O = pm.get('ig.H2O')

MMO2 = MM("Oxygen gas")
MMCO2 = MM("Carbon dioxide")
MMH2O = MM("Steam")
MMN2 = MM("Nitrogen gas")
# Reação:
# C8H18 + 1.4ath (O2 + 3.76N2) =  aCO2 +bH2O +c O2 + d N2 
a = 8
b = 9
ath = 12.5
c = 5
d = 65.8

T0 = 298
T_reac = 307+273

Hreac = hfo("Octane liquid") + 1.4*ath*(O2.h(T=T_reac) - O2.h(T=T0))*MMO2 + 1.4*3.76*(N2.h(T=T_reac) - N2.h(T=T0))*MMN2

def Hprod(T):
  hCO2 = hfo("Carbon dioxide") + (CO2.h(T=T)-CO2.h(T0))*MMCO2
  hH2O = hfo("Steam") + (H2O.h(T=T)-H2O.h(T0))*MMH2O
  hO2 = hfo("Oxygen gas") + (O2.h(T=T)-O2.h(T0))*MMO2
  hN2 = hfo("Nitrogen gas") + (N2.h(T=T)-N2.h(T0))*MMN2
  H = a*hCO2 + b*hH2O + c*hO2 + d*hN2
  return H

fig, ax = plt.subplots()

Tvalues = np.linspace(T0,3000)
ax.plot(Tvalues,Hreac[0]*np.ones_like(Tvalues),'k--',label="Reagentes")
ax.plot(Tvalues,Hprod(Tvalues),'k-',label="Produtos")
ax.set_xlabel("Temperatura [K]")
ax.set_ylabel("Entalpia [kJ/kmol(cb)]")
ax.legend()
ax.grid(True)
plt.show()
```

<img src="/disciplinas/st2mte1/aula7st2mte1_files/figure-html/unnamed-chunk-1-1.png" width="672" />

Podemos calcular de maneira exata *zerando* a função "resíduo" entre os dois lados do balanço:


```python
from scipy.optimize import brentq

def fres_ad(T):
  return Hreac[0] - Hprod(T)[0]

T_min = T0
T_max = 100000

Tad = brentq(fres_ad,T_min,T_max)
print("Temperatura adiabática de chama: %.2f K" %(Tad,))
```

```
## Temperatura adiabática de chama: 1969.74 K
```

## Noções de Equilíbrio Químico

Outro conceito que auxilia bastante no cálculo e no entendimento da formação de poluentes é o conceito de *equilíbrio químico*. A formulação a seguir foi adapatada de [1] e [2].

Quando escrevemos as reações de combustão entre combustíveis e ar, nós assumimos que as reações *se completam*. O projeto da câmara de combustão, do sistema de injeção de combustível e alimentação de ar e do sistema de ignição (quando houver) é feito para que o processo ocorra da melhor maneira possível e, no final, o carbono, enxofre e hidrogênio do combustível se oxide completamente.

Após a combustão, pporém, o cilindro contém uma mistura de gases ($\mathrm{O}_2, \mathrm{CO}, \mathrm{CO2}, \mathrm{N_2}$ etc), que podem reagir entre si ou não. *Essas reações não necessariamente se completam*, porque pode ocorrer **equilíbrio químico** entre reagentes e produtos.

Considere o sistema formado pelos gases de combustão, que estão a uma determinada temperatura `\(T\)` (limitada, como vimos, pela temperatura adiabática de chama) e a uma determinada pressão `\(P\)`. Este sistema pode trocar uma quantidade de calor `\(Q\)` com a vizinhança (positivo quando entra no sistema); a Segunda Lei da Termodinâmica requer então:

$$
\Delta S \ge \frac{Q}{T}
$$

onde a desigualdade ocorre quando há uma *geração* de entropia em um processo irreversível.

Supondo que todo trabalho ocorra de maneira reversível, o quantidade de calor satisfaz:

$$
Q = \Delta H
$$
e portanto 

$$
\Delta H - T \Delta S \le 0
$$
onde o lado esquerdo é a variação da *energia de Gibbs* `\(G = H - TS\)` em um processo isotérmico e isobático. Logo, em uma reação:

$$
\Delta G \le 0
$$

e então concluímos que as reações ocorrem no sentido de diminuir a energia de Gibbs. Quando ela estabiliza (i.e. para de diminuir), a reação se conclui e o sistema atingiu o equilíbrio. Voltando ao exemplo anterior, na combustão em si, queremos que a temperatura seja tal que a configuração com apenas gases de combustão tenha uma energia de Gibbs *menor* que se sobrar combustível não-queimado, de maneira que a reação possa continuar. Se a temperatura for baixa, porém, a energia de Gibbs dos reagentes pode ser muito menor que a dos produtos, de maneira que se a reação continuar a energia de Gibbs vai aumentar, o que é proibido pela Segunda Lei.

Uma reação estequiométrica pode ser escrita como [1]:

$$
\sum_i \nu_i M_i = 0
$$
onde `\(\nu_i\)` são os coeficientes estequiométricos, positivos para os produtos e negativos para os reagentes, e `\(M_i\)` são os componentes.

Suponha uma reação onde `\(M_a\)` e `\(M_b\)` formando `\(M_c\)` e `\(M_d\)`. Essa reação se completa? Para isso, vamos assumir que `\(\delta n_a <0\)` de `\(M_a\)` sejam consumidos. Para manter a estequiometria, `\(\frac{\nu_b}{\nu_a}\delta n_a\)` de `\(M_b\)` também vão ser consumidos. Ou seja, o seguinte balanço deve ser satisfeito:

$$
\frac{\delta n _a}{\nu _a} = \frac{\delta n _b}{\nu _b} = \cdots
$$

A mudança de energia de Gibbs é então:

$$
\Delta G = \sum_i \mu_i \delta n_i
$$

onde `\(\mu_i\)` é potencial químico do componente `\(i\)`. **Assumindo que todos os componentes sejam gases ideais**:

$$
\mu_i (T,P) = \overline{g} _i ^o(T) + R_u T \ln \frac{y_i P}{P_o }
$$
onde o primeiro termo é a energia de Gibbs de formação, um dado tabelado no estado padrão `\((T_o, P_o)\)`, e `\(y_i\)` é a fração molar do componente na mistura.

A condição de equilíbrio ($\Delta G = 0$), que equivale a dizer que essa reação se completa, pode então ser expressa como:

$$
\sum_i \nu _i \left( \overline{g} _i ^o(T) + R_u T \ln \frac{y_i P}{P_o} \right) = 0
$$
A condição de equilíbrio pode ser re-arranjada como:

$$
\sum_i \ln \left(\frac{y_i P}{P_o}\right)^{\nu_i}  = - \frac{\sum_i \overline{g}_i^o (T) \nu_i}{R_u T} = - \frac{\Delta G^o (T)}{R_u T} = \ln K_p
$$
onde `\(K_p\)` é *constante de equilíbrio*, que também é um valor tabelado para reações comuns em engenharia, e que depende apenas da temperatura (você consegue visualizar por quê?) - novamente, assumindo que todos os componentes são gases ideais. O conhecimento dessa constante permite calcular a composição de equilíbrio dessa forma:

$$
K_p = \left(\prod_i n_i^{\nu_i}\right)\left(\frac{P}{n_{\mathrm{total}}}\right)^{\sum_i \nu_i}
$$

onde `\(P\)` é a pressão da câmara de reação em atm.

Há dificuldades em analisar reações reais a partir do pequeno portfólio de reações nas tabelas de `\(K_p\)`. Algumas reagras podem ajudar [3]:

1. O `\(K_p\)` de uma reação é o inverso da reação inversa;
2. O `\(K_p\)` de `\(x\)` reações (multiplicando todos os coeficientes estequiométricos por `\(x\)`) é `\(K_p^x\)`.


### Exemplo de aplicação de equilíbrio

De [3]: A reação `\(\mathrm{N}_2 + \mathrm{O}_2 \to 2 \mathrm{NO}\)` ocorre em motores de combustão interna. Determine a fração molar de equilíbrio do óxido nítrico a 1 atm, considerando temperaturas de 298K, 1000K e 1600 K.


```python
from math import sqrt

# from [2]
log10Kp_original = {
  298: -15.171,
  1000: -4.062,
  1600: -2.290
}

for T in log10Kp_original:
  print("T = %d K" %(T,))
  Kp = (10**(log10Kp_original[T]))**2
  
  a1 = (8 - sqrt(64-16*(4-Kp)))/(2*(4-Kp))
  a2 = (8 + sqrt(64-16*(4-Kp)))/(2*(4-Kp))
  nN2 = (a1 if a1 > 0 else a2)
  nO2 = nN2
  nNO = 2*(1-nN2)
  
  yNO = nNO/(nN2 + nO2 + nNO)
  print("yNO = %.5f" %(yNO))
```

```
## T = 298 K
## yNO = 0.00000
## T = 1000 K
## yNO = 0.00004
## T = 1600 K
## yNO = 0.00256
```

Portanto, em temperaturas baixas, essas reações não tem condições de ocorrer; a formação de NO vai aumentar a energia de Gibbs. À medida que a temperatura aumenta, mais NO pode ser formado sem que `\(G\)` aumente. E é por isso que a emissão de `\(\mathrm{NO}\)` *aumenta* com a temperatura.

## Referências

[1]:Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.

[2]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.


[3]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.
