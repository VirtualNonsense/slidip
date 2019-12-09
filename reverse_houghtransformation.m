function [outmatrix] = reverse_houghtransformation(houghmatrix,picsize,pistep, dstep)
    % TODO: write proper header

    % get relevant positions of relevant values
    [row,col] = find(houghmatrix~=0);
    linevector = [row,col];

    % calculate position of zeroline
    d_null = size(houghmatrix,2)/2;

    % creating x values that are outside the mainpicture
    tmax = (picsize(1)+picsize(2));
    tmin = -tmax;

    % initializing empty matrix
    outmatrix = zeros(size(linevector,1),2,2);

    %retriving alpha and distance
    alpha = linevector(:,1)*pistep;
    d = (linevector(:,2) - d_null)*dstep;
    % converting d and alpha into point which will be used to draw the line
    % into the finished picture
    minpoint = [cos(alpha).*d + tmin*sin(-alpha), sin(alpha).*d+tmin*cos(alpha),];
    outmatrix(:,:,1) = minpoint;
    maxpoint = [cos(alpha).*d + tmax*sin(-alpha), sin(alpha).*d+tmax*cos(alpha)];
    outmatrix(:,:,2) = maxpoint;
end
