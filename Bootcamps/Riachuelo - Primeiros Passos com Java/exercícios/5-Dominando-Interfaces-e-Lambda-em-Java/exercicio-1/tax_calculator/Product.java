package tax_calculator;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Representa um produto com um valor base e um tipo, capaz de calcular seu imposto.
 * Utiliza BigDecimal para cálculos financeiros precisos.
 */
public class Product implements Taxable {
  private String name;
  private BigDecimal baseValue;
  private ProductType type;

  public Product(String name, double baseValue, ProductType type) {
    this.name = name;
    this.baseValue = BigDecimal.valueOf(baseValue);
    this.type = type;
  }

  /**
   * Retorna o nome do produto.
   * @return O nome do produto.
   */
  public String getName() {
    return name;
  }

  /**
   * Retorna o valor base do produto.
   * @return O valor base do produto.
   */
  public BigDecimal getBaseValue() {
    return baseValue;
  }

  /**
   * Retorna o tipo do produto.
   * @return O tipo do produto.
   */
  public ProductType getType() {
    return type;
  }

  /**
   * Calcula o imposto do produto com base em seu valor base e tipo.
   * O cálculo é feito com BigDecimal para precisão financeira.
   * @return O valor do imposto calculado como double.
   */
  @Override
  public double calculateTax() {
    // Multiplica o valor base pela taxa de imposto e arredonda para duas casas decimais
    return baseValue.multiply(BigDecimal.valueOf(type.getTaxRate()))
      .setScale(2, RoundingMode.HALF_UP)
      .doubleValue();
  }
}
