function SerialFuc()        % ��������
  delete(instrfindall)      % �رմ��ڣ��˾�ʮ����Ҫ����ƪ����ϸ����
  global s;                 % ȫ�ֱ������������жϺ���ʹ��
  s = serial('com13');       %ʹ��Ĭ�����ô�������s
  set(s,'BytesAvailableFcnMode','Terminator'); %�����жϴ�����ʽ
  set(s,'Terminator','LF');
  set(s,'BaudRate',230400);
  s.BytesAvailableFcn =@ReceiveCallback;       % �����ж���Ӧ��������
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
  fopen(s);                 %�򿪴���
  
%   for k=1:1:1000               % ÿ���뷢���ַ�����ѭ�����
%       fprintf(s,'ChunyuY19');
%       pause(0.1);
%   end    
end

function ReceiveCallback( obj,event)     %�����ж���Ӧ����
   global s;
   dat = fscanf(s) ;      % �������ݲ���ʾ���޷ֺţ�
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
    drawnow
   end

end