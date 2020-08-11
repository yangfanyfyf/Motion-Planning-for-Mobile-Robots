function log = getLog(K, dt, p_0, v_0, a_0, Path, num)
    
    Vxy_min = -6;
    Vxy_max = 6;
    Vz_min = -1;
    Vz_max = 6;
    Axy_min = -3;
    Axy_max = 3;
    Az_min = -1;
    Az_max = 3;
    Jxy_min = -3;
    Jxy_max = 3;
    Jz_min = -2;
    Jz_max = 2;

    
    w1 = 1;
    w2 = 1;
    w3 = 1;
    w4 = 1;
    log = [];
    i = 1;
    
    for t = 0.2:0.2:(size(Path(:, num), 1) - K) * dt
        
        p = Path(i : i + K - 1, num);
        
        [Tp, Tv, Ta, Bp, Bv, Ba] = getPredictionMatrix(K, dt, p_0, v_0, a_0); %预测的时长都是4s，但是每次预测只执行0.2s
        
        H = w4 * eye(K) + w1 * (Tp'*Tp) + w2 * (Tv'*Tv) + w3 * (Ta'*Ta);

        F = w1 * (Bp' - p') * Tp + w2 * Bv' *Tv + w3 * Ba' * Ta;
        
        A = [Tv; -Tv; Ta; -Ta; eye(K); -eye(K)]; % 硬约束
        
        if (num == 3) % Z轴约束
            b = [Vz_max * ones(20,1) - Bv; - Vz_min * ones(20,1) + Bv; Az_max * ones(20,1) - Ba; - Az_min * ones(20,1) + Ba; ...
                Jz_max * ones(20,1); - Jz_min * ones(20,1)];
        else %X，Y轴约束
            b = [Vxy_max * ones(20,1) - Bv; - Vxy_min * ones(20,1) + Bv; Axy_max * ones(20,1) - Ba; - Axy_min * ones(20,1) + Ba; ...
                Jxy_max * ones(20,1); - Jxy_min * ones(20,1)];
        end

        J = quadprog(H, F, A, b);

        j = J(1);

        p_0 = p_0 + v_0 * dt + 0.5 * a_0 * dt^2 + 1/6 * j * dt^3;
        v_0 = v_0 + a_0 * dt + 0.5 * j * dt^2;
        a_0 = a_0 + j * dt;

        log = [log; t, p_0, v_0, a_0];
        
        i = i + 1;
    end

end