while 1
   num=input('input a number');
   if num~=fix(num)
       disp 'please input a integer'
       continue; 
   end
   k=2;
   while k<num
       if mod(num,k)==0
            disp 'it is not a prime number';
            break;
       end
       k=k+1;
   end
   if k==num
       disp 'it is a prime number';
   end
end