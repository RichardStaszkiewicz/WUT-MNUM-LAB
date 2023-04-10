function x = solveLDLt(A, b)
        % A = LDL'
        [L, D] = factorizeLDLt(A);
        % solve equation Ly = b for y
        y = solveLowerTriangle(L, b);
        % solve equation DL' x = y for x
        x = solveUpperTriangle(D * L', y);
end