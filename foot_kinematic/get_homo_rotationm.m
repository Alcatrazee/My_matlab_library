function result = get_homo_rotationm(axis,theta)

if(axis=='x')
   result = [1 0 0 0;0 cos(theta) -sin(theta) 0;0 sin(theta) cos(theta) 0;0 0 0 1]; 
elseif(axis=='y')
   result = [cos(theta) 0 sin(theta) 0;0 1 0 0;-sin(theta) 0 cos(theta) 0;0 0 0 1]; 
elseif(axis=='z')
   result = [cos(theta) -sin(theta) 0 0;sin(theta) cos(theta) 0 0;0 0 1 0;0 0 0 1];
else
    error('input correct axis in char format')
end