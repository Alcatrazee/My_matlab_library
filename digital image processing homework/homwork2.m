%   Author:Ma Jian
%   Date:  2018-3-27
%   No.01
%   description:get invarant moment of each cell of a image
clear
clc
%% load image and open file
file = fopen('homeworktxt.txt','w');                                       %open or create a txt file
srcImg = imread('pic.jpg');                                                %read a image as srcImg
%% process the image
graypic = rgb2gray(srcImg);                                                %color convertion
sizeofimg = size(graypic);                                                 %get size of image 

core_row = 5;                                                              %making a core
sigma = 10;
gausFilter = fspecial('gaussian',[core_row core_row],sigma);               %get some param. ready to reduce noice
blur=imfilter(graypic,gausFilter,'conv');                                  %filtering the image with gaussion filter

equalized = histeq(blur);                                                  %histogram equalization

level = graythresh(equalized);                                             %get the optimal level to segement the gray picture
bw = im2bw(equalized,0.3);                                                 %gray picture segement without level above,because 0.3 makes a better effect

core = [0 1 0;1 1 1;0 1 0];                                                %morph core 
eroded = imerode(bw,core);
dilated = imdilate(eroded,core);
croped = imcrop(dilated,[5 5 628 470]);                                    %crop the picture in order to get rid of the wrong edge pixels
inverted = ~croped;                                                        %invert the binary picture to get the segement

imshow(inverted);                                                          %show the inverted picture

all_bw = bwlabel(inverted);                                                %give every segement a number
numofcells = max(max(all_bw));                                             %count how many cells there are(though some are linked)
%%  get position of each cell
for i=1:numofcells
    [x(i) y(i) w(i) h(i)] = getBinRect(all_bw,i);                          %get the param. imcrop needed to get every cell out of the gray picture
end

all_segements = [x' y' w' h'];
%% display all single cell
graycrop = imcrop(graypic,[5 5 628 470]);                                  %make a basic picture to crop later
figure
for i=1:numofcells
    imshow(imcrop(graycrop,all_segements(i,:)));                           %crop every cell out of the gray picture
end
%%  moment calculations
str = 'segement number:';
for noc=1:numofcells
    fprintf(file,'segement number:');
    fprintf(file,'%d\r\n',noc);
    croppedimg = imcrop(inverted,all_segements(noc,:));
    %将图像矩阵的数据类型转换成双精度型
    image=double(croppedimg);
    %%%=================计算 、 、 =========================
    %计算灰度图像的零阶几何矩
    m00=sum(sum(image));
    m10=0;
    m01=0;
    [row,col]=size(image);
    for i=1:row
        for j=1:col
            m10=m10+i*image(i,j);
            m01=m01+j*image(i,j);
        end
    end
    %%%=================计算 、 ================================
    u10=m10/m00;
    u01=m01/m00;
    %%%=================计算图像的二阶几何矩、三阶几何矩============
    m20 = 0;m02 = 0;m11 = 0;m30 = 0;m12 = 0;m21 = 0;m03 = 0;
    for i=1:row
        for j=1:col
            m20=m20+i^2*image(i,j);
            m02=m02+j^2*image(i,j);
            m11=m11+i*j*image(i,j);
            m30=m30+i^3*image(i,j);
            m03=m03+j^3*image(i,j);
            m12=m12+i*j^2*image(i,j);
            m21=m21+i^2*j*image(i,j);
        end
    end
    %%%=================计算图像的二阶中心矩、三阶中心矩============
    y00=m00;
    y10=0;
    y01=0;
    y11=m11-u01*m10;
    y20=m20-u10*m10;
    y02=m02-u01*m01;
    y30=m30-3*u10*m20+2*u10^2*m10;
    y12=m12-2*u01*m11-u10*m02+2*u01^2*m10;
    y21=m21-2*u10*m11-u01*m20+2*u10^2*m01;
    y03=m03-3*u01*m02+2*u01^2*m01;
    %%%=================计算图像的归格化中心矩====================
    n20=y20/m00^2;
    n02=y02/m00^2;
    n11=y11/m00^2;
    n30=y30/m00^2.5;
    n03=y03/m00^2.5;
    n12=y12/m00^2.5;
    n21=y21/m00^2.5;
    %%%=================计算图像的七个不变矩======================
    h1 = n20 + n02;
    h2 = (n20-n02)^2 + 4*(n11)^2;
    h3 = (n30-3*n12)^2 + (3*n21-n03)^2;
    h4 = (n30+n12)^2 + (n21+n03)^2;
    h5 = (n30-3*n12)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n21-n03)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
    h6 = (n20-n02)*((n30+n12)^2-(n21+n03)^2)+4*n11*(n30+n12)*(n21+n03);
    h7 = (3*n21-n03)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n12-n30)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
    
    inv_m7(noc,:)= [h1 h2 h3 h4 h5 h6 h7];
    for z=1:7
        fprintf(file,'M%d=%d\r\n',z,inv_m7(noc,z));
    end
    fprintf(file,'\r\n');
end
fclose(file);