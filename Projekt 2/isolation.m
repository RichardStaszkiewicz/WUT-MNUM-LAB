function X = isolation(f, a, b, step)
    syms X
    
    % funkcja pochodnej
    df = matlabFunction(diff(f(X), X));
    
    % się przechodzimy od początku przedziału
    x1 = a;
    x2 = a+step;
    
    zeros_found = 1;
    X = zeros(2, 0);
    
    while x2 <= b
        if f(x1) * f(x2) < 0 % pierwiastek znajduje się w przedziale
            while sign(df(x1)) ~= sign(df(x2)) && df(x1) ~= 0
                x1 = x1 + step; % dociągnij za lokalne ekstremum
            end
            X(1, zeros_found) = x1;
            X(2, zeros_found) = x2;
            zeros_found = zeros_found + 1;
            x1 = x2;
            x2 = x2 + step;
        else
            x2 = x2 + step;
        end
    end
end