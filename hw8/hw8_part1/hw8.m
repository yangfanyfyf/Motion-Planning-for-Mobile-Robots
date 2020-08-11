clc; clear; close all;

% 0.08在40s内不能形成螺旋线
W = 0.8;
V = -0.5;
dt = 0.2;
K = 20;
% initial state
p_0 = [8, 0, 20];
v_0 = zeros(1,3);
a_0 = zeros(1,3);

Path = [];
for t = 0:0.2:8
    p_t = [-t 0 0];
    Path = [Path; p_0 + p_t];
end

%plot3(Path(:,1), Path(:,2), Path(:, 3))

for t = 8:0.2:48
    r = 0.25 * (t-8); % r = 10
    p_t = [r*sin(W*t), r*cos(W*t), -0.5*(t-8)];
    Path = [Path; [0 0 20] + p_t];
    
end
% Path
% plot3(Path(:,1), Path(:,2), Path(:, 3))

logX = getLog(K, dt, p_0(1), v_0(1), a_0(1), Path, 1);
logY = getLog(K, dt, p_0(2), v_0(2), a_0(2), Path, 2);
logZ = getLog(K, dt, p_0(3), v_0(3), a_0(3), Path, 3);
% plot(logX(:, 2))
% 
scatter3(8, 0, 20, 100, 'filled');
hold on;
plot3(logX(:, 2), logY(:, 2), logZ(:, 2), 'r', 'LineWidth', 1);

% figure;
% plot(logX(:, 2:4));
% legend('p', 'v', 'a');

