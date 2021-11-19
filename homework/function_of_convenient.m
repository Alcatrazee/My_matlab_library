
q = [0   0   0   0  451  533;
     0   0   0   0   0    0 ;
     0 399.1 847.1  889.1 889.1 889.1];
omega = [0  0  0 1  0 1;
         0  1  1 0  1 0;
         1  0  0 0  0 0];
hat1 = hat(omega(:,1));
hat2 = hat(omega(:,2));
hat3 = hat(omega(:,3));
hat4 = hat(omega(:,4));
hat5 = hat(omega(:,5));
hat6 = hat(omega(:,6));

hat1_sq = hat1^2;
hat2_sq = hat2^2;
hat3_sq = hat3^2;
hat4_sq = hat4^2;
hat5_sq = hat5^2;
hat6_sq = hat6^2;

syms theta1 theta2 theta3 theta4 theta5 theta6

R1 = e_ro(omega(:,1),theta1);
R2 = e_ro(omega(:,2),theta2);
R3 = e_ro(omega(:,3),theta3);
R4 = e_ro(omega(:,4),theta4);
R5 = e_ro(omega(:,5),theta5);
R6 = e_ro(omega(:,6),theta6);

v = [cross(-omega(:,1),q(:,1)),cross(-omega(:,2),q(:,2)),cross(-omega(:,3),q(:,3)),cross(-omega(:,4),q(:,4)),cross(-omega(:,5),q(:,5)),cross(-omega(:,6),q(:,6))];

P = [twist_p(omega(:,1),v(:,1),theta1),twist_p(omega(:,2),v(:,2),theta2),twist_p(omega(:,3),v(:,3),theta3),twist_p(omega(:,4),v(:,4),theta4),twist_p(omega(:,5),v(:,5),theta5),twist_p(omega(:,6),v(:,6),theta6)];
