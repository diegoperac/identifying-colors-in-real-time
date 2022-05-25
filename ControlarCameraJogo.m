if Partida.CameraLigada == 0
    Partida.CameraLigada = 1;
    set(TelaJogo.Botoes(5),'string','Parar Câmera')
    
    set(TelaJogo.Botoes(1:3),'Enable','on')
    set(TelaJogo.Botoes(6),'Enable','on')
    
    TelaJogo.vid = videoinput('dcam');
    TelaJogo.vid.FramesPerTrigger = 1;
    triggerconfig(TelaJogo.vid,'manual');
    
    if ~isrunning(TelaJogo.vid)
        start(TelaJogo.vid)
        disp('Aquisição de Imagem Iniciada!!!')
    end
else
    Partida.CameraLigada = 0;
    set(TelaJogo.Botoes(5),'string','Iniciar Câmera')
    
    % Habilitar | Desabilitar Preview, Balanço e Ganho de Branco 
    set(TelaJogo.Botoes(1:3),'Value',0);    
    set(TelaJogo.Botoes(1:3),'Enable','off')
    
    % Habilitar | Desabilitar background
    set(TelaJogo.Botoes(6),'Enable','off')       
    
     % Parar | Iniciar Laço de Processamento de Imagem
    Partida.EmExecucao = 0;
    set(TelaJogo.Botoes(8),'string','Iniciar Rotina');    
    set(TelaJogo.Botoes(8),'enable','off');
    
    % Travar | Liberar a exibição da segmentação
    set(TelaJogo.Botoes(4),'Enable','off','Value',0)    
    set(TelaJogo.Seg,'visible','off')
    
    
    % Travar | Liberar a seleção de novo background
    set(TelaJogo.Botoes(6),'Enable','off')
    
    try
        stop(TelaJogo.vid)
        closepreview(TelaJogo.vid)
    end
    disp('Aquisição de Imagem Fechada!!!')
end
