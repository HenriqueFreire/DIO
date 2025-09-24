public class MeiaEntrada extends Ingresso {

    public MeiaEntrada(double valor, String nomeFilme, String dubladoOuLegendado) {
        super(valor, nomeFilme, dubladoOuLegendado);
    }

    @Override
    public double getValorReal() {
        return super.getValorReal() / 2;
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("--- Ingresso Meia Entrada ---");
        super.exibirDetalhes();
    }
}
