function []=homework()
clear
clc
close all
%% construct the trajactary    scalar:mm
t=0:-1:-2000;
x_des=0*ones(1,length(t));
y_des=1*t;
S=0;
for i=1:length(t)-1
    S=S+dist3([x_des(i),y_des(i)],[x_des(i+1),y_des(i+1)]);
end
%% generate the velocity trajactary
smp_t=0.01;                                    %sample time
max_velocity=600;                               %maximun velocity
accl_time=1.5;                                 %accleration time  scalar:s

acc_up=S_curve_planning(0,max_velocity,accl_time,smp_t);    %get acc curve
sum_up=acc_up(length(acc_up));                              %get integration

acc_down=S_curve_planning(max_velocity,0,accl_time,smp_t);  %get acc curve
sum_down=acc_down(length(acc_down));                        %get integration

if S>abs(sum_up+sum_down)                           %judge if maximun v can be reached
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
global x;
global y;
x=zeros(1,length(t_whole)-1);
y=zeros(1,length(t_whole)-1);
num=1;
current_waypoint=[x(num) y(num)];
acc=zeros(1,length(t_whole)-1);
Jerk=zeros(1,length(t_whole)-1);
for i=1:length(t_whole)-1
    % to judge if we need to change the waypoint
    if dist3(current_waypoint,[x,y])<=0.00001
        if num+1<length(t)
            num=num+1;
        end
        current_waypoint=[x_des(num) y_des(num)];
        if x_des(num+1)-x_des(num)==0 && y_des(num+1)-y_des(num)>=0
            phi=pi/2;
        elseif x_des(num+1)-x_des(num)==0 && y_des(num+1)-y_des(num)<0
            phi=-pi/2;
        else
            phi=atan((y_des(num+1)-y_des(num))/(x_des(num+1)-x_des(num)));
        end
    end
    
    x(i+1)=x(i)+velocity(i)*cos(phi)*smp_t;                                  %generate the x axis point list
    y(i+1)=y(i)+velocity(i)*sin(phi)*smp_t;                                  %generate the x axis point list
    acc(i+1)=(velocity(i+1)-velocity(i))/smp_t;                              %calculate the derivative of velocity
    Jerk(i+1)=(acc(i+1)-acc(i))/smp_t;                                       %calculate the derivative of accleration
end
%% draw the plot
% figure (1)
% plot(t_whole,velocity);
% figure(2)
% plot(x,y,'-o','markersize',2);
% legend('actual');
% axis([-1 1 -2000 2000])
% figure(3)
% plot(x_des,y_des);
% legend('trajactary');
% actualxy=[x(length(t_whole)) y(length(t_whole))]
% [x_des(length(x_des)) y_des(length(y_des))]
% 
% figure(4)
% subplot(3,1,1)
% plot(t_whole,velocity);
% title('velocity')
% subplot(3,1,2)
% plot(t_whole,acc);
% title('accleration')
% subplot(3,1,3)
% plot(t_whole,Jerk);
% title('Jerk')
SerialFuc();
end

%% send message to the MCU
% Find a serial port object.
function SerialFuc() 
  delete(instrfindall)      % 关闭串口，此句十分重要，下篇再详细解释
  global s;                 % 全局变量，供串口中断函数使用
  global x;
  global y;
  s = serial('com13');       %使用默认设置创建串口s
  set(s,'inputbuffersize',100);
  set(s,'BaudRate',230400);
  set(s,'BytesAvailableFcnMode','Terminator'); %设置中断触发方式
  set(s,'Terminator','LF');


  figure   % to contain the new plot
  subplot(6,2,1);
  hold on
  title('exp_x');
  
  subplot(6,2,2);
  hold on
  title('exp_y');
  
  subplot(6,2,3);
  hold on
  title('exp_Vx');
  
  subplot(6,2,4);
  hold on
  title('exp_Vy');
  
  subplot(6,2,5);
  hold on
  title('x');
  
  subplot(6,2,6);
  hold on
  title('y');
  
  subplot(6,2,7);
  hold on
  title('vx');
  
  subplot(6,2,8);
  hold on
  title('vy');
  
  subplot(6,2,9);
  hold on
  title('angle');
  
  subplot(6,2,10);
  hold on
  title('omega');
  
  subplot(6,2,11);
  hold on
  title('ax');
  
  subplot(6,2,12);
  hold on
  title('ay');
  
  flushinput(s);
  fopen(s);                 %打开串口
  dat=zeros(length(x),100);
  for k=1:length(x)               % 每两秒发送字符串，循环五次
      msg=make_msg(x(k),y(k))
      fprintf(s,msg);
      pause(0.0001);
      rec=fscanf(s);
      if length(rec)==100
        dat=[dat;rec];
      end
  end
  fclose(s);
  draw(dat);
end
%%
function USARTCallbackFcn( obj,event)     %创建中断响应函数
global s
dat=fscanf(s);
if length(dat)==100
    exp_x=str2double(dat(1:6));
    exp_y=str2double(dat(8:13));
    exp_vx=str2double(dat(15:20));
    exp_vy=str2double(dat(22:27));
    x=str2double(dat(29:34));
    y=str2double(dat(36:41));
    Vx=str2double(dat(43:48));
    Vy=str2double(dat(50:55));
    angle=str2double(dat(57:62));
    omega=str2double(dat(65:71));
    ax=str2double(dat(73:79));
    ay=str2double(dat(81:87));
    time=str2double(dat(89:98));
    
    subplot(6,2,1);
    plot(time,exp_x,'-o','markersize',2);
    subplot(6,2,2);
    plot(time,exp_y,'-o','markersize',2);
    subplot(6,2,3);
    plot(time,exp_vx,'-o','markersize',2);
    subplot(6,2,4);
    plot(time,exp_vy,'-o','markersize',2);
    subplot(6,2,5);
    plot(time,x,'-o','markersize',2);
    subplot(6,2,6);
    plot(time,y,'-o','markersize',2);
    subplot(6,2,7);
    plot(time,Vx,'-o','markersize',2);
    subplot(6,2,8);
    plot(time,Vy,'-o','markersize',2);
    subplot(6,2,9);
    plot(time,angle,'-o','markersize',2);
    subplot(6,2,10);
    plot(time,omega,'-o','markersize',2);
    subplot(6,2,11);
    plot(time,ax,'-o','markersize',2);
    subplot(6,2,12);
    plot(time,ay,'-o','markersize',2);
end
end
