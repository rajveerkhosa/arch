#include <stdio.h>
#include <stdlib.h>

void sscal(int length, int a, float *x, int stride);

int main(void) {
    const int N = 200000000;
    printf("Running SSCAL operation of size %d x 1\n", N);
    int a = 13;
    float *x = (float *) malloc(N * sizeof(float));
    int stride = 2;

    sscal(N, a, x, stride);

    free(x);
    return 0;
}

// Temporary stub just to compile
void sscal(int length, int a, float *x, int stride) {}

