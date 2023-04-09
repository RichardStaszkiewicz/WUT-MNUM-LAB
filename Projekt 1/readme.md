# MNUM Miniprojekt 1
_Richard Staszkiewicz idx. 310918_

<!-- https://snip.mathpix.com/2barti2/notes/f1b9f837-1234-4295-99ed-258c7a7ed446/edit -->

## Dane
### Macierz A

$$
\begin{equation} 
    a_{ij} = \begin{cases}
        2(i + j) + 1, & \text{dla $j ̸= i$}\\
        4n2 + (2i + 4)n \text{dla $j = i$}
    \end{cases}
\end{equation}
$$

Implementacja generacji znajduje się w pliku [Generate_A](generate_A.m)

Przykładowa macierz A dla n = 5:
```
   130     7     9    11    13
     7   140    11    13    15
     9    11   150    15    17
    11    13    15   160    19
    13    15    17    19   170
```

Cechy:Symetryczna, Silna dominacja diagonalna

Dominacja diagonalna została zweryfikowana z pomocą funkcji zaimplementowanej w pliku [testDiagonalDomminance](testDiagonalDomminance.m), która zwróciła dla każdej wartości n wartość True.

### Macierz b

$$
\begin{equation}
  b_{i} = 2.5 + 0.6i
\end{equation}
$$

Implementacja generacji znajduje się w pliku [Generate_B](generate_B.m)

Przykładowa macierz b dla n = 5:
```
    3.1000
    3.7000
    4.3000
    4.9000
    5.5000
```

### Wartości n
n = 5, 10, 25, 50, 100, 200

## Zadanie 1
### Treść
Napisać uniwersalną procedurę w Matlabie o odpowiednich parametrach wejścia i wyjścia (solwer),
rozwiązującą układ n równań liniowych Ax = b, gdzie x, b ∈ Rn, wykorzystując podaną metodę. 
Nie sprawdzać w procedurze, czy dana macierz A spełnia wymagania stosowalności metody. 
Zakazane jest użycie jakichkolwiek solwerów w środku. Obliczyć błąd rozwiązania ε = ∥A˜x − b∥2 (skorzystać
z funkcji norm Matlaba).
Metoda: faktoryzacji LDLT
Proszę wykonać wykresy zależności czasu obliczeń i błędu ε od liczby równań n. Skomentować wyniki

### Rozwiązanie
Z treści wynika że nie należy sprawdzać symetryczności i dodatniego określenia macierzy A.  Wynik zostaje wyznaczony na podstawie rozwiązania układów równań z macierzami trójkątnymi:

$$
Ax = LDL^T x = L(DL^T x) = b
$$

$$
y = DL^T x
$$

$$
Ax = Ly = b
$$

gdzie macierze $L$ i $DL^T$ są macierzami trójkątnymi.

Najpierw rozwiązujemy układ $Ly=b$ w poszukiwaniu $y$, a następnie podstawiamy wyliczoną wartość do układu $DL'x=y$ i rozwiązujemy w poszukiwaniu $x$.
Implementacja funkcji reprezentującej ten algorytm znajduje się w pliku [solveLDLt](solveLDLt.m)

