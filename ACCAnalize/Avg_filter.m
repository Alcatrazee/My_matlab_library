function out=Avg_filter(array,filter_number)
%       name      : Avg filter
%       principle : Get average of every filter_numer of datas,and get the
%       average of it 
length = size(array);
length = length(2);
list = zeros(floor(length/filter_number),filter_number);
output = zeros(1,floor(length/filter_number));
loop_number = floor(length/filter_number);
counter=1;
for k=1:loop_number
    for i=1:filter_number
        list(k,i)=array(counter);
        counter=counter+1;
    end
    output(k)=mean(list(k,:));
end
out=output;