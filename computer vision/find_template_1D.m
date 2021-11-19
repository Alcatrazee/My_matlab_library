% Find template 1D
% NOTE: Function definition must be the very first piece of code here!


% Test code:
s = [-1 0 0 1 1 1 0 -1 -1 0 1 0 0 -1];
t = [1 1 0];
disp('Signal:'), disp([1:size(s, 2); s]);
disp('Template:'), disp([1:size(t, 2); t]);

index = find_template_1D_my(t, s);
disp('Index:'), disp(index);


function index = find_template_1D_my(t, s)
    % TODO: Locate template t in signal s and return index
    % NOTE: Turn off all output from inside the function before submitting!
    for i=1:(size(s,2)-2)
       if(sum(abs(s(i:i+2)-t))==0)
          index = i; 
          return;
       end
    end
    index = -1;
end