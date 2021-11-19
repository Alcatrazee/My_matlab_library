clc;
clear;
% close all;
core_row = 5;
sigma = 15;

srcImg = imread('homeworkpic.jpg');
sizeofimg = size(srcImg);
graypic = rgb2gray(srcImg);
graypic = histeq(graypic);
edgepic = edge(graypic);

gausFilter = fspecial('gaussian',[core_row core_row],sigma);               %matlab 自带高斯模板滤波  
blur=imfilter(graypic,gausFilter,'conv');                                  

subplot(2,2,1);
imshow(blur);

level = graythresh(graypic);
bin_img = im2bw(blur,0.38);

subplot(2,2,2);
imshow(bin_img);

core = [0 0 1 0 0;0 1 1 1 0;1 1 1 1 1;0 1 1 1 0;0 0 1 0 0];
delitated = imdilate(bin_img,core);
delitated = imdilate(delitated,core);
eroded = imerode(delitated,core);
eroded = imerode(eroded,core);
eroded = imerode(eroded,core);
eroded = imerode(eroded,core);
% for i=1:1
%     delitated = imdilate(delitated,core);
% end
% filled = imfill(filled,'holes');
% figure
subplot(2,2,4)
imshow(eroded);

left_region = zeros(sizeofimg);
right_region = zeros(sizeofimg);

temppic = ones(sizeofimg(1:2));
% invert = temppic - filled;
% figure
% imshow(invert);
