function [x_i, iter] = solverMM2(X, x1, delta, max_iter)
    iter = 0;
    x_i = x1;
    fx = polyval(X, x_i);

    while abs(fx)>delta && iter<max_iter
        iter = iter + 1;
        
        sqrt_d = sqrt(polyval(polyder(X), x_i)^2 - 2 * polyval(polyder(polyder(X)), x_i));

        if abs(polyval(polyder(X), x_i) + sqrt_d) > abs(polyval(polyder(X), x_i) - sqrt_d)
            z = -2*polyval(X, x_i) / (polyval(polyder(X), x_i) + sqrt_d);
        else
            z = -2*polyval(X, x_i) / (polyval(polyder(X), x_i) - sqrt_d);
        end
        x_i = x_i + z;
        fx = polyval(X, x_i);
    end
end