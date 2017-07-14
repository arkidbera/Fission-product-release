clear;
close all;
clc

%Take mean and std values of temperature as input from user and store them
promptMean='Enter mean value of temperature (in K):\n';
mu=input(promptMean);

promptStd='Enter standard deviation of temperature (in K):\n';
sigma=input(promptStd);
%

%Generate temperature values having gaussian distribution

%Box-Muller Transform
promptNumSamples='Enter number of samples for Box-Muller Transform:\n';
num_samples=input(promptNumSamples);

Temp=box_muller_transform(mu,sigma,num_samples);
figure;
nbins=100;
h=histogram(Temp,nbins);
title('Histogram of Temperature');
xlabel('Temperature (in K)');

%Direct method:
% Temp=normrnd(mu,sigma,[1000000,1]);
% h=histogram(Temp);
% title('Histogram of Temperature');
% xlabel('Temperature (in K)');

%

%Find diffusion coefficient at each temperature and display distribution
D=zeros(size(Temp,1),1);
D0=2.65*10^-4;
Q=65500;
for i=1:size(Temp,1)
    D(i)=D_from_temp(Temp(i),D0,Q);
end

D_mu=mean(D);
disp('Mean value of D:');
disp(D_mu);

D_sigma=std(D);
disp('Standard deviation of D:');
disp(D_sigma);

figure;
h_D=histogram(D);
title('Histogram of Diffusion Coefficient');
xlabel('Diffusion Coefficient (in cm^2/sec)');
%

%Find release for each value of D
f=zeros(size(D,1),1);
d=50;
t=3600;
for i=1:size(D,1)
    f(i)=release_from_D(D(i),d,t);
end

f_mu=mean(f);
disp('Mean value of release fraction:');
disp(f_mu);

f_sigma=std(f);
disp('Standard deviation of release fraction:');
disp(f_sigma);

figure;
h_f=histogram(f);
title('Histogram of Release fraction');
xlabel('Release fraction');
%

%Find Tolerance Band from confidence interval (input from user) for temperature
promptCI='Enter Confidence Interval (in %):\n';
ci=input(promptCI);

[upper,lower]=findToleranceBand(Temp,nbins,ci);
disp('Upper limit of band:');
disp(upper);
disp('Lower limit of band:');
disp(lower);
%
