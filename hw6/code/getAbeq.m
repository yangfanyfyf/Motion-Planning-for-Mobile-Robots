function [Aeq, beq] = getAbeq(n_seg, n_order, ts, start_cond, end_cond)
    n_all_poly = n_seg*(n_order+1);
    % no transition point constraints ?????
    % only p v a, no j
    %#####################################################
    % STEP 2.1 p,v,a constraint in start 
    Aeq_start = zeros(3, n_all_poly); 
    beq_start = start_cond';
    
    Aeq_start(1,1) = 1*ts(1,1); % 相当于坐标变换，P=M*c
    Aeq_start(2, 1:2) = n_order * [-1 1] * ts(1,1)^(0);
    Aeq_start(3, 1:3) = n_order * (n_order - 1) * [1 -2 1] * ts(1,1)^(-1);
    
    %#####################################################
    % STEP 2.2 p,v,a constraint in end
    Aeq_end = zeros(3, n_all_poly);
    beq_end = end_cond';
    
    Aeq_end(1, end) = 1*ts(n_seg,1);
    Aeq_end(2, (end-1):end) = n_order * [-1 1] * ts(n_seg,1)^(0);
    Aeq_end(3, (end-2):end) = n_order * (n_order - 1) * [1 -2 1] * ts(n_seg,1)^(-1);
    
    %#####################################################
    % STEP 2.3 position continuity constrain between 2 segments
    Aeq_con_p = zeros(n_seg - 1, n_all_poly);
    beq_con_p = zeros(n_seg - 1, 1);
    
    for k = 1:n_seg-1
        indexCol = k * (n_order + 1);
        Aeq_con_p(k, indexCol) = 1 * ts(k,1)^(1); % 第k段最后一个控制点和k+1段第一个控制点
        Aeq_con_p(k, indexCol + 1) = -1 * ts(k+1,1)^(1);
    end
    
    %#####################################################
    % STEP 2.4 velocity continuity constrain between 2 segments
    Aeq_con_v = zeros(n_seg-1, n_all_poly);
    beq_con_v = zeros(n_seg-1, 1);
    
    for k = 1:n_seg-1
        indexCol = k * (n_order + 1);
        Aeq_con_v(k, indexCol-1:indexCol) = n_order * [-1 1] * ts(k,1)^(0); % 最后两个控制点
        Aeq_con_v(k, indexCol+1:indexCol+2) = - n_order * [-1 1] * ts(k+1,1)^(0); % 起始两个控制点
    end
    
    %#####################################################
    % STEP 2.5 acceleration continuity constrain between 2 segments
    Aeq_con_a = zeros(n_seg-1, n_all_poly);
    beq_con_a = zeros(n_seg-1, 1);
    
    for k = 1:n_seg-1
        indexCol = k * (n_order + 1);
        Aeq_con_a(k,indexCol-2:indexCol) = n_order * (n_order - 1) * [1 -2 1] * ts(k,1)^(-1); % 最后3个
        Aeq_con_a(k,indexCol+1:indexCol+3) = - n_order * (n_order - 1) * [1 -2 1] * ts(k+1,1)^(-1); 
    end    
    
    %#####################################################
    % combine all components to form Aeq and beq   
    Aeq_con = [Aeq_con_p; Aeq_con_v; Aeq_con_a];
    beq_con = [beq_con_p; beq_con_v; beq_con_a];
    Aeq = [Aeq_start; Aeq_end; Aeq_con];
    beq = [beq_start; beq_end; beq_con];
    
end