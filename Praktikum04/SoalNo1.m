%% ========================================================================
%  SOAL 1
%  Menghitung galat/error pada perhitungan e^(0.3) menggunakan deret
%  Taylor:
%
%                 n   x^i
%      e^x  ~=  sum  -----
%                i=0   i!
%
%  untuk n = {0, 1, 2, 3, 4}, lalu membandingkan dan menganalisis hasil.
% ========================================================================

clear; clc;

%% 1. Input / parameter
x = 0.3;              % nilai x yang dihitung
n_list = 0:4;          % daftar orde deret yang diminta soal

%% 2. Nilai eksak (acuan pembanding)
eksak = exp(x);

fprintf('=======================================================================\n');
fprintf('          GALAT PERHITUNGAN e^%.1f DENGAN DERET TAYLOR\n', x);
fprintf('=======================================================================\n');
fprintf('Nilai eksak (fungsi exp bawaan MATLAB) = %.15f\n\n', eksak);

%% 3. Siapkan tabel hasil
% Kolom: n | pendekatan (p) | galat mutlak | galat relatif (%)
hasil = zeros(length(n_list), 4);

fprintf('%-4s %-20s %-20s %-15s\n', 'n', 'Pendekatan (p)', 'Galat Mutlak', 'Galat Relatif(%)');
fprintf('-----------------------------------------------------------------------\n');

for k = 1:length(n_list)
    n = n_list(k);

    % --- hitung deret Taylor sampai orde ke-n ---
    p = 0;                       % inisialisasi jumlah/pendekatan
    for i = 0:n
        suku = (x^i) / factorial(i);   % suku ke-i dari deret
        p = p + suku;                  % akumulasi (penjumlahan kumulatif)
    end

    % --- hitung galat ---
    galat_mutlak  = abs(eksak - p);
    galat_relatif = (galat_mutlak / eksak) * 100;   % dalam persen

    % simpan ke tabel
    hasil(k, :) = [n, p, galat_mutlak, galat_relatif];

    % tampilkan baris tabel
    fprintf('%-4d %-20.15f %-20.15f %-15.6f\n', n, p, galat_mutlak, galat_relatif);
end

fprintf('-----------------------------------------------------------------------\n\n');

%% 4. Analisis rasio penurunan galat antar-n (opsional, untuk pembahasan)
fprintf('Rasio penurunan galat (galat_n / galat_(n+1)):\n');
for k = 1:length(n_list)-1
    rasio = hasil(k,3) / hasil(k+1,3);
    fprintf('  galat(n=%d) / galat(n=%d) = %.4f\n', n_list(k), n_list(k+1), rasio);
end


