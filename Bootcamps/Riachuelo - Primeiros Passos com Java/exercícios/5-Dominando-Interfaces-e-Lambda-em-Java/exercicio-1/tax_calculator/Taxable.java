package tax_calculator;

/**
 * Interface para definir um contrato para itens que podem ter impostos calculados.
 */
public interface Taxable {
  /**
   * Calcula e retorna o valor do imposto.
   * @return O valor do imposto calculado.
   */
  double calculateTax();
}
