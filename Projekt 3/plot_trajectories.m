function plot_trajectories()
    x0 = [0.4; 0.3];
    time_span = [0 20];
    h0 = 1e-4;
    hmin = 1e-6;
    epsilonW = 1e-8;
    epsilonB = 1e-8;

    disp("ode45:");
    tic;
    [tode, xode] = ode45(@dxdt, time_span, x0);
    toc
    disp("RKF45:");
    tic;
    [tdp, xdp, ~, ~] = solveRKF(@dxdt, time_span, x0, h0, hmin, epsilonW, epsilonB);
    toc

    fprintf('function\t|\titerations\n');
    fprintf('-\t\t\t|\t-\n');
    todesize = size(tode);
    tdpsize = size(tdp);
    fprintf('ode45\t\t|\t%0.f\n', [todesize(1)]);
    fprintf('RKF45\t|\t%0.f\n', [tdpsize(1)]);

    tiledlayout(2, 2);
    
    % Trajektoria x_1(t)
    nexttile;
    hold on;
    title('Trajektoria x_1(t)');
    xlabel('t');
    ylabel('x_1(t)');
    plot(tode, xode(:, 1));
    plot(tdp, xdp(:, 1));
    legend('ode45', 'RKF45');
    hold off;

    % Trajektoria na płaszczyźnie (x_1, x_2)
    nexttile([2, 1]);
    hold on;
    title('Trajektoria (x_1, x_2)');
    xlabel('x_1');
    ylabel('x_2');
    plot(xode(:, 1), xode(:, 2));
    plot(xdp(:, 1), xdp(:, 2));
    legend('ode45', 'RKF45');
    hold off;

    % Trajektoria x_2(t)
    nexttile;
    hold on;
    title('Trajektoria x_2(t)');
    xlabel('t');
    ylabel('x_2(t)');
    plot(tode, xode(:, 2));
    plot(tdp, xdp(:, 2));
    legend('ode45', 'RKF45');
    hold off;
end