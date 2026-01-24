// 02_Serial_Monitor.ino
// Demonstra como enviar dados para o Monitor Serial do Arduino IDE.

// A função setup() é executada uma vez quando o sketch inicia.
void setup() {
  // Inicia a comunicação serial a uma taxa de 9600 bits por segundo.
  // Esta taxa deve ser a mesma configurada no Monitor Serial.
  Serial.begin(9600);
}

// A função loop() é executada repetidamente, para sempre.
void loop() {
  // Envia a string "Olá, Arduino!" para o Monitor Serial, seguida de uma nova linha.
  Serial.println("Olá, Arduino!");
  
  // Envia o valor de um contador para o Monitor Serial.
  static int contador = 0; // 'static' faz com que a variável mantenha seu valor entre as chamadas de loop.
  Serial.print("Contador: ");
  Serial.println(contador);
  contador++;

  delay(1000); // Espera por 1 segundo antes de enviar a próxima mensagem
}
