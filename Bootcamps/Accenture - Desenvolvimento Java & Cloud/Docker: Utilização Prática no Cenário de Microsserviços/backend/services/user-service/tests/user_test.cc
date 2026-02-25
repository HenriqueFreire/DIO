#include <gtest/gtest.h>
#include <string>

// Simulação de uma função de validação que seria testada
bool isValidEmail(const std::string& email) {
    return email.find("@") != std::string::npos;
}

TEST(UserValidationTest, EmailValidation) {
    EXPECT_TRUE(isValidEmail("henrique@example.com"));
    EXPECT_FALSE(isValidEmail("invalid-email"));
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
