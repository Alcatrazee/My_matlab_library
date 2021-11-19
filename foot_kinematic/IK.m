function result = IK(g_st,l1,l2,l3)

% calculate theta 1
theta1 = atan2(g_st(1,3),-g_st(2,3));
% calculate middle variables : angle A and angle B and distance from ee to
% joint2 j2e2 and angle of ee relative to coordinate 2
T_0_1 = get_homo_rotationm('x',0)*vec2transm([0,0,0])*get_homo_rotationm('z',theta1)*vec2transm([0,0,0]);
T_1_tempc = get_homo_rotationm('x',pi/2)*vec2transm([0,0,0])*get_homo_rotationm('z',-pi)*vec2transm([0,0,l1]);
T_0_tempc = T_0_1*T_1_tempc;
T_tempc_ee = inv(T_0_tempc)*g_st;

delta = norm(T_tempc_ee(1:2,4));

angle_A = acos((delta^2 + l2^2 - l3^2)/(2*delta*l2));
angle_B = acos((l2^2 + l3^2 - delta^2)/(2*l2*l3));
angle_K = atan2(T_tempc_ee(2,4),T_tempc_ee(1,4));
theta2_1 = angle_K + angle_A;
theta2_2 = angle_K - angle_A;
theta3_2 = pi - angle_B;
theta3_1 = angle_B - pi;
% output
result = [theta1 theta2_1 theta3_1;theta1 theta2_2 theta3_2];
