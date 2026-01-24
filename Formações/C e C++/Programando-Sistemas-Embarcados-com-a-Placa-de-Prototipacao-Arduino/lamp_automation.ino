// lamp_automation.ino
// Projeto: Automação de 6 Lâmpadas com Arduino e Controle Remoto IR

// Inclui a biblioteca IRremote. Certifique-se de tê-la instalada no seu Arduino IDE.
// Vá em Sketch -> Incluir Biblioteca -> Gerenciar Bibliotecas... e procure por "IRremote".
#include <IRremote.h>

// --- Configurações de Pinos ---
const int IR_RECEIVE_PIN = 11; // Pino digital onde o receptor IR está conectado
const int LAMP_PINS[] = {2, 3, 4, 5, 6, 7}; // Pinos digitais conectados aos relés das lâmpadas
const int NUM_LAMPS = sizeof(LAMP_PINS) / sizeof(LAMP_PINS[0]); // Calcula o número de lâmpadas

// --- Variáveis de Estado ---
// Array para armazenar o estado atual de cada lâmpada (HIGH = LIGADO, LOW = DESLIGADO)
int lampState[NUM_LAMPS];

// --- Códigos IR do Controle Remoto ---
// ESTES SÃO APENAS VALORES DE EXEMPLO!
// VOCÊ DEVE SUBSTITUÍ-LOS PELOS CÓDIGOS DO SEU PRÓPRIO CONTROLE REMOTO.
// Use o sketch "IR_receive_test.ino" (ou similar) da biblioteca IRremote para descobrir os códigos.
// Exemplo:
// Botão '1' do controle remoto para Lâmpada 1
const long IR_CODE_LAMP1_TOGGLE = 0xFF30CF; // Exemplo: Botão '1'
const long IR_CODE_LAMP2_TOGGLE = 0xFF18E7; // Exemplo: Botão '2'
const long IR_CODE_LAMP3_TOGGLE = 0xFF7A85; // Exemplo: Botão '3'
const long IR_CODE_LAMP4_TOGGLE = 0xFF10EF; // Exemplo: Botão '4'
const long IR_CODE_LAMP5_TOGGLE = 0xFF38C7; // Exemplo: Botão '5'
const long IR_CODE_LAMP6_TOGGLE = 0xFF5AA5; // Exemplo: Botão '6'
const long IR_CODE_ALL_ON       = 0xFFE01F; // Exemplo: Botão 'Power'
const long IR_CODE_ALL_OFF      = 0xFF6897; // Exemplo: Botão 'Mute'

// --- Configuração Inicial (executada uma vez) ---
void setup() {
  Serial.begin(9600); // Inicia a comunicação serial para depuração
  Serial.println("Iniciando automacao de lampadas...");

  // Inicializa o receptor IR
  IrReceiver.begin(IR_RECEIVE_PIN, ENABLE_LED_FEEDBACK); // ENABLE_LED_FEEDBACK é opcional

  // Configura os pinos das lâmpadas como SAÍDA e as desliga inicialmente
  for (int i = 0; i < NUM_LAMPS; i++) {
    pinMode(LAMP_PINS[i], OUTPUT);
    lampState[i] = LOW; // Assume que LOW desliga o relé (e a lâmpada)
    digitalWrite(LAMP_PINS[i], lampState[i]);
    Serial.print("Lâmpada ");
    Serial.print(i + 1);
    Serial.println(" configurada e DESLIGADA.");
  }
  Serial.println("Pronto para receber comandos IR.");
}

// --- Loop Principal (executado repetidamente) ---
void loop() {
  // Verifica se um sinal IR foi recebido
  if (IrReceiver.decode()) {
    long receivedCode = IrReceiver.decodedIRData.decodedRawData; // Obtém o código recebido
    Serial.print("Comando IR recebido: 0x");
    Serial.println(receivedCode, HEX); // Imprime o código em formato hexadecimal

    // Mapeia o código recebido para as ações das lâmpadas
    switch (receivedCode) {
      case IR_CODE_LAMP1_TOGGLE:
        toggleLamp(0); // Lâmpada 1 (índice 0)
        break;
      case IR_CODE_LAMP2_TOGGLE:
        toggleLamp(1); // Lâmpada 2 (índice 1)
        break;
      case IR_CODE_LAMP3_TOGGLE:
        toggleLamp(2); // Lâmpada 3 (índice 2)
        break;
      case IR_CODE_LAMP4_TOGGLE:
        toggleLamp(3); // Lâmpada 4 (índice 3)
        break;
      case IR_CODE_LAMP5_TOGGLE:
        toggleLamp(4); // Lâmpada 5 (índice 4)
        break;
      case IR_CODE_LAMP6_TOGGLE:
        toggleLamp(5); // Lâmpada 6 (índice 5)
        break;
      case IR_CODE_ALL_ON:
        setAllLamps(HIGH);
        break;
      case IR_CODE_ALL_OFF:
        setAllLamps(LOW);
        break;
      default:
        Serial.println("Comando IR desconhecido.");
        break;
    }

    IrReceiver.resume(); // Habilita o receptor IR para receber o próximo comando
  }
}

// --- Funções Auxiliares ---

// Alterna o estado de uma lâmpada específica
void toggleLamp(int lampIndex) {
  if (lampIndex >= 0 && lampIndex < NUM_LAMPS) {
    lampState[lampIndex] = !lampState[lampIndex]; // Inverte o estado (HIGH para LOW, LOW para HIGH)
    digitalWrite(LAMP_PINS[lampIndex], lampState[lampIndex]);
    Serial.print("Lâmpada ");
    Serial.print(lampIndex + 1);
    Serial.print(" agora esta ");
    Serial.println(lampState[lampIndex] == HIGH ? "LIGADA" : "DESLIGADA");
  } else {
    Serial.println("Erro: Indice de lampada invalido.");
  }
}

// Define o estado de todas as lâmpadas
void setAllLamps(int state) {
  for (int i = 0; i < NUM_LAMPS; i++) {
    lampState[i] = state;
    digitalWrite(LAMP_PINS[i], lampState[i]);
  }
  Serial.print("Todas as lampadas agora estao ");
  Serial.println(state == HIGH ? "LIGADAS" : "DESLIGADAS");
}
