/*
  Escreva um código que o usuário entre com um primeiro número, 
um segundo número maior que o primeiro e escolhe entre a opção par e impar, 
com isso o código deve informar todos os números pares ou ímpares 
(de acordo com a seleção inicial) no intervalo de números informados, 
incluindo os números informados e em ordem decrescente;
*/

import java.util.Scanner;

public class main {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    int primeiroNumero;
    int segundoNumero;

    System.out.print("Digite o primeiro número: ");
    primeiroNumero = scanner.nextInt();

    do {
      System.out.print("Digite o segundo número (maior que o primeiro): ");
      segundoNumero = scanner.nextInt();
      if (segundoNumero <= primeiroNumero) {
        System.out.println("O segundo número deve ser maior que o primeiro. Tente novamente.");
      }
    } while (segundoNumero <= primeiroNumero);

    System.out.print("Deseja ver números 'par' ou 'impar'? ");
    String escolha = scanner.next();

    System.out.println("Números " + escolha + " no intervalo de " + segundoNumero + " a " + primeiroNumero + ":");

    for (int i = segundoNumero; i >= primeiroNumero; i--) {
      if (escolha.equalsIgnoreCase("par")) {
        if (i % 2 == 0) {
          System.out.println(i);
        }
      } else if (escolha.equalsIgnoreCase("impar")) {
        if (i % 2 != 0) {
          System.out.println(i);
        }
      } else {
        System.out.println("Escolha inválida. Por favor, digite 'par' ou 'impar'.");
        break;
      }
    }

    scanner.close();
  }
}
