function f = release_from_D(D,d,t)

%Find fractional release    
a=(d/2)*10^-4;  
cond=(pi^2*D*t/a^2);

if cond>=1
    f=1-(a^2/(15*D*t))+(6*(a^2)/((pi^4)*D*t))*exp(-(pi^2)*D*t/(a^2));
else
    f=4*sqrt(D*t/(a^2*pi))-1.5*D*t/(a^2);
end
% 

end