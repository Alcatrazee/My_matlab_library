Num = [10 100];
den = [1 7 17 0];
y_stable = 1;
sys1 = feedback(tf(Num(1),den),1);
sys2 = feedback(tf(Num(2),den),1);
[y1 t1 x1] = step(sys1);
[y2 t2 x2] = step(sys2);
%% rising time 
for i=1:length(y1)
   if y1(i)> y_stable*0.9
      rising_time1 = t1(i);
       break; 
   end
end
rising_time1

for i=1:length(y2)
   if y2(i)> y_stable
      rising_time2 = t2(i);
       break; 
   end
end
rising_time2

%% overlay time
max_sys1 = max(y1)
overlay1 = max_sys1 - y_stable

max_sys2 = max(y2)
overlay2 = max_sys2 - y_stable




