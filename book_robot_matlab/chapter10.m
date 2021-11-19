clear;
clc

lambda = [300:10:1000]*1e-9;
for T = 1000:1000:6000
   plot(lambda*1e-9,blackbody(lambda,T));
   hold all;
end