# MNUM Projekt 3
_Richard Staszkiewicz_
_idx. 310918_

## Treść
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
Równania trajektorii zostały zaimplementowane w pliku [dxdt](dxdt.m)

## Algorytmy

### Metoda Rungego–Kutty-Fehlberga

Metoda RKF bierze pod uwagę parę metod włożonych. W tym konkretnym wypadku, są to metody RK odpowiednio czwartego oraz piątego rzędu.
- Metoda RK rzędu czwartego (5 etapowa):
$$
x_{n+1} = x_n + h \sum_{i=1}^5 w_i^* k_i
$$
$$
k_1 = f(t_n, x_n)
$$
$$
k_i = f(t_n + c_i h, x_n + h  \sum_{j=1}^{i-1} a_{ij}k_j), \text{dla i=2,3,...5}
$$

- Metoda RK rzędu 5 (6 etapowa):
$$
x_{n+1} = x_n + h \sum_{i=1}^{6} w_i^* k_i
$$
$$
k_1 = f(t_n, x_n)
$$
$$
k_i = f(t_n + c_i h, x_n + h  \sum_{j=1}^{i-1} a_{ij}k_j), \text{dla i=2,3,...6}
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
439/216 & -8 & 3680/513 & -845/4104 &  0 \\
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
x_{n+1}=x_{n}+\frac{25}{216} k_{1}+\frac{1408}{2565} k_{3}+\frac{2197}{4104} k_{4}-\frac{1}{5} k_{5}
$$

Następna wartość po kroku metody RK5 ma wzór:
$$
z_{n+1}=x_{n}+\frac{16}{135} k_{1}+\frac{6656}{12825} k_{3}+\frac{28561}{56430} k_{4}-\frac{9}{50} k_{5}+\frac{2}{55} k_{6}
$$

Po odjęciu stronami powyższych równań otrzymujemy oszacowanie błędu metody rzędu 4:

$$
\delta_n(h)=h(z_{n+1}-x_{n+1})=h(\frac{1}{360} k_{1}(h)-\frac{128}{4275} k_{3}(h)-\frac{2197}{75240} k_{4}(h)+\frac{1}{50} k_{5}(h)+\frac{2}{55} k_{6}(h) )
$$

Implementacja kroku solvera posługującego się powyższymi równaniami znajduje się w pliku [makeStep](makeStep.m)

### Wyznaczanie zmienionej długości kroku

W trakcie wyznaczania kolejnego kroku $h_{n+1}$ bierze się pod uwagę niedokładności oszacowania błędu, a także stosuje się współczynnik bezpieczeństwa $s$:

$$
h_{n+1} = s \alpha h_n, \text{ gdzie s < 1}
$$

dla RKF zgodnie ze skryptem, przyjmę $s \approx 0.9$. Współczynnik modyfikacji kroku $\alpha$ dla RK4 otrzymuję ze wzoru:

$$
\alpha = min_{1\le i\le k}(\frac{\varepsilon_i}{|\delta_n(h)_i|})^{\frac{1}{5}}, i = 1, 2, ..., k
$$

gdzie:

$$
\varepsilon_i = |(x_i)_n| \varepsilon_w + \varepsilon_b \\
\varepsilon_w \text{ - dokładność względna} \\
\varepsilon_b \text{ - dokładność bezwzględna}
$$

Implementacja powyższego obliczania kroku alpha znajduje się w pliku [stepAlpha](stepAlpha.m).

## Rozwiązanie
Implementację solvera na podstawie schematu ze strony 174 skryptu zrealizowano w pliku [solveRKF](solveRKF.m).

### Badanie trajektorii
Uruchomiono solverRKF i porównano go z rezultatami funkcji ode45 udostępnionej przez matlaba. Otrzymano następujące rezultaty:
```
>> plot_trajectories
ode45:
Elapsed time is 0.051435 seconds.
RKF45:
Elapsed time is 0.135765 seconds.
function	|	iterations
-			|	-
ode45		|	109
RKF45	    |	592
```
![](trajektorie.png)

