package shape_calculator;

/**
 * Interface para definir um contrato para figuras geométricas que podem ter sua área calculada.
 */
public interface Shape {
  /**
   * Calcula e retorna a área da figura geométrica.
   * @return A área da figura geométrica.
   */
  double calculateArea();
}
