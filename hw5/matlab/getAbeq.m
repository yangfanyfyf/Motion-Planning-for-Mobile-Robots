function [Aeq,beq]= getAbeq(n_seg, n_order, waypoints, ts, start_cond, end_cond)
    n_all_poly = n_seg*(n_order+1);%未知量个数
    %#####################################################
    % p,v,a,j constraint in start, 
    Aeq_start = zeros(4, n_all_poly); %左边的系数,k=0
    beq_start = zeros(4, 1); %约束右段
    % STEP 2.1: write expression of Aeq_start and beq_start
    %
    %
    %
    %
    beq_start = start_cond';
    t = 0;
    Aeq_start(:, 1:8) = calCoeff4xOrder(t, n_order);
    
    %#####################################################
    % p,v,a constraint in end
    Aeq_end = zeros(4, n_all_poly);
    beq_end = zeros(4, 1);
    % STEP 2.2: write expression of Aeq_end and beq_end
    %
    %
    %
    %
    beq_end = end_cond';
    t = ts(n_seg); 
    Aeq_end(:, n_all_poly - 7 : end) = calCoeff4xOrder(t, n_order);

    %#####################################################
    % position constrain in all middle waypoints
    Aeq_wp = zeros(n_seg-1, n_all_poly);
    beq_wp = zeros(n_seg-1, 1);
    % STEP 2.3: write expression of Aeq_wp and beq_wp
    %
    %
    %
    %
    for i = 1:n_seg %第i段
       beq_wp(i,1) = waypoints(i+1);
       k = 0; % position
       Aeq_wp(i, (i-1)*8+1:i*8) = calCoeff1xOrder(ts(i), n_order, k);
    end

    %#####################################################
    % position continuity constrain between each 2 segments
    Aeq_con_p = zeros(n_seg-1, n_all_poly);
    beq_con_p = zeros(n_seg-1, 1); % no change
    % STEP 2.4: write expression of Aeq_con_p and beq_con_p
    %
    %
    %
    %
    
    for i = 1:n_seg-1 %第i段
       k = 0; % position
       Aeq_con_p(i, (i-1)*8+1:i*8) = calCoeff1xOrder(ts(i), n_order, k);
       Aeq_con_p(i, i*8+1:(i+1)*8) = - calCoeff1xOrder(ts(i)-1, n_order, k);
    end
    %#####################################################
    % velocity continuity constrain between each 2 segments
    Aeq_con_v = zeros(n_seg-1, n_all_poly);
    beq_con_v = zeros(n_seg-1, 1);
    % STEP 2.5: write expression of Aeq_con_v and beq_con_v
    %
    %
    %
    %
    for i = 1:n_seg-1 %第i段
       k = 1; % vol
       Aeq_con_v(i, (i-1)*8+1:i*8) = calCoeff1xOrder(ts(i), n_order, k);
       Aeq_con_v(i, i*8+1:(i+1)*8) = - calCoeff1xOrder(ts(i)-1, n_order, k);
    end
    
    %#####################################################
    % acceleration continuity constrain between each 2 segments
    Aeq_con_a = zeros(n_seg-1, n_all_poly);
    beq_con_a = zeros(n_seg-1, 1);
    % STEP 2.6: write expression of Aeq_con_a and beq_con_a
    %
    %
    %
    %
    for i = 1:n_seg-1 %第i段
       k = 2; % acc
       Aeq_con_a(i, (i-1)*8+1:i*8) = calCoeff1xOrder(ts(i), n_order, k);
       Aeq_con_a(i, i*8+1:(i+1)*8) = - calCoeff1xOrder(ts(i)-1, n_order, k);
    end
    
    %#####################################################
    % jerk continuity constrain between each 2 segments
    Aeq_con_j = zeros(n_seg-1, n_all_poly);
    beq_con_j = zeros(n_seg-1, 1);
    % STEP 2.7: write expression of Aeq_con_j and beq_con_j
    %
    %
    %
    %
    
    for i = 1:n_seg-1 %第i段
       k = 3; % jerk
       Aeq_con_j(i, (i-1)*8+1:i*8) = calCoeff1xOrder(ts(i), n_order, k);
       Aeq_con_j(i, i*8+1:(i+1)*8) = - calCoeff1xOrder(ts(i)-1, n_order, k);
    end
    
    %#####################################################
    % combine all components to form Aeq and beq   
    Aeq_con = [Aeq_con_p; Aeq_con_v; Aeq_con_a; Aeq_con_j];
    beq_con = [beq_con_p; beq_con_v; beq_con_a; beq_con_j];
%     size(Aeq_start)
%     size(Aeq_end)
%     size(Aeq_wp)
%     size(Aeq_con)
    Aeq = [Aeq_start; Aeq_end; Aeq_wp; Aeq_con];
    beq = [beq_start; beq_end; beq_wp; beq_con];
end