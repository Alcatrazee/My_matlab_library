%% occpation definition
ui_num_all=10000;
ui_num_farmer=3410;
ui_num_police=340;
ui_num_manager=300;
ui_num_teacher=210;
ui_num_freeman=ui_num_all-ui_num_farmer-ui_num_police-ui_num_manager-ui_num_teacher;
%% salaries definition
f_sal_freeman=21920;
f_sal_farmer=21920;
f_sal_police=69983.5;
f_sal_manager=70000;
f_sal_teacher=60000;
f_sal_all=f_sal_farmer*ui_num_freeman+f_sal_farmer*ui_num_farmer+f_sal_police*ui_num_police+f_sal_manager*ui_num_manager+f_sal_teacher*ui_num_teacher;
%% salaries of all occupation
f_sals_farmer=f_sal_farmer*ui_num_farmer;
f_sals_police=f_sal_police*ui_num_police;
f_sals_manager=f_sal_manager*ui_num_manager;
f_sals_teacher=f_sal_teacher*ui_num_teacher;
f_sals_freeman=f_sal_freeman*ui_num_freeman;
%% create x and y
x=[0 (ui_num_farmer+ui_num_freeman)/ui_num_all (ui_num_freeman+ui_num_farmer+ui_num_teacher)/ui_num_all (ui_num_freeman+ui_num_farmer+ui_num_teacher+ui_num_police)/ui_num_all ui_num_all/ui_num_all];
y=[0 (f_sals_freeman+f_sals_farmer)/f_sal_all (f_sals_freeman+f_sals_farmer+f_sals_teacher)/f_sal_all (f_sals_freeman+f_sals_farmer+f_sals_teacher+f_sals_police)/f_sal_all f_sal_all/f_sal_all];

plot(x,y,'-r')
hold on
line([0 1],[0 1])