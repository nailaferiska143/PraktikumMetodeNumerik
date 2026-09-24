% =========================================================
%       TUGAS PRAKTIKUM 03 - GRAFIK 2D LINSPACE
% =========================================================

x = linspace(0,15);
y = exp(-x/3).*cos(x);

plot(x,y)
xlabel('Sumbu X')
ylabel('Sumbu Y')
title('Grafik f(x)=exp(-x/3).*cos(x)')
