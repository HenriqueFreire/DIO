cmake_minimum_required(VERSION 3.10)
project(product_service)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Drogon REQUIRED)

add_executable(product_service main.cc)
target_link_libraries(product_service PRIVATE Drogon)

target_include_directories(product_service PUBLIC ${DROGON_INCLUDE_DIRS})

enable_testing()

find_package(GTest REQUIRED)

add_executable(product_service_test tests/product_test.cc)
target_link_libraries(product_service_test PRIVATE Drogon GTest::gtest GTest::gtest_main)
add_test(NAME product_service_unit_test COMMAND product_service_test)
