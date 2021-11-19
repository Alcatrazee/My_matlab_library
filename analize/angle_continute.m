
t = -2*pi:0.001:2*pi;
y=sawtooth(t*2+pi)*180;
x = linspace(-720,720,length(y));
subplot(2,1,1)
plot1 = plot(x,y);
xlabel('actual angle')
ylabel('output')
title('original output')
real_angle = zeros(1,length(y));
Loops=0;
for i=1:length(real_angle)-1
    gain = y(i+1)-y(i);
    if(x(i)<=-360&&x(i)>=-360.2)
        k=1;
    end
    if(y(i+1)*y(i)<0)
        if(abs(gain)>300)
            if(y(i+1)<0)
                Loops=Loops+1;
                gain = 360+y(i+1)-y(i);
            else
                Loops=Loops-1;
                gain = -360-y(i)+y(i+1);
            end
        else
            if(y(i+1)<0)
                Loops=Loops-1;
                gain = y(i+1)-y(i);
            else
                Loops=Loops+1;
                gain = y(i+1)-y(i);
            end
        end
        real_angle(i+1) = Loops*180+gain;
    else
        real_angle(i+1) = real_angle(i)+gain;
    end
end
subplot(2,1,2);
plot(x,real_angle);
ylabel('algorithm output')
xlabel('actual angle')
title('after processing')