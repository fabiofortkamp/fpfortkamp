---
date: "2022-03-29"
title: Aula 1 - Desafios de Motores de Combustão Interna
type: book
weight: 20
---

## Desafios atuais em motores de combustão interna

Se você está cursando esta disciplina, é porque já passou por um curso mais fundamental de máquinas térmicas e conhece o funcionamento básico das principais aplicações. A pergunta é: o que vem agora?

Neste curso, por uma questão de escopo, vamos nos ater aos motores de combustão interna (MCI) e ignorar outras máquinas térmicas (como turbinas a gás e a vapor). Comparado com estes outros exemplos, MCI são bastante compactos e geram muita potência em relação ao seu peso, e dominam o setor de transporte [1]. Neste curso, vamos focar em MCI para aplicações automotivas.

Tome um momento para refletir sobre o seu conhecimento de motores de combustão interna e identificar quais são os principais desafios no desenvolvimento de motores.

## Emissões como limitantes

Motores de combustão interna transformam a energia química armazenada em combustíveis em movimento de uma árvore girante. A reação de combustão entre combustíveis e oxigênio é exotérmica e forma diversos produtos de combustão, dependendo das condições de operação na queima, principalmente a proporção entre ar e combustível e a temperatura na câmara de combustão (interior do cilindro). Alguns dos gases que podem ser formados são considerados *poluentes* e têm efeitos danosos; por exemplo, óxidos de nitrogênio contribuem com a chuva ácida, e o monóxido de carbono é tóxico quando inalado. 

Motores de combustão interna, pela sua ampla utilização, são responsáveis por mais da metade das emissões atmosféricas, considerando todas as fontes potenciais [1], e o desenvolvimento de novos motores é limitado pelo controle de poluentes. Quanto mais combustível o sistema de injeção adiciona ao cilindro dos motores, mais energia pode ser obtida, e essa taxa de injeção é limitada na prática por quanto de poluentes admite-se formar no motor [1]. Motores *sobrealimentados* forçam mais ar para dentro do motor com um compressor a montante do motor, permitindo mais injeção de combustível sem necessariamente aumentar a taxa de formação de poluentes, e são uma importante tendência. Virtualmente não há motores diesel que não sejam turboalimentados (i.e. sobrealimentados por um compressor que é acionado por uma turbina inserida no sistema de exaustão), e a proporção de motores a gasolina que também são turboalimentados tem aumentado signitivamente. 

Carros híbridos são outra aposta da indústria para redução do níveis de poluentes. Estes veículos possem dois motores: um elétrico, com alto torque para os momentos de aceleração e mudanças de carga no regime urbano, e um de combustão para o ciclo rodovoviária - porém, este último motor é modificado para reduzir o consumo de combustíveis, seguindo ciclos de *sobre-expansão*, que são mais eficientes (consomem menos combustível, e portanto também geram menos poluentes, mas têm sua potência limitada pela baixa utilização de combustível). Uma consequência da utilização de carros híbridos é "zerar" a emissão de poluentes nas cidades, pois o MCI praticamente não trabalha nesta zona, e a energia para o motor elétrico pode ser gerada em usinas termelétricas longe dos centros urbanos, onde ainda por cima e processo de tratamento de poluentes pode ser melhor realizado, sem as restrições de espaço de um automóvel.

Neste curso, vamos nos concentrar em três eixos principais:

1. Ciclos mais eficientes;
2. Controle de poluentes;
3. Sobralimentação de motores.

## Uma Revisão Termodinâmica

Vamos começar o curso com um estudo dos ciclos termodinâmicos usados em MCI, para identificar possibilidades de melhoria na eficiência, e em algumas semanas vamos começar a voltar nossa atenção para o processo de combustão.

### O que são Máquinas Térmicas

Uma máquina térmica é um conversor de *calor* em *trabalho*.

Por que é necessário um nome pomposo para um conceito aparentemente simples? Porque o conceito não é tão simples assim. Calor e trabalho são duas formas de energia que, pela Primeira Lei da Termodinâmica, são equivalentes no sentido de aumentar a energia interna do sistema. Porém, pela *Segunda Lei da Termodinâmica*, calor e trabalho **não são** equivalentes. 

A obtenção de trabalho mecânico a partir de outras fontes, como se fosse uma *commodity* [2], é uma das tarefas básicas da Engenharia. É com trabalho que movimentamos cargas e pessoas, aplicando *forças* sobre uma *distância*.  

Em comparação com o trabalho, a transferência de calor:

