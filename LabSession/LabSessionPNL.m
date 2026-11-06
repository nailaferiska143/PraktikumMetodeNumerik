% LAB SESSION METODE NUMERIK KELAS 3B
% SISTEM PERSAMAAN NON-LINEAR: f(x) = cos(x) - x = 0
% Metode: Fixed-Point Iteration dan Newton-Raphson
clear; clc; format long;

F   = @(x) cos(x) - x;
dF  = @(x) -sin(x) - 1;    % f'(x)
g   = @(x) cos(x);         % bentuk g(x) untuk Fixed-Point
dg  = @(x) -sin(x);        % g'(x)
tol = 1e-4;                % toleransi
maxit = 100;
x0  = 0.5;                 % tebakan awal (0 < x0 < 1.4)

printf('=== f(x) = cos(x) - x = 0, x0 = %.1f, toleransi < %g ===\n', x0, tol);

%% Fixed-Point Iteration
printf('\n--- Fixed-Point Iteration, g(x) = cos(x) ---\n');
printf('Cek |g''(x0)| = %.6f ', abs(dg(x0)));
akarFP = NaN;  itFP = 0;
if abs(dg(x0)) < 1
  printf('< 1 -> iterasi boleh dilanjutkan\n');
  printf('%3s %12s %12s %12s\n','i','x_i','x_i+1','|selisih|');
  xp = x0;
  for i = 1:maxit
    xn  = g(xp);
    err = abs(xn - xp);
    printf('%3d %12.8f %12.8f %12.8f\n', i, xp, xn, err);
    xp = xn;
    if err < tol, break; end
  end
  akarFP = xp;  itFP = i;
  printf('Akar (Fixed-Point) = %.8f, iterasi = %d, f(akar) = %.2e\n', akarFP, itFP, F(akarFP));
else
  printf('>= 1 -> iterasi TIDAK boleh dilanjutkan\n');
end

%% Newton-Raphson
printf('\n--- Newton-Raphson, f''(x) = -sin(x) - 1 ---\n');
printf('Cek f''(x0) = %.6f ', dF(x0));
akarNR = NaN;  itNR = 0;
if dF(x0) ~= 0
  printf('~= 0 -> aman, iterasi dilanjutkan\n');
  printf('%3s %12s %12s %12s\n','i','x_i','x_i+1','|selisih|');
  xn = x0;
  for i = 1:maxit
    xnew = xn - F(xn)/dF(xn);
    err  = abs(xnew - xn);
    printf('%3d %12.8f %12.8f %12.8f\n', i, xn, xnew, err);
    xn = xnew;
    if err < tol, break; end
  end
  akarNR = xn;  itNR = i;
  printf('Akar (Newton-Raphson) = %.8f, iterasi = %d, f(akar) = %.2e\n', akarNR, itNR, F(akarNR));
else
  printf('= 0 -> iterasi TIDAK boleh dilanjutkan\n');
end

%% Perbandingan
printf('\n============= PERBANDINGAN ==============\n');
printf('%-16s %-14s %s\n','Metode','Akar','Iterasi');
printf('%-16s %-14.8f %d\n','Fixed-Point', akarFP, itFP);
printf('%-16s %-14.8f %d\n','Newton-Raphson', akarNR, itNR);
