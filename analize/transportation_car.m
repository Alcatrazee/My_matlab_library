close all
clc
clear
data=load('C:\Users\Shinelon\Desktop\analist.txt');
vy=data(:,1);
vz=data(:,2);
gz=data(:,3);
omega=data(:,4);
angle=data(:,5);
exp_angle=data(:,6);
ax=data(:,7);
ay=data(:,8);

subplot(4,2,1);
plot(vy);
title('vz')
subplot(4,2,2)
plot(vz);
title('vy')
subplot(4,2,3)
plot(gz);
title('gz')
subplot(4,2,4)
plot(omega);
title('omega')
subplot(4,2,5)
plot(angle);
title('angle')
subplot(4,2,6)
plot(exp_angle);
title('exp_angle')
subplot(4,2,7)
plot(ax);
title('ax')
subplot(4,2,8)
plot(ay);
title('ay')

figure
int_v = zeros(1,length(omega));
for i=2:length(omega)
   int_v(i) = int_v(i-1)+ay(i)*0.005; 
end

plot(int_v);