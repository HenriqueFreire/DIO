package marketing_messages;

/**
 * Interface para definir um serviço de envio de mensagens.
 * Qualquer classe que implementa esta interface deve fornecer
 * uma maneira de enviar uma mensagem.
 */
public interface MessageService {
  /**
   * Envia uma mensagem de texto.
   * @param message O conteúdo da mensagem a ser enviada.
   */
  void sendMessage(String message);
}

