function [found_zeros, falsi_results, newton_results] = plot_Z1()
    a = 2;
    b = 11;
    start_plot = 0;
    end_plot = 20;
    x = start_plot : 0.1 : end_plot;
    f = @ (x) function1(x);
    delta = eps;
    imax = 100;
    I = isolation(f, a, b, 0.01);
    falsi_results = zeros(6, size(I, 2));
    rg = start_plot : end_plot;
    found_zeros = zeros(1, size(rg, 2));
    newton_results = zeros(5, size(rg, 2));

    for i = 1:size(x, 2)
        y(i) = f(x(i));
    end

    tiledlayout(2, 1);

    nexttile;
    hold on;
    title("Metoda Falsi");
    xlabel("x");
    ylabel("y");
    xline(a, '--r', "początek przedziału");
    xline(b, '--r', "koniec przedziału");

    plot(x, y);
    plot(x, zeros(length(x), 1), "k");
    for i = 1 : size(I, 2)
        xline(I(1, i), ':b');
        xline(I(2, i), ':b');
        [xf, ff, falsi_results(3, i), falsi_results(4, i)] = solverFalsi(f, I(1, i), I(2, i), delta, imax);
        falsi_results(1, i) = xf;
        falsi_results(2, i) = ff;
        falsi_results(5, i) = I(1, i);
        falsi_results(6, i) = I(2, i);
        scatter(xf, ff);
    end
    hold off;


    nexttile;
    hold on;
    title('Metoda Newtona');
    xlabel('x');
    ylabel('y');
    xline(a, '--r', "początek przedziału");
    xline(b, '--r', "koniec przedziału");
    plot(x, y);
    plot(x, zeros(length(x), 1));
    for i = 1 : size(rg, 2)
        [xf, ff, iexe, texe] = newton(f, rg(i), delta, imax);
        newton_results(1, i) = xf;
        newton_results(2, i) = ff;
        newton_results(3, i) = iexe;
        newton_results(4, i) = texe;
        newton_results(5, i) = rg(i);
        found_zeros(1, i) = xf;
    end
    found_zeros = unique(found_zeros);
    found_zeros = found_zeros(found_zeros==real(found_zeros));
    found_zeros = found_zeros(found_zeros >= a & found_zeros <= b);
    scatter(found_zeros, 0);
    hold off;
    

end