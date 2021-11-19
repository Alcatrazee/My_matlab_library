function out=mythreshold(img,val_max,val_min)

%return the binary image 
%para:img:image,a matrix of n by m
%val_max: gray value 
if val_max<val_min
   temp=val_max;
   val_max=val_min;
   val_min=temp;
end

s=size(img);
out=zeros(s);
for row=1:s(1)
   for column=1:s(2)
       if img(row,column)<val_max&&img(row,column)>val_min
          out(row,column) = 1;
       end
   end
end
out=logical(out);