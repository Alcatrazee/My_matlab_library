function [M,N] = propeller_model(h,T,G,nr,D_p,H_p,B_p)



rho = Get_rho(h,T);

[C_T,C_M] = Get_Ct(B_p,H_p,D_p,5,0.85,0.75,0.55,0.83,0);

N = 60*sqrt(G/(rho*(D_p^4)*C_T*nr));
M = rho*D_p^5*C_M*((N/60)^2);