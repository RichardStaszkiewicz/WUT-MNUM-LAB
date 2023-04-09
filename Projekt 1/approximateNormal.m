function [x] = approximateNormal(X, Y, degree, useGS)
    A = generate_A3(X, Y, degree);
    
    if useGS
        x = GS(A' * A, A' * Y, 1e-8, 1000 * degree);
    else
        x = solveLDLt(A' * A, A' * Y);
    end
end
