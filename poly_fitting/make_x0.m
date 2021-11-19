function output = make_x0(x,order)

[~,size_of_x] = size(x);
result = zeros(size_of_x,order+1);
k=1;
for i=1:size_of_x
    k=1;
   for j=order:-1:0
      result(i,k) = power(x(i),j);
      k=k+1;
   end
end
output = result;