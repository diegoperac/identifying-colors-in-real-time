if TelaJogo.Botoes(3).Value == 1    
    set(TelaJogo.vid.Source,'GainMode','manual')
    set(TelaJogo.Botoes(3),'string','Brilho: Manual')
else
    set(TelaJogo.vid.Source,'GainMode','auto')
    set(TelaJogo.Botoes(3),'string','Brilho: Auto')
end