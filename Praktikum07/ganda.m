%% Grafik Ganda

clc; clear; close all;

%% ===== PERSAMAAN 1 : 3x^3-5x^2+4x-7 = 1 =====
figure(1); set(gcf,'Name','Persamaan 1 - Grafik Ganda','Position',[50 400 560 420]);
x  = linspace(-0.5, 3, 400);
y1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 7;
y2 = @(x) 1 + 0*x;
plot(x, y1(x), 'b', x, y2(x), 'r', 'LineWidth', 1.5); hold on; grid on;
line([-0.5 3],[0 0],'Color','k');
line([0 0],[-15 25],'Color','k');
plot(1.77, 1, 'ko', 'MarkerFaceColor', 'k');
text(1.9, 5, 'Akar = 1.77');
ylim([-15 25]); xlabel('x'); ylabel('y');
title({'PERSAMAAN 1 - Grafik Ganda'; 'y_1 = 3x^3-5x^2+4x-7  dan  y_2 = 1'});
legend('y_1 = 3x^3-5x^2+4x-7','y_2 = 1','Location','northwest');
annotation('textbox',[0.60 0.14 0.32 0.12],'String',{'PERSAMAAN 1';'Hasil: x = 1.77'}, ...
    'FitBoxToText','on','BackgroundColor','w','EdgeColor','k','FontWeight','bold');

%% ===== PERSAMAAN 2 : e^x - x^2 = 0 =====
figure(2); set(gcf,'Name','Persamaan 2 - Grafik Ganda','Position',[630 400 560 420]);
x  = linspace(-2, 2, 400);
y1 = @(x) exp(x);
y2 = @(x) x.^2;
plot(x, y1(x), 'b', x, y2(x), 'r', 'LineWidth', 1.5); hold on; grid on;
line([-2 2],[0 0],'Color','k');
line([0 0],[-1 8],'Color','k');
plot(-0.70, 0.49, 'ko', 'MarkerFaceColor', 'k');
text(-1.6, 1.5, 'Akar = -0.70');
ylim([-1 8]); xlabel('x'); ylabel('y');
title({'PERSAMAAN 2 - Grafik Ganda'; 'y_1 = e^x  dan  y_2 = x^2'});
legend('y_1 = e^x','y_2 = x^2','Location','north');
annotation('textbox',[0.60 0.14 0.32 0.12],'String',{'PERSAMAAN 2';'Hasil: x = -0.70'}, ...
    'FitBoxToText','on','BackgroundColor','w','EdgeColor','k','FontWeight','bold');

%% ===== PERSAMAAN 3 : log(x+2) + 2x - 3 = 0 =====
figure(3); set(gcf,'Name','Persamaan 3 - Grafik Ganda','Position',[340 -20 560 420]);
x  = linspace(-1.9, 3, 400);
y1 = @(x) log(x + 2);
y2 = @(x) 3 - 2*x;
plot(x, y1(x), 'b', x, y2(x), 'r', 'LineWidth', 1.5); hold on; grid on;
line([-1.9 3],[0 0],'Color','k');
line([0 0],[-6 6],'Color','k');
plot(0.96, 1.08, 'ko', 'MarkerFaceColor', 'k');
text(1.1, 2.2, 'Akar = 0.96');
ylim([-6 6]); xlabel('x'); ylabel('y');
title({'PERSAMAAN 3 - Grafik Ganda'; 'y_1 = log(x+2)  dan  y_2 = 3 - 2x'});
legend('y_1 = log(x+2)','y_2 = 3 - 2x','Location','northeast');
annotation('textbox',[0.60 0.14 0.32 0.12],'String',{'PERSAMAAN 3';'Hasil: x = 0.96'}, ...
    'FitBoxToText','on','BackgroundColor','w','EdgeColor','k','FontWeight','bold');
