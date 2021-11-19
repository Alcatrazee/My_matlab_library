function out=reduce_middle_fil(array,filter_number)
%           name       :reduce_middle_fil
%           principle  :get a middle number of every  filter_number of
%           datas
num=size(array);
num=num(2);
loop_main_num = floor(num/5);
arr5_x(1,1)=0;
arr5_y(1,1)=0;
arr_x_end = zeros(1,loop_main_num);
arr_y_end = zeros(1,loop_main_num);
counter = 1;
 for k=1:loop_main_num
     for i=1:5
        arr5_x(k,i)=array(counter);
        counter = counter+1;
     end
     arr_x_end(k)=middle(arr5_x(k,:));
 end
 out = arr_x_end;