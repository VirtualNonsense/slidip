function [sobel] = SobelOperator(blackwhitepic)
%   This function provides a fast way to apply the sobeloperator to a black
%   and white picture
%   Input ########################
%   rgb: a rgb based picture structure x * y * 3
%   weight: vector with structur 1 x 3. It contains the weights of the
%   diffrent colorchannels. The sum of the entrys should be <= 1
%   Output #######################

    % creating an empty matrix with dimensions and blackwhitematrix
    [x,y] = size(blackwhitepic);
    sobel = zeros(x,y);

    % defining used operatormatrices
    sy = [1,2,1;
          0,0,0;
          -1,-2,-1;];
    sx = sy';

    % applying sobeloperators to the image
    gy = conv2(blackwhitepic, sy, 'same');
    gx = conv2(blackwhitepic, sx, 'same');

    % calculating the result
    sobel(:,:) = (gy(:,:).^2 + gx(:,:).^2).^0.5;
    
    % setting borders to 0, in order to avoid detecting them
    sobel(1,:) = 0;
    sobel(x,:) = 0;
    sobel(:,1) = 0;
    sobel(:,y) = 0;

end

