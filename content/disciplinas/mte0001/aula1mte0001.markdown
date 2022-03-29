---
date: "2022-03-29"
title: Aula 1 Teórica - Introdução ao Estudo das Máquinas Térmicas
type: book
weight: 20
output: markdown
---

## O que são Máquinas Térmicas

Uma máquina térmica é um conversor de *calor* em *trabalho*.

Por que é necessário um nome pomposo para um conceito aparentemente simples? Porque o conceito não é tão simples assim. Calor e trabalho são duas formas de energia que, pela Primeira Lei da Termodinâmica, são equivalentes no sentido de aumentar a energia interna do sistema. Porém, pela *Segunda Lei da Termodinâmica*, calor e trabalho **não são** equivalentes. 

A obtenção de trabalho mecânico a partir de outras fontes, como se fosse uma *commodity* [1], é uma das tarefas básicas da Engenharia. É com trabalho que movimentamos cargas e pessoas, aplicando *forças* sobre uma *distância*. Para essa disciplina, vamos sempre considerar o trabalho como tipificado por uma árvore girante que entrega torque para outros sistemas [2]. 

Em comparação com o trabalho, a transferência de calor:

1. Contribui com a geração de entropia, ao contrário do trabalho, e portanto contribui para a desordem do sistema;
2. É dependente do gradiente de temperaturas entre fonte e sistema;
3. Nem sempre é equivalente ao levantamento de um peso (imagine pegar um ventilador na sua casa, prender um peso nas pás e ligar na tomada - o peso vai subir. Agora, imagine acender uma vela perto dele - as pás vão se movimentar sem estarem ligadas na tomada e levantar o peso?) 


{{< figure src="cengel63-heat-lift.jpg" caption="Fonte: [3]">}}

Assim, *é necessário* um dispositivo especial que transforma calor em trabalho, que vai funcionar limitado pelas Leis da Termodinâmica (e de outras disciplinas). É por isso que temos uma disciplina voltada para isso.

## A importância dos ciclos termodinâmicos

Em determinadas condições, é possível sim transferir calor em trabalho. Por exemplo, um pistão com um gás, quando aquecido, vai elevar o pistão. O verdadeiro desafio é fazer isto em *ciclos* que funcionem de maneira indeterminada sem interação com o operador e sem resíduos de energia - isto é, que consigam de fato operar em regime permanente.

Neste caso, o Enunciado de Kelvin-Planck da Segunda Lei da Termodinâmica diz que "é impossível para um dispositivo que funciona em ciclos realizar trabalho sobre a vizinhança e trocar calor com uma única fonte". 

O contrário sempre é possível. Pense em uma chaleira elétrica: a rede elétrica funciona em ciclos, e este trabalho elétrico vindo da vizinhaça é inteiramente convertido em transferência de calor para apenas a água no seu interior (uma chaleira elétrica pode funcionar mesmo se o exterior for bem isolado do ambiente). Séculos de experimentação provaram que esse tipo de sistema não pode ser invertido; para calor ser convertido em trabalho, sempre vai haver um *calor residual* que é transferido para um segundo reservatório.

{{< figure src="cengel-69-heat-engine.jpg" caption="Fonte: [3]">}}

Todas as máquinas térmicas funcionam em diferentes ciclos. Isto levanta uma questão: por que precisamos de diferentes ciclos?

Vamos usar a figura acima para definir a *eficiência térmica*:

$$
\eta_{\mathrm{t}} = \frac{W_{\mathrm{liq,sai}}}{Q_{\mathrm{ent}}}
$$

**Geralmente**, é interessante maximizar a eficiência térmica. O ciclo mais eficiente possível que pode funcionar entre um reservatório quente a `\(T_{\mathrm{H}}\)` e um reservatório frio a `\(T_{\mathrm{L}}\)` é o ciclo de Carnot:

{{< figure src="cengel38-carnot-pv.jpg" caption="Fonte: [3]">}}

O ciclo acima é para um gás ideal, que sofre processos totalmente reversíveis (i.e. podem ser executados nas duas direções sem resíduo de calor para a vizinhança). A eficiência do ciclo Carnot acima é:

$$
\eta_{\mathrm{t,Carnot}} = 1 - \frac{T_{\mathrm{L}}}{T_{\mathrm{H}}}
$$

Qual o problema com o ciclo de Carnot?

No ciclo de Carnot, existem dois processos de expansão: um isotérmico, de 1 para 2, e um isentrópico, de 2 para 3. Vamos definir uma razão de volumes intermediária:

$$
r_v = \frac{v_2}{v_1}
$$

e uma *razão de compressão* (a maior variação de volume do sistema) como:

$$
r_{\mathrm{comp}} = \frac{v_3}{v_1}
$$

Usando a equação de estado de gases ideais:

$$
Pv = RT
$$


