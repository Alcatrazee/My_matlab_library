N=400;
dt=0.05;
%change lane trajectry
xe=20;                                          %turn vertical   distance 
k=5;                                            %turn horizental distance
a=-2*k/(xe^3);
b=3*k/(xe^2);
c=0;
d=0;
xdes=0:0.05:xe-0.05;
ydes=zeros([1 N]);
psides=zeros([1 N]);
waypoint=zeros([N 2]);
acc=zeros([1 N]);
v=smooth_v(20,1,400);

x=zeros([1 2*N]);
y=zeros([1 2*N]);

for i=2:N
   ydes(i)=a*xdes(i)^3+b*xdes(i)^2+c*xdes(i)+d; 
   psides(i)=3*a*xdes(i)^2+2*b*xdes(i)+c;

   waypoint(i,1)=xdes(i);
   waypoint(i,2)=ydes(i);

   sqrt((ydes(i)-ydes(i-1))^2+(xdes(i)-xdes(i-1))^2);
end

% t=2;
% while x(t)<xdes(N)
%     
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(xdes,acc)
hold on;
