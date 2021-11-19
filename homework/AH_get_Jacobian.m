function out = AH_get_Jacobian(epsi_all,exp_1,exp_2,exp_3)

%function get Jacobian for inverse kinematic
%input para: epsi_all a vector of all epsi
%input para:exp_all :vector of all exp

out=[epsi_all(:,1)    Adg(exp_1)*epsi_all(:,2)    Adg(exp_1*exp_2)*epsi_all(:,3)    Adg(exp_1*exp_2*exp_3)*epsi_all(:,4)];