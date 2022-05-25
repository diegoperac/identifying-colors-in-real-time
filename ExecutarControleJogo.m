if Partida.EmExecucao == 0    
    % Parar | Iniciar Laço de Processamento de Imagem
    Partida.EmExecucao = 1;
    set(TelaJogo.Botoes(8),'string','Parar Rotina')
    
    % Travar | Liberar a exibição da segmentação
    set(TelaJogo.Botoes(4),'Enable','on')
    
    % Travar | Liberar a seleção de novo background
    set(TelaJogo.Botoes(6),'Enable','off')
    
    % Rotina de controle em tempo real da partida 
    % |||||||||| Ver a possibilidade de usar TIMER de 100ms
    t = tic;
    while Partida.EmExecucao == 1
        if toc(t) > 0.1
            t = tic;
            ProcessarImagemJogo;            
            
            figure(TelaJogo.Principal)
            for ii = 1:length(R)
                R(ii).c_apagar_cad
                R(ii).c_plotar_cad
            end
            drawnow
        end
    end
else
    % Parar | Iniciar Laço de Processamento de Imagem
    Partida.EmExecucao = 0;
    set(TelaJogo.Botoes(8),'string','Iniciar Rotina');
    
    % Travar | Liberar a exibição da segmentação
    set(TelaJogo.Botoes(4),'Enable','off','Value',0)
    set(TelaJogo.Seg,'visible','off')
    
    % Travar | Liberar a seleção de novo background
    set(TelaJogo.Botoes(6),'Enable','on')
end