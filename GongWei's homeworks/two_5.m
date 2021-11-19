x=-3:0.1:3;
t=1;
y=zeros([1 length(x)]);
x=-3;
while x<=3
       if x>=-3 && x<-1
           y(t)=(-x^2-4*x-3)/2;
       elseif x>=-1 && x<1
           y(t)=-x^2+1;
       elseif x>1 && x<=3
           y(t)=(-x^2+4*x-3)/2;
       end
       x=x+0.1;
       t=t+1;
end
x=-3:0.1:3;

plot(x,y)