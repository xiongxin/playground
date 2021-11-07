#include <iostream>

// For example, the number of positive integers ≤ 2076 and divisible by 19 is
// 2076/19 = 109.26316 = 109.

int main() {
    int j = 0;
    for (int i = 1; i <= 2076; i++) {
        if (i % 19 == 0) {
            j++;
        }
    }

    // j = 109
    std::cout << j << std::endl;

    return 0;
}