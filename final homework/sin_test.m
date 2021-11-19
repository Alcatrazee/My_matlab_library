max_v=20;
min_v=50;
acc_t=0.25;


smp_t=0.005;
t=0:smp_t:acc_t;
v=(max_v-min_v)/2*(sin(pi/acc_t*(t-acc_t/2))+1)+min_v;
plot(t,v)