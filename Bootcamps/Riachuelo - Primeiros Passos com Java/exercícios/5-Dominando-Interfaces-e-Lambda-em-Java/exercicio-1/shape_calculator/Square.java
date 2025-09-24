package shape_calculator;

/**
 * Representa um quadrado e calcula sua área.
 */
public class Square implements Shape {
  private double side;

  public Square(double side) {
    this.side = side;
  }

  /**
   * Retorna o lado do quadrado.
   * @return O lado do quadrado.
   */
  public double getSide() {
    return side;
  }

  /**
   * Calcula a área do quadrado (lado * lado).
   * @return A área do quadrado.
   */
  @Override
  public double calculateArea() {
    return side * side;
  }
}
