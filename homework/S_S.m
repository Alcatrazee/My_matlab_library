%version 1.2

%v1.0  : got a input to determin the angle of AH-450 joints and calculate the
%correct the angle of each joint of 6 axis robot to intersect the end point

%v1.1  : correct the graph of the AH-450 

%v1.2  : correct the twist_p function , make it adaptable for none rotation
%transformation


clear;
clc;

%tolerance of error
E=0.00002;
%%
%%%%%%%%%%%%%%%%%%%%%%     parameter of AH-450    %%%%%%%%%%%%%%%%%%%%%%%%%
AH_MAX_t1=deg2rad(135);
AH_MIN_t1=deg2rad(-135);
AH_MAX_t2=deg2rad(150);
AH_MIN_t2=deg2rad(-150);
AH_MAX_t4=0;
AH_MIN_t4=-195;
%parameter of AH-450
AH_l0=343;
AH_l1=200;
AH_l2=250;
%omega:w of AH-450
AH_o1=[0 0 1]';
AH_o2=[0 0 1]';
AH_o3=[0 0 1]';
AH_o4=[0 0 0]';
%q
AH_q1=[0 0 0]';
AH_q2=[0 AH_l1 0]';
AH_q3=[0 AH_l1+AH_l2 0]';
AH_q4=[0 AH_l1+AH_l2 0]';
%initial state
AH_g_st_0=[1 0 0 0;0 1 0 AH_l1+AH_l2;0 0 1 325;0 0 0 1];
%%%%%%%%%%%%%%%%%%%%%%              end             %%%%%%%%%%%%%%%%%%%%%%%







