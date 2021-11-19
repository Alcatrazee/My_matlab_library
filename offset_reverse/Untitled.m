% %% x axis -2pi to 0
% angle = -360:0.01:0;
% a = 59.59;
% b = 0.01729;
% c = -3.098;
% d = 8.503;
% e = 0.005585;
% f = -3.455;
% val = a*sin(b*angle+c) + d*sin(e*angle+f);
% plot(angle,val);
%% x axis 0 to 2pi
% angle = 0:0.01:360;
% a = 56.54;
% b = 0.01738;
% c = -3.036;
% d = 104.2;
% e = 0.0001079;
% f = 3.088;
% val = a*sin(b*angle+c) + d*sin(e*angle+f);
% plot(angle,val)
% angle2 = linspace(0,2*pi,length(angle));
%% y axis -2pi to 0
% angle = -360:0.01:0;
% a = 72.02;
% b = 0.000265;
% c = -0.8633;
% d = 56.3;
% e = 0.01777;
% f = -4.498;
% val = a*sin(b*angle+c) + d*sin(e*angle+f);
% plot(angle,val);
% angle2 = linspace(-2*pi,0,length(angle));
%% x axis 0 to 2pi
angle = 0:0.01:360;
a = 85.36 ;
b = 0.007144 ;
c = -2.767 ;
d = 34.07 ;
e = 0.02094 ;
f = 1.145 ;
val = a*sin(b*angle+c) + d*sin(e*angle+f);
plot(angle,val)
angle2 = linspace(0,2*pi,length(angle));
