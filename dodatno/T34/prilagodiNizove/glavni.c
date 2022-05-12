#include <stdio.h>
#define SIZE 9

unsigned long long prilagodiNizove(unsigned int* a, unsigned int* b, int n);

void ispisiNizove(unsigned int* a, unsigned int* b, int n) {
	printf("Niz a: \n  ");
	for(int i = 0; i < n; ++i) {
		printf("%-4u ", a[i]);
	}
	printf("\nNiz b: \n  ");
	for(int i = 0; i < n; ++i) {
		printf("%-4u ", b[i]);
	}
	printf("\n");
}

int main() {
	unsigned int a[SIZE] = { 9, 10, 0, 429, 100, 69, 6, 1000, 4294967295 };
	unsigned int b[SIZE] = { 9, 11, 0, 420, 100, 7, 6, 0, 10 };

	unsigned long long num = prilagodiNizove(a, b, SIZE);
	ispisiNizove(a, b, SIZE);
	
	printf("\nPovratna vrednost je: %llu\n", num);

	return 0;
}