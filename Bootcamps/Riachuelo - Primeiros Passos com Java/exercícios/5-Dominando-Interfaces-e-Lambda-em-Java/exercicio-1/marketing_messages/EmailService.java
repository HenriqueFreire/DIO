package marketing_messages;

public class EmailService implements MessageService {
  @Override
  public void sendMessage(String message) {
    System.out.println("Enviando E-mail: " + message);
  }
}
