%需要有坐标原型
clear;
clc
%constrain of angle of AH-450 and l4
%constrain of angle of AH-450 and l4
AH_MAX_t1=deg2rad(135);
AH_MIN_t1=deg2rad(-135);
AH_MAX_t2=deg2rad(150);
AH_MIN_t2=deg2rad(-150);
AH_MAX_t4=-70;
AH_MIN_t4=-195;
%parameter of AH-450
AH_l0=343;
AH_l1=200;
AH_l2=250;
AH_t4=0;
%omega:w of AH-450
AH_o1=[0 0 1]';
AH_o2=[0 0 1]';
AH_o3=[0 0 1]';
AH_o4=[0 0 0]';
%q
AH_q1=[0 0 0]';
AH_q2=[0 AH_l1 0]';
AH_q3=[0 AH_l1+AH_l2 0]';
AH_q4=[0 0 0]';
%initial state
AH_theta_0=[0 0 0 0]';
AH_g_st_0=[1 0 0 0;0 1 0 AH_l1+AH_l2;0 0 1 325;0 0 0 1];
figure(1)
k=2;
pic=[1 1 1];
for l1=-135:15:135
    for l2=-150:5:150
        for t4=0:-25:-125
            AH_t1=deg2rad(l1);
            AH_t2=deg2rad(l2);
            AH_t3=deg2rad(0);
            AH_t4=t4;
            %work out Rotation matrix
            AH_R1=e_ro(AH_o1,AH_t1);
            AH_R2=e_ro(AH_o2,AH_t2);
            AH_R3=e_ro(AH_o3,AH_t3);
            AH_R4=eye(3);
            %work out v
            AH_v1=-cross(AH_o1,AH_q1);
            AH_v2=-cross(AH_o2,AH_q2);
            AH_v3=-cross(AH_o3,AH_q3);
            AH_v4=[0 0 1]';
            %work out espi
            AH_espi1=make_epsi(AH_v1,AH_o1);
            AH_espi2=make_epsi(AH_v2,AH_o2);
            AH_espi3=make_epsi(AH_v3,AH_o3);
            AH_espi4=[AH_v4' AH_o4']';
            %work out p
            AH_p1=twist_p(AH_o1,AH_v1,AH_t1);
            AH_p2=twist_p(AH_o2,AH_v2,AH_t2);
            AH_p3=twist_p(AH_o3,AH_v3,AH_t3);
            AH_p4=[0 0 AH_t4]';
            %work out the exponential
            AH_exp_1=make_exp(AH_R1,AH_p1);
            AH_exp_2=make_exp(AH_R2,AH_p2);
            AH_exp_3=make_exp(AH_R3,AH_p3);
            AH_exp_4=make_exp(AH_R4,AH_p4);
            %calculate the g_st_theta
            AH_g_st_theta=AH_exp_1*AH_exp_2*AH_exp_3*AH_exp_4*AH_g_st_0;
            if k==1
                pic=[AH_g_st_theta(1,4) AH_g_st_theta(2,4) AH_g_st_theta(3,4)];
            else
                pic=cat(1,pic,[AH_g_st_theta(1,4) AH_g_st_theta(2,4) AH_g_st_theta(3,4)]);
            end
            %plot3(pic(k,1),pic(k,2),pic(k,3),'-o');
            plot3(AH_g_st_theta(1,4),AH_g_st_theta(2,4),AH_g_st_theta(3,4),'-ro');
            hold on
            k=k+1
        end
    end
end

%plot3(pic(:,1),pic(:,2),pic(:,3),'-o');
hold on
grid on
drawnow
axis([-600 600 -600 600 0 500])

% %calculate the coordinate of each joint
% pos_joint_a = [0 0 AH_l0 1]';
% pos_joint_b = AH_exp_1*[0 AH_l1 AH_l0 1]';
% pos_joint_c = AH_exp_1*AH_exp_2*AH_exp_3*[0 AH_l1+AH_l2 AH_l0 1]';
% pos_joint_d = AH_g_st_theta(:,4);
% x=[0 pos_joint_a(1,1) pos_joint_b(1,1) pos_joint_c(1,1) pos_joint_d(1,1)];
% y=[0 pos_joint_a(2,1) pos_joint_b(2,1) pos_joint_c(2,1) pos_joint_d(2,1)];
% z=[0 pos_joint_a(3,1) pos_joint_b(3,1) pos_joint_c(3,1) pos_joint_d(3,1)];
% %draw the 3d plot
% plot3(x,y,z,'-ro','Linewidth',2);
% axis([-600 600 -600 600 0 735])
% grid on