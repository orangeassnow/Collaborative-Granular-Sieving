%% Calculate the difference quotient
function M = diff_quotient(matrix_f_value,d1,n)
    M=0.1;
    for i =1:n
    delty = diff(matrix_f_value,1,i);
    firstorder = delty./d1(i);
    absfo = abs(firstorder);
    M = max(max(absfo(:)),M);  
    end
end