%% Generations of M
function [f_currentmin,x_currentmin,x_currentmin_sec,C,f_values,err1,err2,layer,M,d1,d2,count]=M_deter(x_currentmin_sec,x_currentmin_ini,Problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin0,x_currentmin0,f_values0,M0,d0,d1,lamda,threshold1,threshold2)
count = 0;
while abs(x_currentmin_sec'-x_currentmin_ini')>(d0-d1)/2
    x_currentmin_ini = x_currentmin_sec;
    d0 = d1;
    M = 2*M;
    [~,x_currentmin_sec,~,~,~,~,~,d1]=multilayer(Problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin0,x_currentmin0,f_values0,lamda,threshold1,threshold2);
    count = count+1;
end
 M = M+M0;
[f_currentmin,x_currentmin,C,f_values,err1,err2,layer,d2]=multilayer(Problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin0,x_currentmin0,f_values0,lamda,threshold1,threshold2);
count = count+1;