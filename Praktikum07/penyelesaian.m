1;  % penanda file skrip
%% Penyelesaian: Biseksi dan Regula-Falsi

%% ===================== FUNGSI =====================
function c = Biseksi(f, a, b, n, tol)
    fa = f(a);  fb = f(b);
    if fa*fb > 0
        error('Peringatan: f(a) dan f(b) bertanda sama.');
    end
    fprintf('\nMetode Biseksi\n');
    fprintf('Iter\ta\t\tb\t\tf(a)\t\tf(b)\t\tc\t\tf(c)\t\terror\n');
    c_lama = NaN;
    for i = 1:n
        c  = (a + b)/2;                  % titik tengah
        fc = f(c);
        err = abs(c - c_lama);
        if i == 1
            fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\t-\n', i, a, b, fa, fb, c, fc);
        else
            fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', i, a, b, fa, fb, c, fc, err);
        end
        if fc == 0 || (i > 1 && err <= tol)
            break;
        end
        if fa*fc < 0
            b = c;  fb = fc;
        else
            a = c;  fa = fc;
        end
        c_lama = c;
    end
    fprintf('Akar = %.5f (iterasi: %d)\n', c, i);
end

function c = RegulaFalsi(f, a, b, n, tol)
    fa = f(a);  fb = f(b);
    if fa*fb > 0
        error('Peringatan: f(a) dan f(b) bertanda sama.');
    end
    fprintf('\nMetode Regula-Falsi\n');
    fprintf('Iter\ta\t\tb\t\tf(a)\t\tf(b)\t\tc\t\tf(c)\t\terror\n');
    c_lama = NaN;
    for i = 1:n
        c  = (a*fb - b*fa)/(fb - fa);    % perpotongan garis lurus dengan sumbu x
        fc = f(c);
        err = abs(c - c_lama);
        if i == 1
            fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\t-\n', i, a, b, fa, fb, c, fc);
        else
            fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', i, a, b, fa, fb, c, fc, err);
        end
        if fc == 0 || (i > 1 && err <= tol)
            break;
        end
        if fa*fc < 0
            b = c;  fb = fc;
        else
            a = c;  fa = fc;
        end
        c_lama = c;
    end
    fprintf('Akar = %.5f (iterasi: %d)\n', c, i);
end

%% ===================== PROGRAM UTAMA =====================
clc;

n   = 20;
tol = 1e-4;

f1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 8;      % persamaan 1 (y = 1 dipindah ke kiri)
f2 = @(x) exp(x) - x.^2;                  % persamaan 2
f3 = @(x) log(x + 2) + 2*x - 3;           % persamaan 3 (log = ln; basis 10 -> log10)

disp('=== PERSAMAAN 1 ===');  a = 1;  b = 2;
c1_bis = Biseksi(f1, a, b, n, tol);
c1_reg = RegulaFalsi(f1, a, b, n, tol);

disp('=== PERSAMAAN 2 ===');  a = -1; b = 0;
c2_bis = Biseksi(f2, a, b, n, tol);
c2_reg = RegulaFalsi(f2, a, b, n, tol);

disp('=== PERSAMAAN 3 ===');  a = 0;  b = 2;
c3_bis = Biseksi(f3, a, b, n, tol);
c3_reg = RegulaFalsi(f3, a, b, n, tol);

fprintf('\n=== REKAPITULASI ===\n');
fprintf('Persamaan 1: Biseksi = %.5f | Regula-Falsi = %.5f\n', c1_bis, c1_reg);
fprintf('Persamaan 2: Biseksi = %.5f | Regula-Falsi = %.5f\n', c2_bis, c2_reg);
fprintf('Persamaan 3: Biseksi = %.5f | Regula-Falsi = %.5f\n', c3_bis, c3_reg);
