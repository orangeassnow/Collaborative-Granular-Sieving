%% Calculation for the coordinates of the center points
function  C = selectcell(A)
judge = iscell(A);
C = [];
b = [];
if judge == 1    
    num = length(A);
    for i=1:num
        b=[b;length(A{i})];
    end
    ind=fullfact(b) ;
    for i=1:num
        B=A{i}';
        C = [C,B(ind(:,i))];  
    end
else
    [num,n] = size(A);
    for i=1:n
        b=num*ones(1,n);
        ind=fullfact(b) ;  
        B=A(:,i);
        C = [C,B(ind(:,i))];
    end
end
end