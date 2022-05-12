#include <stdio.h>
#define SIZE 6

int CheckParityArray(unsigned short int* niz, int n);

void PrintBin16(unsigned long long n) {
	unsigned short int m = 0x8000u;
	for(int i = 1; i <= 16; ++i) {
		unsigned long long b = n & m;
		b >>= (16-i);
		printf("%llu", b);	

		if(i % 8 == 0) { printf(" "); }
		m >>= 1;
	}
}

int main() {
	unsigned short int niz[SIZE] = {32768, 33024, 7, 10, 65535, 0};

	int num = CheckParityArray(niz, SIZE);
	for(int i = 0; i < SIZE; ++i) {
		printf("%d: ", i+1); 
		PrintBin16(niz[i]);
		printf("\n");
	}
	printf("\nBroj vrednosti koje imaju dobar paritet je: %d\n", num);

	return 0;
}