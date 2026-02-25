cmake_minimum_required(VERSION 3.10)
project(user_service)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Drogon REQUIRED)

add_executable(user_service main.cc)
target_link_libraries(user_service PRIVATE Drogon)

target_include_directories(user_service PUBLIC ${DROGON_INCLUDE_DIRS})

enable_testing()

find_package(GTest REQUIRED)

add_executable(user_service_test tests/user_test.cc)
target_link_libraries(user_service_test PRIVATE Drogon GTest::gtest GTest::gtest_main)
add_test(NAME user_service_unit_test COMMAND user_service_test)
