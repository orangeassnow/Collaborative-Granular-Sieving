%% Locate the center points in the next partition level
function C0= subpartition(C,S,lamda)
[mm,nn] = size(C);
temp = lamda^nn;
C0 =zeros(mm*temp,nn);
PART = zeros(lamda,nn);
for i = 1: mm
    for j = 1:lamda
        PART(j,:) = C(i,:)+S(j,:);
    end
    C0((i-1)*temp+1:i*temp,:) = selectcell(PART);
end
end 