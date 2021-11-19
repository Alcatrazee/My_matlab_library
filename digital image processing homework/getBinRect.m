function [x,y,h,w] = getBinRect(img,number)

% this function is used to get a rectangle of a segment

sizeofimg = size(img);

tempx=[];
tempy=[];

for i = 1:sizeofimg(1)
    for j=1:sizeofimg(2)
        if img(i,j)==number
           tempx = [tempx j];
           tempy = [tempy i];
        end
    end
end

x = min(tempx);
y = min(tempy);
w = max(tempy)-min(tempy);
h = max(tempx)-min(tempx);

