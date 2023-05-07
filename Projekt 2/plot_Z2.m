function plot_Z2(X, delta, max_iter)
    [x0, iter] = findPolyZeros(X, delta, max_iter);
    start_plot = -3; %real(min(x0) - mean(abs(x0)));
    end_plot = 3; %real(max(x0) + mean(abs(x0)));
    x = start_plot : 0.001 : end_plot;
    y = zeros(size(x, 2));
    y0 = zeros(length(x0));
    for i = 1:size(x, 2)
        y(i) = polyval(X, x(i));
    end
    for i = 1:length(x0)
        y0(i) = polyval(X, x0(i));
    end

    tiledlayout(1, 1);

    nexttile;
    hold on;
    title("Zadanie 2");
    xlabel("x");
    ylabel("y");
    plot(x, y);
    for i = 1:length(x0)
        if abs(imag(x0(i))) < delta
            scatter(real(x0(i)), real(y0(i)),'blue');
        else
            scatter(real(x0(i)), real(y0(i)), 'red', 'filled');
        end
    end
    legend("Blue dots: Real roots", "Red dots: Complex roots projected to real values");
    hold off;
end