clear;
close all;
clc

%Take temperature as input from user; this will be kept constant
promptTemp='Enter value of temperature (in K):\n';
T=input(promptTemp);
%

%Take mean and std values of D0 and Q as input from user and store them
promptMeanD0='Enter mean value of D0 (in cm^2/sec):\n';
D0_mu=input(promptMeanD0);

promptStdD0='Enter standard deviation of D0 (in cm^2/sec):\n';
D0_sigma=input(promptStdD0);

promptMeanQ='Enter mean value of Q (in cal/mol):\n';
Q_mu=input(promptMeanQ);

promptStdQ='Enter standard deviation of Q (in cal/mol):\n';
Q_sigma=input(promptStdQ);
%

%Generate D0 and Q values having gaussian distribution
promptNumSamples='Enter number of samples for Box-Muller Transform:\n';
num_samples=input(promptNumSamples);

%For Kr85 analysis:
% D0_mu=2.65*10^-4;
% D0_sigma=0.01*2.65*10^-4;
D0=box_muller_transform(D0_mu,D0_sigma,num_samples);
figure;
h_D0=histogram(D0);
title('Histogram of D0');
xlabel('D0 (in cm^2/sec)');

%For Kr85 analysis:
% Q_mu=65500;
% Q_sigma=0.01*65500;
Q=box_muller_transform(Q_mu,Q_sigma,num_samples);
figure;
h_Q=histogram(Q);
title('Histogram of Q');
xlabel('Q (in cal/mol)');
%

%Calculate D from Temperature, D0 and Q
D=zeros(size(D0,1),size(Q,1));
for i=1:size(D0,1)
    for j=1:size(Q,1)
        D(i,j)=D_from_temp(T,D0(i),Q(j));
    end
end
D=reshape(D,[i*j,1]);

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







