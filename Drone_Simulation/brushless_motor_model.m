function [I,U] = brushless_motor_model(des_M,des_N,motor_param)

%% motor parameter
K_v0=motor_param(1);
Im_max=motor_param(2);
Im_0=motor_param(3);
U_m0=motor_param(4);
R_m=motor_param(5);
G_m=motor_param(6);

%% calculation
I = ((des_M*K_v0*U_m0)/(9.55*(U_m0-Im_0*R_m)))+Im_0;

U = I*R_m + (U_m0-Im_0*R_m)*des_N/(K_v0*U_m0);


