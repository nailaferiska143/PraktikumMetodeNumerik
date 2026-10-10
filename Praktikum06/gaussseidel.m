% =====================================================================
%  METODE GAUSS-SEIDEL (iteratif, tebakan awal x0 = 0)
% =====================================================================
clear; clc;

% ---- Data soal (variabel: p, q, r, s, t) ----
A = [ 5 -1 -1  0  0;
     -1  5 -1 -1  0;
     -1 -1  4 -1 -1;
      0  0  1  4 -2;
      0  1 -1  1  4];
b = [-1; 2; 6; 2; -1];
n = length(b);
nama   = {'p'; 'q'; 'r'; 's'; 't'};
tol    = 0.001;     % batas toleransi error
maxit  = 20;        % maksimum iterasi
nulang = 1000;      % pengulangan agar waktu terukur (tic toc)

% ---- Algoritma (diukur waktunya, tanpa input/output) ----
id = tic;
for rep = 1:nulang
  x = zeros(n, 1);
  riwayat = zeros(maxit, n + 2);
  galatit = inf;
  iter = 0;
  while iter < maxit && galatit >= tol
    iter = iter + 1;
    xlama = x;
    for i = 1:n                              % nilai terbaru langsung dipakai
      s = A(i, 1:i-1) * x(1:i-1) + A(i, i+1:n) * x(i+1:n);
      x(i) = (b(i) - s) / A(i, i);
    end
    galatit = max(abs(x - xlama));
    riwayat(iter, :) = [iter, x', galatit];
  end
  riwayat = riwayat(1:iter, :);
end
waktu = toc(id) / nulang;

% ---- SOAL 1: himpunan penyelesaian ----
fprintf('=== METODE GAUSS-SEIDEL ===\n\n');
fprintf('Toleransi = %g, maksimum iterasi = %d\n\n', tol, maxit);
fprintf('%3s %11s %11s %11s %11s %11s %11s\n', 'k','p','q','r','s','t','max|dx|');
fprintf('%3d %11.6f %11.6f %11.6f %11.6f %11.6f %11.6f\n', riwayat');
if galatit < tol
  fprintf('\nKonvergen pada iterasi ke-%d\n', iter);
else
  fprintf('\nBelum konvergen setelah %d iterasi\n', iter);
end
fprintf('\nSOAL 1 - Himpunan penyelesaian:\n');
for i = 1:n
  fprintf('  %s = %.6f\n', nama{i}, x(i));
end

% ---- SOAL 2: galat |nilai eksak - nilai hampiran| ----
xE = [55/169; 422/507; 70/39; 7/169; -10/507];   % nilai eksak (analitik)
galat = abs(xE - x);
fprintf('\nSOAL 2 - Galat terhadap nilai eksak:\n');
for i = 1:n
  fprintf('  galat %s = %.6e\n', nama{i}, galat(i));
end
fprintf('  galat maksimum = %.6e\n', max(galat));

% ---- SOAL 3: running time ----
fprintf('\nSOAL 3 - Running time (rata-rata %d kali): %.3f mikrodetik\n', ...
        nulang, waktu * 1e6);
