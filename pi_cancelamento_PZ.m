% Função de transferência da planta
s = tf('s');
G = 6.65e-6 / (s + 3.85);

% Controlador PI usando cancelamento polo-zero
Kp = 2; % maior que 1.158
Ki = Kp * 3.85;

C = Kp + Ki/s;

% Sistema em malha aberta e malha fechada
L = C * G; % malha aberta
T = feedback(L, 1); % malha fechada

% Exibir parâmetros
disp(['Kp = ', num2str(Kp)]);
disp(['Ki = ', num2str(Ki)]);
disp('Função de transferência em malha fechada:')
T

info = stepinfo(T);
disp('--- Desempenho da Resposta ao Degrau ---');
disp(info);
% Plotar a resposta ao degrau

figure;
pzmap(T);
title('Mapa Polo-Zero da malha fechada');
grid on;


figure;
step(T)
title('Resposta ao Degrau do Sistema com Controlador PI (Cancelamento Polo-Zero)')
grid on
