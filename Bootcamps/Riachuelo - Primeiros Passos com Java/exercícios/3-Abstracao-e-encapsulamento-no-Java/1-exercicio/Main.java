import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ContaBancaria minhaConta = null;

        System.out.println("Bem-vindo ao sistema bancário!");

        // Criação da conta
        System.out.print("Digite o saldo inicial da conta: R$");
        double saldoInicial = scanner.nextDouble();
        minhaConta = new ContaBancaria(saldoInicial);
        System.out.println("Conta criada com sucesso!");

        int opcao;
        do {
            System.out.println("\n--- Menu de Operações ---");
            System.out.println("1. Consultar Saldo");
            System.out.println("2. Consultar Cheque Especial Disponível");
            System.out.println("3. Depositar Dinheiro");
            System.out.println("4. Sacar Dinheiro");
            System.out.println("5. Pagar Boleto");
            System.out.println("6. Verificar Uso de Cheque Especial");
            System.out.println("0. Sair");
            System.out.print("Escolha uma opção: ");
            opcao = scanner.nextInt();

            switch (opcao) {
                case 1:
                    System.out.println("Saldo atual: R$" + String.format("%.2f", minhaConta.consultarSaldo()));
                    break;
                case 2:
                    System.out.println("Cheque especial disponível: R$" + String.format("%.2f", minhaConta.consultarChequeEspecialDisponivel()));
                    break;
                case 3:
                    System.out.print("Digite o valor a depositar: R$");
                    double valorDeposito = scanner.nextDouble();
                    minhaConta.depositar(valorDeposito);
                    break;
                case 4:
                    System.out.print("Digite o valor a sacar: R$");
                    double valorSaque = scanner.nextDouble();
                    minhaConta.sacar(valorSaque);
                    break;
                case 5:
                    System.out.print("Digite o valor do boleto a pagar: R$");
                    double valorBoleto = scanner.nextDouble();
                    minhaConta.pagarBoleto(valorBoleto);
                    break;
                case 6:
                    if (minhaConta.estaUsandoChequeEspecial()) {
                        System.out.println("Você está usando o cheque especial.");
                    } else {
                        System.out.println("Você não está usando o cheque especial.");
                    }
                    break;
                case 0:
                    System.out.println("Saindo do sistema. Obrigado!");
                    break;
                default:
                    System.out.println("Opção inválida. Tente novamente.");
            }
        } while (opcao != 0);

        scanner.close();
    }
}