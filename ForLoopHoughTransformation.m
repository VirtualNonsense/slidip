function [outmatrix,distancesteps,alphasteps] = ForLoopHoughTransformation(inmatrix, pistep, dstep)
%   this function contains one possible implementation of the so called
%   houghtransformation.
%   The benefit of this algorithm is that it's speed is decent and the
%   memoryusage is relativly low.
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
    
    % calculating biggest possible distance
    [y,x] = size(inmatrix);
    dmax = (x^2 + y^2)^0.5;
    dmin = -dmax;
    
    %defining vectors used with the hough-transformation
    % one could consider this the x axis
    distancesteps = [fliplr(-dstep:-dstep:dmin) 0:dstep:dmax];
    % one could consider this the y axis
    alphasteps = 0:pistep:pi;
    
    % preparing the outmatrix forhand saves time in the algorithm
    outmatrix = zeros(size(alphasteps,2),size(distancesteps,2));

    % fetching all matrix values > 0 -> the detected edges
    [row,col] = find(inmatrix > 0);
    pixels = [row,col];
    
    
    for pixel = pixels'
        %for loop through all possibble values of alpha
        for a = alphasteps
            %calculating the hesse normal form value of d
            % dist = cos(a) * x + sin(a) * y;
            dist = cos(a)*pixel(2) + sin(a)*pixel(1);
            
            %getting the nearest value of d in hough-matrix
            [~,index] = min(abs(distancesteps-dist));
            
            %increase value of corresponding values in outmatrix by 1
            outmatrix(a==alphasteps,index) = outmatrix(a==alphasteps, index) +1;
        end
    end
end

