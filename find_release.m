function f=find_release(T,d0)

%Some initializations
D=zeros(1,10);
t=3600;
R=2;
%

%Release calculation
for j=1:1:10
    D(j)=(2.65*10^(-4))*exp(-(65500)/(R*T(j)))*5;
    a=(d0/2)*10^-4;
    cond=(pi^2*D(j)*t/a^2);
  
 if(cond>=1)
     f(j)=1-(a^2/(15*D(j)*t))+(6*(a^2)/((pi^4)*D(j)*t))*exp(-(pi^2)*D(j)*t/(a^2));
 else
     f(j)=4*sqrt(D(j)*t/(a^2*pi))-1.5*D(j)*t/(a^2);
 end
end
%

end

