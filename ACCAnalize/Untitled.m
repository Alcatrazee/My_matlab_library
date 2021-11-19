clear;
clc;
all = load('ACC data2.txt');
ACC_X = all(:,1)';
ACC_Y = all(:,2)';
dt = all(:,3)';
dem = size(ACC_X);
num = dem(2);
count = 1:num;
intgrat_X(1)=ACC_X(1)*dt(1);
intgrat_Y(1)=ACC_Y(1)*dt(1);
sum_x=ACC_X(1)*dt(1);
sum_y=ACC_Y(1)*dt(1);
for k=2:num
    intgrat_X(k)=intgrat_X(k-1)+ACC_X(k)*dt(k);
    sum_x=sum_x+ACC_X(k)*dt(k);
    intgrat_Y(k)=intgrat_Y(k-1)+ACC_Y(k)*dt(k);
    sum_y=sum_y+ACC_Y(k)*dt(k);
end

integrated_reduce_middle_filter_X(1)=0;
integrated_reduce_middle_filter_Y(1)=0;
integrated_middle_filter_X(1)=0;
integrated_middle_filter_Y(1)=0;
integrated_avg_filter_X(1)=0;
integrated_avg_filter_Y(1)=0;

avg_filter_number=5;
arr_x_end(1)=0;
arr_y_end(1)=0;
arr_x_end=reduce_middle_fil(ACC_X,avg_filter_number);
arr_y_end=reduce_middle_fil(ACC_Y,avg_filter_number);
integrated_reduce_middle_filter_X=integrat(arr_x_end,dt);
integrated_reduce_middle_filter_Y=integrat(arr_y_end,dt);

af_loop_filter_num = 5;
AF_LOOP_FIL_X(1)=0;
AF_LOOP_FIL_Y(1)=0;
AF_LOOP_FIL_X = Loop_middle_filter(ACC_X,af_loop_filter_num);
AF_LOOP_FIL_Y = Loop_middle_filter(ACC_Y,af_loop_filter_num);
integrated_middle_filter_X=integrat(AF_LOOP_FIL_X,dt);
integrated_middle_filter_Y=integrat(AF_LOOP_FIL_Y,dt);


avg_filter_num=5;
avg_fil_X(1)=0;
avg_fil_Y(1)=0;
avg_fil_X = Avg_filter(ACC_X,avg_filter_num);
avg_fil_Y = Avg_filter(ACC_Y,avg_filter_num);
integrated_avg_filter_X=integrat(avg_fil_X,dt);
integrated_avg_filter_Y=integrat(avg_fil_Y,dt);
%%%%%%%             Draw the plot              %%%%%%%
figure;

subplot(3,2,1);
plot(arr_x_end);
title('first filter');
axis([1 floor(num/af_loop_filter_num) -0.05 0.05])

subplot(3,2,3);
plot(AF_LOOP_FIL_X);
title('After Loop filter X');
axis([1 num -0.05 0.05]);

subplot(3,2,5);
plot(avg_fil_X);
title('After Avg filter X');
axis([1 floor(num/avg_filter_num) -0.05 0.05]);

subplot(3,2,2);
plot(arr_y_end);
title('first filter');
axis([1 floor(num/af_loop_filter_num) -0.05 0.05])

subplot(3,2,4);
plot(AF_LOOP_FIL_Y);
title('After Loop filter Y');
axis([1 num -0.05 0.05]);

subplot(3,2,6);
plot(avg_fil_Y);
title('After Avg filter Y');
axis([1 floor(num/avg_filter_num) -0.05 0.05]);
%%%%%%%             Draw the plot2              %%%%%%%
figure

subplot(3,2,1);
plot(integrated_reduce_middle_filter_X);
title('After first filter X');
axis([1 floor(num/af_loop_filter_num) -0.05 0.05]);

subplot(3,2,2);
plot(integrated_reduce_middle_filter_Y);
title('After first filter Y');
axis([1 floor(num/af_loop_filter_num) -0.05 0.05]);

subplot(3,2,3);
plot(integrated_middle_filter_X);
title('After Loop filter X');
axis([1 num -0.05 0.05]);

subplot(3,2,4);
plot(integrated_middle_filter_Y);
title('After Loop filter Y');
axis([1 num -0.05 0.05]);

subplot(3,2,5);
plot(integrated_avg_filter_X);
title('After Avg filter X');
axis([1 floor(num/avg_filter_num) -0.05 0.05]);

subplot(3,2,6);
plot(integrated_avg_filter_Y);
title('After Avg filter Y');
axis([1 floor(num/avg_filter_num) -0.05 0.05]);


