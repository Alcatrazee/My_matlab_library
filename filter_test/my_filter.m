close all
clear 
clc
data = load('C:\Users\marki\OneDrive\×ÀÃæ\two_file\tau.txt');
data_q1 = data(:,1);
data_q2 = data(:,2);
[length,~] = size(data);

result = low_pass(data_q1);

figure
plot(data_q1)
hold on
plot(result,'r')