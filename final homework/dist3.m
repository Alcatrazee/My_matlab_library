function d=dist3(point1,point2)
%cultculate the distance between two points
%d is the return value
%point1,point2 are the input value
%point-[x1,y1],point2-[x2,y2]
x1 = point1(1);
x2 = point2(1);
y1 = point1(2);
y2 = point2(2);
d = sqrt((x2-x1)^2+(y2-y1)^2);
