function out=Loop_middle_filter(array,num)
%       name     :Loop_middle_filter
%       principle:get num number and get one middle number,then add 1
%       then recycle
%       output   :array of all the middle number
length = size(array);
length = length(2);
end_array = zeros(1,length-num);
for k=1:length-num
        end_array(k)=middle(array(k:k+num-1));
end
out = end_array;