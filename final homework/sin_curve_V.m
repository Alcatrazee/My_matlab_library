function out = sin_curve_V(start_v,end_v,acc_t,smp_t)

% get matrix of accleration of a ploynomial accleration process


% %%  input
% v_max=1;                        %maximum velocity 1m/s
% v_min=2;
% acc_t=0.05;                     %accleration time 1s
% smp_t=0.0005;
%% construct sin curve fomular
t=0:smp_t:acc_t;
max_v=end_v;
min_v=start_v;
%% four varaibles
S=zeros(1,length(t)-1);
v=zeros(1,length(t-1));
acc=zeros(1,length(t)-1);
Jerk=zeros(1,length(t)-1);
%% calculate four varaibles base on velocity
v(1)=start_v;
acc(1)=(v(1)-start_v)/smp_t;
Jerk(1)=(acc(1)-0)/smp_t;
S(1)=0+v(1)*smp_t;
for i=2:length(t)
    v(i)=(max_v-min_v)/2*(sin(pi/acc_t*(t(i)-acc_t/2))+1)+min_v;
    acc(i)=(v(i)-v(i-1))/smp_t;
    Jerk(i)=(acc(i)-acc(i-1))/smp_t;
    S(i)=S(i-1)+v(i)*smp_t;
end
%% plot 
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
out=[v  S(length(t))];
