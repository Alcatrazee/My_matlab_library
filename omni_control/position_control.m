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

pos_x=0;
pos_y=0;

figure(1)
hold on 
axis([-1500 1500 -1500 1500])
k=1;

waypoint=[0 0;0 -380;-380 -730;-600 -1330];

while k
    % Communicating with instrument object, obj1.
    data1 = fscanf(obj1);
    if length(data1)==15
        pos_x=str2double(data1(2:7));
        pos_y=str2double(data1(8:13));
        pos=[pos_x pos_y]
        plot(pos_x,pos_y,'-o','markersize',2);
        drawnow
        if sqrt((pos_x-waypoint(k,1))^2+(pos_y-waypoint(k,2))^2)<=5&&k<5
          k=k+1;
          fprintf(obj1,make_msg(waypoint(k,1),waypoint(k,2)));
        end
    end
    % Flush the data in the input buffer.
    flushinput(obj1);

    %pause(0.01)
end

% Disconnect from instrument object, obj1.
fclose(obj1);

