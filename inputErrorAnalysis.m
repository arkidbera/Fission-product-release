function [upper,lower] = inputErrorAnalysis(mu,sigma,ci)

%Box-Muller Transform
Temp=box_muller_transform(mu,sigma,100000);
nbins=100;
%

%Find Tolerance Band from confidence interval (input from user) for temperature
[upper,lower]=findToleranceBand(Temp,nbins,ci);
%
end