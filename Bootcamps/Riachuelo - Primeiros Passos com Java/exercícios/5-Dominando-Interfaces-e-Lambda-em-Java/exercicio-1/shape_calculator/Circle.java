package shape_calculator;

/**
 * Representa um círculo e calcula sua área.
 */
public class Circle implements Shape {
  private double radius;

  public Circle(double radius) {
    this.radius = radius;
  }

  /**
   * Retorna o raio do círculo.
   * @return O raio do círculo.
   */
  public double getRadius() {
    return radius;
  }

  /**
   * Calcula a área do círculo (PI * raio * raio).
   * @return A área do círculo.
   */
  @Override
  public double calculateArea() {
    return Math.PI * radius * radius;
  }
}
