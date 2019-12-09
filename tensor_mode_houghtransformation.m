function [outmatrix,d,alpha] = tensor_mode_houghtransformation(inmatrix, pistep, dstep)
%creating empty matrix with dimensions of inmatrix
    [y,x] = size(inmatrix);
    
    %calculating max value for distance from origin (upper left) to lower
    %right
    dmax = (x^2 + y^2)^0.5;
    dmin = -dmax;
    
    % defining vectors used with the hough-transformation
    alpha = 0:pistep:pi;
    d = [fliplr(-dstep:-dstep:dmin) 0:dstep:dmax];
    outmatrix = zeros(size(alpha,2),size(d,2));
    % reshaping d in order to exploit FAST MATRIX OPERATIONS \0/
    d = reshape(d, [1, 1, size(d,2)]);
    
    %getting columns and rows where inmatrix is not 0
    [row,col] = find(inmatrix > 0);
    pixels = [row,col];
    
    % reshaping Pixels in order to exploit FAST MATRIX OPERATIONS \0/
    pixels = pixels';
    
    dist = cos(alpha(:))*pixels(2,:) + sin(alpha(:))*pixels(1,:);
    
    diff = abs(dist-d);
    for index = 1:size(diff,2)
        slice = reshape(diff(:,index,:), [size(diff, 1), size(diff, 3)]);
        [~,I] = min(slice,[],2,'linear');
        outmatrix(I) = outmatrix(I) + 1;
    end
end

