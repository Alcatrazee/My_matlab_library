function out=make_msg(exp_posx,exp_posy)

%function :create the instruction for the MCU
%input : exp_posx :expected position of x axis in global frame
%        exp_posy :expected position of y axis in global frame
%scalar:mm

if exp_posy>100000||exp_posx>100000||exp_posy<-10000||exp_posx<-10000
   error('input out of range'); 
end

str_expy=sprintf('%06d',round(exp_posy));
str_expx=sprintf('%06d',round(exp_posx));
out=['G' str_expx str_expy];