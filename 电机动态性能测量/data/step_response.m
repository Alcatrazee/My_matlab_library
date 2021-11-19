clear
clc
rpm_vector = [];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\step_5v.txt');
data_5v = input_data(1:102,1);
time_5v = input_data(1:102,3);
time_5v = time_5v - time_5v(1);
[length,~] = size(time_5v);
figure(1)
for i=1:length
    plot(time_5v(i),data_5v(i),'-x')
    hold on
end

input_data_8v5 = load('E:\matlab\matlab program\电机动态性能测量\data\test_8p5v.txt');
data_8v5 = input_data_8v5(:,1);
time_8v5 = input_data_8v5(:,3);
[length,~] = size(time_8v5);
figure(2)
plot(time_8v5,data_8v5)
avg = 120.3372;
line([0,time_8v5(length)],[120.3372,120.3372],'Color',[.8 0 0]);
%time_8v5 = time_8v5 - time_8v5(1);

% %% fit 
% x = time_5v;
% p1 =  -3.292e+05;
% p2 =   9.994e+05;
% p3 =  -1.292e+06;
% p4 =   9.233e+05;
% p5 =  -3.983e+05;
% p6 =   1.066e+05;
% p7 =  -1.751e+04;
% p8 =        1656;
% p9 =       -2.24;
% y = p1*x.^8 + p2*x.^7 + p3*x.^6 + p4*x.^5 + p5*x.^4 + p6*x.^3 + p7*x.^2 + p8*x + p9;