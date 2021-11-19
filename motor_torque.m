close all 
clear
clc
%% motor parameter
V = 24;
no_load_speed = 388;  %rpm    can be measured by giving nominal votage and measure the velocity
no_load_current = 0.2;    %  can be measured by current meter when dry running
stall_torque = 9.6;    %  can be measured by a weight scale(Nm)
stall_current = 16;      %  can be measured by current meter when roter stalled
%% calculation
% calculated parameter
tao = linspace(0,stall_torque,500);
Kb = V/(no_load_speed*2*pi/60);
Kt = stall_torque/stall_current;
R = V/stall_current;

% parameter calculation
k_t_w = -R/(Kt*Kb);b_t_w = V/Kb;
% relationship between torque and speed
w = tao*k_t_w + b_t_w;

% plot 1
figure(1);
plot(tao,w);
title('torque/speed')
xlabel 'torque'
ylabel 'speed'

% curve of torque and current
k_t_i = (stall_current-no_load_current)/stall_torque;
b_t_i = no_load_current;
i = tao*k_t_i+b_t_i;

% plot 2
figure(2);
plot(tao,i);
title('torque/current');
xlabel 'torque'
ylabel 'current'

%% efficiency
% output power
out_p = tao.*w;
in_p = V*i;
eff = out_p./in_p;
[max_eff,index] = max(eff);
% plot
figure(3)
plot(tao,eff);
title('torque/efficiency');
xlabel 'torque'
ylabel 'efficiency'

disp 'maximum efficiency'
max_eff

disp 'max power consumsion in max efficiency'
V*i(index)

%% nominal values
% nominal current
disp 'nominal current'
i_n = i(index)
% nominal torque
disp 'nominal torque(Nm)'
tao_n = Kt*i_n
% nominal speed
disp 'nominal speed(rad/s)'
w_n = tao_n*k_t_w + b_t_w
disp 'nominal speed(rpm)'
w_n*60/(2*pi)

