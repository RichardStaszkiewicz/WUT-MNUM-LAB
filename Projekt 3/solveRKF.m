function [tout, xout, hout, dout] = solveRKF(dxdt, tspan, x0, h0, hmin, epsilonW, epsilonB)
    %   ========= REALIZACJA ZGODNIE Z AUTOMATEM ZE STRONY 174 SKRYPTU ====
    %
    %
    %   CEL
    %       Wyznaczanie rozwiązania układu równań różniczkowych zwyczajnych
    %       przy podanej wartości rozwiązania w punkcie początkowym
    %  
    %   PARAMETRY WEJSCIOWE
    %       dxdt   -  funkcja przyjmująca jako parametry czas oraz wartości
    %                 w punkcie, a zwracająca pochodną dx/dt 
    %       t0     -  wektor dwu wartościowy - przedział poszukiwania
    %                 rozwiązania
    %       x0     -  wektor punktów startowych  
    %       h0     -  początkowa wartość kroku
    %       hmin   -  ustalona minimalna wielkość kroku - poniżej tego
    %                 kroku kończymy program - uznajemy, że nie da się
    %                 znaleźć wyniku z zadaną dokładnością
    %       epsilonW - wartość dozwolonego błędu względnego
    %       epsilonB - wartość dozwolonego błędu bezwzględnego
    %
    %   PARAMETRY WYJSCIOWE
    %       tout   -  wektor kolejnych wartości czasu t 
    %       xout   -  macierz kolejnych wartości x w kolejnych iteracjach
    %                 algorytmu
    %       hout   -  wektor kroków w kolejnych iteracjach algorytmu
    %       dout   -  macierz szacowanych błędów dla wartości x w kolejnych
    %                 iteracjach algorytmu
    %
    %   PRZYKLADOWE WYWOLANIE
    %       >> [tout, xout, hout, dout] = dorpri45(@trajectory, [0 20], [0; 13], 1e-4, 1e-6, 1e-8, 1e-8)
    %
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
