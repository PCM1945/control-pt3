close all;
clc;

s = tf('s');
G = 6.65e-6 / (s + 3.85);
Kp = 2; % maior que o mínimo necessário de 1.51

[Tfunc_pi] = sintoniza_pi_zeros(G, Kp);


K = 6.65e-6;
a = 3.85;

[Kp_zn, ki_zn, kd_zn, Tfunc_pid] = sintoniza_pid_zn1(K, a);







% Informações da resposta ao degrau PI cncelamento PZ
info_pi = stepinfo(Tfunc_pi);
disp('--- Desempenho da Resposta ao Degrau - PI sintonizado (cancelamento de polos e zeros) ---');
disp(info_pi);

info_pid = stepinfo(Tfunc_pid);
disp('--- Desempenho da Resposta ao Degrau - PID sintonizado (Ziegler-Nichols) ---')
disp(info_pid)

% Exibe a resposta ao degrau PID ZN
figure;
step(Tfunc_pid)
title('Resposta ao Degrau - PID sintonizado (ZN Método I)')
xlabel('Tempo (s)')
ylabel('Saída')
grid on
%exibe a resposta ao degrau do controlador PI
figure;
step(Tfunc_pi);
title('Resposta ao Degrau do Sistema com Controlador PI (Cancelamento Polo-Zero)');
grid on;

%exibe a comparação entre os dois métodos
figure;
step(Tfunc_pi, 'r');
legend("controlador PI");
hold on;
step(Tfunc_pid, 'b');
legend("cottrolador PID");
grid on

% Plotar plano S para sistem PI
figure;
pzmap(Tfunc_pi);
title('Mapa Polo-Zero da malha fechada PI');
grid on;


