%transform the robot to [0 500 0] and rotate 180 degree in line 69
clear;
clc;
%theta
SA_t1=deg2rad(0);
SA_t2=deg2rad(0);
SA_t3=deg2rad(0);
SA_t4=deg2rad(0);
SA_t5=deg2rad(0);
SA_t6=deg2rad(0);
%axises
SA_w1=[0 0 1]';
SA_w2=[-1 0 0]';
SA_w3=[-1 0 0]';
SA_w4=[0 1 0 ]';
SA_w5=[-1 0 0]';
SA_w6=[0 0 -1]';
%parameters for each 
SA_l1=491;
SA_l2=350;
SA_l3=350;
SA_l4=84;
%initial parameters
SA_gst_0=[eye(3) [0 SA_l2 SA_l1+SA_l2-SA_l4]';0 0 0 1];
%make R
SA_R1=e_ro(SA_w1,SA_t1);
SA_R2=e_ro(SA_w2,SA_t2);
SA_R3=e_ro(SA_w3,SA_t3);
SA_R4=e_ro(SA_w4,SA_t4);
SA_R5=e_ro(SA_w5,SA_t5);
SA_R6=e_ro(SA_w6,SA_t6);
%qn
SA_q1=[0 0 0]';
SA_q2=[0 0 SA_l1]';
SA_q3=[0 0 SA_l1+SA_l2]';
SA_q4=[0 0 SA_l1+SA_l2]';
SA_q5=[0 SA_l3 SA_l1+SA_l2]';
SA_q6=[0 SA_l3 SA_l1+SA_l2]';
%make v
SA_v1=-cross(SA_w1,SA_q1);
SA_v2=-cross(SA_w2,SA_q2);
SA_v3=-cross(SA_w3,SA_q3);
SA_v4=-cross(SA_w4,SA_q4);
SA_v5=-cross(SA_w5,SA_q5);
SA_v6=-cross(SA_w6,SA_q6);
%make epsi
SA_epsi1=make_epsi(SA_w1,SA_v1);
SA_epsi2=make_epsi(SA_w2,SA_v2);
SA_epsi3=make_epsi(SA_w3,SA_v3);
SA_epsi4=make_epsi(SA_w4,SA_v4);
SA_epsi5=make_epsi(SA_w5,SA_v5);
SA_epsi6=make_epsi(SA_w6,SA_v6);
%make P
SA_P1=twist_p(SA_w1,SA_v1,SA_t1);
SA_P2=twist_p(SA_w2,SA_v2,SA_t2);
SA_P3=twist_p(SA_w3,SA_v3,SA_t3);
SA_P4=twist_p(SA_w4,SA_v4,SA_t4);
SA_P5=twist_p(SA_w5,SA_v5,SA_t5);
SA_P6=twist_p(SA_w6,SA_v6,SA_t6);
%make exponatial
SA_exp1=make_exp(SA_R1,SA_P1);
SA_exp2=make_exp(SA_R2,SA_P2);
SA_exp3=make_exp(SA_R3,SA_P3);
SA_exp4=make_exp(SA_R4,SA_P4);
SA_exp5=make_exp(SA_R5,SA_P5);
SA_exp6=make_exp(SA_R6,SA_P6);
%calculate 
SA_gst_theta=SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*SA_gst_0;
%make a new posture
new_R=e_ro([0 0 1]',pi);
new_pos=[new_R [0 500 0]';0 0 0 1];
%draw the pic.
SA_point_a=new_pos*[0 0 0 1]';
SA_point_b=new_pos*SA_exp1*[0 0 SA_l1 1]';
SA_point_c=new_pos*SA_exp1*SA_exp2*[0 0 SA_l1+SA_l2 1]';
SA_point_d=new_pos*SA_exp1*SA_exp2*SA_exp3*SA_exp4*[0 SA_l3 SA_l1+SA_l2 1]';
SA_point_e=new_pos*SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*[0 SA_l3 SA_l1+SA_l2-SA_l4 1]';
x=[SA_point_a(1,1) SA_point_b(1,1) SA_point_c(1,1) SA_point_d(1,1) SA_point_e(1,1)];
y=[SA_point_a(2,1) SA_point_b(2,1) SA_point_c(2,1) SA_point_d(2,1) SA_point_e(2,1)];
z=[SA_point_a(3,1) SA_point_b(3,1) SA_point_c(3,1) SA_point_d(3,1) SA_point_e(3,1)];
%draw the 3d plot
plot3(x,y,z,'-bo','Linewidth',2);
axis([-1000 1000 -1000 1000 0 1500])
grid on