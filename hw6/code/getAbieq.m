function [Aieq, bieq] = getAbieq(n_seg, n_order, corridor_range, ts, v_max, a_max)
    n_all_poly = n_seg*(n_order+1);
    
    
    
    %#####################################################
    % STEP 3.2.1 p constraint
    Aieq_p = zeros(2*n_all_poly, n_all_poly);
    bieq_p = zeros(2*n_all_poly, 1);
    
    for i = 1:n_seg
        for j = 1:n_order+1
            index = j + (i-1)*(n_order+1);
            Aieq_p(index, index) = 1 * ts(i,1)^(1);
            Aieq_p(index+n_all_poly, index) = - 1 * ts(i,1)^(1);
            
            bieq_p(index, 1) = corridor_range(i,2);
            bieq_p(index+n_all_poly, 1) = - corridor_range(i,1);
        end
    end
    
    
    %#####################################################
    % STEP 3.2.2 v constraint   
    
    num = n_seg * n_order;
    
    Aieq_v = zeros(2*num, n_all_poly);
    bieq_v = zeros(2*num, 1);
    for i = 1:n_seg
        for j = 1:n_order 
            index = j + (i-1)*n_order;
            
            Aieq_v(index, index:index+1) = n_order * [-1 1] * ts(i,1)^(0);
            Aieq_v(index + num, index:index+1) = - n_order * [-1 1] * ts(i,1)^(0);
            
            bieq_v(index, 1) = v_max;
            bieq_v(index + num, 1) = v_max;
        end
    end
    
    %#####################################################
    % STEP 3.2.3 a constraint   
    num = n_seg * (n_order - 1);
    Aieq_a = zeros(2*num, n_all_poly);
    bieq_a = zeros(2*num, 1);
    
    for i = 1:n_seg
        for j = 1:n_order - 1 
            index = j + (i-1)*(n_order-1);
            
            Aieq_a(index, index:index+2) = n_order * (n_order-1) * [1 -2 1] * ts(i,1)^(-1);
            Aieq_a(index + num, index:index+2) = - n_order * (n_order-1) * [1 -2 1] * ts(i,1)^(-1);
            
            bieq_a(index, 1) = a_max;
            bieq_a(index + num, 1) = a_max;
        end
    end
    
    %#####################################################
    % combine all components to form Aieq and bieq   
    
    Aieq = [Aieq_p; Aieq_v; Aieq_a];
    bieq = [bieq_p; bieq_v; bieq_a];
    
    
    % ?
    %Aieq = Aieq_p;
    %bieq = bieq_p;
end