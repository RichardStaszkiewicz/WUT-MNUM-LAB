function [b] = generate_B2(n)
    b = zeros(n, 1);
    for i = 1 : n
        b(i, 1) = -3.5 + 0.5 * i;
    end
end