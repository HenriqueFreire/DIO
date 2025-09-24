import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FormatadorTelefone {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Bem-vindo ao Formatador de Telefone!");
        System.out.println("Por favor, insira um número de telefone (ou 'sair' para encerrar):");

        while (scanner.hasNextLine()) {
            String entrada = scanner.nextLine();
            if (entrada.equalsIgnoreCase("sair")) {
                break;
            }

            String numeroLimpo = entrada.replaceAll("[^0-9]", ""); // Remove caracteres não numéricos

            if (numeroLimpo.isEmpty()) {
                System.out.println("Entrada inválida. Por favor, insira um número de telefone.");
            } else {
                String resultado = formatarNumero(numeroLimpo);
                System.out.println("Entrada: " + entrada);
                System.out.println("Resultado: " + resultado);
            }
            System.out.println("\nPor favor, insira outro número de telefone (ou 'sair' para encerrar):");
        }

        scanner.close();
        System.out.println("Programa encerrado.");
    }

    public static String formatarNumero(String numeroLimpo) {
        int tamanho = numeroLimpo.length();

        // Padrões de telefone fixo
        // 8 dígitos sem DDD: xxxx-xxxx
        if (tamanho == 8) {
            return "Telefone Fixo (sem DDD): " + numeroLimpo.substring(0, 4) + "-" + numeroLimpo.substring(4);
        }
        // 10 dígitos com DDD: (xx)xxxx-xxxx
        if (tamanho == 10) {
            return "Telefone Fixo (com DDD): (" + numeroLimpo.substring(0, 2) + ")" + numeroLimpo.substring(2, 6) + "-" + numeroLimpo.substring(6);
        }

        // Padrões de celular
        // 9 dígitos sem DDD: xxxxx-xxxx
        if (tamanho == 9) {
            return "Celular (sem DDD): " + numeroLimpo.substring(0, 5) + "-" + numeroLimpo.substring(5);
        }
        // 11 dígitos com DDD: (xx)xxxxx-xxxx
        if (tamanho == 11) {
            return "Celular (com DDD): (" + numeroLimpo.substring(0, 2) + ")" + numeroLimpo.substring(2, 7) + "-" + numeroLimpo.substring(7);
        }

        // Se a entrada já estiver formatada, tentar identificar o tipo
        Pattern pFixoDDD = Pattern.compile("^\\((\\d{2})\\)(\\d{4})-(\\d{4})$");
        Pattern pFixoSemDDD = Pattern.compile("^(\\d{4})-(\\d{4})$");
        Pattern pCelularDDD = Pattern.compile("^\\((\\d{2})\\)(\\d{5})-(\\d{4})$");
        Pattern pCelularSemDDD = Pattern.compile("^(\\d{5})-(\\d{4})$");

        Matcher mFixoDDD = pFixoDDD.matcher(numeroLimpo);
        Matcher mFixoSemDDD = pFixoSemDDD.matcher(numeroLimpo);
        Matcher mCelularDDD = pCelularDDD.matcher(numeroLimpo);
        Matcher mCelularSemDDD = pCelularSemDDD.matcher(numeroLimpo);

        if (mFixoDDD.matches()) {
            return "Telefone Fixo (com DDD, já formatado): " + numeroLimpo;
        } else if (mFixoSemDDD.matches()) {
            return "Telefone Fixo (sem DDD, já formatado): " + numeroLimpo;
        } else if (mCelularDDD.matches()) {
            return "Celular (com DDD, já formatado): " + numeroLimpo;
        } else if (mCelularSemDDD.matches()) {
            return "Celular (sem DDD, já formatado): " + numeroLimpo;
        }

        // Se a entrada tiver números e outros caracteres, tentar extrair e formatar
        Pattern pNumeros = Pattern.compile("(\\d+)");
        Matcher mNumeros = pNumeros.matcher(numeroLimpo);
        StringBuilder apenasNumeros = new StringBuilder();
        while (mNumeros.find()) {
            apenasNumeros.append(mNumeros.group(1));
        }

        if (apenasNumeros.length() > 0) {
            String numeroExtraido = apenasNumeros.toString();
            String resultadoExtraido = formatarNumero(numeroExtraido); // Chama recursivamente para formatar o número extraído
            if (!resultadoExtraido.startsWith("Número inválido")) {
                return "Entrada com caracteres extras, número extraído e formatado: " + resultadoExtraido;
            }
        }

        return "Número inválido: " + numeroLimpo + " (quantidade de dígitos não corresponde a um padrão válido ou formato incorreto)";
    }
}