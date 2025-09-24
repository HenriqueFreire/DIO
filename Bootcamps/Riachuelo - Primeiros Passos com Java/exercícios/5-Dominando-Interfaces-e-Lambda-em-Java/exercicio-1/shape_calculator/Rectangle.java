package shape_calculator;

/**
 * Representa um retângulo e calcula sua área.
 */
public class Rectangle implements Shape {
  private double base;
  private double height;

  public Rectangle(double base, double height) {
    this.base = base;
    this.height = height;
  }

  /**
   * Retorna a base do retângulo.
   * @return A base do retângulo.
   */
  public double getBase() {
    return base;
  }

  /**
   * Retorna a altura do retângulo.
   * @return A altura do retângulo.
   */
  public double getHeight() {
    return height;
  }

  /**
   * Calcula a área do retângulo (base * altura).
   * @return A área do retângulo.
   */
  @Override
  public double calculateArea() {
    return base * height;
  }
}
