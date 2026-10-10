% =====================================================================
%  METODE GAUSS (eliminasi maju + substitusi mundur, partial pivoting)
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
  Ab = [A, b];
  for k = 1:n-1
    [~, idx] = max(abs(Ab(k:n, k)));       % pivot parsial
    idx = idx + k - 1;
    if idx ~= k
      Ab([k idx], :) = Ab([idx k], :);
    end
    for i = k+1:n
      m = Ab(i, k) / Ab(k, k);
      Ab(i, k:end) = Ab(i, k:end) - m * Ab(k, k:end);
    end
  end
  x = zeros(n, 1);
  for i = n:-1:1
    x(i) = (Ab(i, end) - Ab(i, i+1:n) * x(i+1:n)) / Ab(i, i);
  end
end
waktu = toc(id) / nulang;

% ---- SOAL 1: himpunan penyelesaian ----
fprintf('=== METODE GAUSS ===\n\n');
fprintf('Matriks setelah eliminasi maju [U | c]:\n');
disp(Ab);
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
