function [sobel] = sobeloperator(blackwhitepic)
%SOBELOPERATOR Summary of this function goes here
%   

%creating an empty matrix with dimensions as blackwhitematrix
[x,y] = size(blackwhitepic);
sobel = zeros(x,y);

%defining the sobeloperators
sy = [1,2,1;
      0,0,0;
      -1,-2,-1;];
sx = sy';

%applying the sobeloperators to the image
gy = conv2(blackwhitepic, sy, 'same');
gx = conv2(blackwhitepic, sx, 'same');

%calculating the result
sobel(:,:) = (gy(:,:).^2 + gx(:,:).^2).^0.5;
%setting the borders to 0, otherwise wrong result
sobel(1,:) = 0;
sobel(x,:) = 0;
sobel(:,1) = 0;
sobel(:,y) = 0;

end

