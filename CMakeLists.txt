cmake_minimum_required(VERSION 3.20)

project(HelloWorld LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(addition src/addition.cpp)
target_include_directories(addition PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src")

add_executable(hello_world src/main.cpp)

include(CTest)
if(BUILD_TESTING)
    enable_testing()
    include(FetchContent)

    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    add_executable(addition_tests tests/test_addition.cpp)
    target_link_libraries(addition_tests PRIVATE addition GTest::gtest_main)

    add_test(
        NAME BasicAddition
        COMMAND addition_tests --gtest_filter=AdditionTest.BasicAddition
    )
endif()
