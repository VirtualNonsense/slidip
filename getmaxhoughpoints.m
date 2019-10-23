function [outputdata] = getmaxhoughpoints(inputhough,maxdistance, weight)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    [a,d] = find(inputhough ~= 0);
    final = [];
    
    for k = 1:size(a,1)
        current = [a(k), d(k)];
        for l = k+1:size(d,1)
            if((weight*(a(k)-a(l))^2 + (d(k)-d(l))^2) < maxdistance)
                current = [current;
                    a(l), d(l)];
                a(l) = 0;
                d(l) = 0;
            end
        end
        if size(current,1) ~= 1
            current = (sum(current))/size(current,1);
        end
        final = [final;
            current];
    end
    [zerorow, zerocol] = find(final == 0);
    final(zerorow,:) = [];
    outputdata = final;

end

