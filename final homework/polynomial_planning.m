clear
clc
%%  input
v_max=2;                    %maximum velocity 1m/s
acc_t=1;                    %accleration time 1s
smp_t=0.005;
%% construct polynomial fomular
a=-2*v_max/acc_t^3;
b=3*v_max/acc_t^2;
t=0:smp_t:acc_t;
%% four varaibles
S=zeros(1,length(t)-1);
v=zeros(1,length(t-1));
acc=zeros(1,length(t)-1);
Jerk=zeros(1,length(t)-1);
%% calculate four varaibles base on velocity
for i=2:length(t)
    v(i)=a*t(i)^3+b*t(i)^2;
    acc(i)=(v(i)-v(i-1))/smp_t;
    Jerk(i)=(acc(i)-acc(i-1))/smp_t;
    S(i)=S(i-1)+v(i)*smp_t;
end
%% plot 
subplot(4,1,1)
plot(t,Jerk);
subplot(4,1,2)
plot(t,acc);
subplot(4,1,3)
plot(t,v);
subplot(4,1,4)
plot(t,S);
