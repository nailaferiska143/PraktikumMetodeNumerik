%  KASUS 3 : Persamaan Nonlinear (Metode Grafik + Metode Biseksi)

function Kasus3_SPNL()
clc; close all;

%% 1. MERUMUSKAN PERSAMAAN NONLINEAR
V_bola = 300;                              % volume bola (cm^3)
% Perbandingan V_tabung : V_bola = (pi r^2 (2r)) : (4/3 pi r^3) = 2 : 4/3 = 3 : 2
V_tabung = V_bola * (2) / (4/3);           % = 450 cm^3
V_luar   = V_tabung - V_bola;              % = 150 cm^3  (bagian tabung di luar bola)

% V_luar = (2/3) pi r^3   ->   f(r) = (2/3) pi r^3 - V_luar = 0
f = @(r) (2/3)*pi*r.^3 - V_luar;

fprintf('===== KASUS 3 : PERSAMAAN NONLINEAR (BISEKSI) =====\n');
fprintf('V bola   = %.2f cm^3\n', V_bola);
fprintf('V tabung = %.2f cm^3 (perbandingan V tabung : V bola = 3 : 2)\n', V_tabung);
fprintf('V luar   = %.2f cm^3\n', V_luar);
fprintf('Persamaan nonlinear : f(r) = (2/3)*pi*r^3 - %.0f = 0\n\n', V_luar);

%% 2. METODE GRAFIK UNTUK MENENTUKAN NILAI AWAL
r_plot = 0:0.01:10;
figure(1);
subplot(1,2,1);
plot(r_plot, f(r_plot), 'b-', 'LineWidth', 2); hold on;
plot([0 10], [0 0], 'k-');                       % sumbu f(r) = 0
hold off; grid on;
xlabel('r (cm)'); ylabel('f(r)');
title('Grafik f(r) pada 0 \leq r \leq 10');

subplot(1,2,2);
r_zoom = 3:0.01:6;
plot(r_zoom, f(r_zoom), 'b-', 'LineWidth', 2); hold on;
plot([3 6], [0 0], 'k-');
plot([4 4], [f(4) 0], 'r--', 'LineWidth', 1.5);  % batas bawah a
plot([5 5], [0 f(5)], 'r--', 'LineWidth', 1.5);  % batas atas  b
plot(4, f(4), 'ro', 'MarkerFaceColor', 'r');
plot(5, f(5), 'go', 'MarkerFaceColor', 'g');
hold off; grid on;
xlabel('r (cm)'); ylabel('f(r)');
title('Zoom 3 \leq r \leq 6 : akar berada di [4, 5]');

fprintf('Tabel tanda f(r) untuk memilih selang awal\n');
fprintf('%5s %12s %10s\n', 'r', 'f(r)', 'tanda');
for r = 0:1:8
    fprintf('%5d %12.4f %10s\n', r, f(r), ternary(f(r) > 0, '+', '-'));
end

a = 4;  b = 5;                                       % selang awal dari grafik
fprintf('\nSelang awal [a,b] = [%d,%d] : f(a) = %.4f, f(b) = %.4f -> f(a)*f(b) < 0\n\n', ...
        a, b, f(a), f(b));

%% 3. METODE BISEKSI
tol   = 1e-6;                                        % toleransi lebar selang
maxit = 100;
fprintf('%4s %10s %10s %10s %12s %12s %12s\n', ...
        'Iter', 'a', 'b', 'c', 'f(a)', 'f(c)', '|b-a|');
for i = 1:maxit
    c  = (a + b)/2;
    fa = f(a);   fc = f(c);
    a_tampil = a;  b_tampil = b;
    if fa*fc < 0
        b = c;                                       % akar di [a, c]
    else
        a = c;                                       % akar di [c, b]
    end
    fprintf('%4d %10.6f %10.6f %10.6f %12.6f %12.6f %12.8f\n', ...
            i, a_tampil, b_tampil, c, fa, fc, abs(b-a));
    if fc == 0 || abs(b-a) < tol, break; end
end

%% 4. HASIL AKHIR & VERIFIKASI
r_akar  = c;
t_akar  = 2*r_akar;
r_exact = (3*V_luar/(2*pi))^(1/3);                   % solusi analitik pembanding
fprintf('\nHASIL AKHIR setelah %d iterasi\n', i);
fprintf('  Jari-jari bola & tabung (r) = %.6f cm\n', r_akar);
fprintf('  Tinggi tabung (t = 2r)      = %.6f cm\n', t_akar);
fprintf('  Volume bola   (4/3 pi r^3)  = %.4f cm^3\n', 4/3*pi*r_akar^3);
fprintf('  Volume tabung (pi r^2 t)    = %.4f cm^3\n', pi*r_akar^2*t_akar);
fprintf('  Volume tabung di luar bola  = %.4f cm^3\n', pi*r_akar^2*t_akar - 4/3*pi*r_akar^3);
fprintf('  f(r akar)                   = %.6e\n', f(r_akar));
fprintf('  Solusi analitik r = (225/pi)^(1/3) = %.6f cm | galat = %.2e\n', ...
        r_exact, abs(r_exact - r_akar));
end

%% =========================== FUNGSI PENDUKUNG (subfungsi) ===========================

function out = ternary(cond, a, b)
% Pengganti operator kondisi satu baris
    if cond
        out = a;
    else
        out = b;
    end
end
