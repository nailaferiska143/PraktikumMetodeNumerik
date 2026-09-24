%% ========================================================================
%  SOAL 3
%  Menghitung galat/error pada perhitungan sin(x) menggunakan deret
%  Taylor:
%
%                  N          x^(2n+1)
%      sin(x) ~= sum  (-1)^n -----------
%                 n=0          (2n+1)!
%
%  dengan N = {1, 2, 3, 4, 5} dan x = 1, lalu membandingkan dan
%  menganalisis hasil yang diperoleh.
% ========================================================================

clear; clc;

x = 1;             % nilai x (dalam radian)
N_list = 1:5;       % daftar orde deret yang diminta soal

%% 1. Nilai eksak (acuan pembanding)
eksak = sin(x);

fprintf('=======================================================================\n');
fprintf('        GALAT PERHITUNGAN sin(%d) DENGAN DERET TAYLOR\n', x);
fprintf('=======================================================================\n');
fprintf('Nilai eksak (fungsi sin bawaan MATLAB) = %.15f\n\n', eksak);

%% 2. Siapkan tabel hasil
% Kolom: N | pendekatan (p) | galat mutlak | galat relatif (%)
hasil = zeros(length(N_list), 4);

fprintf('%-4s %-20s %-20s %-15s\n', 'N', 'Pendekatan (p)', 'Galat Mutlak', 'Galat Relatif(%)');
fprintf('-----------------------------------------------------------------------\n');

for k = 1:length(N_list)
    N = N_list(k);

    % --- hitung deret Taylor sampai orde ke-N ---
    p = 0;                       % inisialisasi jumlah/pendekatan
    for n = 0:N
        pangkat = 2*n + 1;                       % eksponen x
        suku = ((-1)^n) * (x^pangkat) / factorial(pangkat);  % suku ke-n
        p = p + suku;                            % akumulasi (bolak-balik tanda)
    end

    % --- hitung galat ---
    galat_mutlak  = abs(eksak - p);
    galat_relatif = (galat_mutlak / eksak) * 100;

    hasil(k, :) = [N, p, galat_mutlak, galat_relatif];

    fprintf('%-4d %-20.15f %-20.15e %-15.10f\n', N, p, galat_mutlak, galat_relatif);
end

fprintf('-----------------------------------------------------------------------\n\n');

%% 3. Tampilkan rincian tiap suku (untuk pembahasan/analisis lebih detail)
fprintf('Rincian nilai tiap suku deret (n = 0 s.d. 5):\n');
fprintf('%-4s %-15s %-20s\n', 'n', '(2n+1)', 'Suku (-1)^n x^(2n+1)/(2n+1)!');
fprintf('-----------------------------------------------------------------------\n');
for n = 0:5
    pangkat = 2*n + 1;
    suku = ((-1)^n) * (x^pangkat) / factorial(pangkat);
    fprintf('%-4d %-15d %-20.15f\n', n, pangkat, suku);
end
fprintf('-----------------------------------------------------------------------\n\n');

%% 4. Analisis rasio penurunan galat antar-N
fprintf('Rasio penurunan galat (galat_N / galat_(N+1)):\n');
for k = 1:length(N_list)-1
    rasio = hasil(k,3) / hasil(k+1,3);
    fprintf('  galat(N=%d) / galat(N=%d) = %.4f\n', N_list(k), N_list(k+1), rasio);
end
fprintf('\n');

%% 5. Verifikasi batas galat deret bolak-balik (Alternating Series)
%    Untuk deret bolak-balik, |galat| <= |suku pertama yang dibuang|
fprintf('Verifikasi batas galat deret bolak-balik:\n');
fprintf('%-4s %-25s %-20s\n', 'N', 'Batas |suku ke-(N+1)|', 'Galat aktual');
fprintf('-----------------------------------------------------------------------\n');
for k = 1:length(N_list)
    N = N_list(k);
    n_berikut = N + 1;
    pangkat_berikut = 2*n_berikut + 1;
    batas = abs((x^pangkat_berikut) / factorial(pangkat_berikut));
    fprintf('%-4d %-25.6e %-20.6e\n', N, batas, hasil(k,3));
end
fprintf('-----------------------------------------------------------------------\n\n');

