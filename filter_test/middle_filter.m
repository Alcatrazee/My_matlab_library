function result = middle_filter(input_vector,num)

[length,~] = size(input_vector);
result=0;
window = zeros(1,num);
current_pointer=1;
i=1;
while (1)
    if(length-current_pointer>num)
        for j = 0:num-1                     %¸³Öµ¸ø´°
           window(j+1) = input_vector(current_pointer+j); 
        end
        current_pointer = current_pointer+num;
        result(i) = median(window);
        i=i+1;
    else 
       break; 
    end
end