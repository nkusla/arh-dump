#include <stdio.h>
#define SIZE 16

void pescaniSat(unsigned short* niz, int n);

void PrintBin16(short int a) {
	unsigned short m = 0x8000;
	for(int i = 1; i <= 16; ++i) {
		unsigned short b = a & m;
		b >>= (16-i);
		b == 1 ? printf("\x1b[32m%hu\x1b[0m", b) : printf("%hu", b);	
		if(i % 8 == 0) { printf(" "); }
		m >>= 1;
	}
}

int main() {

	unsigned short niz[SIZE] = {0};
	int n;

	printf("Unesite visinu sata: ");
	scanf("%d", &n);

	pescaniSat(niz, n);
	for(int i = 0; i < n; ++i) {
		PrintBin16(niz[i]);
		printf("\n");
	}
}