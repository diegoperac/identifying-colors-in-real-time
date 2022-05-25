if TelaJogo.Botoes(4).Value == 1
    % Mostrar figura e sequência de segmentações
    set(TelaJogo.Seg,'visible','on')
    
    ImagemJogo.Mapa(1).Cor = [1 0 0];
    ImagemJogo.Mapa(2).Cor = [0 1 0];
    ImagemJogo.Mapa(3).Cor = [0 0 1];
    ImagemJogo.Mapa(4).Cor = [1 1 0];
    ImagemJogo.Mapa(5).Cor = [0 1 1];
    ImagemJogo.Mapa(6).Cor = [1 0 1];
    ImagemJogo.Mapa(7).Cor = [1 1 1];
    
    
    % Criar código
    for ii = 1:7
        for jj = 1:3
            ImagemJogo.Icor{ii}(:,:,jj) = ImagemJogo.If(:,:,ii)*255*ImagemJogo.Mapa(ii).Cor(jj);
        end
        imshow(ImagemJogo.Icor{ii},'Parent',TelaJogo.SegSub(ii))
        
        if ii == 1
            ImagemJogo.Icor{8} = ImagemJogo.Icor{ii};
        else
            ImagemJogo.Icor{8} = ImagemJogo.Icor{8} + ImagemJogo.Icor{ii};
        end
    end
    imshow(ImagemJogo.Icor{8},'Parent',TelaJogo.SegSub(8))
    drawnow
else
    % Ocultar Figura
    set(TelaJogo.Seg,'visible','off')
end