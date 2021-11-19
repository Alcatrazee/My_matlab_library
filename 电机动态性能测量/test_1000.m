clc
clear
data = load('1000_data.txt');

motor1_data = -data(:,1);
motor2_data = -data(:,2);
motor3_data = data(:,3);
time_log = data(:,4);
time_log = time_log - time_log(1);

% subplot(3,1,1)
% plot(time_log,motor1_data);
% subplot(3,1,2)
% plot(time_log,motor2_data);
% subplot(3,1,3)
% plot(time_log,motor3_data);

motor1_stable_state = motor1_data(369:1391);
motor2_stable_state = motor2_data(369:1391);
motor3_stable_state = motor3_data(369:1391);

motor1_mean = mean(motor1_stable_state)
motor2_mean = mean(motor2_stable_state)
motor3_mean = mean(motor3_stable_state)

motor1_data = motor1_data/motor1_mean;
motor2_data = motor2_data/motor2_mean;
motor3_data = motor3_data/motor3_mean;

figure(1);plot(time_log,motor2_data)


epsi = 0.9878;
omegan = 18.14;
motor_sys = tf([omegan^2],[1 2*omegan*epsi omegan^2]);
figure(2)
[y,t] = step(motor_sys);
plot(t,y)

% a =-4.189e+05;
% b = 20.67;
% c = 4.628e+05;
% d = -0.0002464;
% 
% fitted_curve1 = a*exp(-b*time_log)+c*exp(-d*time_log)+a;
% subplot(3,1,3)
% hold on
% plot(time_log,fitted_curve1)
% input = 1000/1400*11.59*ones(1,length(time_log));
% figure
% plot(time_log,fitted_curve1);
% hold on
% plot(time_log,motor3_data);