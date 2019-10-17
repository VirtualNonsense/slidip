clear all
clc

%[file, path, index] = uigetfile({'*.jpg', 'JPEG'; '*.png', 'PNG'}, "please choose a picture");
%filepath = 'C:\Users\andre\OneDrive\Software\source\repos\Matlab\Uni\slidip\testimages\extremtest.jpg'; %strcat(path, file);
pic = imread('testimages/lines.jpg');
pic = rgb2bw(pic);
pic = sobeloperator(pic);
pic = threshold(pic, 0);
pic = houghtransformation(pic, 0.01, 10);
colormap gray;
imagesc(pic)
%image(pic,'CDataMapping', 'scaled');

colorbar;