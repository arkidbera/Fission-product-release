clear;
close all;
clc;

%Some assignments
ci=55:5:95;
upper=zeros(1,size(ci,2));
lower=zeros(1,size(ci,2));
%

%Take temperature as input from the user
promptTemp='Enter Temperature (in K):\n';
T=input(promptTemp);
%

%Calculate tolerance band for various ci values
for i=1:size(ci,2)
    [upper(i),lower(i)]=inputErrorAnalysis(T,20,ci(i));
end
%

%Display results
disp('Upper bounds:')
disp(upper);
disp('Lower bounds:')
disp(lower);
%