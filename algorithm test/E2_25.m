x = -1.2:0.01:1.2;
y1 = linspace(-2,0,100);
y2 = linspace(0,2,100);
y_middle = zeros(1,41);
y = [y1 y_middle y2];
plot(x,y);
grid on
axis equal
x_true = (x.^3)';
hold on ;
a = inv(x_true'*x_true)*x_true'*y'
plot(a*x_true,y);