1. Contribui com a geração de entropia, ao contrário do trabalho, e portanto contribui para a desordem do sistema;
2. É dependente do gradiente de temperaturas entre fonte e sistema;
3. Nem sempre é equivalente ao levantamento de um peso (imagine pegar um ventilador na sua casa, prender um peso nas pás e ligar na tomada - o peso vai subir. Agora, imagine acender uma vela perto dele - as pás vão se movimentar sem estarem ligadas na tomada e levantar o peso?) 


{{< figure src="cengel63-heat-lift.jpg" caption="Fonte: [3]">}}

Assim, *é necessário* um dispositivo especial que transforma calor em trabalho, que vai funcionar limitado pelas Leis da Termodinâmica (e de outras disciplinas).

### A importância dos ciclos termodinâmicos

Em determinadas condições, é possível sim transferir calor em trabalho. Por exemplo, um pistão com um gás, quando aquecido, vai elevar o pistão. O verdadeiro desafio é fazer isto em *ciclos* que funcionem de maneira indeterminada sem interação com o operador e sem resíduos de energia - isto é, que consigam de fato operar em regime permanente.

Neste caso, o Enunciado de Kelvin-Planck da Segunda Lei da Termodinâmica diz que "é impossível para um dispositivo que funciona em ciclos realizar trabalho sobre a vizinhança e trocar calor com uma única fonte". 

O contrário sempre é possível. Pense em uma chaleira elétrica: a rede elétrica funciona em ciclos, e este trabalho elétrico vindo da vizinhaça é inteiramente convertido em transferência de calor para apenas a água no seu interior (uma chaleira elétrica pode funcionar mesmo se o exterior for bem isolado do ambiente). Séculos de experimentação provaram que esse tipo de sistema não pode ser invertido; para calor ser convertido em trabalho, sempre vai haver um *calor residual* que é transferido para um segundo reservatório.

{{< figure src="cengel-69-heat-engine.jpg" caption="Fonte: [3]">}}


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

Exemplo de valores típicos: `\(T_{\mathrm{L}} = 300\,\mathrm{K}^, T_{\mathrm{H}} = 1500\,\mathrm{K}, k = 1.4\)`. Com isso, você vai ver que `\(r_v\)` é multiplicado por 56. Ou seja, por menor que seja `\(r_v\)` (e não queremos diminui-lo indefinidamente, pois o trabalho do Ciclo de Carnot cresce com esse parâmetro!), a variação total de volume (entre máximo e mínimo) vai ser multiplicado enormemente. Pense em qual deve ser o curso de um pistão que precise se expandir 60 vezes (para efeitos de comparação: os maiores motores possuem uma razão de compressão da ordem de 20 - e já são enormes).

Além disso, o ciclo de Carnot demanda um tempo infinito para ser completado, porque durante os processos isotérmicos precisamos ser muito lentos para deixar o fluido se equilibrar e não mudar a sua temperatura. Consequência: o ciclo de Carnot é um ciclo de potência nula.

Ou seja: o ciclo de Carnot não é nada prático. Nós utilizamos outros ciclos, pagando com redução da eficiência para conseguirmos trabalhar de maneira prática, gerando altas potências em espaços limitados.

## Motores de combustão interna

O vídeo abaixo contém uma explicação geral bastante boa sobre os componentes e o funcionamento de motores de combustão interna:

{{< youtube Ul1XuiJE0Dw >}}

O motor acima apresentado é um *motor de ignição por faísca* (MIF), também chamado de *motor Otto*; o outro grande tipo é o *motor de ignição espontânea*, ou MIE. Você consegue enumerar diferenças entre elas, baseado no seu conhecimento anterior a este curso?

Algumas outras questões para repensar:

1. Quantos graus o virabrequim gira para completar os 4 tempos de um motor (de ignição por faísca, por exemplo)? Como a pressão dentro do cilindro varia? Onde ocorrem a ignição e a abertura e fechamento das válvulas?
2. O que limita mecanicamente a operação dos motores? O que limita as altas rotações dos motores? A alta pressão?
3. Por que temos motores com vários cilindros pequenos, e não apenas apenas um cilindro grande (o que reduziria o número de componentes, por exemplo).


## Referências

[1]: Heywood, J. B. Internal Combustion Engine Fundamentals. New York: McGraw-Hill, 1988.

[2]: Bejan, A. Advanced Engineering Thermodynamics. New York: John Wiley & Sons, 1988

[3]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.
