/*
  Escreva um código onde o usuário informa um número inicial, 
posteriormente irá informar outros N números, 
a execução do código irá continuar até que o número informado dividido 
pelo primeiro número tenha resto diferente de 0 na divisão, 
números menores que o primeiro número devem ser ignorados
*/

import java.util.Locale;
import java.util.Scanner;

public class main {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in).useLocale(Locale.US);

    System.out.print("Digite o número inicial: ");
    int numeroInicial = scanner.nextInt();

    System.out.println("Agora, digite outros números. A execução irá parar quando um número dividido pelo inicial tiver resto diferente de 0.");
    System.out.println("Números menores que o inicial serão ignorados.");

    while (true) {
      System.out.print("Digite um número: ");
      int proximoNumero = scanner.nextInt();

      if (proximoNumero < numeroInicial) {
        System.out.println("Número ignorado (menor que o número inicial).");
        continue;
      }

      if (proximoNumero % numeroInicial != 0) {
        System.out.println("O número " + proximoNumero + " dividido por " + numeroInicial + " tem resto diferente de 0. Encerrando.");
        break;
      } else {
        System.out.println("O número " + proximoNumero + " dividido por " + numeroInicial + " tem resto 0. Continue.");
      }
    }

    scanner.close();
  }
}