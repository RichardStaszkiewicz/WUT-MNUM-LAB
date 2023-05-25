function plot_step_error_time()
    x0 = [0.4; 0.3];
    time_span = [0 20];
    h0 = 1e-4;
    hmin = 1e-6;
    epsilonW = 1e-8;
    epsilonB = 1e-8;


    [tdp, ~, hdp, ddp] = solveRKF(@dxdt, time_span, x0, h0, hmin, epsilonW, epsilonB);
    
    tiledlayout(2, 1);
    
    % Zależność długości kroku od czasu
    nexttile;
    hold on;
    title('Step vs time');
    xlabel('t');
    ylabel('h(t)');
    plot(tdp, hdp);
    hold off;

    % Zależność estymaty błędu od czasu
    nexttile;
    hold on;
    title('Error vs time');
    xlabel('t');
    ylabel('delta_n(t)');
    plot(tdp, ddp(:, 1));
    plot(tdp, ddp(:, 2));
    hold off;
end
