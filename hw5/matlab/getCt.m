function Ct = getCt(n_seg, n_order)
    %#####################################################
    % STEP 2.1: finish the expression of Ct
    %
    %
    %
    %
    %
    ROW = 8 * n_seg;
    COL = 4 * n_seg + 4;
    
    Ct = zeros(ROW, COL);
    
    for i = 1 : ROW
        if (i >= 1 && i <= 4) % 0 
            Ct(i,i) = 1;
            continue;
        elseif (i >= (ROW - 3) && i <= ROW) % K
            kNum = n_seg + 4 + mod(i+3, 8);
            Ct(i, kNum ) = 1;
            continue;
        end
        
        Num = mod(i+3, 8);
        if (Num == 0) % p
            pNum = (i+3) / 8;
            Ct(i, pNum+4) = 1;
            Ct(i+4, pNum+4) = 1;
        elseif (Num == 1 || Num == 2 || Num == 3) % v, a, j
            vajNum = n_seg + 7 + (floor((i+3)/8)-1)*3 + Num;
            Ct(i, vajNum) = 1;
            Ct(i + 4, vajNum) = 1;
        end

    end
end