Implementacja powyższego badania trajektorii znajduje się w pliku [plot_trajectories](plot_trajectories).

### Długość kroku  i estymata błędu vs czas

Zbadano graficznie przebiegi czasowe długości kroku i estymat błędu względnego i bezwzględnego w solverze RKF i otrzymano następujące rezultaty:
![](step_error_time.png)

Implementacja wyświetlania powyższych przebiegów znajduje się w pliku [plot_step_error_time](plot_step_error_time.m)


## Wnioski

### Parametry
* Minimalny krok wyznacza otoczenie rozpatrywanego punktu, w którym nie może być rozpatrywana
 następna iteracja algorytmu, zapobiegając tym samym "utknięciu" na skutek ciągłego zmniejszania kroku.
* Dokładność względna jest miarą tolerancji między rozwiązaniem a propozycją algorytmu i zależy od wartości funkcji w danym punkcie.
* Dokładność bezwzględna jest miarą tolerancji między rozwiązaniem a propozycją algorytmu i nie zależy od wartości funkcji w danym punkcie.
* Dokładność bezwzględna ma większe znaczenie dla wartości bliższych 0, podczas gdy dokładność względna gra większą rolę przy wartościach większych.

### Porównanie z ode45

| **Kategoria** | **RKF45** | **ODE45** | **Porównanie** |
| :---: | :---: | :---: | :---: |
| **Poprawność** | Znalazł poprawny wynik | Znalazł poprawny wynik | Takie same |
| **Efektywność** | 592 kroki | 109 kroków | ODE45 znalazł rozwiązanie w zauważalnie mniejszej ilości kroków |
| **Szybkość** | 0.05 s | 0.13 s | ODE45 szybciej doszło do rozwiązania |


ODE45 bazując na metodzie Dormanda-Prince'a potrzebuje mniej kroków by znaleźć rozwiązanie.
Wyniki czasowe uważam za nieinterpretowalne, ponieważ mimo wyraźnej przewagi solvera ODE45, został on również
z algorytmicznego punktu widzenia zaprojektowany pod współpracę ze środowiskiem MATLAB.



## Pliki

### dxdt.m
```matlab
function dxdt = dxdt(t, x)
    dx1dt = x(2) + x(1) * (0.3 - x(1)^2 - x(2)^2);
    dx2dt = -x(1) + x(2) * (0.3 - x(1)^2 - x(2)^2);

    dxdt = [dx1dt; dx2dt];
end
```

### makeStep.m
```matlab
function [x2, delta] = makeStep(f, t, x1, h)
    k1 = h * f(t, x1);
    k2 = h * f(t + 1/4 * h,     x1 + 1/4 * k1);
    k3 = h * f(t + 3/8 * h,     x1 + 3/32 * k1          + 9/32 * k2);
    k4 = h * f(t + 12/13 * h,   x1 + 1932/2197 * k3     - 7200/2197 * k2    + 7296/2197 * k3);
    k5 = h * f(t + h,           x1 + 439/216 * k1       - 8 * k2            + 3680/513 * k3     - 845/4104 * k4);
    k6 = h * f(t + 1/2 * h,     x1 - 8/27 * k1          + 2 * k2            - 3544/2565 * k3    + 1859/4104 * k4       - 11/40 * k5);

    x2 = x1 + 25/216 * k1 + 1408/2565 * k3 + 2197/4104 * k4 - 1/5 * k5;
    delta = h * (1/360 * k1 - 128/4275 * k3 - 2197/75240 * k4 + 1/50 * k5 + 2/55 * k6);
end
```
### stepAlpha.m
```matlab
function alpha = stepAlpha(x, epsilonW, epsilonB, delta)
    epsilon = abs(x) * epsilonW + epsilonB;
    alpha = min((epsilon ./ abs(delta)) .^ (1/5));
end
```

