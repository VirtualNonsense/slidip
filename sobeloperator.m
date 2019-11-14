function [sobel] = sobeloperator(bw)
%SOBELOPERATOR Summary of this function goes here
%   
[x,y] = size(bw);
sobel = zeros(x,y);
sy = [1,2,1;
      0,0,0;
      -1,-2,-1;];
sx = sy';

gy = conv2(bw, sy, 'same');
gx = conv2(bw, sx, 'same');

sobel(:,:) = (gy(:,:).^2 + gx(:,:).^2).^0.5;
sobel(1,:) = 0;
sobel(x,:) = 0;
sobel(:,1) = 0;
sobel(:,y) = 0;

end

