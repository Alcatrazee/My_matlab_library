clear;clc
syms t  real
syms q1(t) q2(t)
syms r1
syms r2
syms l1 
syms l2
syms m1;
syms m2;
syms J1;
syms J2;
syms g;

P_1 = r1*[cos(q1),sin(q1)];
P_2 = [l1*cos(q1)+r2*cos(q1+q2);
       l1*sin(q1)+r2*sin(q1+q2)];
   
%%
V_1 = diff(P_1,t);
V_2 = diff(P_2,t);

%%
T1 = 0.5*m1*sum(V_1.^2) + 0.5 * J1 * diff(q1,t)^2;
T2 = 0.5*m2*sum(V_2.^2) + 0.5 * J2 * diff(q2,t)^2;

V1 = m1*g*r1*sin(q1);
V2 = m2*g*(l1*sin(q1) + r2 *sin(q1+q2));

%%
L = simplify(T1+T2-V1-V2);