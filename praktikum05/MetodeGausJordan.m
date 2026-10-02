% Metode b) Eliminasi Gauss-Jordan
clc; clear; format rat;

A = [2 1 -1; 4 3 1; -2 1 2];
b = [3; 9; 4];
n = length(b);
Ab = [A b];

disp('Matriks awal [A|b]:'); disp(Ab);

% ---- Forward elimination (sama dengan Gauss) ----
for k = 1:n-1
  for i = k+1:n
    m = Ab(i,k) / Ab(k,k);
    Ab(i,k:n+1) = Ab(i,k:n+1) - m * Ab(k,k:n+1);
  end
end
disp('Hasil forward elimination (segitiga atas):'); disp(Ab);

% ---- Backward elimination -> diagonal ----
for k = n:-1:2
  for i = k-1:-1:1
    m = Ab(i,k) / Ab(k,k);
    printf('R%d <- R%d - (%s)*R%d\n', i, i, strtrim(rats(m)), k);
    Ab(i,:) = Ab(i,:) - m * Ab(k,:);
  end
  printf('\nSetelah kolom %d di atas pivot dinolkan:\n', k); disp(Ab);
end

% ---- Normalisasi -> identitas ----
for i = 1:n
  Ab(i,:) = Ab(i,:) / Ab(i,i);
end
disp('Setelah normalisasi [I|x]:'); disp(Ab);

x = Ab(:,n+1);
for i = 1:n
  printf('x%d = %s = %.4f\n', i, strtrim(rats(x(i))), x(i));
end
