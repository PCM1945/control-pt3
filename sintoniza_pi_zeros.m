function [T] = sintoniza_pi_zeros(G, Kp)
    % Função para projetar um controlador PI por cancelamento polo-zero
    % G: função de transferência da planta (TF)
    % Kp: ganho proporcional (escolhido maior que o limite mínimo)
    %
    % Retorna:
    %   T   - função de transferência em malha fechada
    %   info - estrutura com informações da resposta ao degrau

    % Definir variável simbólica 's' para funções de transferência
    s = tf('s');

    % Obter polo dominante da planta
    [z, p, ~] = zpkdata(G, 'v');
    if isempty(p)
        error('A planta fornecida não possui polos.');
    end
    dominante = abs(p(1)); % assumindo 1 polo dominante

    % Calcular Ki com base no polo dominante
    Ki = Kp * dominante;

    % Criar o controlador PI
    C = Kp + Ki/s;

    % Sistema em malha aberta e malha fechada
    L = C * G;
    T = feedback(L, 1);

    % Exibir parâmetros
    disp("parâmetros para o PI")
    fprintf('Kp = %.4f\n', Kp);
    fprintf('Ki = %.4f\n', Ki);
end