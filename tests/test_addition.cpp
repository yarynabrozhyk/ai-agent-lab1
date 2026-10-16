#include "addition.h"

#include <gtest/gtest.h>

TEST(AdditionTest, BasicAddition) {
    EXPECT_EQ(add(2, 3), 5);
}
