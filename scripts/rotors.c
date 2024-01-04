#include <stdio.h>

size_t get_index(char* str, char c) {
	size_t i = 0;
	while(str[i] != '\0') {
		if(str[i] == c)
			return i;
		i++;
	}
	return 2137;
}

int main() {
	char alphabet[64];
	char fw_key[64];
	char bw_key[64];

	for(char c = 'A'; c <= 'Z'; c++) {
		alphabet[c - 'A'] = c;
		//printf("%c ", alphabet[c - 'A']);
	}

	printf("\nDej mie rotor: ");
	scanf("%s", fw_key);

	printf("Forward mapping:\n");
	printf("%s\n", alphabet);
	printf("%s\n", fw_key);

	printf("(");
	for(int i = 0; i < 26; i++) {
		printf("%d", fw_key[i] - 'A');
		if(i < 25) {
			printf(",");
		}
	}
	printf(")\n");

	printf("\nbackward mapping:\n");

    //printf("(");
	for(int i = 0; i < 26; i++) {
		size_t idx = get_index(fw_key, i + 'A');
		char letter = alphabet[idx];
		bw_key[i] = letter;
	}
	bw_key[26] = '\0';

	printf("%s\n", alphabet);
	printf("%s\n", bw_key);

	printf("(");
	for(int i = 0; i < 26; i++) {
		printf("%d", bw_key[i] - 'A');
		if(i < 25) {
			printf(",");
		}
	}
	printf(")\n");
}
//iteruj od litery A, znajdz indeks i litery w fw_key, sprawdz alfabet[i]
