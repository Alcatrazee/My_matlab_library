clear;
Z = load('jj.txt')';
length = size(Z);
temp(1) = 0;
num_sample = length(2);
S = 1:num_sample;
a = 1;
c = 1;
w(1) = 1;
w = randn(1,num_sample);

v = randn(1,num_sample);
for N = 2:num_sample
   temp(N) = 0; 
end

Dv = (std(v))^2;
Dw = (std(w))^2;
P2(1) = 0;
out(1) = 0;
%Z = c*temp + v;

%Z = Z-mean(Z(a:num_sample));
Dv = (std(Z))^2;
Dw = 0.001;
pos = 0;
pos2 = 0;

for N = 2:num_sample
   P1(N) = a.^2*P2(N-1) + Dw;
   K(N) = P1(N)*c/(P1(N)*c.^2+Dv);
   out(N)=a*out(N-1)+K(N)*(Z(N)-c*out(N-1));
   P2(N) =P1(N)-c*K(N)*P1(N);
   pos(N) = pos(N-1)+out(N)*0.02;
   pos2(N) = pos2(N-1)+Z(N)*0.02;
end
figure(1)
subplot(4,1,1);
plot(S,temp,'r',S,out,'b');
subplot(4,1,2);
plot(S,temp,'r',S,Z,'b');
subplot(4,1,3);
plot(S,pos,'r',S,pos2,'g')

Dv = std(pos)^2;
Z = pos;

P1(1)=0;
K(N) = 0;
out(1) = 0;
p2(1) = 0;

for N = 2:num_sample
   P1(N) = a.^2*P2(N-1) + 0.0005;
   K(N) = P1(N)*c/(P1(N)*c.^2+Dv);
   out(N)=a*out(N-1)+K(N)*(Z(N)-c*out(N-1));
   P2(N) =P1(N)-c*K(N)*P1(N);
end

subplot(4,1,4);
plot(S,pos,'r');