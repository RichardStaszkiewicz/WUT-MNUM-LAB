function [x] = approximateSVD(X, Y, degree)
    A = generate_A3(X, Y, degree);

    [U, S, V] = svd(A);

    sigma = S(1 : size(A, 2), :);
    sigma_plus = [ inv(sigma) zeros(size(A, 2), size(A, 1) - size(A, 2))];
    A_plus = V * sigma_plus * U';
    x = A_plus * Y;
end
