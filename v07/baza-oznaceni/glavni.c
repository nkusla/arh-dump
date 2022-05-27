#include <stdio.h>
#include <stdlib.h>

int inter_to_str_base(int br, char* str, unsigned int duzina, unsigned int baza);

int main() {
	unsigned int baza, duzina;
	int br;
	char str[33];

	printf("Unesite oznaceni dekadni 32-bitan broj: ");
	scanf("%d", &br);
	printf("Unesite duzinu bafera: ");
	scanf("%u", &duzina);
	printf("Unesite bazu sistema: ");
	scanf("%u", &baza);

	int g = inter_to_str_base(br, str, duzina, baza);
	printf("Greska: %d\n", g);
	if(!g) {
		printf("String: %s", str);
	}
	printf("\n");

	return 0;
}