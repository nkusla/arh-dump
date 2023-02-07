# Arhitektura računara repozitorijum

U ovom repozitorijumu se nalaze rešenja zadataka sa vežbi iz predmeta _Arhitektura računara_, pored toga sačuvana su i rešenja nekih kolokvijuma od prošlih godina.

## Instalacija i kompajliranje na Debian/Ubuntu distribucijama

Na Debian/Ubuntu distribuciji potrebno je u terminalu pokrenuti sledeću komandu i instalirati sledeće pakete:
```
sudo apt install gcc gcc-multilib ddd
```

Kod kompajliranja je potrebno navesti `-m32` flag, kako bi `gcc` kompajler izvršio kompajliranje za 32-bitnu arhitekturu:
```
gcc -m32 <ime_fajla>.S
```