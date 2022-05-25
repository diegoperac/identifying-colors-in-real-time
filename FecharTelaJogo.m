try
    stop(TelaJogo.vid)
    closepreview(TelaJogo.vid)
end
disp('Aquisição de Imagem Fechada!!!')


set(TelaJogo.Seg,'CloseRequestFcn','closereq');

closereq
