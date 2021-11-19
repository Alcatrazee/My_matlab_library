%intial state
coor_robot_global=[1 1];
coor_dot_global=[2 2];
coor_dot_robot=[2 0];
theta_car_rotation = 0;

%dot_coor_robot=[coor_dot_robot(1);coor_dot_robot(2);0];
car_coor_global=[cos(theta_car_rotation),-sin(theta_car_rotation),coor_robot_global(1);sin(theta_car_rotation),cos(theta_car_rotation),coor_robot_global(2);0,0,1];

%           g
rotation_matrix_robot2global = [cos(theta_car_rotation),-sin(theta_car_rotation),coor_robot_global(1);
                                sin(theta_car_rotation),cos(theta_car_rotation),coor_robot_global(2);
                                0,                      0,                      1];
% way to g invers
rotation_m=[rotation_matrix_robot2global(1,1:2);
            rotation_matrix_robot2global(2,1:2);];
RTP_minus=-rotation_m'*coor_robot_global';
RT=rotation_m';
% g-1
rotation_matrix_global2robot=[RT(1,:) RTP_minus(1,1);
                              RT(2,:) RTP_minus(2,1);
                              0 0 1                ];
 %        coordinate of dot in robot frame                        
dot_coor_robot=rotation_matrix_global2robot*[coor_dot_global';1 ]
%         angle of dot in robot frame
dot_angle_robot = atan(dot_coor_robot(2,1)/dot_coor_robot(1,1))*180/pi
                          
%dot_coor_globalframe=rotation_matrix_robot2global*dot_coor_robot;