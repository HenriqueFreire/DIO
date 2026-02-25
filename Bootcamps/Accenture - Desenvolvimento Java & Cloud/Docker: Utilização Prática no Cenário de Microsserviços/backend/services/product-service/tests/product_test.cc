#include <gtest/gtest.h>

// Simulação de lógica de negócio de produtos
struct PriceCalculator {
    static double applyDiscount(double price, double discountPercent) {
        if (discountPercent < 0 || discountPercent > 100) return price;
        return price * (1.0 - discountPercent / 100.0);
    }
};

TEST(ProductLogicTest, DiscountCalculation) {
    EXPECT_DOUBLE_EQ(PriceCalculator::applyDiscount(100.0, 10.0), 90.0);
    EXPECT_DOUBLE_EQ(PriceCalculator::applyDiscount(100.0, 110.0), 100.0);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