onde `\(R = c_p - c_v\)` é a constante do gás. Estamos assumindo sempre que os calores específicos são constantes.

e a variação de entropia de gases ideais:

$$
s_2 - s_1 = c_v \ln \frac{T_2}{T_1} + R \ln \frac{v_2}{v_1}
$$

é possível mostrar (tente!) que:

$$
r_{\mathrm{comp}} = r_{{v}} \left(\frac{T_{\mathrm{L}}}{T_{\mathrm{H}}}\right)^{\frac{1}{1-k}}
$$

Exemplo de valores típicos: `\(T_{\mathrm{L}} = 300\,\mathrm{K}^, T_{\mathrm{H}} = 1500\,\mathrm{K}, k = 1.4\)`. Com isso, você vai ver que `\(r_v\)` é multiplicado por 56. Ou seja, por menor que seja `\(r_v\)`, a variação total de volume (entre máximo e mínimo) vai ser multiplicado enormemente. Pense em qual deve ser o curso de um pistão que precise se expandir 60 vezes (para efeitos de comparação: os maiores motores possuem uma razão de compressão da ordem de 20 - e já são enormes).

Além disso, o ciclo de Carnot demanda um tempo infinito para ser completado, porque durante os processos isotérmicos precisamos ser muito lentos para deixar o fluido se equilibrar e não mudar a sua temperatura. Consequência: o ciclo de Carnot é um ciclo de potência nula.

Ou seja: o ciclo de Carnot não é nada prático. Nós utilizamos outros ciclos, pagando com redução da eficiência para conseguirmos trabalhar de maneira prática, gerando altas potências em espaços limitados.


## Tipos de máquinas térmicas

Nesta disciplina, vamos trabalhar com as seguintes máquinas térmicas:

1. **Motores de combustão interna**: máquinas térmicas *de pistão*, que funcionam com *gases de combustão*, segundo os ciclos *Otto* e *Diesel* (principalmente)
2. **Geradores de vapor**: máquinas térmicas *de fluxo*, que funcionam com *água condensada e vapor* segundo o *Ciclo Rankine*
3. **Turbinas a gás**: máquinas térmicas *de fluxo*, que funcionam com *gases a combustão* que funcionam segundo o *Ciclo Brayton*.

Já explicamos por que não podemos usar o ciclo de Carnot. Mas por quê essas diferenças de operação?

Os motores de combustão interna (MCI) são as máquinas térmicas mais compactas que temos (conseguimos fazer cortadores de grama portáteis com ele), mas sua potência está limitada na casa das centenas de cavalos-vapor. Acima disso, há perdas demais, o sistema fica pesado demais e é difícil fazer o pistão atingir as velocidades necessárias. 

Para aumentar a potência (na casa dos mega-watts), precisamos de máquinas *de fluxo*, rotativas e não alternativas como o pistão, que consigam movimentar uma grande massa de fluido. O equivalente com gases seriam as turbinas a gás, muito usadas na aviação. Em contrapartida, não é eficiente nem barato usar turbinas em carros. 

E por que temos máquinas térmicas com água? Porque a mudança de fase faz o sistema ficar mais eficiente; um fluido que muda de fase a pressão constante se mantém a temperatura constante, aproximando-se do ciclo de Carnot. Porém, uma máquina térmica desse tipo é a menos compacta das três acimas - estamos indo de carros para aviões e agora para grandes usinas termelétricas.

## Apenas os ciclos importam?

Para finalizar, o gráfico abaixo contém dados de carros coletadas pela Agência de Proteção Ambiental dos EUA:



```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.5     v purrr   0.3.4
## v tibble  3.1.6     v dplyr   1.0.8
## v tidyr   1.2.0     v stringr 1.4.0
## v readr   2.1.2     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=class)) + 
  geom_smooth(mapping = aes(linetype = drv)) + 
  labs(x = "Cilindrada [litros]", y = "Eficiência em rodovias [milhas por galão]")
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

<img src="/disciplinas/mte0001/aula1mte0001_files/figure-html/unnamed-chunk-1-1.png" width="672" />

O que está sendo mostrado: a eficiência de motores como função da cilindrada. A variável `drv` é o tipo de tração: `4` para 4 rodas, `r` para tração traseira e `f` para tração dianteira. Os carros com tração nas 4 rodas são os menos eficientes de todo; por quê? Examinando a classe, os carros `2seater`, esportivos de 2 lugares, são mais eficientes que outros de mesma cilindrada - por quê?

Como dá para ver, existem muitos detalhes que apenas o estudo dos ciclos não responde - e é isso que vamos investigar neste curso.

## Referências

[1]: Bejan, A. Advanced Engineering Thermodynamics. New York: John Wiley & Sons, 1988

[2]: de Souza, Z. Elementos de Máquinas Térmicas. Rio de Janeiro: Campus, 1980.

[3]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.

