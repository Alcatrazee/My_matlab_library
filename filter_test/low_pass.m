function result = low_pass(input_vector)


A = 0.05;
[length,~] = size(input_vector);
result = zeros(length,1);
for i=2:length
    result(i) = A*result(i-1)+(1-A)*input_vector(i); 
end