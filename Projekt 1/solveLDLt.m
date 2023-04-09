function x = solveLDLt(A, b)
        % solve using LDL' decomposition
        % A = LDL'
        [L, D] = LDLt(A);
        % First solve equation Ly = b for y
        % L - lower triangular matrix
        y = solveLowerTriangle(L, b);
        % Then solve equation DL' x = y for x
        % DL' - upper triangular matrix
        x = solveUpperTriangle(D * L', y);
end