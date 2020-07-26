function M = calCoeff1xOrder(t, n_order, k)

    M = zeros(1, n_order + 1);
    
    for i = 0:n_order % 1:8
        if i >= k
            M(1, i+1) = factorial(i) / factorial(i - k) * t^(i - k);
        end
    end 
    
end