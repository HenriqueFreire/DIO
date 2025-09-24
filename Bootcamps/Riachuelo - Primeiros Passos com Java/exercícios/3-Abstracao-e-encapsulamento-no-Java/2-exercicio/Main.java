import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Carro meuCarro = new Carro();

        System.out.println("Bem-vindo ao simulador de carro!");

        int opcao;
        do {
            System.out.println("\n--- Menu de Operações do Carro ---");
            System.out.println("Status atual: " + (meuCarro.estaLigado() ? "Ligado" : "Desligado") + ", Velocidade: " + meuCarro.verificarVelocidade() + " km/h, Marcha: " + meuCarro.getMarcha());
            System.out.println("1. Ligar Carro");
            System.out.println("2. Desligar Carro");
            System.out.println("3. Acelerar");
            System.out.println("4. Diminuir Velocidade");
            System.out.println("5. Virar (Esquerda/Direita)");
            System.out.println("6. Trocar Marcha");
            System.out.println("0. Sair");
            System.out.print("Escolha uma opção: ");
            opcao = scanner.nextInt();

            switch (opcao) {
                case 1:
                    meuCarro.ligar();
                    break;
                case 2:
                    meuCarro.desligar();
                    break;
                case 3:
                    meuCarro.acelerar();
                    break;
                case 4:
                    meuCarro.diminuirVelocidade();
                    break;
                case 5:
                    System.out.print("Para qual direção deseja virar (esquerda/direita)? ");
                    String direcao = scanner.next();
                    meuCarro.virar(direcao);
                    break;
                case 6:
                    System.out.print("Para qual marcha deseja trocar (0-6)? ");
                    int novaMarcha = scanner.nextInt();
                    meuCarro.trocarMarcha(novaMarcha);
                    break;
                case 0:
                    System.out.println("Saindo do simulador de carro. Obrigado!");
                    break;
                default:
                    System.out.println("Opção inválida. Tente novamente.");
            }
        } while (opcao != 0);

        scanner.close();
    }
}