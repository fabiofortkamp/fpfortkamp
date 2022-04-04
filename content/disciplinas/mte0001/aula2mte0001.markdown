---
date: "2022-04-04"
title: Aula 2 Teórica - Ciclos Ideais de Motores de Combustão interna
type: book
weight: 30
---

O [Ciclo de Carnot](https://fpfortkamp.com/disciplinas/mte0001/aula1mte0001/) é totalmente reversível mas não representa o funcionamento real das máquinas térmicas existentes. Principalmente nos processos isotérmicos, o ciclo de Carnot precisa acontecer infinitamente devagar porque você não pode deixar a temperatura mudar enquanto calor é transferido e o pistão se move. 

Um motor a combustão a interna precisa de processos rápidos, que consigam funcionar a milhares de rotações por minuto. 

Nós precisamos de ciclos ideais que sejam representações, ainda que simplificadas, do que de fato acontece). Estes ciclos são todos internamente reversíveis (então o fluido não experimenta atrito com as paredes, e todos os processos são quase-estáticos), mas geralmente vão incluir *irreversibilidades externas* - geralmente, transferência de calor com uma diferença de temperatura finita.

Para melhor analisar e identificar tendências, usamos as **Hipóteses do Padrão a Ar Frio** [1]:

- Fluido de trabalho é um gás ideal em sistema fechado;
- Todos os processos são internamente reversíveis;
- A combustão é representada por um fornecimento de calor (e não ocorre de maneira isotérmica, por causa da restrição de tempo do ciclo de Carnot)
- A exaustão é representada por uma rejeição de calor;
- Calores específicos independentes de temperatura:

$$
c_p = \left(\frac{\partial h}{\partial T}\right)_p
$$

$$
c_v = \left(\frac{\partial u}{\partial T}\right)_v
$$

Observe que, para um gás ideal, esses parâmetros dependem apenas da temperatura, bem como a entalpia e a energia interna.

Além disso, temos: 

Constante de gás ideal:

$$
R = c_p - c_v
$$

Razão de calores específicos:

$$
k = \frac{c_p}{c_v}
$$

## Ciclo Otto

O ciclo Otto é o ciclo representativo dos motores de ignição por faísca:

{{< figure src="engines-schematics-cengel.png" caption="Fonte: [1]">}}

Conforme explicado anteriormente, nós idealizamos esse ciclo da seguinte maneira: tratamos o fluido de trabalho como um gás ideal em um sistema fechado, não levando em conta os tempos de admissão e descarga, portanto; tratamos os processos de compressão e expansão como adiabáticos e reversíveis (por quê?), e os processos de combustão e rejeição de calor como iso-volumétricos.
Em um diagrama `\(P-v\)`, temos:

{{< figure src="otto-pv-cenvel.png" caption="Fonte: [1]">}}

e, em um diagrama `\(T-s\)`:

{{< figure src="otto-ts-cengel.jpeg" caption="Fonte: [1]">}}

Comparando com o Ciclo de Carnot, observe que substituímos os processos isotérmicos, que eu havia falado que são muito lentos, por processos isovolumétricos, "instantâneos", explosivos - o pistão não se mexe.

Uma grandeza importante é a *razão de compressão `\(r_{\mathrm{comp}}\)`*, definido como a razão entre os volumes máximo (PMI) e mínimo (PMS):

$$
r_{\mathrm{comp}} = \frac{v_{\mathrm{max}}}{v_{\mathrm{min}}}
$$
Nas expressões a seguir, desprezamos os efeitos de energia cinética e potencial.

Os processos de entrada de calor a volume constante são, em processo genérico A-B, são:

$$
q_{A-B} = c_v(T_A - T_B)
$$

além disso, as seguintes relações são úteis:

Em todos os pontos do diagrama:

$$
Pv = R T
$$

onde `\(R\)` é a constante de gás ideal.

Para os processos a entropia constante, usando as Hipóteses Padrão a Ar frio:

$$
Pv^k = \mathrm{constante}
$$

onde `\(k\)` é a razão de calores específicos.

### Um exemplo numérico

Ex. 9-39 de [1]: A razão de compressão de um ciclo Otto padrão a ar é 9,5. Antes do processo isentrópico de compressão, o ar está a 100 kPa, 35 ˚C e 600 cm$^3$. A temperatura no final do processo de expansão isentrópica é de 800 K. Considerando calores específicos constantes à temperatura ambiente, determine (a) a temperatura e a pressão mais altas do ciclo, (b) a quantidade de calor transferido, em kJ, (c) e a eficiência térmica.

### Trabalho e Eficiência térmica do ciclo Otto

A eficiência térmica do Ciclo Otto, de maneira geral, é:

$$
\eta_{\mathrm{t,Otto}} = 1 - r_{\mathrm{comp}}^{(1-k)}
$$

