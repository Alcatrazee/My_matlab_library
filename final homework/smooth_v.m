function v=smooth_v(S,max_v,dt,start_v,end_v,max_acc)

%S: distance of the path,scalar: mm
%max_v: expected maximun velocity
%dt:to standarize the time,this value will affact the number of output

total_time=S/0.8/max_v;
N=fix(total_time/dt);
v=zeros([1 N]);

time_to_acc=total_time/5;
time_period=0:total_time/N:total_time-total_time/N;
x=0:N;

xe=time_to_acc/total_time*N;

a=-2*max_v/(xe^3);
b=3*max_v/(xe^2);

for t=1:N
   v(1,t) =((heaviside(t)-heaviside(t-xe))*(a*x(t)^3+b*x(t)^2))  +  (heaviside(t-xe)-heaviside(t-(N-xe)))*max_v  + (heaviside(t-(N-xe))-heaviside(t-N))*((max_v-(a*(x(t)-(N-xe))^3+b*(x(t)-(N-xe))^2)));
end
N
%plot(time_period,v);