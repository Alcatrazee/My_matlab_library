function out=make_msg_v(v_x,v_y)

%create the message for the MCU
%v_x is the expcted velocity of x axis
%v_y is the expcted velocity of y axis

if v_y>800||v_x>800||v_y<-800||v_x<-800
   error('input out of range'); 
end

str_vy=sprintf('%6d',v_y);
str_vx=sprintf('%6d',v_x);
out = ['V' str_vx str_vy];