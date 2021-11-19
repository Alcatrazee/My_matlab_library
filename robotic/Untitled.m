Rad1 = -pi/2:0.01:pi/2;%input('input the angle(rad) of joint 1 \n');
Rad2 = -pi/2:0.01:pi/2;%input('input the angle(rad) of joint 2 \n');
Rad3 = -pi/2:0.01:pi/2;
Rad4 = -pi/2:0.01:pi/2;

L1 = Link('d', 0, 'a', 1, 'alpha', 0,'qlim',[-pi/2 pi/2])
L2 = Link('d', 0, 'a', 1, 'alpha', 0,'qlim',[-pi/2 pi/2])
L3 = Link('d', 0, 'a', 0.5, 'alpha', pi/2,'qlim',[-pi/2 pi/2])
L4 = Link('d', 0, 'a', 0.3, 'alpha', 0,'qlim',[-pi/2 pi/2])
bot = SerialLink([L1 L2 L3 L4], 'name', 'my robot')
N = 315;
for t=1:N
    bot.plot([Rad1(t) Rad2(t) Rad3(t) Rad4(t)])
end