%% The results of reaching the termination condition under initial M
function [f_currentmin,x_currentmin,C,f_values,err1,err2,layer,d]=multilayer(problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin,x_currentmin,f_values,lamda,threshold1,threshold2)
err1 = M*e;
err2 = e;
f_upper = f_optimal + err1;
x = logresults<=f_upper;
C = C1(x,:);  %The remaining center points after the first elimination 
f_values = f_values(x,:);
layer = 1;

while err1>threshold1 && err2>threshold2
    [f_currentmin,x_currentmin,C,f_values,d,err1,err2] = optimal(n,d,M,C,problem,lamda);
    layer = layer +1;
end
end