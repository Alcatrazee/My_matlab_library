function out=myrgb2gray(img)

s=size(img);
if s(3)~=3
   error('nxmx3 matric is needed'); 
end
out=img(:,:,1)*0.299+img(:,:,2)*0.587+img(:,:,3)*0.114;
%R*0.299 + G*0.587 + B*0.114
 
