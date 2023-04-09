function plotZ1Epsilon(iter)
    N = [5 10 25 50 100 200];
    % iter = 5;

    EA = zeros(size(N));
    TA = zeros(size(N));

    for k = 1 : iter
        epsilonsA = zeros(size(N));
        timesA = zeros(size(N));
    
        i = 1;
        for n = N
            A = generate_A(n);
            b = generate_B(n);
            [epsilonsA(i), timesA(i)] = solveAndGetEpsilon(A, b);
            i = i + 1;
        end
        EA = EA + epsilonsA;
        TA = TA + timesA;
    end

    EA = EA / iter;
    TA = TA / iter;

    tiledlayout(2, 1);
    
    nexttile
    plot(N, EA);
    title('Błąd Epsilon od liczby równań n');
    xlabel('n');
    ylabel('epsilon');

    nexttile
    plot(N, TA);
    title('Czas wykonania od liczby równań n');
    xlabel('n');
    ylabel('czas');
end

function [epsilon, time] = solveAndGetEpsilon(A, b)
    tic
    x = solveLDLt(A, b);
    time = toc;
    epsilon = norm(A * x - b, 2);
end
