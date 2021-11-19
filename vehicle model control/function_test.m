vdes=smooth_v(20,10);

len = length(vdes);

dt=0.05;

error=zeros([1 len]);
error_sum=zeros([1 len]);

acc=zeros([1 len]);
v=zeros([1 len]);

for t=2:len
    acc(t)=(vdes(t)-vdes(t-1))/dt;
    
    v(t)=v(t-1)+acc(t-1)*dt;
end

figure
hold on
plot(1:len,v)
plot(1:len,vdes)
%plot(1:len,acc)
%legend('v','vdes','acc')

