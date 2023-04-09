function d = testDiagonalDomminance(A)
    [n, ~] = size(A);
    d = true;
    for i = 1 : n
        if (sum(abs(A(i, :))) - abs(A(i, i))) > abs(A(i, i))
            d = false;
        end
    end
end
% Sprawdza dominację diagonalną
% A - macierz symetryczna
% d - czy macierz A ma dominację diagonalną?