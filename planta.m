% Parâmetros estimados
J = 0.001;           % kg.m^2
C = 0.0076;          % Nms/rad
Ke = 7e-4;           % V.s/rad
Kt = 3e-5;           % Nm/A
Ra = 46;             % Ohm
M = 0.1;             % kg
g = 9.81;            % m/s^2
d = 0.1;             % m

% Função de transferência da planta completa
num = Kt / Ra;
den = [J, (C + (Kt*Ke)/Ra), M*g*d];
G = tf(num, den);

% Ganho estático e polo dominante
K_aprox = dcgain(G)
p = pole(G)
tau = 1 / abs(p(1))  % Constante de tempo estimada
G_aprox = tf(K_aprox, [tau 1]);

% Comparando respostas ao degrau
tstep = 0:0.01:2;
step(G, tstep);
legend("resposta ao degrau sistema de segunda ordem")
hold on;
step(G_aprox, tstep);
legend('Resposta ao Degrau');
title('Comparação da resposta ao degrau');
grid on;