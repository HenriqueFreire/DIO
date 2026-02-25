#pragma once
#include <string>
#include <cstdint>

namespace ecommerce::models {

struct User {
    uint64_t id;
    std::string username;
    std::string email;
    std::string password_hash;

    auto operator<=>(const User&) const = default;
};

} // namespace ecommerce::models
