data = load('C:\Users\Shinelon\Desktop\test.txt');
N = 1000;
xt = 1:1000;
ax_imu = data(1:N,1);
ax_mpu = data(1:N,2);
dt = data(1:N,3);
ax_imu=ax_imu';
ax_mpu=ax_mpu';
%N = length(ax_imu);
scaler = 0.04;

figure

subplot(4,1,1)
plot(xt,ax_imu)
legend('imu')
axis([0 N -scaler scaler])

subplot(4,1,2)
plot(xt,ax_mpu)
legend('mpu')
axis([0 N -scaler scaler])

new_dat(1)=0;

for i = 1:N
    new_dat(i)=0.5*ax_imu(i)+0.5*ax_mpu(i);
end

subplot(4,1,3)
plot(xt,new_dat)
legend('com')
axis([0 N -scaler scaler])

cov_mpu = (std(ax_mpu)^2);
cov_imu = (std(ax_imu)^2);
cov_new = (std(new_dat)^2);

disp(cov_imu);
disp(cov_mpu);
disp(cov_new);
%%%%%%%%%%%%%%%%%%%%%%%%%
Rvv=cov_mpu/10;
Qww=cov_imu/10;

p(1)=0;
Bs(1)=0;
offset(1)=0;

for t=2:N;
    x(t)=ax_imu(t);
    p1(t)=p(t-1)+Qww;
    Kg(t)=p1(t)/(p1(t)+Rvv);
    Bs(t)=x(t)+Kg(t)*(ax_mpu(t)-x(t));
    p(t)=p1(t)-Kg(t)*p1(t);
end

subplot(4,1,4)
plot(xt,Bs)
legend('kf')
axis([0 N -scaler scaler])