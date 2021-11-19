clear;
clc;
E=0.0001;

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

SA_theta=zeros([6 1]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AH450 para%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%constrain of angle of AH-450 and l4
AH_MAX_t1=deg2rad(135);
AH_MIN_t1=deg2rad(-135);
AH_MAX_t2=deg2rad(150);
AH_MIN_t2=deg2rad(-150);
AH_MAX_t4=0;
AH_MIN_t4=-200;
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
AH_gst_0=[1 0 0 0;0 1 0 AH_l1+AH_l2;0 0 1 325;0 0 0 1];
AH_gd=[    eye(3) [-150 250 325]';0 0 0 1];
%       f(x)=exp_1*exp_2*exp_3*exp_4*g_st0*g_d-1
AH_theta=AH_theta_0;
%figure(1);
for j=1:200
    AH_gd(1,4)=AH_gd(1,4)+1;
    AH_gd(3,4)=AH_gd(3,4)-0.5;
    for t=1:100
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%four axis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        AH_t1=AH_theta(1,1);
        AH_t2=AH_theta(2,1);
        AH_t3=AH_theta(3,1);
        AH_t4=AH_theta(4,1);
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
        %get phi(theta_k)
        AH_epsi_thk=vee(logm(AH_exp_1*AH_exp_2*AH_exp_3*AH_exp_4*AH_gst_0/AH_gd));
        %get Jacobian
        AH_Jacobian=AH_get_Jacobian([AH_espi1 AH_espi2 AH_espi3 AH_espi4],AH_exp_1,AH_exp_2,AH_exp_3);
        %get pseudo Jacobian
        AH_ps_Jacobian=pinv(AH_Jacobian);
        %get theta_k+1
        AH_theta=AH_theta-AH_ps_Jacobian*AH_epsi_thk;
        Norm_of_phi=norm(AH_epsi_thk);
        %calculate
        %     stem(t,Norm_of_phi);
        %     hold on
        if Norm_of_phi<E
            break;
        end
    end
    
    if t==100
        error('coordinate out of workspace!!!')
    end
    
    AH_t1=AH_theta(1,1);
    AH_t2=AH_theta(2,1);
    AH_t3=AH_theta(3,1);
    AH_t4=AH_theta(4,1);
    if AH_t4>AH_MAX_t4||AH_t4<AH_MIN_t4
       error('hight is out of range'); 
    end
    vector_theta=set_right_angle_four_axis([AH_t1 AH_t2 AH_t3 AH_t4]');
    AH_t1=vector_theta(1,1);
    AH_t2=vector_theta(2,1);
    AH_t3=vector_theta(3,1);
    AH_t4=vector_theta(4,1);
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
    AH_gst_theta=AH_exp_1*AH_exp_2*AH_exp_3*AH_exp_4*AH_gst_0;
    
    pos_joint_a = [0 0 AH_l0 1]';
    pos_joint_b = AH_exp_1*[0 AH_l1 AH_l0 1]';
    pos_joint_c = pos_joint_b+[0 0 53 0]';
    pos_joint_d = AH_gst_theta(:,4);
    pos_joint_d(3,1)=395;
    pos_joint_e = AH_gst_theta(:,4);
    x=[0 pos_joint_a(1,1) pos_joint_b(1,1) pos_joint_c(1,1) pos_joint_d(1,1) pos_joint_e(1,1)];
    y=[0 pos_joint_a(2,1) pos_joint_b(2,1) pos_joint_c(2,1) pos_joint_d(2,1) pos_joint_e(2,1)];
    z=[0 pos_joint_a(3,1) pos_joint_b(3,1) pos_joint_c(3,1) pos_joint_d(3,1) pos_joint_e(3,1)];
    %draw the 3d plot
    figure(1)
    plot3(x,y,z,'-ro','Linewidth',2);
    axis([-1000 1000 -200 1200 0 735])
    xlabel('x')
    ylabel('y')
    hold on
    grid on
    
    
    
    
    
    %make a new posture
    new_R=e_ro([0 0 1]',pi);
    new_pos=[new_R [0 717 0]';0 0 0 1];
    
    
    SA_gd=new_pos*AH_gd;
    Norm_of_phi=0;
    %f(x)=exp_1*exp_2*exp_3*exp_4*exp_5*exp_6*g_st(0)*g^-1
    t=0;
    for t=1:100
        %theta                                  change the angle here!!!
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
        %         figure(1)
        %         stem(t,Norm_of_phi);
        if Norm_of_phi<E
            break;
        end
        %hold on
    end
    
    if t==100
       error('point is out of six axis robot''s range') ;
    end
    
    
    %output the answer
    SA_theta=set_right_angle(SA_theta');
    SA_gst_theta=SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*SA_gst_0;
    %recalculate
    %theta                                  change the angle here!!!
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
    
    
    
    %visiualize
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
    drawnow
    hold off
    
    figure(2)
    plot3(SA_point_e(1,1),SA_point_e(2,1),SA_point_e(3,1),'-r*','markersize',1);
    axis([-1000 1000 -200 1200 0 735])
    hold on 
    grid on
    
end