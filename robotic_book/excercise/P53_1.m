[s,sd,sdd] = tpoly(0,1,50,0,i);
subplot(3,1,1);
plot(s);
legend('s')
subplot(3,1,2);
plot(sd);
legend('sd')
subplot(3,1,3);
plot(sdd);
legend('sdd')
max(s)