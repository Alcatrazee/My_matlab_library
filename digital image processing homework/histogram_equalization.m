%   Author:Ma Jian
%   Date:  2018-3-26
%   No.01
%   histogram equalization
%% clear console and close all windows
clc;                                                           % clear console
clear;                                                         % delete all varables
close all;                                                     % close all running applications
%%  read image and convert color
img = imread('lena_lowcontrast.jpg');                          % read image as rgb image
gray = myrgb2gray(img);                                        % convert image to gray image
equalized_img = histeq(gray);                                  % equalized image
%% show histogram of gray image
subplot(2,2,1);                                                % create a figure with subfigures
myhistogram(gray);                                             % show histogram
title('histogram of original image');                          % make a title
%% show gray image
subplot(2,2,2)                                                 % call subfigure 2 
imshow(gray);                                                  % show gray image 
title('origin image');                                         % make a title
%% show histogram of equalized image
subplot(2,2,3)                                                 % call subfigure 3 
myhistogram(equalized_img);                                    % show histogram 
title('histogram of equlized image');                          % make a title
%% show equlized image
subplot(2,2,4)                                                 % call subfigure 4 
imshow(equalized_img);                                         % show equlized image 
title('equlized image');                                       % make a title
