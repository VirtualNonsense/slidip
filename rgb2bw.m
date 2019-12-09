function [bw] = rgb2bw(rgb, weight)
%RGB2BW Summary of this function goes here
%   Detailed explanation goes here
%   Input ########################
%   rgb: a rgb based picture structure x * y * 3
%   Output #######################
%   bw: greyscale representation of the image, structure x * y
[x,y,~] = size(rgb);
bw = int32(zeros(x,y));
bw(:,:) = weight(1) * int32(rgb(:,:,1)) + weight(2) * int32(rgb(:,:,2)) + weight(3) * int32(rgb(:,:,3));

