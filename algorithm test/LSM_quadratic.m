x = 0:0.1:10;
one_matrix = ones(1,length(x))';
y = (sin(x))';
for i=1:length(x)
    plot(x(i),y(i),'marker','x')
    hold on
end
show_x = x;
x = [x.^6' x.^5' x.^4' x.^3' x.^2' x.^1' x.^0'];
A = (x'*x);
Y = (x)'*y;
result = inv(A)*Y
plot(show_x,x*result)