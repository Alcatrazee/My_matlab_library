close all
clc
clear
data=load('C:\Users\Shinelon\Desktop\vol3.txt');
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

start_point = 1;
end_point = 300;

figure;
angle = v2(start_point:end_point)';
x_offset = t1(start_point:end_point)';
y_offset = t2(start_point:end_point)';
plot(angle,x_offset)
figure;
plot(angle,y_offset)

% %% 拟合vol.txt 和 vol2.txt
% figure(2);
% 
% a1 = 56.54;
% b1 = 0.01738;
% c1 = -3.036;
% a2 = 104.2;
% b2 = 0.0001079;
% c2 = 3.088;
% 
% x = linspace(0,360,300);
% x_offset_simo = a1*sin(b1*x+c1) + a2*sin(b2*x+c2);
% hold on
% plot(x,x_offset_simo);
% 
% figure(3);
% 
% a11 =       85.36 ;
% b11 =    0.007144 ;
% c11 =      -2.767 ;
% a22 =       34.07 ;
% b22 =     0.02094 ;
% c22 =       1.145 ;
% 
% x = linspace(0,360,300);
% y_offset_simo = a11*sin(b11*x+c11) + a22*sin(b22*x+c22);
% hold on
% plot(x,y_offset_simo);

%% 拟合vol3和4
figure(2);

a1 =       59.59;
b1 =     0.01729;
c1 =      -3.098;
a2 =       8.503;
b2 =    0.005585;
c2 =      -3.455;

x = linspace(-360,0,300);
x_offset_simo = a1*sin(b1*x+c1) + a2*sin(b2*x+c2);
hold on
plot(x,x_offset_simo);

figure(3);

a11 =       72.02;
b11 =    0.000265;
c11 =     -0.8633;
a22 =        56.3;
b22 =     0.01777;
c22 =      -4.498;

x = linspace(-360,0,300);
y_offset_simo = a11*sin(b11*x+c11) + a22*sin(b22*x+c22);
hold on
plot(x,y_offset_simo);