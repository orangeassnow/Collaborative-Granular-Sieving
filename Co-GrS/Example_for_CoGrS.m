%-------------------------------------------------------------------------%
% An example for Co-GrS Algorithm                                         %
% Purpose: Evaluate on the CEC'2013 benchmark suite                                 %
%-------------------------------------------------------------------------%
clc;
clear;
addpath('../matlab/');
global initial_flag 
initial_flag = 0;

% Set initial parameters
problem = 1; % Pass problem as the No. of the test function
bounds = [0,30]; % Establish bounds for variables (format: [a1 b1;a2 b2;a3 b3])
p_domain = [2]; % Domain partition (format: [a,b,c])
p_each = [60]; % Partition in each subdomain (format: [a,b,c])
threshold1 = 0.001; % Termination of the first threshold
threshold2 = 0.001; % Termination of the second threshold

% Call Co-GrS
[f_currentmin,x_currentmin,f_final,x_final,C,M,err1,err2,layer,time,multi_time,gene_M] = CoGrS(problem,bounds,p_domain,threshold1,threshold2,p_each);


