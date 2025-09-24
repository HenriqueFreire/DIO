public class IngressoFamilia extends Ingresso {
    private int numeroPessoas;

    public IngressoFamilia(double valor, String nomeFilme, String dubladoOuLegendado, int numeroPessoas) {
        super(valor, nomeFilme, dubladoOuLegendado);
        this.numeroPessoas = numeroPessoas;
    }

    public int getNumeroPessoas() {
        return numeroPessoas;
    }

    public void setNumeroPessoas(int numeroPessoas) {
        this.numeroPessoas = numeroPessoas;
    }

    @Override
    public double getValorReal() {
        double valorTotal = super.getValorReal() * numeroPessoas;
        if (numeroPessoas > 3) {
            valorTotal *= 0.95; // Desconto de 5%
        }
        return valorTotal;
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("--- Ingresso Família ---");
        super.exibirDetalhes();
        System.out.println("Número de Pessoas: " + numeroPessoas);
    }
}
