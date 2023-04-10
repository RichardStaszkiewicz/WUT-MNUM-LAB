function [L, D] = factorizeLDLt(A)
    [n, ~] = size(A);
    L = zeros(n, n);
    D = zeros(n, n);
    
    for i = 1 : n
        L(i, i) = 1;
        D(i, i) = A(i, i);

        for k = 1 : i - 1
            D(i, i) = D(i, i) - L(i, k) ^ 2 * D(k, k);
        end
        
        for j = i + 1 : n
            L(j, i) = A(j, i);
            for k = 1 : i - 1
                L(j, i) = L(j, i) - L(j, k) * D(k, k) * L(i, k);
            end
            L(j, i) = L(j, i) / D(i, i);
        end
    end
end
