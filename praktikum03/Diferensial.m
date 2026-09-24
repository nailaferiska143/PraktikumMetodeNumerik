% =========================================================
%               TUGAS PRAKTIKUM 03 - DIFERENSIAL
% =========================================================

% Diferensial
function hasil = Diferensial()
    syms x
    f = input('Masukkan bentuk persamaan f(x) = ');
    f_asli = sym(f);
    hasil = diff(f_asli, x)
end
