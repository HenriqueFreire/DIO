#pragma once
#include <string>
#include <cstdint>
#include <vector>

namespace ecommerce::models {

struct Product {
    uint64_t id;
    std::string name;
    std::string description;
    double price;
    uint32_t stock_quantity;

    // C++20: Default comparison operator
    auto operator<=>(const Product&) const = default;
};

} // namespace ecommerce::models
