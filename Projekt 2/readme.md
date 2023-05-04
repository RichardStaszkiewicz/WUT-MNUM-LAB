# MNUM Miniprojekt 2
_Richard Staszkiewicz idx. 310918_

## Zadanie 1

### Treść
Proszę znaleźć wszystkie pierwiastki funkcji 
$$
f(x) = 2.2xcos(x) - 2ln(x+2)
$$
w przedziale [2, 11] używając
a) własnego solwera z implementacją metody reguły *falsi*
b) podanego na stronie przedmiotu solwera newton.m z implementacją metody Newtona.

### Rozwiązanie

W pliku [function1](function1.m) została zaimplementowana funkcja z zadania.

#### Reguła Falsi
Przy zadanej funkcji $f$ ciągłej na przedziale $[a, b]$ przyjmującej na granicach przedziału różne znaki,
można zastosować regułę falsi do znalezienia miejsca zerowego. Iteracyjnie wyznacza się punkt przecięcia c odcinka łączącego
punkty $(a, f(a))$ oraz $(b, f(b))$ z osią OX za pomocą wzoru

$$
c = \frac{af(b) - bf(a)}{f(b) - f(a)}
$$

W następnym kroku rozpatrujemy ten przedział ze zbioru ${[a, c], [c, b]}$ który ma ujemny iloczyn (granice przedziału o różnych znakach).
Kryterium stopu jest $f(c) < \delta$ gdzie $\delta$ jest dokładnością.

Sprawdzono zadaną funkcję i dla krańców przedziału $[2, 11]$ otrzymano odpowiednio wartości $[-4.6036, -5.0228]$.
Przedział nie spełnia więc założeń użycia reguły falsi. Z pomocą analizy graficznej narzędziem wolfram alpha stwierdzono także występowanie w tym przedziale 2 miejsc zerowych.
W celu analizy algorytmu, dokonano rozbicia przedziału z pomocą wyznaczania przedziałów izolacji pierwiastków zaimplementowanego w pliku [isolation](isolation.m).

Dla każdego elementu zmodyfikowanego zbioru uruchomiono solver [solverFalsi](solverFalsi.m) i otrzymano następujące miejsca zerowe: []

