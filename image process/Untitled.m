img=imread('C:\Users\Shinelon\Desktop\testpic.jpg');
gray=myrgb2gray(img);
% best=graythresh(gray);
g=mythreshold(gray,180,97);
connection=my_connection(g);
% b=im2bw(gray,0.38);
% imshow(g)