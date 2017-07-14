clear;
clc;

%Take burnup as input from user
prompt1='Enter Burnup (in MW-h/kgU) \n';
Bh=input(prompt1);
B=Bh/24;
%

%Take grain size as input from user
prompt2='Enter grain size(in um):\n';
d0=input(prompt2);
%

%Sample values of linear power- can also be taken as input from the user
X_init=[35 37.5 40 42.5 45 47.5 50 52.5 55 57.5 60 62.5 65];
X=X_init.*1000;
%

%If we take input from user
% for j=1:1:10
%     prompt2='Enter X (in Kw/m)\n';
%     X1=input(prompt2);
%     X(j)=X1*1000;
% end
%

%Release calculation for each X (including burnup) (iterative computation)
f=zeros(1,13);
for j=1:1:13
    
  t=[1 1 1 1 1 1 1 1 1 1 1];
  x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
  T=[1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];
  T_prev=zeros(1,11);
  null_value=zeros(1,11);
  difference=[1 1 1 1 1 1 1 1 1 1 1];
  disp('***');
  disp('X:')
  disp(X(j));
  
  while(not(isequal(difference,null_value)))
   for i=1:1:11
    
    T_prev(i)=T(i);
    Tc=T(i)-273;
    k=1/(0.1148 + 0.0035*B + (2.475*10^-4)*(1-0.00333*B)*Tc) + 0.0132*exp(0.00188*Tc);
    T(i)=X(j)/(4*k*pi) - (X(j)*x(i)^2)/(4*k*pi) + 675;
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

%PLot release vs linear power for a particular burnup value
plot(X,f);
ylabel('f');
xlabel('X (in W/m)');
hold on;
%

