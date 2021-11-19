% Find a serial port object.
obj1 = instrfind('Type', 'serial', 'Port', 'COM4', 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = serial('COM4');
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Configure instrument object, obj1.
set(obj1, 'BaudRate', 230400);
set(obj1, 'inputbuffersize', 15)

% Connect to instrument object, obj1.
fopen(obj1);

vx=0;
vy=0;

k=1;


x=1:1000;
y=zeros([1 1000]);

while k<1000
    % Communicating with instrument object, obj1.
    if x(k)<=100
        y(k)=5*x(k);
    elseif x(k)>100&&x(k)<900
        y(k)=500;
    elseif x(k)>=900
        y(k)=-5*(x(k)-1000);
    end
    msg=make_msg_v(0,y(k))
    fprintf(obj1,msg);
    k=k+1;
    pause(0.01);
end

% Disconnect from instrument object, obj1.
fclose(obj1);

