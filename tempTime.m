function [] = tempTime(t,Tavg_time,X)

%Determination of the normalized temperature values
x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
T=createCurve(X*1000,x);
%

%Plot and display, find normalised value of temperatures
Tavg=trapz(x,T);
T_normal=T./Tavg;
%

%Calculate the temperature values using Tavg and reconstruct envelopes for
%each Tavg
T_final=envelope(Tavg_time,T_normal);
%

%Find the release for each time instant
f=zeros(length(Tavg_time),1);
for i=1:length(Tavg_time)
    f(i)=calcRelease(x,T_final(i,:),50);
end
%

%Plot release vs time
plot(t,f);
hold on;
%

end