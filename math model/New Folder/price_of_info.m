C1 = 1;
C2 = 1;
Value_info = 10;
Value_ins = 10;
Cost_def = 0;
F_ds = 0;

for t=1:100
   Value_rel=round(abs(rand(1,1)*10));
   Value_rel=Value_rel+b*Value_n*revelance;
end
Cost_def = a*Value_info + Value_rel;

price = C1*C2*Value_info+Value_ins+Cost_def+F_ds;