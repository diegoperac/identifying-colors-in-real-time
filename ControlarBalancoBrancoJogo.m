if TelaJogo.Botoes(2).Value == 1    
    set(TelaJogo.vid.Source,'WhiteBalanceMode','manual')
    set(TelaJogo.Botoes(2),'string','Branco: Manual')
else
    set(TelaJogo.vid.Source,'WhiteBalanceMode','auto')
    set(TelaJogo.Botoes(2),'string','Branco: Auto')
end