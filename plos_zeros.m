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
figure;
pzmap(G);
title('Mapa Polo-Zero da Função de Transferência Completa');
grid on;

figure;
pzmap(G_aprox);
title('Mapa Polo-Zero da Aproximação de 1ª Ordem');
grid on;

% Mostrar polos e zeros
disp('Polos da planta completa:');
disp(pole(G));

disp('Zeros da planta completa:');
disp(zero(G));