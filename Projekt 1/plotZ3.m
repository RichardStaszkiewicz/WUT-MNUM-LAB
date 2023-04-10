function [result] = plotZ3(strategy)

    N = [3, 5, 7, 9, 10];
    
    for i = 1 : length(N)
        degree = N(i);
        nexttile
        
        X = -10:2:10;
        Y = [-35.798, -19.430, -9.737, -3.163, -0.650, 1.587, 1.517, 2.183, 5.102, 11.091, 22.000]';
        resolution = -10:0.2:10;
        
        if strategy == 0
            result = approximateNormal(X, Y, degree, 0);
        elseif strategy == 1
            result = approximateNormal(X, Y, degree, 1);
        else
            result = approximateSVD(X, Y, degree);
        end
    
        result = result(end:-1:1);
    
        polynomial_values = polyval(result, X);
        epsilon_2 = norm(polynomial_values - Y');
        epsilon_inf = norm(polynomial_values - Y', "inf");
    
        plot(resolution , polyval(result, resolution), X, Y, 'o');
    
        title({['Degree = ' num2str(degree)] ...
            ['epsilon 2 = ' num2str(epsilon_2)] ...
            ['epsilon inf = ' num2str(epsilon_inf)]});
    end
end