syms theta1
syms theta2
syms r1
syms r2
syms l1 
syms l2
syms m1;
syms m2;
syms J1;
syms J2;
syms g;

% r1 = 0.2;
% r2 = 0.25;
% l1 = 0.4;
% l2 = 0.5;
% m1 = 1;
% m2 = 1.2;
% J1 = 0.0133;
% J2 = 0.026;
% g = 9.81;

P_1 = r1*[cos(theta1),sin(theta1)];
P_2 = [l1*cos(theta1)+r2*cos(theta1+theta2);
       l1*sin(theta1)+r2*sin(theta1+theta2)];
%% Q1
V_1 = diff(P_1);
V_2 = diff(P_2);
%% Q2
VD = sqrt(V_2(1)^2+V_2(2)^2);
T1 = 0.5*J1*diff(theta1);
T2 = 0.5*J2*diff(theta1*theta2)^2+0.5*m2*VD^2;
T_total = T1+T2;
%% Q3
V1 = 0.5*m1*g*l1*sin(theta1);
V2 = 0.5*m2*g*(l1*sin(theta1)+0.5*l2*sin(theta1+theta2));
V_total = V1+V2;
%% Q4
L = T_total - V_total;

dfx_L2theta_dot1 = diff(L,diff(theta1));
tau1 = diff(dfx_L2theta_dot1) - diff(L,theta1);

dfx_L2theta_dot2 = diff(L,diff(theta2));
tau2 = diff(dfx_L2theta_dot2) - diff(L,theta2);

%display_tau1 = pretty(tau1);
%display_tau2 = pretty(tau2);
%% Q6
tau_vec = [tau1 tau2]';
theta_vect = [theta1 theta2]';
disp('A:')
pretty(tau_vec*pinv(theta_vect))





