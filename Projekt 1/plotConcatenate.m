function [EA_GS1, EA_GS2] = plotConcatenate(iter)
    N = [5 10 25 50 100 200];
    [EA1, TA1] = analyzeAlgorithm(@generate_A1, @generate_B1, iter, @solveAndGetEpsilonLDLt, N);
    [EA2, TA2] = analyzeAlgorithm(@generate_A2, @generate_B2, iter, @solveAndGetEpsilonLDLt, N);
    [EA_GS1, TA_GS1] = analyzeAlgorithm(@generate_A1, @generate_B1, iter, @solveAndGetEpsilonGS, N);
    [EA_GS2, TA_GS2] = analyzeAlgorithm(@generate_A2, @generate_B2, iter, @solveAndGetEpsilonGS, N);
    tiledlayout(2, 1);
    
    nexttile
    plot(N, EA1, N, EA2, N, EA_GS1, N, EA_GS2);
    legend('LDLt: Zad 1', 'LDLt: Zad 2', 'GS: Zad 1', 'GS: Zad 2');
    title('Błąd Epsilon od liczby równań n');
    xlabel('n');
    ylabel('epsilon');
    set(gca, 'YScale', 'log')

    nexttile
    plot(N, TA1, N, TA2, N, TA_GS1, N, TA_GS2);
    legend('LDLt: Zad 1', 'LDLt: Zad 2', 'GS: Zad 1', 'GS: Zad 2');
    title('Czas wykonania od liczby równań n');
    xlabel('n');
    ylabel('czas');
    set(gca, 'YScale', 'log')
end

function [EA, TA] = analyzeAlgorithm(generate_A, generate_B, iter, solveAndGetEpsilon, N)
    EA = zeros(size(N));
    TA = zeros(size(N));

    for k = 1 : iter
        epsilonsA = zeros(size(N));
        timesA = zeros(size(N));
    
        i = 1;
        for n = N
            A = generate_A(n);
            b = generate_B(n);
            [epsilonsA(i), timesA(i)] = solveAndGetEpsilon(A, b, n);
            i = i + 1;
        end
        EA = EA + epsilonsA;
        TA = TA + timesA;
    end

    EA = EA / iter;
    TA = TA / iter;
end

function [epsilon, time] = solveAndGetEpsilonLDLt(A, b, ~)
    tic
    x = solveLDLt(A, b);
    time = toc;
    epsilon = norm(A * x - b, 2);
end

function [epsilon, time] = solveAndGetEpsilonGS(A, b, n)
    tic
    x = GS(A, b, 1e-8, n * 1000);
    time = toc;
    epsilon = norm(A * x - b, 2);
end
