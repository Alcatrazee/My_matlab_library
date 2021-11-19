

%R=[sqrt(2)/2 0 sqrt(2)/2;0 1 0;-sqrt(2)/2 0 sqrt(2)/2];
R=[-0.727 0 -0.683;0 1 0;0.686 0 -0.726];


vector_coor=[0 0 1]';
vector_in_base=R*vector_coor;
X=vector_in_base(1,1);
Y=vector_in_base(2,1);
Z=vector_in_base(3,1);
theta_x=rad2deg(acos(X/sqrt(X^2+Y^2)))
theta_y=rad2deg(acos(Y/sqrt(X^2+Y^2)))
theta_z=rad2deg(asin(Z/sqrt(Z^2+X^2)))
