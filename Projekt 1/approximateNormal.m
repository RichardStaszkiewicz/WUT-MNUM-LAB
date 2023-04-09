function [a] = approximateNormal(X, Y, degree, useGS)
    A = generate_A3(X, Y, degree);
    
    if useGS
        a = GS(A' * A, A' * Y, 1e-8, 1000 * degree);
    else
        a = solveLDLt(A' * A, A' * Y);
    end
end
