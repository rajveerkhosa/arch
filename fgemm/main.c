#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void fgemm(int m, int n, int k, float *A, float *B, float *C);

int main() {
    int m = 128, n = 128, k = 128;

    float *A = malloc(sizeof(float) * m * k);
    float *B = malloc(sizeof(float) * k * n);
    float *C = malloc(sizeof(float) * m * n);

    for (int i = 0; i < m * k; i++) A[i] = 1.0f;
    for (int i = 0; i < k * n; i++) B[i] = 1.0f;

    clock_t start = clock();
    fgemm(m, n, k, A, B, C);
    clock_t end = clock();

    printf("Time: %f sec\n", (float)(end - start) / CLOCKS_PER_SEC);
    printf("C[0] = %f\n", C[0]);

    free(A); free(B); free(C);
    return 0;
}

