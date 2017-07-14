function f=calcRelease(x,T,d0)

%Some initilizations
T_zoneAvg=zeros(1,10);
zoneArea=zeros(1,10);
%

%Find avg temperatures of all zones
for i=1:10
    x_zone=[x(i) x(i+1)];
    T_zone=[T(i) T(i+1)];
    T_zoneAvg(i)=(trapz(x_zone,T_zone))*10;
    zoneArea(i)=pi*(x(i+1)^2-x(i)^2);
end
disp('Zonal temperature: ');
disp(T_zoneAvg);
%

%To find release for each zone
f_release=find_release(T_zoneAvg,d0);
disp('Zonal release: ');
disp(f_release);
disp('Zonal area: ');
disp(zoneArea);
%

%Net release of the pellet for a particular X
disp('Total area: ');
disp(sum(zoneArea));
f=((zoneArea)*transpose(f_release))/sum(zoneArea); 
disp('Net release:');
disp(f);
%

end
