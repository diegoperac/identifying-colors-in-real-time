tic
ImagemJogo.Im = getsnapshot(TelaJogo.vid);

ImagemJogo.Isub = imsubtract(ImagemJogo.Im,ImagemJogo.Background);

ImagemJogo.Isub = imresize(ImagemJogo.Isub,0.5);

% Realizar sequência de segmentação

ImagemJogo.Camada = [1 1 2 2 3 3];

ImagemJogo.se = strel('square',11);

% Criar conjunto de cores em várias camadas.
for ii = 1:7
    ImagemJogo.Iseg = ImagemJogo.Isub(:,:,1) >= 0;
    for jj = 1:6
        if mod(jj,2)
            ImagemJogo.Iseg = ImagemJogo.Iseg & (ImagemJogo.Isub(:,:,ImagemJogo.Camada(jj)) >= CoresSegmentacao(ii,jj));
        else
            ImagemJogo.Iseg = ImagemJogo.Iseg & (ImagemJogo.Isub(:,:,ImagemJogo.Camada(jj)) <= CoresSegmentacao(ii,jj));
        end
    end
    
    % Filtragem das camadas: Dilatação e Passa-Baixas (Blurring)
    
    %ImagemJogo.If(:,:,ii) = imfilter(ImagemJogo.Iseg(:,:),fspecial('average', 3));
    %ImagemJogo.If(:,:,ii) = imclose(ImagemJogo.If(:,:,ii),ImagemJogo.se);
    %ImagemJogo.Reg(ii).Props = regionprops(ImagemJogo.If(:,:,ii));
    
    ImagemJogo.If(:,:,ii) = ImagemJogo.Iseg;
    
    % Criar regiões separadas por cor
    ImagemJogo.Reg.Props{ii} = regionprops(ImagemJogo.Iseg);
end


% Criar vetores de centroide
for ii = 1:7
    kk = 1;
    ImagemJogo.Reg.Cores{ii} = [];
    for jj = 1:length(ImagemJogo.Reg.Props{ii})
        % Eliminar ruído por área na imagem
        if ImagemJogo.Reg.Props{ii}(jj).Area > 20 % pixels : criar variável
            ImagemJogo.Reg.Cores{ii}(kk,:) = ImagemJogo.Reg.Props{ii}(jj).Centroid;
            kk = kk + 1;
        end
    end
end

% Iniciar a associar das cores com os jogadores
% Jogadores são definidor por: Vermelho, Verde e Magenta

% Analisar a possibilidade de um jogador nosso ter a mesma cor de um
% jogador adversário

% Selecionar a cor do robô
% Se Amarelo
ImagemJogo.Reg.CoresTime = ImagemJogo.Reg.Cores{4};
ImagemJogo.Reg.CoresJogador = [ImagemJogo.Reg.Cores{1}; ImagemJogo.Reg.Cores{2}; ImagemJogo.Reg.Cores{6}];
ImagemJogo.Reg.CoresJogador = [ImagemJogo.Reg.CoresJogador [1*ones(size(ImagemJogo.Reg.Cores{1},1),1); 2*ones(size(ImagemJogo.Reg.Cores{2},1),1); 6*ones(size(ImagemJogo.Reg.Cores{6},1),1)]];


distColetivaMin = inf;
indmin = 1;

% Verificar se há mais indicadores de times que de jogadores
if size(ImagemJogo.Reg.CoresTime,1) > size(ImagemJogo.Reg.CoresJogador,1)
    indmin = 1;
    ind = perms(1:size(ImagemJogo.Reg.CoresTime,1));
    
    if ~isempty(ind)
        for ii = 1:size(ind,1)
            distColetiva = [];
            
            % Testar para as situações com menos ou mais de três jogadores
            for jj = 1:size(ImagemJogo.Reg.CoresJogador,1)
                distColetiva = norm(ImagemJogo.Reg.CoresJogador(jj,1:2) - ImagemJogo.Reg.CoresTime(ind(ii,jj),1:2));
            end
            [ii distColetiva]
            if distColetivaMin > distColetiva
                distColetivaMin = distColetiva;
                indmin = ii;
            end
        end
    end
    disp(['indmin: ' num2str(indmin)])
else
    distColetivaMin = inf;
    
    ind = perms(1:size(ImagemJogo.Reg.CoresJogador,1));
    
    if ~isempty(ind)
        for ii = 1:size(ind,1)
            distColetiva = [];
            
            % Testar para as situações com menos ou mais de três jogadores
            for jj = 1:size(ImagemJogo.Reg.CoresTime,1)
                distColetiva = norm(ImagemJogo.Reg.CoresTime(jj,1:2) - ImagemJogo.Reg.CoresJogador(ind(ii,jj),1:2));
            end
            [ii distColetiva]
            if distColetivaMin > distColetiva
                distColetivaMin = distColetiva;
                indmin = ii;
            end
        end
        disp(['indmin 2: ' num2str(indmin)])
        
        % Reposicionar os jogadores
        
%         for jj = 1:size(ImagemJogo.Reg.CoresTime,1)
%             % J(jj).pPos.IX(1:2,1) = mean([ImagemJogo.Reg.CoresTime(jj,1:2)' ImagemJogo.Reg.CoresJogador(ind(indmin,jj),1:2)'],2);
%             R(jj).Pos.X(1:2,1) = [TelaJogo.px2m.X(1) 0; 0 TelaJogo.px2m.Y(1)]*...
%                 mean([ImagemJogo.Reg.CoresTime(jj,1:2)' ImagemJogo.Reg.CoresJogador(ind(indmin,jj),1:2)'],2) + [TelaJogo.px2m.X(2);TelaJogo.px2m.Y(2)];
%         end
        for jj = 1:size(ImagemJogo.Reg.CoresTime,1)
            % J(jj).pPos.IX(1:2,1) = mean([ImagemJogo.Reg.CoresTime(jj,1:2)' ImagemJogo.Reg.CoresJogador(ind(indmin,jj),1:2)'],2);
            R(jj).Pos.X(1:2,1) = [TelaJogo.px2m.X(1) 0; 0 TelaJogo.px2m.Y(1)]*...
                ImagemJogo.Reg.CoresTime(jj,1:2)' + [TelaJogo.px2m.X(2);TelaJogo.px2m.Y(2)];
        end
        
    end            
end

% Reposicionar os jogadores

for jj = 1:size(ImagemJogo.Reg.CoresTime,1)
    % J(jj).pPos.IX(1:2,1) = mean([ImagemJogo.Reg.CoresTime(jj,1:2)' ImagemJogo.Reg.CoresJogador(ind(indmin,jj),1:2)'],2);
    R(jj).Pos.X(1:2,1) = [TelaJogo.px2m.X(1) 0; 0 TelaJogo.px2m.Y(1)]*...
        2*ImagemJogo.Reg.CoresTime(jj,1:2)' + [TelaJogo.px2m.X(2);TelaJogo.px2m.Y(2)];
end


% Se Ciano
% ImagemJogo.Reg.CoresTime = ImagemJogo.Reg.Cores{5};


ControlarSegmentacaoJogo

toc;