% =========================================================
%         TUGAS PRAKTIKUM 03 - ANONYMOUS FUNCTION
% =========================================================

clc; clear;

% Fungsi pangkat 3
kubik = @(x) x.^3;
kubik(2)          % ans = 8
kubik(1:4)        % ans = [1 8 27 64]

% Fungsi perkalian dua variabel
kali = @(x,y) x.*y;
kali(3,4)         % ans = 12
kali(6,7)         % ans = 42
