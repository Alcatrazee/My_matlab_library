x=-2:(8-(-2))/100:8;

num=polyval([1 -4 3 -2 0 6],x);

root=roots([1 -4 3 -2 0 6]);

plot(x,num)

num_over=0;

for i=1:101
   if num(i)>0
       num_over=num_over+1;
   end
end

num_over
root