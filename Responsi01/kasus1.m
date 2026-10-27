%  KASUS 1 : Galat & Error Pemotongan (Deret Taylor cos(x) dan e^x)

function Kasus1_Galat()
clc; close all;

%% 1. PARAMETER MASUKAN
lambda = 12;            % panjang gelombang
v      = 36;            % kecepatan
x      = 10;            % nilai x pada suku e^x
h0     = 5;             % amplitudo awal
N      = [23 24 25];    % batas iterasi (jumlah suku deret Taylor)
t      = 0:0.01:5;      % rentang waktu 0 <= t <= 5 (501 titik)
theta  = (t*v)/lambda;  % argumen cos, yaitu t*v/lambda

%% 2. HITUNG NILAI EKSAK
h_eksak = h0*(cos(theta) + exp(x));

%% 3. HITUNG NILAI PENDEKATAN (deret Taylor dengan n suku)
h_aprx = zeros(numel(N), numel(t));
for m = 1:numel(N)
    n = N(m);
    h_aprx(m,:) = h0*(cos_taylor(theta, n) + exp_taylor(x, n));
end

%% 4. HITUNG GALAT
galat_mutlak   = abs(h_eksak - h_aprx);
galat_relatif  = galat_mutlak ./ abs(h_eksak) * 100;
rerata_mutlak  = mean(galat_mutlak, 2);
rerata_relatif = mean(galat_relatif, 2);
toleransi      = 1;

%% 5. TAMPILKAN HASIL DI COMMAND WINDOW
fprintf('===== KASUS 1 : GALAT & ERROR PEMOTONGAN =====\n');
fprintf('lambda = %d, v = %d, x = %d, h0 = %d, 0 <= t <= 5 (%d titik)\n\n', ...
        lambda, v, x, h0, numel(t));

fprintf('Galat pemotongan komponen e^x (eksak e^10 = %.6f)\n', exp(x));
for m = 1:numel(N)
    e_aprx = exp_taylor(x, N(m));
    fprintf('  n = %d : e^10 pendekatan = %.6f | galat = %.6f\n', ...
            N(m), e_aprx, abs(exp(x) - e_aprx));
end

fprintf('\nCuplikan nilai h(t)\n');
fprintf('%5s %16s %16s %16s %16s\n', 't', 'h eksak', 'h n=23', 'h n=24', 'h n=25');
idx = 1:100:numel(t);
for i = idx
    fprintf('%5.1f %16.4f %16.4f %16.4f %16.4f\n', ...
            t(i), h_eksak(i), h_aprx(1,i), h_aprx(2,i), h_aprx(3,i));
end

fprintf('\nPerbandingan rerata galat (batas toleransi = %d%%)\n', toleransi);
fprintf('%4s | %20s | %24s | %s\n', 'n', 'Rerata galat mutlak', ...
        'Rerata galat relatif (%)', 'Status');
for m = 1:numel(N)
    if rerata_relatif(m) < toleransi
        status = 'LAYAK';
    else
        status = 'TIDAK LAYAK';
    end
    fprintf('%4d | %20.6f | %24.6f | %s\n', N(m), ...
            rerata_mutlak(m), rerata_relatif(m), status);
end

%% 6. GAMBAR GRAFIK
% Grafik 1 : keempat fungsi dalam satu plot
figure(1);
plot(t, h_eksak,    'k-',  'LineWidth', 2.5); hold on;
plot(t, h_aprx(1,:), 'r--', 'LineWidth', 1.8);
plot(t, h_aprx(2,:), 'g-.', 'LineWidth', 1.8);
plot(t, h_aprx(3,:), 'b:',  'LineWidth', 2.2);
hold off; grid on;
xlabel('t'); ylabel('h(t)');
title('Perbandingan h(t) Eksak dan Pendekatan Deret Taylor');
legend('f_{eksak}', 'f_{n=23}', 'f_{n=24}', 'f_{n=25}', 'Location', 'northeast');

% Grafik 2 : galat mutlak terhadap t
figure(2);
plot(t, galat_mutlak(1,:), 'r-',  'LineWidth', 1.8); hold on;
plot(t, galat_mutlak(2,:), 'g-',  'LineWidth', 1.8);
plot(t, galat_mutlak(3,:), 'b-',  'LineWidth', 1.8);
hold off; grid on;
xlabel('t'); ylabel('Galat mutlak');
title('Galat Mutlak Pendekatan terhadap Nilai Eksak');
legend('n = 23', 'n = 24', 'n = 25', 'Location', 'northeast');
end

%% =========================== FUNGSI PENDUKUNG (subfungsi) ===========================

function y = cos_taylor(x, n)
% Deret Maclaurin cos(x) = sum_{k=0}^{n-1} (-1)^k x^(2k) / (2k)!
    y = zeros(size(x));
    for k = 0:n-1
        y = y + ((-1)^k) * x.^(2*k) / factorial(2*k);
    end
end

function y = exp_taylor(x, n)
% Deret Maclaurin e^x = sum_{k=0}^{n-1} x^k / k!
    y = zeros(size(x));
    for k = 0:n-1
        y = y + x.^k / factorial(k);
    end
end
