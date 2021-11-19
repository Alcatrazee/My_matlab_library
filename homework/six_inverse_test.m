clear;
clc;
E=0.1;
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

SA_gd=    [    1.0000         0         0         0
                0             1         0      290.6030
                0             0         1      500.3970
                0             0         0      1.0000];
            
% SA_gd=[    0.1564   -0.9877         0    0
%            0.9877    0.1564         0    250
%                 0         0    1.0000    300.0000
%                 0         0         0    1.0000];           

for j=1:100
    SA_gd(2,4)=SA_gd(2,4)+1.5;
    %f(x)=exp_1*exp_2*exp_3*exp_4*exp_5*exp_6*g_st(0)*g^-1
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
    SA_point_a=SA_exp1*[0 0 0 1]';
    SA_point_b=SA_exp1*SA_exp2*[0 0 SA_l1 1]';
    SA_point_c=SA_exp1*SA_exp2*SA_exp3*[0 0 SA_l1+SA_l2 1]';
    SA_point_d=SA_exp1*SA_exp2*SA_exp3*SA_exp4*[0 SA_l3 SA_l1+SA_l2 1]';
    SA_point_e=SA_exp1*SA_exp2*SA_exp3*SA_exp4*SA_exp5*SA_exp6*[0 SA_l3 SA_l1+SA_l2-SA_l4 1]';
    x=[SA_point_a(1,1) SA_point_b(1,1) SA_point_c(1,1) SA_point_d(1,1) SA_point_e(1,1)];
    y=[SA_point_a(2,1) SA_point_b(2,1) SA_point_c(2,1) SA_point_d(2,1) SA_point_e(2,1)];
    z=[SA_point_a(3,1) SA_point_b(3,1) SA_point_c(3,1) SA_point_d(3,1) SA_point_e(3,1)];
    %draw the 3d plot
    figure(1)
    plot3(x,y,z,'-bo','Linewidth',2);
    axis([-500 500 -600 600 0 1500])
    grid on
    drawnow
end