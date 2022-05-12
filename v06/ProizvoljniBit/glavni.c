#include <stdio.h>

void ProizvoljniBit(unsigned long long* n, unsigned int pos, unsigned int v);

void PrintBin64(unsigned long long n, int k) {
	unsigned long long  m = 0x8000000000000000ull;
	for(int i = 1; i <= 64; ++i) {
		unsigned long long b = n & m;
		b >>= (64-i);
		64-i == k ? printf("\x1b[32m%llu\x1b[0m", b) : printf("%llu", b);	

		if(i % 8 == 0) { printf(" "); }
		m >>= 1;
	}
}

int main() {
	unsigned long long n; 
	unsigned int pos, v;
	
	printf("Unesite broj: ");
	scanf("%llu", &n);
	printf("Pozicija bita (0-63): ");
	scanf("%u", &pos);
	printf("Vrednost bita (0/1): ");
	scanf("%u", &v);

	printf("Pre: \n");
	PrintBin64(n, -1);
	ProizvoljniBit(&n, pos, v);
	printf("\n\nPosle: \n");
	PrintBin64(n, pos);
	printf("\n");

	return 0;
}