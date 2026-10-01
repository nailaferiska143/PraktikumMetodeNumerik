function x = MetodeGausJordan(A, b)
% METODEGAUSJORDANDETAIL  Eliminasi Gauss-Jordan
%
%   x = MetodeGausJordanDetail        -> memakai soal P5 (default)
%   x = MetodeGausJordanDetail(A, b)  -> memakai SPL sembarang A*x = b
%
% Tahap: (1) forward elimination, (2) backward elimination,
%        (3) normalisasi diagonal menjadi 1 -> x terbaca langsung.

  if nargin < 2
    A = [2 1 -1; 4 3 1; -2 1 2];
    b = [3; 9; 4];
  end
  b = b(:);
  n = size(A, 1);
  if size(A, 2) ~= n || length(b) ~= n
    error('A harus persegi dan panjang b harus sama dengan ukuran A');
  end
  tol = 1e-12;

  fprintf('==============================================\n');
  fprintf('  (b) ELIMINASI GAUSS-JORDAN\n');
  fprintf('==============================================\n\n');

  M = [A b];
  tampilMatriks(M, 'Matriks augmented awal [A | b]:', n);

  % ------------------ TAHAP 1: FORWARD ------------------
  fprintf('--- TAHAP 1: FORWARD ELIMINATION ---\n\n');
  for k = 1:n-1
    fprintf('Langkah %d : pivot a(%d,%d) = %s\n', k, k, k, frac(M(k,k)));
    if abs(M(k,k)) < tol
      error('Pivot nol di baris %d. Perlu pertukaran baris (pivoting).', k);
    end
    for i = k+1:n
      m = M(i,k) / M(k,k);
      fprintf('  m(%d,%d) = %s  ->  R%d <- R%d - (%s) * R%d\n', i, k, frac(m), i, i, frac(m), k);
      M(i,:) = M(i,:) - m * M(k,:);
      M(i,k) = 0;
    end
    fprintf('\n');
  end
  tampilMatriks(M, 'Hasil forward elimination (segitiga atas):', n);

  if abs(M(n,n)) < tol
    error('Pivot terakhir nol: sistem singular.');
  end

  % ------------------ TAHAP 2: BACKWARD ------------------
  fprintf('--- TAHAP 2: BACKWARD ELIMINATION ---\n\n');
  for k = n:-1:2
    fprintf('Menolkan kolom %d di atas pivot a(%d,%d) = %s\n', k, k, k, frac(M(k,k)));
    for i = k-1:-1:1
      m = M(i,k) / M(k,k);
      fprintf('  R%d <- R%d - (%s) * R%d\n', i, i, frac(m), k);
      M(i,:) = M(i,:) - m * M(k,:);
      M(i,k) = 0;
    end
    fprintf('\n');
    tampilMatriks(M, sprintf('Matriks setelah menolkan kolom %d:', k), n);
  end

  % ------------------ TAHAP 3: NORMALISASI ------------------
  fprintf('--- TAHAP 3: NORMALISASI DIAGONAL ---\n\n');
  for i = 1:n
    p = M(i,i);
    fprintf('  R%d <- R%d / (%s)\n', i, i, frac(p));
    M(i,:) = M(i,:) / p;
  end
  fprintf('\n');
  tampilMatriks(M, 'Matriks akhir [I | x]:', n);

  x = M(:, n+1);
