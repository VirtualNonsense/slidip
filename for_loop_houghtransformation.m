function [outmatrix,d,alpha] = for_loop_houghtransformation(inmatrix, pistep, dstep)
    %HOUGHTRANSFORMATION Summary of this function goes hereend
    
    
    %creating empty matrix with dimensions of inmatrix
    [y,x] = size(inmatrix);
    
    %calculating max value for distance from origin (upper left) to lower
    %right
    dmax = (x^2 + y^2)^0.5;
    dmin = -dmax;
    
    %defining vectors used with the hough-transformation
    alpha = 0:pistep:pi;
    d = [fliplr(-dstep:-dstep:dmin) 0:dstep:dmax];
    %generating an outmatrix with dimensions of vectors
    outmatrix = zeros(size(alpha,2),size(d,2));

    %getting columns and rows where inmatrix is not 0
    [row,col] = find(inmatrix > 0);
    pixels = [row,col];
    
    %for loop through all points not 0
    for pixel = pixels'
        %for loop through all possibble values of alpha
        for a = alpha
            %calculating the hesse normal form value of d
            % dist = cos(a) * x + sin(a) * y;
            dist = cos(a)*pixel(2) + sin(a)*pixel(1);
            %getting the nearest value of d in hough-matrix
            [~,index] = min(abs(d-dist));
            %increase value of corresponding values in outmatrix by 1
            outmatrix(a==alpha,index) = outmatrix(a==alpha, index) +1;
        end
    end
    
    
end

