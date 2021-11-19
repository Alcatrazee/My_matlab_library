clear
clc
Jerk_max=1;
acc_t=0.1;
omega=2*pi/acc_t;
smp_t=0.005;
conf=1/smp_t*pi;
t=0:0.005:acc_t;
k=10;
num=1;
Jerk=zeros(1,length(t)-1);
acc=zeros(1,length(t)-1);
v=zeros(1,length(t)-1);
x=zeros(1,length(t)-1);
for i=1:length(t)-1
     Jerk(i+1)=conf*sin(omega*t(i));
%      if Jerk(i+1)>=Jerk_max
%         Jerk(i+1)=Jerk_max;
%      elseif Jerk(i+1)<=-Jerk_max
%         Jerk(i+1)=-Jerk_max; 
%      end
     acc(i+1)=acc(i)+Jerk(i)*smp_t;
     v(i+1)=v(i)+acc(i)*smp_t;
     x(i+1)=x(i)+v(i)*smp_t;
end
subplot(4,1,1)
plot(t,Jerk);
subplot(4,1,2)
plot(t,acc);
subplot(4,1,3)
plot(t,v);
subplot(4,1,4)
plot(t,x);