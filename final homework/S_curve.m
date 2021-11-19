function out = S_curve(start_v,end_v,acc_t,smp_t)
%%  input
v_max=end_v;                          %maximum velocity 1m/s
v_min=start_v;

delta_v=v_max-v_min;
Jm=9*delta_v/(2*acc_t^2);

t=0:smp_t:acc_t;
J=zeros(1,length(t));

for i=1:length(t)
    if i<=fix((1/3)*length(t))
        J(i)=Jm;
    elseif i>fix((1/3)*length(t)) && i<=fix((2/3)*length(t))
        J(i)=0;
    elseif i>fix((2/3)*length(t))   
        J(i)=-Jm;
    end
end
% plot(t,J);
a(1)=0;
v(1)=v_min;
S(1)=0;
for i=2:length(t)
   a(i)=a(i-1)+J(i-1)*smp_t;
   v(i)=v(i-1)+a(i-1)*smp_t;
   S(i)=S(i-1)+v(i-1)*smp_t;
end
v(length(t))=end_v;
% plot(t,a);
% figure
% plot(t,v)
% figure
% plot(t,S)
out=[v  S(length(t))];
