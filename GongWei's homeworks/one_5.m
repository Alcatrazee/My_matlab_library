x=0:pi*2/100:pi*2;
y=cos(x)*(0.5+3*sin(x)/(1+x.^2));
plot(x,y)