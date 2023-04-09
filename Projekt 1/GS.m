function [xf, iexe, texe]=GS(A,b,delta,imax)
%
%   CEL, ALGORYTM 
%       Rozwiazanie ukladu rownan liniowych Ax=b 
%       iteracyjna metoda Gaussa-Seidela. 
%       Implementacja wedlug podrecznika Piotra Tatjewskiego 
%      "Metody Numeryczne", OWPW 2013, str. 59.
%  
%   PARAMETRY WEJSCIOWE
%       A        -  macierz kwadratowa zdominowana diagonalnie
%                      lub symetryczna, dodatnio okreslona
%       b        -  wektor kolumnowy prawych stron 
%       delta  -  dokladnosc  
%       imax  -  maksymalna liczba iteracji
%
%   PARAMETRY WYJSCIOWE
%       xf       -  rozwiazanie 
%       iexe  -  liczba iteracji wykonanych
%       texe  -  czas obliczen [s]
%
%   PRZYKLADOWE WYWOLANIE
%       >> G=rand(5)  
%       >> A=G*G' 
%       >> b=rand(5,1)  
%       >> [xf, iexe, texe] = GS(A, b, 1e-8, 5000)
%       >> norm(A*xf-b)
%
%   AUTOR, PROJEKT  
%       Andrzej Karbowski, 
%       Projekt z "Metod numerycznych" MNUM, 
%       WEiTI PW, sem. 23L 
%
tic;
D=diag(diag(A));
U=triu(A)-D;
L=tril(A)-D;
n=size(b,1);
x=ones(n,1); xold=0;k=0;
while norm(xold-x) > delta & k < imax 
    xold=x; k=k+1;
    w=U*x-b;
    for i=1:n
       x(i)=(-L(i,1:i-1)*x(1:i-1)-w(i))/D(i,i);
    end
end
texe=toc; iexe =k; xf=x;
