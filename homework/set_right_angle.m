function out=set_right_angle(SA_theta)

%make the angle of each joint in the legal range
%input the six angle of each joint

SA_MAX_t1=deg2rad(170);
SA_MIN_t1=deg2rad(-170);
SA_MAX_t2=deg2rad(110);
SA_MIN_t2=deg2rad(-110);
SA_MAX_t3=deg2rad(136);
SA_MIN_t3=deg2rad(-136);
SA_MAX_t4=deg2rad(185);
SA_MIN_t4=deg2rad(-185);
SA_MAX_t5=deg2rad(120);
SA_MIN_t5=deg2rad(-120);
SA_MAX_t6=deg2rad(360);
SA_MIN_t6=deg2rad(-360);

range=[SA_MAX_t1 SA_MIN_t1;
       SA_MAX_t2 SA_MIN_t2;
       SA_MAX_t3 SA_MIN_t3;
       SA_MAX_t4 SA_MIN_t4;
       SA_MAX_t5 SA_MIN_t5;
       SA_MAX_t6 SA_MIN_t6];
out=zeros([1 6]);
for t=1:6
   if SA_theta(t)> range(t,1)||SA_theta(t)< range(t,2)
       temp=fix(SA_theta(t)/(2*pi));
       out(t)=SA_theta(t)-temp*2*pi;
   else
       out(t)=SA_theta(t);
   end
end
out=out';