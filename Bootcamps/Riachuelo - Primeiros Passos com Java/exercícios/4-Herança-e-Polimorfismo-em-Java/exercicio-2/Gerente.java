public class Gerente extends Usuario {

    public Gerente(String nome, String email, String senha) {
        super(nome, email, senha, true); // Gerente é sempre administrador
    }

    // Métodos específicos do Gerente
    public void gerarRelatorioFinanceiro() {
        System.out.println("Gerente " + getNome() + " gerando relatório financeiro.");
        // Lógica para gerar relatório financeiro
    }

    public void consultarVendas() {
        System.out.println("Gerente " + getNome() + " consultando vendas.");
        // Lógica para consultar vendas
    }
}
