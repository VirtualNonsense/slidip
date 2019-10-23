clear all
clc

pistep = 0.01;
dstep = 10;

%[file, path, index] = uigetfile({'*.jpg', 'JPEG'; '*.png', 'PNG'}, "please choose a picture");
filepath = 'testimages/lines.jpg'; %strcat(path, file);
filepath1 = 'testimages/lines.jpg';
display("reading image");
pic = imread(filepath1);
pic = rgb2bw(pic);
picsize = size(pic);
display("Applying sobelfilter");
pic = sobeloperator(pic);

display("Applying thresholdfilter");
pic = threshold(pic, 0.5);
sobel = pic;

display("houghtransformation");
[pic,d,alpha] = houghtransformation(pic, pistep, dstep);
imagesc(pic)
colorbar

display("Applying thresholdfilter");
pic = threshold(pic,0.6);

display("Retransformation");
pic = hough2lines(pic,pistep,dstep,d,alpha,picsize);

pic = pic.*sobel;
colormap hot
imagesc(pic)
colorbar;
