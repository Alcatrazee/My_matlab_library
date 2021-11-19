function out=my_connection(img)

% get the roi from the binary image
% image must be the binary matrix 
% output:matrix containning the coordinate of each roi , started with x
% then y,means odd number represents the x coordinate 

%%  input para check and para. declaration
row=size(img);
if length(row)~=2
    error('image should be a binary image'); 
end
column=row(2);
row=row(1);
k=1;
out=libpointer('int16Ptr',[0 0]);
%% 
for row1=1:row
   for column1=1:column
      inmat=IsinMat(out,k,[row1,column1]);
      if img(row1,column1)~=1&&img(row1,column1)~=0
         error('image should be a binary image'); 
      elseif img(row1,column1)==1 && inmat==0
         temp=broad_search(img,[row1,column1]);
         out(k)=libpointer('int16Ptr',temp);        % use pointer to get the vectors ,if you want to see the value ,use get(out(k),'value')
         k=k+1;
      end
   end
end
end
%%
function out=IsinMat(ptr,k,coordinate)
    for t=1:k-1
        temp1=get(ptr(t),'value');
        len=length(temp1);
        for i=1:len-1
            if coordinate(1)==temp1(i)&&coordinate(2)==temp1(i+1)
               out=1;
               return;
            end
        end
    end
    out=0;
end
