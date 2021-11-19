clear;
clc;
%%%%%%%%%%%         假设环境        %%%%%%%%%%%%
N=2000;                                     %时刻总量
counter=1:2000
W=randn(1,N);                               %过程噪声
X=stepfun(1:N,N/2)*10;                      %角速度曲线，单位：度，在k>1000之后以90°每秒的角速度旋转
H=16.38375;                                 %转换矩阵
V=randn(1,N)*20;                            %测量噪声，因为不够大，噪声不够明显，所以乘以20倍
for k=1:N
   Z(k)=X(k)*H+V(k);                        %假设传感器收到的值，单位：无
%   Z(k)=Z(k)/H;                             %检测到的值最终变换成使用的值，这样设定好后面绘图比较
end

%%%%%%%%%%%         一些需要赋初值的变量        %%%%%%%%%%%%
X2(1)=0;                                    %X(k|k)
P2(1)=0;                                    %P(k|k)
A=1;
B=1;
Dw=std(W)^2;                                %过程噪声方差
Dv=std(V)^2;                                %测量噪声方差
I=1;                                        %单位矩阵，此处为1
Kg(1)=0;
Dw=0.01;
Err(1)=0;
% Dv=1;
%%%%%%%%%%%         开始计算        %%%%%%%%%%%%
for k=2:N
   P1=A*P2*A+Dw;                            %P(k|k-1)=A*P(k-1|k-1)*A'+Q
   Kg(k)=P1*H/(H*P1*H+Dv);                  %Kg(k)=P(k|k-1)*H'/(H*P(k|k-1)*H'+R)
   X2(k)=X2(k-1)+Kg(k)*(Z(k)-H*X2(k-1));    %X(k|k)=X(k|k-1)+Kg(k)*(Z(k)-H*X(k|k-1))
   P2=(I-Kg(k)*H)*P1;                       %P(k|k)=I-Kg(k)*H*P(k|k-1)
   Err(k)=X(k)-X2(k);
end

Y(1)=0;
AF(1)=0;

for k=1:N
   Y(k)=Z(k)/H; 
   AF(k)=X2(k);
   Err(k)=Err(k);
end
subplot(2,1,1)
plot(counter,X,'b',counter,Y,counter,AF,'k');
title('all');
legend('real','sensor data','after filter');
axis([0 2000 -5 15]);
xlabel('time')
ylabel('°/s')
subplot(2,1,2)
plot(Err)
axis([0 2000 -5 12]);
title('Error');
legend('Error')
