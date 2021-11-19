clear 
clc
% syms t1 t2 t3 l1 l2 l3
t1 = pi/2;
t2 = pi/4;
t3 = pi/4;
l1 = 1;
l2 = 1;
l3 = 1;
T_0_1 = get_homo_rotationm('x',0)*vec2transm([0,0,0])*get_homo_rotationm('z',t1)*vec2transm([0,0,0]);
T_1_2 = get_homo_rotationm('x',pi/2)*vec2transm([0,0,0])*get_homo_rotationm('z',t2-pi)*vec2transm([0,0,l1]);
T_2_3 = get_homo_rotationm('x',0)*vec2transm([l2,0,0])*get_homo_rotationm('z',t3)*vec2transm([0,0,0]);
T_3_e = get_homo_rotationm('x',0)*vec2transm([l3,0,0])*get_homo_rotationm('z',0)*vec2transm([0,0,0]);
disp 'generate disired posture'
T_0_ee = T_0_1*T_1_2*T_2_3*T_3_e

% Get IK solutions
solutions = IK(T_0_ee,l1,l2,l3);
solution1 = solutions(1,:);
solution2 = solutions(2,:);

% FK with first solution
t1 = solution1(1);
t2 = solution1(2);
t3 = solution1(3);
T_0_1 = get_homo_rotationm('x',0)*vec2transm([0,0,0])*get_homo_rotationm('z',t1)*vec2transm([0,0,0]);
T_1_2 = get_homo_rotationm('x',pi/2)*vec2transm([0,0,0])*get_homo_rotationm('z',t2-pi)*vec2transm([0,0,l1]);
T_2_3 = get_homo_rotationm('x',0)*vec2transm([l2,0,0])*get_homo_rotationm('z',t3)*vec2transm([0,0,0]);
T_3_e = get_homo_rotationm('x',0)*vec2transm([l3,0,0])*get_homo_rotationm('z',0)*vec2transm([0,0,0]);
disp 'this is FK with solution 1'
T_0_ee = T_0_1*T_1_2*T_2_3*T_3_e

% FK with second solution
t1 = solution2(1);
t2 = solution2(2);
t3 = solution2(3);
T_0_1 = get_homo_rotationm('x',0)*vec2transm([0,0,0])*get_homo_rotationm('z',t1)*vec2transm([0,0,0]);
T_1_2 = get_homo_rotationm('x',pi/2)*vec2transm([0,0,0])*get_homo_rotationm('z',t2-pi)*vec2transm([0,0,l1]);
T_2_3 = get_homo_rotationm('x',0)*vec2transm([l2,0,0])*get_homo_rotationm('z',t3)*vec2transm([0,0,0]);
T_3_e = get_homo_rotationm('x',0)*vec2transm([l3,0,0])*get_homo_rotationm('z',0)*vec2transm([0,0,0]);
disp 'this is FK with solution 2'
T_0_ee = T_0_1*T_1_2*T_2_3*T_3_e

