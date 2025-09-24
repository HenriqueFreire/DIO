package marketing_messages;

public class SocialMediaService implements MessageService {
  @Override
  public void sendMessage(String message) {
    System.out.println("Publicando em Redes Sociais: " + message);
  }
}
