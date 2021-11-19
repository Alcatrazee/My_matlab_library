correct=0;
while correct~=1
   psw=input('input your password:') 
   if psw==123
      correct=1;
      disp 'correct'
      break;
   else
       disp 'password incorrect,please input the right password:'
   end
end
disp 'program ended'