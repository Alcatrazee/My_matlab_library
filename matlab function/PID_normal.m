function out=PID_normal(Kp,Ki,Kd,errork,errork_f,error_sum)
%cultculate the output of a PID controller
%you know what the parameters mean
out = Kp*errork+Ki*error_sum+Kd*(errork-errork_f);