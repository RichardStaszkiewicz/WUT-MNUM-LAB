function [A] = generate_A2(n)
    A = zeros(n, n);

    for i = 1 : n
        A(i, i) = -12;
    end
    
    for i = 2 : n
        A(i, i - 1) = 4.5;
        A(i - 1, i) = 4.5;
    end

    for i = 3 : n
        A(i, i - 2) = 4.5;
        A(i - 2, i) = 4.5;
    end
end