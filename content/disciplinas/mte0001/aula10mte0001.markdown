---
date: "2022-05-24"
title: Aula 10 Teórica - Análise de Segunda Lei de Combustão 
type: book
weight: 90
---

## Uma Revisão de Termodinâmica de Misturas

Na [aula passada](https://fpfortkamp.com/disciplinas/mte0001/aula9mte0001/), detalhamos uma Análise de Primeira Lei de um processo de combustão em sistema fechado. Ao fazer isso, nós aplicamos uma regra de misturas conhecida como a Lei de Amagat: quando você tem uma mistura de gases ideais (como é o gaso dos gases de combustão) a uma pressão `\(P\)` e a uma temperatura `\(T\)`, o volume da mistura é a soma dos volumes que cada gás teria se estivesse isolado na mesma temperatura `\(T\)` e pressão `\(P\)`. 

Isso não é tão óbvio quanto parece porque, em uma mistura, podemos facilmente considerar que todos os componentes estão na mesma temperatura, mas não na mesma pressão; cada gás contribui um pouco para a pressão total, já que esta é a soma das forças que as moléculas fazem sobre uma parede de área unitária.

Assim, em uma mistura de `\(k\)` componentes, consideramos que cada componente `\(i\)` tem a sua fração molar `\(y_i\)`, e a sua *pressão parcial* é `\(P_i = y_i P\)`.

### Variação de energia e entropia em um processo de mistura

Para os gases ideais, a entalpia e a energia interna são funções apenas da temperatura, então se a temperatura de cada componente é a temperatura da mistura, então a entalpia da mistura é simplesmente a soma das entalpias inviduais - e de fato fizemos isso extensivemente nas últimas aulas. *Porém, mesmo para gases ideais, a entropia depende da pressão*. Se você mistura `\(k\)` componentes individualmente na mesma temperatura `\(T\)`, a temperatura "parcial" continua sendo `\(T\)`. Se você mistura os `\(k\)` componentes, todos originalmente na mesma pressão `\(P\)`, a pressão final de cada componente não vai ser `\(P\)`, mas `\(P_i\)`, e portanto a entropia muda. 

Seja um componente `\(i\)` que estava originalmente a `\(P\)`, e após a mistura está a `\(y_i P\)`. Assumindo que a temperatura não muda, a variação da entropia de `\(i\)` durante a mistura é:

$$
\Delta s_i = s_{i,\mathrm{misturado}} - s_{i,\mathrm{isolado}} = -R_u \ln \frac{P_i}{P} = -R_u \ln y_i
$$

Como `\(y_i < 1\)`, `\(\Delta s_i > 0\)`. *O processo de mistura de gases gera entropia*, e isso tem consequências do ponto de vista da Segunda Lei da Termodinâmica.

### Processos de mistura e separação e irreversibilidades

Se, como colocado acima, o processo de mistura gera entropia, então ele é irreversível; *trabalho poderia ser gerado se o processo fosse feito de maneira controlada*:

{{< youtube 5UxCUuk4CEs >}}

e o reverso pode ser feito -  trabalho pode ser adicionado a uma mistura para separar os componentes:

{{< youtube U4xZI2WHOQo >}}

Note nos dois vídeos acima como a *pressão* da mistura é manipulada, já que, como colocado, isso afeta a entropia e então o sentido em que trabalho pode ser adicionado.

## Variação de entropia em sistemas reativos

Os exemplos acima não correspondem a reações químicas, mas simplesmente a misturas (onde não há liberação de calor ou mudança na composição), mas esses conceitos podem ser estendidos para o estudo da combustão.

Realizando um balanço de entropia em um sistema reativo entre reagentes (R) e produtos (P), que troca calor `\(Q\)` com uma fonte a `\(T_f\)`, temos:

$$
S_{\mathrm{ger}} = S _{\mathrm{P}} - S _{\mathrm{R}} - \frac{Q}{T _f}
$$
Agora: como calculamos a entropia total da *mistura* de reagentes e da *mistura* de produtos?

A **Terceira Lei da Termodinâmica** diz que a entropia de uma substância cristalina pura à temperaratura de 0 K é 0 [1]. Os gases ideais que tratamos nos produtos e nos reagentes obviamente não são substâncias cristalinas e obviamente não estão a 0 K, então precisamos calcular variações. Nós temos tabelados valores da *entropia absoluta* `\(\overline{s} _i^o\)` de diversos gases em uma dada temperatura `\(T\)` a na pressão padrão `\(P_o = 1\ \mathrm{atm}\)`. A entropia de cada componente na mistura (de reagentes ou produtos) é então:

$$
\overline{s} _i (T _m,P _i) = \overline{s} _i^o - R_u \ln \frac{y _i P _m}{P _o}
$$
onde cada fase `\(m = {R,P}\)` está na temperatura `\(T_m\)` e pressão `\(P_m\)`.

## Trabalho reversível

Como visto anteriormente, a geração de entropia devido à reação química (descontada devidamente da transferência de calor devido à reação) pode ser revertida em trabalho, mas raramente o é. O trabalho perdido durante esse processo, isto é, o máximo trabalho que poderia ser gerado, por ser computado por:

$$
W_{\mathrm{max}} = T_0 S_{\mathrm{ger}}
$$

onde `\(T_0\)` é a temperatura da vizinhança, usualmente admitida como equivalente à temperatura do estado padrão (298 K).

## Exemplos

Ex. 15-91 de [1]: Octano líquido ($\mathrm{C} _8 \mathrm{H} _{18}$) a 25 ˚C e 1 atm entra a uma vazão de 0,25 kg/min em uma câmara de combustão que opera em regime permanente. Ele é queimado com 50% de excesso de ar, que também entra na  câmara a 25 ˚C e 1 atm. Após a combustão, os produtos são resfriados até 25 ˚C.  Os  produtos saem a 1 atm e a temperatura ambiente é 298K. Considerando uma combustão completa, na qual todo a água formada está na forma líquida, determine

a) Taxa de transferência de calor da câmara de combustão;

b) Taxa de geração de entropia;

c) Taxa de destruição de trabalho.

Ex: 14-92 de [2]: Um inventor aﬁrma ter construído um equipamento que a partir 
de 0,001 kg/s de água, obtida numa torneira a 10 ˚C e 100 kPa, produz ﬂuxos separados de 
gás hidrogênio e oxigênio, cada um a 400 K e 175 kPa. Ele diz que seu equipamento opera 
numa sala a 25 ˚C e com um consumo de 10 kW elétricos. Como você avalia esta afirmação?

## Referências

[1]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[2]: Sonntag, R. E; Borgnakke, C.; Van Wylen, G. J. Fundamentos da Termodinâmica (6a ed.). São Paulo: Edgard Blücher, 2003.
