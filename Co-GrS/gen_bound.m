function new_bounds = gen_bound(bounds,p0)
[n,~] = size(bounds);
p0=p0';
b_lower = bounds(:,1);
b_upper = bounds(:,2);
side_length = b_upper - b_lower;
d = side_length./p0;
startpoint = b_lower + d/2;
endpoint = b_upper - d/2;

S0 = cell(1,n);
for i = 1: n
    S0{i} = linspace(startpoint(i),endpoint(i),p0(i));    
end

c = selectcell(S0);
[m,~] = size(c);

new_lower = (c-repmat(d'/2,m,1))';
new_upper = (c+repmat(d'/2,m,1))';
new_b = zeros(2*n,m);
new_b(1:2:end-1,:) = new_lower;
new_b(2:2:end,:) = new_upper;
k = ones(1,m);
new_bounds = mat2cell(new_b,2*n,k);
for i = 1:m
new_bounds{i} = reshape(new_bounds{i},n,2);
end

