syms x
y=x*exp(2*x);
answer=diff(y,20);
pretty(answer)
