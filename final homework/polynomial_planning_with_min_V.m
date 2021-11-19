function out = polynomial_planning_with_min_V(start_v,end_v,acc_t,smp_t)

% get matrix of accleration of a ploynomial accleration process


% %%  input
% v_max=1;                        %maximum velocity 1m/s
% v_min=2;
% acc_t=0.05;                     %accleration time 1s
% smp_t=0.0005;
%% construct polynomial fomular
a=2*(start_v-end_v)/acc_t^3;
b=-3*(start_v-end_v)/acc_t^2;
t=0:smp_t:acc_t;
%% four varaibles
S=zeros(1,length(t)-1);
v=zeros(1,length(t-1));
acc=zeros(1,length(t)-1);
Jerk=zeros(1,length(t)-1);
%% calculate four varaibles base on velocity
v(1)=start_v;
acc(1)=(v(1)-0)/smp_t;
Jerk(1)=(acc(1)-0)/smp_t;
S(1)=0+v(1)*smp_t;
for i=2:length(t)
    v(i)=a*t(i)^3+b*t(i)^2+start_v;
    acc(i)=(v(i)-v(i-1))/smp_t;
    Jerk(i)=(acc(i)-acc(i-1))/smp_t;
    S(i)=S(i-1)+v(i)*smp_t;
end
% % plot 
% figure
% subplot(4,1,1)
% plot(t,Jerk);
% subplot(4,1,2)
% plot(t,acc);
% subplot(4,1,3)
% plot(t,v);
% subplot(4,1,4)
% plot(t,S);
% a_max=max(acc)

%% output
%out=[Jerk;acc;v;S];
acc(fix(-b/(6*a)/smp_t))
out=[v  S(length(t))];
