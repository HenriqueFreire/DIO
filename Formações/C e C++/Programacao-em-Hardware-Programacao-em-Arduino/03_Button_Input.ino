// 03_Button_Input.ino
// Demonstra como ler o estado de um botão e controlar um LED.

// Define os pinos digitais para o botão e o LED.
const int buttonPin = 2; // Pino digital ao qual o botão está conectado
const int ledPin = 13;   // Pino digital ao qual o LED está conectado (LED embutido)

// Variável para armazenar o estado atual do botão
int buttonState = 0;

// A função setup() é executada uma vez quando o sketch inicia.
void setup() {
  // Configura o pino do LED como SAÍDA.
  pinMode(ledPin, OUTPUT);
  // Configura o pino do botão como ENTRADA com um resistor pull-up interno.
  // Isso garante que o pino esteja em HIGH quando o botão não está pressionado.
  pinMode(buttonPin, INPUT_PULLUP);
  
  Serial.begin(9600); // Inicia a comunicação serial para depuração
  Serial.println("Sistema de Botao e LED iniciado.");
}

// A função loop() é executada repetidamente, para sempre.
void loop() {
  // Lê o estado do botão.
  // INPUT_PULLUP faz com que o estado seja LOW quando o botão é pressionado.
  buttonState = digitalRead(buttonPin);

  // Verifica se o botão está pressionado (estado LOW)
  if (buttonState == LOW) {
    // Se o botão está pressionado, liga o LED
    digitalWrite(ledPin, HIGH);
    Serial.println("Botao Pressionado - LED LIGADO");
  } else {
    // Se o botão não está pressionado, desliga o LED
    digitalWrite(ledPin, LOW);
    Serial.println("Botao Solto - LED DESLIGADO");
  }

  delay(50); // Pequeno atraso para evitar leituras instáveis do botão (debounce)
}
