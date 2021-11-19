N=1000;
Q=[0,0;0,0];
R=1;
W=sqrt(Q)*randn(2,N);
V=sqrt(R)*randn(1,N);

A=[1,1;0,1];
B=[0.5;1];
U=-9.8;
H=[1,0];

X=zeros(2,N);
X(:,1)=[95;1];
P0=[10,0;0,1];
Z=zeros(1,N);
Z(1)=H*X(:,1);
Xkf=zeros(2,N);
Xkf(:,1)=X(:,1);
err_P=zeros(N,2);
err_P(1,1)=P0(1,1);
err_P(1,2)=P0(2,2);
I=eye(2);

for k=2:N
   X(:,k)=A*X( :,k-1)+B*U+W(k);
   
   Z(k)=H*X(:,k)+V(k);
   
   X_Pre=A*Xkf(:,k-1)+B*U;
   P_pre=A*P0*A'+Q;
   Kg=P_pre*H'*inv(H*P_pre*H'+R);
   Xkf(:,k)=X_Pre+Kg*(Z(k)-H*X_Pre);
   P0=(I-Kg*H)*P_pre;
   
   err_P(k,1)=P0(1,1);
   err_P(k,2)=P0(2,2);
    
end

subplot(2,1,1);
plot(Z);
subplot(2,1,2);
plot(Xkf());