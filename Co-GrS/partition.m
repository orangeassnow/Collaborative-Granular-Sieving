function [f_final,x_final,C,err1,err2,layer]=partition(Problem,sortresult,position,C1,M,d1)
[~,n] = size(C1);
f_optimal = sortresult(1);

lamda = 2;% the subsequent partition ratio.
[f_final,x_final,C,sortresult,position,f_optimal,d,err1,err2] = optimal_min(n,d1,M,sortresult,position,f_optimal,C1,Problem,lamda);

layer = 2;
while err1>0.001 && err2>0.001 
    [f_final,x_final,C,sortresult,position,f_optimal,d,err1,err2] = optimal_min(n,d,M,sortresult,position,f_optimal,C,Problem,lamda);
    layer = layer +1;
end
end




