/*
Escreva um código que receba o nome e o ano de nascimento 
de alguém e imprima na tela a seguinte mensagem: "Olá 'Fulano' você tem 'X' anos"
*/

import java.util.Scanner;
import java.time.Year;

public class main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Digite seu nome: ");
        String nome = scanner.nextLine();

        System.out.print("Digite seu ano de nascimento: ");
        int anoNascimento = scanner.nextInt();

        int anoAtual = Year.now().getValue();
        int idade = anoAtual - anoNascimento;

        System.out.println("Olá '" + nome + "' você tem '" + idade + "' anos");

        scanner.close();
    }
}