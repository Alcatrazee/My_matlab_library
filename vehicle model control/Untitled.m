N=400;                                          %number of samples



%% create the trajectray

%change lane trajectry
xe=20;                                          %turn vertical   distance 
k=5;                                            %turn horizental distance
a=-2*k/(xe^3);
b=3*k/(xe^2);
c=0;
d=0;
xdes=0:0.05:xe-0.05;
ydes=zeros([1 xe]);

% distance list
S(N)=0;
% derivative of y by x
psides=zeros(1,N);
for i=2:N
   ydes(i)=a*xdes(i)^3+b*xdes(i)^2+c*xdes(i)+d; 
   S(i)=S(i-1)+sqrt((ydes(i)-ydes(i-1))^2+(xdes(i)-xdes(i-1))^2);
   psides(i)=3*a*xdes(i)^2+2*b*xdes(i)+c;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% get smoothed velocity
v=smooth_v(S(N),1.5,0.05);
E=length(v);
trans_g2r=zeros([3 3]);
counter=2;

%% configuration
%constant
Lf=2.67;                                        %length from front wheels and the center of the car
dt=0.05;                                        %sameple time
sim_time = N*dt;
disp sim_time:
sim_time
%initial state
steering(1)=0.26166667;
%constrains
steering_max=9*pi/180;
steering_min=-steering_max;

%configuration 
steering_rate=zeros(1,E);
epsi=zeros(1,E);
cte=zeros(1,E);
steering_gain=zeros(1,E);
steering=zeros(1,E);

%   model
x=zeros([1 E]);
y=zeros([1 E]);
psi=zeros([1 E]);
s=zeros([1 E]);
cost=zeros([1 E]);






%% simulation
for t=2:E-1 
    %state calculate
    x(t)=x(t-1)+v(t-1)*cos(psi(t-1))*dt;
    y(t)=y(t-1)+v(t-1)*sin(psi(t-1))*dt;
    acc(t-1)=(v(t)-v(t-1))/dt;
    %v(t)=v(t-1)+acc(t-1)*dt;
    %v(t) = 1;
    s(t)=s(t-1)+v(t-1)*dt;
    psi(t)=psi(t-1)+(v(t-1)/Lf)*steering(t-1)*dt;
    %cost
    cost(t)=cost(t-1)+steering_rate(t-1)^2;
    
    %error calculate
    cte(t)=ydes(t-1)-y(t-1)+v(t-1)*sin(epsi(t-1))*dt;
    epsi(t)=psi(t-1)-psides(t-1)+v(t-1)/Lf*steering(t)*dt;
    %calculate steering for the next loop    
  %%%%%%%%%%%%%%%   search the nearest point    %%%%%%%%%%%%%%%%
    found =0;

    %axis([0 0.5 -0.002 0.02])
    while found~=1
        des_in_r=[cos(psi(t)), sin(psi(t)), -x(t)*cos(psi(t))-y(t)*sin(psi(t));-sin(psi(t)) ,cos(psi(t)) ,sin(psi(t))*x(t)-cos(psi(t))*y(t);0,0,1]*[xdes(counter) ydes(counter) 1]';
%         figure(2)
%         plot(des_in_r(1,1),des_in_r(2,1),'-o');
%         axis([-0.06 0.06 -0.1 0.1]);
%         grid on
        if des_in_r(1,1)>=0
            if sqrt(des_in_r(1,1)^2+des_in_r(2,1)^2)<0.15 && sqrt(des_in_r(1,1)^2+des_in_r(2,1)^2)>0.096;
                found=1;
                break;
            end
        end
        if counter<400
            counter=counter+1;
        else
           found=1; 
        end
    end
  %%%%%%%%%%%%%%%    end of searching           %%%%%%%%%%%%%%%%
    steering_gain(t)=atan(des_in_r(2,1)/des_in_r(1,1))/dt;
%     if steering_gain(t)>steering_max
%         steering_gain(t)=steering_max;
%     elseif steering_gain(t)<steering_min
%         steering_gain(t)=steering_min;
%     end
    steering(t)=steering(t)+steering_gain(t);

    steering_rate(t)=(steering(t)-steering(t-1))/dt;
end
y(E)=y(E-1);
x(E)=x(E-1)+dt*v(E);

figure(1)
plot(xdes,ydes)
hold on;
plot(x(1:E),y(1:E));
legend('trajectray','actual motion')
axis([0 20 0 5]);
grid on
figure 
plot(x,steering_gain(1:E))
figure
plot(x,steering(1:E))
