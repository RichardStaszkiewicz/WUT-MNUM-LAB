function [roots, iterations] = findPolyZeros(X, delta, max_iter)
    degree = length(X) - 1;
    roots = zeros(degree, 1);
    iterations = zeros(degree, 1);

    for i = 1:degree
        [roots(i), iterations(i)] = solverMM2(X, 0, delta, max_iter);

        % Horner
        n = length(X);
        new_X = zeros(n, 1);
        for j = 2:n
            new_X(j) = X(j - 1) + new_X(j - 1) * roots(i);
        end

        X = new_X;
    end

    
end