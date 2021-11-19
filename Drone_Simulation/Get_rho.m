function rho = Get_rho(h,Temperature)

rho0 = 1.293;

Pa = 101325*(1-0.0065*(h/(273+Temperature)))^5.2561;
rho = 273*Pa/(101325*(273+Temperature))*rho0;