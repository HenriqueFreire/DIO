/*
Escreva um código onde o usuário entra com sua altura e peso, 
seja feito o calculo do seu IMC(IMC = peso/(altura * altura)) 
e seja exibida a mensagem de acordo com o resultado:

* Se for menor ou igual a 18,5 "Abaixo do peso";
* se for entre 18,6 e 24,9 "Peso ideal";
* Se for entre 25,0 e 29,9 "Levemente acima do peso";
* Se for entre 30,0 e 34,9 "Obesidade Grau I";
* Se for entre 35,0 e 39,9 "Obesidade Grau II (Severa)";
* Se for maior ou igual a 40,0 "Obesidade III (Mórbida)";
*/

import java.util.Locale;
import java.util.Scanner;

public class main {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in).useLocale(Locale.US);

    System.out.print("Digite sua altura em metros (ex: 1.75): ");
    double altura = scanner.nextDouble();

    System.out.print("Digite seu peso em quilogramas (ex: 70.5): ");
    double peso = scanner.nextDouble();

    double imc = peso / (altura * altura);

    System.out.printf("Seu IMC é: %.2f\n", imc);

    if (imc <= 18.5) {
      System.out.println("Abaixo do peso");
    } else if (imc >= 18.6 && imc <= 24.9) {
      System.out.println("Peso ideal");
    } else if (imc >= 25.0 && imc <= 29.9) {
      System.out.println("Levemente acima do peso");
    } else if (imc >= 30.0 && imc <= 34.9) {
      System.out.println("Obesidade Grau I");
    } else if (imc >= 35.0 && imc <= 39.9) {
      System.out.println("Obesidade Grau II (Severa)");
    } else {
      System.out.println("Obesidade III (Mórbida)");
    }

    scanner.close();
  }
}