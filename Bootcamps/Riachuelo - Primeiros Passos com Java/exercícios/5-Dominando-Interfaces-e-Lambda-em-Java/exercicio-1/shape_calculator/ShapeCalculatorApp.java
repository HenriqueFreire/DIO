package shape_calculator;

/**
 * Aplicação principal para demonstrar o cálculo da área de diferentes figuras geométricas.
 */
public class ShapeCalculatorApp {
  public static void main(String[] args) {
    // Criando algumas figuras geométricas
    Shape square = new Square(5.0);
    Shape rectangle = new Rectangle(4.0, 6.0);
    Shape circle = new Circle(3.0);

    System.out.println("--- Cálculo de Área de Figuras Geométricas ---");

    // Calculando e exibindo áreas
    printAreaDetails("Quadrado", square);
    printAreaDetails("Retângulo", rectangle);
    printAreaDetails("Círculo", circle);

    // Exemplo com lambda para uma forma geométrica ad-hoc (ex: um triângulo simples)
    System.out.println("\n--- Cálculo de Área via Lambda (Triângulo Ad-Hoc) ---");
    Shape triangle = () -> {
      double base = 7.0;
      double height = 4.0;
      return (base * height) / 2;
    };
    System.out.printf("Área do Triângulo (Ad-Hoc): %.2f%n", triangle.calculateArea());
    System.out.println("--- Fim do Cálculo ---");
  }

  /**
   * Método auxiliar para imprimir os detalhes da área de uma figura.
   * @param shapeName O nome da figura.
   * @param shape A figura para a qual a área será calculada e impressa.
   */
  private static void printAreaDetails(String shapeName, Shape shape) {
    System.out.printf("Área do %s: %.2f%n", shapeName, shape.calculateArea());
  }
}
