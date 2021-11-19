function true_or_false=Check_param_range(param,min,max)
% usage: check if the parameter is out of bound or not

if(param>max||param<min)
    true_or_false=0;
else
    true_or_false=1;
end