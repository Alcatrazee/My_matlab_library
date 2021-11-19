t=0:0.01:10;


for i=2:4
    subplot(3,1,i-1)
    switch i
        case 2 
            title('r=2');
            r=2;
        case 3
            title('r=3');
            r=3;
        case 4
            title('r=4');
            r=4;
    end
    x=r*cos(t)+3*t;
    y=r*sin(t)+3;
    plot(x,y)
    axis([0 30 -10 10])
end



