function [outputdata] = getmaxhoughpoints(inputhough,maxdistance, weight)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    [a,d] = find(inputhough ~= 0);
    final = [];
    current = zeros(size(a,1),2,size(a,1));
    
    for k = 1:size(a,1)
        current(k,:,1) = [a(k), d(k)];
        for l = 1:size(d,1)
            if((weight*(a(k)-a(l))^2 + (d(k)-d(l))^2) <= maxdistance)
                current(k,:,l) = [a(l), d(l)];
            end
        end
    end
    
    %das ist hässlich, noch schöner machen
    for m = 1:size(current,1)
        row = current(m,1,:);
        row = round(mean(nonzeros(row)));
        col = current(m,2,:);
        col = round(mean(nonzeros(col)));
        current(m,:,1) = [row,col];
    end
    final = unique(current(:,:,1),'rows');
    outputdata = final;

end

