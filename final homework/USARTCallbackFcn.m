function USARTCallbackFcn( obj1,event)     %创建中断响应函数
    count=0;
    buffersize=0;
    data=fscanf(obj1);
    set(handles.display,'String',data);
    x=[count-1 count];
    y=[dat str2double(data)];
    dat=str2double(data);
    line(handles.axes1,x,y);
    drawnow;
    count=count+1;
    flushinput(obj1);
end