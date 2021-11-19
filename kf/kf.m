clear
N=1000;
w(1)=0;
w=randn(1,N)/10;
u1=stepfun(1:N,100)*25;
u2=stepfun(1:N,400)*25;
u=(u1-u2);
o = 0:0.1:(N-1)/10;
noise = 0.3*sin(0.6*o)+randn(1,N)*0.5;
% u=u+w;
x(1)=0;
a=1;
for k=2:N;
x(k)=u(k-1);
end


V=noise;
q1=std(V);
Rvv=q1.^2;
q2=std(x);
Rxx=q2.^2; 
q3=std(w);
Rww=q3.^2;
c=1;
Y=c*x+V;

p(1)=0;
s(1)=0;
for t=2:N;
p1(t)=a.^2*p(t-1)+0.003;
b(t)=c*p1(t)/(c.^2*p1(t)+0.1);
s(t)=a*s(t-1)+b(t)*(Y(t)-a*c*s(t-1));
p(t)=p1(t)-c*b(t)*p1(t);
end

t=1:N;
plot(t,s,'r',t,Y,'k',t,x,'b');
legend('kf','sample','original')
axis([0 N -1 30])

sum=0;
sum_real=0;
sum_sensor=0;

for t=1:N
   sum=sum+s(t);
   sum_real=sum_real+x(t);
   sum_sensor=sum_sensor+Y(t);
end
sum
sum_real
sum_sensor