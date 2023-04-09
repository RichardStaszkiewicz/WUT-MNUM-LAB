function [A] = generate_A1(n)
    A = zeros(n, n);

    for i = 1 : n
        for j = 1 : n
            A(i, j) = 2 * (i + j) + 1;
        end
    end
    
    for i = 1 : n
        A(i, i) = 4 * n * n + (2 * i + 4) * n;
    end
end
