function openList = insert_open(x_val, y_val, parent_x_val, parent_y_val, hn, gn, fn)

openList = zeros(1,8);
openList(1,1) = 1;
openList(1,2) = x_val;
openList(1,3) = y_val;
openList(1,4) = parent_x_val;
openList(1,5) = parent_y_val;
openList(1,6) = hn;
openList(1,7) = gn;
openList(1,8) = fn;

end