[x,y]=meshgrid(-2:0.1:2,-2:0.1:2);
z=(x.^2).*exp(-((x.^2)+(y.^2)));
surf(x,y,z)