Fica o desafio: provar isso!

{{< figure src="eta-otto-cengel.png" caption="Fonte: [1]">}}

A razão *k* diminui com a complexidade das cadeias. Para gases monoatômicos (como He), é de 1,667, enquanto que para o dióxido de carbono é de 1,3, para o etanol, de 1,2. Assim, há uma queda de eficiência apenas por precisarmos usar mistura de ar e combustível.

Além disso, observem que a eficiência cresce com a razão de compressão, mas ela é limitada na prática pela temperatura de auto ignição dos combustíveis. Esse é o grande ponto de combustíveis com maior *octanagem* (resistência à auto-ignição). Em 1923, descobriu-se que a adição de chumbo tetra-etila aumentava a octanagem, o que deu origem a motores com alta razão de compressão (e alta eficiência). Na década de 1970, descobriram-se os efeitos danosos do chumbo na gasolina, e os motores caíram de eficiência momentaneamente.

Essa briga entre otimização térmica e adequação às normas ambientais é uma constante na carreira do engenheiro e da engenheira.

Também é interessante observar que a eficiência não depende das temperaturas máximas e mínimas - por que isso acontece?

### Ciclos Diesel e Misto

Esses dois ciclos são característicos de motores de ignição por compressão. Observa-se que, sem a faísca, a dinâmica da combustão é muito mais lenta, resultando no movimento do pistão durante esse processo:

{{< figure src="diesel-ts-pv-cengel.png" caption="Fonte: [1]">}}

O movimento do pistão durante a combustão é caracterizado pela **razão de corte**:

$$
r_{\mathrm{c}} = \frac{v_3}{v_2}
$$

Nesse processo, há saída de trabalho: (sem variações de energia cinética e potencial):

$$
q_{\mathrm{{ent}}} - w_{\mathrm{sai}} = \Delta u = c_v (T_3 - T_2)
$$

Mas o trabalho reversível de expansão de um pistão é:

$$
w_{\mathrm{sai}} = \int P \mathrm{d}v
$$

 Para o processo a pressão constante é:

$$
w_{\mathrm{sai}} = P_2(v_3 - v_2)
$$

de onde:

$$
q_{\mathrm{ent}} = u_3 - u_2 + P_3 v_3 - P_2 v_2
$$

(Observe que `\(P_2 = P_3\)`)

Logo:

$$
q_{\mathrm{ent}} = h_3 - h_2 = c_p (T_3 - T_2)
$$

onde a última igualdade vale para gases ideais com calor específico constante.

E essa relação pode ser usada para analisar esses processos isobáricos. Ainda continua valendo:

$$
w_{\mathrm{liq,sai}} = q_{\mathrm{ent}} - q_{\mathrm{sai}}
$$

e esse trabalho inclui os trechos 2-3, 3-4, e desconta a compressão 1-2.

Eficiência:

$$
\eta_{\mathrm{t,Diesel}} = 1 - \frac{1}{r_{\mathrm{comp}}^{k-1}}\left(\frac{r_{\mathrm{c}}^k - 1}{k\left(r_{\mathrm{c}}-1\right)}\right)
$$

A eficiência térmica cai com a razão de corte mas, em compensação, motores Diesel aguetem maiores razões de compressão; de maneira geral, são mais eficientes que motores a gasolina.

Atualmente, os motores de ignição por compressão são melhor modelados pelo ciclo misto (ou dual, ou Sabathé), que inclui um estágio mais rápido e um mais lento:

{{< figure src="misto-pv-cengel.jpeg" caption="Fonte: [1]">}}


Para uma dada razão de compressão e razão de corte, esse ciclo é mais eficiente que o Diesel. A decomposição do processo de absorção de calor reflete melhor a dinâmica: um estágio rápido (isocórico) de combustão, seguido pela "arrefecimento" da frente de chama, quando a maior parte do combustível já queimou. Como falado anteriormente, esse regime de funcionamento é mais apropriado para altas rotações, historicamente uma limitação de motores Diesel.


{{< figure src="comparacao-eficiencia-brunetti.png" caption="Fonte: [2]">}}

### Um exemplo numérico de ciclo misto

Exercício 9-40 de [3]: No início do processo de compressão em um ciclo de ar-padrão dual, `\(P_1 = 1\, \mathrm{bar}\)` e `\(T_1 = 300 \,\mathrm{K}\)`. A adição total de calor é 1000 kJ/kg. Plote a eficiência térmica e o trabalho líquido como função da razão de compressão, para diferentes valores da fração do calor adicionado a volume constante e a pressão constante.

## Referências

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[2]: Brunetti, F. Motores de Combustão Interna - Volume 1. São Paulo: Blucher, 2012.

[3]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.




