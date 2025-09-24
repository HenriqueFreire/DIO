import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

public class Calculadora {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Bem-vindo à Calculadora!");
        System.out.println("Por favor, insira os números separados por vírgulas (ex: 10,5,20):");
        String numerosInput = scanner.nextLine();

        System.out.println("Escolha a operação:");
        System.out.println("1. Soma");
        System.out.println("2. Subtração");
        int operacao = scanner.nextInt();

        List<Double> numeros = new ArrayList<>();
        try {
            String[] numerosArray = numerosInput.split(",");
            for (String s : numerosArray) {
                numeros.add(Double.parseDouble(s.trim()));
            }
        } catch (NumberFormatException e) {
            System.out.println("Erro: Entrada de números inválida. Certifique-se de usar apenas números e vírgulas.");
            scanner.close();
            return;
        }

        double resultado = 0;

        if (operacao == 1) { // Soma
            for (double num : numeros) {
                resultado += num;
            }
            System.out.println("Resultado da Soma: " + resultado);
        } else if (operacao == 2) { // Subtração
            if (numeros.isEmpty()) {
                System.out.println("Não há números para subtrair.");
            } else {
                resultado = numeros.get(0); // Começa com o primeiro número
                for (int i = 1; i < numeros.size(); i++) {
                    resultado -= numeros.get(i);
                }
                System.out.println("Resultado da Subtração: " + resultado);
            }
        } else {
            System.out.println("Operação inválida. Por favor, escolha 1 para Soma ou 2 para Subtração.");
        }

        scanner.close();
    }
}
