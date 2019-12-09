function [bw] = ColoredImageToGrayScale(rgb, weight)
%   This function converts colorimages into black and white pictures
%   Input ########################
%   rgb: a rgb based picture structure x * y * 3
%   weight: vector with structur 1 x 3. It contains the weights of the
%   diffrent colorchannels. The sum of the entrys should be <= 1
%   Output #######################
%   bw: greyscale representation of the image, structure x * y
[x,y,~] = size(rgb);
bw = int32(zeros(x,y));
bw(:,:) = weight(1) * int32(rgb(:,:,1)) + weight(2) * int32(rgb(:,:,2)) + weight(3) * int32(rgb(:,:,3));

