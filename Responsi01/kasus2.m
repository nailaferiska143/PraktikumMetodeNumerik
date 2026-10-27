%  KASUS 2 : Sistem Persamaan Linear (Metode Gauss-Seidel)
function Kasus2_SPL()
clc; close all;

%% 1. KONVERSI SATUAN KE KILOGRAM
% 1 hg = 0.1 kg ; 1 dag = 0.01 kg ; 1 g = 0.001 kg
% Kolom : beras | telur | tepung | ayam
A = [ 2.5    1500/1000   5          500/1000;     % Adel
      40*0.1 0.75        1000/1000  2;            % Briza
      2000/1000 15*0.1   50*0.01    6000/1000;    % Caca
      1      4250/1000   20*0.1     9*0.1 ];      % Dinda
b = [161000; 149000; 251500; 173000];                % total belanja (Rp)
nama = {'Adel','Briza','Caca','Dinda'};
bahan = {'Beras','Telur','Tepung','Ayam'};

fprintf('===== KASUS 2 : SPL METODE GAUSS-SEIDEL =====\n');
fprintf('Matriks koefisien A (kg) dan vektor b (Rp):\n');
for i = 1:4
    fprintf('  [%6.2f %6.2f %6.2f %6.2f ] | %9d   (%s)\n', A(i,:), b(i), nama{i});
end

%% 2. CEK SYARAT KECUKUPAN KONVERGENSI (DOMINAN DIAGONAL STRIK)
d = abs(diag(A));
s = sum(abs(A),2) - d;
fprintf('\nCek dominan diagonal MATRIKS AWAL:\n');
for i = 1:4
    fprintf('  Baris %d : |a_ii| = %.2f, jumlah elemen lain = %.2f -> %s\n', ...
            i, d(i), s(i), ternary(d(i) > s(i), 'dominan', 'TIDAK dominan'));
end

%% 3. CARI URUTAN BARIS YANG MEMBUAT DIAGONAL DOMINAN (permutasi baris)
P = perms(1:4);
ketemu = false;
for p = 1:size(P,1)
    Ap = A(P(p,:), :);
    if all(abs(diag(Ap)) > sum(abs(Ap),2) - abs(diag(Ap)))
        urutan = P(p,:);  ketemu = true;  break;
    end
end
if ~ketemu
    error('Tidak ada urutan baris dominan diagonal -> gunakan metode langsung.');
end
A2 = A(urutan,:);   b2 = b(urutan);
fprintf('\nUrutan baris baru = [%s]  (%s)\n', num2str(urutan), ...
        strjoin(nama(urutan), ', '));
fprintf('Matriks setelah penukaran baris:\n');
for i = 1:4
    fprintf('  [%6.2f %6.2f %6.2f %6.2f ] | %9d   (%s)\n', A2(i,:), b2(i), nama{urutan(i)});
end

% Pembanding : jari-jari spektral matriks iterasi Gauss-Seidel (harus < 1)
rho_awal = jari_spektral(A);
rho_baru = jari_spektral(A2);
fprintf('\nJari-jari spektral Gauss-Seidel: matriks awal = %.4f, setelah tukar baris = %.4f\n', ...
        rho_awal, rho_baru);

%% 4. ITERASI GAUSS-SEIDEL
n      = 4;
xk     = zeros(n,1);      % tebakan awal [0;0;0;0]
tol    = 1e-6;            % toleransi galat (selisih maksimum antar iterasi)
maxit  = 1000;

fprintf('\nTabel iterasi Gauss-Seidel (tebakan awal = 0, tol = %g)\n', tol);
fprintf('%4s %12s %12s %12s %12s %14s\n', 'Iter', 'Beras', 'Telur', 'Tepung', 'Ayam', 'Galat maks');
for it = 1:maxit
    x_lama = xk;
    for i = 1:n
        j = [1:i-1, i+1:n];                         % indeks selain diagonal
        xk(i) = (b2(i) - A2(i,j)*xk(j)) / A2(i,i);  % nilai terbaru langsung dipakai
    end
    galat = max(abs(xk - x_lama));
    fprintf('%4d %12.4f %12.4f %12.4f %12.4f %14.6f\n', it, xk, galat);
    if galat < tol, break; end
end

%% 5. VERIFIKASI DENGAN METODE LANGSUNG MATLAB (A\b)
x_acuan = A\b;
fprintf('\nHASIL AKHIR (harga per kg) setelah %d iterasi:\n', it);
for i = 1:4
    fprintf('  %-7s : Rp %10.2f   (acuan A\\b : Rp %10.2f)\n', bahan{i}, xk(i), x_acuan(i));
end
fprintf('Residu max |A*x - b| = %.6f\n', max(abs(A*xk - b)));
end

%% =========================== FUNGSI PENDUKUNG (subfungsi) ===========================

function r = jari_spektral(M)
% Jari-jari spektral matriks iterasi Gauss-Seidel T = -(D+L)^(-1) U
    L = tril(M,-1);  U = triu(M,1);  D = diag(diag(M));
    T = -((D+L)\U);
    r = max(abs(eig(T)));
end

function out = ternary(cond, a, b)
% Pengganti operator kondisi satu baris
    if cond
        out = a;
    else
        out = b;
    end
end
