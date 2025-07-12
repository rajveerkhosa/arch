#include <stdio.h>

float sdot(int length, float *x, float *y);

int main(void) {
    float x[4] = {1.0, 2.0, 3.0, 4.0};
    float y[4] = {10.0, 20.0, 30.0, 40.0};

    float result = sdot(4, x, y);
    printf("Dot product result = %.2f\n", result);

    return 0;
}

