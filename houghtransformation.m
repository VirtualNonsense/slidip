function [outmatrix,d,alpha] = houghtransformation(inmatrix, pistep, dstep)
    %HOUGHTRANSFORMATION Summary of this function goes here
    %   Detailed explanation goes here
%     [x,y] = size(inmatrix);
%     dmax = (x^2 + y^2)^0.5;
%     dmin = -dmax;
%     amountangle = pi / pistep;
%     outmatrix = zeros(round(amountangle), 2*round(dmax/dstep));
%     [row,col] = find(inmatrix > 0);
%     pixels = [row,col];
%     
%     for pixel = pixels'
%         for alpha = pistep:pistep:pi
%             a = round(alpha/pistep);
%             d = cos(alpha)*pixel(1)+sin(alpha)*pixel(2);
%             k = floor((d - dmin)/dstep) + 1;
%             outmatrix(a, k) = outmatrix(a, k) + 1;
%         end
%     end
    
    
    %Hedtt's code
    [x,y] = size(inmatrix);
    dmax = (x^2 + y^2)^0.5;
    dmin = -dmax;
    alpha = 0:pistep:pi;
    d = dmin:dstep:dmax;
    outmatrix = zeros(size(alpha,2),size(d,2));
%=======
    amountangle = pi / pistep;
    outmatrix = zeros(round(amountangle)+1, 2*round(dmax/dstep)+1);
    [row,col] = find(inmatrix > 0);
    pixels = [row,col];
    
    for pixel = pixels'
        for a = alpha
            dist = cos(a)*pixel(1)+sin(a)*pixel(2);
            [~,index] = min(abs(d-dist));
            outmatrix(a==alpha,index) = outmatrix(a==alpha,index) +1;
        end
    end
    
    
end

