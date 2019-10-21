clear all
clc

pistep = 0.01;
dstep = 10;

%[file, path, index] = uigetfile({'*.jpg', 'JPEG'; '*.png', 'PNG'}, "please choose a picture");
%<<<<<<< HEAD
%filepath = 'C:\Users\andre\OneDrive\Software\source\repos\Matlab\Uni\slidip\testimages\extremtest.jpg'; %strcat(path, file);
pic = imread('testimages/lines.jpg');
%=======
filepath = 'C:\Users\andre\OneDrive\Software\source\repos\Matlab\Uni\slidip\testimages\lines.jpg'; %strcat(path, file);
filepath1 = 'testimages/extremtest.jpg';
display("reading image")
pic = imread(filepath1);
%>>>>>>> 8aee41ba327e9000e8fb44dead48679b07b9776e
pic = rgb2bw(pic);
picsize = size(pic);
pic = sobeloperator(pic);
imwrite(pic,'result/sobelpic.jpg');
pic = threshold(pic, 0.5);
imwrite(pic,'result/sobelpic_threshold.jpg');
sobel = pic;
tic
[pic,d,alpha] = houghtransformation(pic, pistep, dstep);
imagesc(pic)
colorbar
saveas(gcf,'result/houghtransformation.jpg');
close
%imwrite(pic,'result/houghtransformation.jpg');
toc
pic = threshold(pic,0.6);
imwrite(pic,'result/houghtransformation_threshold.jpg');
tic
pic = hough2lines(pic,pistep,dstep,d,alpha,picsize);
imwrite(pic,'result/hough2lines.jpg');
toc
pic = pic.*sobel;
imwrite(pic,'result/hough2lines_with_sobel.jpg');
%<<<<<<< HEAD
% colormap gray;
% %=======
% colormap hot
% %>>>>>>> 8aee41ba327e9000e8fb44dead48679b07b9776e
% imagesc(pic)
% %image(pic,'CDataMapping', 'scaled');
% 
% colorbar;