# Programação em Hardware: Exemplos de Código Arduino

Esta pasta contém exemplos básicos de código (sketches) para a plataforma Arduino, demonstrando funcionalidades fundamentais para quem está começando a programar microcontroladores.

## Conteúdo:

*   `01_Blink_LED.ino`: O clássico "Olá Mundo" do Arduino, que faz um LED piscar.
*   `02_Serial_Monitor.ino`: Demonstra como enviar mensagens e dados para o Monitor Serial do Arduino IDE, útil para depuração.
*   `03_Button_Input.ino`: Exemplo de como ler o estado de um botão e usá-lo para controlar um LED.
*   `README.md`: Este arquivo.

## Como Usar os Exemplos:

Para usar estes exemplos, você precisará do Arduino IDE (ou uma IDE compatível como o VS Code com a extensão Arduino).

1.  **Abra o Arduino IDE:** Inicie o ambiente de desenvolvimento.
2.  **Abra o Sketch:** Vá em `Arquivo > Abrir...` e navegue até a pasta deste projeto. Selecione um dos arquivos `.ino` (ex: `01_Blink_LED.ino`).
3.  **Selecione a Placa:** Vá em `Ferramentas > Placa` e selecione o modelo da sua placa Arduino (ex: `Arduino Uno`).
4.  **Selecione a Porta:** Vá em `Ferramentas > Porta` e selecione a porta serial à qual seu Arduino está conectado (ex: `COM3` no Windows, `/dev/ttyUSB0` ou `/dev/ttyACM0` no Linux/macOS).
5.  **Carregue o Código:** Clique no botão "Carregar" (seta para a direita) na barra de ferramentas do IDE. O código será compilado e enviado para sua placa Arduino.

### Hardware Necessário (para `03_Button_Input.ino`):

*   Placa Arduino (qualquer modelo, ex: Uno, Nano)
*   Um botão de pressão
*   Fios jumper
*   (Opcional) Um LED e um resistor de 220 Ohm (o LED embutido no pino 13 pode ser usado)

**Montagem para `03_Button_Input.ino`:**

*   Conecte um terminal do botão ao pino digital 2 do Arduino.
*   Conecte o outro terminal do botão ao GND (terra) do Arduino.
*   O LED embutido no pino 13 será usado para a saída. Se quiser usar um LED externo, conecte o ânodo (perna mais longa) do LED ao pino 13 (via um resistor de 220 Ohm) e o cátodo (perna mais curta) ao GND.

Ao carregar o `03_Button_Input.ino`, o LED deverá acender quando você pressionar o botão e apagar quando soltar. Você também pode abrir o Monitor Serial (ícone de lupa no canto superior direito do IDE) para ver as mensagens de depuração.
