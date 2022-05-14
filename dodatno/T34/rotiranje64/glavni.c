#include <stdio.h>

int rotiranje64(unsigned long long* n);

void PrintBin64(unsigned long long n) {
	unsigned long long  m = 0x8000000000000000ull;
	for(int i = 1; i <= 64; ++i) {
		unsigned long long b = n & m;
		b >>= (64-i);
		b ? printf("\x1b[32m%llu\x1b[0m", b) : printf("%llu", b);

		if(i % 8 == 0) { printf(" "); }
		m >>= 1;
	}
}

int main() {
	unsigned long long n;
	int br;

	printf("Unesite broj: ");
	scanf("%llu", &n);

	printf("Pre rotiranja: \n");
	PrintBin64(n);

	printf("\nPosle rotiranja: \n");
	br = rotiranje64(&n);
	PrintBin64(n);
	printf("\n\nBroj jedinica u broj je: %d\n", br);

	return 0;
}