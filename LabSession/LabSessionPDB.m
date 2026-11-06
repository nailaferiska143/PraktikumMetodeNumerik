% LAB SESSION METODE NUMERIK KELAS 3B
% PERSAMAAN DIFERENSIAL BIASA: dy/dx = x*sqrt(y)
% Metode: Euler dan Runge-Kutta Orde-4 (RK4)
clear; clc; format long;

f   = @(x,y) x*sqrt(y);
x0  = 0;  y0 = 1;          % ASUMSI: nilai awal tidak diberikan di soal -> y(0)=1
h   = 0.1;                 % ukuran langkah
xt  = 1.2;                 % titik target
tol = 1e-4;                % toleransi error
n   = round((xt - x0)/h);  % jumlah langkah = 12

lbl = {'TIDAK memenuhi toleransi','memenuhi toleransi'};

% Solusi eksak (hanya untuk mengecek error):
% dy/sqrt(y) = x dx  ->  y = (x^2/4 + C)^2,  C = sqrt(y0) - x0^2/4
C   = sqrt(y0) - x0^2/4;
yex = @(x) (x.^2/4 + C).^2;

x  = x0 + (0:n)*h;
yE = zeros(1,n+1);  yR = zeros(1,n+1);
yE(1) = y0;  yR(1) = y0;

for i = 1:n
  % ---------- Euler ----------
  % y_{i+1} = y_i + h*f(x_i, y_i)
  yE(i+1) = yE(i) + h*f(x(i), yE(i));

  % ---------- RK4 ----------
  k1 = f(x(i),         yR(i));
  k2 = f(x(i)+0.5*h,   yR(i)+0.5*h*k1);
  k3 = f(x(i)+0.5*h,   yR(i)+0.5*h*k2);
  k4 = f(x(i)+h,       yR(i)+h*k3);
  yR(i+1) = yR(i) + h/6*(k1 + 2*k2 + 2*k3 + k4);
end

printf('\n=== dy/dx = x*sqrt(y), y(0)=1, h=0.1 ===\n');
printf('%5s %12s %12s %12s\n','x','Euler','RK4','Eksak');
for i = 1:n+1
  printf('%5.1f %12.6f %12.6f %12.6f\n', x(i), yE(i), yR(i), yex(x(i)));
end

ye   = yex(xt);
errE = abs(yE(end) - ye);
errR = abs(yR(end) - ye);

printf('\nEstimasi y(%.1f):\n', xt);
printf('Euler : %.6f | error = %.6f | %s\n', yE(end), errE, lbl{(errE < tol)+1});
printf('RK4   : %.6f | error = %.6f | %s\n', yR(end), errR, lbl{(errR < tol)+1});
printf('Eksak : %.6f\n', ye);
