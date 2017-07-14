clear;
close all;
clc;

%Extract data temp and time data and fill them in two vectors 't', 'Tavg_time'
data=xlsread('temp_time.xlsx');
t=data(:,2);
Tavg_time=data(:,3);
plot(t,Tavg_time);
title('Average pellet temperature vs time');
ylabel('Average pellet temperature (in K)');
xlabel('Time (in secs)');
%

%Determination of the normalized temperature values
prompt1='Enter normal condition burnup: \n';
X=input(prompt1);
x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
T=createCurve(X*1000,x);
%

%Plot and display, find normalised value of temperatures
figure;
plot(x,T);
title('Temperature distribution envelope for X=26.38 kW/m');
xlabel('relative radius');
ylabel('temp');
Tavg=trapz(x,T);
disp('Average temperature at normal conditions:')
disp(Tavg);
T_normal=T./Tavg;
disp('Temperature at Different radii:')
disp(T);
disp('Temperature weights at Different radii:')
disp(T_normal);
%

%Calculate the temperature values using Tavg and reconstruct envelopes for
%each Tavg
T_final=envelope(Tavg_time,T_normal);
figure;
for i=1:length(Tavg_time)
    plot(x,T_final(i,:));
    hold on;
end
title('Envelopes for the average temperatures');
xlabel('relative radius');
ylabel('temp');
%

%Find the release for each time instant
f=zeros(length(Tavg_time),1);
for i=1:length(Tavg_time)
    f(i)=calcRelease(x,T_final(i,:),50);
end
%

%Plot release vs time
figure;
plot(t,f);
release=trapz(t,f);
disp('Total release:');
disp(release);
title('Net release fraction vs time');
xlabel('time');
ylabel('release fraction');
%

%Plot cdf
f_cdf=f;
for i=2:size(f_cdf)
    f_cdf(i)=f_cdf(i)+f_cdf(i-1);
end
figure;
plot(t,f_cdf);
title('Net cumulative release fraction vs time');
xlabel('time');
ylabel('Cumulative release fraction');
%


