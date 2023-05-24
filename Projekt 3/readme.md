# MNUM Projekt 3
_Richard Staszkiewicz_
_idx. 310918_

# Treść
Ruch punktu na płaszczyźnie ($x_1$, $x_2$) jest opisany równaniami:

$$
\frac{dx_1}{dt} = x_2 + x_1 (0.3 - x_1^2 - x_2^2)
$$

$$
\frac{dx_1}{dt} = - x_1 + x_2  (0.3 - x_1^2 - x_2^2)
$$

Należy obliczyć przebieg trajektorii ruchu tego punktu w przedziale [0, 20] dla warunków początkowych: $x_1(0) = 0.4$, $x_2(0) = 0.3$.

Rozwiązanie proszę znaleźć korzystając z zaimplementowanej przez siebie w języku Matlaba w formie
funkcji (możliwie uniwersalnej, czyli solwera, o odpowiednich parametrach wejścia i wyjścia) metody
Rungego–Kutty-Fehlberga czwartego rzędu przy zmiennym kroku z szacowaniem błędu
techniką pary metod włożonych (RKF45)

## Równania trajektorii
```matlab
function dxdt = dxdt(t, x)
    dx1dt = x(2) + x(1) * (0.3 - x(1)^2 - x(2)^2);
    dx2dt = -x(1) + x(2) * (0.3 - x(1)^2 - x(2)^2);

    dxdt = [dx1dt; dx2dt];
end
```

## Algorytmy

### Metoda Rungego–Kutty-Fehlberga

Metoda RKF bierze pod uwagę parę metod włożonych. W tym konkretnym wypadku, są to metody RK odpowiednio czwartego oraz piątego rzędu.
- Metoda RK rzędu czwartego (6 etapowa):
$$
x_{n+1} = x_n + h \sum_{i=1}^6 w_i^* k_i
$$
$$
k_1 = f(t_n, x_n)
$$
$$
k_i = f(t_n + c_i h, x_n + h  \sum_{j=1}^{i-1} a_{ij}k_j), \text{dla i=2,3,...6}
$$

- Metoda RK rzędu 5 (7 etapowa):
$$
x_{n+1} = x_n + h \sum_{i=1}^{7} w_i^* k_i
$$
$$
k_1 = f(t_n, x_n)
$$
$$
k_i = f(t_n + c_i h, x_n + h  \sum_{j=1}^{i-1} a_{ij}k_j), \text{dla i=2,3,...7}
$$

W obu metodach współczynniki $w_i^*$ i $w_i$ są różne, ale równe są współczynniki $c_i$ oraz $a_{ij}$ dla $j = 1, ..., i-1, i = 2, ..., m$. Wobec powyższego $k_i$ są równe dla $i = 1,..., m$.

$$
C = \begin{bmatrix}
0 & 1/4 & 3/8 & 12/13 & 1 & 1/2\\
\end{bmatrix}
$$

$$
A = \begin{bmatrix}
0 & 0 &     0 &     0 &     0 \\
1/4 & 0 &     0 &     0 &     0 \\
3/32 &  9/32 &   0 &     0 &     0 \\
1932/2197 & -7200/2197  &  7296/2197 &  0 &     0 \\
438/216 & -8 & 3680/513 & -845/4104 &  0 \\
-8/27 &  2 &  -3544/2565 & 1859/4104 & -11/40 \\
\end{bmatrix}
$$

$$
W^* = \begin{bmatrix}
25/216 & 0 & 1408/2565 & 2197/4104& -1/5 & 0 \\
\end{bmatrix}
$$

$$
W = \begin{bmatrix}
16/135 & 0 & 6656/12825 & 28561/56430 & -9/50 & 2/55 \\
\end{bmatrix}
$$

Podstawiając do wzorów otrzymujemy następujące wzory na współczynnik k:
$$
k_{1} = h f(t_{n}, x_{n})
$$

$$
k_{2} = h f(t_{n}+\frac{1}{4} h, x_{n}+\frac{1}{4} k_{1})
$$

$$
k_{3} = h f(t_{n}+\frac{3}{8} h, x_{n}+\frac{3}{32} k_{1}+\frac{9}{32} k_{2})
$$

$$
k_{4} = h f(t_{n}+\frac{12}{13} h, x_{n}+\frac{1932}{2197} k_{1}-\frac{7200}{2197} k_{2}+\frac{7296}{2197} k_{3})
$$

$$
k_{5} = h f(t_{n}+h, x_{n}+\frac{439}{216} k_{1}- 8 k_{2}+\frac{3680}{513} k_{3}-\frac{845}{4104} k_{4})
$$

$$
k_{6} = h f(t_{n}+\frac{1}{2} h, x_{n}-\frac{8}{27} k_{1}+ 2 k_{2}-\frac{3544}{2565} k_{3}+\frac{1859}{4104} k_{4}-\frac{11}{40} k_{5})
$$

Następna wartość po kroku metody RK4 ma wzór:
$$
x_{n+1}=x_{n}+\frac{35}{384} k_{1}+\frac{500}{1113} k_{3}+\frac{125}{192} k_{4}-\frac{2187}{6784} k_{5}+\frac{11}{84} k_{6}
$$

Następna wartość po kroku metody RK5 ma wzór:
$$
z_{n+1}=x_{n}+\frac{5179}{57600} k_{1}+\frac{7571}{16695} k_{3}+\frac{393}{640} k_{4}-\frac{92097}{339200} k_{5}+\frac{187}{2100} k_{6}+\frac{1}{40} k_{7}
$$

Po odjęciu stronami powyższych równań otrzymujemy oszacowanie błędu metody rzędu 4:

$$
\delta_n(h)=h(z_{n+1}-x_{n+1})=h(-\frac{71}{57600} k_{1}(h)+\frac{71}{16695} k_{3}(h)-\frac{71}{1920} k_{4}(h)+\frac{17253}{339200} k_{5}(h)-\frac{22}{525} k_{6}(h)+\frac{1}{40} k_{7}(h))
$$





