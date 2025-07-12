#include <stdio.h>
#include <stdlib.h>

void iaxpy(int length, int a, int *x, int *y, int *result);

int main(void) {
    int length = 5;
    int a = 3;
    int x[] = {1, 2, 3, 4, 5};
    int y[] = {10, 20, 30, 40, 50};
    int result[5];

    iaxpy(length, a, x, y, result);

    for (int i = 0; i < length; i++) {
        printf("result[%d] = %d\n", i, result[i]);
    }

    return 0;
}

