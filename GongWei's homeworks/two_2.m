t=0:0.01:10;
a=1;
for n=1:4
    subplot(4,1,n)
    switch n
        case 1
            title('r=2');
        case 2 
            title('r=2');
        case 3
            title('r=3');
        case 4
            title('r=4');
    end
    x=sin(t);
    y=sin(n*t+a);
    plot(x,y);
    %axis([0 30 -10 10])
end
