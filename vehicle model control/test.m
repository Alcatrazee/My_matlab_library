xdes=5;
ydes=1;
x(1)=1;
y(1)=1;
t=1;
psi(1)=0;

coor = [xdes ydes 1]';
des_in_r=[cos(psi(t)), sin(psi(t)), -x(t)*cos(psi(t))-y(t)*sin(psi(t));-sin(psi(t)) ,cos(psi(t)) ,sin(psi(t))*x(t)-cos(psi(t))*y(t);0,0,1];