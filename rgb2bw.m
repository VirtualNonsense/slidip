function [bw] = rgb2bw(rgb)
%RGB2BW Summary of this function goes here
%   Detailed explanation goes here
%   Input ########################
%   rgb: a rgb based picture structure x * y * 3
%   Output #######################
%   bw: greyscale representation of the image
[x,y,c] = size(rgb);
bw = zeros(x,y);
bw(:,:) = 255 - ((int32(rgb(:,:,1)) + int32(rgb(:,:,2)) + int32(rgb(:,:,3)))/3);

