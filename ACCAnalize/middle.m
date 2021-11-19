function out=middle(array)
%       取中位数函数
%       array:取中位数的序列
sorted_arr = sort(array);
num=size(array);
num=num(2);
if(mod(num,2)~=0)
   out = sorted_arr(num/2+0.5); 
else
   out = 'The length of this array is not odd';
end

