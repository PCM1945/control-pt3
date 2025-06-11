% Definição da planta
num_p = 6.65e-6;
den_p = [1 3.85];
Gp = tf(num_p, den_p);

% Definindo os parâmetros do controlador PI com cancelamento de polo
Ti = 0.101; % contante de tempo do sistema 
Tt = 0.1; %constante de tempo desejada para o controlador 
Kp = 1/(num_p * Tt);  
C_PI = Kp * tf([Ti 1], [Ti 1]);  % C_PI(s) = Kp * (Ti*s + 1)/(Ti*s)

% Malha aberta
L = series(C_PI, Gp);

% Malha fechada com realimentação unitária
T = feedback(L, 1);

% Análise de desempenho
step(T, 'r')
title('Resposta ao Degrau do Sistema em Malha Fechada')

info = stepinfo(T);
disp('--- Desempenho da Resposta ao Degrau ---');
disp(info);

% Esse comando retorna uma estrutura com dados como:

%RiseTime: Tempo de subida (do 10% ao 90% do valor final)

%SettlingTime: Tempo de acomodação (normalmente 2% de tolerância)

%Overshoot: Sobressinal (quanto ultrapassa o valor final)

%Peak: Valor máximo atingido

%PeakTime: Tempo em que ocorre o pico

%SteadyStateValue: Valor de regime (normalmente 1 se entrada é um degrau unitário)