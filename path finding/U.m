x=1:50;
y=1:50;
endcoor=[50 50];
[X,Y]=meshgrid(x,y);

z=sqrt(((X-endcoor(1)).^2)+((Y-endcoor(2)).^2));
surf(X,Y,z,z,'edgecolor','none');
camlight left;lighting phong
grid on
axis ([0 50 0 50 0 70])