### solveRKF.m
```matlab
function [tout, xout, hout, dout] = solveRKF(dxdt, tspan, x0, h0, hmin, epsilonW, epsilonB)
    % STAŁE
    s = 0.9;
    % ZMIENNE
    x1 = x0;
    t1 = tspan(1);
    tmax = tspan(2);
    h1 = h0;
    % WYJŚCIE
    tout = t1;
    xout = x1';
    hout = h1;
    dout = zeros(length(x0));
    n = 1;

    while true
        [x2, delta] = makeStep(dxdt, t1, x1, h1);
        alpha = stepAlpha(x1, epsilonW, epsilonB, delta);

        axs = s * alpha;
        hstar = axs * h1;

        if axs >= 1
            if t1 + h1 >= tmax
                return; % osiągnięty koniec przedziału
            else
                t2 = t1 + h1;
                h2 = min([hstar, 5 * h1, tmax - t1]); %  ograniczenie jako heura, beta = 5
                n = n + 1;

                tout(n, 1) = t2;
                xout(n, :) = x2';
                hout(n, 1) = h2;
                dout(n, :) = delta';

                t1 = t2;
                x1 = x2;
                h1 = h2;
            end
        else % zmniejszanie kroku
            if hstar < hmin
                disp("Impossible to solve with given precision"); % osiągnięty krok jest mniejszy niż zadany najmniejszy krok
                return;
            else
                h1 = hstar; % zmniejszenie kroku
            end
        end
    end
end
```

### plot_trajectories.m
```matlab
function plot_trajectories()
    x0 = [0.4; 0.3];
    time_span = [0 20];
    h0 = 1e-4;
    hmin = 1e-6;
    epsilonW = 1e-8;
    epsilonB = 1e-8;

    disp("ode45:");
    tic;
    [tode, xode] = ode45(@dxdt, time_span, x0);
    toc
    disp("RKF45:");
    tic;
    [tdp, xdp, ~, ~] = solveRKF(@dxdt, time_span, x0, h0, hmin, epsilonW, epsilonB);
    toc

    fprintf('function\t|\titerations\n');
    fprintf('-\t\t\t|\t-\n');
    todesize = size(tode);
    tdpsize = size(tdp);
    fprintf('ode45\t\t|\t%0.f\n', [todesize(1)]);
    fprintf('RKF45\t|\t%0.f\n', [tdpsize(1)]);

    tiledlayout(2, 2);

    nexttile;
    hold on;
    title('Trajektoria x_1(t)');
    xlabel('t');
    ylabel('x_1(t)');
    plot(tode, xode(:, 1));
    plot(tdp, xdp(:, 1));
    legend('ode45', 'RKF45');
    hold off;

    nexttile([2, 1]);
    hold on;
    title('Trajektoria (x_1, x_2)');
    xlabel('x_1');
    ylabel('x_2');
    plot(xode(:, 1), xode(:, 2));
    plot(xdp(:, 1), xdp(:, 2));
    legend('ode45', 'RKF45');
    hold off;

    nexttile;
    hold on;
    title('Trajektoria x_2(t)');
    xlabel('t');
    ylabel('x_2(t)');
    plot(tode, xode(:, 2));
    plot(tdp, xdp(:, 2));
    legend('ode45', 'RKF45');
    hold off;
end
```

### plot_step_error_time.m
```matlab
function plot_step_error_time()
    x0 = [0.4; 0.3];
    time_span = [0 20];
    h0 = 1e-4;
    hmin = 1e-6;
    epsilonW = 1e-8;
    epsilonB = 1e-8;


    [tdp, ~, hdp, ddp] = solveRKF(@dxdt, time_span, x0, h0, hmin, epsilonW, epsilonB);
    
    tiledlayout(2, 1);

    nexttile;
    hold on;
    title('Step vs time');
    xlabel('t');
    ylabel('h(t)');
    plot(tdp, hdp);
    hold off;

    nexttile;
    hold on;
    title('Error vs time');
    xlabel('t');
    ylabel('delta_n(t)');
    plot(tdp, ddp(:, 1));
    plot(tdp, ddp(:, 2));
    hold off;
end
```
