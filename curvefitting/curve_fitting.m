
x = 0:0.1:100;
k=0.5;
for i=1:length(x)
   y1(i) = k*x(i); 
end
x2 = 100:0.01:200;
for i=1:length(x2)
   y2(i) = 50; 
end
x3 = 200:0.01:300;
k2=-0.5;
b = 150;
for i=1:length(x3)
   y3(i) = k2*x3(i) + b; 
end

y_all = [y1 y2 y3];
x = [x x2 x3];
plot(x,y_all);