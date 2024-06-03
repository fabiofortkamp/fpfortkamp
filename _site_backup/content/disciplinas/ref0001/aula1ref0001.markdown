
---
date: "2022-04-05"
title: Aula 1 - Introdução à Refrigeração
type: book
weight: 10
---





## Produção de Frio

Pense no seu refrigerador doméstico. Dentro dele há um *ambiente frio*, que está isolado de um *ambiente mais quente* ao seu redor. O objetivo do refrigerador é justamente criar esse ambiente isolado, de maneira que você consiga armazenar alimentos e impedir a ação bacteriana que ocorre a altas temperaturas [1]. A sua experiência diária mostra que existe alguma ação necessária para isso; se você tirasse o refrigerador da tomada, o interior tenderia a ficar quente, equilibrando-se com o ambiente externo.

A Refrigeração é a arte de **produzir frio** - um termo não muito exato, já que o estamos fazendo é retirar calor e não adicionar "frio", mas que é bastante usado pela indústria e pelas publicações especializadas.

Aquecer coisas é bastante fácil: esfregue uma mão na outra e elas vão ficar quentes. Refrigerar ambientes e sistemas em geral é bastante difícil; exige equipamentos especializados e consumo de energia, com seus custos associados. No momento em que estas notas são escritas, o mundo está emergindo de uma pandemia de COVID-19 ainda presente, e as vacinas foram uma arma importante nesse combate. Existem diferentes vacinas, cada qual com sua eficácia, método - e [temperatura necessária para armazenamento](https://www.cnnbrasil.com.br/saude/vacinas-da-pfizer-poderao-ser-armazenadas-em-freezers-comuns-por-duas-semanas/). O acesso à tecnologia de refrigeração pode significar acesso a alimentos mais duradouros e remédios e vacinas mais sofisticadas. Claramente, é do interesse da sociedade facilitar o "acesso ao frio".

## Requisitos de Refrigeração

Um sistema de refrigeração deve manter uma fonte fria a uma temperatura `\(T_{\mathrm{L}}\)`, enquanto a protege termicamente de uma fonte quente a `\(T_{\mathrm{H}}\)`. A fonte quente vai tender a aquecer a fonte fria se esta não estiver isolada, impondo uma carga térmica. Fontes comuns de carga térmica incluem:

1. Abertura de portas, com consequente entrada de alimentos ou pessoas;
2. Dissipação de calor na fonte fria (metabolismo humano, reações químicas nos alimentos, dissipação Joule em componentes eletrônicos);
3. Infiltração de ar quente por folgas;
4. Condução de calor por paredes e janelas.

Para manter a fonte fria na mesma temperatura, a entrada de carga térmica deve ser compensada, em regime permanente, pela *capacidade de refrigeração* `\(\dot{Q}_{\mathrm{L}}\)`, que vai *da fonte fria para o sistema*. 

A especificação das temperaturas das fontes e da capacidade de refrigeração necessária forma os requisitos mínimos que usualmente são impostos ao projeto de um sistema de refrigeração.

## Segunda Lei da Termodinâmica

A carga térmica atua continuamente sobre a fonte fria, e assim o sistema deve retirar também continuamente a capacidade de refrigeração. Antigamente era bastante comum verdadeiras *geladeiras* onde o gelo era armazenado na parte superior de um gabinete; o ar era resfriado por convecção natural, e, estando mais denso que o ar ambiente, descia e absorvia calor dos alimentos, resfriando-os. O ar agora quente sobe por empuxo, onde cede calor de volta para o bloco de gelo:

{{< figure src="geladeira.png" caption="Fonte: [3]">}}

A desvantagem óbvia deste sistema é que o gelo derrete com o passar do tempo e preciso ser reposto - e de fato um mercado de gelo existiu durante muito tempo, onde o gelo era "minerado" e transportado; esta atividade não foi ainda totalmente esquecida:

{{< vimeo 610454670 >}}

O desafio da Refrigeração é funcionar em *ciclos termodinâmicos*, onde um fluido vai passar por uma série de processos e periodicamente retornar ao seu estado inicial, de maneira que o ciclo funcione de maneira indefinida.

Mas aí a Segunda Lei da Termodinâmica impõe uma restrição: o Enunciado de Clausius [2] proíbe a simples transferência, por um sistema cíclico, de calor de uma fonte fria para uma fonte quente - que é exatamente o que um refrigerador faz; para poder retornar ao seu estado inicial, o sistema rejeita o calor absorvido para a fonte quente. Se você medisse a temperatura do ar adjacente ao condensador do seu refrigerador (a "grade" que fica na parte traseira), veria que ele está mais quente que o ar ambiente. 

O que resolve o Enunciado de Clausis é que essa transferência não é "simples", mas ocorre acompanhada de realização de trabalho mecânico. Como falado no início deste texto, se desligado o refrigerador não produz frio algum. A potência de entrada no sistema `\(\dot{W}_{\mathrm{ent}}\)` deve ser minimizada, mas nunca pode ser nula.

## Compressão de Vapor

Existem diferentes tecnologias de refrigeração; o fator de diferenciação é como a potência é transformada num gradiente de temperaturas. No chamado *lado quente* do refrigerador, o sistema está numa temperatura `\(T_{\mathrm{HE}} > T_{\mathrm{H}}\)` (*HE = hot end*), de maneira que um trocador de calor consiga realizar essa transferência naturalmente. Da mesma maneira, no lado frio, o sistema cria uma temperatura `\(T_{\mathrm{LE}} < T_{\mathrm{L}}\)`. Observe a diferença: `\(T_{\mathrm{HE}}\)` é a temperatura do sistema, do fluido refrigerante, enquando `\(T_{\mathrm{H}}\)` é a temperuta da fonte, geralmente do ar frio.

A tecnologia dominante nos últimos 100 anos têm sido a *Compressão Mecânica de Vapor*, onde ciclicamente pressurizamos e despressurizamos um fluido que escoa, e a temperatura do fluido segue o caminho da pressão.

## Ciclo de Carnot reverso

Uma medida da *eficiência* de um sistema de refrigeração, como uma razão entre "efeito desejado" e "gasto necessário", é o **coeficiente de eficiácia** (ou de desempenho, ou de performance):

$$
\mathrm{COP} = \frac{\dot{Q} _{\mathrm{L}}}{\dot{W} _{\mathrm{ent}}}
$$

Cuidado, porém, que ao contrário da eficiência de uma máquina térmica, o COP pode ser maior que 1 (e de fato desejamos que seja, pagando pouco para conseguir retirar bastante calor).

O limite superior para o COP de qualquer sistema que funcione entre duas isotermas dadas é o COP de um *Ciclo de Carnot reverso*:

{{< figure src="carnot-reverso.jpg" caption="Fonte: [2]">}}

Usando conceitos da Primeira e da Segunda Lei da Termodinâmica (tente!), é possível provar que:

$$
\mathrm{COP} _{\mathrm{Carnot}} = \frac{T _{\mathrm{L}}}{T _{\mathrm{H}}-T _{\mathrm{L}}}
$$


### Cuidado em focar no COP...

Um erro muito comum em quem está começando a estudar na refrigeração, é querer focar no COP como uma métrica absoluta que deve ser maximizada a todo custo.

Considere o caso de dois sistemas de refrigeração, ambos com uma fonte quente a 40 ºC. O primeiro sistema mantém uma fonte a -12ºC e outro a +12ºC. Qual o COP de Carnot dos sistemas? Podemos calcular com Python:


```python
TH = 40 + 273 # temperaturas em análise de Carnot sempre em kelvin!
for tl in [-12,12]:
  TL = tl + 273
  COP_Carnot = TL/(TH-TL)
  print("tl = %d ºC, COP de Carnot = %.2f" %(tl,COP_Carnot))
```

```
## tl = -12 ºC, COP de Carnot = 5.02
## tl = 12 ºC, COP de Carnot = 10.18
```

O COP de Carnot do segundo sistema é o dobro do primeiro - mas ele é *melhor*? Depende do ponto de vista: para cada kW de capacidade de refrigeração, ele de fato consome menos, mas só consegue manter a fonte "fria" em temperaturas relativamente altas.

O Ciclo de Carnot requer processos bifásicos de compressão, o que é bastante difícil de realizar na prática. O ciclo que de fato é usado em refrigeradores reais precisa ser modificado - mas esse é o tema da próxima aula.

## Referências

[1]: Dossat, R. L. Princípios de Refrigeração. [s.l.] Hemus, 2004.

[2]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

[3]: Slides do Prof. Claudio Melo para a disciplina EMC 6238 Refrigeração do POSMEC/UFSC
