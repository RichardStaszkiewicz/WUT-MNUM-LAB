# MNUM Miniprojekt 1
_Richard Staszkiewicz idx. 310918_

<!-- https://snip.mathpix.com/2barti2/notes/f1b9f837-1234-4295-99ed-258c7a7ed446/edit -->

## Dane
### Macierz A

$$
\begin{equation}
  a_{ij} = \begin{cases}
    2 (i + j) + 1, & \text{dla $j \neq i $}\\
    4n^2 + (2i + 4) n, & \text{dla $j = i$}\\
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

#### Metoda faktoryzacji $LDL^T$

Algorytm faktoryzacji najłatwiej osiągnąć poprzez przedstawienie macierzy $A$ jako iloczyn macierzy $L$ oraz $DL^T$, gdzie $L$ jest macierzą trójkątną dolną z jedynkami na diagonali a $D$ jest macierzą diagonalną.

$$
\begin{bmatrix}
    a_{11} & a_{12} & ... & a_{1n} \\
    a_{21} & a_{22} & ... & a_{2n} \\
    ... & ... & ... & ... \\
    a_{n1} & a_{n2} & ... & a_{nn} \\
\end{bmatrix}
=
\begin{bmatrix}
    1 & 0 & ... & 0 \\
    \overline{l}_{21} & 1 & ... & 0 \\
    ... & ... & ... & ... \\
    \overline{l}_{n1} & \overline{l}_{n2} & ... & 1 \\
\end{bmatrix}
 \begin{bmatrix}
    d_{11} & d_{12} \overline{l}_{21} & ... & d_{1n} \overline{l}_{n1} \\
    0 & d_{22} & ... & d_{2n} \overline{l}_{n2} \\
    ... & ... & ... & ... \\
    0 & 0 & ... & d_{nn} \\
\end{bmatrix}
$$

Kolejno rozwiązując równania skalarne jesteśmy w stanie przedstawić to działanie w postaci algorytmu.


Algorytm:

$$
d_{ii} = a_{ii} - \sum_{k = 1}^{i-1} {\overline{l}_{ik}^2 d_{kk}}
$$

$$
\overline{l}_{ji} = ({a_{ji} -  \sum_{k=1}^{i-1} {\overline{l}_{jk} d_{kk} \overline{l}_{ik}}}) / d_{ii}, i = 1, ..., n, j = i + 1, ..., n
$$

Implementacja powyższego algorytmu znajduje się w pliku [factorize_LDLt](factorize_LDLt.m).

#### Macierz trójkątna dolna
Mając podane równanie $Ax = b$ wartości $x$ można wyznaczać iteracyjnie za pomocą kolejnych równań liniowych z jedną niewiadomą za pomocą algorytmu:

$$
x_1 = \frac{b_1}{a_{11}}
$$

$$
x_k = \frac{b_k - \sum_{j = 1}^{k - 1} {a_{kj} x_j}}{a_{kk}}, k = 2, 3, ..., n
$$

Implementacja powyższego algorytmu znajduje się w pliku [solveLowerTriangle](solveLowerTriangle.m)

#### Macierz trójkątna górna
Podobnie jak część dolną, mając podane równanie $Ax = b$ wartości $x$ można wyznaczać iteracyjnie za pomocą kolejnych równań liniowych z jedną niewiadomą za pomocą algorytmu:

$$
x_n = \frac{b_n}{a_{nn}}
$$

$$
x_k = \frac{b_k - \sum_{j = k + 1}^{n} {a_{kj} x_j}}{a_{kk}}, k = n - 1, n - 2, ..., 1
$$

Implementacja powyższego algorytmu znajduje się w pliku [solveUpperTriangle](solveUpperTriangle.m)

### Obliczanie błędu i reprezentacja graficzna
Wykorzystując wzór na błąd Epsilon od liczby równań n w postaci $\varepsilon = ∥A\tilde{x} − b∥_2$ i funkcji wbudowanych Matlaba do wizualizacji otrzymano następujące przebiegi:


Implementacja powyższej wizualizacji znajduje się w pliku [plotZ1Epsilon](plotZ1Epsilon.m)
