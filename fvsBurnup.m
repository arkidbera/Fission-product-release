clear;
clc;

%Take a range of burnup values
Bh=[0 200 250 300 350 400 450 500 550 600 650 700 750];
B=Bh./24;
%

%Take a particular linear power and grain radius value
prompt1='Enter X(in kW/m):\n';
Xin=input(prompt1);
X=Xin*1000;
prompt2='Enter grain size(in um):\n';
d0=input(prompt2);
%

%Release calculation
f=zeros(1,13);
for j=1:1:13
    
  t=[1 1 1 1 1 1 1 1 1 1 1];
  x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
  T=[1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];
  T_prev=zeros(1,11);
  null_value=zeros(1,11);
  difference=[1 1 1 1 1 1 1 1 1 1 1];
  disp('***');
  disp('B:')
  disp(B(j));
  
  while(not(isequal(difference,null_value)))
   for i=1:1:11
    
    T_prev(i)=T(i);
    Tc=T(i)-273;
    k=1/(0.1148 + 0.0035*B(j) + (2.475*10^-4)*(1-0.00333*B(j))*Tc) + 0.0132*exp(0.00188*Tc);
    T(i)=X/(4*k*pi) - (X*x(i)^2)/(4*k*pi) + 675;
    t(i)=T(i)/1000;
   end
  diff=T-T_prev;
  difference=diff>10;
  end
  
  disp('Temperatures at different radii: ');
  disp(T);
  f(j)=calcRelease(x,T,d0); %function to calculate a more accurate release for each X
  disp('Net release for the particular X');
  disp(f(j));

end
%

%Plotting the behaviour
if Xin==40
    if d0==50
        plot(Bh,f,'b-s');
    elseif d0==20
        plot(Bh,f,'b-o');
    elseif d0==10
        plot(Bh,f,'b-^');
    else
        disp('Invalid diamater value!');
    end
elseif Xin==50
    if d0==50
        plot(Bh,f,'r-s');
    elseif d0==20
        plot(Bh,f,'r-o');
    elseif d0==10
        plot(Bh,f,'r-^');
    else
        disp('Invalid diamater value!');
    end
elseif Xin==60
    if d0==50
        plot(Bh,f,'g-s');
    elseif d0==20
        plot(Bh,f,'g-o');
    elseif d0==10
        plot(Bh,f,'g-^');
    else
        disp('Invalid diamater value!');
    end
else
    disp('Invalid X!');
end  
ylabel('f');
xlabel('B (in MW-h/kgU)');
hold on;
%
