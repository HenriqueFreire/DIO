import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Scanner;

public class GeradorDados {

    public record CampoDado(String nomeCampo, String valor, String tipo) {
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<CampoDado> dadosColetados = new ArrayList<>();

        System.out.println("Bem-vindo ao Gerador de Dados (Java 21 Edition)!");
        System.out.println("Insira os dados no formato NOME_CAMPO;VALOR;TIPO; (ou 'fim' para parar):");
        System.out.println("Tipos aceitos: texto, datas, data e hora, numeros inteiros, numeros com pontos flutuantes, boleanos, array");

        while (true) {
            System.out.print("> ");
            String entrada = scanner.nextLine();

            if (entrada.equalsIgnoreCase("fim")) {
                break;
            }

            Optional<CampoDado> campoOpcional = parseEntrada(entrada);

            campoOpcional.ifPresentOrElse(
                    dadosColetados::add,
                    () -> System.out.println("Formato inválido. Use NOME_CAMPO;VALOR;TIPO;")
            );
        }

        scanner.close();

        if (!dadosColetados.isEmpty()) {
            System.out.println("\n--- Dados Coletados ---");
            dadosColetados.forEach(System.out::println);

            System.out.println("\n--- JSON (Simulado) ---");
            System.out.println(gerarJsonSimulado(dadosColetados));

            System.out.println("\n--- XML (Simulado) ---");
            System.out.println(gerarXmlSimulado(dadosColetados));

            System.out.println("\n--- YAML (Simulado) ---");
            System.out.println(gerarYamlSimulado(dadosColetados));

        } else {
            System.out.println("Nenhum dado foi inserido.");
        }
    }

    private static Optional<CampoDado> parseEntrada(String entrada) {
        String[] partes = entrada.split(";");
        if (partes.length == 3) {
            return Optional.of(new CampoDado(partes[0].trim(), partes[1].trim(), partes[2].trim()));
        }
        return Optional.empty();
    }

    private static String gerarJsonSimulado(List<CampoDado> dados) {
        StringBuilder json = new StringBuilder("[").append(System.lineSeparator());
        for (int i = 0; i < dados.size(); i++) {
            CampoDado dado = dados.get(i);
            json.append("  {")
                .append(System.lineSeparator())
                .append("    \"nome_campo\": \"").append(dado.nomeCampo()).append("\",")
                .append(System.lineSeparator())
                .append("    \"valor\": \"").append(dado.valor()).append("\",")
                .append(System.lineSeparator())
                .append("    \"tipo\": \"").append(dado.tipo()).append("\"")
                .append(System.lineSeparator())
                .append("  }");
            if (i < dados.size() - 1) {
                json.append(",");
            }
            json.append(System.lineSeparator());
        }
        json.append("]");
        return json.toString();
    }

    private static String gerarXmlSimulado(List<CampoDado> dados) {
        StringBuilder xml = new StringBuilder("<dados>").append(System.lineSeparator());
        for (CampoDado dado : dados) {
            xml.append("  <campo>")
               .append(System.lineSeparator())
               .append("    <nome_campo>").append(dado.nomeCampo()).append("</nome_campo>")
               .append(System.lineSeparator())
               .append("    <valor>").append(dado.valor()).append("</valor>")
               .append(System.lineSeparator())
               .append("    <tipo>").append(dado.tipo()).append("</tipo>")
               .append(System.lineSeparator())
               .append("  </campo>")
               .append(System.lineSeparator());
        }
        xml.append("</dados>");
        return xml.toString();
    }

    private static String gerarYamlSimulado(List<CampoDado> dados) {
        StringBuilder yaml = new StringBuilder("dados:").append(System.lineSeparator());
        for (CampoDado dado : dados) {
            yaml.append("  - campo:")
                .append(System.lineSeparator())
                .append("      nome_campo: ").append(dado.nomeCampo())
                .append(System.lineSeparator())
                .append("      valor: ").append(dado.valor())
                .append(System.lineSeparator())
                .append("      tipo: ").append(dado.tipo())
                .append(System.lineSeparator());
        }
        return yaml.toString();
    }
}
