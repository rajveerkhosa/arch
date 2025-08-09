#include <stdio.h>
#include <stdlib.h>

void mysquare( int n, float* a );

int main() {
	unsigned int n = 1024;
	
	float* a = (float*) malloc( sizeof( float ) * n );
	

	//	Initialize vals
	for (int i = 0; i < n; i++) {
		a[i] = i + 1;
	}
		
	mysquare(n, a);
	
	//	Prints results
	for (int i = 0; i < n; i++) {
		printf("a[%d] = %.2f\n", i, a[i]);
	}

	free( a );
	
	return 0;
}
