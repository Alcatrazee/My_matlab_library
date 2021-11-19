a=1;
dt=0.05;
v=0;
x=0;
for k=0:0.05:2
   v = v+a*dt;
   x = x+v*dt;
   figure(1);
   stem(k,v);
   hold on
   figure(2);
   stem(k,x);
   hold on
end