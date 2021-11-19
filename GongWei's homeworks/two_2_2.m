t=0:0.01:10;
n=2;
for i=1:4
    subplot(4,1,i)
    switch i
        case 1
            title('r=2');
            a=0
        case 2 
            title('r=2');
            a=pi/3;
        case 3
            title('r=3');
            a=pi/2;
        case 4
            title('r=4');
            a=pi;
    end
    x=sin(t);
    y=sin(n*t+a);
    plot(x,y);
    %axis([0 30 -10 10])
end
