%% To find whether there are multiple global optimal solutions
function [f_currentmin,x_currentmin] = multi_solution(f_currentmin,x_currentmin,C,f_values)
position_ini = find(f_values <= f_currentmin+0.5); %the parameter can be adjusted by the specific problems
[num,~] = size(position_ini);
[f_values_temp,position] = sort(f_values(position_ini));
C_temp = C(position_ini,:);
C_temp = C_temp(position,:);
 for i = 2:num
 x_temp = C_temp(i,:);
 x_final_dis = dist(x_currentmin,x_temp');
 while all(x_final_dis>0.1) %the parameter can be adjusted by the specific problems
      x_currentmin = [x_currentmin;x_temp];
      f_currentmin = [f_currentmin;f_values_temp(i)];
      break
end
end