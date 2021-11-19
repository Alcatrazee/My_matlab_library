% Find template 2D
% NOTE: Function definition must be the very first piece of code here!

% Test code:
rgb_tablet = imread('test_img.jpg');
tablet = rgb2gray(rgb_tablet);
imshow(tablet);
glyph = tablet(75:165, 150:185);
imshow(glyph);

corr = find_template_2D_my(glyph, tablet);
imshow(corr)
%disp([y x]); % should be the top-left corner of template in tablet

function corr_img =  find_template_2D_my(template, img)%[yIndex,xIndex] = find_template_2D_my(template, img)
% TODO: Find template in img and return [y x] location
% NOTE: Turn off all output from inside the function before submitting!
corr_img = normxcorr2(template,img);
% for rows = 1:size(img,1)-size(template,1)+1
%     for cols = 1:size(img,2)-size(template,2)+1
%         if(sum(abs(template-img(rows:rows+size(template,1)-1,cols:cols+size(template,2)-1)))==0)
%             yIndex = rows;
%             xIndex = cols;
%             return;
%         end
%     end
% end
% yIndex = -1;
% xIndex = -1;
end