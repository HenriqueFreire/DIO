package marketing_messages;

public class WhatsAppService implements MessageService {
  @Override
  public void sendMessage(String message) {
    System.out.println("Enviando WhatsApp: " + message);
  }
}
