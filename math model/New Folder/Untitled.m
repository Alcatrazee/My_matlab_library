clc
clear
L=0:0.01:1;
A=10;
N=100;
M=100;
y=zeros(1,100);
for t=1:length(L)
    y(t)=((N*A-M*A+L(t)*M*2*A)/(N*A+3*A*M-L(t)*M*2*A))-3;
end
plot(L,y);
xlabel('L');
ylabel('y');