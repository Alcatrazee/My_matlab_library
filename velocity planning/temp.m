dat=load('C:\Users\Shinelon\Desktop\data1.txt');
figure 
hold on
plot(dat(:,1));
x=1:600;
y=zeros(1,600);
for i=1:600 
    y(i)=400; 
end
plot(x,y)