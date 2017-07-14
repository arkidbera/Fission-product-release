clear;
close all;
clc

%Take temperature as input from user; this will be kept constant
promptTemp='Enter value of temperature (in K):\n';
T=input(promptTemp);
%

%Find D
D0=2.65*10^-4;
Q=65500;
D=D_from_temp(T,D0,Q);
disp('Diffusion Coefficient:');
disp(D);
%

%Take mean and std values of grain size and time as input from user and store them
promptMean_d='Enter mean value of grain size (in microns):\n';
d_mu=input(promptMean_d);

promptStd_d='Enter standard deviation of grain size (in microns):\n';
d_sigma=input(promptStd_d);

promptMean_t='Enter mean value of time (in seconds):\n';
t_mu=input(promptMean_t);

promptStd_t='Enter standard deviation of time (in seconds):\n';
t_sigma=input(promptStd_t);
%

%Generate d and t values having gaussian distribution
promptNumSamples='Enter number of samples for Box-Muller Transform:\n';
num_samples=input(promptNumSamples);

%For Kr85 analysis:
% d_mu=50;
% d_sigma=0.01*50;
d=box_muller_transform(d_mu,d_sigma,num_samples);
figure;
h_d=histogram(d);
title('Histogram of grain size');
xlabel('Grain size (in microns)');

%For Kr85 analysis:
% t_mu=3600;
% t_sigma=0.01*3600;
t=box_muller_transform(t_mu,t_sigma,num_samples);
figure;
h_t=histogram(t);
title('Histogram of time');
xlabel('Time (in seconds)');
%

%Calculate f from D, d and t
f=zeros(size(d,1),size(t,1));
for i=1:size(d,1)
    for j=1:size(t,1)
        f(i,j)=release_from_D(D,d(i),t(j));
    end
end
f=reshape(f,[i*j,1]);

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


