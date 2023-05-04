function [xf, ff, iexe, texe] = solverFalsi(f, a, b, delta, imax)
    stop = false;
    iexe = 0;
    
    tic
    while ~stop
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        if f(a) * f(c) < 0
            b = c;
        else
            a = c;
        end
        
        if abs(f(c)) < delta || iexe >= imax - 1
            stop = true;
        end

        iexe = iexe + 1;
    end
    texe = toc;
    xf = c;
    ff = f(c);
end