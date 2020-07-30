function [Q, M] = getQM(n_seg, n_order, ts)
    Q = [];
    M = [];
    M_k = getM(n_order);
    for k = 1:n_seg
        %#####################################################
        % STEP 2.1 calculate Q_k of the k-th segment 
        % same as hw5
        Q_k = zeros(n_order+1,n_order+1);
        for i = 0 : n_order
            for l = 0 : n_order
                if (i < 4 || l < 4)
                    continue;
                else
                    Q_k(i+1 ,l+1) = i*(i-1)*(i-2)*(i-3)*l*(l-1)*(l-2)*(l-3)/(i+l-7)*ts(k)^(i+l-7);
                end
            end
        end
        
        Q = blkdiag(Q, Q_k);
        
        M = blkdiag(M, M_k);
    end
end