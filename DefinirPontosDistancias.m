TelaJogo.FiguraPontos =  figure; 
imshow(getsnapshot(TelaJogo.vid))

[X,Y] = ginput(15);
Px = [-0.75 -0.75 -0.6 -0.6 -0.375 -0.375 -0.375 0 0.375 0.375 0.375 0.6 0.6 0.75 0.75]';
Py = [-0.2 0.2 -0.35 0.35 -0.4 0 0.4 0 -0.4 0 0.4 -0.35 0.35 -0.2 0.2]';

% Equação que transforma valores do espaço da câmera para o cartesiano
TelaJogo.px2m.X = polyfit(X,Px,1);
TelaJogo.px2m.Y = polyfit(Y,Py,1);