%%
%%%%%%%%%%%%%%%%%%%   parameter of six axis robot   %%%%%%%%%%%%%%%%%%%%%%%
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
SA_theta_0=zeros([1 6]);
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
SA_epsi1=make_epsi(SA_v1,SA_w1);
SA_epsi2=make_epsi(SA_v2,SA_w2);
SA_epsi3=make_epsi(SA_v3,SA_w3);
SA_epsi4=make_epsi(SA_v4,SA_w4);
SA_epsi5=make_epsi(SA_v5,SA_w5);
SA_epsi6=make_epsi(SA_v6,SA_w6);
%initial theta
SA_theta=zeros([6 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     end     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








%%
%%%%%%%%%%%%%%%%%%%%%       input the joint angles     %%%%%%%%%%%%%%%%%%%%
angle_of_AH450=input('angle of each joint and theta4\n');
if length(angle_of_AH450)~=4
    error 'please input a vector contain four elements in order like this [theta1 theta2 theta3 theta4]'
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     end     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








%%
%%%%%%%%%%%%%%%%%%%%%%% four axis forward kinematic  %%%%%%%%%%%%%%%%%%%%%%
%controlable state             controlable para. here!!!!
AH_t1=deg2rad(angle_of_AH450(1));
AH_t2=deg2rad(angle_of_AH450(2));
AH_t3=deg2rad(angle_of_AH450(3));
AH_t4=angle_of_AH450(4);
%check the angle 1 and 2
if AH_t1>AH_MAX_t1 ||AH_t1<AH_MIN_t1
    error('theta 1 is out of range');
end
if AH_t2>AH_MAX_t2 ||AH_t2<AH_MIN_t2
    error('theta 2 is out of range');
end
%check the length of z
if AH_t4>AH_MAX_t4 ||AH_t4<AH_MIN_t4
    error('length 4 is out of range');
end
%work out Rotation matrix
AH_R1=e_ro(AH_o1,AH_t1);
AH_R2=e_ro(AH_o2,AH_t2);
AH_R3=e_ro(AH_o3,AH_t3);
AH_R4=e_ro(AH_o4,0);
%work out v
AH_v1=-cross(AH_o1,AH_q1);
AH_v2=-cross(AH_o2,AH_q2);
AH_v3=-cross(AH_o3,AH_q3);
AH_v4=[0 0 1]';
%work out espi  
AH_espi1=make_epsi(AH_v1,AH_o1);
AH_espi2=make_epsi(AH_v2,AH_o2);
AH_espi3=make_epsi(AH_v3,AH_o3);
AH_espi4=make_epsi(AH_v4,AH_o4);
%work out p
AH_p1=twist_p(AH_o1,AH_v1,AH_t1);
AH_p2=twist_p(AH_o2,AH_v2,AH_t2);
AH_p3=twist_p(AH_o3,AH_v3,AH_t3);
AH_p4=twist_p(AH_o4,AH_v4,AH_t4);
%work out the exponential
AH_exp_1=make_exp(AH_R1,AH_p1);
AH_exp_2=make_exp(AH_R2,AH_p2);
AH_exp_3=make_exp(AH_R3,AH_p3);
AH_exp_4=make_exp(AH_R4,AH_p4);
%calculate the g_st_theta
disp 'target p:'
AH_g_st_theta=AH_exp_1*AH_exp_2*AH_exp_3*AH_exp_4*AH_g_st_0                %output the forward kinematic of AH-450
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     end     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%
%%%%%%%%%%%%%%%%%%%%%%% six axis inverse kinematic %%%%%%%%%%%%%%%%%%%%%%%%
SA_gd = AH_g_st_theta;                                                     % target pos.
%f(x)=exp_1*exp_2*exp_3*exp_4*exp_5*exp_6*g_st(0)*g^-1
figure(1);                                                                 %make a figure
subplot(2,1,1);                                                            %the first pic of four
tic
for t=1:100
    %  given theta
    SA_t1=SA_theta(1);
    SA_t2=SA_theta(2);
    SA_t3=SA_theta(3);
    SA_t4=SA_theta(4);
    SA_t5=SA_theta(5);
    SA_t6=SA_theta(6);
    %  make R for six axis 
    SA_R1=e_ro(SA_w1,SA_t1);
    SA_R2=e_ro(SA_w2,SA_t2);
    SA_R3=e_ro(SA_w3,SA_t3);
    SA_R4=e_ro(SA_w4,SA_t4);
    SA_R5=e_ro(SA_w5,SA_t5);
    SA_R6=e_ro(SA_w6,SA_t6);
    %  make P for six axis
    SA_P1=twist_p(SA_w1,SA_v1,SA_t1);
    SA_P2=twist_p(SA_w2,SA_v2,SA_t2);
    SA_P3=twist_p(SA_w3,SA_v3,SA_t3);
    SA_P4=twist_p(SA_w4,SA_v4,SA_t4);
    SA_P5=twist_p(SA_w5,SA_v5,SA_t5);
    SA_P6=twist_p(SA_w6,SA_v6,SA_t6);
    %  make exponatial for six axis
    SA_exp1=make_exp(SA_R1,SA_P1);
    SA_exp2=make_exp(SA_R2,SA_P2);
    SA_exp3=make_exp(SA_R3,SA_P3);
    SA_exp4=make_exp(SA_R4,SA_P4);
    SA_exp5=make_exp(SA_R5,SA_P5);
    SA_exp6=make_exp(SA_R6,SA_P6); 
    %get phi(theta_k)
    SA_epsi_thk=vee(logm(SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*SA_gst_0/SA_gd));
    %get Jacobian
    SA_Jacobian=get_Jacobian([SA_epsi1 SA_epsi2 SA_epsi3 SA_epsi4 SA_epsi5 SA_epsi6],SA_exp1,SA_exp2,SA_exp3,SA_exp4,SA_exp5,SA_exp6);
    %get pseudo Jacobian
    SA_ps_Jacobian=pinv(SA_Jacobian);
    %get theta_k+1
    SA_theta=SA_theta-SA_ps_Jacobian*SA_epsi_thk;
    Norm_of_phi=norm(SA_epsi_thk);
    %calculate
    subplot(2,2,1);
    stem(t,Norm_of_phi);
    hold on
    if Norm_of_phi<E
        break;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     end     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc





title('Norm of phi');
disp 'µü´ú´ÎÊý:'
t
if t>=20
    error( 'failed to literate or pos. out of range');
end
Norm_of_phi

%output the answer
SA_theta=set_right_angle(SA_theta')
SA_gst_theta=SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*SA_gst_0







%%%%%%%%%%%%%%%%%%%%%%%%%%%      recalculate     %%%%%%%%%%%%%%%%%%%%%%%%%%
%theta                                 
SA_t1=SA_theta(1);
SA_t2=SA_theta(2);
SA_t3=SA_theta(3);
SA_t4=SA_theta(4);
SA_t5=SA_theta(5);
SA_t6=SA_theta(6);
%make R
SA_R1=e_ro(SA_w1,SA_t1);
SA_R2=e_ro(SA_w2,SA_t2);
SA_R3=e_ro(SA_w3,SA_t3);
SA_R4=e_ro(SA_w4,SA_t4);
SA_R5=e_ro(SA_w5,SA_t5);
SA_R6=e_ro(SA_w6,SA_t6);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     end     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%%%%%%     visiualize     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%position of eacch joint of Six axis robot
SA_point_a=SA_exp1*[0 0 0 1]';
SA_point_b=SA_exp1*SA_exp2*[0 0 SA_l1 1]';
SA_point_c=SA_exp1*SA_exp2*SA_exp3*[0 0 SA_l1+SA_l2 1]';
SA_point_d=SA_exp1*SA_exp2*SA_exp3*SA_exp4*[0 SA_l3 SA_l1+SA_l2 1]';
SA_point_e=SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*[0 SA_l3 SA_l1+SA_l2-SA_l4 1]';
SA_x=[SA_point_a(1,1) SA_point_b(1,1) SA_point_c(1,1) SA_point_d(1,1) SA_point_e(1,1)];
SA_y=[SA_point_a(2,1) SA_point_b(2,1) SA_point_c(2,1) SA_point_d(2,1) SA_point_e(2,1)];
SA_z=[SA_point_a(3,1) SA_point_b(3,1) SA_point_c(3,1) SA_point_d(3,1) SA_point_e(3,1)];

%draw the skeleton of the 6 axis robot in pic. 2
subplot(2,2,2)
plot3(SA_x,SA_y,SA_z,'-bo','Linewidth',2);
hold on
grid on
title('two robots');
axis([-500 500 -600 600 0 1000])

%draw the skeleton of the 6 axis robot in pic. 3
subplot(2,2,3)
plot3(SA_x,SA_y,SA_z,'-bo','Linewidth',2);
hold on
grid on
title('6 axis robot')
axis([-500 500 -600 600 0 1000])


%position of eacch joint of AH-450
pos_joint_a = [0 0 AH_l0 1]';
pos_joint_b = AH_exp_1*[0 AH_l1 AH_l0 1]';
pos_joint_c = pos_joint_b+[0 0 53 0]';
pos_joint_d = AH_g_st_theta(:,4);
pos_joint_d(3,1)=395;
pos_joint_e = AH_g_st_theta(:,4);
AH_x=[0 pos_joint_a(1,1) pos_joint_b(1,1) pos_joint_c(1,1) pos_joint_d(1,1) pos_joint_e(1,1)];
AH_y=[0 pos_joint_a(2,1) pos_joint_b(2,1) pos_joint_c(2,1) pos_joint_d(2,1) pos_joint_e(2,1)];
AH_z=[0 pos_joint_a(3,1) pos_joint_b(3,1) pos_joint_c(3,1) pos_joint_d(3,1) pos_joint_e(3,1)];

%draw the skeleton of the 6 axis robot in pic. 2
subplot(2,2,2)
plot3(AH_x,AH_y,AH_z,'-ro','Linewidth',2);

%draw the skeleton of the 6 axis robot in pic. 4
subplot(2,2,4)
plot3(AH_x,AH_y,AH_z,'-ro','Linewidth',2);
grid on
hold on
title('AH-450')
axis([-500 500 -600 600 0 1000])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     end     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







%%%%%%%%%%%%%%%%%%%%%%%%%%   end of program  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%