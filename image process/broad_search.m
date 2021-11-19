function out=broad_search(img,start_point)

% get the points that connect to the start_point ,spread with BFS
% output : vector which contain the x and y coordinate of the connected
% points,odd number is the x coordinate,like 1,3,5


%%  parameter configuration
if length(start_point)~=2
    error('start_point should be a vector');
end
openset=start_point;
closeset=[];
out=[];

%%  start search
%    dir up down left right
while isempty(openset)==0
    exist=check_four_dir(img,[openset(1) openset(2)],openset,closeset);
    if exist(1)==1 && img(openset(1)-1,openset(2))==1
        openset=[openset,openset(1)-1,openset(2)];
    end
    if exist(2)==1 && img(openset(1)+1,openset(2))==1
        openset=[openset,openset(1)+1,openset(2)];
    end
    if exist(3)==1 && img(openset(1),openset(2)-1)==1
        openset=[openset,openset(1),openset(2)-1];
    end
    if exist(4)==1 && img(openset(1),openset(2)+1)==1
        openset=[openset,openset(1),openset(2)+1];
    end
    if img(openset(1),openset(2))==1
        out=[out,openset(1),openset(2)];
    end
    
    closeset=[closeset,openset(1),openset(2)];
    openset(1)=[];
    openset(1)=[];
end
end



%%  see if there exist the upper down left and right
function out=check_four_dir(img,checkpoint,openset,closeset)

sizeofimg=size(img);
inCorO=[IsinOorC(openset,closeset,[checkpoint(1)-1,checkpoint(2)]),IsinOorC(openset,closeset,[checkpoint(1)+1,checkpoint(2)]),IsinOorC(openset,closeset,[checkpoint(1),checkpoint(2)-1]),IsinOorC(openset,closeset,[checkpoint(1),checkpoint(2)+1])];

if checkpoint(1)~=sizeofimg(1) && inCorO(2)==0
    down=1;
else 
    down=0;
end

if checkpoint(1)~=1 && inCorO(1)==0
    up=1;
else 
    up=0;
end

if checkpoint(2)~=1 && inCorO(3)==0
    left=1;
else 
    left=0;
end

if checkpoint(2)~=sizeofimg(2) && inCorO(4)==0
    right=1;
else 
    right=0;
end

out=[up,down,left,right];

end

%%  see if the coodinate is in the openset or the closeset or not
function out=IsinOorC(openset,closeset,point)

olen=length(openset);
clen=length(closeset);

for o=1:olen-1
    if point(1)==openset(o)&&point(2)==openset(o+1)
        out=1;
        return ;
    end
end

for c=1:clen-1
    if point(1)==closeset(c)&&point(2)==closeset(c+1)
        out=1;
        return ;
    end
end

out=0;
end