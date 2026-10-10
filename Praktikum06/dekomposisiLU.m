% =====================================================================
%  METODE DEKOMPOSISI LU (Doolittle, partial pivoting: P*A = L*U)
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
nulang = 1000;      % pengulangan agar waktu terukur (tic toc)

% ---- Algoritma (diukur waktunya, tanpa input/output) ----
id = tic;
for rep = 1:nulang
  L = eye(n);  U = A;  P = eye(n);
  for k = 1:n-1
    [~, idx] = max(abs(U(k:n, k)));        % pivot parsial
    idx = idx + k - 1;
    if idx ~= k
      U([k idx], :) = U([idx k], :);
      P([k idx], :) = P([idx k], :);
      if k > 1
        L([k idx], 1:k-1) = L([idx k], 1:k-1);
      end
    end
    for i = k+1:n
      L(i, k) = U(i, k) / U(k, k);
      U(i, k:n) = U(i, k:n) - L(i, k) * U(k, k:n);
      U(i, k) = 0;
    end
  end
  pb = P * b;
  y  = zeros(n, 1);
  for i = 1:n                               % substitusi maju: L y = P b
    y(i) = pb(i) - L(i, 1:i-1) * y(1:i-1);
  end
  x = zeros(n, 1);
  for i = n:-1:1                            % substitusi mundur: U x = y
    x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
  end
end
waktu = toc(id) / nulang;

% ---- SOAL 1: himpunan penyelesaian ----
fprintf('=== METODE DEKOMPOSISI LU ===\n\n');
fprintf('Matriks L:\n');  disp(L);
fprintf('Matriks U:\n');  disp(U);
fprintf('Matriks P:\n');  disp(P);
fprintf('Vektor y (L y = P b):\n');  disp(y);
fprintf('Cek residu |P*A - L*U| maksimum = %.3e\n\n', max(max(abs(P*A - L*U))));
fprintf('SOAL 1 - Himpunan penyelesaian:\n');
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
