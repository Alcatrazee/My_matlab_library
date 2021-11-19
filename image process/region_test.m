clear
clc
img=imread('C:\Users\Shinelon\Desktop\ppp.jpg');
img_process=img;
gray=myrgb2gray(img);
bin=mythreshold(gray,80,255);
connection=my_connection(bin);
new_img_coor=get(connection(1),'value');
len=length(new_img_coor);
new_img=zeros(240,320);
for t=1:2:len
   img_process(new_img_coor(t),new_img_coor(t+1),1)=255; 
   img_process(new_img_coor(t),new_img_coor(t+1),2)=0; 
   img_process(new_img_coor(t),new_img_coor(t+1),3)=0; 
end
imshow(img_process);