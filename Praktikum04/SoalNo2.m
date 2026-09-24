%% ========================================================================
%  SOAL 2
%  Menghitung galat/error pada perhitungan:
%
%      1/1 + 1/2 + 1/3 + ... + 1/20
%
%  menggunakan 3 metode berbeda, lalu membandingkan hasilnya:
%    a. Perhitungan secara eksak (pecahan, tanpa pembulatan)
%    b. Masing-masing pembagian dibulatkan, lalu dijumlahkan (looping)
%    c. Tanpa looping, menggunakan fungsi sum()
% ========================================================================

clear; clc;

N = 20;   % banyak suku (1/1 sampai 1/20)

fprintf('=======================================================================\n');
fprintf('           GALAT PERHITUNGAN  1/1 + 1/2 + ... + 1/%d\n', N);
fprintf('=======================================================================\n\n');

%% ------------------------------------------------------------------
%  A. PERHITUNGAN SECARA EKSAK
eksak = 0;
for i = 1:N
    eksak = eksak + 1/i;      % penjumlahan presisi double, tanpa pembulatan manual
end

fprintf('a. Perhitungan EKSAK (presisi double penuh, tanpa pembulatan manual):\n');
fprintf('   Bentuk desimal : %.15f\n\n', eksak);

%% ------------------------------------------------------------------
%  B. MASING-MASING PEMBAGIAN DIBULATKAN (looping)
%     Setiap 1/i dibulatkan ke d angka desimal SEBELUM dijumlahkan.
%     Dicoba beberapa nilai d untuk melihat pengaruh jumlah desimal
%     terhadap besar galat.
% ------------------------------------------------------------------
fprintf('b. Masing-masing pembagian DIBULATKAN, lalu dijumlahkan (loop):\n');
fprintf('%-12s %-20s %-18s %-15s\n', 'Desimal(d)', 'Hasil Jumlah', 'Galat Mutlak', 'Galat Relatif(%)');
fprintf('-----------------------------------------------------------------------\n');

daftar_desimal = [2 3 4 5];   % variasi jumlah angka desimal pembulatan
hasil_b = zeros(length(daftar_desimal), 4);

for k = 1:length(daftar_desimal)
    d = daftar_desimal(k);

    s = 0;                       % inisialisasi penjumlahan
    faktor = 10^d;                % faktor pengali untuk pembulatan manual
    for i = 1:N
        % Pembulatan manual ke d desimal (kompatibel MATLAB & Octave,
        % tidak bergantung pada round(X,d) yang hanya ada di MATLAB
        % atau di Octave dengan paket tambahan)
        suku_bulat = round((1/i) * faktor) / faktor;
        s = s + suku_bulat;           % akumulasi hasil
    end

    galat_mutlak  = abs(eksak - s);
    galat_relatif = (galat_mutlak / eksak) * 100;

    hasil_b(k, :) = [d, s, galat_mutlak, galat_relatif];

    fprintf('%-12d %-20.10f %-18.10e %-15.8f\n', d, s, galat_mutlak, galat_relatif);
end
fprintf('-----------------------------------------------------------------------\n\n');

%% ------------------------------------------------------------------
%  C. TANPA LOOPING, MENGGUNAKAN FUNGSI sum()
%     Memanfaatkan operasi vektor: 1./i untuk i = 1:N, dijumlahkan
%     sekaligus dengan sum(). Tidak ada pembulatan manual di sini;
%     ketelitian mengikuti presisi double (~15-16 digit).
% ------------------------------------------------------------------
i_vec  = 1:N;              % vektor 1,2,3,...,20
s_sum  = sum(1 ./ i_vec);  % penjumlahan tanpa loop eksplisit

galat_mutlak_c  = abs(eksak - s_sum);
galat_relatif_c = (galat_mutlak_c / eksak) * 100;

fprintf('c. TANPA LOOPING (fungsi sum):\n');
fprintf('   Hasil         : %.15f\n', s_sum);
fprintf('   Galat mutlak  : %.6e\n', galat_mutlak_c);
fprintf('   Galat relatif : %.10f %%\n\n', galat_relatif_c);

%% ------------------------------------------------------------------
%  D. TABEL PERBANDINGAN RINGKAS ANTAR METODE
% ------------------------------------------------------------------
fprintf('=======================================================================\n');
fprintf('               PERBANDINGAN RINGKAS KETIGA METODE\n');
fprintf('=======================================================================\n');
fprintf('%-30s %-20s %-15s\n', 'Metode', 'Hasil', 'Galat Mutlak');
fprintf('-----------------------------------------------------------\n');
fprintf('%-30s %-20.15f %-15s\n', 'a. Eksak (acuan)', eksak, '0 (acuan)');
for k = 1:length(daftar_desimal)
    label = sprintf('b. Dibulatkan %d desimal', daftar_desimal(k));
    fprintf('%-30s %-20.15f %-15.6e\n', label, hasil_b(k,2), hasil_b(k,3));
end
fprintf('%-30s %-20.15f %-15.6e\n', 'c. sum() tanpa loop', s_sum, galat_mutlak_c);
fprintf('-----------------------------------------------------------------------\n\n');

