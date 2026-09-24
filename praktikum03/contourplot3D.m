% =========================================================
%       TUGAS PRAKTIKUM 03 - GRAFIK 3D CONTOUR PLOT
% =========================================================

x = -4:0.25:4;
y = -4:0.25:4;

[X,Y] = meshgrid(x,y);

Z = 2.^(-sqrt(X.^2 + Y.^2)) .* cos(Y) .* sin(X);

contour3(X,Y,Z,12)

xlabel('x');
ylabel('y');
zlabel('z');
