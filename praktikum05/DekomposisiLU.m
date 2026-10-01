% Metode (c): Dekomposisi LU (diagonal L = 1)
% VERSI SCRIPT MURNI: tanpa function/subfunction, jadi tidak bergantung nama file.
clc; clear;

A = [2 1 -1; 4 3 1; -2 1 2];
b = [3; 9; 4];
n = length(b);

% pengubah angka -> pecahan (angka sangat kecil dianggap 0)
frac = @(v) strtrim(rats(v * (abs(v) >= 1e-12)));

fprintf('==============================================\n');
fprintf('  (c) DEKOMPOSISI LU\n');
fprintf('==============================================\n\n');

U = A;
L = eye(n);

% ------------------ FORWARD ELIMINATION ------------------
fprintf('--- FORWARD ELIMINATION (mencatat pengali m) ---\n\n');
for k = 1:n-1
  fprintf('Langkah %d : pivot u(%d,%d) = %s\n', k, k, k, frac(U(k,k)));
  if abs(U(k,k)) < 1e-12
    error('Pivot nol di baris %d. Perlu pivoting.', k);
  end
  for i = k+1:n
    m = U(i,k) / U(k,k);
    L(i,k) = m;
    fprintf('  m(%d,%d) = %s / %s = %s   -> disimpan ke L(%d,%d)\n', ...
            i, k, frac(U(i,k)), frac(U(k,k)), frac(m), i, k);
    U(i,:) = U(i,:) - m * U(k,:);
    U(i,k) = 0;
  end
  fprintf('\n');
end

% ------------------ TAMPILKAN A, L, U, L*U ------------------
daftar = {A,   'Matriks A:'; ...
          L,   'Matriks L (segitiga bawah, diagonal = 1):'; ...
          U,   'Matriks U (segitiga atas):'; ...
          L*U, 'Hasil kali L * U:'};

for t = 1:size(daftar, 1)
  Mt = daftar{t, 1};
  fprintf('%s\n', daftar{t, 2});
  for i = 1:n
    fprintf('  [');
    for j = 1:n
      fprintf('%8s', frac(Mt(i,j)));
    end
    fprintf('  ]\n');
  end
  fprintf('\n');
end

% ------------------ BUKTI A = L*U ------------------
galat = max(max(abs(L*U - A)));
fprintf('Galat maksimum |L*U - A| = %g\n', galat);
if galat < 1e-12
  fprintf('==> TERBUKTI: A = L*U\n\n');
else
  fprintf('==> A tidak sama dengan L*U\n\n');
end
fprintf('Bonus: det(A) = u11*u22*u33 = %s\n\n', frac(prod(diag(U))));

% ------------------ L*y = b (substitusi maju) ------------------
fprintf('--- L*y = b (SUBSTITUSI MAJU) ---\n');
y = zeros(n, 1);
for i = 1:n
  jumlah = 0;
  for j = 1:i-1
    jumlah = jumlah + L(i,j) * y(j);
  end
  y(i) = b(i) - jumlah;
  fprintf('y%d = %s - %s = %s\n', i, frac(b(i)), frac(jumlah), frac(y(i)));
end

% ------------------ U*x = y (substitusi mundur) ------------------
fprintf('\n--- U*x = y (SUBSTITUSI MUNDUR) ---\n');
x = zeros(n, 1);
for i = n:-1:1
  jumlah = 0;
  for j = i+1:n
    jumlah = jumlah + U(i,j) * x(j);
  end
  x(i) = (y(i) - jumlah) / U(i,i);
  fprintf('x%d = (%s - %s) / %s = %s  (%.6f)\n', i, frac(y(i)), frac(jumlah), ...
          frac(U(i,i)), frac(x(i)), x(i));
end

% ------------------ VERIFIKASI ------------------
fprintf('\n--- VERIFIKASI ---\n');
fprintf('Norm residual ||A*x - b||          = %g\n', norm(A*x - b));
fprintf('Selisih dengan A\\b (bawaan Octave) = %g\n\n', norm(x - A\b));

fprintf('SOLUSI (LU):\n');
for i = 1:n
  fprintf('  x%d = %s = %.6f\n', i, frac(x(i)), x(i));
end
fprintf('\n');
