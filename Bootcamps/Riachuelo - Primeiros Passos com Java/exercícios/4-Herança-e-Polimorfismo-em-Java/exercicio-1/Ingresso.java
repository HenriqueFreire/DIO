public class Ingresso {
    private double valor;
    private String nomeFilme;
    private String dubladoOuLegendado; // "Dublado" ou "Legendado"

    public Ingresso(double valor, String nomeFilme, String dubladoOuLegendado) {
        this.valor = valor;
        this.nomeFilme = nomeFilme;
        this.dubladoOuLegendado = dubladoOuLegendado;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public String getNomeFilme() {
        return nomeFilme;
    }

    public void setNomeFilme(String nomeFilme) {
        this.nomeFilme = nomeFilme;
    }

    public String getDubladoOuLegendado() {
        return dubladoOuLegendado;
    }

    public void setDubladoOuLegendado(String dubladoOuLegendado) {
        this.dubladoOuLegendado = dubladoOuLegendado;
    }

    public double getValorReal() {
        return this.valor;
    }

    public void exibirDetalhes() {
        System.out.println("Filme: " + nomeFilme);
        System.out.println("Tipo: " + dubladoOuLegendado);
        System.out.println("Valor Base: R$" + String.format("%.2f", valor));
        System.out.println("Valor Real: R$" + String.format("%.2f", getValorReal()));
    }
}
