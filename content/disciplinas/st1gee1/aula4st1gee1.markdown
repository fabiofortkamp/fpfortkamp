---
date: "2022-04-28"
title: Aula 3 - Fornalhas e composição de combustíveis
type: book
weight: 30
---

## Fornalhas

A fornalha é a instalação onde ocorre a reação de combustão em um gerador de vapor [1]; é onde ar e combustível são *alimentados* e onde os gases são formados:

{{< figure src="gerador-adaptado.png" caption="Fonte: Adaptado de [1]">}}

O projeto da fornalha deve garantir as condições de queima adequadas para o combustível que está sendo usado. Os combustíveis mais usados atualmente em geradores de vapor são:

1. Carvão mineral
2. Lenha
3. Óleo combustível
4. Gás Natural
5. Biomassa

Que fatores você acha que estão envolvidos na escolha de um destes combustíveis?

Dependendo da fase do combustível e de suas características, diferentes tipos de fornalha existem [1]:

1. Fornalhas de queima em suspensão
2. Fornalhas de queima em grelha
3. Fornalhas de queima em leitos fluidizados.

É uma via de mão dupla: podemos projetar uma fornalha para um combustível escolhido, mas também podemos trocar o combustível se a fornalha já construída for compatível.

Uma das principais características de uma fornalha é seu *volume*. Pense em situações limite: o que você acha que acontece com o processo de combustão quando o volume da fornalha é muito pequeno? E quando é muito grande?

