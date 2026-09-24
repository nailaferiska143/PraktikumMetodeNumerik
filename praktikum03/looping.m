% =========================================================
%               TUGAS PRAKTIKUM 03 - LOOPING
% =========================================================

%% 1. For loop - kondisi 1
% Menghitung pangkat 3 dari i, untuk i = 1 sampai 5
clc; clear;
disp('--- For loop kondisi 1 ---')
for i = 1:5
    p = i^3
end

disp('');

%% 2. For loop - kondisi 2
% Menghitung j dikali 2, dengan step 1, dari 2 sampai 6
disp('--- For loop kondisi 2 ---')
for j = 2:1:6
    q = j*2
end

disp('');

%% 3. While loop
% Mengulang selama r <= 6, dengan rumus s = r^2 - r
disp('------- While loop -------')
r = 1;
while (r <= 6)
    s = r^2 - r
    r = r + 1;
end

disp('');

%% 4. Continue
% Melewati (skip) perhitungan ketika i == 4
disp('-------- Continue --------')
for i = 1:5
    if (i == 4)
        continue
    end
    p = i^3
end

disp('');

%% 5. Break
% Menghentikan loop ketika i == 4
disp('--------- Break ---------')
for i = 1:5
    if (i == 4)
        break
    end
    p = i^3
end

