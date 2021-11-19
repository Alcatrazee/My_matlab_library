clear
clc
order = 4;
x=[2,4,5,6,6.8,7.5,9,12,13.3,15];
y=[-10,-6.9,-4.2,-2,0,2.1,3,5.2,6.4,4.5]';
[~,k]=size(x);
X0 = make_x0(x,order);
X0_T = X0';
A = (X0_T*X0)\(X0_T*y);

figure(1)
hold on
sizeofx = size(x);
for i=1:sizeofx(2)
   plot(x(i),y(i),'*') 
end
real_x = min(x):0.1:max(x);
real_X0 = make_x0(real_x,order);
real_y = real_X0*A;
plot(real_x,real_y)