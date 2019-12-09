function [outmatrix,d,alpha] = tensor_mode_houghtransformation(inmatrix, pistep, dstep)
%   this function contains one possible implementation of the so called
%   houghtransformation.
%   This implementation does best when processing "small" images or rough
%   settings
%   when calculating large images with fine settings
%   it usually takes longer than it's competitors because matlab has
%   problems initialising extreme large tensors
%   (also the resulting tensor could be to large for the RAM)
%   Input ########################
%   inmatrix: This matrix contains the detected edges of a given image
%   pistep [rad]: steps for y axis
%   dstep [pixel]: steps for x axis
%   Output #######################
%   outmatrix: this matrix contains the transformed image
%   alphasteps: vector containing the discrete angles used in the
%   transformation
%   distancesteps: vector containing the discrete lengths used in the
%   houghtransformation
   
    %calculating max value for distance from origin (upper left) to lower
    %right
    [y,x] = size(inmatrix);
    dmax = (x^2 + y^2)^0.5;
    dmin = -dmax;
    
    % defining vectors used with the hough-transformation
    alpha = 0:pistep:pi;
    d = [fliplr(-dstep:-dstep:dmin) 0:dstep:dmax];
    
    % generating matrix
    outmatrix = zeros(size(alpha,2),size(d,2));
    
    % reshaping d in order to exploit faster matrix operations
    d = reshape(d, [1, 1, size(d,2)]);
    
    %getting columns and rows where inmatrix is not 0
    [row,col] = find(inmatrix > 0);
    pixels = [row,col];
    
    % reshaping d in order to exploit faster matrix operations
    pixels = pixels';
    
    % calculate all possible lines for all found pixels and safe it into
    % sturcture: angles * pixel
    dist = cos(alpha(:))*pixels(2,:) + sin(alpha(:))*pixels(1,:);
    
    % calculating every distance in order to find the best aproximation 
    % structure: angle * pixel * distanceaprox
    diff = abs(dist-d);
    
    % looping over pixelcolumn    
    for index = 1:size(diff,2)
        % generating a slice with structure: angle * distance
        slice = reshape(diff(:,index,:), [size(diff, 1), size(diff, 3)]);
        % finding minimum for specific pixelslice
        % I contains the found inices -> best approx for each angle
        [~,I] = min(slice,[],2,'linear');
        % adding 1 to each pos
        outmatrix(I) = outmatrix(I) + 1;
    end
end

