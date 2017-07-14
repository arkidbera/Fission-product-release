clear;
close all;
clc;

%Extract data temp and time data and fill them in two vectors 't', 'Tavg_time'
data=xlsread('temp_time.xlsx');
t=data(:,2);
Tavg_time=data(:,3);
%

%Take normal conditon burnup value as input from user
prompt1='Enter normal condition burnup: \n';
X=input(prompt1);
%

%Take confidence interval as input from user
promptCI='Enter Confidence Interval (in %):\n';
ci=input(promptCI);
%

%Plot Tolerance Band
T_upper=zeros(size(t));
T_lower=zeros(size(t));
for i=1:size(Tavg_time,1)
    [T_upper(i),T_lower(i)]=inputErrorAnalysis(Tavg_time(i),20,ci);
end

%Temperature tolerance band
figure;
plot(t,Tavg_time);
hold on;
plot(t,T_upper);
hold on;
plot(t,T_lower);
hold on;
title('Tolerance band of Temperature');
xlabel('Time (in secs)');
ylabel('Temperature (in K)');
legend('Mean Temperature','Upper bound of tolerance band','Lower bound of tolerance band');

%Fractional release tolerance band
figure;
tempTime(t,Tavg_time,X);
tempTime(t,T_upper,X);
tempTime(t,T_lower,X);
title('Tolerance band of Release Fraction');
xlabel('Time (in secs)');
ylabel('Release Fraction');
legend('Mean release fraction','Upper bound of tolerance band','Lower bound of tolerance band');

%

