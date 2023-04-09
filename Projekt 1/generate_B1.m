function [b] = generate_B1(n)
    b = zeros(n, 1);
    for i = 1 : n
        b(i, 1) = 2.5 + 0.6 * i;
    end
end
