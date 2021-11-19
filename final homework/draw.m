function draw(dat)


exp_x=dat(:,1);
exp_y=dat(:,2);
exp_vx=dat(:,3);
exp_vy=dat(:,4);
x=dat(:,5);
y=dat(:,6);
Vx=dat(:,7);
Vy=dat(:,8);
angle=dat(:,9);
omega=dat(:,10);
ax=dat(:,11);
ay=dat(:,12);
time=dat(:,13);


subplot(6,2,1);
plot(time,exp_x);
title('exp_x');
subplot(6,2,2);
plot(time,exp_y);
title('exp_y');
subplot(6,2,3);
plot(time,exp_vx);
title('exp_vx');
subplot(6,2,4);
plot(time,exp_vy);
title('exp_vy');
subplot(6,2,5);
plot(time,x);
title('x');
subplot(6,2,6);
plot(time,y);
title('y');
subplot(6,2,7);
plot(time,Vx);
title('vx');
subplot(6,2,8);
plot(time,Vy);
title('vy');
subplot(6,2,9);
plot(time,angle);
title('angle');
subplot(6,2,10);
plot(time,omega);
title('omega');
subplot(6,2,11);
plot(time,ax);
title('ax');
subplot(6,2,12);
plot(time,ay);
title('ay');