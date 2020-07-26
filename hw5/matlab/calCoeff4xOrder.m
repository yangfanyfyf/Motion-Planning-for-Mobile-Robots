function M = calCoeff4xOrder(t, n_order)
    M = zeros(4, n_order+1);
    
    for j = 1:4
         for m = 1:n_order+1
              if m >= j % from getAbeq, m == i, j == k
                  M(j,m) = factorial(m-1) / factorial(m-1-(j-1)) * t^(m-1-(j-1));
              end
         end
    end
    
end