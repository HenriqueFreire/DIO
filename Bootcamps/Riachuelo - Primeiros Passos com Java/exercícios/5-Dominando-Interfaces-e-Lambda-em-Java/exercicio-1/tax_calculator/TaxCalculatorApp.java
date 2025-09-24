package tax_calculator;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.List;

/**
 * Aplicação principal para demonstrar o cálculo de impostos de produtos,
 * utilizando a interface Taxable e BigDecimal para precisão financeira.
 */
public class TaxCalculatorApp {
  public static void main(String[] args) {
    // Criando alguns produtos
    List<Product> products = Arrays.asList(
      new Product("Arroz", 100.0, ProductType.ALIMENTACAO),
      new Product("Vitamina C", 50.0, ProductType.SAUDE_E_BEM_ESTAR),
      new Product("Camiseta", 80.0, ProductType.VESTUARIO),
      new Product("Livro Java", 120.0, ProductType.CULTURA)
    );

    System.out.println("--- Cálculo de Impostos de Produtos ---");

    // Calculando e exibindo impostos para cada produto
    products.forEach(TaxCalculatorApp::printTaxDetails);

    // Exemplo com lambda para um produto temporário ou cálculo ad-hoc
    System.out.println("\n--- Cálculo de Imposto via Lambda (Serviço Digital Ad-Hoc) ---");
    // Um serviço digital com valor base de 200.0 e taxa de 5%
    Taxable digitalServiceTax = () -> {
      BigDecimal baseValue = new BigDecimal("200.00");
      BigDecimal taxRate = new BigDecimal("0.05"); // 5% para serviço digital (exemplo)
      return baseValue.multiply(taxRate).setScale(2, RoundingMode.HALF_UP).doubleValue();
    };
    System.out.printf("Imposto para Serviço Digital (Ad-Hoc): R$ %.2f%n", digitalServiceTax.calculateTax());
    System.out.println("--- Fim do Cálculo ---");
  }

  /**
   * Método auxiliar para imprimir os detalhes do imposto de um produto.
   * @param product O produto para o qual os detalhes do imposto serão impressos.
   */
  private static void printTaxDetails(Product product) {
    double tax = product.calculateTax();
    System.out.printf("Produto: %s (%.2f%%) - Valor Base: R$ %.2f - Imposto: R$ %.2f%n",
      product.getName(), product.getType().getTaxRate() * 100,
      product.getBaseValue(), tax);
  }
}
