function [xf, ff, iexe, texe] = newton(f, x0, delta, imax)
%
%   CEL
%       Poszukiwanie pierwiastka funkcji jednej zmiennej
%       metoda Newtona (stycznych)
%  
%   PARAMETRY WEJSCIOWE
%       f      -  funkcja dana jako wyrazenie  
%       x0     -  punkt poczatkowy
%       delta  -  dokladnosc  
%       imax   -  maksymalna liczba iteracji
%
%   PARAMETRY WYJSCIOWE
%       xf     -  rozwiazanie 
%       ff     -  wartosc funkcji w xf
%       iexe   -  liczba iteracji wykonanych
%       texe   -  czas obliczen [s]
%
%   PRZYKLADOWE WYWOLANIE
%       >> [xf, ff, iexe, texe] = newton(@ (x) sin(x), 2, 1e-8, 100)
%
%   AUTOR, PROJEKT  
%       Andrzej Karbowski, 
%       Projekt z "Metod numerycznych" MNUM, 
%       WEiTI PW, sem. 22Z 
%
syms X
% obliczenie pochodnej reprezentowanej jako funkcja anonimowa
df = matlabFunction(diff(f(X), X));
tic;
i = 0; x=x0; fx=feval(f,x); 
while abs(fx) > delta && i < imax
     i = i + 1; xpop = x; 
     % iteracyjne obliczanie nowego przyblizenia pierwiastka
     x = x - fx/df(x);
     fx=feval(f,x);
end
texe=toc; iexe=i;
xf=x; ff = fx;