public class MainUsuarios {
    public static void main(String[] args) {
        // Testando Gerente
        Gerente gerente = new Gerente("Carlos Silva", "carlos.silva@empresa.com", "senha123");
        gerente.realizarLogin("carlos.silva@empresa.com", "senha123");
        gerente.gerarRelatorioFinanceiro();
        gerente.consultarVendas();
        gerente.alterarDados("Carlos Alberto Silva", "carlos.a.silva@empresa.com");
        gerente.alterarSenha("novaSenha456");
        gerente.realizarLogoff();
        System.out.println("\n");

        // Testando Vendedor
        Vendedor vendedor = new Vendedor("Ana Souza", "ana.souza@empresa.com", "venda123");
        vendedor.realizarLogin("ana.souza@empresa.com", "venda123");
        vendedor.realizarVenda();
        vendedor.realizarVenda();
        vendedor.consultarVendas();
        vendedor.realizarLogoff();
        System.out.println("\n");

        // Testando Atendente
        Atendente atendente = new Atendente("Pedro Lima", "pedro.lima@empresa.com", "caixa789");
        atendente.realizarLogin("pedro.lima@empresa.com", "caixa789");
        atendente.receberPagamento(150.75);
        atendente.receberPagamento(200.00);
        System.out.println("Valor atual em caixa: R$" + String.format("%.2f", atendente.getValorEmCaixa()));
        atendente.fecharCaixa();
        atendente.realizarLogoff();
        System.out.println("\n");

        // Exemplo de polimorfismo
        System.out.println("--- Exemplo de Polimorfismo ---");
        Usuario[] usuarios = new Usuario[3];
        usuarios[0] = new Gerente("Fernanda Costa", "fernanda.costa@empresa.com", "admin123");
        usuarios[1] = new Vendedor("Bruno Mendes", "bruno.mendes@empresa.com", "vendas456");
        usuarios[2] = new Atendente("Mariana Dias", "mariana.dias@empresa.com", "atend789");

        for (Usuario u : usuarios) {
            System.out.println("Nome: " + u.getNome() + ", Email: " + u.getEmail() + ", Admin: " + u.isAdministrador());
            u.realizarLogin(u.getEmail(), "senhaIncorreta"); // Tentativa de login incorreta
            u.realizarLogin(u.getEmail(), (u instanceof Gerente) ? "admin123" : (u instanceof Vendedor) ? "vendas456" : "atend789"); // Login correto
            u.realizarLogoff();
            System.out.println("------------------------------");
        }
    }
}