Row=8;
Column=6;
num=randn(Row,Column);
avg_n=zeros([1 Column]);
var_n=zeros([1 Column]);
for n=1:Column
   avg_n(n)=mean(num(:,1));
   var_n(n)=var(num(:,1));
end
num_reshape=reshape(num,8*6,1);
var_all=var(num_reshape);
avg_all=mean(num_reshape);