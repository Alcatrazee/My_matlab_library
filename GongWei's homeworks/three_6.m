x=input('input x: ');
n=input('input n: ');

y=1;

for i=1:n
    y=y+(x^i)/(factorial(i));
end
y