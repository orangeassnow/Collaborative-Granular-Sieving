function  [f_currentmin,x_currentmin,C,M,err1,err2,layer,total_time,gene_M]=GrS(problem,bounds,threshold1,threshold2,ini_partition,lamda)
% GrS Algorithm                                                          
% Purpose: Find the global optimal solutions of a n-dimensional function
% input : 'problem' is the name of the test function;
%         'bounds' is bounds for variables(format: [a1 b1;a2 b2;...;an,bn]).;
%         'threshold1' and 'threshold2' are two termination thresholds, and the default is 0.001;  
%         'ini_partition' is the initial partition ratio and the default is 60 for dimension<4 and 2 for dimension>3;
%         'lamda' is the subsequent partition ratio and the default is 2;
%       
% output: 'f_currentmin' is the algorithm minimum obtained by GrS;    
%         'x_currentmin' are the algorithm minimizer(s) obtained by GrS;
%         'C' are the remaining center points in the termination level;
%         'M' is the final M;
%         'err1' and 'err2' are the actual error, respectively represent M*e and e;
%         'layer' is the partition level when terminating GrS;
%         'total_time' is the total time to find algorithm minimum and algorithm minimizers;
%         'gene_M' is the generations of M;

[n,~] = size(bounds);
if nargin==2
    threshold1 = 0.001;
    threshold2 = 0.001;
    if n < 4
        ini_partition = 60*ones(1,n);
    else
        ini_partition = 2*ones(1,n);
    end
    lamda = 2;    
end
if nargin==3
    threshold2 = 0.001;
    if n < 4
        ini_partition = 60*ones(1,n);
    else
        ini_partition = 2*ones(1,n);
    end
    lamda = 2;    
end
if nargin==4
    if n < 4
        ini_partition = 60*ones(1,n);
    else
        ini_partition = 2*ones(1,n);
    end
    lamda = 2;  
end
if nargin==5
    lamda = 2;    
end

tic;
b_lower     = bounds(:,1);
b_upper     = bounds(:,2);
side_length = b_upper - b_lower;
p = ini_partition';
d = side_length./p;
startpoint = b_lower + d/2;
endpoint = b_upper - d/2;
    
S0 = cell(1,n);
for i = 1: n
    S0{i} = linspace(startpoint(i),endpoint(i),p(i));    
end
C1 = selectcell(S0);
[num,dim] = size(C1);

f_values0 = zeros(num,1);
for i=1:num
f_values0(i)=-niching_func(C1(i,:),problem);
end
[f_currentmin0,position] = min(f_values0);
x_currentmin0 = C1(position,:); 
if f_currentmin0<=0
   f_values1 = f_values0-f_currentmin0+1;
else
   f_values1 = f_values0; 
end
logresults = log(f_values1);
if dim ==1
    matrix_f_value = logresults;
else
    matrix_f_value = reshape(logresults,ini_partition);
end
f_optimal = logresults(position);

M0 = diff_quotient(matrix_f_value,d,n);
if M0 >= 100
    M0 = 50;
end

e = sqrt(sum(d.^2));
[~,x_currentmin_ini,~,~,~,~,~,d0]=multilayer(problem,logresults,f_optimal,e,C1,M0,d,n,f_currentmin0,x_currentmin0,f_values0,lamda,threshold1,threshold2);
M = 2*M0;
[~,x_currentmin_sec,~,~,~,~,~,d1]=multilayer(problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin0,x_currentmin0,f_values0,lamda,threshold1,threshold2);
[f_currentmin,x_currentmin,x_currentmin_sec,C,f_values,err1,err2,layer,M,d1,d2,count]=M_deter(x_currentmin_sec,x_currentmin_ini,problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin0,x_currentmin0,f_values0,M0,d0,d1,lamda,threshold1,threshold2);
gene_M = 2+count;
while abs(x_currentmin'-x_currentmin_sec')>(d1-d2)/2
   [f_currentmin,x_currentmin,x_currentmin_sec,C,f_values,err1,err2,layer,M,d1,d2,count]=M_deter(x_currentmin,x_currentmin_sec,problem,logresults,f_optimal,e,C1,M,d,n,f_currentmin0,x_currentmin0,f_values0,M0,d1,d2,lamda,threshold1,threshold2);
   gene_M = gene_M + count;
end
time=toc; % 'time' is when finding all the remaining center points in the termination level;

a=questdlg('Do you want to determine whether there are multiple global optimal solutions?','Multi-solutions execution selection','Yes','No','Yes');
set(0,'DefaultUicontrolFontsize',10);
if a(1)=='Y'
     tic;
    [f_currentmin,x_currentmin] = multi_solution(f_currentmin,x_currentmin,C,f_values);
     multi_time = toc; % 'multi_time' is to find whether there are multiple global optimal solutions;
else
   multi_time = 0;
end
total_time = time + multi_time;