# Computer Architecture

### ZAD 1
Napisać program, który:
- od nowej linii
- wyświetla imię i nazwisko studenta – uwzględniając małe i duże litery
- za pomocą przerwania dosowego ah, 2
- przerwać działanie programu za pomocą ah, 1

### ZAD 2
Zmodyfikuj swój program z poprzednich zajęć, tak aby, po wprowadzeniu jednego znaku ASCII z klawiatury program wyświetlił na ekranie dla wartości (znaku ASCII) większej od 90 -nazwisko, a dla mniejszej wartości znaku ASCII - imię.

### ZAD 3b
Napisać program, który sprawdza czy w imieniu lub nazwisku znajdują się niedozwolone znaki i wyświetla odpowiedni komunikat

### ZAD 3
Pobierz dwie cyfry a i b z klawiatury za pomocą przerwania 21h
i wykonaj poniższe operacje:

1. Dodaj a i b   i wyświetl wynik w postaci znaku ASCII
2. Odejmij a i b   i wyświetl wynik w postaci znaku ASCII
3. Pomnóż a i b   i wyświetl wynik w postaci znaku ASCII
4. Podziel a przez b   i wyświetl wynik w postaci znaku ASCII

*  Wyświetl wykrzyknik, jeśli b wynosi 0 w miejscu wyniku dzielenia.
*  Oddziel wyniki spacją.
*  Odejmij od symboli ASCII przesunięcie.

### ZAD 4
Przepisz ZAD 3, aby generowało identyczny wynik, ale wykorzystując procedury dodawania, odejmowania, mnożenia i dzielenia. Zamiast wykorzystywać zmiennych do operacji arytmetycznych proszę korzystać ze stosu.

* Można wyłącznie przetrzymywać argumenty a i b w zmiennych.
## ZAD 5

•Napisz program do liczenia silni, liczby jednocyfrowej* wprowadzanej z klawiatury, wynik wyświetlaj w systemie dziesiętnym za pomocą znaków ASCII.
* Stosuj procedury

* Stosuj stos

* Do wartości 8  - arytmetyka 16 bitowa
### ZAD 6

Napisz program, który pobierze do 25 znaków ASCII z klawiatury za pomocą ah,10. Następnie pobierze przesunięcie szyfru Cezara, i wyświetli komunikat zakodowany.

* Zapętl alfabet, konwertuj duże litery do małych. Wszystkie inne znaki zamień na spację. Wyświetlanie komunikatów zrealizuj za pomocą ah,9.

Na ocenę bdb:

*  Program ma wczytywać argument do przesunięcia w postaci liczby dziesiętnej z zakresu 16 bitowego, wielokrotność alfabetu rozwiąż za pomocą dzielenia modulo.
*  Zaprogramuj pełne menu. Powitanie, wybór opcji, wielokrotne kodowanie, zakończenie programu. Pamiętaj o wypełnianiu tablicy dolarami…

## Projekt
Napisać program, który pobiera z wejścia dwa łańcuchy znakowe, a następnie sprawdza, czy zawierają tą samą liczbę liter, wypisując na ekran stosowny komunikat. Program powinien móc wielokrotnie powtarzać operację z różnymi ciągami znaków oraz zakończyć pracę po naciśnięciu przez użytkownika klawisza ENTER. Wykorzystać procedury i stos. Przewidzieć sytuacje wyjątkowe.
