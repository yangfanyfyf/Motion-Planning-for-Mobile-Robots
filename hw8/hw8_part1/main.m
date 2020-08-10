% initial states
p_0 = 10;
v_0 = 0;
a_0 = 0;
% total time = 4s
K = 20;
dt = 0.2;
% save traj
log = [0, p_0, v_0, a_0];
% weight
w1 = 1;
w2 = 1;
w3 = 1;
w4 = 1;

for t = 0.2:0.2:10
    [Tp, Tv, Ta, Bp, Bv, Ba] = getPredictionMatrix(K, dt, p_0, v_0, a_0);
    
    H = w4 * eye(K) + w1 * (Tp'*Tp) + w2 * (Tv'*Tv) + w3 * (Ta'*Ta);
    
    F = w1 * Bp' * Tp + w2 * Bv' *Tv + w3 * Ba' * Ta;
    
    J = quadprog(H, F, [], []);
    
    j = J(1);
    
    p_0 = p_0 + v_0 * dt + 0.5 * a_0 * dt^2 + 1/6 * j * dt^3;
    v_0 = v_0 + a_0 * dt + 0.5 * j * dt^2;
    a_0 = a_0 + j * dt;
    
    log = [log; t, p_0, v_0, a_0];
end

plot(log(:, 2:4));
legend('p', 'v', 'a');