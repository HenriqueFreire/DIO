/*
Escreva um código que receba a base e a alturade um retângulo, calcule sua área e exiba na tela
fórmula: área=base X altura
*/

import java.util.Scanner;

public class main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Digite o valor da base do retângulo: ");
        double base = scanner.nextDouble();

        System.out.print("Digite o valor da altura do retângulo: ");
        double altura = scanner.nextDouble();

        double area = base * altura;

        System.out.println("A área do retângulo é: " + area);

        scanner.close();
    }
}