% =========================================================
%       TUGAS PRAKTIKUM 03 - GRAFIK 3D LINE PLOT
% =========================================================

t = 0:0.1:8*pi;

x = sqrt(t).*sin(3*t);
y = sqrt(t).*cos(3*t);
z = 0.4*t;

plot3(x,y,z,'k','linewidth',1);
grid on

xlabel('x');
ylabel('y');
zlabel('z');
