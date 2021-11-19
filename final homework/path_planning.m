clear
clc
close all
%% construct the trajactary    scalar:mm
t=0:50;
x_des=t;
y_des=3*t;
S=0;
for i=1:length(t)-1
   S=S+dist3([x_des(i),y_des(i)],[x_des(i+1),y_des(i+1)]); 
end
%% generate the velocity trajactary
smp_t=0.005;                                    %sample time
max_velocity=150;                               %maximun velocity
accl_time=0.15;                                 %accleration time  scalar:s

acc_up=S_curve_planning(0,max_velocity,accl_time,smp_t);    %get acc curve
sum_up=acc_up(length(acc_up));                              %get integration 

acc_down=S_curve_planning(max_velocity,0,accl_time,smp_t);  %get acc curve
sum_down=acc_down(length(acc_down));                        %get integration

if S>sum_up+sum_down                           %judge if maximun v can be reached
   t_avg=(S-sum_up-sum_down)/acc_up(length(acc_up)-2);
   avg_v=ones(1,fix(t_avg/smp_t))*acc_up(length(acc_up)-1);
else
   
end

velocity=[acc_up(1:length(acc_up)-1) avg_v  acc_down(1:length(acc_down)-1)];
t_whole=1:length(velocity);
t_whole=t_whole*smp_t;


%% generate the k of each dot
% for i=1:t(length(t)-1)
%     k(i)=(y(i+1)-y(i))/(x(i+1)-x(i));
% end

integrate_of_v=sum_up+sum_down+(S-sum_up-sum_down);
error=S-integrate_of_v

%% generate the waypoints
x=zeros(1,length(t_whole)-1);
y=zeros(1,length(t_whole)-1);
num=1;
current_waypoint=[x(num) y(num)];
dis=0;
act=0;
acc=zeros(1,length(t_whole)-1);
Jerk=zeros(1,length(t_whole)-1);
for i=1:length(t_whole)-1
   % to judge if we need to change the waypoint
   if dist3(current_waypoint,[x,y])<=0.00001
      if num+1<length(t)
          num=num+1; 
      end
      current_waypoint=[x(num) y(num)];
      if x_des(num+1)-x_des(num)==0 && y_des(num+1)-y_des(num)>=0 
          phi=pi/2;
      elseif x_des(num+1)-x_des(num)==0 && y_des(num+1)-y_des(num)<0
          phi=-pi/2;
      else
          phi=atan((y_des(num+1)-y_des(num))/(x_des(num+1)-x_des(num)));
      end
   end
   
   x(i+1)=x(i)+velocity(i)*cos(phi)*smp_t;
   y(i+1)=y(i)+velocity(i)*sin(phi)*smp_t;
   acc(i+1)=(velocity(i+1)-velocity(i))/smp_t;
   Jerk(i+1)=(acc(i+1)-acc(i))/smp_t;
%    dis=dist3([0 0],[x(i),y(i)]);
%    actualxy=[x(i) y(i)]
%    act=act+velocity(i)*smp_t;
%    calculatexy=[act*cos(phi) act*sin(phi)]
end

% x(length(t_whole))=x_des(length(t));
% y(length(t_whole))=y_des(length(t));
%% draw the plot
figure 
plot(t_whole,velocity);
figure
plot(x,y,'-o','markersize',2);
legend('actual');
figure
plot(x_des,y_des);
legend('trajactary');
actualxy=[x(length(t_whole)) y(length(t_whole))]
[x_des(length(x_des)) y_des(length(y_des))]

subplot(3,1,1)
plot(t_whole,velocity);
title('velocity')
subplot(3,1,2)
plot(t_whole,acc);
title('accleration')
subplot(3,1,3)
plot(t_whole,Jerk);
title('Jerk')

