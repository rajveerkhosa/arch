#include <stdlib.h>
#include <stdio.h>

int main(int argc, char** argv) {
    const int length = 200000000;
    int* a = (int*) malloc(sizeof(int) * length);
    int* b = (int*) malloc(sizeof(int) * length);

    for (int i = 0; i < length; i++) {
        a[i] = b[i] * b[i];
    }

    free(a);
    free(b);
    return 0;
}

