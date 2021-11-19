%需要有坐标原型
clear;
clc
%parameter
d1=685;
d2=152;
d3=50;
a2=381;
a3=25;
d4=457;
d6=127;
%omega:w
o1=[0 0 1]';
o2=[-1 0 0]';
o3=[-1 0 0]';
o4=[0 0 1]';
o5=[-1 0 0]';
o6=[0 1 0]';
%q
q1=[0 0 0]';
q2=[0 0 d1]';
q3=[-d2 a2 d1]';
q4=[-(d2-d3) a2+d4 d1]';
q5=[-(d2-d3) a2+d4 d1]';
q6=[-(d2-d3) a2+d4 d1]';
%initial state of each joint                change your angle here
t1=deg2rad(0);
t2=deg2rad(0);
t3=deg2rad(90);
t4=deg2rad(0);
t5=deg2rad(-90);
t6=deg2rad(0);
%work out Rotation matrix
R1=e_ro(o1,t1);
R2=e_ro(o2,t2);
R3=e_ro(o3,t3);
R4=e_ro(o4,t4);
R5=e_ro(o5,t5);
R6=e_ro(o6,t6);
%work out v
v1=-cross(o1,q1);
v2=-cross(o2,q2);
v3=-cross(o3,q3);
v4=-cross(o4,q4);
v5=-cross(o5,q5);
v6=-cross(o6,q6);
%work out epsi
epsi_1=[v1;o1];
epsi_2=[v2;o2];
epsi_3=[v3;o3];
epsi_4=[v4;o4];
epsi_5=[v5;o5];
epsi_6=[v6;o6];
%work out p
p1=twist_p(o1,v1,t1);
p2=twist_p(o2,v2,t2);
p3=twist_p(o3,v3,t3);
p4=twist_p(o4,v4,t4);
p5=twist_p(o5,v5,t5);
p6=twist_p(o6,v6,t6);
% p1=[0 0 d1]';
% p2=[-d2 0 0]';
% p3=[d3 a2 0]';
% p4=[0 d4 0]';
% p5=[0 0 0]';
% p6=[0 d6 0]';
%work out exp_espi
exp_1=[R1(1,:) p1(1,1);
       R1(2,:) p1(2,1);
       R1(3,:) p1(3,1);
       0 0 0     1    ];
exp_2=[R2(1,:) p2(1,1);
       R2(2,:) p2(2,1);
       R2(3,:) p2(3,1);
       0 0 0     1    ];
exp_3=[R3(1,:) p3(1,1);
       R3(2,:) p3(2,1);
       R3(3,:) p3(3,1);
       0 0 0     1    ];
exp_4=[R4(1,:) p4(1,1);
       R4(2,:) p4(2,1);
       R4(3,:) p4(3,1);
       0 0 0     1    ];
exp_5=[R5(1,:) p5(1,1);
       R5(2,:) p5(2,1);
       R5(3,:) p5(3,1);
       0 0 0     1    ];
exp_6=[R6(1,:) p6(1,1);
       R6(2,:) p6(2,1);
       R6(3,:) p6(3,1);
       0 0 0     1    ];

 %one point in frame 6
 g0=[1 0 0 -(d2-d3);0 1 0 a2+d4+d6;0 0 1 d1;0 0 0 1]'; 
 
%g(0)
g_theta=exp_1*exp_2*exp_3*exp_4*exp_5*exp_6*g0;


 

%  
%  g_0*point
%homogenious presetation
% pos_joint_1 = [exp_1(1,4) exp_1(2,4) exp_1(3,4) 1]';
% pos_joint_2 = exp_1*[exp_2(1,4) exp_2(2,4) exp_2(3,4) 1]';
% pos_joint_3 = exp_1*exp_2*[exp_3(1,4) exp_3(2,4) exp_3(3,4) 1]';
% pos_joint_4 = exp_1*exp_2*exp_3*[exp_4(1,4) exp_4(2,4) exp_4(3,4) 1]';
% pos_joint_5 = exp_1*exp_2*exp_3*exp_4*[exp_5(1,4) exp_5(2,4) exp_5(3,4) 1]';
% pos_joint_6 = exp_1*exp_2*exp_3*exp_4*exp_5*[exp_6(1,4) exp_6(2,4) exp_6(3,4) 1]';
%
pos_joint_1 = [0 0 d1 1]';
pos_joint_2 = exp_1*[-d2 0 d1 1]';
pos_joint_3 = exp_1*exp_2*[-(d2-d3) a2 d1 1]';
pos_joint_4 = exp_1*exp_2*exp_3*[-(d2-d3) a2+d4 d1 1]';
pos_joint_5 = exp_1*exp_2*exp_3*exp_4*[-(d2-d3) a2+d4 d1 1]';
pos_joint_6 = exp_1*exp_2*exp_3*exp_4*exp_5*[-(d2-d3) a2+d4+d6 d1 1]';


one_joint_in_frame3=exp_1*exp_2*exp_3*[-d2 a2 d1 1]';%[-d3 0 0 1]';

x=[0 pos_joint_1(1,1) pos_joint_2(1,1) one_joint_in_frame3(1,1) pos_joint_3(1,1)  pos_joint_4(1,1) pos_joint_5(1,1) pos_joint_6(1,1)];
y=[0 pos_joint_1(2,1) pos_joint_2(2,1) one_joint_in_frame3(2,1) pos_joint_3(2,1)  pos_joint_4(2,1) pos_joint_5(2,1) pos_joint_6(2,1)];
z=[0 pos_joint_1(3,1) pos_joint_2(3,1) one_joint_in_frame3(3,1) pos_joint_3(3,1)  pos_joint_4(3,1) pos_joint_5(3,1) pos_joint_6(3,1)];

plot3(x,y,z,'-o');
axis([-600 600 -600 1000 0 1500])
grid on
