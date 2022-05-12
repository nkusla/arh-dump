#include <stdio.h>

int CheckParity(unsigned short int* vrednost);

void PrintBin16(unsigned long long n) {
	printf("\n");
	unsigned short int m = 0x8000u;
	for(int i = 1; i <= 16; ++i) {
		unsigned long long b = n & m;
		b >>= (16-i);
		printf("%llu", b);	

		if(i % 8 == 0) { printf(" "); }
		m >>= 1;
	}
	printf("\n");
}

int main() {
	unsigned short int vrednost, num; 
	printf("Unesite broj: ");
	scanf("%hu", &vrednost);

	num = CheckParity(&vrednost);
	PrintBin16(vrednost);
	num ? printf("Paritet je dobro postavljen\n") : printf("Paritet nije dobro postavljen\n");

	return 0;
}