function out=integrat(array,dt)
%       name       :integration
%       principle  :integrate the input array and output the array
if nargin<2
    error('not enough parameters');
end
length = size(array);
length = length(2);
out_put = zeros(1,length);
out_put(1)=array(1)*dt(1);
for k=2:length
    out_put(k) = out_put(k-1)+array(k)*dt(k);
end
out = out_put;