%varables : theta_a~c,l4,coor_in_l4_frame
theta_a=deg2rad(18.719);
theta_b=deg2rad(124.549);
theta_c=deg2rad(46.116);
l1=30;
l2=30;
l3=30;
l4=20;
coor_in_l4_frame=[0 0 10 1]';

g_bc=[-cos(theta_c)  sin(theta_c)  0    0 ;
      -sin(theta_c) -cos(theta_c)  0    l3;
           0            0         -1   -l4;
           0            0          0    1 ];
      
g_ab=[ cos(theta_b) -sin(theta_b)  0    0 ;
       sin(theta_b)  cos(theta_b)  0    l2;
            0           0          1    0 ;
            0           0          0    1 ];
        
g_sa=[ cos(theta_a) -sin(theta_a)  0    0 ;
       sin(theta_a)  cos(theta_a)  0    0 ;
            0           0          1    l1;
            0           0          0    1 ];
        
        

test_matrix=[ cos(theta_a)*(-cos(theta_b)*cos(theta_c)+sin(theta_b)*sin(theta_c))-sin(theta_a)*(-sin(theta_b)*cos(theta_c)-cos(theta_b)*sin(theta_c))     cos(theta_a)*(cos(theta_b)*sin(theta_c)+sin(theta_b)*cos(theta_c))-sin(theta_a)*(sin(theta_b)*sin(theta_c)-cos(theta_b)*cos(theta_c))         0      -l3*sin(theta_b)*cos(theta_a)-sin(theta_a)*(l3*cos(theta_b)+l2);
              sin(theta_a)*(-cos(theta_b)*cos(theta_c)+sin(theta_b)*sin(theta_c))+sin(theta_a)*(-sin(theta_b)*cos(theta_c)-cos(theta_b)*sin(theta_c))     sin(theta_a)*(cos(theta_b)*sin(theta_c)+sin(theta_b)*cos(theta_c))+cos(theta_a)*(sin(theta_b)*sin(theta_c)-cos(theta_b)*cos(theta_c))         0      -l3*sin(theta_b)*sin(theta_a)+cos(theta_a)*(l3*cos(theta_b)+l2);
                                            0                                                                                                                                                                     0                                                                                    -1                                 l1-l4                               ;
                                            0                                                                                                                                                                     0                                                                                     0                                 1                                   ];

pos_joint_a = [g_sa(1,4) g_sa(2,4) g_sa(3,4) 1]';
pos_joint_b = g_sa*[g_ab(1,4) g_ab(2,4) g_ab(3,4) 1]';
pos_joint_c = g_sa*g_ab*[g_bc(1,4) g_bc(2,4) g_bc(3,4) 1]';

%test_matrix*coor_in_l4_frame;
% figure 
% hold on
% plot([pos_joint_a(1,1),pos_joint_b(1,1)],[pos_joint_a(2,1),pos_joint_b(2,1)],'-ks','MarkerFaceColor','r','MarkerSize',10);
% plot([pos_joint_c(1,1),pos_joint_b(1,1)],[pos_joint_c(2,1),pos_joint_b(2,1)],'-ks','MarkerFaceColor','r','MarkerSize',10);
% plot(pos_joint_c(1,1),pos_joint_c(2,1),'-x','markersize',20);
% axis([-60 60 0 60])

x=[0 pos_joint_a(1,1) pos_joint_b(1,1) pos_joint_c(1,1) pos_joint_c(1,1)];
y=[0 pos_joint_a(2,1) pos_joint_b(2,1) pos_joint_c(2,1) pos_joint_c(2,1)];
z=[0 pos_joint_a(3,1) pos_joint_b(3,1) pos_joint_c(3,1)+l4 pos_joint_c(3,1)];

plot3(x,y,z,'-o');
axis([-60 60 0 60 0 40])
grid on
a=11;
b=12;
c=sumab(a,b);