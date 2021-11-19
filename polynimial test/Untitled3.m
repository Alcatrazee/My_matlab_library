xe=20;                                         %turn vertical   distance 
k=5;                                            %turn horizental distance
a=-2*k/(xe^3);
b=3*k/(xe^2);
c=0;
d=0;
x=0:1:xe-0.01;
y=zeros([1 xe]);
for i=1:xe
   y(i)=a*x(i)^3+b*x(i)^2+c*x(i)+d; 
end
plot(x,y);
axis([0 xe -k k])