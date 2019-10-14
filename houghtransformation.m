function [outmatrix] = houghtransformation(inmatrix,pistep, dstep)
    %HOUGHTRANSFORMATION Summary of this function goes here
    %   Detailed explanation goes here
    [x,y] = size(inmatrix);
    dmax = (x^2 + y^2)^0.5;
    dmin = -dmax;
    amountangle = pi / pistep;
    outmatrix = zeros(round(amountangle), 2*round(dmax/dstep));
    [row,col] = find(inmatrix > 0);
    pixels = [row,col];
    
    for pixel = pixels'
        for alpha = pistep:pistep:pi
            a = round(alpha/pistep);
            d = cos(alpha)*pixel(1)+sin(alpha)*pixel(2);
            k = floor((d - dmin)/dstep) + 1;
            outmatrix(a, k) = outmatrix(a, k) + 1;
        end
    end
end

