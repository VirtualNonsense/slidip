clear all;
clc;
close all;

%[file, path, index] = uigetfile({'*.jpg', 'JPEG'; '*.png', 'PNG'}, "please choose a picture");
filepath = 'C:\Users\andre\OneDrive\Software\source\repos\Matlab\Uni\slidip\testimages\extremtest.jpg'; %strcat(path, file);
pic = imread(filepath);
pic = rgb2bw(pic);
pic = sobeloperator(pic);
image(pic,'CDataMapping', 'scaled');
colorbar;