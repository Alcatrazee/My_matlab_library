%syms t1 t2 t3 t4 t5 t6;
t1 = deg2rad(15);
t2 = deg2rad(-40);
t3 = deg2rad(-50);
t4 = deg2rad(30);
t5 = deg2rad(70);
t6 = deg2rad(25);
T_01 = make_exp(e_ro([1 0 0]',0),[0 0 0]')*make_exp(e_ro([0 0 1]',t1),[0 0 0]');
T_12 = make_exp(e_ro([1 0 0]',deg2rad(-90)),[0 0 0]')*make_exp(e_ro([0 0 1]',t2),[0 0 220]');
T_23 = make_exp(e_ro([1 0 0]',0),[430 0 0]')*make_exp(e_ro([0 0 1]',t3),[0 0 -90]');
T_34 = make_exp(e_ro([1 0 0]',deg2rad(-90)),[0 0 0]')*make_exp(e_ro([0 0 1]',t4),[0 0 430]');
T_45 = make_exp(e_ro([1 0 0]',deg2rad(90)),[0 0 0]')*make_exp(e_ro([0 0 1]',t5),[0 0 0]');
T_56 = make_exp(e_ro([1 0 0]',deg2rad(-90)),[0 0 0]')*make_exp(e_ro([0 0 1]',t6),[0 0 0]');
T_06 = T_01*T_12*T_23*T_34*T_45*T_56
