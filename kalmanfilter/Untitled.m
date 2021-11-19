clear;
clc;
%%%%%%%%%%%         ���軷��        %%%%%%%%%%%%
N=2000;                                     %ʱ������
counter=1:2000
W=randn(1,N);                               %��������
X=stepfun(1:N,N/2)*10;                      %���ٶ����ߣ���λ���ȣ���k>1000֮����90��ÿ��Ľ��ٶ���ת
H=16.38375;                                 %ת������
V=randn(1,N)*20;                            %������������Ϊ�����������������ԣ����Գ���20��
for k=1:N
   Z(k)=X(k)*H+V(k);                        %���贫�����յ���ֵ����λ����
%   Z(k)=Z(k)/H;                             %��⵽��ֵ���ձ任��ʹ�õ�ֵ�������趨�ú����ͼ�Ƚ�
end

%%%%%%%%%%%         һЩ��Ҫ����ֵ�ı���        %%%%%%%%%%%%
X2(1)=0;                                    %X(k|k)
P2(1)=0;                                    %P(k|k)
A=1;
B=1;
Dw=std(W)^2;                                %������������
Dv=std(V)^2;                                %������������
I=1;                                        %��λ���󣬴˴�Ϊ1
Kg(1)=0;
Dw=0.01;
Err(1)=0;
% Dv=1;
%%%%%%%%%%%         ��ʼ����        %%%%%%%%%%%%
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
ylabel('��/s')
subplot(2,1,2)
plot(Err)
axis([0 2000 -5 12]);
title('Error');
legend('Error')
