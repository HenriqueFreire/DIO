import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        MaquinaDeBanho maquina = new MaquinaDeBanho();

        System.out.println("Bem-vindo ao sistema de máquina de banho de pet!");

        int opcao;
        do {
            System.out.println("\n--- Menu de Operações da Máquina de Banho ---");
            System.out.println("Nível de Água: " + String.format("%.2f", maquina.verificarNivelAgua()) + "L");
            System.out.println("Nível de Shampoo: " + String.format("%.2f", maquina.verificarNivelShampoo()) + "L");
            System.out.println("Pet na Máquina: " + (maquina.verificarPetNaMaquina() ? "Sim" : "Não"));
            System.out.println("1. Colocar Pet na Máquina");
            System.out.println("2. Retirar Pet da Máquina");
            System.out.println("3. Dar Banho no Pet");
            System.out.println("4. Abastecer Água");
            System.out.println("5. Abastecer Shampoo");
            System.out.println("6. Limpar Máquina");
            System.out.println("0. Sair");
            System.out.print("Escolha uma opção: ");
            opcao = scanner.nextInt();

            switch (opcao) {
                case 1:
                    maquina.colocarPetNaMaquina();
                    break;
                case 2:
                    maquina.retirarPetDaMaquina();
                    break;
                case 3:
                    maquina.darBanhoNoPet();
                    break;
                case 4:
                    maquina.abastecerAgua();
                    break;
                case 5:
                    maquina.abastecerShampoo();
                    break;
                case 6:
                    maquina.limparMaquina();
                    break;
                case 0:
                    System.out.println("Saindo do sistema da máquina de banho. Obrigado!");
                    break;
                default:
                    System.out.println("Opção inválida. Tente novamente.");
            }
        } while (opcao != 0);

        scanner.close();
    }
}