function [f_currentmin,x_currentmin,f_final,x_final,C,M,err1,err2,layer,time,multi_time,gene_M] = CoGrS(problem,bounds,p_domain,threshold1,threshold2,p_each)
% Co-GrS Algorithm                                                          
% input : 'problem' is the No. of the test function;
%         'bounds' is bounds for variables(format: [a1 b1;a2 b2;...;an,bn]).;
%         'threshold1' and 'threshold2' are two termination thresholds, and the default is 0.001;  
%         'p_each' is the initial partition ratio for each subdomain and the default is 60 for dimension<4 and 2 for dimension>3 (format: [a,b,c]);
%         'p_domain' is the partition ratio for the domain on each dimension (format: [a,b,c]);
%       
% output: 'f_currentmin' is the algorithm minimum obtained by Co-GrS;    
%         'x_currentmin' are the algorithm minimizer(s) obtained by Co-GrS;
%         'C' are the remaining center points in the termination level for each subdomain;
%         'M' is the final M for each subdomain;
%         'err1' and 'err2' are the actual error, respectively represent M*e and e for each subdomain;
%         'layer' is the partition level when terminating GrS for each subdomain;
%         'total_time' is the total time to find algorithm minimum and algorithm minimizers for each subdomain;
%         'gene_M' is the generations of M for each subdomain;
%         'multi_time' is the time to find multiple solutions among the subdomains;

new_bounds = gen_bound(bounds,p_domain);
[~,block] = size(new_bounds);

for i = 1:block
[f_final{i},x_final{i},C{i},M{i},err1{i},err2{i},layer{i},time{i},gene_M{i}] = GrS(problem,new_bounds{i},threshold1,threshold2,p_each);    
end

f_final0 = cell2mat(f_final);
x_final0 = cell2mat(x_final);
[j,k] = size(f_final0);
[n,~] = size(bounds);
f_final0 = reshape(f_final0,j*k,1);
x_final0 = reshape(x_final0,j*k,n);
[f_currentmin,position0] = min(f_final0);
x_currentmin = x_final0(position0,:);

a=questdlg('Do you want to determine whether there are multiple global optimal solutions?','Multi-solutions execution selection','Yes','No','Yes');
set(0,'DefaultUicontrolFontsize',10);
if a(1)=='Y'
     tic;
    [f_currentmin,x_currentmin] = multi_solution(f_currentmin,x_currentmin,x_final0,f_final0);
     multi_time = toc; % 'multi_time' is to find whether there are multiple global optimal solutions;
else
   multi_time = 0;
end