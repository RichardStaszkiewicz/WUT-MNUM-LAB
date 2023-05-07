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

W pliku [function1](function1.m) została zaimplementowana funkcja z zadania.

### Reguła Falsi
Przy zadanej funkcji $f$ ciągłej na przedziale $[a, b]$ przyjmującej na granicach przedziału różne znaki,
można zastosować regułę falsi do znalezienia miejsca zerowego. Iteracyjnie wyznacza się punkt przecięcia c odcinka łączącego
punkty $(a, f(a))$ oraz $(b, f(b))$ z osią OX za pomocą wzoru

$$
c = \frac{af(b) - bf(a)}{f(b) - f(a)}
$$

W następnym kroku rozpatrujemy ten przedział ze zbioru ${[a, c], [c, b]}$ który ma ujemny iloczyn (granice przedziału o różnych znakach).
Kryterium stopu jest $f(c) < \delta $ gdzie $\delta$ jest dokładnością. Implementacja powyższego algorytmu jest reprezentowana solverem (solverFalsi)[solverFalsi.m].

Sprawdzono zadaną funkcję i dla krańców przedziału $[2, 11]$ otrzymano odpowiednio wartości $[-4.6036, -5.0228]$.
Przedział sam w sobie nie spełnia więc założeń użycia reguły falsi. Z pomocą analizy graficznej narzędziem wolfram alpha stwierdzono także występowanie w tym przedziale 2 miejsc zerowych.

### Metoda Newtona
Metoda Newtona aproksymuje funkcję docelową funkcją liniową wyznaczaną poprzez niepełny szereg Taylora w aktualnym punkcie $x_{i}$ z pomocą wzoru

$$
f(x) \approx f(x_i) + f'(x_i)(x - x_i) 
$$

Kolejny punkt $x_{i+1}$ jest wyliczany z przyrównania do zera aproksymacji liniowej funkcji $f(x)$:

$$
f(x_i) + f'(x_i)(x_{i+1} - x_i) = 0
$$

wyznaczając $x_{i+1}$ otrzymujemy:

$$
x_{i+1} = x_n - \frac{f(x_i)}{f'(x_i)}
$$

Implementacja została udostępniona przez Prowadzącego i znajduje się w pliku (newton)[newton.m].

### Przedziały izolacji pierwiastków
Znajdowanie przedziałów izolacji pierwiastków funkcji jest stosunkowo proste i działa na zasadzie zmodyfikowanego algorytmu gąsienicy. Mając zatany krok $\beta$ i granice badanego przedziału $[a, b]$
iteracyjnie wyznaczamy najmniejszy przedział taki że jego krańce są przeciwnych znaków a pochodna nie jest na krańcach równa 0. 

Algorytm izolacji pierwiastków zaimplementowano w pliku [isolation](isolation.m).

### Rozwiązanie
Rezultaty uzyskane przez poszczególne solvery reprezentuje tabela i grafika uzyskana na podstawie procedury [plot_Z1.m](plot_Z1).

![](Z1.png)

_*Falsi*_
| X  | Y  | Iter  | Time  | a  | b  |
|---|---|---|---|---|---|
| 5.0707  | -0.0000 | 100.0000  |  0.0074  |  3.4700  |  5.0800 |
| 7.5795  |  0.0000 | 100.0000  |  0.0011  |  6.4300  |  7.5800 |

_*Newton*_
| X  | Y  | Iter  | Time  | x0 |
|---|---|---|---|---|
| 5.0707  | 0.0000  |  100  |  0.0013  |  6 |
|   7.5795  |  0.0000  | 100  |  0.0001  |  9 |

### Wnioski
Obie metody sprawnie znalazły miejsca zerowe funkcji, przy podobnej ilości iteracji. Metoda Newtona jest minimalnie szybsza licząc executoin time.
Metoda Falsi może zawieść (długo zbiegać) jeśli:
* Jeden z końców przedziałów nie zmienia się przy wielu iteracjach.
_Rozwiązaniem powyższego problemu byłoby zastosowanie algorytmu Illinois ze zbieżnością superliniową._

Metoda Newtona może zawieść (nie znaleźć najbliższego pierwiastka w otoczeniu) jeśli:
* Sotsujemy ją poza obszarem atrakcji pierwiastka
* W okolicy punktu testowego pochoda jest bliska 0 (oddala się wówczas algorytm znacznie od punktu startowego).

## Zadanie 2

### Treść
Używając metody *Mullera MM2* proszę znaleźć wszystkie pierwiastki wielomianu czwartego stopnia:
$$
f(x) = a_{4}x^4 + a_{3}x^3 + a_{2}x^2 + a_{1}x + a_0, [a_4, a_3, a_2, a_1, a_0] = [2, \frac{1}{2}, -5, 2, -3]
$$

### Metoda Mullera 2
Na podstawie wartości wielomianu w zadanym punkcie startowym $x_k$ oraz informacji o jego pierwszej i drugiej pochodnej, MM2 iteracyjnie poprawia położenie do czasu osiągnięcia pierwiasta wielomianu z zadaną dokładnością zgodnie ze wzorem
$$
z_{+,-} = \frac{-2f(x_k)}{f'(x_k)\pm\sqrt{(f'(x_k))^2 - 2f(x_k)f''(x_k)}}
z_{min} = min{z_+, z_-}
x_{k + 1} = x_k + z_{min}
$$

Ponieważ pierwiastki wielomianu mogą być wielokrotne i zespolone, należy w metodzie uwzględnić arytmetykę liczb zespolonych.
Implementacja podstawowego algorytmu MM2 do znajdywania pojedyńczego pierwiastka została zrealizowana w pliku [solverMM2](solverMM2.m).

### Deflacja czynnikiem liniowym
Jej realizacją jest prosty algorytm implementujący schemat Hornera na podstawie wzoru $q_i = a_i + q_{i + i} * \alpha. Jest on zaimplementowany jako elemnet funkcji [findPolyZeros](findPolyZeros.m).
