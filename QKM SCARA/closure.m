%varables : theta_a~c,l4,coor_in_l4_frame
syms theta_a;
syms theta_b;
syms theta_c;
syms l0;
syms l1;
syms l2;

g_bc=[cos(theta_c)  -sin(theta_c)  0    0 ;
      sin(theta_c)   cos(theta_c)  0    l2;
           0            0          1    0 ;
           0            0          0    1 ];
      
g_ab=[ cos(theta_b) -sin(theta_b)  0    0 ;
       sin(theta_b)  cos(theta_b)  0    l1;
            0           0          1    0 ;
            0           0          0    1 ];
        
g_sa=[ cos(theta_a) -sin(theta_a)  0    0 ;
       sin(theta_a)  cos(theta_a)  0    0 ;
            0           0          1    l0;
            0           0          0    1 ];
        
 g_sa*g_ab*[0 l2 0 1]'