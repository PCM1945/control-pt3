function [Kp, Ti, Td, T] = sintoniza_pid_zn1(K, a)
% SINTONIZA_PID_ZN1 Sintoniza um controlador PID pelo Método I de Ziegler-Nichols (curva de reação)
% 
% Entradas:
%   K - ganho estático da planta
%   a - polo da planta (tal que G(s) = K / (s + a))
%
% Saídas:
%   Kp, Ti, Td - parâmetros do controlador PID
%   T - função de transferência em malha fechada

    % Constante de tempo da planta
    tau = 1 / a;

    % Atraso estimado (1/10 de tau)
    L = tau / 10;

    % Parâmetros do PID (ZN - Método I)
    Kp = 1.2 * tau / (K * L);
    Ti = 2 * L;
    Td = 0.5 * L;

    % Define variáveis de transferência
    s = tf('s');

    % Controlador PID
    Gc = Kp * (1 + 1/(Ti*s) + Td*s);

    % Planta com atraso
    Gp = K / (tau*s + 1) * exp(-L*s);

    % Malha fechada
    T = feedback(Gc * Gp, 1);
    
    disp("parâmetros PID");
    fprintf('Kp = %.4f\n', Kp);
    fprintf('Ti = %.4f\n', Ti);
    fprintf('Td = %4f\n', Td);
end