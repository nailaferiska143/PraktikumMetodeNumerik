function x = MetodeGaus(A, b)
% METODEGAUSDETAIL  Eliminasi Gauss (forward elimination + substitusi mundur)

%
% Semua langkah ditampilkan dalam bentuk pecahan.

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
  fprintf('  (a) ELIMINASI GAUSS\n');
  fprintf('==============================================\n\n');

  M = [A b];
  tampilMatriks(M, 'Matriks augmented awal [A | b]:', n);

  % ------------------ FORWARD ELIMINATION ------------------
  fprintf('--- FORWARD ELIMINATION ---\n\n');
  for k = 1:n-1
    fprintf('Langkah %d : pivot a(%d,%d) = %s\n', k, k, k, frac(M(k,k)));
    if abs(M(k,k)) < tol
      error('Pivot nol di baris %d. Perlu pertukaran baris (pivoting).', k);
    end
    for i = k+1:n
      m = M(i,k) / M(k,k);
      fprintf('  m(%d,%d) = %s / %s = %s\n', i, k, frac(M(i,k)), frac(M(k,k)), frac(m));
      fprintf('  R%d <- R%d - (%s) * R%d\n', i, i, frac(m), k);
      M(i,:) = M(i,:) - m * M(k,:);
      M(i,k) = 0;                      % hilangkan galat numerik kecil
    end
    fprintf('\n');
    tampilMatriks(M, sprintf('Matriks setelah eliminasi kolom %d:', k), n);
  end

  if abs(M(n,n)) < tol
    error('Pivot terakhir nol: sistem singular (tidak ada solusi tunggal).');
  end

  U = M(:, 1:n);
  c = M(:, n+1);
  tampilMatriks([U c], 'Bentuk segitiga atas [U | c]:', n);

  % ------------------ BACKWARD SUBSTITUTION ------------------
  fprintf('--- SUBSTITUSI MUNDUR ---\n\n');
  x = zeros(n, 1);
  for i = n:-1:1
    jumlah = 0;
    for j = i+1:n
      jumlah = jumlah + U(i,j) * x(j);
    end
    x(i) = (c(i) - jumlah) / U(i,i);
    fprintf('x%d = (%s - %s) / %s = %s  (%.6f)\n', i, frac(c(i)), frac(jumlah), ...
            frac(U(i,i)), frac(x(i)), x(i));
  end

  % ------------------ VERIFIKASI ------------------
  fprintf('\n--- VERIFIKASI ---\n');
  r = A * x - b;
  fprintf('Residual A*x - b = [ %s ]\n', strjoin(arrayfun(@(v) sprintf('%g', v), r', 'UniformOutput', false), ', '));
  fprintf('Norm residual    = %g\n', norm(r));
  fprintf('Selisih dengan A\\b (bawaan Octave) = %g\n\n', norm(x - A\b));

  fprintf('SOLUSI (Gauss):\n');
  for i = 1:n
    fprintf('  x%d = %s = %.6f\n', i, frac(x(i)), x(i));
  end
  fprintf('\n');
end

% ================== FUNGSI BANTU ==================
function s = frac(v)
  if abs(v) < 1e-12, v = 0; end
  s = strtrim(rats(v));
end

function tampilMatriks(M, judul, nvar)
  fprintf('%s\n', judul);
  for i = 1:size(M,1)
    fprintf('  [');
    for j = 1:size(M,2)
      if nargin >= 3 && j == nvar + 1
        fprintf('  |');
      end
      fprintf('%8s', frac(M(i,j)));
    end
    fprintf('  ]\n');
  end
  fprintf('\n');
end
