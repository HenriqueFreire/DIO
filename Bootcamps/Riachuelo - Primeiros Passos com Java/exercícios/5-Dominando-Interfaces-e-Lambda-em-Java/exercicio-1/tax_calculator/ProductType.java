package tax_calculator;

/**
 * Enumeração para os tipos de produtos e suas respectivas taxas de imposto.
 */
public enum ProductType {
  ALIMENTACAO(0.01), // 1%
  SAUDE_E_BEM_ESTAR(0.015), // 1.5%
  VESTUARIO(0.025), // 2.5%
  CULTURA(0.04); // 4%

  private final double taxRate;

  ProductType(double taxRate) {
    this.taxRate = taxRate;
  }

  /**
   * Retorna a taxa de imposto associada a este tipo de produto.
   * @return A taxa de imposto.
   */
  public double getTaxRate() {
    return taxRate;
  }
}