Uma maneira de quantificar essa determinação de uma faixa para o volume de uma fornalha é a *carga térmica volumétrica*, definida como a razão entre o calor liberado na combustão (definido na [aula passada](https://fpfortkamp.com/disciplinas/st1gee1/aula2st1gee1/))  e o volume da fornalha. A figura seguinte apresenta valores típicos de carga térmica volumétrica, dependendo do tipo de fornalha, do tipo de caldeira (que vamos estudar mais para a frente), e do tipo de combustível:

{{< figure src="carga-termica.png" caption="Fonte: [1]">}}

## Composição de combustíveis

Na avaliação do processo de queima, a principal característica que importa dos combustíveis é a sua *composição gravimétrica*, isto é, as frações mássicas que são ocupadas por cada componente. 

Os combustíveis industriais são uma mistura de [2]:

1. Carbono ($\mathrm{C}$)
2. Hidrogênio ($\mathrm{H2}$)
3. Enxofre ($\mathrm{S}$)
4. Oxigênio ($\mathrm{O}_2$)
5. Nitrogênio ($\mathrm{N}_2$)
6. Umidade ($\mathrm{H_2O}$)
7. Cinzas

É preciso ser bastante claro na indicação da composição do combustível. Por exemplo, vamos dizer uma amostra de carvão é analisada e percebe-se que ele tem um teor de umidade de 20%. O carvão então é seco e analisado novamente, e descobre-se que, na base seca, ele tem 60% de carbono. Se estamos analisando uma reação do carvão já seco, então este é o teor de carbono; porém, se analisarmos uma reação do carvão úmido, então o seu teor de carbono em relação à massa total é 60% de 80%, ou 48%.

Nós vamos denotar `\(x_i\)` a fração mássica do componente `\(i\)` no combustível a ser analisado.

## Visão geral da combustão

Uma reação de combustão é uma reação de algumas substâncias ou elementos com oxigênio, com subsequente liberação de energia.

Cada um dos componentes tem a sua reação química balanceada com o oxigênio, com a sua respectiva liberação de energia, como por exemplo [1]:

$$
\mathrm{C} + \mathrm{O}_2 \to \mathrm{CO}_2 + 33900 \,\mathrm{kJ/kg}
$$

$$
\mathrm{S} + \mathrm{O}_2 \to \mathrm{S}\mathrm{O}_2 + 9200 \,\mathrm{kJ/kg}
$$
Chamo a atenção para a reação do enxofre. Como vamos falar, o enxofre é um componente indesejado mas inevitável dos combustíveis, que até ajuda a liberar energia, mas muito pouca.

No caso do gás natural, o que é mais comum é expressar a composição em base volumétrica normal, isto é, a cada 1 m$^3$ de gás natural a 0 ºC e 1 atm, qual o volume parcial de cada hidrocarboneto que compõe o gás. Por exemplo, no caso do etano:

$$
2\mathrm{C}_2\mathrm{H}_6 + 7\mathrm{O}_2 \to 4\mathrm{CO}_2 + 6 \mathrm{H}_2\mathrm{O} + 51870 \,\mathrm{kJ/kg}
$$
Os gases de interesse em combustão podem ser tratados como gases ideais [3]. O volume ocupado por 1 kmol de *todos os gases ideais* uma uma pressão e temperatura especificados é o mesmo, independente da composição do gás. Portanto, se em 100 m$^3$ de gás natural há, digamos, 10 m$^3$ de etano, isso é completamente equivalente a dizer que, em 100 kmol de gás natural, há 10 kmol de etano.  Nós usamos a notação `\(y_i\)` para denotar a fração molar (ou volumétrica) de misturas de gases.

Na prática, os combustíveis industriais são misturas de todos esses componentes. O que chamamos de gás natural, por exemplo, é uma mistura do etano com metano e outros gases mais pesados. A lenha contém carbono, enxofre e outros componentes. Esses valores de energia por cada componente se somam e continuem para o *poder calorífico* dos combustíveis, e como vimos em aulas anteriores, esse poder calorífico é transferido para o vapor d'água na caldeira. 

Reparar que é necessário oxigênio para ocasionar a reação. Poderíamos até fornecer oxigênio puro, o que seria mais eficiente, mas muito caro. Na prática, fornecemos ar, que vamos considerar como uma mistura de ar seco e umidade, sendo o ar seco uma mistura de oxigênio e nitrogênio. Consideramos também que cada 1 kg de ar seco carrega `\(\omega\)` kg de umidade (vapor d'água dissolvido no ar). 

Em base molar (ou volumétrica, já que consideramos o ar um gás ideal que é uma mistura de gases ideais `\(\mathrm{O}_2\)` e `\(\mathrm{N}_2\)`), o ar contém 21% de oxigênio e 79% de nitrogênio. Cada mol de `\(\mathrm{O}_2\)` é acompanhado por 3,76 kmol (21% = 1 / (1 + 3,76)).

## Poder calorífico inferior

A maneira correta de calcular o poder calorífico inferior de combustíveis é escrever a reação e aplicar a Primeira Lei da Termodinâmica a essa reação. 

Considere uma reação de um determinado combustível, com a composição gravimétrica especificada. Na fornalha, não há realização de trabalho; vamos denotar `\(\dot{Q}_{\mathrm{comb}}\)` a taxa de liberação de calor na combustão. Uma análise de Primeira Lei da Termodinâmica em regime permanente, sem variações de energia cinética e potencial, fornece:

$$
\dot{m}_{\mathrm{cb}}h_{\mathrm{cb}} + \dot{m}_{\mathrm{ar}}h_{\mathrm{ar}} = \dot{Q}_{\mathrm{comb}} + \dot{m}_{\mathrm{g}}h_{\mathrm{g}}
$$
Os valores de entalpia específica são tabelados, porém são tabelados *em relação a uma referência para a substância*. Como aqui temos diferentes substâncias, precisamos estabelecer uma relação entre as referências das diferentes substâncias.

Na análise da combustão, geralmente estabelecemos que o *estado de referência padrão* de todas as substâncias envolvidas é 25 ºC e 1 atm. A entalpia de uma substância reagente no estado padrão é a sua *entalpia de formação*, e, por convenção, a entalpia de formação dos seguintes compostos é nula:

1. Carbono monoatômico
2. Gás nitrogênio
3. Gás oxigênio
4. Gás hidrogênio

O valor absoluto do calor liberado em uma reação de combustão, quando todos os reagentes e produtos são mantidos na mesma temperatura (usualmente a própria temperatura do estado padrão), é o seu *poder calorífico*. O poder calorífico é *inferior* quando o vapor d'água formado está na fase gasosa (o que é geralmente o caso).

O PCI de um combustível, portanto, deve ser calculado escrevendo a reação de combustão, determinando os balanços estequiométricos, e então aplicando a Primeira Lei.

Porém, com boa aproximação [1], o PCI pode ser calculado diretamente com base na composição.

### Para combustíveis sólidos

$$
\mathrm{PCI} = 33900x _{\mathrm{C}} + 141800 \left(x _{\mathrm{H_2}} - \frac{x _{\mathrm{O_2}}}{8}\right) + 9200 x _{\mathrm{S}} - 2400 \left(9 x _{\mathrm{H_2}} + x _{\mathrm{H_2O}}\right)
$$

onde o resultado está em kJ/kg e as frações mássicas são números decimais, não em porcentagens.

### Para combustíveis gasosos

Como o gás natural é uma mistura de gases ideais, podemos ponderar o poder calorífico de cada componente na base mássica:

$$
\mathrm{PCI} = \sum_i x_i \mathrm{PCI}_i
$$

onde, cuidado! As frações volumétricas precisam ser convertidas em frações mássicas.

### Exemplos

**Comparação de poder caloríficos**:

Considere um carvão com composição na base seca:

- 47% de carbono
- 3% de hidrogênio
- 4% de enxofre
- 5% de oxigênio
- 1% de nitrogênio
- 40% de cinzas

Calcule o PCI aplicando a Primeira Lei e com a expressão aproximada.


```python
xC = 0.47
xH2 = 0.03
xS = 0.04
xO2 = 0.05
xN2 = 0.01

MC = 12.01
hfCO2 = -393520

MS = 32.054
hfSO2 = -267100

MH2 = 2.016
hfH2Ov = -241820
PCIp = abs(hfCO2*xC/MC + hfSO2*xS/MS + hfH2Ov*xH2/MH2)
PCIa =  33900*xC+ 141800 *(xH2-xO2/8) + 9200*xS - 2400* (9 *xH2 )
print("PCI (Primeira Lei) = %.2f MJ/kg" %(1e-3*PCIp))
```

```
## PCI (Primeira Lei) = 19.33 MJ/kg
```

```python
print("PCI (approx) = %.2f MJ/kg" %(1e-3*PCIa))
```

```
## PCI (approx) = 19.02 MJ/kg
```

**Exercício 3.1 de [1]**: Considere uma fornalha projetada para queimar 1 kg/s de carvão com composição na base seca:

- 47% de carbono
- 3% de hidrogênio
- 4% de enxofre
- 5% de oxigênio
- 1% de nitrogênio
- 40% de cinzas

Calcule o calor disponível na fornalha, considerando que o carvão é fornecido seco ou úmido (20% de umidade), desprezando as contribuições de calor sensível.

**Exercício  adaptado 15-103 de [4]**: Calcule o PCI de uma mistura gasosa de 40% em volume de butano ($\mathrm{C}_4\mathrm{H}_{10}$) e 60% de propano ($\mathrm{C}_3\mathrm{H}_8$)



## Referências


[1]: Bazzo, E. Geração de vapor (2 ed.). Florianópolis: Editora UFSC, 1995.

[2]: Lora, E. E. S., & Nascimento, M. A. R. do. Geração Termelétrica: Planejamento, Projeto e Operação. Rio de Janeiro: Interciência, 2004.

[3]: Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.


Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[4]: Moran, Michael J; Shapiro, Howard N. Fundamentals of Engineering Thermodynamics (5 ed.). Chichester: Wiley, 2006.


