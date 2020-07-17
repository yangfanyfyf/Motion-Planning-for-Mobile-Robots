function exp_array=expand_array(node_x,node_y,hn,xTarget,yTarget,CLOSED,MAX_X,MAX_Y,label,xStart,yStart)

exp_array=[];
exp_count=1;
c2=size(CLOSED,1);% Number of elements in CLOSED including the zeros
for k= 1:-1:-1
    for j= 1:-1:-1
        if (k~=j || k~=0)  % The node itself is not its successor
            s_x = node_x+k;
            s_y = node_y+j;
            if((s_x >0 && s_x <=MAX_X) && (s_y >0 && s_y <=MAX_Y))%node within array bound
               flag=1;                    
               for c1=1:c2
                   if(s_x == CLOSED(c1,1) && s_y == CLOSED(c1,2))
                      flag=0;
                   end
                end
                if (flag == 1)
                    exp_array(exp_count,1) = s_x;
                    exp_array(exp_count,2) = s_y;
                    exp_array(exp_count,3) = hn+distance(node_x,node_y,s_x,s_y,label);%cost of travelling to node
                    exp_array(exp_count,4) = distance(s_x,s_y,xTarget,yTarget,label);%distance between node and goal
                    if (label == 3 || label == 4) %Tie Breaker
                        dx1 = abs(node_x - xTarget);
                        dy1 = abs(node_y - yTarget);
                        dx2 = abs(xStart - xTarget);
                        dy2 = abs(yStart - yTarget);
                        cross = abs(dx1*dy2 - dx2*dy1);
                        exp_array(exp_count,4) = exp_array(exp_count,4) + cross;
                    end 
                    exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
                    exp_count=exp_count+1;
                 end
             end
         end
     end
end 

% 
%     for k= 1:-1:-1
%         for j= 1:-1:-1
%             if ~(abs(k) == abs(j)) %%不让斜着走！
%                 s_x = node_x+k;
%                 s_y = node_y+j;
%                 if((s_x >0 && s_x <=MAX_X) && (s_y >0 && s_y <=MAX_Y))%node within array bound
%                    flag=1;                    
%                    for c1=1:c2
%                        if(s_x == CLOSED(c1,1) && s_y == CLOSED(c1,2))
%                           flag=0;
%                        end
%                     end
%                     if (flag == 1)
%                         exp_array(exp_count,1) = s_x;
%                         exp_array(exp_count,2) = s_y;
%                         exp_array(exp_count,3) = hn+distance(node_x,node_y,s_x,s_y,label);%cost of travelling to node
%                         exp_array(exp_count,4) = distance(s_x,s_y,xTarget,yTarget,label);%distance between node and goal
%                         if (label == 3 || label == 4) %Tie Breaker
%                             dx1 = abs(node_x - xTarget);
%                             dy1 = abs(node_y - yTarget);
%                             dx2 = abs(xStart - xTarget);
%                             dy2 = abs(yStart - yTarget);
%                             cross = abs(dx1*dy2 - dx2*dy1);
%                             exp_array(exp_count,4) = exp_array(exp_count,4) + cross;
%                         end 
%                         exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
%                         exp_count=exp_count+1;
%                      end
%                  end
%              end
%          end
%     end 


end
