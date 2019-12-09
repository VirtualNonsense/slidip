function [outmatrix] = ReverseHoughtransformation(houghmatrix,picsize,pistep, dstep)
%   This function converts all points into lines
%   The lines are described by two points, placed outside the picture
%   Input ########################
%   houghmatrix: filtered houghmatrix, containing every relevant line
%   picsize: vector containing the size of the former picture
%   pistep [rad]: steps for y axis
%   dstep [pixel]: steps for x axis
%   Output #######################
%   outmatrix: shape: x-entries : y : entries : minpoint/maxpoint
%   this matrix: contrains the found lines

    % get positions of relevant values
    [row,col] = find(houghmatrix~=0);
    linevector = [row,col];

    % calculate position of zeroline
    d_null = size(houghmatrix,2)/2;

    % creating x values which are outside the mainpicture
    tmax = (picsize(1)+picsize(2));
    tmin = -tmax;

    % initializing empty matrix
    outmatrix = zeros(size(linevector,1),2,2);

    %retrive angles and distances
    alpha = linevector(:,1)*pistep;
    d = (linevector(:,2) - d_null)*dstep;
    
    % converting d and alpha into points which will be used to draw the line
    % into the finished picture
    minpoint = [cos(alpha).*d + tmin*sin(-alpha), sin(alpha).*d+tmin*cos(alpha),];
    maxpoint = [cos(alpha).*d + tmax*sin(-alpha), sin(alpha).*d+tmax*cos(alpha)];
    
    % filling points into tensor
    outmatrix(:,:,1) = minpoint;
    outmatrix(:,:,2) = maxpoint;
end

