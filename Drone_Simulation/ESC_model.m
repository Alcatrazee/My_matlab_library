function [throttle,I_e,U_e] = ESC_model(U_m,I_m,U_b,R_b,nr,I_other)

%% param 
I_emax = 20;
G_e = 0.019;
R_e = 0.133;

%% calculation
throttle = (U_m+I_m*R_e)/U_b;
I_e = throttle*I_m;
U_e = U_b - (nr*I_e + I_other)*R_b;