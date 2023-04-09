function x = solveLowerTriangle(A, b)
    % solve linear equation with lower triangular matrix
    [n, ~] = size(A);
    x = zeros(n, 1);

    for k = 1 : n
        x(k, 1) = b(k, 1);
        
        for j = 1 : k - 1
            x(k, 1) = x(k, 1) - A(k, j) * x(j, 1);
        end

        x(k, 1) = x(k, 1) / A(k, k);
    end
end