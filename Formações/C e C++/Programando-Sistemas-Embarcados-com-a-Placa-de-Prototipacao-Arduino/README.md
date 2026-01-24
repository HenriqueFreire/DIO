# Automação de 6 Lâmpadas com Arduino e Controle Remoto IR

Este projeto demonstra como controlar seis lâmpadas (ou outros dispositivos AC) usando um Arduino e um controle remoto infravermelho (IR). É um excelente ponto de partida para automação residencial básica.

## Descrição do Projeto

O sistema permite ligar/desligar individualmente até seis lâmpadas, além de comandos para ligar todas ou desligar todas as lâmpadas, utilizando um controle remoto IR padrão. O Arduino decodifica os sinais do controle remoto e ativa/desativa módulos de relé, que por sua vez controlam a energia das lâmpadas.

## Componentes Necessários

*   **Placa Arduino:** Arduino Uno, Nano, Mega ou similar (com pinos digitais suficientes).
*   **Módulos de Relé:** 6 módulos de relé de 1 canal (ou módulos de 2, 4, 8 canais que somem 6 saídas). Certifique-se de que são compatíveis com 5V do Arduino.
*   **Receptor IR:** Módulo receptor IR (ex: VS1838B, TSOP1838).
*   **Controle Remoto IR:** Qualquer controle remoto IR padrão (ex: de TV, DVD).
*   **Lâmpadas:** 6 lâmpadas (com suas respectivas fiações e soquetes).
*   **Fonte de Alimentação:** Para o Arduino e, se necessário, para os relés (muitos relés podem ser alimentados pelo 5V do Arduino, mas para múltiplos relés, uma fonte externa pode ser mais estável).
*   **Fios Jumper:** Para as conexões.
*   **Protoboard (opcional):** Para montar o receptor IR e outras conexões.

## Diagrama de Conexão (Fritzing/Texto)

**ATENÇÃO: Trabalhar com eletricidade AC (corrente alternada) pode ser PERIGOSO e causar CHOQUE ELÉTRICO ou INCÊNDIO. Se você não tem experiência, procure a ajuda de um eletricista qualificado.**

### Conexões do Receptor IR:

*   **VCC** (ou +): Conecte ao pino **5V** do Arduino.
*   **GND** (ou -): Conecte ao pino **GND** do Arduino.
*   **OUT** (ou S): Conecte ao pino digital **D11** do Arduino.

### Conexões dos Módulos de Relé (para cada um dos 6 relés):

*   **VCC** (ou +): Conecte ao pino **5V** do Arduino (ou fonte de alimentação externa para relés).
*   **GND** (ou -): Conecte ao pino **GND** do Arduino (ou fonte de alimentação externa para relés).
*   **IN** (ou S): Conecte aos pinos digitais **D2, D3, D4, D5, D6, D7** do Arduino (um pino para cada relé).

### Conexões das Lâmpadas (para cada lâmpada):

*   Cada lâmpada deve ser conectada ao terminal **COM (Comum)** e **NO (Normalmente Aberto)** do seu respectivo módulo de relé.
*   A energia AC (fase e neutro) deve ser interrompida pelo relé. Por exemplo, conecte a fase da rede elétrica ao COM do relé e o NO do relé à fase da lâmpada. O neutro da lâmpada vai direto para o neutro da rede.

## Instalação da Biblioteca IRremote

1.  Abra o Arduino IDE.
2.  Vá em `Sketch > Incluir Biblioteca > Gerenciar Bibliotecas...`.
3.  Na caixa de pesquisa, digite `IRremote`.
4.  Procure pela biblioteca `IRremote` (geralmente a versão mais recente).
5.  Clique em `Instalar`.

## Obtendo os Códigos IR do seu Controle Remoto

**Este é um passo CRÍTICO!** Os códigos IR no sketch (`IR_CODE_LAMP1_TOGGLE`, etc.) são apenas exemplos. Você precisa descobrir os códigos que *seu próprio controle remoto* envia.

1.  Abra o Arduino IDE.
2.  Vá em `Arquivo > Exemplos > IRremote > IRrecvDumpV3` (ou um exemplo similar de "dump" ou "receive").
3.  Carregue este sketch para o seu Arduino (com o receptor IR conectado ao pino D11).
4.  Abra o Monitor Serial (ícone de lupa no canto superior direito do IDE).
5.  Aponte seu controle remoto para o receptor IR e pressione os botões que você deseja usar para cada lâmpada (e para ligar/desligar tudo).
6.  Anote os códigos hexadecimais que aparecem no Monitor Serial (ex: `0xFF30CF`).
7.  **Substitua** os valores de exemplo no `lamp_automation.ino` pelos códigos que você anotou.

## Código (`lamp_automation.ino`)

O sketch `lamp_automation.ino` contém a lógica principal:

*   **`setup()`:** Inicializa a comunicação serial, o receptor IR e configura os pinos dos relés como saída, desligando todas as lâmpadas.
*   **`loop()`:** Constantemente verifica se um comando IR foi recebido. Se sim, decodifica o comando e, usando uma estrutura `switch`, chama a função apropriada (`toggleLamp` ou `setAllLamps`).
*   **`toggleLamp(int lampIndex)`:** Inverte o estado (liga/desliga) de uma lâmpada específica.
*   **`setAllLamps(int state)`:** Define o estado (ligado/desligado) para todas as lâmpadas.

## Como Carregar o Código

1.  Abra o `lamp_automation.ino` no Arduino IDE.
2.  **Certifique-se de ter substituído os códigos IR de exemplo pelos seus próprios!**
3.  Selecione sua placa Arduino em `Ferramentas > Placa`.
4.  Selecione a porta serial correta em `Ferramentas > Porta`.
5.  Clique no botão "Carregar" (seta para a direita).

## Segurança Importante

*   **Eletricidade AC é Perigosa:** Sempre desligue a energia da rede elétrica antes de fazer qualquer conexão com as lâmpadas e os relés.
*   **Isolamento:** Certifique-se de que todas as conexões AC estejam bem isoladas e seguras.
*   **Capacidade do Relé:** Verifique se seus módulos de relé são adequados para a voltagem e corrente das suas lâmpadas.
*   **Não Sobrecarregue o Arduino:** Se estiver usando muitos relés, considere alimentar os relés com uma fonte de alimentação externa para não sobrecarregar o pino 5V do Arduino.

Este projeto é para fins educacionais. Use com cautela e responsabilidade.
