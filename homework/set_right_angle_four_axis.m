function out=set_right_angle_four_axis(SA_theta)

%make the angle of each joint in the legal range
%input the six angle of each joint
%input is a column vector

SA_MAX_t1=deg2rad(135);
SA_MIN_t1=deg2rad(-135);
SA_MAX_t2=deg2rad(150);
SA_MIN_t2=deg2rad(-150);
SA_MAX_t3=deg2rad(360);
SA_MIN_t3=deg2rad(-360);
SA_MAX_t4=deg2rad(-70);
SA_MIN_t4=deg2rad(-185);

range=[SA_MAX_t1 SA_MIN_t1;
       SA_MAX_t2 SA_MIN_t2;
       SA_MAX_t3 SA_MIN_t3;
       SA_MAX_t4 SA_MIN_t4];
out=zeros([1 4]);
for t=1:3
   if SA_theta(t)> range(t,1)||SA_theta(t)< range(t,2)
       temp=fix(SA_theta(t)/(2*pi));
       out(t)=SA_theta(t)-temp*2*pi;
   else
       out(t)=SA_theta(t);
   end
end
out(4)=SA_theta(4,1);
out=out';