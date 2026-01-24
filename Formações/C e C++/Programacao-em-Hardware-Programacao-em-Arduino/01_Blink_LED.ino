// 01_Blink_LED.ino
// O exemplo mais básico: piscar um LED.

// Define o pino digital ao qual o LED está conectado.
// A maioria das placas Arduino tem um LED embutido no pino 13.
const int ledPin = 13;

// A função setup() é executada uma vez quando o sketch inicia.
void setup() {
  // Configura o pino digital como uma SAÍDA.
  pinMode(ledPin, OUTPUT);
}

// A função loop() é executada repetidamente, para sempre.
void loop() {
  digitalWrite(ledPin, HIGH); // Liga o LED (HIGH é nível de tensão alto)
  delay(1000);                // Espera por 1 segundo (1000 milissegundos)
  digitalWrite(ledPin, LOW);  // Desliga o LED (LOW é nível de tensão baixo)
  delay(1000);                // Espera por mais 1 segundo
}
