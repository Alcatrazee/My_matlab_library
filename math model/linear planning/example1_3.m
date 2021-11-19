
%%
f=[2 3 1];
A=[-1 -4 -2;-3 -2 0];
b=[-8 -6];
Aeq=[];
beq=[];
lb=zeros(1,3);
[x,fval]=linprog(f,A,b,Aeq,beq,lb)
%%