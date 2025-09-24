public class Atendente extends Usuario {
    private double valorEmCaixa;

    public Atendente(String nome, String email, String senha) {
        super(nome, email, senha, false); // Atendente é sempre não administrador
        this.valorEmCaixa = 0.0;
    }

    public double getValorEmCaixa() {
        return valorEmCaixa;
    }

    // Métodos específicos do Atendente
    public void receberPagamento(double valor) {
        if (valor > 0) {
            this.valorEmCaixa += valor;
            System.out.println("Atendente " + getNome() + " recebeu R$" + String.format("%.2f", valor) + ". Valor em caixa: R$" + String.format("%.2f", valorEmCaixa));
        } else {
            System.out.println("Valor de pagamento inválido.");
        }
    }

    public void fecharCaixa() {
        System.out.println("Atendente " + getNome() + " fechou o caixa. Valor final em caixa: R$" + String.format("%.2f", valorEmCaixa));
        // Lógica para registrar o fechamento do caixa e talvez zerar o valorEmCaixa para o próximo turno
        this.valorEmCaixa = 0.0; // Zera o caixa após o fechamento
    }
}
