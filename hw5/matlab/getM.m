function M = getM(n_seg, n_order, ts)
    M = [];
    for k = 1:n_seg
        M_k = zeros(8,n_order+1);
        %#####################################################
        % STEP 1.1: calculate M_k of the k-th segment 
        %
        %
        %
        %
        for i = 1:8
            if i <= 4 %t=0
                t = 0;
                M_k(1:4,:) = calCoeff4xOrder(t, n_order);
            else
                t = ts(k);
                M_k(5:8,:) = calCoeff4xOrder(t, n_order);
            end
        end
    
        M = blkdiag(M, M_k);
    end
end