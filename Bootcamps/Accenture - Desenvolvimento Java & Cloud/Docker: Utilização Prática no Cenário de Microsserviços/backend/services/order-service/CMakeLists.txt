cmake_minimum_required(VERSION 3.10)
project(order_service)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Drogon REQUIRED)

add_executable(order_service main.cc)
target_link_libraries(order_service PRIVATE Drogon)

target_include_directories(order_service PUBLIC ${DROGON_INCLUDE_DIRS})
