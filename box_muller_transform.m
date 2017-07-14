function Temp = box_muller_transform(mu,sigma,num_samples)

u1=rand(num_samples,1);
u2=rand(num_samples,1);

Temp=mu+sigma*sqrt(-2*log(u1)).*cos(2*pi*u2);

end