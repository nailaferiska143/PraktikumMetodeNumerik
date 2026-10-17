%% Grafik Tunggal
clc; clear; close all;

f1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 8;      % 3x^3-5x^2+4x-7 = 1
f2 = @(x) exp(x) - x.^2;                  % e^x - x^2 = 0
f3 = @(x) log(x + 2) + 2*x - 3;           % log(x+2)+2x-3 = 0 (log = ln)

%% ===== PERSAMAAN 1 =====
figure(1); set(gcf,'Name','Persamaan 1 - Grafik Tunggal','Position',[50 400 560 420]);
x = linspace(-0.5, 3, 400);
plot(x, f1(x), 'b', 'LineWidth', 1.5); hold on; grid on;
line([-0.5 3],[0 0],'Color','k');          % sumbu x
line([0 0],[-15 25],'Color','k');          % sumbu y
plot(1.77, 0, 'ro', 'MarkerFaceColor', 'r');
text(1.0, 4, 'Akar = 1.77');
ylim([-15 25]); xlabel('x'); ylabel('y');
title({'PERSAMAAN 1 - Grafik Tunggal'; 'y = 3x^3 - 5x^2 + 4x - 7, dengan y = 1  (f(x) = 3x^3-5x^2+4x-8)'});
legend('f(x)','Location','northwest');
annotation('textbox',[0.60 0.14 0.32 0.12],'String',{'PERSAMAAN 1';'Hasil: x = 1.77 (selang [1,2])'}, ...
    'FitBoxToText','on','BackgroundColor','w','EdgeColor','k','FontWeight','bold');

%% ===== PERSAMAAN 2 =====
figure(2); set(gcf,'Name','Persamaan 2 - Grafik Tunggal','Position',[630 400 560 420]);
x = linspace(-2, 2, 400);
plot(x, f2(x), 'b', 'LineWidth', 1.5); hold on; grid on;
line([-2 2],[0 0],'Color','k');
line([0 0],[-4 3],'Color','k');
plot(-0.70, 0, 'ro', 'MarkerFaceColor', 'r');
text(-1.6, 0.6, 'Akar = -0.70');
ylim([-4 3]); xlabel('x'); ylabel('y');
title({'PERSAMAAN 2 - Grafik Tunggal'; 'y = e^x - x^2, dengan y = 0'});
legend('f(x)','Location','southeast');
annotation('textbox',[0.55 0.55 0.32 0.12],'String',{'PERSAMAAN 2';'Hasil: x = -0.70 (selang [-1,0])'}, ...
    'FitBoxToText','on','BackgroundColor','w','EdgeColor','k','FontWeight','bold');

%% ===== PERSAMAAN 3 =====
figure(3); set(gcf,'Name','Persamaan 3 - Grafik Tunggal','Position',[340 -20 560 420]);
x = linspace(-1.9, 3, 400);
plot(x, f3(x), 'b', 'LineWidth', 1.5); hold on; grid on;
line([-1.9 3],[0 0],'Color','k');
line([0 0],[-12 6],'Color','k');
plot(0.96, 0, 'ro', 'MarkerFaceColor', 'r');
text(1.1, -2, 'Akar = 0.96');
ylim([-12 6]); xlabel('x'); ylabel('y');
title({'PERSAMAAN 3 - Grafik Tunggal'; 'y = log(x+2) + 2x - 3, dengan y = 0'});
legend('f(x)','Location','southeast');
annotation('textbox',[0.55 0.55 0.32 0.12],'String',{'PERSAMAAN 3';'Hasil: x = 0.96 (selang [0,2])'}, ...
    'FitBoxToText','on','BackgroundColor','w','EdgeColor','k','FontWeight','bold');
