% Used for Motion Planning for Mobile Robots
% Thanks to HKUST ELEC 5660 
close all; clear all; clc;

%图像参数
set(gcf, 'Renderer', 'painters');
set(gcf, 'Position', [500, 50, 700, 700]);

% Environment map in 2D space 
xStart = 1.0;
yStart = 1.0;
xTarget = 9.0;
yTarget = 9.0;
MAX_X = 10;
MAX_Y = 10;
map = obstacle_map(xStart, yStart, xTarget, yTarget, MAX_X, MAX_Y);
%只包括了障碍，是一个随机的矩阵
%MAP才是地图

% Waypoint Generator Using the A* 

path_1 = A_star_search(map, MAX_X, MAX_Y, 1); % 1 for Euclidean
path_2 = A_star_search(map, MAX_X, MAX_Y, 2); % 2 for Manhattan
path_3 = A_star_search(map, MAX_X, MAX_Y, 3); % 3 for Euclidean with tie breaker
path_4 = A_star_search(map, MAX_X, MAX_Y, 4); % 4 for Manhattan with tie breaker
% visualize the 2D grid map
%set(gcf,'position',[100,100, 1000, 800]); 

subplot(2,2,1);
visualize_map(map, path_1);
title('Euclidean');
set(gca,'xTick', [0:1:10]);

subplot(2,2,2);
visualize_map(map, path_2);
title('Manhattan');
set(gca,'xTick', [0:1:10]);

subplot(2,2,3);
visualize_map(map, path_3);
title('Euclidean with tie breaker');
set(gca,'xTick', [0:1:10]);

subplot(2,2,4);
visualize_map(map, path_4);
title('Manhattan with tie breaker');
set(gca,'xTick', [0:1:10]);