---
date: "2022-05-24"
title: Aula 10 - Escoamento compressível em tubos capilares
type: book
weight: 90
---

[Na aula anterior](https://fpfortkamp.com/disciplinas/ref0001/aula9ref0001/), nós introduzimos o importante o assunto das curvas de equilíbrio entre compressores e tubos capilares. Dado um compressor fixo e um tubo capilar, a temperatura de condensação e de evaporação estão amarradas: quando uma é alterada (por mudanças nas condições de operação), o sistema migra para outro ponto de equilíbrio, de maneira que a outra é alterada.

O que estava errado naquele modelo?

## Escoamento compressível

A principal limitação era a hipótese de que o escoamento era incompressível, e pegamos então propriedades médias e uma velocidade média ao longo de todo o tubo. Não é isto que acontece em um tubo capilar: a alta perda de carga devido ao pequeno diâmetro abaixa a pressão do fluido, que então consegue evaporar com mais facilidade; o vapor tem menos densidade e portanto consegue escoar com mais velocidade. *O fluido acelera ao longo de um tubo capilar*; portanto, o nosso modelo de tubo capilar iso-entálpico é falso, uma vez que a entalpia é convertida em energia cinética. Entretanto, é prática ignorar isso como um fator de segurança no projeto de evaporadores; ao assumir que a entalpia não diminui, estamos subestimando o efeito refrigerante no evaporador, e podemos fazer um projeto mais confiável.

## Modelo de tubo capilar adiabático

Como as propriedades do fluido (decorrentes da mudança de fase) mudam o tempo todo, precisamos dividir o tubo de comprimento `\(L\)` e diâmetro `\(D\)` em pequenos elementos de comprimento `\(\Delta L\)`:

{{< figure src="stoecker-capilar.png" caption="Fonte: [1]">}}

Em regime permanente, a vazão `\(\dot{m}\)` não muda, e consideramos que a área de seção transversal `\(A\)` também não. Portanto a razão `\(\frac{\dot{m}}{A}\)` é uma constante. 

No nosso modelo diferencial, as propriedades do estado 1 são sempre conhecidas. Por exemplo, no início do tubo capilar, o estado 1 equivale à saída do condensador, que pode ser de líquido saturado ou sub-resfriado. De qualquer maneira, o volume específico `\(v_1\)` sempre pode ser determinado. A velocidade na seção 1 é então:

$$
V_ 1 = v_ 1 \frac{\dot{m}}{A}
$$

A conservação da massa requer então:

$$
\frac{\dot{m}}{A} = \frac{V_1}{v_1} = \frac{V_2}{v_2}
$$

E a conservação da energia (considerando o tubo adiabático, sem realização de trabalho e sem variações de energia potencial) é:

$$
h_1 + \frac{V_1^2}{2} = h_2 + \frac{V_2^2}{2}
$$

onde aqui é bem fácil se confundir com as unidades: se a velocidade está em m/s, a entalpia deve estar em J/kg (e não em kJ/kg como é usual).

Que forças agem sobre esse escoamento? O gradiente de pressão `\(P_1-P_2\)` age no sentido de 1 para 2, enquanto que a força de atrito tenta frear esse movimento. A resultante desse efeito altera a quantidade de movimento de 1 para 2 (já que, ao contrário do modelo da semana passada, a velocidade está mudando agora):

$$
(P _1-P _2) - f _m \frac{\Delta L}{D}\frac{V _m^2}{2v _m} = \frac{\dot{m}}{A}\left(V _2-V _1\right)
$$
onde o índice `\(m\)` se refere a um valor médio no elemento, que assumimos como pequeno para que isso faça sentido.

O fator de atrito local de um escoamento bifásico, com uma incerteza razoável, pode ser estimado como [1]:

$$
f = \frac{0.33}{\mathrm{Re}^{0.25}}
$$

### Exercício

DESAFIO: criar um algoritmo que permita calcular o comprimento necessário para um tubo capilar de determinado diâmetro. Considere uma condição de entrada conhecida (e.g. líquido saturado na pressão de condensação), uma pressão de saída conhecida, e assuma que o fluido está bifásico o tempo todo. Considere passos de temperatura até atingir a temperatura de evaporação, calcule o comprimento de cada passo e some os valores de todos os passos.

Dica: assuma que as propriedades de saturação (pressão, densidade, viscosidade, entalpia do líquido e do vapor saturado) são conhecidas a cada temperatura.

## Blocagem

Se você implementar o algoritmo acima, vai perceber que os comprimentos necessários nos últimos estágios vão se tornando cada vez menores e eventualmente podem ficar negativos. O que está acontecendo?

O escoamento em um tubo capilar é adiabático porém irreversível - portanto, a entropia só pode aumentar. Porém, como a temperatura está abaixando, esse aumento em relação ao estado inicial vai diminuindo; quando ele tentar ser negativo, o escoamento não é mais fisicamente possível. Isso acontece quando o fluido atinge a velocidade do som. 

Em um tubo de seção constante, a velocidade do som só pode ocorrer na saída do tubo; não é possível acelerar um fluido hipersônico sem aumentar a área [2]. Portanto, depois que a pressão de saída é tal que a velocidade do som é atingida, diminuir ainda mais a pressão não aumenta a vazão:

{{< figure src="blocado-stoecker.png" caption="Fonte: [1]">}}

### Dimensionamento de tubos capilares blocados

O modelo descrito acima é uma primeira estimativa de comprimento necessário, e pode servir de análise de sensibilidade quanto ao diâmetro dos tubos e às pressões de evaporação e condensação. Porém, se a diferença de pressão é grande o suficiente para assegurar a blocagem, então o tubo capilar pode ser dimensionado de maneira mais prática:

{{< youtube elp6Z0Yf2sw >}}

Examine o [catálogo](https://www.embraco.com/wp-content/uploads/2019/09/tabela-de-aplicacao-de-compressores-50hz-e-60hz-r134a-e-misturas-blend.pdf) descrito no vídeo acima; observe cada par (comprimento,diâmetro) é prescrito para uma *faixa* de temperaturas de evaporação, porque nessas condições é garantido que o escoamento será blocado. 

Veja também outro vídeo sobre seleção de tubos capilares:

{{< youtube L-l7vMxO9fo >}}

Esses softwares e catálogos se baseiam em dados experimentais; entretanto, podem ser necessários alguns ajustes, cortando o tubo, até atingir as pressões necessárias.

## Referências:

[1]: Stoecker, W. F., & Jones, J. W. Refrigeração e Ar Condicionado. São Paulo: McGraw-Hill do Brasil, 1985.

[2]: Çengel, Y. A., & Boles, M. A. Termodinâmica (7 ed.). Porto Alegre: AMGH, 2013.
