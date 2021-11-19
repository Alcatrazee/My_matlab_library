x = 0:0.1:100;
x = x'
y = x+random('exp',1,1,length(x))';
for i=1:length(x)
    plot(x(i),y(i),'marker','x')
    hold on
end
A = x'*x
Y = x'*y
result = Y/A
plot(x,x*result)