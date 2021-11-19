close all
clc
clear
data=load('C:\Users\Shinelon\Desktop\analist.txt');
t1=data(:,1);
t2=data(:,2);
t3=data(:,3);
v1=data(:,4);
v2=data(:,5);
v3=data(:,6);

subplot(3,2,1);
plot(t1);
subplot(3,2,2)
plot(t2);
subplot(3,2,3)
plot(t3);
subplot(3,2,4)
plot(v1);
subplot(3,2,5)
plot(v2);
subplot(3,2,6)
plot(v3);