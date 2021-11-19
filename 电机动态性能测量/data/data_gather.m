clear
clc
rpm_vector = [];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn12v.txt');
data_12 = input_data(:,1);
avg_12v = mean(data_12);
rpm_vector = [rpm_vector avg_12v];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn11v.txt');
data_11v = input_data(:,1);
avg_11 = mean(data_11v);
rpm_vector = [rpm_vector avg_11];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn10v.txt');
data_10v = input_data(:,1);
avg_10 = mean(data_10v);
rpm_vector = [rpm_vector avg_10];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn9v.txt');
data_9v = input_data(:,1);
avg_9 = mean(data_9v);
rpm_vector = [rpm_vector avg_9];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn8v.txt');
data_8v = input_data(:,1);
avg_8 = mean(data_8v);
rpm_vector = [rpm_vector avg_8];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn7v.txt');
data_7v = input_data(:,1);
avg_7 = mean(data_7v);
rpm_vector = [rpm_vector avg_7];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn6v.txt');
data_6v = input_data(:,1);
avg_6 = mean(data_6v);
rpm_vector = [rpm_vector avg_6];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn5v.txt');
data_5v = input_data(:,1);
avg_5 = mean(data_5v);
rpm_vector = [rpm_vector avg_5];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn4v.txt');
data_4v = input_data(:,1);
avg_4 = mean(data_4v);
rpm_vector = [rpm_vector avg_4];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn3v.txt');
data_3v = input_data(:,1);
avg_3 = mean(data_3v);
rpm_vector = [rpm_vector avg_3];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn2v.txt');
data_2v = input_data(:,1);
avg_2 = mean(data_2v);
rpm_vector = [rpm_vector avg_2];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn1v.txt');
data_1v = input_data(:,1);
avg_1 = mean(data_1v);
rpm_vector = [rpm_vector avg_1];
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\RpmIn0.5v.txt');
data_halfv = input_data(:,1);
avg_halfv = mean(data_halfv);
rpm_vector = [rpm_vector avg_halfv];
rpm_vector = flip(rpm_vector);
rpm_vector = rpm_vector*74/74.8;
votage_vector = [0.5,1,2,3,4,5,6,7,8,9,10,11,12];
[~,length] = size(rpm_vector);
figure(1)
for i=1:length
    plot(votage_vector(i),rpm_vector(i),'-x')
    hold on
end
Kc = 14.49;
n_b = 3.066;
u = 0:0.01:12;
n = u*Kc - n_b;
plot(u,n);
input = 8.5;
estimate_output = Kc*input - n_b
input_data = load('E:\matlab\matlab program\电机动态性能测量\data\temp.txt');
temp = input_data(:,1);
actual_temp = mean(temp)*74/74.8
