function out=middle(array)
%       ȡ��λ������
%       array:ȡ��λ��������
sorted_arr = sort(array);
num=size(array);
num=num(2);
if(mod(num,2)~=0)
   out = sorted_arr(num/2+0.5); 
else
   out = 'The length of this array is not odd';
end

