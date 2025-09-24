package marketing_messages;

public class SmsService implements MessageService {
  @Override
  public void sendMessage(String message) {
    System.out.println("Enviando SMS: " + message);
  }
}
