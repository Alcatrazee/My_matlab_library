Kp=0.01;
Ki=0;
Kd=0;
desire_num = 20;
desire=zeros([1 100]);
out = zeros([1 100]);
error = zeros([1 100]);
error_sum=0;
x=1:100;
desire(1)=desire_num;
out_f=0;
for i=2:100
   desire(i)= desire_num;
   error(i) = desire(i)-out(i-1);
   out(i)=Kp*error(i)*x(i)^2;
end
plot(x,desire,x,out)
axis([0 100 -100 100])