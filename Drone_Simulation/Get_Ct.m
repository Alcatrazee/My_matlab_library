function [C_T,C_M]=Get_Ct(B_p,H_p,D_p,A,epsi,lumda,epsii,e,alpha0)

% usage: this is a function to calculate the coffcient of toque and force of a propeller
% how to use: [C_T C_M]=Get_Ct(A,epsi,lumda,epsii,e,C_fd,alpha0,K0)
% fomular: C_T = 0.25*pi^3*lumda*epsii^2*B_p*K0
%          C_M = 1/(8*A)*pi^2*C_d*epsii^2*lumda*B_p^2
%          C_d =
%          C_fd+(pi*A*K0^2)/(e)*(epsi*atan(H_p/pi*D_p)-alpha0)^2/(pi*A+K0)^2))
% constrain: A=5~8 , epsi=0.85~0.95 , lumda=0.7~0.9 , epsii=0.4~0.7 ,
% e=0.7~0.9 , C_fd=0.015 , alpha=-pi/36~0 , K0=6.11 , B_p=2~3 , H_p=0~90 ,
% D_p>0

C_fd = 0.015;
K0=6.11;

if(~Check_param_range(A,5,8))
   error('param A is out of bound');
end
if(~Check_param_range(epsi,0.85,0.95))
   error('param epsi is out of bound');
end
if(~Check_param_range(lumda,0.7,0.9))
   error('param lumda is out of bound');
end
if(~Check_param_range(epsii,0.4,0.7))
   error('param epsii is out of bound');
end
if(~Check_param_range(e,0.7,0.9))
   error('param e is out of bound');
end
if(~Check_param_range(alpha0,-pi/36,0))
   error('param alpha0 is out of bound');
end
if(~Check_param_range(B_p,2,3))
   error('param B_p is out of bound');
end

temp = (epsi*atan(H_p/(pi*D_p))-alpha0) / (pi*A+K0);

C_d = C_fd+ ((pi*A*K0^2)/e) * temp^2 ;

C_T = 0.25 * pi^3 * lumda * epsii^2 * B_p * K0 * temp;

C_M = 1/(8*A) * pi^2 * C_d * epsii^2 * lumda*B_p^2;




