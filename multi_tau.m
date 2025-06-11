% Definição da planta
num_p = 6.65e-6;
den_p = [1 3.85];
Gp = tf(num_p, den_p);

% Vetor com três constantes de tempo desejadas
taus = [0.2, 0.5, 1.0];

% Inicialização da figura
figure;
hold on;

% Cores para as curvas
cores = ['r', 'g', 'b'];

for i = 1:length(taus)
    Tt = taus(i)           % constante de tempo desejada
    Kp = 1 / (num_p * Tt);  % ganho proporcional do PI
    Ti = 0.101;             % constante de tempo do integrador mantida fixa

    % Controlador PI
    C_PI = Kp * tf([Ti 1], [Ti 1]);

    % Malha aberta e fechada
    L = series(C_PI, Gp);
    T_sys = feedback(L, 1);

    % Resposta ao degrau
    step(T_sys, cores(i))
    hold on
end

% Gráficos e legendas
title('Resposta ao Degrau com Diferentes Constantes de Tempo Desejadas (\tau)')
xlabel('Tempo (s)')
ylabel('Saída')
legend('show');
grid on;
