function T_final=envelope(Tavg_time,T_normal)

T_final=zeros(length(Tavg_time),11);

for i=1:length(Tavg_time)
   T_final(i,:)=T_normal*Tavg_time(i);
end

end