function [T]=createCurve(X,x)

  t=[1 1 1 1 1 1 1 1 1 1 1];
  T=[1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];
  T_prev=[0 0 0 0 0 0 0 0 0 0 0];
  null_value=[0 0 0 0 0 0 0 0 0 0 0];
  difference=[1 1 1 1 1 1 1 1 1 1 1];
   
  while(not(isequal(difference,null_value)))
   for i=1:1:11
    
    T_prev(i)=T(i);
    k=100/(7.5408+17.692*t(i)+3.6142*t(i)^2)+(6400/t(i)^2.5)*exp(-16.35/t(i));
    T(i)=X/(4*k*pi) - (X*x(i)^2)/(4*k*pi) + 675;
    t(i)=T(i)/1000;
    
   end
  diff=T-T_prev;
  difference=diff>10;
  end
  

end

