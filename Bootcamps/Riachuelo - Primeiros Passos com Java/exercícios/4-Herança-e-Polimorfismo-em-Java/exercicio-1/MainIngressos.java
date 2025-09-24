public class MainIngressos {
    public static void main(String[] args) {
        // Testando Ingresso normal
        Ingresso ingressoNormal = new Ingresso(50.0, "Duna: Parte 2", "Legendado");
        ingressoNormal.exibirDetalhes();
        System.out.println("\n");

        // Testando Meia Entrada
        MeiaEntrada meiaEntrada = new MeiaEntrada(50.0, "Duna: Parte 2", "Legendado");
        meiaEntrada.exibirDetalhes();
        System.out.println("\n");

        // Testando Ingresso Família com 3 pessoas (sem desconto)
        IngressoFamilia ingressoFamilia3 = new IngressoFamilia(50.0, "Duna: Parte 2", "Dublado", 3);
        ingressoFamilia3.exibirDetalhes();
        System.out.println("\n");

        // Testando Ingresso Família com 4 pessoas (com desconto)
        IngressoFamilia ingressoFamilia4 = new IngressoFamilia(50.0, "Duna: Parte 2", "Dublado", 4);
        ingressoFamilia4.exibirDetalhes();
        System.out.println("\n");

        // Exemplo de polimorfismo
        System.out.println("--- Exemplo de Polimorfismo ---");
        Ingresso[] ingressos = new Ingresso[4];
        ingressos[0] = new Ingresso(40.0, "Divertida Mente 2", "Dublado");
        ingressos[1] = new MeiaEntrada(40.0, "Divertida Mente 2", "Dublado");
        ingressos[2] = new IngressoFamilia(40.0, "Divertida Mente 2", "Dublado", 2);
        ingressos[3] = new IngressoFamilia(40.0, "Divertida Mente 2", "Dublado", 5);

        for (Ingresso i : ingressos) {
            i.exibirDetalhes();
            System.out.println("------------------------------");
        }
    }
}
