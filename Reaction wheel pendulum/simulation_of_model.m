T = 0.001;                          % sample time
I_rB = 0.0002495644984;             % moment of inertia of body
C_fB = 0.0010403486675;             % damping coef of rotor
g = 9.81;                           % gravity constant
M = 0.3;                            % total mass of the moving part
mr = 0.0768;                        % mass of the rod
mb = 0.213;                         % mass of the body
lr = 0.12;                          % length from joint A to joint B
Ib = 0.0025624119799;               % moment of inertia of body
C_fA = 0.001585115164;              % damping coef of joint A
km = 0.0202;                        % motor torque constant
lb = 0.09673;                       % length from joint A to COM of body 
I_A = 0.01676805279669;             % moment of inertia of the moving part

A = [-(I_rB-I_A)*C_fB/(I_rB*I_A),-(mr*lr+mb*lb)*g/(I_A),-C_fA/I_A;
              0                          0               1;
           C_fB/I_A           (mr*lr+mb*lb)*g/(I_A)      -C_fA/I_A];
       
B = [(I_rB+I_A)/(I_rB*I_A);0;-km/I_A];

C = [0 1 0];

D = 0;

model = ss(A,B,C,D);

%% poles placement
k_place = place(A,B,[-5,-1+1i,-1-1i]');
A_place = A-B*k_place;
ss_place = ss(A_place,zeros(3,1),C,D);

[theta_b,t,states] = initial(ss_place,[0 deg2rad(15) 0]);


%% LQR
Q = [1 0 0 ;
    0 1 0 ;
    0 0 1 ];
R = 1;
[K_lqr,S,P] = lqr(model,Q,R);
ss_lqr = ss(A-B*K_lqr,zeros(3,1),C,D);
[X_lqr,t2,X_lqr_tra] = initial(ss_lqr,[0;deg2rad(15);0],t);
draw_pend(X_lqr_tra,lr)
%% plot

figure(1)
subplot(3,1,1)
plot(t,states(:,1)); hold on
plot(t2,X_lqr_tra(:,1));
subplot(3,1,2)
plot(t,states(:,2)); hold on
plot(t2,X_lqr_tra(:,2));
subplot(3,1,3)
plot(t,states(:,3));hold on
plot(t2,X_lqr_tra(:,3));

