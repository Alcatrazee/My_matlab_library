%% atmosphere param and weight of drone
h = 10;                 %altitute
T = 25;                 %temperature
G = 50;                 %weight of  the drone
%% propeller param
D_p = 0.4318;           %diameter of propeller
H_p = 0.1524;           %pitch of propeller
B_p = 2;                %number of fans
nr = 4;                 %number of propellers of the drone
%% motor param
K_v0=310;               %kv
Im_max=40;              %maximum I for motor
Im_0=0.5;               %no-load I
U_m0=20;                %no-load U
R_m=0.101;              %inner resistance
G_m=0.208;              %weight of motor
motor_param = [K_v0,Im_max,Im_0,U_m0,R_m,G_m];
%% battery param
Cb = 10000;             %capacitor of the battery
U_b = 26;               %votage of the battery
R_b = 0.01;             %inner resistance
K_b = 45;               %45C
G_b = 0.3;              %weight of the battery
%% other param
I_other=1;              %consumption of I for other device

%% start the calculation
[M,N] = propeller_model(h,T,G,nr,D_p,H_p,B_p);   % Get the Torque and velocity of the propeller
[I,U] = brushless_motor_model(M,N,motor_param);
[throttle,I_e,U_e] = ESC_model(U,I,U_b,R_b,nr,I_other);
I_b = I_e*nr+I_other;
duration_of_flight=Battery_model(Cb,R_b,U_b,K_b,G_b,I_b)


