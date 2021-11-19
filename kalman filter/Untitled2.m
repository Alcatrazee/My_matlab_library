clear 
Y = load('yaw.txt')';
Y = Y(1,:);
mean_data = mean(Y);
%Y = Y-mean_data;
length = size(Y);
N=length(2);
w=0.1*randn(1,N);
x(1)=0;
a=1;

V=randn(1,N);
q1=std(Y);
Rvv=q1.^2;
q2=std(Rvv);
Rxx=q2.^2;
q3=std(w);
Qww=q3.^2;

%Y=x+c*V;
big = 0;
small = 0;
zero = 0;
sum = 0;
sum2 = 0;

p(1)=0;
Bs(1)=0;
offset(1)=0;
for t=2:N;
x(t)=x(t-1);
p1(t)=p(t-1)+Qww;
Kg(t)=p1(t)/(p1(t)+Rvv);
Bs(t)=Bs(t-1)+Kg(t)*(Y(t)-Bs(t-1));
p(t)=p1(t)-Kg(t)*p1(t);
if Y(t)>0
    big = big + 1;
end
if Y(t)==0
   zero = zero + 1;
end
if Y(t)<0
small = small + 1;
end
sum = sum+Y(t);
sum2 = sum2+Bs(t);

end

fprintf('above0:%d\tequal20:%d\tsmaller0:%d\tsum:%f\tsum2:%f\n',big,zero,small,sum,sum2);

t=1:N;
subplot(2,1,1);
plot(t,Bs,t,x,'b');
axis([0 6000 -0.5 1.5])
subplot(2,1,2);
plot(t,Y,t,x,'b');
axis([0 6000 -0.5 1.5])