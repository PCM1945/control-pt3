% Parâmetros da planta
K = 6.65e-6;
tau = 1 / 3.85;
L = tau / 10;

% Parâmetros PID usando Ziegler-Nichols (Método I)
Kp = 1.2 * tau / (K * L)
Ti = 2 * L
Td = 0.5 * L

% Criando controlador PID
s = tf('s');
Gc = Kp * (1 + 1/(Ti*s) + Td*s);

% Planta com atraso
Gp = K / (tau*s + 1) * exp(-L*s);

% Sistema em malha fechada
T = feedback(Gc * Gp, 1);

%Métricas de desempenho
info = stepinfo(T);
disp('--- Desempenho da Resposta ao Degrau ---');
disp(info);

% Resposta ao degrau
step(T)
title('Resposta ao Degrau - Sistema com PID (ZN Método I)')
grid on

