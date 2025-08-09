void myFMA(int length, float* a, float* b, float* c) {
    for (int i = 0; i < length; i++)
        a[i] = a[i] * b[i] + c[i];
}

