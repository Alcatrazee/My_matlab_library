function duration_of_flight=Battery_model(Cb,Rb,Ub,Kb,Gb,Ib)

% output scaler : minutes

Cmin = Cb*0.2;

duration_of_flight = (Cb-Cmin)/Ib*60/1000;