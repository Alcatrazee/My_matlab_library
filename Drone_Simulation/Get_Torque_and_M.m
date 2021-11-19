function [T,M] = Get_Torque_and_M(h,Temperature,N,D_p,H_p,B_p)

% usage: get the torque and thrust 
% scale: h:m Temperature:degree Cel. N:RPM D_p:M H_p:? B_p:pr0pellers

%% get cofficent
[C_T,C_M] = Get_Ct(B_p,H_p,D_p,5,0.85,0.75,0.55,0.83,0);

%% get role
rho = Get_rho(h,Temperature);

%%  thrust
T = C_T*rho*(N/60).^2*D_p^4;
M = C_M*rho*(N/60).^2*D_p^5;

end