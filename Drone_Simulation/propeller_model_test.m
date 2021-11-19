close all
D_p = 0.254;
H_p = 0.1143;
B_p = 2;
h = 200;
Temperature = 25;
N = 2000:1000:12000;
OFFICAL_DATA_T=[Lbf_2_N(0.140) Lbf_2_N(0.322) Lbf_2_N(0.572) Lbf_2_N(0.896) Lbf_2_N(1.292) Lbf_2_N(1.762) Lbf_2_N(2.309) Lbf_2_N(2.949) Lbf_2_N(3.675) Lbf_2_N(4.491) Lbf_2_N(5.401)];
OFFICAL_DATA_M=[In_Lbf_2_Nm(0.087) In_Lbf_2_Nm(0.201) In_Lbf_2_Nm(0.358) In_Lbf_2_Nm(0.559) In_Lbf_2_Nm(0.789) In_Lbf_2_Nm(1.058) In_Lbf_2_Nm(1.366) In_Lbf_2_Nm(1.858) In_Lbf_2_Nm(2.458) In_Lbf_2_Nm(3.173) In_Lbf_2_Nm(4.021)];

[T,M] = Get_Torque_and_M(h,Temperature,N,D_p,H_p,B_p);

figure(1)
plot(N,T)
hold on 
plot(N,OFFICAL_DATA_T,'-.');
title('N-T')
xlabel('N/RPM')
ylabel('T/N')
legend('model','official data')

figure(2)
plot(N,M)
hold on 
plot(N,OFFICAL_DATA_M,'-.');
title('N-M')
xlabel('N/RPM')
ylabel('M/N M')
legend('model','official data')
