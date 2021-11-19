clear
clc
rpm_vector = [];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\max_pwm_response.txt');
data_velocity = input_data(:,1);
time = input_data(:,4);
[length,~] = size(time);
ut = ones(length,1)*1400;
plot(time,data_velocity)