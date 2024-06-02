#include <stdio.h>

int main() { 
	int b = 2;
	int exp = 3;

	while (exp > 0) {
		b = b * b;
		exp = exp - 1;
	}

	printf("b = %d and exp = %d", b, exp);
}
