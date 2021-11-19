clear
clc
rpm_vector = [];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\velocity_response.txt');
data_velocity = input_data(:,1);
time = input_data(:,4);
ut = input_data(:,3);
[length,~] = size(time);
figure(1)
plot(time,data_velocity)
% for i=1:length
%     plot(time(i),data_velocity(i),'-x')
%     hold on
% end
figure(2)
plot(time,ut)
normed_ut = ut/max(ut);
normed_data = data_velocity/max(data_velocity);
figure(3)
plot(time,normed_ut)
hold on
plot(time,normed_data)
u = ut(156:560);
fu = data_velocity(156:560);
plot(u,fu)