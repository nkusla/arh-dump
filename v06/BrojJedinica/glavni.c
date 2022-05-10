#include <stdio.h>

int BrojJedinica(unsigned long long n);

void PrintBin(unsigned long long n) {
	printf("\n");
	unsigned long long m = 0x8000000000000000llu;
	for(int i = 1; i <= 64; ++i) {
		unsigned long long b = n & m;
		b >>= (64-i);
		printf("%llu", b);	

		if(i % 8 == 0) { printf(" "); }
		m >>= 1;
	}
}

int main() {
	unsigned long long n; 
	printf("Unesite broj: ");
	scanf("%llu", &n);

	int num = BrojJedinica(n);
	PrintBin(n);
	printf("\nBroj jedinica: %d\n", num);

	return 0;
}