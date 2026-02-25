#pragma once
#include <string>
#include <cstdint>
#include <vector>
#include <chrono>

namespace ecommerce::models {

struct OrderItem {
    uint64_t product_id;
    uint32_t quantity;
    double price_at_purchase;

    auto operator<=>(const OrderItem&) const = default;
};

struct Order {
    uint64_t id;
    uint64_t user_id;
    std::vector<OrderItem> items;
    double total_price;
    std::chrono::system_clock::time_point created_at;

    auto operator<=>(const Order&) const = default;
};

} // namespace ecommerce::models
