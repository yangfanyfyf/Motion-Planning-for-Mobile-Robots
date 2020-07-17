function dist = distance(x1,y1,x2,y2,label)
% Euclidean Distance
if (label == 1 || label == 3)
    dist = sqrt((x1 - x2)^2 + (y1 - y2)^2);

% Manhattan Distance
elseif (label == 2 || label == 4)
    dist = abs(x1 - x2) + abs(y1 - y2);
    
end
   
end