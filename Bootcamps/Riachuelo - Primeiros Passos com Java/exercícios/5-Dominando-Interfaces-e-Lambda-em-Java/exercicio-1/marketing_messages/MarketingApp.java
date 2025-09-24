package marketing_messages;

import java.util.Arrays;
import java.util.List;

/**
 * Aplicação principal para demonstrar o envio de mensagens de marketing
 * para diferentes serviços, utilizando o padrão Strategy com interfaces
 * e expressões lambda para flexibilidade.
 */
public class MarketingApp {
  public static void main(String[] args) {
    String marketingMessage = "🎉 Grande Promoção! Não perca as ofertas exclusivas! 🎉";

    // Inicializa os serviços de mensagem
    List<MessageService> services = Arrays.asList(
      new SmsService(),
      new EmailService(),
      new SocialMediaService(),
      new WhatsAppService(),
      // Exemplo de serviço ad-hoc usando expressão lambda
      (msg) -> System.out.println("Enviando Notificação Push: " + msg)
    );

    System.out.println("--- Iniciando Campanha de Marketing ---");

    // Envia a mesma mensagem para todos os serviços registrados
    services.forEach(service -> service.sendMessage(marketingMessage));

    System.out.println("--- Campanha de Marketing Concluída ---");

    // Exemplo de envio de uma mensagem específica para um novo serviço via lambda
    System.out.println("\n--- Enviando Mensagem Urgente via Serviço de Alerta (Lambda) ---");
    MessageService alertService = (msg) -> System.out.println("🚨 ALERTA DE SEGURANÇA: " + msg + " 🚨");
    alertService.sendMessage("Verifique suas credenciais agora!");
    System.out.println("--- Mensagem de Alerta Enviada ---");
  }
}
