#include <stdlib.h>
#include <stdio.h>

void myFMA(int length, float* a, float* b, float* c);

int main(int argc, char** argv) {
    const int length = 20000000;
    float* a = (float*) malloc(sizeof(float) * length);
    float* b = (float*) malloc(sizeof(float) * length);
    float* c = (float*) malloc(sizeof(float) * length);

    myFMA(length, a, b, c);

    free(a);
    free(b);
    free(c);
    return 0;
}

