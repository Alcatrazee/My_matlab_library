function out = myhistogram(uint8img)

% Author:Markin
% Date:2018-3-26
% Usage:Get array of histogram of a gray image

sizeofimg = size(uint8img);
height = sizeofimg(2);
width = sizeofimg(1);
value = zeros(1,256);
count = 0:255;
for i=1:1:width
   for j = 1:1:height
        value(uint8img(i,j)+1) = value(uint8img(i,j)+1)+1;
        
   end
end
stem(count,value);
out = value;
