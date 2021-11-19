% this is a function that fit a cubic polynomial to given parameters:
% start value,end value,start velocity,end velocity
clear
theta_l=6;
theta_r = 2;
theta_l_dot=pi/4;
theta_r_dot=pi/4;
t = 0:0.01:3;
length_t = t(length(t));
t_display = 0:0.01:2*length_t;
T = [1 0 0 0;
     0 0 1 0;
     -3/(length_t^2),3/(length_t^2),-2/(length_t),-1/length_t;
     2/(length_t^3), -2/(length_t^3), 1/(length_t^2), 1/(length_t^2)];
A =   T * [theta_l theta_r theta_l_dot theta_r_dot]';

% T = [1 0 0 0;
%      0 1 0 0;
%      -3/(length_t^2),-2/length_t,3/(length_t^2),-1/length_t;
%      2/(length_t^3), 1/(length_t^2), -2/(length_t^3), 1/(length_t^2)];
% A =   T * [theta_l theta_l_dot theta_r theta_r_dot]';

% A(1)=theta_l;
% A(2)=theta_l_dot;
% A(3) = 3*(theta_r-theta_l)/(length_t^2) - 2*theta_l_dot/length_t - theta_r_dot/length_t;
% A(4) = -2*(theta_r - theta_l)/(length_t^3)+ (theta_r_dot+theta_l_dot)/(length_t^2);
a0 = A(1);
a1 = A(2);
a2 = A(3);
a3 = A(4);
y = a0+a1*t+a2*t.^2+a3*t.^3;
plot(t,y)