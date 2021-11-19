x = -10:0.1:10;
y = x;
z = zeros(length(x),length(y));

for i=1:length(x)
    for j = 1:length(y)
        z(i,j) = [x(i) y(j)]*A*[x(i) y(j)]';
    end
end
mesh(x,y,z)