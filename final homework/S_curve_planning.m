function out = S_curve_planning(start_v,end_v,acc_t,smp_t)

% get matrix of accleration of a ploynomial accleration process


% %%  input
% v_max=1;                        %maximum velocity 1m/s
% v_min=2;
% acc_t=0.05;                     %accleration time 1s
% smp_t=0.0005;
%% construct S curve fomular
t=0:smp_t:acc_t;
max_v=end_v;
min_v=start_v;
delta_v=max_v-min_v;
Jm=9*delta_v/(2*acc_t^2);
%% four varaibles
S=zeros(1,length(t)-1);
v=zeros(1,length(t-1));
acc=zeros(1,length(t)-1);
Jerk=zeros(1,length(t)-1);
%% calculate four varaibles base on velocity

for i=1:length(t)
    if i<=fix((1/3)*length(t))
        Jerk(i)=Jm;
    elseif i>fix((1/3)*length(t)) && i<=fix((2/3)*length(t))
        Jerk(i)=0;
    elseif i>fix((2/3)*length(t))   
        Jerk(i)=-Jm;
    end
end
% plot(t,J);
acc(1)=0;
v(1)=min_v;
for i=2:length(t)
   acc(i)=acc(i-1)+Jerk(i-1)*smp_t;
   v(i)=v(i-1)+acc(i-1)*smp_t;
   S(i)=S(i-1)+v(i-1)*smp_t;
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
