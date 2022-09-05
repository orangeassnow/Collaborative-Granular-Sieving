%% The subsequent partition and elimination
function [f_currentmin,x_currentmin,C,f_values,d,err1,err2,num] = optimal(n,d,M,C,problem,lamda)
d = d/lamda;
e = sqrt(sum(d.^2));
err1 = M*e;
err2 = e;
S=zeros(lamda,n);
for i = 1:n
    S(:,i) = linspace(-(lamda-1)*d(i)/2,(lamda-1)*d(i)/2,lamda);
end
C = subpartition(C,S,lamda); 
clear S
[num,~] = size(C);
f_values = zeros(num,1);
for i=1:num
f_values(i)=-niching_func(C(i,:),problem);
end

%f_values = feval(problem,C);
[f_currentmin,position] = min(f_values);
x_currentmin = C(position,:);

if f_currentmin<=0
   f_values1 = f_values-f_currentmin+1;
   f_upper = err1;
   logresults = log(f_values1);
   x = logresults <= f_upper;
   f_values = f_values(x);
else
   f_upper = log(f_currentmin)+err1;
   logresults = log(f_values);
   x = logresults <= f_upper;
   f_values = f_values(x);
end

C = C(x,:);
