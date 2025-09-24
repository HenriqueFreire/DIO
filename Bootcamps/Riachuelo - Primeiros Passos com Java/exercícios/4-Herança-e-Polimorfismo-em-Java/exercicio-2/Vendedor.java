public class Vendedor extends Usuario {
    private int quantidadeVendas;

    public Vendedor(String nome, String email, String senha) {
        super(nome, email, senha, false); // Vendedor é sempre não administrador
        this.quantidadeVendas = 0;
    }

    public int getQuantidadeVendas() {
        return quantidadeVendas;
    }

    // Métodos específicos do Vendedor
    public void realizarVenda() {
        this.quantidadeVendas++;
        System.out.println("Vendedor " + getNome() + " realizou uma venda. Total de vendas: " + quantidadeVendas);
    }

    public void consultarVendas() {
        System.out.println("Vendedor " + getNome() + " consultando suas vendas. Total: " + quantidadeVendas);
    }
}
