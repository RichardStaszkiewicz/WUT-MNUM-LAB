function [A] = generate_A3(X, Y, degree)
    N = size(Y, 1);
    A = zeros(N, degree + 1);
    for i = 1 : N
        for j = 1 : degree + 1
            A(i, j) = X(i) ^ (j - 1);
        end
    end
end