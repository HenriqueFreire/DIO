public class ContaBancaria {
    private double saldo;
    private double limiteChequeEspecial;
    private double valorUsadoChequeEspecial;
    private double taxaChequeEspecial = 0.20; // 20%

    public ContaBancaria(double saldoInicial) {
        this.saldo = saldoInicial;
        if (saldoInicial <= 500.00) {
            this.limiteChequeEspecial = 50.00;
        } else {
            this.limiteChequeEspecial = saldoInicial * 0.50;
        }
        this.valorUsadoChequeEspecial = 0.0;
    }

    public double consultarSaldo() {
        return saldo;
    }

    public double consultarChequeEspecialDisponivel() {
        // O valor disponível é o limite total menos o quanto já foi usado (se o saldo for negativo).
        if (saldo < 0) {
            return limiteChequeEspecial + saldo; // saldo é negativo, então + saldo diminui o limite disponível
        }
        return limiteChequeEspecial;
    }

    public void depositar(double valor) {
        if (valor > 0) {
            saldo += valor;
            System.out.println("Depósito de R$" + String.format("%.2f", valor) + " realizado com sucesso.");

            // Se estava usando cheque especial e agora o saldo está positivo ou zerado
            if (valorUsadoChequeEspecial > 0 && saldo >= 0) {
                double valorTaxa = valorUsadoChequeEspecial * taxaChequeEspecial;
                saldo -= valorTaxa;
                System.out.println("Taxa de cheque especial de R$" + String.format("%.2f", valorTaxa) + " aplicada.");
                valorUsadoChequeEspecial = 0.0;
            }
        } else {
            System.out.println("Valor de depósito inválido.");
        }
    }

    public boolean sacar(double valor) {
        if (valor <= 0) {
            System.out.println("Valor de saque inválido.");
            return false;
        }

        if (saldo + limiteChequeEspecial >= valor) {
            double saldoAnterior = saldo;
            saldo -= valor;
            System.out.println("Saque de R$" + String.format("%.2f", valor) + " realizado com sucesso.");

            if (saldoAnterior >= 0 && saldo < 0) {
                // Começou a usar o cheque especial
                valorUsadoChequeEspecial = Math.abs(saldo);
            } else if (saldoAnterior < 0 && saldo < 0) {
                // Já estava usando e usou mais
                valorUsadoChequeEspecial = Math.abs(saldo);
            }
            return true;
        } else {
            System.out.println("Saldo insuficiente e limite de cheque especial excedido.");
            return false;
        }
    }

    public boolean pagarBoleto(double valor) {
        if (valor <= 0) {
            System.out.println("Valor de boleto inválido.");
            return false;
        }

        if (saldo + limiteChequeEspecial >= valor) {
            double saldoAnterior = saldo;
            saldo -= valor;
            System.out.println("Pagamento de boleto de R$" + String.format("%.2f", valor) + " realizado com sucesso.");

            if (saldoAnterior >= 0 && saldo < 0) {
                // Começou a usar o cheque especial
                valorUsadoChequeEspecial = Math.abs(saldo);
            } else if (saldoAnterior < 0 && saldo < 0) {
                // Já estava usando e usou mais
                valorUsadoChequeEspecial = Math.abs(saldo);
            }
            return true;
        } else {
            System.out.println("Saldo insuficiente e limite de cheque especial excedido para pagar o boleto.");
            return false;
        }
    }

    public boolean estaUsandoChequeEspecial() {
        return saldo < 0;
    }
}