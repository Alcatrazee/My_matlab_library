clc
clear
data = load('500_data.txt');

motor1_data = -data(:,1);
motor2_data = -data(:,2);
motor3_data = data(:,3);
time_log = data(:,4);

subplot(3,1,1)
plot(time_log,motor1_data);
subplot(3,1,2)
plot(time_log,motor2_data);
subplot(3,1,3)
plot(time_log,motor3_data);

motor1_stable_state = motor1_data(369:1391);
motor2_stable_state = motor2_data(369:1391);
motor3_stable_state = motor3_data(369:1391);

motor1_mean = mean(motor1_stable_state)
motor2_mean = mean(motor2_stable_state)
motor3_mean = mean(motor3_stable_state)

fitted_curve1 = (-23.13*time_log.^-3.079+19250)';
subplot(3,1,1)
hold on
plot(time_log,fitted_curve1)
input = 1000/1400*11.59*ones(1,length(time_log));